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
            return res.json({ message: 'Ticket booked successfully', tickets });
        } catch (error) {
            console.error('Error booking ticket:', error.message);
            return res.status(500).json({ error: error.message || 'An error occured' });
        }
    },
];

exports.handleCancelTicket = [
    async (req, res) => {
        const { ticketID } = req.body;
        try {
            await ticketService.cancelTicket(ticketID);
            return res.json({ message: 'Ticket canceled successfully' });
        } catch (error) {
            console.error('Error canceling ticket:', error.message);
            return res.status(500).json({ error: error.message || 'An error occurred' });
        }
    },
];

exports.handleGetMyTicket = async (req, res) => {
    const { identifier } = req.query;
    try {
        const tickets = await ticketService.getTicketsByPassenger(identifier);
        return res.json({ tickets });
    } catch (error) {
        console.error('Error fetching tickets:', error.message);
        return res.status(500).json({ error: error.message });
    }
};

exports.handleGetTicketByID = async (req, res) => {
    const { ticketId } = req.query;
    try {
        const ticket = await ticketService.getTicketByID(ticketId);
        return res.json(ticket);
    } catch (error) {
        console.error('Error fetching ticket:', error.message);
        return res.status(500).json({ error: error.message });
    }
};