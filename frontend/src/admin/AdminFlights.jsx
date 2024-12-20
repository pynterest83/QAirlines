import { useState, useEffect, useRef } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../Server';
import AdminNavigation from './components/AdminNavigation';
import ScrollToTop from "../scroll.jsx";
import cityList from "../airports.json";

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

    const [fromSuggestions, setFromSuggestions] = useState([]);
    const [toSuggestions, setToSuggestions] = useState([]);
    const fromInputRef = useRef(null);
    const toInputRef = useRef(null);

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

    const handleEditChange = (e, field) => {
        setEditFlight({
            ...editFlight,
            [field]: e.target.value
        });
    };

    const handleEditSave = () => {
        const updatedFlight = {};
        if (editFlight.DepTime !== flights.find(flight => flight.FlightID === editFlight.FlightID).DepTime) {
            updatedFlight.DepTime = editFlight.DepTime;
        }
        if (editFlight.BoardingTime !== flights.find(flight => flight.FlightID === editFlight.FlightID).BoardingTime) {
            updatedFlight.BoardingTime = editFlight.BoardingTime;
        }
        if (editFlight.Status !== flights.find(flight => flight.FlightID === editFlight.FlightID).Status) {
            updatedFlight.Status = editFlight.Status;
        }
        if (editFlight.DestID !== flights.find(flight => flight.FlightID === editFlight.FlightID).DestID) {
            updatedFlight.DestID = editFlight.DestID;
        }
        if (editFlight.ArrTime !== flights.find(flight => flight.FlightID === editFlight.FlightID).ArrTime) {
            updatedFlight.ArrTime = editFlight.ArrTime;
        }
        if (editFlight.DepID !== flights.find(flight => flight.FlightID === editFlight.FlightID).DepID) {
            updatedFlight.DepID = editFlight.DepID;
        }
        if (editFlight.AircraftID !== flights.find(flight => flight.FlightID === editFlight.FlightID).AircraftID) {
            updatedFlight.AircraftID = editFlight.AircraftID;
        }
        updatedFlight.flightID = editFlight.FlightID;

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
        const formattedDate = date.toISOString().split('T')[0]; // Keep the original date format
        const formattedTime = date.toLocaleTimeString('en-GB', { timeZone: 'UTC' }); // Convert time to GMT+0
        return { formattedDate, formattedTime };
    };

    const handleClickOutside = (event) => {
        if (fromInputRef.current && !fromInputRef.current.contains(event.target)) {
            setFromSuggestions([]);
        }
        if (toInputRef.current && !toInputRef.current.contains(event.target)) {
            setToSuggestions([]);
        }
    };

    useEffect(() => {
        document.addEventListener("mousedown", handleClickOutside);
        return () => {
            document.removeEventListener("mousedown", handleClickOutside);
        };
    }, []);

    const handleSuggestionClick = (city, field) => {
        handleNewFlightChange({ target: { value: city[0] }}, field);
        if (field === 'DepID') {
            setFromSuggestions([]);
        } else {
            setToSuggestions([]);
        }
    };

    const handleFromCityChange = (e) => {
        const value = e.target.value.toUpperCase();
        handleNewFlightChange(e, 'DepID');
        if (!value.length) {
            setFromSuggestions([]);
            return;
        }
        setFromSuggestions(
            cityList.filter((e) => e[0].startsWith(value))
        );
    };

    const handleToCityChange = (e) => {
        const value = e.target.value.toUpperCase();
        handleNewFlightChange(e, 'DestID');
        if (!value.length) {
            setToSuggestions([]);
            return;
        }
        setToSuggestions(
            cityList.filter((e) => e[0].startsWith(value))
        );
    };

    if (!token) {
        return <Navigate to="/adminLogin" />;
    }
    return (
        <div className="relative">
            <ScrollToTop />
            <AdminNavigation />
            <div className="p-4">
                <h2 className="text-xl font-bold mb-6">Add New Flight</h2>
                <form onSubmit={handleNewFlightSubmit} className="bg-white p-6 rounded-lg shadow-md mb-8 grid grid-cols-1 md:grid-cols-2 gap-4">
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
                    <div className="mb-4 relative" ref={fromInputRef}>
                        <label className="block text-gray-700">Departure ID:</label>
                        <input
                            type="text"
                            value={newFlight.DepID}
                            onChange={handleFromCityChange}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                        {fromSuggestions.length > 0 && (
                            <ul className="absolute z-10 w-full bg-white border rounded-md mt-1 max-h-60 overflow-auto">
                                {fromSuggestions.map((city, index) => (
                                    <li
                                        key={index}
                                        className="p-2 hover:bg-gray-200 cursor-pointer"
                                        onClick={() => handleSuggestionClick(city, 'DepID')}
                                    >
                                        <div className="font-bold">{city[0]}</div>
                                        <div className="text-sm">{city[2]}</div>
                                    </li>
                                ))}
                            </ul>
                        )}
                    </div>
                    <div className="mb-4 relative" ref={toInputRef}>
                        <label className="block text-gray-700">Destination ID:</label>
                        <input
                            type="text"
                            value={newFlight.DestID}
                            onChange={handleToCityChange}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                        {toSuggestions.length > 0 && (
                            <ul className="absolute z-10 w-full bg-white border rounded-md mt-1 max-h-60 overflow-auto">
                                {toSuggestions.map((city, index) => (
                                    <li
                                        key={index}
                                        className="p-2 hover:bg-gray-200 cursor-pointer"
                                        onClick={() => handleSuggestionClick(city, 'DestID')}
                                    >
                                        <div className="font-bold">{city[0]}</div>
                                        <div className="text-sm">{city[2]}</div>
                                    </li>
                                ))}
                            </ul>
                        )}
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
                    <button type="submit" className="w-full gradient-button text-white px-4 py-2 rounded-md col-span-1 md:col-span-2">
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