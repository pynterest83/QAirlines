// models/associations.js

const Aircraft = require('./Aircraft');
const Airport = require('./Airport');
const Flight = require('./Flight');
const FlightSeat = require('./FlightSeat');
const Passenger = require('./Passenger');
const Seat = require('./Seat');
const Ticket = require('./Ticket');
const TicketClass = require('./TicketClass');
const Promotion = require('./Promotion');
const Users = require('./User');

// Flight và Airport associations
Flight.belongsTo(Airport, { as: 'DepartureAirport', foreignKey: 'DepID' });
Flight.belongsTo(Airport, { as: 'DestinationAirport', foreignKey: 'DestID' });
Airport.hasMany(Flight, { as: 'DepartingFlights', foreignKey: 'DepID' });
Airport.hasMany(Flight, { as: 'ArrivingFlights', foreignKey: 'DestID' });

// Flight và Aircraft association
Flight.belongsTo(Aircraft, { foreignKey: 'AircraftID' });
Aircraft.hasMany(Flight, { foreignKey: 'AircraftID' });

// Seat và Aircraft association
Seat.belongsTo(Aircraft, { foreignKey: 'AircraftID' });
Aircraft.hasMany(Seat, { foreignKey: 'AircraftID' });

// FlightSeat associations
FlightSeat.belongsTo(Flight, { foreignKey: 'FlightID' });
Flight.hasMany(FlightSeat, { foreignKey: 'FlightID', as: 'flightSeats' });

// Association giữa FlightSeat và Seat
FlightSeat.belongsTo(Seat, { foreignKey: 'SeatNo', targetKey: 'SeatNo', as: 'seatDetails' });
Seat.hasMany(FlightSeat, { foreignKey: 'SeatNo', sourceKey: 'SeatNo', as: 'flightSeats' });

// Passenger self-association (Guardian)
Passenger.belongsTo(Passenger, { as: 'Guardian', foreignKey: 'GuardianID' });
Passenger.hasMany(Passenger, { as: 'Dependents', foreignKey: 'GuardianID' });

// Ticket associations
Ticket.belongsTo(Passenger, { foreignKey: 'PassID' });
Passenger.hasMany(Ticket, { foreignKey: 'PassID' });

Ticket.belongsTo(Flight, { foreignKey: 'FlightID' });
Flight.hasMany(Ticket, { foreignKey: 'FlightID' });

// Ticket và FlightSeat association
Ticket.hasOne(FlightSeat, { foreignKey: 'TicketID', sourceKey: 'TicketID' });
FlightSeat.belongsTo(Ticket, { foreignKey: 'TicketID', targetKey: 'TicketID' });

// Flight và TicketClass association
Flight.hasMany(TicketClass, { foreignKey: 'FlightID', as: 'ticketClasses' });
TicketClass.belongsTo(Flight, { foreignKey: 'FlightID' });

// Nếu có mối quan hệ giữa Ticket và Seat thông qua FlightSeat
Ticket.belongsTo(Seat, { foreignKey: 'SeatNo', targetKey: 'SeatNo' });
Seat.hasMany(Ticket, { foreignKey: 'SeatNo', sourceKey: 'SeatNo' });
