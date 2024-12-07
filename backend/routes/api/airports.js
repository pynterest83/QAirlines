const express = require('express');
const airportController = require("../../controllers/airportController");
const { getRelatedAirportsSchema } = require("../../validations/airportValidation");
const validateInput = require("../../middlewares/validateInput");

const router = express.Router();

router.get(
    '/related',
    validateInput(getRelatedAirportsSchema, 'query'),
    airportController.getRelatedAirports
);

module.exports = router;
