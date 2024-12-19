
const express = require('express');
const router = express.Router();
const seatsController = require('../../controllers/seatsController');
const validate = require("../../middlewares/validateInput");
const {allSeatsSchema, availableSeatsSchema} = require("../../validations/seatValidation");


router.get('/all', validate(allSeatsSchema, 'query'), seatsController.getAllSeats);


router.get('/available', validate(availableSeatsSchema, 'query'), seatsController.getAvailableSeats);

module.exports = router;
