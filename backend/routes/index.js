// routes/index.js
const express = require('express');
const router = express.Router();

// Import các route từ thư mục api
const offersRoutes = require('./api/offers');
const seatsRoutes = require('./api/seats');
const ticketsRoutes = require('./api/tickets');
const promotionsRoutes = require('./api/promotions');
const authRoutes = require('./api/auth');

// Đăng ký các route với URL cơ bản là /api
router.use('/offers', offersRoutes);
router.use('/seats', seatsRoutes);
router.use('/tickets', ticketsRoutes);
router.use('/promotions', promotionsRoutes);
router.use('/auth', authRoutes);

module.exports = router;
