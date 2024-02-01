const express = require('express');
const ideasRouter = express.Router();
module.exports = ideasRouter;
const {
    getAllFromDatabase, 
    addToDatabase, 
    getFromDatabaseById, 
    updateInstanceInDatabase,
    deleteFromDatabasebyId
} = require('./db.js');

// get all ideas
ideasRouter.get('/', (req, res) => {
    const ideas = getAllFromDatabase('ideas');
    if (ideas) {
        res.status(200).send(ideas);
    } 
    res.status(404).send();
});

// Post new idea
ideasRouter.post('/', (req, res) => {
    const newIdea = addToDatabase('ideas', req.query);
    if (newIdea) {
        res.send(newIdea);
    }
});

// check if idea with ID exists
ideasRouter.param('ideaId', (req, res, next, id) => {
    const ideaObj = getFromDatabaseById('ideas', id);
    if (ideaObj !== undefined) {
        req.idea = ideaObj;
        next();
        return;
    }
    res.status(404).send('Invalid ID');
});

// Get single idea
ideasRouter.get('/:ideaId', (req, res) => {
    res.send(req.idea);
});

// Update idea
ideasRouter.put('/:ideaId', (req, res) => {
    const ideaQ = req.query;
    const ideaObj =  {
        "id": req.idea.id,
        "name": ideaQ.name,
        "description": ideaQ.description,
        "weeklyRevenue": ideaQ.weeklyRevenue,
        "numWeeks": ideaQ.numWeeks
    }
    const updatedIdea = updateInstanceInDatabase('ideas', ideaObj);
    if(updatedIdea !== undefined) {
        res.send(ideaObj);
    }
    res.status(404).send();
});

// Delete single idea
ideasRouter.delete('/:ideaId', (req, res) => {
    const isDeleted = deleteFromDatabasebyId('ideas', req.idea.id);
    if (isDeleted) {
        res.status(204).send();
    } else {
        res.status(404).send();
    }
});