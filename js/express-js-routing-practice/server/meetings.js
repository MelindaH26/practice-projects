const express = require('express');
const meetingsRouter  = express.Router();
module.exports = meetingsRouter;
const {
    getAllFromDatabase, 
    addToDatabase, 
    deleteAllFromDatabase
} = require('./db.js');

// Get all meetings
meetingsRouter.get('/', (req, res) => {
    const meetings = getAllFromDatabase('meetings');
    if (meetings !== undefined) {
        res.send(meetings);
    } else {
        res.status(404).send('Meetings not found');
    }
});

// Post a new meeting
meetingsRouter.post('/', (req, res) => {
    const newMeeting = addToDatabase('meetings', req.query);
    if (newMeeting) {
        res.send(newMeeting);
    }
});

// Delete all meetings
meetingsRouter.delete('/', (req, res) => {
    const meetings = deleteAllFromDatabase('meetings');
    res.status(201).send(meetings);
})