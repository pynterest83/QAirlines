const Flight = require('../../models/schemas/Flight');
const Seat = require('../../models/schemas/Seat');
const FlightSeat = require('../../models/schemas/FlightSeat');
const { Op } = require('sequelize');


async function getAllSeats(flightID) {
    const flight = await Flight.findByPk(flightID);
    if (!flight) throw new Error('Flight not found');

    const seats = await Seat.findAll({
        where: { AircraftID: flight.AircraftID },
        include: [{
            model: FlightSeat,
            as: 'flightSeats',
            where: { FlightID: flightID },
            required: false
        }],
        order: [['SeatNo', 'ASC']]
    });

    return seats.map(seat => ({
        seatNo: seat.SeatNo,
        class: seat.Class,
        status: seat.flightSeats.length === 0 ? 'not available' : seat.flightSeats[0].TicketID ? 'booked' : 'available'
    }));
}


async function getAvailableSeats(flightID, classType) {
    const flight = await Flight.findByPk(flightID);
    if (!flight) throw new Error('Flight not found');

    const availableSeats = await Seat.findAll({
        where: {
            AircraftID: flight.AircraftID,
            Class: classType
        },
        include: [{
            model: FlightSeat,
            as: 'flightSeats',
            where: { FlightID: flightID, TicketID: { [Op.is]: null } },
            required: true
        }],
        order: [['SeatNo', 'ASC']]
    });

    return availableSeats.map(seat => seat.SeatNo);
}

module.exports = {
    getAllSeats,
    getAvailableSeats
};
