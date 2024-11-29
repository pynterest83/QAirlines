const express = require('express');
const router = express.Router();
const flightController = require('../../controllers/flightController');
const validate = require("../../middlewares/validateInput");
const authenticateUser = require("../../middlewares/authenticateUser");
const checkAdmin = require("../../middlewares/checkAdmin");
const {updateFlightSchema} = require("../../validations/flightValidation");

router.put('/update', authenticateUser, checkAdmin, validate(updateFlightSchema, 'body'), flightController.handleUpdate);

module.exports = router;