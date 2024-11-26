const express = require('express');
const router = express.Router();
const ticketsController = require('../../controllers/ticketsController');
const { myTicketsSchema, cancelTicketSchema, bookTicketSchema, ticketByIdSchema } = require('../../validations/ticketValidation');
const validate = require("../../middlewares/validateInput");

router.post('/book-ticket', validate(bookTicketSchema, 'body'), ticketsController.handleBookTicket);
router.delete('/cancel-ticket', validate(cancelTicketSchema, 'body'), ticketsController.handleCancelTicket);
router.get('/by-id', validate(ticketByIdSchema, 'query'), ticketsController.handleGetTicketByID);
router.get('/my-tickets', validate(myTicketsSchema, 'query'), ticketsController.handleGetMyTicket);

module.exports = router;
