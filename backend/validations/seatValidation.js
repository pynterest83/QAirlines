const Joi = require('joi');

// Schema kiểm tra tất cả các chỗ ngồi
const allSeatsSchema = Joi.object({
    flightID: Joi.string().max(10).required(), // Sử dụng flightID
});

// Schema kiểm tra các chỗ ngồi trống theo hạng ghế
const availableSeatsSchema = Joi.object({
    flightID: Joi.string().max(10).required(), // Sử dụng flightID
    class: Joi.string().valid('Economy', 'Business', 'First').required(),
});

module.exports = {
    allSeatsSchema,
    availableSeatsSchema,
};
