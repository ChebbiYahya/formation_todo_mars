const TodoService=require("../services/todo.service");

exports.createTodo= async (req,res,next)=>{
    try {
        const {userId,title,desc}=req.body;
        let todo =await TodoService.createToDo(userId,title,desc);
        res.json({status:true,success:todo});
    } catch (error) {
        next(error); 
    }
}

exports.getUserTodo = async(req,res,next)=>{
    try {
        const {userId}=req.params;
        let todo = await TodoService.getTododata(userId);
        res.json({status:true,success:todo});
    } catch (error) {
        next(error);
    }

  
}
exports.deleteTodo = async (req,res,next)=>{
    try {
        const {id}=req.params;
        let deleted = await TodoService.deleteTodo(id);
        res.json({status:true,success:deleted});
    } catch (error) {
        next(error);
    }
}