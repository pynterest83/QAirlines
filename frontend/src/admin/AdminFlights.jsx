import React, { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../Server';
import AdminNavigation from './components/AdminNavigation';

const AdminFlights = () => {
    const token = localStorage.getItem("token");
    if (!token) {
        return <Navigate to="/adminLogin" />;
    }

    const [flights, setFlights] = useState([]);
    const [newFlight, setNewFlight] = useState({
        Status: "Scheduled",
        DepTime: "",
        ArrTime: "",
        BoardingTime: "",
        DepID: "",
        DestID: "",
        AircraftID: ""
    });
    const [editFlight, setEditFlight] = useState({
        flightID: "",
        Status: "Scheduled",
        DepTime: "",
        ArrTime: "",
        BoardingTime: "",
        DepID: "",
        DestID: "",
        AircraftID: ""
    });

    const fetchFlights = async () => {
        const response = await fetch(`${Server}flights/list`);
        if (response.ok) {
            const data = await response.json();
            setFlights(data.flights);
        } else {
            console.error('Failed to fetch flights:', response.statusText);
        }
    };

    useEffect(() => {
        fetchFlights();
    }, [token]);

    const createFlight = async (flightDetails) => {
        const response = await fetch(`${Server}flights/create`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(flightDetails)
        });

        if (response.ok) {
            const data = await response.json();
            console.log('Flight created:', data);
            setFlights([...flights, data.flight]);
            setNewFlight({
                Status: "Scheduled",
                DepTime: "",
                ArrTime: "",
                BoardingTime: "",
                DepID: "",
                DestID: "",
                AircraftID: ""
            });
        } else {
            console.error('Failed to create flight:', response.statusText);
        }
    };

    const updateFlight = async (flightDetails) => {
        console.log('Updating flight:', flightDetails);
        const response = await fetch(`${Server}flights/update`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(flightDetails)
        });
    
        if (response.ok) {
            const data = await response.json();
            console.log('Flight updated:', data);
            setFlights(flights.map(flight => flight.flightID === data.flight.flightID ? data.flight : flight));
        } else {
            console.error('Failed to update flight:', response.statusText);
        }
    };

    const handleDelete = async (id) => {
        const response = await fetch(`${Server}flights/delete/${id}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (response.ok) {
            setFlights(flights.filter(flight => flight.FlightID !== id));
        } else {
            console.error('Failed to delete flight:', response.statusText);
        }
    };

    const handleEditChange = (e, field) => {
        setEditFlight({
            ...editFlight,
            [field]: e.target.value
        });
    };

    const handleEditSave = (flightID) => {
        const updatedFlight = {
            flightID: flightID,
            DepTime: editFlight.DepTime,
            BoardingTime: editFlight.BoardingTime,
            Status: editFlight.Status,
            DestID: editFlight.DestID
        };
        updateFlight(updatedFlight).then(() => {
            window.location.reload();
        });
    };

    const handleNewFlightChange = (e, field) => {
        setNewFlight({
            ...newFlight,
            [field]: e.target.value
        });
    };

    const handleNewFlightSubmit = (e) => {
        e.preventDefault();
        createFlight(newFlight);
    };

    const formatDateTime = (dateTime) => {
        const date = new Date(dateTime);
        const formattedDate = date.toLocaleDateString();
        const formattedTime = date.toLocaleTimeString();
        return { formattedDate, formattedTime };
    };

    return (
        <div className="relative">
            <AdminNavigation />
            <div className="p-4">
                <form onSubmit={handleNewFlightSubmit} className="bg-white p-6 rounded-lg shadow-md mb-8">
                    <div className="mb-4">
                        <label className="block text-gray-700">Status:</label>
                        <select
                            value={newFlight.Status}
                            onChange={(e) => handleNewFlightChange(e, 'Status')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        >
                            <option value="Scheduled">Scheduled</option>
                            <option value="Delaying">Delaying</option>
                            <option value="In-Flight">In-Flight</option>
                            <option value="Arrived">Arrived</option>
                        </select>
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Departure Time:</label>
                        <input
                            type="datetime-local"
                            value={newFlight.DepTime}
                            onChange={(e) => handleNewFlightChange(e, 'DepTime')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Arrival Time:</label>
                        <input
                            type="datetime-local"
                            value={newFlight.ArrTime}
                            onChange={(e) => handleNewFlightChange(e, 'ArrTime')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Boarding Time:</label>
                        <input
                            type="datetime-local"
                            value={newFlight.BoardingTime}
                            onChange={(e) => handleNewFlightChange(e, 'BoardingTime')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Departure ID:</label>
                        <input
                            type="text"
                            value={newFlight.DepID}
                            onChange={(e) => handleNewFlightChange(e, 'DepID')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Destination ID:</label>
                        <input
                            type="text"
                            value={newFlight.DestID}
                            onChange={(e) => handleNewFlightChange(e, 'DestID')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Aircraft ID:</label>
                        <input
                            type="text"
                            value={newFlight.AircraftID}
                            onChange={(e) => handleNewFlightChange(e, 'AircraftID')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <button type="submit" className="bg-blue-500 text-white px-4 py-2 rounded-md">
                        Create Flight
                    </button>
                </form>
                <div className="overflow-x-auto">
                    <table className="table-auto w-full bg-white rounded-lg shadow-md">
                        <thead>
                            <tr className="bg-gray-200">
                                <th className="px-4 py-2">Flight Number</th>
                                <th className="px-4 py-2">Status</th>
                                <th className="px-4 py-2">From</th>
                                <th className="px-4 py-2">To</th>
                                <th className="px-4 py-2">Boarding Time</th>
                                <th className="px-4 py-2">Departure Time</th>
                                <th className="px-4 py-2">Arrival Time</th>
                                <th className="px-4 py-2">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {flights.map(flight => {
                                const { formattedDate: boardingDate, formattedTime: boardingTime } = formatDateTime(flight.BoardingTime);
                                const { formattedDate: departureDate, formattedTime: departureTime } = formatDateTime(flight.DepTime);
                                const { formattedDate: arrivalDate, formattedTime: arrivalTime } = formatDateTime(flight.ArrTime);
                                return (
                                    <tr key={flight.FlightID} className="border-t">
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                flight.FlightID // Keep FlightID fixed
                                            ) : (
                                                flight.FlightID
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                <select
                                                    value={newFlight.Status}
                                                    onChange={(e) => handleNewFlightChange(e, 'Status')}
                                                    required
                                                    className="mt-1 p-2 w-full border rounded-md"
                                                >
                                                    <option value="Scheduled">Scheduled</option>
                                                    <option value="Delaying">Delaying</option>
                                                    <option value="In-Flight">In-Flight</option>
                                                    <option value="Arrived">Arrived</option>
                                                </select>
                                            ) : (
                                                flight.Status
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                flight.DepID // Keep DepID fixed
                                            ) : (
                                                flight.DepID
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                flight.DestID // Keep DestID fixed
                                            ) : (
                                                flight.DestID
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                <input
                                                    type="datetime-local"
                                                    value={editFlight.BoardingTime}
                                                    onChange={(e) => handleEditChange(e, 'BoardingTime')}
                                                    className="mt-1 p-2 w-full border rounded-md"
                                                />
                                            ) : (
                                                `${boardingDate} ${boardingTime}`
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                <input
                                                    type="datetime-local"
                                                    value={editFlight.DepTime}
                                                    onChange={(e) => handleEditChange(e, 'DepTime')}
                                                    className="mt-1 p-2 w-full border rounded-md"
                                                />
                                            ) : (
                                                `${departureDate} ${departureTime}`
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                <input
                                                    type="datetime-local"
                                                    value={editFlight.ArrTime}
                                                    onChange={(e) => handleEditChange(e, 'ArrTime')}
                                                    className="mt-1 p-2 w-full border rounded-md"
                                                />
                                            ) : (
                                                `${arrivalDate} ${arrivalTime}`
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                <button 
                                                    onClick={() => handleEditSave(flight.FlightID)} 
                                                    className="bg-green-500 text-white px-2 py-1 rounded-md mr-2"
                                                >
                                                    Save
                                                </button>
                                            ) : (
                                                <button 
                                                    onClick={() => setEditFlight(flight)} 
                                                    className="bg-yellow-500 text-white px-2 py-1 rounded-md mr-2"
                                                >
                                                    Edit
                                                </button>
                                            )}
                                            <button 
                                                onClick={() => handleDelete(flight.FlightID)} 
                                                className="bg-red-500 text-white px-2 py-1 rounded-md"
                                            >
                                                Delete
                                            </button>
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}

export default AdminFlights;