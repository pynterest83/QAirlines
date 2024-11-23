const Joi = require('joi');

// Schema cho chuyến bay khứ hồi
const roundTripSchema = Joi.object({
    departure: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Mã sân bay đi phải có đúng 3 ký tự',
            'any.required': 'Mã sân bay đi là bắt buộc'
        }),
    destination: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Mã sân bay đến phải có đúng 3 ký tự',
            'any.required': 'Mã sân bay đến là bắt buộc'
        }),
    departure_date: Joi.date()
        .required()
        .messages({
            'date.base': 'Ngày khởi hành không hợp lệ',
            'any.required': 'Ngày khởi hành là bắt buộc'
        }),
    return_date: Joi.date()
        .greater(Joi.ref('departure_date'))
        .required()
        .messages({
            'date.greater': 'Ngày về phải sau ngày khởi hành',
            'any.required': 'Ngày về là bắt buộc'
        })
});

// Schema cho chuyến bay một chiều
const oneWaySchema = Joi.object({
    departure: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Mã sân bay đi phải có đúng 3 ký tự',
            'any.required': 'Mã sân bay đi là bắt buộc'
        }),
    destination: Joi.string()
        .length(3)
        .required()
        .messages({
            'string.length': 'Mã sân bay đến phải có đúng 3 ký tự',
            'any.required': 'Mã sân bay đến là bắt buộc'
        }),
    departure_date: Joi.date()
        .required()
        .messages({
            'date.base': 'Ngày khởi hành không hợp lệ',
            'any.required': 'Ngày khởi hành là bắt buộc'
        })
});

module.exports = {
    roundTripSchema,
    oneWaySchema
};
