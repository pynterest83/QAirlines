const express = require('express');
const router = express.Router();
const bannerController = require('../../controllers/bannerController');
const validate = require("../../middlewares/validateInput");
const authenticateUser = require("../../middlewares/authenticateUser");
const checkAdmin = require("../../middlewares/checkAdmin");
const {createBannerSchema, editBannerSchema, deleteBannerSchema} = require("../../validations/bannerValidation");
const fileUpload = require('express-fileupload');

router.use(fileUpload());


router.post('/create', authenticateUser, checkAdmin, validate(createBannerSchema, "body"), bannerController.handleCreateBanner);
router.get('/list', bannerController.handleGetBanners);
router.put('/edit', authenticateUser, checkAdmin, validate(editBannerSchema, "body"), bannerController.handleEditBanner);
router.delete('/delete/:bannerID', authenticateUser, checkAdmin, validate(deleteBannerSchema, "params"), bannerController.handleDeleteBanner);

module.exports = router;