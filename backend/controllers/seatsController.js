// controllers/seatsController.js
const Flight = require('../models/Flight');
const Seat = require('../models/Seat');
const FlightSeat = require('../models/FlightSeat');
const { Op } = require('sequelize');

// Hàm truy vấn tất cả chỗ ngồi của một chuyến bay
exports.getAllSeats = async (req, res) => {
    const { flightID } = req.query;

    try {
        const flight = await Flight.findByPk(flightID);

        if (!flight) {
            return res.status(404).json({ error: 'Flight not found' });
        }

        const seats = await Seat.findAll({
            where: { AircraftID: flight.AircraftID },
            include: [{
                model: FlightSeat,
                as: 'flightSeats',
                where: { FlightID: flightID },
                required: false, // Để lấy cả ghế không tồn tại trong FlightSeat
            }],
            order: [['SeatNo', 'ASC']]
        });

        const seatDetails = seats.map(seat => ({
            seatNo: seat.SeatNo,
            class: seat.Class,
            status: seat.flightSeats.length === 0 ? 'not available' : seat.flightSeats[0].TicketID ? 'booked' : 'available'
        }));

        res.json({ flightID, allSeats: seatDetails });
    } catch (error) {
        console.error('Error fetching all seats:', error);
        res.status(500).json({ error: 'Database query error' });
    }
};

// Hàm truy vấn danh sách các chỗ ngồi trống theo hạng ghế của một chuyến bay
exports.getAvailableSeats = async (req, res) => {
    const { flightID, class: classType } = req.query;

    try {
        const flight = await Flight.findByPk(flightID);

        if (!flight) {
            return res.status(404).json({ error: 'Flight not found' });
        }

        const availableSeats = await Seat.findAll({
            where: {
                AircraftID: flight.AircraftID,
                Class: classType
            },
            include: [{
                model: FlightSeat,
                as: 'flightSeats',
                where: { FlightID: flightID, TicketID: { [Op.is]: null } }, // Chỉ lấy ghế chưa có vé
                required: true
            }],
            order: [['SeatNo', 'ASC']]
        });

        const seatNos = availableSeats.map(seat => seat.SeatNo);

        res.json({ flightID, class: classType, availableSeats: seatNos });
    } catch (error) {
        console.error('Error fetching available seats:', error);
        res.status(500).json({ error: 'Database query error' });
    }
};
