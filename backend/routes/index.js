// routes/index.js
const express = require('express');
const router = express.Router();

// Import các route từ thư mục api
const offersRoutes = require('./api/offers');
const seatsRoutes = require('./api/seats');
const ticketsRoutes = require('./api/tickets');

// Đăng ký các route với URL cơ bản là /api
router.use('/offers', offersRoutes);
router.use('/seats', seatsRoutes);
router.use('/tickets', ticketsRoutes);

module.exports = router;
