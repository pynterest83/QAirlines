const promotionService = require('../services/promotions/promotionService');

// Tạo mới thông tin
exports.createPromotion = async (req, res) => {
    try {
        const promotion = await promotionService.createPromotion(req.body);
        res.status(201).json({ message: 'Thông tin đã được tạo thành công', promotion });
    } catch (error) {
        console.error('Error creating promotion:', error.message);
        res.status(500).json({ error: 'Đã xảy ra lỗi khi tạo thông tin' });
    }
};

// Lấy danh sách thông tin
exports.getPromotions = async (req, res) => {
    try {
        const promotions = await promotionService.getPromotions();
        res.status(200).json(promotions);
    } catch (error) {
        console.error('Error fetching promotions:', error.message);
        res.status(500).json({ error: 'Đã xảy ra lỗi khi lấy danh sách thông tin' });
    }
};

// Cập nhật thông tin
exports.updatePromotion = async (req, res) => {
    const { PromotionID } = req.params;
    try {
        const promotion = await promotionService.updatePromotion(PromotionID, req.body);
        res.status(200).json({ message: 'Thông tin đã được cập nhật thành công', promotion });
    } catch (error) {
        console.error('Error updating promotion:', error.message);
        res.status(500).json({ error: error.message });
    }
};

// Xóa thông tin
exports.deletePromotion = async (req, res) => {
    const { PromotionID } = req.params;
    try {
        await promotionService.deletePromotion(PromotionID);
        res.status(200).json({ message: 'Thông tin đã được xóa thành công' });
    } catch (error) {
        console.error('Error deleting promotion:', error.message);
        res.status(500).json({ error: error.message });
    }
};
