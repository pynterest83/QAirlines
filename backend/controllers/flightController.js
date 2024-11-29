const { updateFlight } = require("../services/flight/flightService");
exports.handleUpdate = async (req, res) => {
    const { flightID, ...updates } = req.body;

    try {
        const flight = await updateFlight(flightID, updates);
        res.json({
            message: 'Flight delayed successfully',
            flight
        });
    } catch (error) {
        console.error('Error during delay:', error.message);
        res.status(400).json({ error: error.message });
    }
}