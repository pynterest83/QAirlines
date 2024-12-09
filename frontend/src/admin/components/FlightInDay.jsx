import React, { useEffect, useState } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../../Server';

function FlightInDay({ date }) {
    const [flights, setFlights] = useState([]);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);
    const [expandedFlight, setExpandedFlight] = useState(null);
    const [passengerData, setPassengerData] = useState({});
    const [loadingPassengers, setLoadingPassengers] = useState(false);

    const token = localStorage.getItem('token');
    if (!token) {
        return <Navigate to="/adminLogin" />;
    }

    useEffect(() => {
        fetch(`${Server}offers/by-date?date=${date}`, {
            headers: {
                Authorization: `Bearer ${token}`,
            },
        })
            .then((response) => {
                if (!response.ok) {
                    throw new Error('Error fetching flights');
                }
                return response.json();
            })
            .then((data) => {
                if (data && data.flights) {
                    setFlights(data.flights);
                } else {
                    setError('No flights available for this date');
                }
                setLoading(false);
            })
            .catch((err) => {
                console.error('Error:', err);
                setError('Error fetching data');
                setLoading(false);
            });
    }, [date, token]);

    const togglePassengerDetails = (flightId) => {
        if (expandedFlight === flightId) {
            setExpandedFlight(null); // Collapse if already expanded
        } else {
            setExpandedFlight(flightId); // Expand the clicked flight
            if (!passengerData[flightId]) {
                setLoadingPassengers(true);
                fetch(`${Server}flights/${flightId}/passengers`, {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                })
                    .then((response) => {
                        if (!response.ok) {
                            throw new Error('Error fetching passenger details');
                        }
                        return response.json();
                    })
                    .then((data) => {
                        setPassengerData((prev) => ({
                            ...prev,
                            [flightId]: data,
                        }));
                        setLoadingPassengers(false);
                    })
                    .catch((err) => {
                        console.error('Error fetching passengers:', err);
                        setLoadingPassengers(false);
                    });
            }
        }
    };

    if (loading) {
        return <div className="text-center text-gray-600 mt-10">Loading...</div>;
    }

    if (error) {
        return <div className="text-center text-red-600 mt-10">Error: {error}</div>;
    }

    return (
        <div className="overflow-x-auto">
            <h2 className="text-2xl font-bold mb-6 text-center text-gray-800">Flights for {date}</h2>
            <table className="table-auto w-full border-collapse rounded-lg overflow-hidden shadow-lg">
                <thead className="bg-purple-700 text-white">
                    <tr>
                        <th className="px-4 py-3 text-left">Flight ID</th>
                        <th className="px-4 py-3 text-left">Status</th>
                        <th className="px-4 py-3 text-left">Departure</th>
                        <th className="px-4 py-3 text-left">Destination</th>
                        <th className="px-4 py-3 text-left">Departure Time</th>
                        <th className="px-4 py-3 text-left">Arrival Time</th>
                        <th className="px-4 py-3 text-left">Aircraft Model</th>
                    </tr>
                </thead>
                <tbody className="bg-white">
                    {flights.map((flight) => (
                        <React.Fragment key={flight.FlightID}>
                            <tr
                                className="hover:bg-gray-100 border-b transition duration-300 ease-in-out cursor-pointer"
                                onClick={() => togglePassengerDetails(flight.FlightID)}
                            >
                                <td className="px-4 py-3 text-gray-700">{flight.FlightID}</td>
                                <td className="px-4 py-3 text-gray-700">{flight.Status}</td>
                                <td className="px-4 py-3 text-gray-700">{flight.DepID}</td>
                                <td className="px-4 py-3 text-gray-700">{flight.DestID}</td>
                                <td className="px-4 py-3 text-gray-700">
                                    {new Date(flight.DepTime).toLocaleString()}
                                </td>
                                <td className="px-4 py-3 text-gray-700">
                                    {new Date(flight.ArrTime).toLocaleString()}
                                </td>
                                <td className="px-4 py-3 text-gray-700">{flight.Aircraft.Model}</td>
                            </tr>
                            {expandedFlight === flight.FlightID && (
                                <tr>
                                    <td colSpan="7" className="px-4 py-3 bg-gray-50">
                                        {loadingPassengers ? (
                                            <div className="text-center text-gray-500">
                                                Loading passengers...
                                            </div>
                                        ) : passengerData[flight.FlightID] &&
                                          passengerData[flight.FlightID].length > 0 ? (
                                            <table className="table-auto w-full border-collapse mt-3">
                                                <thead className="bg-gray-200">
                                                    <tr>
                                                        <th className="px-4 py-2 text-left">Ticket ID</th>
                                                        <th className="px-4 py-2 text-left">First Name</th>
                                                        <th className="px-4 py-2 text-left">Last Name</th>
                                                        <th className="px-4 py-2 text-left">Gender</th>
                                                        <th className="px-4 py-2 text-left">DOB</th>
                                                        <th className="px-4 py-2 text-left">Email</th>
                                                        <th className="px-4 py-2 text-left">Phone</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    {passengerData[flight.FlightID].map((passenger) => (
                                                        <tr key={passenger.TicketID} className="hover:bg-gray-100">
                                                            <td className="px-4 py-2">{passenger.TicketID}</td>
                                                            <td className="px-4 py-2">
                                                                {passenger.Passenger.FirstName}
                                                            </td>
                                                            <td className="px-4 py-2">
                                                                {passenger.Passenger.LastName}
                                                            </td>
                                                            <td className="px-4 py-2">
                                                                {passenger.Passenger.Gender}
                                                            </td>
                                                            <td className="px-4 py-2">
                                                                {new Date(passenger.Passenger.DOB).toLocaleDateString()}
                                                            </td>
                                                            <td className="px-4 py-2">
                                                                {passenger.Passenger.Email || 'N/A'}
                                                            </td>
                                                            <td className="px-4 py-2">
                                                                {passenger.Passenger.PhoneNumber || 'N/A'}
                                                            </td>
                                                        </tr>
                                                    ))}
                                                </tbody>
                                            </table>
                                        ) : (
                                            <div className="text-center text-gray-500">
                                                No passengers found for this flight.
                                            </div>
                                        )}
                                    </td>
                                </tr>
                            )}
                        </React.Fragment>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default FlightInDay;
