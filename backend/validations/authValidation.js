const Joi = require('joi');

const registerSchema = Joi.object({
    username: Joi.string()
        .alphanum()
        .min(3)
        .max(30)
        .required()
        .messages({
            'string.alphanum': 'Tên đăng nhập chỉ chứa các ký tự chữ và số',
            'string.min': 'Tên đăng nhập phải có ít nhất 3 ký tự',
            'string.max': 'Tên đăng nhập không được vượt quá 30 ký tự',
            'any.required': 'Tên đăng nhập là bắt buộc'
        }),
    password: Joi.string()
        .min(6)
        .required()
        .messages({
            'string.min': 'Mật khẩu phải có ít nhất 6 ký tự',
            'any.required': 'Mật khẩu là bắt buộc'
        }),
    role: Joi.string()
        .valid('User', 'Admin')
        .optional()
        .messages({
            'any.only': 'Vai trò chỉ có thể là "User" hoặc "Admin"'
        })
});

module.exports = {
    registerSchema
};
