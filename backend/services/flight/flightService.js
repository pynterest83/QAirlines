const { Flight, Seat, FlightSeat, Passenger, Ticket, TicketClass} = require("../../models/schemas");
const {Op} = require("sequelize");

async function updateFlight(flightID, updates) {
    const flight = await Flight.findByPk(flightID);
    if (!flight) {
        throw new Error('Flight not found');
    }
    if (updates.DepTime && !flight.OriginalDepTime) flight.OriginalDepTime = flight.DepTime;
    if (updates.ArrTime && !flight.OriginalArrTime) flight.OriginalArrTime = flight.ArrTime;
    if (updates.BoardingTime && !flight.OriginalBoardingTime) flight.OriginalBoardingTime = flight.BoardingTime;
    Object.keys(updates).forEach(key => {
        if (updates[key] !== undefined) {
            flight[key] = updates[key];
        }
    });
    await flight.save();
    return flight;
}

async function generateFlightID() {
    let unique = false;
    let flightID;

    while (!unique) {
        const prefix = String.fromCharCode(65 + Math.floor(Math.random() * 26)) +
            String.fromCharCode(65 + Math.floor(Math.random() * 26));
        const randomNumber = Math.floor(100 + Math.random() * 900);
        flightID = `${prefix}${randomNumber}`;
        const existingFlight = await Flight.findOne({ where: { FlightID: flightID } });
        if (!existingFlight) {
            unique = true;
        }
    }

    return flightID;
}

async function createFlight(flightData) {
    const transaction = await Flight.sequelize.transaction();
    try {
        const FlightID = await generateFlightID();
        flightData.AircraftID = flightData.AircraftID.trim().toUpperCase();
        const seats = await Seat.findAll({
            where: { AircraftID: flightData.AircraftID },
        });
        if (seats.length === 0) {
            throw new Error(`No seats found for AircraftID: ${flightData.AircraftID}`);
        }
        const newFlight = await Flight.create(
            { ...flightData, FlightID },
            { transaction }
        );
        const flightSeats = seats.map(seat => ({
            FlightID,
            AircraftID: seat.AircraftID,
            SeatNo: seat.SeatNo,
            TicketID: null, // Initially, no tickets are assigned
        }));
        await FlightSeat.bulkCreate(flightSeats, { transaction });
        const { ticketPrices } = flightData;
        const ticketClasses = Object.entries(ticketPrices).map(([className, price]) => ({
            FlightID,
            ClassName: className,
            Price: price,
        }));
        await TicketClass.bulkCreate(ticketClasses, { transaction });
        await transaction.commit();
        return newFlight;
    } catch (error) {
        await transaction.rollback();
        throw new Error(`Failed to create flight: ${error.message}`);
    }
}

async function getFlights(flightIds = []) {
    const query = {};

    if (flightIds.length > 0) {
        query.FlightID = {
            [Op.in]: flightIds,
        };
    }
    return await Flight.findAll({
        where: query,
        order: [['DepTime', 'ASC']],
    });
}

const getFlightDetails = async (flightID) => {
    const passengers = await Ticket.findAll({
        where: { FlightID: flightID },
        include: [{
            model: Passenger
        }]
    });
    return passengers.map(ticket => ({
        TicketID: ticket.TicketID,
        Passenger: ticket.Passenger,
    }));
};

module.exports = {
    updateFlight,
    createFlight,
    getFlights,
    getFlightDetails
};
