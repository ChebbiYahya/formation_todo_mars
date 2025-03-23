const router = require("express").Router();
const TodoController = require("../controllers/todo.controller");

router.post('/storeTodo',TodoController.createTodo);
router.get('/getUserTodoList/:userId',TodoController.getUserTodo);
router.delete('/deleteTodo/:id',TodoController.deleteTodo);

module.exports = router;