const Joi = require('joi');

// Schema đặt vé
const bookTicketSchema = Joi.object({
    flightID: Joi.string().max(10).required(),
    passengers: Joi.array()
        .items(
            Joi.object({
                firstName: Joi.string().max(50).required(),
                lastName: Joi.string().max(50).required(),
                dob: Joi.date().less('now').required(),
                gender: Joi.string().valid('M', 'F').required(),
                email: Joi.string().email().optional(),
                phoneNumber: Joi.string().pattern(/^\+?\d{9,15}$/).optional(),
                passport: Joi.string().max(20).optional(),
                ssn: Joi.string().length(12).optional(),
                seatNo: Joi.string().max(5).required(),
                guardianSSN: Joi.string().length(12).optional(),
            })
        )
        .min(1)
        .required(),
});

// Schema hủy vé
const cancelTicketSchema = Joi.object({
    ticketID: Joi.string().max(10).required(),
});

module.exports = {
    bookTicketSchema,
    cancelTicketSchema,
};
