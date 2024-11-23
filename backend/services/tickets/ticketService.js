const { Passenger, Ticket, FlightSeat, Flight } = require('../../models/schemas');
const {Op} = require("sequelize");

// Tìm hoặc tạo hành khách
async function findOrCreatePassenger(data) {
    const { firstName, lastName, dob, gender, email, phoneNumber, passport, ssn, guardianID } = data;

    const whereConditions = {};
    if (passport) whereConditions.Passport = passport;
    if (ssn) whereConditions.SSN = ssn;
    if (email) whereConditions.Email = email;
    if (phoneNumber) whereConditions.PhoneNumber = phoneNumber;

    let passenger = await Passenger.findOne({
        where: {
            ...whereConditions,
            FirstName: firstName,
            LastName: lastName,
            DOB: dob,
            Gender: gender,
        },
    });

    if (!passenger) {
        passenger = await Passenger.create({
            PassID: `P${Math.floor(Math.random() * 1000000)}`,
            FirstName: firstName,
            LastName: lastName,
            DOB: dob,
            Gender: gender,
            Email: email,
            PhoneNumber: phoneNumber,
            Passport: passport,
            SSN: ssn,
            GuardianID: guardianID,
        });
    }

    return passenger;
}

// Đặt vé cho hành khách
async function bookTicket(flightID, seatNo, passID) {
    const flight = await Flight.findByPk(flightID);
    if (!flight) throw new Error('Chuyến bay không tồn tại');

    const ticketID = `T${Math.floor(Math.random() * 1000000)}`;
    const cancellationDeadline = new Date(new Date(flight.DepTime).getTime() - 72 * 60 * 60 * 1000);

    const ticket = await Ticket.create({
        TicketID: ticketID,
        FlightID: flightID,
        AircraftID: flight.AircraftID,
        SeatNo: seatNo,
        PassID: passID,
        CancellationDeadline: cancellationDeadline,
    });

    await FlightSeat.update(
        { TicketID: ticketID },
        { where: { FlightID: flightID, SeatNo: seatNo } }
    );

    return ticket;
}

// Hủy vé
async function cancelTicket(ticketID) {
    const ticket = await Ticket.findByPk(ticketID);
    if (!ticket) throw new Error('Vé không tồn tại');

    await FlightSeat.update(
        { TicketID: null },
        { where: { FlightID: ticket.FlightID, SeatNo: ticket.SeatNo } }
    );

    await ticket.destroy();

    return true;
}

// Lấy thông tin vé theo hành khách
async function getTicketsByPassenger(identifier) {
    // Tìm hành khách người lớn dựa trên SSN hoặc Passport
    const guardian = await Passenger.findOne({
        where: {
            [Op.or]: [
                { SSN: identifier },
                { Passport: identifier }
            ]
        }
    });

    if (!guardian) {
        throw new Error('Guardian not found with the provided SSN or Passport');
    }

    // Tìm tất cả hành khách phụ thuộc của người lớn
    const dependents = await Passenger.findAll({
        where: { GuardianID: guardian.PassID },
        attributes: ['PassID']
    });

    const dependentIDs = dependents.map(dependent => dependent.PassID);
    const allPassengerIDs = [guardian.PassID, ...dependentIDs]; // Bao gồm cả người lớn và trẻ em

    // Lấy vé của tất cả hành khách này
    const tickets = await Ticket.findAll({
        where: { PassID: { [Op.in]: allPassengerIDs } },
        include: [
            {
                model: Flight,
                attributes: ['FlightID', 'DepTime', 'ArrTime', 'DepID', 'DestID']
            }
        ]
    });

    if (tickets.length === 0) {
        throw new Error('No tickets found for this guardian and dependents');
    }

    return tickets.map(ticket => ({
        TicketID: ticket.TicketID,
        FlightID: ticket.FlightID,
        SeatNo: ticket.SeatNo,
        AircraftID: ticket.AircraftID,
        CancellationDeadline: ticket.CancellationDeadline,
        FlightDetails: ticket.Flight
    }));
}


module.exports = {
    findOrCreatePassenger,
    bookTicket,
    cancelTicket,
    getTicketsByPassenger
};
