const express = require('express');
const aircraftController = require("../../controllers/aircraftController");
const router = express.Router();

router.get('/list', aircraftController.handleGetAircrafts);

module.exports = router;