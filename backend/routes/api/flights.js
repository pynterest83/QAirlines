const express = require('express');
const router = express.Router();
const flightController = require('../../controllers/flightController');
const validate = require("../../middlewares/validateInput");
const delayFlightSchema = require("../../validations/flightValidation");
const authenticateUser = require("../../middlewares/authenticateUser");
const checkAdmin = require("../../middlewares/checkAdmin");

router.put('/delay', authenticateUser, checkAdmin, validate(delayFlightSchema, 'body'), flightController.handleDelay);

module.exports = router;