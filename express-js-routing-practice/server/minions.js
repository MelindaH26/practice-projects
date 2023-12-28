const express = require('express');
const minionsRouter = express.Router();
module.exports = minionsRouter;
const {
    getAllFromDatabase, 
    addToDatabase, 
    getFromDatabaseById, 
    updateInstanceInDatabase,
    deleteFromDatabasebyId
} = require('./db.js');

// Get all minions
minionsRouter.get('/', (req, res) => {
    const allMinions = getAllFromDatabase('minions');
    console.log('I got all minions');
    res.send(allMinions);
});

// Create a new minion
minionsRouter.post('/', (req, res) => {
    const instance = req.query;
    const name = instance.name;
    // check minion has required fields
    if (name && salary) {
        const newMinion = addToDatabase('minions', instance);
        res.send(newMinion);
    }
    res.status(400).send();
});

// check for minion if
minionsRouter.param('minionId', (req, res, next, id) => {
    minion = getFromDatabaseById('minions', id);
    // if minion with that id exists
    if(minion !== undefined) {
        req.minion = minion;
        next();
    }
    res.status(404).send();
});

// Get minion by id
minionsRouter.get('/:minionId', (req, res) => {
    res.send(req.minion);
});

minionsRouter.put('/:minionId', (req, res) => {
    // set query id to match url id
    req.query.id  = minion.id;
    // check if salary only contains numbers
    const salary = req.query.salary;
    if(salary && (salary.match(/^[0-9]+$/) != null)){
        const updatedMinion = updateInstanceInDatabase('minions', req.query);
        res.send(updatedMinion);
    }
    res.status(404);
});

// Delete single minion
minionsRouter.delete('/:minionId', (req, res) => {
    const deletedMinion = deleteFromDatabasebyId('minions', req.minion.id);
    if (deletedMinion) {
        res.status(204).send();
    }
    res.status(404);
});