var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const http = require('http');

const {connectToMongoDB}=require('./db/db');

const body_parser=require('body-parser')


//import routers
const userRouter = require("./routers/user.router");
const todoRouter = require("./routers/todo.router");
//import models
const UserModel = require('./models/user.model');
const TodoModel = require('./models/todo.model');


var app = express();

require("dotenv").config();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(body_parser.json());

//router
app.use('/auth',userRouter);
app.use('/todo',todoRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // retourner l'erreur en JSON
  res.status(err.status || 500).json({
    status: false,
    message: err.message,
    error: req.app.get('env') === 'development' ? err : {}
  });
});

const server =http.createServer(app);
server.listen(process.env.PORT,()=>{
  connectToMongoDB();
  console.log("app is running on port",process.env.PORT);
});

module.exports = app;
