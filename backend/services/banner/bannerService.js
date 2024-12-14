const Banner = require('../../models/schemas/Banner');
const {storage} = require("../supabase/supabaseClient");

function generateBannerId() {
    const prefix = 'BN';
    const randomPart = Math.random().toString(36).substring(2, 10).toUpperCase();
    return `${prefix}${randomPart}`;
}

async function createBanner(banner) {
    const BannerID = generateBannerId();
    const transaction = await Banner.sequelize.transaction();
    let result;
    try {
        const image = banner.image;
        const imagePath = `${BannerID}/${image.name}`;
        const imageUpload = await storage
            .from('banner-files')
            .upload(imagePath, image.data, {
                contentType: image.mimetype,
                upsert: true,
            });
        if (imageUpload.error) throw imageUpload.error;
        const ImageURL = storage.from('banner-files').getPublicUrl(imagePath).data.publicUrl;
        result = await Banner.create(
            { ...banner, BannerID, ImageURL },
            { transaction }
        );

        await transaction.commit();
    } catch (error) {
        await transaction.rollback();
        throw error;
    }
    return result;
}

async function getBanners(ids) {
    console.log('Banner IDs:', ids);
    console.log('Is Banner defined:', !!Banner);
    if (ids.length === 0) {
        return await Banner.findAll();
    } else {
        return await Banner.findAll({
            where: {
                BannerID: ids
            }
        });
    }
}

async function editBanner(BannerID, data) {
    const banner = await Banner.findByPk(BannerID);
    if (!banner) throw new Error('Banner not found');
    const image = data.image;
    const transaction = await Banner.sequelize.transaction();
    try {
        if (image) {
            const imagePath = `${BannerID}/${image.name}`;
            const imageUpload = await storage
                .from('banner-files')
                .upload(imagePath, image.data, {
                    contentType: image.mimetype,
                    upsert: true,
                });
            if (imageUpload.error) throw imageUpload.error;
            data.ImageURL = storage.from('banner-files').getPublicUrl(imagePath).data.publicUrl;
        }
        await banner.update(data, { transaction });
        await transaction.commit();
    } catch (error) {
        await transaction.rollback();
        throw error;
    }
}

async function deleteBanner(BannerID) {
    const banner = await Banner.findByPk(BannerID);
    if (!banner) throw new Error('Banner not found');
    await banner.destroy();
}

module.exports = {
    createBanner,
    getBanners,
    editBanner,
    deleteBanner
}