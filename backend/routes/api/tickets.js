const express = require('express');
const router = express.Router();
const ticketsController = require('../../controllers/ticketsController');
const { myTicketsSchema, cancelTicketSchema, bookTicketSchema} = require('../../validations/ticketValidation');
const validate = require("../../middlewares/validateInput");

router.post('/book-ticket', validate(bookTicketSchema, 'body'), ticketsController.handleBookTicket);
router.delete('/cancel-ticket', validate(cancelTicketSchema, 'body'), ticketsController.handleCancelTicket);
router.get('/my-tickets', validate(myTicketsSchema, 'query'), ticketsController.handleGetMyTicket);

module.exports = router;
