const Joi = require('joi');
const roundTripSchema = Joi.object({
    departure: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Departure airport code must be exactly 3 characters',
            'any.required': 'Departure airport code is required'
        }),
    destination: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Destination airport code must be exactly 3 characters',
            'any.required': 'Destination airport code is required'
        }),
    departure_date: Joi.date()
        .required()
        .messages({
            'date.base': 'Invalid departure date',
            'any.required': 'Departure date is required'
        }),
    return_date: Joi.date()
        .greater(Joi.ref('departure_date'))
        .required()
        .messages({
            'date.greater': 'Return date must be after departure date',
            'any.required': 'Return date is required'
        })
});

const oneWaySchema = Joi.object({
    departure: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Departure airport code must be exactly 3 characters',
            'any.required': 'Departure airport code is required'
        }),
    destination: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Destination airport code must be exactly 3 characters',
            'any.required': 'Destination airport code is required'
        }),
    departure_date: Joi.date()
        .required()
        .messages({
            'date.base': 'Invalid departure date',
            'any.required': 'Departure date is required'
        })
});
const rangeSchema = Joi.object({
    departure: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Departure airport code must be exactly 3 characters',
            'any.required': 'Departure airport code is required'
        }),
    destination: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Destination airport code must be exactly 3 characters',
            'any.required': 'Destination airport code is required'
        }),
    start_date: Joi.date()
        .required()
        .messages({
            'date.base': 'Invalid start date',
            'any.required': 'Start date is required'
        }),
    end_date: Joi.date()
        .greater(Joi.ref('start_date'))
        .required()
        .messages({
            'date.greater': 'End date must be after start date',
            'any.required': 'End date is required'
        }),
    ticket_class: Joi.string()
        .valid('Economy', 'Business', 'First')
        .optional()
        .messages({
            'any.only': 'Ticket class must be "Economy", "Business" or "First"'
        })
});
const byDateSchema = Joi.object({
    date: Joi.date()
        .required()
        .messages({
            'date.base': 'Invalid flight date',
            'any.required': 'Flight date is required'
        })
});
module.exports = {
    roundTripSchema,
    oneWaySchema,
    rangeSchema,
    byDateSchema
};