const express = require('express');
const router = express.Router();
const roomController = require('../controllers/roomController');

router.post('/', roomController.getOrCreateRoom);
router.get('/', roomController.listRoomsForUser); // list rooms by ?userId
router.get('/:id', roomController.getRoom);

module.exports = router;
