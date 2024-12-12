import React, { useEffect, useState } from 'react';
import AdminNavigation from './components/AdminNavigation';
import { Server } from '../Server';
import { Navigate } from 'react-router-dom';

import Graph from './components/Graph';
import StatsCards from './components/StatsCard';
import FlightInDay from './components/FlightInDay';

import {
    Chart as ChartJS,
    BarElement,
    CategoryScale,
    LinearScale,
    Title,
    Tooltip,
    Legend,
} from 'chart.js';

ChartJS.register(BarElement, CategoryScale, LinearScale, Title, Tooltip, Legend);

function Admin() {
        const token = localStorage.getItem('token');
        if (!token) {
            return <Navigate to="/adminLogin" />;
        }

    const [chartData, setChartData] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    // Get today's date in the format 'YYYY-MM-DD'
    const today = new Date().toISOString().split('T')[0];

    useEffect(() => {
        fetch(`${Server}statistics/booking/monthly?year=2024`, {
            headers: {
                Authorization: `Bearer ${token}`,
            },
        })
            .then((response) => {
                if (response.status === 401) {
                    localStorage.removeItem('token');
                    window.location.href = '/adminLogin';
                    return null;
                }
                return response.json();
            })
            .then((data) => {
                if (data && data.monthlyStatistics && data.monthlyStatistics.length > 0) {
                    const months = data.monthlyStatistics.map((item) => item.month);
                    const bookingCounts = data.monthlyStatistics.map((item) => item.bookingCount);

                    setChartData({
                        labels: months,
                        datasets: [
                            {
                                label: 'Bookings per Month',
                                backgroundColor: [
                                    '#3e95cd',
                                    '#8e5ea2',
                                    '#3cba9f',
                                    '#e8c3b9',
                                    '#c45850',
                                    '#3e95cd',
                                    '#8e5ea2',
                                    '#3cba9f',
                                    '#e8c3b9',
                                    '#c45850',
                                    '#3e95cd',
                                    '#8e5ea2',
                                ],
                                data: bookingCounts,
                            },
                        ],
                    });
                } else {
                    setError('No booking data available');
                }
                setLoading(false);
            })
            .catch((error) => {
                console.error('Error fetching data:', error);
                setError('Error fetching data');
                setLoading(false);
            });
    }, []);

    if (loading) {
        return <div className="text-center text-gray-600 mt-10">Loading...</div>;
    }

    if (error) {
        return <div className="text-center text-red-600 mt-10">Error: {error}</div>;
    }

    return (
        <div className="relative bg-gray-100 min-h-screen">
            <AdminNavigation />
            
            {/* StatsCards Section */}
            <div className="bg-white shadow-lg rounded-lg p-6 max-w-5xl mx-auto mt-6">
                <StatsCards />
            </div>

            {/* Graph Section */}
            <div className="bg-white shadow-lg rounded-lg p-6 max-w-5xl mx-auto mt-6">
                <h2 className="text-2xl font-bold mb-4">Monthly Bookings</h2>
                {chartData && <Graph chartData={chartData} />}
            </div>

            {/* FlightInDay Section */}
            <div className="bg-white shadow-lg rounded-lg p-6 max-w-5xl mx-auto mt-6">
                <FlightInDay date={today} />
            </div>
        </div>
    );
}

export default Admin;