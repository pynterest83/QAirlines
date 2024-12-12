import { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../Server';
import AdminNavigation from './components/AdminNavigation';

const AdminFlights = () => {
    const token = localStorage.getItem("token");
    useEffect(() => {
        fetchFlights().then();
    }, [token]);

    const [flights, setFlights] = useState([]);
    const [newFlight, setNewFlight] = useState({
        Status: "Scheduled",
        DepTime: "",
        ArrTime: "",
        BoardingTime: "",
        DepID: "",
        DestID: "",
        AircraftID: "",
        ticketPrices: {
            Economy: 0,
            Business: 0,
            First: 0
        }
    });
    const [editFlight, setEditFlight] = useState(null); // Initialize editFlight to null

    const fetchFlights = async () => {
        const response = await fetch(`${Server}flights/list`);
        if (response.ok) {
            const data = await response.json();
            setFlights(data.flights);
        } else {
            console.error('Failed to fetch flights:', response.statusText);
        }
    };

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
            setFlights([...flights, data.flight]);
            setNewFlight({
                Status: "Scheduled",
                DepTime: "",
                ArrTime: "",
                BoardingTime: "",
                DepID: "",
                DestID: "",
                AircraftID: "",
                ticketPrices: {
                    Economy: 0,
                    Business: 0,
                    First: 0
                }
            });
        } else {
            console.error('Failed to create flight:', response.statusText);
        }
    };

    const updateFlight = async (flightDetails) => {
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
            setFlights(flights.map(flight => flight.FlightID === data.flight.flightID ? data.flight : flight));
            setEditFlight(null); // Reset editFlight after successful update
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

    const handleEditSave = () => {
        const updatedFlight = {
            flightID: editFlight.FlightID,
            DepTime: editFlight.DepTime,
            BoardingTime: editFlight.BoardingTime,
            Status: editFlight.Status,
            DestID: editFlight.DestID,
            ArrTime: editFlight.ArrTime,
            DepID: editFlight.DepID,
            AircraftID: editFlight.AircraftID
        };
        updateFlight(updatedFlight).then(() => {
            window.location.reload(); 
        });
    };

    const handleNewFlightChange = (e, field) => {
        if (field !== "Economy" && field !== "Business" && field !== "First")
            setNewFlight({
                ...newFlight,
                [field]: e.target.value
            });
        else setNewFlight({
            ...newFlight,
            ticketPrices: {
                ...newFlight.ticketPrices,
                [field]: e.target.value
            }
        })
    };

    const handleNewFlightSubmit = (e) => {
        e.preventDefault();
        createFlight(newFlight).then();
    };

    const formatDateTime = (dateTime) => {
        const date = new Date(dateTime);
        const formattedDate = date.toLocaleDateString();
        const formattedTime = date.toLocaleTimeString();
        return { formattedDate, formattedTime };
    };

    if (!token) {
        return <Navigate to="/adminLogin" />;
    }
    return (
        <div className="relative">
            <AdminNavigation />
            <div className="p-4">
                <h2 className="text-xl font-bold mb-6">Add New Flight</h2>
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
                            <option value="Delayed">Delayed</option>
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
                    <div className="mb-4">
                        <label className="block text-gray-700">Economy seats price:</label>
                        <input
                            type="text"
                            value={newFlight.ticketPrices.Economy}
                            onChange={(e) => handleNewFlightChange(e, 'Economy')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Business seats price:</label>
                        <input
                            type="text"
                            value={newFlight.ticketPrices.Business}
                            onChange={(e) => handleNewFlightChange(e, 'Business')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">First class price:</label>
                        <input
                            type="text"
                            value={newFlight.ticketPrices.First}
                            onChange={(e) => handleNewFlightChange(e, 'First')}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <button type="submit" className="w-full gradient-button text-white px-4 py-2 rounded-md">
                        Create Flight
                    </button>
                </form>
                <h3 className="text-lg font-bold mb-4">Manage Flights</h3>
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
                                                flight.FlightID 
                                            ) : (
                                                flight.FlightID
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {/* Correctly check if editFlight is not null and its FlightID matches */}
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                <select
                                                    value={editFlight.Status}
                                                    onChange={(e) => handleEditChange(e, 'Status')}
                                                    required
                                                    className="mt-1 p-2 w-full border rounded-md"
                                                >
                                                    <option value="Scheduled">Scheduled</option>
                                                    <option value="Delayed">Delayed</option>
                                                    <option value="In-Flight">In-Flight</option>
                                                    <option value="Arrived">Arrived</option>
                                                </select>
                                            ) : (
                                                flight.Status
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                flight.DepID 
                                            ) : (
                                                flight.DepID
                                            )}
                                        </td>
                                        <td className="px-4 py-2">
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                flight.DestID 
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
                                            {/* Conditionally render based on editFlight */}
                                            {editFlight && editFlight.FlightID === flight.FlightID ? (
                                                <button
                                                    onClick={handleEditSave}
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