// routes/api/offers.js
const express = require('express');
const router = express.Router();
const offersController = require('../../controllers/offersController');

// Định nghĩa các endpoint và gắn với controller tương ứng
router.get('/round-trip', offersController.getRoundTripFlights);
router.get('/one-way', offersController.getOneWayFlights);

module.exports = router;
