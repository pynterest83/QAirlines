const {createBanner, getBanners, editBanner, deleteBanner} = require("../services/banner/bannerService");
exports.handleCreateBanner = async (req, res) => {
    try {
        const { Title, Description, DiscountTitle, DiscountDescription } = req.body;
        const image = req.files?.image;

        if (!image) {
            return res.status(400).json({ error: 'Image is required.' });
        }

        const bannerData = {
            Title,
            Description,
            DiscountTitle,
            DiscountDescription,
            image: {
                name: image.name,
                data: image.data,
                mimetype: image.mimetype,
            },
        };

        const result = await createBanner(bannerData);

        res.json({
            message: 'Banner created successfully',
            result
        });
    } catch (error) {
        console.error('Error during banner creation:', error.message);
        res.status(400).json({ error: error.message });
    }
}

exports.handleGetBanners = async (req, res) => {
    const bannerIds = req.query.bannerIds ? req.query.bannerIds.split(',') : [];
    try {
        const banners = await getBanners(bannerIds);
        return res.json({ banners });
    } catch (error) {
        console.error('Error during fetching banners:', error.message);
        return res.status(400).json({ error: error.message });
    }
}

exports.handleEditBanner = async (req, res) => {
    const { bannerID, ...updates } = req.body;
    try {
        const banner = await editBanner(bannerID, updates);
        res.json({
            message: 'Banner updated successfully',
            banner
        });
    } catch (error) {
        console.error('Error during banner update:', error.message);
        res.status(400).json({ error: error.message });
    }
}

exports.handleDeleteBanner = async (req, res) => {
    const { bannerID } = req.params;
    try {
        await deleteBanner(bannerID);
        res.json({
            message: 'Banner deleted successfully',
        });
    } catch (error) {
        console.error('Error during banner deletion:', error.message);
        res.status(400).json({ error: error.message });
    }
}