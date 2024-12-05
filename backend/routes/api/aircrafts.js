const express = require('express');
const aircraftController = require("../../controllers/aircraftController");
const authenticateUser = require("../../middlewares/authenticateUser");
const checkAdmin = require("../../middlewares/checkAdmin");
const {createAircraftSchema} = require("../../validations/aircraftValidation");
const validate = require("../../middlewares/validateInput");
const fileUpload = require('express-fileupload');
const router = express.Router();

router.use(fileUpload());

router.get('/list', aircraftController.handleGetAircrafts);
router.post(
    '/create',
    authenticateUser,
    checkAdmin,
    validate(createAircraftSchema, "body"),
    aircraftController.handleCreateAircraft
);

module.exports = router;