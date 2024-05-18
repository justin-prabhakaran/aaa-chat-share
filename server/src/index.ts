import bodyParser from 'body-parser';
import express from 'express';
import http from 'http';
import morgan from 'morgan';
import cors from 'cors'
import { Server } from 'socket.io';
import { saveFile, saveUser, File } from './mongo';
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
        console.log(file)
        console.log(req.body)
        const newFile = await saveFile(file.originalname, req.body.file_size, req.body.user_id); // how to return file_id to /upload
        console.log(newFile)
        callback(null, newFile.file_id + path.extname(file.originalname));
    }
});

const upload = multer({
    storage: storage
});

app.use('/uploads', express.static('uploads'));

app.post('/user', async (req, res) => {
    console.log(req.body);
    if (req.body.user_name) {
        const rs = await saveUser(req.body.user_name);
        return res.status(201).json(rs);
    }
});

app.post('/upload', upload.single('file'), async (req, res) => {
    if (req.file) {
        const query = {
            file_name: req.file.originalname
        }
        const newFile = await File.findOne(query);
        console.log(newFile);
        return res.status(200).json(newFile);
    }
    return res.status(404).json("file Not Found !");
});
io.on('connection', (socket) => {
    socket.on('message', (
        message,
    ) => {
        console.log(message);
    });
});


server.listen(port, () => {
    console.log('Server running on...');
});