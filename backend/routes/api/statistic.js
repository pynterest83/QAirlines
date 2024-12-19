const express = require('express');
const statisticController = require("../../controllers/statisticController");
const authenticateUser = require("../../middlewares/authenticateUser");
const checkAdmin = require("../../middlewares/checkAdmin");
const validate = require("../../middlewares/validateInput");
const { monthlyBookingStatisticsSchema} = require("../../validations/statisticValidation");

const router = express.Router();


router.get('/booking/monthly', authenticateUser, checkAdmin, validate(monthlyBookingStatisticsSchema, 'query'), statisticController.handleMonthlyBooking);
router.get('/income/monthly', authenticateUser, checkAdmin, validate(monthlyBookingStatisticsSchema, 'query'), statisticController.handleMonthlyIncome);

module.exports = router;