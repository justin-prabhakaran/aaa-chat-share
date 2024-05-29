import mongoose, { Schema, Document } from "mongoose"
import dotenv from 'dotenv';
dotenv.config()

const db_url = process.env.MONGO_DB_URL ?? '';

mongoose.connect(db_url).then(() => {
    console.log('DB connected on..' + process.env.MONGO_DB_URL);
}).catch((err) => {
    console.log(err);

});



interface UserDoc extends Document {
    user_id: Schema.Types.ObjectId,
    user_name: String,
}

export interface FileDoc extends Document {
    file_id: Schema.Types.ObjectId,
    file_name: String,
    file_size: Number,
    user_id: Schema.Types.ObjectId,
}

interface ChatDoc extends Document {
    chat_id: Schema.Types.ObjectId,
    user_name: String,
    message: String,
    time: Number,
}

const UserSchema = new Schema<UserDoc>(
    {
        user_id: {
            type: Schema.Types.ObjectId,
            default: function (this: UserDoc) {
                return this._id;
            }
        },

        user_name: {
            type: String,
            required: true
        }
    }
);


const FileSchema = new Schema<FileDoc>(
    {
        file_id: {
            type: Schema.Types.ObjectId,
            default: function (this: FileDoc) {
                return this._id;
            }
        },
        file_name: {
            type: String,
            required: true,
        },
        file_size: {
            type: Number,
            required: true
        },
        user_id: {
            type: Schema.Types.ObjectId,
            ref: 'User',
            required: true,

        }
    }
);


const ChatSchema = new Schema<ChatDoc>(
    {
        chat_id: {
            type: Schema.Types.ObjectId,
            default: function (this: Document) {
                return this.id;
            }
        },

        user_name: {
            required: true,
            type: String,

        },

        message: {
            type: String,
            required: true,
        },

        time: {
            type: Number,
            required: true,
        }
    }
);

export const User = mongoose.model<UserDoc>('User', UserSchema);
export const File = mongoose.model<FileDoc>('File', FileSchema);
export const Chat = mongoose.model<ChatDoc>('Chat', ChatSchema);

export async function saveUser(user_name: String) {

    const newUser: UserDoc = new User({
        user_name
    });

    await newUser.save();

    return newUser;

}

export async function saveFile(file_name: String, file_size: Number, user_id: String,) {


    const newFile: FileDoc = new File({
        file_name,
        file_size,
        user_id
    });

    await newFile.save();

    return newFile;

}


export async function saveChat(user_name: String, message: String, time: Number) {
    const newChat = new Chat(
        {
            user_name,
            message,
            time
        }
    );

    await newChat.save();

    return newChat;
}