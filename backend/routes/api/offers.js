const express = require('express');
const router = express.Router();
const offersController = require('../../controllers/offersController');
const validate = require("../../middlewares/validateInput");
const {roundTripSchema, oneWaySchema, rangeSchema, byDateSchema} = require("../../validations/offerValidation");


router.get('/round-trip', validate(roundTripSchema, 'query'), offersController.getRoundTripFlights);
router.get('/one-way', validate(oneWaySchema, 'query'), offersController.getOneWayFlights);
router.get('/in-range', validate(rangeSchema, 'query'), offersController.getFlightsWithinRange);
router.get('/by-date', validate(byDateSchema, 'query'), offersController.getFlightsByDate);

module.exports = router;
