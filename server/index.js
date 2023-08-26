console.log("hello Rhea")
//IMPORT PACKAGE
const express = require("express")
const mongoose =  require("mongoose");
const adminRouter = require("./routes/admin");
//same as in dart import command

//IMPORT OTHER FILES
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
// const userRouter = require("./routes/user");

//INIT
const PORT = process.env.PORT || 3000;
const app = express(); //same as initiallising main.dart
const DB = "mongodb+srv://rhea:Mongo123@cluster0.6lfdkly.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
//connecting mongoose
mongoose
    .connect(DB)
    .then (function(){
        console.log("Connection Succesful");
    })
    .catch(function (e){
        console.log(e);
    })

//creating an api
app.listen(PORT, "0.0.0.0",  function () {
    console.log(`connected to port ${PORT}`);
});