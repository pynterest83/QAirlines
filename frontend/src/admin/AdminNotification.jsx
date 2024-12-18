import React, { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../Server';
import AdminNavigation from './components/AdminNavigation';
import ScrollToTop from "../scroll.jsx";

const AdminNotification = () => {
    const token = localStorage.getItem("token");
    if (!token) {
        return <Navigate to="/adminLogin" />;
    }

    const [notifications, setNotifications] = useState([]);
    const [title, setTitle] = useState("");
    const [content, setContent] = useState("");
    const [amount, setAmount] = useState("");
    const [editMode, setEditMode] = useState(false);
    const [editId, setEditId] = useState(null);

    useEffect(() => {
        const fetchNotifications = async () => {
            const response = await fetch(`${Server}promotions/list`);
            if (response.ok) {
                const data = await response.json();
                setNotifications(data);
            } else {
                console.error('Failed to fetch notifications:', response.statusText);
            }
        };

        fetchNotifications();
    }, [token]);

    const createPromotion = async (promotionDetails) => {
        const response = await fetch(`${Server}promotions/create`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(promotionDetails)
        });

        if (response.ok) {
            const data = await response.json();
            console.log('Promotion created:', data);
            setNotifications([...notifications, data.promotion]);
        } else {
            console.error('Failed to create promotion:', response.statusText);
        }
    };

    const updatePromotion = async (promotionID, promotionDetails) => {
        const response = await fetch(`${Server}promotions/update/${promotionID}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(promotionDetails)
        });

        if (response.ok) {
            const data = await response.json();
            console.log('Promotion updated:', data);
            setNotifications(notifications.map(notification => 
                notification.PromotionID === promotionID ? data.promotion : notification
            ));
            setEditMode(false);
            setEditId(null);
            setTitle("");
            setContent("");
            setAmount("");
        } else {
            console.error('Failed to update promotion:', response.statusText);
        }
    };

    const handleDelete = async (id) => {
        const response = await fetch(`${Server}promotions/delete/${id}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (response.ok) {
            setNotifications(notifications.filter(notification => notification.PromotionID !== id));
        } else {
            console.error('Failed to delete promotion:', response.statusText);
        }
    };

    const handleEdit = (id) => {
        const promotion = notifications.find(notification => notification.PromotionID === id);
        setTitle(promotion.Title);
        setContent(promotion.Content);
        setAmount(promotion.Amount);
        setEditMode(true);
        setEditId(id);
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        const promotionDetails = {
            Title: title,
            Content: content,
            Amount: parseInt(amount)
        };
        if (editMode) {
            updatePromotion(editId, promotionDetails);
        } else {
            createPromotion(promotionDetails);
        }
    };

    return (
        <div className="relative">
            <ScrollToTop />
            <AdminNavigation />
            <div className="p-4">
            <h2 className="text-xl font-bold mb-6">Add New Notification</h2>
            <form onSubmit={handleSubmit} className="bg-white p-6 rounded-lg shadow-md mb-8">
                <div className="mb-4">
                    <label className="block text-gray-700">Title:</label>
                    <input
                        type="text"
                        value={title}
                        onChange={(e) => setTitle(e.target.value)}
                        required
                        className="mt-1 p-2 w-full border rounded-md"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700">Content:</label>
                    <textarea
                        value={content}
                        onChange={(e) => setContent(e.target.value)}
                        required
                        className="mt-1 p-2 w-full border rounded-md"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700">Amount:</label>
                    <input
                        type="number"
                        value={amount}
                        onChange={(e) => setAmount(e.target.value)}
                        required
                        className="mt-1 p-2 w-full border rounded-md"
                    />
                </div>
                <button type="submit" className="gradient-button w-full text-white px-4 py-2 rounded-md">
                    {editMode ? "Update Promotion" : "Create Promotion"}
                </button>
            </form>
            <h3 className="text-lg font-bold mb-4">Manage Notifications</h3>
            <div className="overflow-x-auto">
                <table className="table-auto w-full bg-white rounded-lg shadow-md">
                    <thead>
                        <tr className="bg-gray-200">
                            <th className="px-4 py-2">ID</th>
                            <th className="px-4 py-2">Title</th>
                            <th className="px-4 py-2">Content</th>
                            <th className="px-4 py-2">Amount</th>
                            <th className="px-4 py-2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {notifications.map(notification => (
                            <tr key={notification.PromotionID} className="border-t">
                                <td className="px-4 py-2">{notification.PromotionID}</td>
                                <td className="px-4 py-2">{notification.Title}</td>
                                <td className="px-4 py-2">{notification.Content}</td>
                                <td className="px-4 py-2">{notification.Amount}</td>
                                <td className="px-4 py-2">
                                    <button 
                                        onClick={() => handleEdit(notification.PromotionID)} 
                                        className="bg-yellow-500 text-white px-2 py-1 rounded-md mr-2"
                                    >
                                        Edit
                                    </button>
                                    <button 
                                        onClick={() => handleDelete(notification.PromotionID)} 
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
}

export default AdminNotification;