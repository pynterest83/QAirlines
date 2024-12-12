const Joi = require('joi');

const createPromotionSchema = Joi.object({
    Title: Joi.string()
        .max(100)
        .required()
        .messages({
            'string.max': 'Title must not exceed 100 characters',
            'any.required': 'Title is required'
        }),
    Content: Joi.string()
        .required()
        .messages({
            'any.required': 'Content is required'
        }),
    Amount: Joi.number()
        .positive()
        .optional()
        .messages({
            'number.positive': 'Amount must be a positive number'
        })
});

const updatePromotionSchema = Joi.object({
    Title: Joi.string()
        .max(100)
        .optional()
        .messages({
            'string.max': 'Title must not exceed 100 characters'
        }),
    Content: Joi.string()
        .optional()
        .messages({
            'any.required': 'Content is required'
        }),
    Amount: Joi.number()
        .positive()
        .optional()
        .messages({
            'number.positive': 'Amount must be a positive number'
        })
});

module.exports = {
    createPromotionSchema,
    updatePromotionSchema
};