// routes/api/offers.js
const express = require('express');
const router = express.Router();
const offersController = require('../../controllers/offersController');
const validate = require("../../middlewares/validateInput");
const {roundTripSchema, oneWaySchema} = require("../../validations/offerValidation");

// Định nghĩa các endpoint và gắn với controller tương ứng
router.get('/round-trip', validate(roundTripSchema, 'query'), offersController.getRoundTripFlights);
router.get('/one-way', validate(oneWaySchema, 'query'), offersController.getOneWayFlights);

module.exports = router;
