const { updateFlight, createFlight, getFlights} = require("../services/flight/flightService");

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

exports.handleCreate = async (req, res) => {
    const flightData = req.body;

    try {
        const flight = await createFlight(flightData);
        res.json({
            message: 'Flight created successfully',
            flight
        });
    } catch (error) {
        console.error('Error during flight creation:', error.message);
        res.status(400).json({ error: error.message });
    }
}

exports.handleGetFlights = async (req, res) => {
    const flightIds = req.query.flightIds ? req.query.flightIds.split(',') : [];

    try {
        const flights = await getFlights(flightIds);
        res.json({ flights });
    } catch (error) {
        console.error('Error during fetching flights:', error.message);
        res.status(400).json({ error: error.message });
    }
}