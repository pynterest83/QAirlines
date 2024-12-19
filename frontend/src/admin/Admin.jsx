import React, { useState, useEffect } from "react";
import { Navigate } from "react-router-dom";
import { Server } from "../Server.js";
import StatsCard from "../admin/components/StatsCard.jsx";
import Graph from "../admin/components/Graph.jsx"
import FlightInDay from "../admin/components/FlightInDay.jsx"
import AdminNavigation from "../admin/components/AdminNavigation.jsx"
import ScrollToTop from "../scroll.jsx";

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

    const [bookingChartData, setBookingChartData] = useState(null);
    const [incomeChartData, setIncomeChartData] = useState(null);
    const [totalBookings, setTotalBookings] = useState(0);
    const [totalIncome, setTotalIncome] = useState(0);
    const [availableAirlines, setAvailableAirlines] = useState(0);
    const [totalFlights, setTotalFlights] = useState(0);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    // Get today's date in the format 'YYYY-MM-DD'
    const today = new Date().toISOString().split('T')[0];

    useEffect(() => {
        const fetchStatistics = async () => {
            try {
                const bookingResponse = await fetch(`${Server}statistics/booking/monthly?year=2024`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                const incomeResponse = await fetch(`${Server}statistics/income/monthly?year=2024`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                const aircraftResponse = await fetch(`${Server}aircrafts/list`, {
                    headers: {
                      Authorization: `Bearer ${token}`,
                    },
                });
                const flightResponse = await fetch(`${Server}flights/list`, {
                    headers: {
                      Authorization: `Bearer ${token}`,
                    },
                });

                if (bookingResponse.status === 401 || incomeResponse.status === 401 || aircraftResponse.status === 401 || flightResponse.status === 401) {
                    localStorage.removeItem('token');
                    window.location.href = '/adminLogin';
                    return;
                }

                const bookingData = await bookingResponse.json();
                const incomeData = await incomeResponse.json();
                const aircraftData = await aircraftResponse.json();
                const flightData = await flightResponse.json();

                if (bookingData && bookingData.monthlyStatistics && bookingData.monthlyStatistics.length > 0) {
                    const months = bookingData.monthlyStatistics.map((item) => item.month);
                    const bookingCounts = bookingData.monthlyStatistics.map((item) => item.bookingCount);

                    setBookingChartData({
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

                    const totalBookings = bookingData.monthlyStatistics.reduce((sum, month) => sum + month.bookingCount, 0);
                    setTotalBookings(totalBookings);
                } else {
                    setError('No booking data available');
                }

                if (incomeData && incomeData.monthlyStatistics && incomeData.monthlyStatistics.length > 0) {
                    const months = incomeData.monthlyStatistics.map((item) => item.month);
                    const incomes = incomeData.monthlyStatistics.map((item) => item.totalIncome);

                    setIncomeChartData({
                        labels: months,
                        datasets: [
                            {
                                label: 'Income per Month',
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
                                data: incomes,
                            },
                        ],
                    });

                    const totalIncome = incomeData.monthlyStatistics.reduce((sum, month) => sum + month.totalIncome, 0);
                    setTotalIncome(totalIncome);
                } else {
                    setError('No income data available');
                }
                const availableAirlines = aircraftData.length;
                const totalFlights = flightData.flights.length;
                setAvailableAirlines(availableAirlines);
                setTotalFlights(totalFlights);
                setLoading(false);
            } catch (error) {
                setError(error.message);
                setLoading(false);
            }
        };

        fetchStatistics();
    }, [token]);

    if (loading) {
        return <div className="text-center text-gray-600 mt-10">Loading...</div>;
    }

    if (error) {
        return <div className="text-center text-red-600 mt-10">Error: {error}</div>;
    }

    return (
        <div className="relative bg-gray-100 min-h-screen">
            <ScrollToTop />
            <AdminNavigation />
            
            {/* StatsCards Section */}
            <div className="bg-white shadow-lg rounded-lg p-6 max-w-5xl mx-auto mt-6">
                <StatsCard totalBookings={totalBookings} totalIncome={totalIncome} availableAirlines={availableAirlines} totalFlights={totalFlights}/>
            </div>

            {/* Booking Graph Section */}
            <div className="bg-white shadow-lg rounded-lg p-6 max-w-5xl mx-auto mt-6">
                <h2 className="text-2xl font-bold mb-4">Monthly Bookings</h2>
                {bookingChartData && <Graph chartData={bookingChartData} />}
            </div>

            {/* Income Graph Section */}
            <div className="bg-white shadow-lg rounded-lg p-6 max-w-5xl mx-auto mt-6">
                <h2 className="text-2xl font-bold mb-4">Monthly Income</h2>
                {incomeChartData && <Graph chartData={incomeChartData} />}
            </div>

            {/* FlightInDay Section */}
            <div className="bg-white shadow-lg rounded-lg p-6 max-w-5xl mx-auto mt-6">
                <FlightInDay date={today} />
            </div>
        </div>
    );
}

export default Admin;