require('../middlewares/validateInput');
const ticketService = require('../services/tickets/ticketService');

exports.handleBookTicket = [
    async (req, res) => {
        const { flightID, passengers } = req.body;

        try {
                        const tickets = await Promise.all(
                passengers.map(async (passenger) => {
                    const { seatNo, ...info } = passenger;
                    const pass = await ticketService.findOrCreatePassenger(info);
                    return ticketService.bookTicket(flightID, seatNo, pass.PassID);
                })
            );

            res.json({ message: 'Ticket booked successfully', tickets });
        } catch (error) {
            console.error('Error booking ticket:', error.message);
            res.status(500).json({ error: error.message || 'An error occured' });
        }
    },
];

exports.handleCancelTicket = [
    async (req, res) => {
        const { ticketID } = req.body;

        try {
            await ticketService.cancelTicket(ticketID);
            res.json({ message: 'Ticket canceled successfully' });
        } catch (error) {
            console.error('Error canceling ticket:', error.message);
            res.status(500).json({ error: error.message || 'An error occurred' });
        }
    },
];

exports.handleGetMyTicket = async (req, res) => {
    const { identifier } = req.query;

    try {

        const tickets = await ticketService.getTicketsByPassenger(identifier);
        res.json({ tickets });
    } catch (error) {
        console.error('Error fetching tickets:', error.message);
        res.status(500).json({ error: error.message });
    }
};

exports.handleGetTicketByID = async (req, res) => {
    const { ticketId } = req.query;

    try {
        const ticket = await ticketService.getTicketByID(ticketId);
        res.json(ticket);
    } catch (error) {
        console.error('Error fetching ticket:', error.message);
        res.status(500).json({ error: error.message });
    }
};