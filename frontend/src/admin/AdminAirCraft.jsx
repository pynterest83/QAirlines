import { useState, useEffect } from "react";
import { Navigate } from "react-router-dom";
import { Server } from "../Server";
import AdminNavigation from "./components/AdminNavigation";
import airplaneLoader from '../assets/images/airplaneLoader.gif'; // Import the loading GIF
import ScrollToTop from "../scroll.jsx";

const AdminAircraft = () => {
    const token = localStorage.getItem("token");

    const [aircrafts, setAircrafts] = useState([]);
    const [aircraftID, setAircraftID] = useState("");
    const [model, setModel] = useState("");
    const [manufacturer, setManufacturer] = useState("");
    const [capacity, setCapacity] = useState("");
    const [svgFile, setSvgFile] = useState(null);
    const [jsonFile, setJsonFile] = useState(null);
    const [imageFile, setImageFile] = useState(null);
    const [loading, setLoading] = useState(false); // Add loading state

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
    
        // Prepare FormData
        const formData = new FormData();
        formData.append("AircraftID", aircraftID);
        formData.append("Model", model);
        formData.append("Manufacturer", manufacturer);
        formData.append("Capacity", parseInt(capacity));
    
        if (svgFile) formData.append("svg", svgFile);
        if (jsonFile) formData.append("json", jsonFile);
    
        if (imageFile) {
            Array.from(imageFile).forEach((file) => {
                formData.append("images", file);
            });
        }
    
        createAircraft(formData);
    };    
    if (!token) {
        return <Navigate to="/adminLogin" />;
    }
    return (
        <div className="relative">
            <ScrollToTop />
            <AdminNavigation />
            <div className="p-6 bg-gray-100 min-h-screen">
                <h2 className="text-xl font-bold mb-6">Create New Aircraft</h2>
                <form onSubmit={handleSubmit} className="bg-white p-8 rounded-lg shadow-md mb-8">
                    {/* Aircraft Details */}
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-6">
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Aircraft ID:
                            </label>
                            <input
                                type="text"
                                value={aircraftID}
                                onChange={(e) => setAircraftID(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Model:
                            </label>
                            <input
                                type="text"
                                value={model}
                                onChange={(e) => setModel(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Manufacturer:
                            </label>
                            <input
                                type="text"
                                value={manufacturer}
                                onChange={(e) => setManufacturer(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Capacity:
                            </label>
                            <input
                                type="number"
                                value={capacity}
                                onChange={(e) => setCapacity(e.target.value)}
                                required
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                        </div>
                    </div>

                    {/* File Uploads */}
                    <div className="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-6">
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Upload SVG:
                            </label>
                            <input
                                type="file"
                                accept="image/svg+xml"
                                onChange={(e) => setSvgFile(e.target.files[0])}
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                            {svgFile && <p className="text-sm text-gray-500 mt-1">{svgFile.name}</p>}
                        </div>
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Upload JSON:
                            </label>
                            <input
                                type="file"
                                accept="application/json"
                                onChange={(e) => setJsonFile(e.target.files[0])}
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                            {jsonFile && <p className="text-sm text-gray-500 mt-1">{jsonFile.name}</p>}
                        </div>
                        <div>
                            <label className="block text-gray-700 font-medium mb-1">
                                Upload Image:
                            </label>
                            <input
                                type="file"
                                accept="image/*"
                                multiple
                                onChange={(e) => setImageFile(e.target.files)}
                                className="w-full border border-gray-300 rounded-md p-2"
                            />
                            {imageFile && <p className="text-sm text-gray-500 mt-1">{imageFile.name}</p>}
                        </div>
                    </div>

                    {/* Submit Button */}
                    <button
                        type="submit"
                        className="w-full gradient-button text-white py-2 px-4 rounded-md"
                        disabled={loading} // Disable button while loading
                    >
                        {loading ? "Creating..." : "Create Aircraft"}
                    </button>
                </form>

                {/* Loading Indicator */}
                {loading && (
                    <div className="flex justify-center items-center">
                        <img src={airplaneLoader} alt="Loading..." />
                    </div>
                )}

                {/* Aircraft List */}
                <h3 className="text-lg font-bold mb-4">Existing Aircrafts</h3>
                <div className="overflow-x-auto">
                    <table className="table-auto w-full bg-white rounded-lg shadow-md">
                        <thead>
                            <tr className="bg-gray-200">
                                <th className="px-4 py-2">Aircraft ID</th>
                                <th className="px-4 py-2">Model</th>
                                <th className="px-4 py-2">Manufacturer</th>
                                <th className="px-4 py-2">Capacity</th>
                            </tr>
                        </thead>
                        <tbody>
                            {aircrafts.map((aircraft) => (
                                <tr key={aircraft.AircraftID} className="border-t">
                                    <td className="px-4 py-2">{aircraft.AircraftID}</td>
                                    <td className="px-4 py-2">{aircraft.Model}</td>
                                    <td className="px-4 py-2">{aircraft.Manufacturer}</td>
                                    <td className="px-4 py-2">{aircraft.Capacity}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default AdminAircraft;