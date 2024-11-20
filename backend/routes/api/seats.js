// routes/api/seats.js
const express = require('express');
const router = express.Router();
const seatsController = require('../../controllers/seatsController');

// API lấy tất cả chỗ ngồi của một chuyến bay
router.get('/all', seatsController.getAllSeats);

// API lấy danh sách các chỗ ngồi trống theo hạng ghế của một chuyến bay
router.get('/available', seatsController.getAvailableSeats);

module.exports = router;
