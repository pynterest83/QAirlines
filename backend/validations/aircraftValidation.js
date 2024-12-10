const Joi = require('joi');

const createAircraftSchema = Joi.object({
    AircraftID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Aircraft ID must not exceed 10 characters',
            'any.required': 'Aircraft ID is required'
        }),
    Model: Joi.string()
        .required()
        .messages({
            'any.required': 'Model is required'
        }),
    Manufacturer: Joi.string()
        .required()
        .messages({
            'any.required': 'Manufacturer is required'
        }),
    Capacity: Joi.number()
        .integer()
        .min(1)
        .required()
        .messages({
            'number.base': 'Capacity must be a number',
            'number.integer': 'Capacity must be an integer',
            'number.min': 'Capacity must be at least 1',
            'any.required': 'Capacity is required'
        })
});

module.exports = { createAircraftSchema };