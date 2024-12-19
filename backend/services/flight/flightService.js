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
    console.log(`Fetching flight details for FlightID: ${flightID}`);

    const flightSeats = await FlightSeat.findAll({
        where: {
            FlightID: flightID,
            TicketID: { [Op.not]: null }
        },
        include: [
            {
                model: Ticket,
                attributes: ['TicketID', 'PassID']
            },
            {
                model: Seat,
                as: 'seatDetails',
                attributes: ['Class']
            }
        ]
    });

    console.log('FlightSeats:', JSON.stringify(flightSeats, null, 2));

    const uniqueFlightSeats = flightSeats.reduce((acc, seat) => {
        if (!acc.find(s => s.Ticket?.TicketID === seat.Ticket?.TicketID)) {
            acc.push(seat);
        }
        return acc;
    }, []);

    const passengerIDs = uniqueFlightSeats.map(fs => fs.Ticket?.PassID).filter(Boolean);

    const passengers = await Passenger.findAll({
        where: {
            PassID: passengerIDs
        }
    });

    console.log('Passengers:', JSON.stringify(passengers, null, 2));

    const passengerMap = passengers.reduce((acc, passenger) => {
        acc[passenger.PassID] = passenger;
        return acc;
    }, {});

    const result = uniqueFlightSeats.map(flightSeat => {
        const ticket = flightSeat.Ticket;
        const seatDetails = flightSeat.seatDetails;

        return {
            TicketID: ticket.TicketID,
            Passenger: passengerMap[ticket.PassID] || null,
            SeatClass: seatDetails?.Class || null
        };
    });

    console.log('Final Flight Details:', JSON.stringify(result, null, 2));

    return result;
};

module.exports = {
    updateFlight,
    createFlight,
    getFlights,
    getFlightDetails
};
