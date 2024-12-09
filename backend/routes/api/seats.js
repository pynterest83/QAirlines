// routes/api/seats.js
const express = require('express');
const router = express.Router();
const seatsController = require('../../controllers/seatsController');
const validate = require("../../middlewares/validateInput");
const {allSeatsSchema, availableSeatsSchema} = require("../../validations/seatValidation");

// API lấy tất cả chỗ ngồi của một chuyến bay
router.get('/all', validate(allSeatsSchema, 'query'), seatsController.getAllSeats);

// API lấy danh sách các chỗ ngồi trống theo hạng ghế của một chuyến bay
router.get('/available', validate(availableSeatsSchema, 'query'), seatsController.getAvailableSeats);

module.exports = router;
