const Joi = require('joi');
const allSeatsSchema = Joi.object({
    flightID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Flight ID must not exceed 10 characters',
            'any.required': 'Flight ID is required'
        }),
});
const availableSeatsSchema = Joi.object({
    flightID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Flight ID must not exceed 10 characters',
            'any.required': 'Flight ID is required'
        }),
    class: Joi.string()
        .valid('Economy', 'Business', 'First')
        .required()
        .messages({
            'any.only': 'Class must be "Economy", "Business", or "First"',
            'any.required': 'Class is required'
        }),
});
module.exports = {
    allSeatsSchema,
    availableSeatsSchema,
};