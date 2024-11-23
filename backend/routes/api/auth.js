const express = require('express');
const router = express.Router();
const authController = require('../../controllers/authController');
const { registerSchema } = require('../../validations/authValidation');
const validate = require('../../middlewares/validateInput');

// Đăng ký
router.post('/register', validate(registerSchema), authController.register);

// Đăng nhập
router.post('/login', authController.login);

module.exports = router;
