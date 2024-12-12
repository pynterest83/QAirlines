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
    Status: Joi.string().max(20).required(),
    DepTime: Joi.date().required(),
    ArrTime: Joi.date().required(),
    BoardingTime: Joi.date().required(),
    DepID: Joi.string().max(3).required(),
    DestID: Joi.string().max(3).required(),
    AircraftID: Joi.string().max(10).required(),
    ticketPrices: Joi.object({
        Economy: Joi.number().positive().required(),
        Business: Joi.number().positive().required(),
        First: Joi.number().positive().required(),
    }).required().messages({
        'any.required': 'Ticket prices for all classes are required',
    }),
});


const getFlightsSchema = Joi.object({
    flightIds: Joi.string()
        .pattern(/^[A-Za-z0-9,]*$/)
        .optional()
        .messages({
            'string.pattern.base': 'Flight IDs must be a comma-separated list of alphanumeric values.',
        }),
});

const getFlightDetailsSchema = Joi.object({
    flightId: Joi.string().max(10).required().messages({
        'string.empty': 'Flight ID is required',
        'string.max': 'Flight ID must not exceed 10 characters',
    }),
});


module.exports = {
    updateFlightSchema,
    createFlightSchema,
    getFlightsSchema,
    getFlightDetailsSchema,
};
