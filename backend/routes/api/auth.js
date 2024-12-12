const express = require('express');
const router = express.Router();
const authController = require('../../controllers/authController');
const { registerSchema } = require('../../validations/authValidation');
const validate = require('../../middlewares/validateInput');


router.post('/register', validate(registerSchema), authController.register);


router.post('/login', authController.login);

module.exports = router;
