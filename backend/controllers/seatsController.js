require('../middlewares/validateInput');
const seatService = require('../services/seats/seatService');

exports.getAllSeats = [
    async (req, res) => {
        try {
            const { flightID } = req.query;             const allSeats = await seatService.getAllSeats(flightID);
            return res.json({ flightID, allSeats });
        } catch (error) {
            console.error('Error fetching all seats:', error.message);
            return res.status(500).json({ error: error.message || 'An error occured' });
        }
    },
];

exports.getAvailableSeats = [
    async (req, res) => {
        try {
            const { flightID, class: classType } = req.query;
            const availableSeats = await seatService.getAvailableSeats(flightID, classType);
            return res.json({ flightID, class: classType, availableSeats });
        } catch (error) {
            console.error('Error fetching available seats:', error.message);
            return res.status(500).json({ error: error.message || 'An error occured' });
        }
    },
];
