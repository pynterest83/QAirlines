const {delayFlight} = require("../services/flight/flightService");
exports.handleDelay = async (req, res) => {
    const { flightID, ...newTimes } = req.body;

    try {
        const flight = await delayFlight(flightID, newTimes);
        res.json({
            message: 'Flight delayed successfully',
            flight
        });
    } catch (error) {
        console.error('Error during delay:', error.message);
        res.status(400).json({ error: error.message });
    }
}