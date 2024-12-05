// noinspection ExceptionCaughtLocallyJS

const { Flight, Seat, FlightSeat, Passenger, Ticket} = require("../../models/schemas");
const {Op} = require("sequelize");
async function updateFlight(flightID, updates) {
    // Find the flight by its ID
    const flight = await Flight.findByPk(flightID);
    // Convert to time zone
    if (!flight) {
        throw new Error('Flight not found');
    }
    if (updates.DepTime && !flight.OriginalDepTime) flight.OriginalDepTime = flight.DepTime;
    if (updates.ArrTime && !flight.OriginalArrTime) flight.OriginalArrTime = flight.ArrTime;
    if (updates.BoardingTime && !flight.OriginalBoardingTime) flight.OriginalBoardingTime = flight.BoardingTime;

    // Apply the updates dynamically
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
        // Generate a random FlightID
        const prefix = String.fromCharCode(65 + Math.floor(Math.random() * 26)) +
            String.fromCharCode(65 + Math.floor(Math.random() * 26));
        const randomNumber = Math.floor(100 + Math.random() * 900);
        flightID = `${prefix}${randomNumber}`;

        // Check if the generated FlightID already exists in the database
        const existingFlight = await Flight.findOne({ where: { FlightID: flightID } });
        if (!existingFlight) {
            unique = true;
        }
    }

    return flightID;
}

async function createFlight(flightData) {
    const requiredFields = ['Status', 'DepTime', 'ArrTime', 'BoardingTime', 'DepID', 'DestID', 'AircraftID'];
    const missingFields = requiredFields.filter(field => !flightData[field]);

    if (missingFields.length > 0) {
        throw new Error(`Missing required fields: ${missingFields.join(', ')}`);
    }

    // Normalize AircraftID
    flightData.AircraftID = flightData.AircraftID.trim().toUpperCase();

    const transaction = await Flight.sequelize.transaction(); // Start a transaction for atomicity
    try {
        // Generate a unique FlightID
        const FlightID = await generateFlightID();

        // Validate AircraftID and fetch associated seats
        const seats = await Seat.findAll({
            where: { AircraftID: flightData.AircraftID },
        });

        if (seats.length === 0) {
            throw new Error(`No seats found for AircraftID: ${flightData.AircraftID}`);
        }

        // Create the flight
        const newFlight = await Flight.create({ ...flightData, FlightID }, { transaction });

        // Populate the flightSeat table
        const flightSeats = seats.map(seat => ({
            FlightID,
            AircraftID: seat.AircraftID,
            SeatNo: seat.SeatNo,
            TicketID: null, // Initially, no tickets are assigned
        }));

        await FlightSeat.bulkCreate(flightSeats, { transaction });

        await transaction.commit(); // Commit the transaction
        return newFlight;
    } catch (error) {
        await transaction.rollback(); // Rollback on error
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

    // Sort by Departure Time
    return await Flight.findAll({
        where: query,
        order: [['DepTime', 'ASC']],
    });
}

const getFlightDetails = async (flightID) => {
    const passengers = await Ticket.findAll({
        where: { FlightID: flightID },
        include: [{
            model: Passenger,
            attributes: ['PassID', 'FirstName', 'LastName', 'DOB', 'Gender']
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
