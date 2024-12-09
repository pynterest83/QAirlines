const Joi = require('joi');

const monthlyBookingStatisticsSchema = Joi.object({
    year: Joi.number().integer().min(2015).required()
        .messages({
            'number.integer': 'Năm phải là số nguyên',
            'number.min': 'Năm phải lớn hơn hoặc bằng 2015',
            'any.required': 'Năm là bắt buộc'
        }),
})

module.exports = { monthlyBookingStatisticsSchema };