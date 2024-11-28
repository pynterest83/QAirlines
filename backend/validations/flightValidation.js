const Joi = require('joi');

const delayFlightSchema = Joi.object({
    flightID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.empty': 'Flight ID is required',
            'string.max': 'Flight ID must not exceed 10 characters',
        }),
    DepTime: Joi.date()
        .allow(null)
        .optional()
        .messages({
            'date.base': 'DepTime must be a valid date',
        }),
    ArrTime: Joi.date()
        .allow(null)
        .optional()
        .messages({
            'date.base': 'ArrTime must be a valid date',
        }),
    BoardingTime: Joi.date()
        .allow(null)
        .optional()
        .messages({
            'date.base': 'BoardingTime must be a valid date',
        }),
});

module.exports = delayFlightSchema;
