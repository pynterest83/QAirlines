import { Server } from '../../Server';

const fetchBannerData = async () => {
    try {
        const response = await fetch(`${Server}/banners/list`);
        if (!response.ok) {
            throw new Error('Failed to fetch banner data');
        }
        const data = await response.json();
        return data.banners.map(banner => ({
            title: banner.Title,
            description: banner.Description,
            image: banner.ImageURL,
            discount_title: banner.DiscountTitle,
            discount_description: banner.DiscountDescription,
            alt: "Image"
        }));
    } catch (error) {
        console.error(error);
        return [];
    }
};

export const BannerData = await fetchBannerData();