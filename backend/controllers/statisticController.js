// Thống kê số lượng vé theo tháng
const { getMonthlyBookingStatistic } = require("../services/statistic/statisticService");

exports.handleMonthlyBooking = async (req, res) => {
    try {
        const { year } = req.query;

        // Gọi service để lấy thống kê
        const monthlyStatistics = await getMonthlyBookingStatistic(year);

        res.status(200).json({
            year,
            monthlyStatistics,
        });
    } catch (error) {
        console.error("Error fetching monthly booking statistics:", error.message);
        res.status(500).json({ error: "Failed to fetch monthly booking statistics" });
    }
};