const { getAllAircraft, createAircraft } = require("../services/aircrafts/aircraftService");

exports.handleGetAircrafts = async (req, res) => {
    try {
        const aircrafts = await getAllAircraft();
        res.json(aircrafts);
    } catch (error) {
        console.error('Error fetching aircrafts:', error.message);
        res.status(500).json({ error: error.message });
    }
}

exports.handleCreateAircraft = async (req, res) => {
    const { seats, ...aircraft } = req.body;
    try {
        await createAircraft(aircraft, seats);
        res.json({
            message: 'Aircraft created successfully',
            aircraft: aircraft
        });
    } catch (error) {
        console.error('Error during aircraft creation:', error.message);
        res.status(400).json({ error: error.message });
    }
}