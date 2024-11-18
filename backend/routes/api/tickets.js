const express = require('express');
const router = express.Router();
const ticketsController = require('../../controllers/ticketsController');

router.post('/book-ticket', ticketsController.handleBookTicket);
router.delete('/cancel-ticket', ticketsController.handleCancelTicket);

module.exports = router;
