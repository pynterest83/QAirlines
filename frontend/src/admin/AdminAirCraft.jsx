import React, { useState, useEffect } from "react";
import { Navigate } from "react-router-dom";
import { Server } from "../Server";
import AdminNavigation from "./components/AdminNavigation";
import airplaneLoader from '../assets/images/airplaneLoader.gif';

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
    const [svgFile, setSvgFile] = useState(null);
    const [jsonFile, setJsonFile] = useState(null);
    const [imageFiles, setImageFiles] = useState([]); // For multiple images
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        const fetchAircrafts = async () => {
            try {
                const response = await fetch(`${Server}aircrafts/list`);
                if (response.ok) {
                    const data = await response.json();
                    setAircrafts(data);
                } else {
                    console.error("Failed to fetch aircrafts:", response.statusText);
                }
            } catch (error) {
                console.error("Error fetching aircrafts:", error.message);
            }
        };

        fetchAircrafts().then();
    }, [token]);

    const createAircraft = async (formData) => {
        setLoading(true); // Set loading to true
        try {
            const response = await fetch(`${Server}aircrafts/create`, {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                },
                body: formData,
            });

            if (response.ok) {
                const data = await response.json();
                setAircrafts([...aircrafts, data.aircraft]); // Update aircraft list
                window.location.reload(); // Reload the page after successful creation
            } else {
                const errorText = await response.text();
                console.error("Failed to create aircraft:", errorText);
            }
        } catch (error) {
            console.error("Unexpected error:", error.message);
        } finally {
            setLoading(false); // Set loading to false
        }
    };

    const handleSubmit = (e) => {
        e.preventDefault();

        const formData = new FormData();
        formData.append("AircraftID", aircraftID);
        formData.append("Model", model);
        formData.append("Manufacturer", manufacturer);
        formData.append("Capacity", parseInt(capacity));

        if (svgFile) formData.append("svg", svgFile);
        if (jsonFile) formData.append("json", jsonFile);
        if (imageFiles.length > 0) {
            imageFiles.forEach((file) => {
                formData.append("images", file); // Append each image file with the key "relatedImages"
            });
        }

        createAircraft(formData);
    };

    return (
        <div className="relative">
            <AdminNavigation />
            <div className="p-6 bg-gray-100 min-h-screen">
                <h2 className="text-xl font-bold mb-6">Create New Aircraft</h2>
                <form onSubmit={handleSubmit} className="bg-white p-8 rounded-lg shadow-md mb-8">
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-6">
                        {/* Aircraft ID */}
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">Aircraft ID:</label>
                            <input
                                type="text"
                                value={aircraftID}
                                onChange={(e) => setAircraftID(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>

                        {/* Model */}
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">Model:</label>
                            <input
                                type="text"
                                value={model}
                                onChange={(e) => setModel(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>

                        {/* Manufacturer */}
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">Manufacturer:</label>
                            <input
                                type="text"
                                value={manufacturer}
                                onChange={(e) => setManufacturer(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>

                        {/* Capacity */}
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">Capacity:</label>
                            <input
                                type="number"
                                value={capacity}
                                onChange={(e) => setCapacity(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>
                    </div>

                    <div className="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-6">
                        {/* SVG File Upload */}
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">Upload SVG:</label>
                            <input
                                type="file"
                                accept=".svg"
                                onChange={(e) => setSvgFile(e.target.files[0])}
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>

                        {/* JSON File Upload */}
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">Upload JSON:</label>
                            <input
                                type="file"
                                accept=".json"
                                onChange={(e) => setJsonFile(e.target.files[0])}
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>

                        {/* Image Files Upload */}
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Upload Images:
                            </label>
                            <input
                                type="file"
                                accept="image/*"
                                multiple // Allow multiple file uploads
                                onChange={(e) => setImageFiles(Array.from(e.target.files))}
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                            {imageFiles.length > 0 && (
                                <ul className="text-sm text-gray-500 mt-1">
                                    {imageFiles.map((file, index) => (
                                        <li key={index}>{file.name}</li>
                                    ))}
                                </ul>
                            )}
                        </div>
                    </div>

                    <button
                        type="submit"
                        className="w-full gradient-button text-white py-2 px-4 rounded-md"
                        disabled={loading}
                    >
                        {loading ? "Creating..." : "Create Aircraft"}
                    </button>
                </form>

                {loading && (
                    <div className="flex justify-center items-center">
                        <img src={airplaneLoader} alt="Loading..." />
                    </div>
                )}

                {/* Aircraft List */}
                <h2 className="text-xl font-bold mb-4">Aircraft List</h2>
                <table className="min-w-full bg-white border border-gray-200">
                    <thead>
                        <tr>
                            <th className="py-2 px-4 border-b">Aircraft ID</th>
                            <th className="py-2 px-4 border-b">Model</th>
                            <th className="py-2 px-4 border-b">Manufacturer</th>
                            <th className="py-2 px-4 border-b">Capacity</th>
                        </tr>
                    </thead>
                    <tbody>
                        {aircrafts.map((aircraft) => (
                            <tr key={aircraft.id}>
                                <td className="py-2 px-4 border-b">{aircraft.AircraftID}</td>
                                <td className="py-2 px-4 border-b">{aircraft.Model}</td>
                                <td className="py-2 px-4 border-b">{aircraft.Manufacturer}</td>
                                <td className="py-2 px-4 border-b">{aircraft.Capacity}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default AdminAircraft;