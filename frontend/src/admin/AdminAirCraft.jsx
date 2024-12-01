import React, { useState, useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { Server } from '../Server';
import AdminNavigation from './components/AdminNavigation';

const AdminAircraft = () => {
    const token = localStorage.getItem("token");
    if (!token) {
        return <Navigate to="/adminLogin" />;
    }

    const [aircrafts, setAircrafts] = useState([]);
    const [aircraftID, setAircraftID] = useState("");
    const [model, setModel] = useState("");
    const [manufacturer, setManufacturer] = useState("");
    const [capacity, setCapacity] = useState("");
    const [editMode, setEditMode] = useState(false);
    const [editId, setEditId] = useState(null);

    useEffect(() => {
        const fetchAircrafts = async () => {
            const response = await fetch(`${Server}aircrafts/list`);
            if (response.ok) {
                const data = await response.json();
                setAircrafts(data);
            } else {
                console.error('Failed to fetch aircrafts:', response.statusText);
            }
        };

        fetchAircrafts();
    }, [token]);

    const createAircraft = async (aircraftDetails) => {
        const response = await fetch(`${Server}aircrafts/create`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(aircraftDetails)
        });

        if (response.ok) {
            const data = await response.json();
            setAircrafts([...aircrafts, data.aircraft]);
        } else {
            console.error('Failed to create aircraft:', response.statusText);
        }
    };

    const updateAircraft = async (aircraftID, aircraftDetails) => {
        const response = await fetch(`${Server}aircrafts/update/${aircraftID}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(aircraftDetails)
        });

        if (response.ok) {
            const data = await response.json();
            setAircrafts(aircrafts.map(aircraft => 
                aircraft.AircraftID === aircraftID ? data.aircraft : aircraft
            ));
            setEditMode(false);
            setEditId(null);
            setAircraftID("");
            setModel("");
            setManufacturer("");
            setCapacity("");
        } else {
            console.error('Failed to update aircraft:', response.statusText);
        }
    };

    const handleDelete = async (id) => {
        const response = await fetch(`${Server}api/aircrafts/delete/${id}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (response.ok) {
            setAircrafts(aircrafts.filter(aircraft => aircraft.AircraftID !== id));
        } else {
            console.error('Failed to delete aircraft:', response.statusText);
        }
    };

    const handleEdit = (id) => {
        const aircraft = aircrafts.find(aircraft => aircraft.AircraftID === id);
        setAircraftID(aircraft.AircraftID);
        setModel(aircraft.Model);
        setManufacturer(aircraft.Manufacturer);
        setCapacity(aircraft.Capacity);
        setEditMode(true);
        setEditId(id);
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        const aircraftDetails = {
            AircraftID: aircraftID,
            Model: model,
            Manufacturer: manufacturer,
            Capacity: parseInt(capacity)
        };
        if (editMode) {
            updateAircraft(editId, aircraftDetails);
        } else {
            createAircraft(aircraftDetails);
        }
    };

    return (
        <div className="relative">
            <AdminNavigation />
            <div className="p-4">
                <form onSubmit={handleSubmit} className="bg-white p-6 rounded-lg shadow-md mb-8">
                    <div className="mb-4">
                        <label className="block text-gray-700">Aircraft ID:</label>
                        <input
                            type="text"
                            value={aircraftID}
                            onChange={(e) => setAircraftID(e.target.value)}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Model:</label>
                        <input
                            type="text"
                            value={model}
                            onChange={(e) => setModel(e.target.value)}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Manufacturer:</label>
                        <input
                            type="text"
                            value={manufacturer}
                            onChange={(e) => setManufacturer(e.target.value)}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Capacity:</label>
                        <input
                            type="number"
                            value={capacity}
                            onChange={(e) => setCapacity(e.target.value)}
                            required
                            className="mt-1 p-2 w-full border rounded-md"
                        />
                    </div>
                    <button type="submit" className="bg-purple-800 text-white px-4 py-2 rounded-md">
                        {editMode ? "Update Aircraft" : "Create Aircraft"}
                    </button>
                </form>
                <div className="overflow-x-auto">
                    <table className="table-auto w-full bg-white rounded-lg shadow-md">
                        <thead>
                            <tr className="bg-gray-200">
                                <th className="px-4 py-2">Aircraft ID</th>
                                <th className="px-4 py-2">Model</th>
                                <th className="px-4 py-2">Manufacturer</th>
                                <th className="px-4 py-2">Capacity</th>
                                <th className="px-4 py-2">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {aircrafts.map(aircraft => (
                                <tr key={aircraft.AircraftID} className="border-t">
                                    <td className="px-4 py-2">{aircraft.AircraftID}</td>
                                    <td className="px-4 py-2">{aircraft.Model}</td>
                                    <td className="px-4 py-2">{aircraft.Manufacturer}</td>
                                    <td className="px-4 py-2">{aircraft.Capacity}</td>
                                    <td className="px-4 py-2">
                                        <button 
                                            onClick={() => handleEdit(aircraft.AircraftID)} 
                                            className="bg-yellow-500 text-white px-2 py-1 rounded-md mr-2"
                                        >
                                            Edit
                                        </button>
                                        <button 
                                            onClick={() => handleDelete(aircraft.AircraftID)} 
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

export default AdminAircraft;