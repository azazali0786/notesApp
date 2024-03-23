//Steps: to build model of mongoos
//1. define sheme -> Note: id userid , title , content , dateadded
//2. Create Model -> <model> <schema> Note

const mongoose = require('mongoose');
const  noteSchema = mongoose.Schema({
    id: {
        type: String,
        unique: true,
        require: true
    },
    userId: {
        type: String,
        require: true
    },
    title: {
        type: String,
        require: true
    },
    content: {
        type: String,
    },
    dateadded: {
        type: Date,
        default: Date.now
    },
    
});

module.exports = mongoose.model("Note", noteSchema);
