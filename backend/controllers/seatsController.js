const validate = require('../middlewares/validateInput');
const { allSeatsSchema, availableSeatsSchema } = require('../validations/seatValidation');
const seatService = require('../services/seats/seatService');

// Lấy tất cả chỗ ngồi
exports.getAllSeats = [
    validate(allSeatsSchema, 'query'), // Kiểm tra query parameters
    async (req, res) => {
        try {
            const { flightID } = req.query; // flightID thay vì flightId
            const allSeats = await seatService.getAllSeats(flightID);
            res.json({ flightID, allSeats });
        } catch (error) {
            console.error('Error fetching all seats:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra' });
        }
    },
];

// Lấy chỗ ngồi trống theo hạng ghế
exports.getAvailableSeats = [
    validate(availableSeatsSchema, 'query'), // Kiểm tra query parameters
    async (req, res) => {
        try {
            const { flightID, class: classType } = req.query; // flightID thay vì flightId
            const availableSeats = await seatService.getAvailableSeats(flightID, classType);
            res.json({ flightID, class: classType, availableSeats });
        } catch (error) {
            console.error('Error fetching available seats:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra' });
        }
    },
];
