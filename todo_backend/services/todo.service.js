const ToDoModel = require("../models/todo.model");

class ToDoServices{
    static async createToDo(userId,title,desc){
        const createTodo= new ToDoModel({userId,title,desc});
        return await createTodo.save();
    }
    static async getTododata(userId){
        const todoData= await ToDoModel.find({userId});
        return todoData;
    }

    static async deleteTodo(id){
        const deleted = await ToDoModel.findOneAndDelete({_id:id});
        return deleted;
    }
}
module.exports=ToDoServices;