exports.handleDelay = async (req, res) => {
    const { flightID } = req.params;
    const { newTimes } = req.body;

    try {
        const flight = await flightService.delayFlight(flightID, newTimes);
        res.json({
            message: 'Flight delayed successfully',
            flight
        });
    } catch (error) {
        console.error('Error during delay:', error.message);
        res.status(400).json({ error: error.message });
    }
}