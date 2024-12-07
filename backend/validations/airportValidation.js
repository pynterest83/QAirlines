const Joi = require('joi');

const getRelatedAirportsSchema = Joi.object({
    airportId: Joi.string()
        .trim()
        .max(10)
        .required()
        .messages({
            'any.required': 'AirportID is required.',
            'string.empty': 'AirportID cannot be empty.',
            'string.max': 'AirportID must not exceed 10 characters.'
        }),
});

module.exports = { getRelatedAirportsSchema };
