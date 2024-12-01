const { getAllAircraft } = require("../services/aircrafts/aircraftService");

exports.handleGetAircrafts = async (req, res) => {
    try {
        const aircrafts = await getAllAircraft();
        res.json(aircrafts);
    } catch (error) {
        console.error('Error fetching aircrafts:', error.message);
        res.status(500).json({ error: error.message });
    }
}