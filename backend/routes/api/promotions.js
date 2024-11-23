const express = require('express');
const router = express.Router();
const promotionController = require('../../controllers/promotionController');
const validate = require('../../middlewares/validateInput');
const authenticateUser = require('../../middlewares/authenticateUser');
const checkAdmin = require('../../middlewares/checkAdmin'); // Import middleware kiểm tra quyền
const {
    createPromotionSchema,
    updatePromotionSchema
} = require('../../validations/promotionValidation');

router.post('/create', authenticateUser, checkAdmin, validate(createPromotionSchema), promotionController.createPromotion);
router.get('/list', authenticateUser, checkAdmin, promotionController.getPromotions);
router.put('/update/:PromotionID', authenticateUser, checkAdmin, validate(updatePromotionSchema), promotionController.updatePromotion);
router.delete('/delete/:PromotionID', authenticateUser, checkAdmin, promotionController.deletePromotion);

module.exports = router;
