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


export const User = mongoose.model<UserDoc>('User', UserSchema);
export const File = mongoose.model<FileDoc>('File', FileSchema);

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
    })

    await newFile.save();

    return newFile;


}
