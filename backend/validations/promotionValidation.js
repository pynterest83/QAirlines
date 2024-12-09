const Joi = require('joi');

// Schema cho tạo mới khuyến mãi
const createPromotionSchema = Joi.object({
    Title: Joi.string()
        .max(100)
        .required()
        .messages({
            'string.max': 'Tiêu đề không được vượt quá 100 ký tự',
            'any.required': 'Tiêu đề là bắt buộc'
        }),
    Content: Joi.string()
        .required()
        .messages({
            'any.required': 'Nội dung là bắt buộc'
        }),
    Amount: Joi.number()
        .positive()
        .optional()
        .messages({
            'number.positive': 'Số tiền khuyến mãi phải là số dương'
        })
});

// Schema cho cập nhật khuyến mãi
const updatePromotionSchema = Joi.object({
    Title: Joi.string()
        .max(100)
        .optional()
        .messages({
            'string.max': 'Tiêu đề không được vượt quá 100 ký tự'
        }),
    Content: Joi.string()
        .optional()
        .messages({
            'any.required': 'Nội dung là bắt buộc'
        }),
    Amount: Joi.number()
        .positive()
        .optional()
        .messages({
            'number.positive': 'Số tiền khuyến mãi phải là số dương'
        })
});

module.exports = {
    createPromotionSchema,
    updatePromotionSchema
};
