const Joi = require('joi');

const bookTicketSchema = Joi.object({
    flightID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Flight ID must not exceed 10 characters',
            'any.required': 'Flight ID is required'
        }),
    passengers: Joi.array()
        .items(
            Joi.object({
                firstName: Joi.string()
                    .max(50)
                    .required()
                    .messages({
                        'string.max': 'First name must not exceed 50 characters',
                        'any.required': 'First name is required'
                    }),
                lastName: Joi.string()
                    .max(50)
                    .required()
                    .messages({
                        'string.max': 'Last name must not exceed 50 characters',
                        'any.required': 'Last name is required'
                    }),
                dob: Joi.date()
                    .less('now')
                    .required()
                    .messages({
                        'date.less': 'Date of birth must be before the current date',
                        'any.required': 'Date of birth is required'
                    }),
                gender: Joi.string()
                    .valid('M', 'F')
                    .required()
                    .messages({
                        'any.only': 'Gender must be "M" (Male) or "F" (Female)',
                        'any.required': 'Gender is required'
                    }),
                email: Joi.string()
                    .email()
                    .optional()
                    .messages({
                        'string.email': 'Invalid email'
                    }),
                phoneNumber: Joi.string()
                    .pattern(/^\+?\d{9,15}$/)
                    .optional()
                    .messages({
                        'string.pattern.base': 'Phone number must be between 9 and 15 digits and can start with a "+"'
                    }),
                passport: Joi.string()
                    .max(20)
                    .optional()
                    .messages({
                        'string.max': 'Passport must not exceed 20 characters'
                    }),
                ssn: Joi.string()
                    .length(12)
                    .optional()
                    .messages({
                        'string.length': 'SSN must be exactly 12 digits'
                    }),
                seatNo: Joi.string()
                    .max(5)
                    .required()
                    .messages({
                        'string.max': 'Seat number must not exceed 5 characters',
                        'any.required': 'Seat number is required'
                    }),
                guardianSSN: Joi.string()
                    .length(12)
                    .optional()
                    .messages({
                        'string.length': 'Guardian SSN must be exactly 12 digits'
                    }),
            })
        )
        .min(1)
        .required()
        .messages({
            'array.min': 'There must be at least 1 passenger',
            'any.required': 'Passenger list is required'
        }),
});

const cancelTicketSchema = Joi.object({
    ticketID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Ticket ID must not exceed 10 characters',
            'any.required': 'Ticket ID is required'
        }),
});

const myTicketsSchema = Joi.object({
    identifier: Joi.string()
        .required()
        .regex(/^\d{12}$|^[A-Z0-9]{6,9}$/)
        .messages({
            'string.pattern.base': 'Identifier must be a valid SSN (12 digits) or Passport (6-9 alphanumeric characters)',
            'any.required': 'Identifier is required'
        })
});

const ticketByIdSchema = Joi.object({
    ticketId: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Ticket ID must not exceed 10 characters',
            'any.required': 'Ticket ID is required'
        }),
});

module.exports = {
    bookTicketSchema,
    cancelTicketSchema,
    myTicketsSchema,
    ticketByIdSchema
};