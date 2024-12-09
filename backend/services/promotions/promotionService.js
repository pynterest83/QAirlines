const Promotion = require('../../models/schemas/Promotion');

function generatePromotionID() {
    const prefix = 'PR';
    const randomPart = Math.random().toString(36).substring(2, 10).toUpperCase();
    return `${prefix}${randomPart}`;
}

async function createPromotion(data) {
    const PromotionID = generatePromotionID(); // Sinh PromotionID tại đây
    return await Promotion.create({ ...data, PromotionID });
}

async function getPromotions() {
    return await Promotion.findAll();
}

async function getPromotionById(PromotionID) {
    return await Promotion.findByPk(PromotionID);
}

async function updatePromotion(PromotionID, data) {
    const promotion = await getPromotionById(PromotionID);
    if (!promotion) throw new Error('Promotion not found');
    return await promotion.update(data);
}

async function deletePromotion(PromotionID) {
    console.log('PromotionID nhận được:', PromotionID);
    const promotion = await getPromotionById(PromotionID);
    if (!promotion) throw new Error('Promotion not found');
    return await promotion.destroy();
}

module.exports = {
    createPromotion,
    getPromotions,
    updatePromotion,
    deletePromotion
};
