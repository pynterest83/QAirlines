const { Flight } = require("../../models/schemas");

async function updateFlight(flightID, updates) {
    // Find the flight by its ID
    const flight = await Flight.findByPk(flightID);
    if (!flight) {
        throw new Error('Flight not found');
    }
    if (updates.DepTime && !flight.OriginalDepTime) flight.OriginalDepTime = flight.DepTime;
    if (updates.ArrTime && !flight.OriginalArrTime) flight.OriginalArrTime = flight.ArrTime;
    if (updates.BoardingTime && !flight.OriginalBoardingTime) flight.OriginalBoardingTime = flight.BoardingTime;

    // Apply the updates dynamically
    Object.keys(updates).forEach(key => {
        if (updates[key] !== undefined) {
            flight[key] = updates[key];
        }
    });
    await flight.save();
    return flight;
}

module.exports = { updateFlight };
