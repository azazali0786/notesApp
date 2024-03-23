//Initialization 
const express = require('express');
const app = express();
require("dotenv").config();

const mongoose = require("mongoose");
const Note = require('./models/Note');
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false })); //extended is for nested data
app.use(bodyParser.json());

const mongoDbpath = process.env.MONGO;
mongoose.connect(mongoDbpath).then(function () {
    //App Routes
    console.log('Connected to Mongo');
    app.get("/", function (req, res) {
        const response = { message: "API Works!" };
        res.json(response);
    });
    const noteRouter = require('./routes/Note');
    app.use("/notes", noteRouter);
});

//Started the sercer on a PORT
const PORT = process.env.PORT || 5000;
app.listen(PORT, function () {
    console.log("Server started at PORT: " + PORT);
});