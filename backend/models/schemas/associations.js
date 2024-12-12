const Aircraft = require('./Aircraft');
const Airport = require('./Airport');
const Flight = require('./Flight');
const FlightSeat = require('./FlightSeat');
const Passenger = require('./Passenger');
const Seat = require('./Seat');
const Ticket = require('./Ticket');
const TicketClass = require('./TicketClass');


Flight.belongsTo(Airport, { as: 'DepartureAirport', foreignKey: 'DepID' });
Flight.belongsTo(Airport, { as: 'DestinationAirport', foreignKey: 'DestID' });
Airport.hasMany(Flight, { as: 'DepartingFlights', foreignKey: 'DepID' });
Airport.hasMany(Flight, { as: 'ArrivingFlights', foreignKey: 'DestID' });


Flight.belongsTo(Aircraft, { foreignKey: 'AircraftID' });
Aircraft.hasMany(Flight, { foreignKey: 'AircraftID' });


Seat.belongsTo(Aircraft, { foreignKey: 'AircraftID' });
Aircraft.hasMany(Seat, { foreignKey: 'AircraftID' });


FlightSeat.belongsTo(Flight, { foreignKey: 'FlightID' });
Flight.hasMany(FlightSeat, { foreignKey: 'FlightID', as: 'flightSeats' });


FlightSeat.belongsTo(Seat, { foreignKey: 'SeatNo', targetKey: 'SeatNo', as: 'seatDetails' });
Seat.hasMany(FlightSeat, { foreignKey: 'SeatNo', sourceKey: 'SeatNo', as: 'flightSeats' });


Passenger.belongsTo(Passenger, { as: 'Guardian', foreignKey: 'GuardianID' });
Passenger.hasMany(Passenger, { as: 'Dependents', foreignKey: 'GuardianID' });


Ticket.belongsTo(Passenger, { foreignKey: 'PassID' });
Passenger.hasMany(Ticket, { foreignKey: 'PassID' });

Ticket.belongsTo(Flight, { foreignKey: 'FlightID' });
Flight.hasMany(Ticket, { foreignKey: 'FlightID' });


Ticket.hasOne(FlightSeat, { foreignKey: 'TicketID', sourceKey: 'TicketID' });
FlightSeat.belongsTo(Ticket, { foreignKey: 'TicketID', targetKey: 'TicketID' });


Flight.hasMany(TicketClass, { foreignKey: 'FlightID', as: 'ticketClasses' });
TicketClass.belongsTo(Flight, { foreignKey: 'FlightID' });


Ticket.belongsTo(Seat, { foreignKey: 'SeatNo', targetKey: 'SeatNo' });
Seat.hasMany(Ticket, { foreignKey: 'SeatNo', sourceKey: 'SeatNo' });
