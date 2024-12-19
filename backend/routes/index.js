
const express = require('express');
const router = express.Router();


const offersRoutes = require('./api/offers');
const seatsRoutes = require('./api/seats');
const ticketsRoutes = require('./api/tickets');
const promotionsRoutes = require('./api/promotions');
const authRoutes = require('./api/auth');
const flightRoutes = require('./api/flights');
const aircraftRoutes = require('./api/aircrafts');
const statisticRoutes = require('./api/statistic');
const airportsRoutes = require('./api/airports');
const bannerRoutes = require('./api/banner');


router.use('/offers', offersRoutes);
router.use('/seats', seatsRoutes);
router.use('/tickets', ticketsRoutes);
router.use('/promotions', promotionsRoutes);
router.use('/auth', authRoutes);
router.use('/flights', flightRoutes);
router.use('/aircrafts', aircraftRoutes);
router.use('/statistics', statisticRoutes);
router.use('/airports', airportsRoutes);
router.use('/banners', bannerRoutes);

module.exports = router;
