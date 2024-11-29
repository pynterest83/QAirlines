require('../middlewares/validateInput');
const offerService = require('../services/offers/offerService');

// Xử lý chuyến bay khứ hồi
exports.getRoundTripFlights = [
    async (req, res) => {
        const { departure, destination, departure_date, return_date } = req.query;
        try {
            const { outboundFlights, returnFlights } = await offerService.queryRoundTrip(departure, destination, departure_date, return_date);

            if (outboundFlights.length === 0 || returnFlights.length === 0) {
                return res.status(404).json({ error: 'Không tìm thấy chuyến bay khứ hồi phù hợp' });
            }

            res.json(offerService.formatRoundTripResults(outboundFlights, returnFlights));
        } catch (error) {
            console.error('Error fetching round-trip flights:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra' });
        }
    },
];

// Xử lý chuyến bay một chiều
exports.getOneWayFlights = [
    async (req, res) => {
        const { departure, destination, departure_date } = req.query;
        try {
            const flights = await offerService.queryOneWay(departure, destination, departure_date);

            if (flights.length === 0) {
                return res.status(404).json({ error: 'Không tìm thấy chuyến bay một chiều phù hợp' });
            }

            res.json(offerService.formatOneWayResults(flights));
        } catch (error) {
            console.error('Error fetching one-way flights:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra' });
        }
    },
];

// Xử lý chuyến bay trong khoảng thời gian
exports.getFlightsWithinRange = [
    async (req, res) => {
        const { departure, destination, start_date, end_date, ticket_class = 'Economy' } = req.query;
        try {
            const flights = await offerService.queryFlightsWithinRange(departure, destination, start_date, end_date, ticket_class);

            if (flights.length === 0) {
                return res.status(404).json({ error: 'Không tìm thấy chuyến bay phù hợp' });
            }

            res.json(offerService.formatFlightsWithinRangeResults(flights));
        } catch (error) {
            console.error('Error fetching flights within range:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra' });
        }
    },
]

// Xử lý chuyến bay theo ngày
exports.getFlightsByDate = [
    async (req, res) => {
        const { date } = req.query;
        try {
            const flights = await offerService.queryFlightsByDate(date);

            if (flights.length === 0) {
                return res.status(404).json({ error: 'Không tìm thấy chuyến bay phù hợp' });
            }

            res.json(offerService.formatFlightsByDateResults(flights));
        } catch (error) {
            console.error('Error fetching flights by date:', error.message);
            res.status(500).json({ error: error.message || 'Có lỗi xảy ra' });
        }
    },
]