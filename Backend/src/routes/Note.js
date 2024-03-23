const express = require('express');
const router = express.Router();

const Note = require('./../models/Note');

router.post("/list", async function (req, res) {
    // console.log(req.body.userId);
    var notes = await Note.find({ userId: req.body.userId });
    res.json(notes);
});

router.post("/add", async function (req, res) {

    await Note.deleteOne({ id: req.body.id });

    const newNote = new Note({
        id: req.body.id,
        userId: req.body.userId,
        title: req.body.title,
        content: req.body.content
    });
    await newNote.save();

    const response = { message: "New Note Created!" + `id: ${req.body.id}` };
    // console.log(response);
    res.json(response);
});

router.post("/delete", async function (req, res) {
    await Note.deleteOne({ id: req.body.id });
    const response = { message: "Note deleted!" + `id: ${req.body.id}` };
    res.json(response);
});

module.exports = router;
