const Joi = require('joi');

const registerSchema = Joi.object({
    username: Joi.string()
        .alphanum()
        .min(3)
        .max(30)
        .required()
        .messages({
            'string.alphanum': 'Username can only contain alphanumeric characters',
            'string.min': 'Username must be at least 3 characters long',
            'string.max': 'Username must not exceed 30 characters',
            'any.required': 'Username is required'
        }),
    password: Joi.string()
        .min(6)
        .required()
        .messages({
            'string.min': 'Password must be at least 6 characters long',
            'any.required': 'Password is required'
        }),
    role: Joi.string()
        .valid('User', 'Admin')
        .optional()
        .messages({
            'any.only': 'Role can only be "User" or "Admin"'
        })
});

module.exports = {
    registerSchema
};
