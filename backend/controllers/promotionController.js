const promotionService = require('../services/promotions/promotionService');

exports.createPromotion = async (req, res) => {
    try {
        const promotion = await promotionService.createPromotion(req.body);
        res.status(201).json({ message: 'Promotion created successfully', promotion });
    } catch (error) {
        console.error('Error creating promotion:', error.message);
        res.status(500).json({ error: 'An error occurred while creating the promotion' });
    }
};

exports.getPromotions = async (req, res) => {
    try {
        const promotions = await promotionService.getPromotions();
        res.status(200).json(promotions);
    } catch (error) {
        console.error('Error fetching promotions:', error.message);
        res.status(500).json({ error: 'An error occurred while fetching the promotions' });
    }
};

exports.updatePromotion = async (req, res) => {
    const { PromotionID } = req.params;
    try {
        const promotion = await promotionService.updatePromotion(PromotionID, req.body);
        res.status(200).json({ message: 'Promotion updated successfully', promotion });
    } catch (error) {
        console.error('Error updating promotion:', error.message);
        res.status(500).json({ error: error.message });
    }
};

exports.deletePromotion = async (req, res) => {
    const { PromotionID } = req.params;
    try {
        await promotionService.deletePromotion(PromotionID);
        res.status(200).json({ message: 'Promotion deleted successfully' });
    } catch (error) {
        console.error('Error deleting promotion:', error.message);
        res.status(500).json({ error: error.message });
    }
};