const mongoose = require('mongoose');
const { Schema } = mongoose;
const UserModel = require('../models/user.model');

const todoSchema = new Schema({
    userId:{
        type: Schema.Types.ObjectId,
        ref:UserModel.modelName
    },
    title : {
        type:String,
        required:true,
    },
    desc:{
        type:String,
        required:true
    }
});

const ToDoModel = mongoose.model("todo",todoSchema);
module.exports = ToDoModel;