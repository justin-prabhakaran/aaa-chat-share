import bodyParser, { json } from 'body-parser';
import express from 'express';
import http from 'http';
import morgan from 'morgan';
import cors from 'cors'
import { Server } from 'socket.io';
import { saveFile, saveUser, File, User, FileDoc } from './mongo';
import multer from 'multer';
import path from 'path';

import dotenv from 'dotenv';

dotenv.config()

const app = express()
const server = http.createServer(app);
const io = new Server(server);


const port = process.env.PORT ?? 3000;


app.use(bodyParser.json());
app.use(cors())
app.use(morgan('combined'));

const storage = multer.diskStorage({
    destination: function (req, file, callback) {
        callback(null, 'uploads/');
    },
    filename: async function (req, file, callback) {
        if (file && req.body.user_id && req.body.file_size) {
            const newFile = await saveFile(file.originalname, req.body.file_size, req.body.user_id); // how to return file_id to /upload
            console.log(newFile)
            callback(null, newFile.file_id + path.extname(file.originalname));
        } else {
            callback(new Error("params not found"), '');
        }


    }
});

const upload = multer({
    storage: storage
});

app.use('/uploads', express.static('uploads'));

app.post('/user', async (req, res) => {
    console.log(req.body);
    const { user_name } = req.body;

    if (user_name) {
        try {
            const rs = await saveUser(user_name);
            return res.status(201).json(rs);
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    } else {
        return res.status(400).json({ error: 'Missing user_name' });
    }
});


app.get('/user', async (req, res) => {
    const userId = req.query.user_id;
    if (userId) {
        try {
            const result = await User.findById(userId);
            if (result) {
                console.log(result);
                return res.status(200).json(result);
            } else {
                return res.status(404).json({ error: 'User not found' });
            }
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    } else {
        return res.status(400).json({ error: 'Missing user_id' });
    }
});



//upload.single will handle the upload file 
//dont implement file upload again idiot
app.post('/upload', upload.single('file'), async (req, res) => {
    if (req.file) {
        const query = {
            file_name: req.file.originalname
        }
        const newFile = await File.findOne(query);
        console.log(newFile);
        if (newFile) {
            io.emit('updatefiles');
            return res.status(200).json();
        }
    }
    return res.status(404).json("file Not Found !");
});

//gives all file 
app.get('/upload', async (req, res) => {


    // const result = await File.find();

    // let newres: Array<any> = [{}];

    // result.forEach(async (value, i) => {
    //     console.log(value, i);
    //     newres[i].file_id = value.file_id,
    //         newres[i].file_name = value.file_name,
    //         newres[i].file_size = value.file_size
    //     const res = await User.findById(value.user_id);
    //     newres[i].user_name = res?.user_name ?? 'null';
    //     newres[i].file_link = `http://localhost:${process.env.PORT}/uploads/${value.file_id}${path.extname(value.file_name.toString())}`

    //     console.log(newres[i])
    // });

    // return res.status(200).json(newres);

    try {
        const result = await File.find();
        const newres = await Promise.all(result.map(async (value) => {
            console.log(value);
            const user = await User.findById(value.user_id);
            console.log(user);
            return {
                file_id: value.file_id,
                file_name: value.file_name,
                file_size: value.file_size,
                user_name: user?.user_name ?? 'null',
                file_link: `http://localhost:${process.env.PORT}/uploads/${value.file_id}${path.extname(value.file_name.toString())}`
            };
        }));

        return res.status(200).json(newres);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal Server Error' });
    }

});



io.on('connection', (socket) => {

    socket.on('message', (data) => {
        try {
            let pdata = JSON.parse(data);
            console.log(pdata);
            socket.broadcast.emit('message', pdata);
        } catch (e) {
            console.log(e);
        }
    });

});


server.listen(port, () => {
    console.log('Server running on...');
});