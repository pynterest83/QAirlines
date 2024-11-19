const Joi = require('joi');

// Schema cho chuyến bay khứ hồi
const roundTripSchema = Joi.object({
    departure: Joi.string().length(3).required(),
    destination: Joi.string().length(3).required(),
    departure_date: Joi.date().required(),
    return_date: Joi.date().greater(Joi.ref('departure_date')).required(),
});

// Schema cho chuyến bay một chiều
const oneWaySchema = Joi.object({
    departure: Joi.string().length(3).required(),
    destination: Joi.string().length(3).required(),
    departure_date: Joi.date().required(),
});

module.exports = {
    roundTripSchema,
    oneWaySchema,
};
