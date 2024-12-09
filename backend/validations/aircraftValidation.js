const Joi = require('joi');

const createAircraftSchema = Joi.object({
    AircraftID: Joi.string().max(10).required(),
    Model: Joi.string().required(),
    Manufacturer: Joi.string().required(),
    Capacity: Joi.number().integer().min(1).required()
});

module.exports = { createAircraftSchema };
