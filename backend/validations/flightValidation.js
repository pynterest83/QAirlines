const Joi = require('joi');

const updateFlightSchema = Joi.object({
    flightID: Joi.string().max(10).required().messages({
        'string.empty': 'Flight ID is required',
        'string.max': 'Flight ID must not exceed 10 characters',
    }),
    DepTime: Joi.date().optional().messages({
        'date.base': 'DepTime must be a valid date',
    }),
    ArrTime: Joi.date().optional().messages({
        'date.base': 'ArrTime must be a valid date',
    }),
    BoardingTime: Joi.date().optional().messages({
        'date.base': 'BoardingTime must be a valid date',
    }),
    Status: Joi.string().optional().max(20).messages({
        'string.max': 'Status must not exceed 20 characters',
    }),
    DepID: Joi.string().optional().max(3).messages({
        'string.max': 'DepID must not exceed 3 characters',
    }),
    DestID: Joi.string().optional().max(3).messages({
        'string.max': 'DestID must not exceed 3 characters',
    }),
    AircraftID: Joi.string().optional().max(10).messages({
        'string.max': 'AircraftID must not exceed 10 characters',
    })
});

const createFlightSchema = Joi.object({
    Status: Joi.string().max(20).required().messages({
        'string.empty': 'Status is required',
        'string.max': 'Status must not exceed 20 characters',
    }),
    DepTime: Joi.date().required().messages({
        'date.base': 'DepTime must be a valid date',
        'any.required': 'DepTime is required',
    }),
    ArrTime: Joi.date().required().messages({
        'date.base': 'ArrTime must be a valid date',
        'any.required': 'ArrTime is required',
    }),
    BoardingTime: Joi.date().required().messages({
        'date.base': 'BoardingTime must be a valid date',
        'any.required': 'BoardingTime is required',
    }),
    DepID: Joi.string().max(3).required().messages({
        'string.empty': 'Departure ID is required',
        'string.max': 'DepID must not exceed 3 characters',
    }),
    DestID: Joi.string().max(3).required().messages({
        'string.empty': 'Destination ID is required',
        'string.max': 'DestID must not exceed 3 characters',
    }),
    AircraftID: Joi.string().max(10).required().messages({
        'string.empty': 'Aircraft ID is required',
        'string.max': 'AircraftID must not exceed 10 characters',
    }),
});

const getFlightsSchema = Joi.object({
    flightIds: Joi.string()
        .pattern(/^[A-Za-z0-9,]*$/) // Allows alphanumeric characters and commas
        .optional()
        .messages({
            'string.pattern.base': 'Flight IDs must be a comma-separated list of alphanumeric values.',
        }),
});

module.exports = { getFlightsSchema };


module.exports = {
    updateFlightSchema,
    createFlightSchema,
    getFlightsSchema
};
