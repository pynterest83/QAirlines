const Joi = require('joi');

// Schema đặt vé
const bookTicketSchema = Joi.object({
    flightID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Mã chuyến bay không được vượt quá 10 ký tự',
            'any.required': 'Mã chuyến bay là bắt buộc'
        }),
    passengers: Joi.array()
        .items(
            Joi.object({
                firstName: Joi.string()
                    .max(50)
                    .required()
                    .messages({
                        'string.max': 'Tên không được vượt quá 50 ký tự',
                        'any.required': 'Tên là bắt buộc'
                    }),
                lastName: Joi.string()
                    .max(50)
                    .required()
                    .messages({
                        'string.max': 'Họ không được vượt quá 50 ký tự',
                        'any.required': 'Họ là bắt buộc'
                    }),
                dob: Joi.date()
                    .less('now')
                    .required()
                    .messages({
                        'date.less': 'Ngày sinh phải nhỏ hơn ngày hiện tại',
                        'any.required': 'Ngày sinh là bắt buộc'
                    }),
                gender: Joi.string()
                    .valid('M', 'F')
                    .required()
                    .messages({
                        'any.only': 'Giới tính phải là "M" (Nam) hoặc "F" (Nữ)',
                        'any.required': 'Giới tính là bắt buộc'
                    }),
                email: Joi.string()
                    .email()
                    .optional()
                    .messages({
                        'string.email': 'Email không hợp lệ'
                    }),
                phoneNumber: Joi.string()
                    .pattern(/^\+?\d{9,15}$/)
                    .optional()
                    .messages({
                        'string.pattern.base': 'Số điện thoại phải có từ 9 đến 15 chữ số và có thể bắt đầu bằng dấu "+"'
                    }),
                passport: Joi.string()
                    .max(20)
                    .optional()
                    .messages({
                        'string.max': 'Hộ chiếu không được vượt quá 20 ký tự'
                    }),
                ssn: Joi.string()
                    .length(12)
                    .optional()
                    .messages({
                        'string.length': 'SSN phải có đúng 12 chữ số'
                    }),
                seatNo: Joi.string()
                    .max(5)
                    .required()
                    .messages({
                        'string.max': 'Số ghế không được vượt quá 5 ký tự',
                        'any.required': 'Số ghế là bắt buộc'
                    }),
                guardianSSN: Joi.string()
                    .length(12)
                    .optional()
                    .messages({
                        'string.length': 'SSN của người giám hộ phải có đúng 12 chữ số'
                    }),
            })
        )
        .min(1)
        .required()
        .messages({
            'array.min': 'Phải có ít nhất 1 hành khách',
            'any.required': 'Danh sách hành khách là bắt buộc'
        }),
});

// Schema hủy vé
const cancelTicketSchema = Joi.object({
    ticketID: Joi.string()
        .max(10)
        .required()
        .messages({
            'string.max': 'Mã vé không được vượt quá 10 ký tự',
            'any.required': 'Mã vé là bắt buộc'
        }),
});

// Schema kiểm tra input cho /my-tickets
const myTicketsSchema = Joi.object({
    identifier: Joi.string()
        .required()
        .regex(/^\d{12}$|^[A-Z0-9]{6,9}$/) // SSN: 12 chữ số hoặc Passport: 6-9 ký tự
        .messages({
            'string.pattern.base': 'Identifier phải là SSN hợp lệ (12 chữ số) hoặc Passport (6-9 ký tự chữ và số)',
            'any.required': 'Identifier là bắt buộc'
        })
});

module.exports = {
    bookTicketSchema,
    cancelTicketSchema,
    myTicketsSchema
};
