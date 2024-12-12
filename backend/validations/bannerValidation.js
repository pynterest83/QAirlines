const Joi = require('joi');

const createBannerSchema = Joi.object({
    Title: Joi.string().required().messages({
        'string.empty': 'Title is required.',
    }),
    Description: Joi.string().required().messages({
        'string.empty': 'Description is required.',
    }),
    DiscountTitle: Joi.string().optional().allow('').messages({
        'string.empty': 'Discount Title cannot be empty.',
    }),
    DiscountDescription: Joi.string().optional().allow('').messages({
        'string.empty': 'Discount Description cannot be empty.',
    })
});

const editBannerSchema = Joi.object({
    bannerID: Joi.string().required().messages({
        'string.empty': 'Banner ID is required.',
    }),
    Title: Joi.string().max(100).optional(),
    Description: Joi.string().allow('').optional(),
    DiscountTitle: Joi.string().max(50).allow(null, '').optional(),
    DiscountDescription: Joi.string().allow('').optional(),
    image: Joi.object({
        name: Joi.string().required(),
        data: Joi.any().required(),
        mimetype: Joi.string().valid('image/svg+xml', 'image/png', 'image/jpeg').required().messages({
            'any.only': 'Image must be in SVG, PNG, or JPEG format.',
        }),
    }).optional(),
});

const deleteBannerSchema = Joi.object({
    bannerID: Joi.string().required().messages({
        'string.empty': 'Banner ID is required.',
    }),
});


module.exports = {
    createBannerSchema,
    editBannerSchema,
    deleteBannerSchema,
};
