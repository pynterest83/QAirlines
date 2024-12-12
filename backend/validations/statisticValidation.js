const Joi = require('joi');

const monthlyBookingStatisticsSchema = Joi.object({
    year: Joi.number().integer().min(2015).required()
        .messages({
            'number.integer': 'Year must be an integer',
            'number.min': 'Year must be greater than or equal to 2015',
            'any.required': 'Year is required'
        }),
});

module.exports = { monthlyBookingStatisticsSchema };