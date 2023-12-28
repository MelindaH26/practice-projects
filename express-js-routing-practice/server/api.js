const express = require('express');
const apiRouter = express.Router();
const minionsRouter = require('./minions.js');
const ideasRouter = require('./ideas.js');
const meetingsRouter = require('./meetings.js');

// mount minions router
apiRouter.use('/minions', minionsRouter);
// mount ideas router
apiRouter.use('/ideas', ideasRouter);
//mount meetings router
apiRouter.use('/meetings', meetingsRouter);

module.exports = apiRouter;