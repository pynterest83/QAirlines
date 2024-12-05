const Joi = require('joi');

const createAircraftSchema = Joi.object({
    AircraftID: Joi.string().max(10).required(),
    Model: Joi.string().required(),
    Manufacturer: Joi.string().required(),
    Capacity: Joi.number().integer().min(1).required(),
    seats: Joi.alternatives().try(
        Joi.array().items(
            Joi.object({
                SeatNo: Joi.string().required(),
                Class: Joi.string().valid('Economy', 'Business', 'First').required()
            })
        ),
        Joi.string()
    ).required(),
});

module.exports = { createAircraftSchema };
