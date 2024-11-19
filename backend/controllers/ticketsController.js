const validate = require('../middlewares/validateInput');
const { bookTicketSchema, cancelTicketSchema } = require('../validations/ticketValidation');
const ticketService = require('../services/tickets/ticketService');

// Xử lý đặt vé
exports.handleBookTicket = [
    validate(bookTicketSchema, 'body'), // Kiểm tra body request
    async (req, res) => {
        const { flightID, passengers } = req.body;

        try {
            // Xử lý logic đặt vé
            const tickets = await Promise.all(
                passengers.map(async (passenger) => {
                    const { seatNo, ...info } = passenger;
                    const pass = await ticketService.findOrCreatePassenger(info);
                    return ticketService.bookTicket(flightID, seatNo, pass.PassID);
                })
            );

            res.json({ message: 'Đặt vé thành công', tickets });
        } catch (error) {
            console.error('Error booking ticket:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra khi đặt vé' });
        }
    },
];

// Xử lý hủy vé
exports.handleCancelTicket = [
    validate(cancelTicketSchema, 'body'), // Kiểm tra body request
    async (req, res) => {
        const { ticketID } = req.body;

        try {
            await ticketService.cancelTicket(ticketID);
            res.json({ message: 'Hủy vé thành công' });
        } catch (error) {
            console.error('Error canceling ticket:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra khi hủy vé' });
        }
    },
];
