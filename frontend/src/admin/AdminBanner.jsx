import React, { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../Server';
import AdminNavigation from './components/AdminNavigation';
import airplaneLoader from '../assets/images/airplaneLoader.gif';
import ScrollToTop from "../scroll.jsx";

const AdminBanner = () => {
    const token = localStorage.getItem("token");
    useEffect(() => {
        fetchBanners().then();
    }, [token]);

    const [banners, setBanners] = useState([]);
    const [newBanner, setNewBanner] = useState({
        Title: "",
        Description: "",
        DiscountTitle: "",
        DiscountDescription: "",
        image: null
    });
    const [editBanner, setEditBanner] = useState(null);

    const fetchBanners = async () => {
        const response = await fetch(`${Server}banners/list`);
        if (response.ok) {
            const data = await response.json();
            setBanners(data.banners);
        } else {
            console.error('Failed to fetch banners:', response.statusText);
        }
    };

    const createBanner = async (bannerDetails) => {
        const formData = new FormData();
        for (const key in bannerDetails) {
            formData.append(key, bannerDetails[key]);
        }

        const response = await fetch(`${Server}banners/create`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`
            },
            body: formData
        });

        if (response.ok) {
            const data = await response.json();
            setBanners([...banners, data.result]);
            setNewBanner({
                Title: "",
                Description: "",
                DiscountTitle: "",
                DiscountDescription: "",
                image: null
            });
        } else {
            console.error('Failed to create banner:', response.statusText);
        }
    };

    const updateBanner = async (bannerDetails) => {
        const formData = new FormData();
        for (const key in bannerDetails) {
            formData.append(key, bannerDetails[key]);
        }

        const response = await fetch(`${Server}banners/edit`, {
            method: 'PUT',
            headers: {
                'Authorization': `Bearer ${token}`
            },
            body: formData
        });

        if (response.ok) {
            const data = await response.json();
            setBanners(banners.map(banner => banner.BannerID === data.banner.BannerID ? data.banner : banner));
            setEditBanner(null);
        } else {
            console.error('Failed to update banner:', response.statusText);
        }
    };

    const handleDelete = async (id) => {
        const response = await fetch(`${Server}banners/delete/${id}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (response.ok) {
            setBanners(banners.filter(banner => banner.BannerID !== id));
        } else {
            console.error('Failed to delete banner:', response.statusText);
        }
    };

    const handleEditChange = (e, field) => {
        setEditBanner({
            ...editBanner,
            [field]: e.target.value
        });
    };

    const handleEditSave = () => {
        const updatedBanner = {
            BannerID: editBanner.BannerID,
            Title: editBanner.Title,
            Description: editBanner.Description,
            DiscountTitle: editBanner.DiscountTitle,
            DiscountDescription: editBanner.DiscountDescription,
            image: editBanner.image
        };
        updateBanner(updatedBanner).then(() => {
            window.location.reload();
        });
    };

    const handleNewBannerChange = (e, field) => {
        if (field === "image") {
            setNewBanner({
                ...newBanner,
                [field]: e.target.files[0]
            });
        } else {
            setNewBanner({
                ...newBanner,
                [field]: e.target.value
            });
        }
    };

    const handleNewBannerSubmit = (e) => {
        e.preventDefault();
        createBanner(newBanner).then();
    };

    if (!token) {
        return <Navigate to="/adminLogin" />;
    }

    return (
        <div className="relative">
            <ScrollToTop />
            <AdminNavigation />
            <div className="p-4">
                <h2 className="text-xl font-bold mb-6">Add New Banner</h2>
                <form onSubmit={handleNewBannerSubmit} className="bg-white p-6 rounded-lg shadow-md mb-8">
                    <div className="mb-4">
                        <label className="block text-gray-700">Title:</label>
                        <input
                            type="text"
                            value={newBanner.Title}
                            onChange={(e) => handleNewBannerChange(e, 'Title')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Description:</label>
                        <input
                            type="text"
                            value={newBanner.Description}
                            onChange={(e) => handleNewBannerChange(e, 'Description')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Discount Title:</label>
                        <input
                            type="text"
                            value={newBanner.DiscountTitle}
                            onChange={(e) => handleNewBannerChange(e, 'DiscountTitle')}
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Discount Description:</label>
                        <input
                            type="text"
                            value={newBanner.DiscountDescription}
                            onChange={(e) => handleNewBannerChange(e, 'DiscountDescription')}
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Image:</label>
                        <input
                            type="file"
                            onChange={(e) => handleNewBannerChange(e, 'image')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <button type="submit" className="w-full gradient-button text-white px-4 py-2 rounded-md">
                        Create Banner
                    </button>
                </form>
                <h3 className="text-lg font-bold mb-4">Manage Banners</h3>
                <div className="overflow-x-auto">
                    <table className="table-auto w-full bg-white rounded-lg shadow-md">
                        <thead>
                        <tr className="bg-gray-200">
                            <th className="px-4 py-2">Banner ID</th>
                            <th className="px-4 py-2">Title</th>
                            <th className="px-4 py-2">Description</th>
                            <th className="px-4 py-2">Discount Title</th>
                            <th className="px-4 py-2">Discount Description</th>
                            <th className="px-4 py-2">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                            {banners.map(banner => (
                                <tr key={banner.BannerID} className="border-t">
                                    <td className="px-4 py-2">
                                        {editBanner && editBanner.BannerID === banner.BannerID ? (
                                            banner.BannerID
                                        ) : (
                                            banner.BannerID
                                        )}
                                    </td>
                                    <td className="px-4 py-2">
                                        {editBanner && editBanner.BannerID === banner.BannerID ? (
                                            <input
                                                type="text"
                                                value={editBanner.Title}
                                                onChange={(e) => handleEditChange(e, 'Title')}
                                                className="mt-1 p-2 w-full border rounded-md"
                                            />
                                        ) : (
                                            banner.Title
                                        )}
                                    </td>
                                    <td className="px-4 py-2">
                                        {editBanner && editBanner.BannerID === banner.BannerID ? (
                                            <input
                                                type="text"
                                                value={editBanner.Description}
                                                onChange={(e) => handleEditChange(e, 'Description')}
                                                className="mt-1 p-2 w-full border rounded-md"
                                            />
                                        ) : (
                                            banner.Description
                                        )}
                                    </td>
                                    <td className="px-4 py-2">
                                        {editBanner && editBanner.BannerID === banner.BannerID ? (
                                            <input
                                                type="text"
                                                value={editBanner.DiscountTitle}
                                                onChange={(e) => handleEditChange(e, 'DiscountTitle')}
                                                className="mt-1 p-2 w-full border rounded-md"
                                            />
                                        ) : (
                                            banner.DiscountTitle
                                        )}
                                    </td>
                                    <td className="px-4 py-2">
                                        {editBanner && editBanner.BannerID === banner.BannerID ? (
                                            <input
                                                type="text"
                                                value={editBanner.DiscountDescription}
                                                onChange={(e) => handleEditChange(e, 'DiscountDescription')}
                                                className="mt-1 p-2 w-full border rounded-md"
                                            />
                                        ) : (
                                            banner.DiscountDescription
                                        )}
                                    </td>
                                    <td className="px-4 py-2">
                                        {editBanner && editBanner.BannerID === banner.BannerID ? (
                                            <button
                                                onClick={handleEditSave}
                                                className="bg-green-500 text-white px-2 py-1 rounded-md mr-2"
                                            >
                                                Save
                                            </button>
                                        ) : (
                                            <button
                                                onClick={() => setEditBanner(banner)}
                                                className="bg-yellow-500 text-white px-2 py-1 rounded-md mr-2"
                                            >
                                                Edit
                                            </button>
                                        )}
                                        <button
                                            onClick={() => handleDelete(banner.BannerID)}
                                            className="bg-red-500 text-white px-2 py-1 rounded-md"
                                        >
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default AdminBanner;