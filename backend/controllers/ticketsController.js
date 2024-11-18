const express = require('express');
const { Passenger, Ticket, FlightSeat, Flight } = require('../models');

// Helper function to find or create a passenger
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

// Book a ticket for a passenger
async function bookTicket(flightID, seatNo, passID) {
    try {
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
    } catch (error) {
        console.error('Error in bookTicket:', error.message);
        throw error;
    }
}

// Route to book tickets
exports.handleBookTicket = async (req, res) => {
    const { flightID, passengers } = req.body;

    if (!flightID || !passengers || !Array.isArray(passengers)) {
        return res.status(400).json({ error: 'Thiếu thông tin bắt buộc hoặc thông tin không hợp lệ' });
    }

    try {
        // Tách khách hàng người lớn và trẻ em
        const adults = passengers.filter(p => !p.guardianSSN);
        const children = passengers.filter(p => p.guardianSSN);

        // Xử lý khách hàng người lớn trước
        const adultResults = await Promise.all(adults.map(async (adult) => {
            const { seatNo, ...adultInfo } = adult;
            const passenger = await findOrCreatePassenger(adultInfo);
            return { passID: passenger.PassID, seatNo };
        }));

        // Tạo map với SSN của người lớn để dễ dàng truy cập
        const guardianMap = adultResults.reduce((acc, { passID }, index) => {
            acc[adults[index].ssn] = passID;
            return acc;
        }, {});

        // Xử lý khách hàng trẻ em sau khi người lớn đã được tạo xong
        const childResults = await Promise.all(children.map(async (child) => {
            const { seatNo, guardianSSN, ...childInfo } = child;
            const guardianID = guardianMap[guardianSSN];

            if (!guardianID) throw new Error(`Không tìm thấy người giám hộ với SSN: ${guardianSSN}`);

            // Thêm GuardianID vào thông tin của trẻ em
            childInfo.guardianID = guardianID;
            const passenger = await findOrCreatePassenger(childInfo);
            return { passID: passenger.PassID, seatNo };
        }));

        // Đặt vé cho tất cả khách hàng
        const ticketPromises = [
            ...adultResults.map(({ passID, seatNo }) => bookTicket(flightID, seatNo, passID)),
            ...childResults.map(({ passID, seatNo }) => bookTicket(flightID, seatNo, passID))
        ];

        const tickets = await Promise.all(ticketPromises);
        res.json({ message: 'Đặt vé thành công', tickets });
    } catch (error) {
        console.error('Error in /book-ticket:', error.message);
        res.status(500).json({ error: error.message || 'Có lỗi xảy ra khi đặt vé' });
    }
};

// Route to cancel a ticket
exports.handleCancelTicket = async (req, res) => {
    const { ticketID } = req.body;

    if (!ticketID) {
        return res.status(400).json({ error: 'Vui lòng cung cấp ticketID' });
    }

    try {
        const ticket = await Ticket.findByPk(ticketID);
        if (!ticket) throw new Error('Vé không tồn tại');

        await FlightSeat.update(
            { TicketID: null },
            { where: { FlightID: ticket.FlightID, SeatNo: ticket.SeatNo } }
        );

        await ticket.destroy();

        res.json({ message: 'Hủy vé thành công' });
    } catch (error) {
        console.error('Error in /cancel-ticket:', error.message);
        res.status(500).json({ error: error.message || 'Có lỗi xảy ra khi hủy vé' });
    }
};
