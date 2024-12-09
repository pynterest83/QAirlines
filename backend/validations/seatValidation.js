const Joi = require('joi');

// Schema kiểm tra tất cả các chỗ ngồi
const allSeatsSchema = Joi.object({
    flightID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Mã chuyến bay không được vượt quá 10 ký tự',
            'any.required': 'Mã chuyến bay là bắt buộc'
        }),
});

// Schema kiểm tra các chỗ ngồi trống theo hạng ghế
const availableSeatsSchema = Joi.object({
    flightID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Mã chuyến bay không được vượt quá 10 ký tự',
            'any.required': 'Mã chuyến bay là bắt buộc'
        }),
    class: Joi.string()
        .valid('Economy', 'Business', 'First')
        .required()
        .messages({
            'any.only': 'Hạng ghế phải là "Economy", "Business", hoặc "First"',
            'any.required': 'Hạng ghế là bắt buộc'
        }),
});

module.exports = {
    allSeatsSchema,
    availableSeatsSchema,
};
