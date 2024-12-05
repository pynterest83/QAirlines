const Joi = require('joi');

const createAircraftSchema = Joi.object({
    AircraftID: Joi.string().max(10).required(),
    Model: Joi.string().required(),
    Capacity: Joi.number().integer().min(1).required(),
    Manufacturer: Joi.string().required(),
    seats: Joi.array().items(
        Joi.object({
            SeatNo: Joi.string().required(),
            Class: Joi.string().valid('Economy', 'Business', 'First').required()
        })
    ).required()
});

module.exports = { createAircraftSchema };
