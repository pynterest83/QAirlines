const Flight = require('../../models/schemas/Flight');

async function delayFlight(flightID, newTimes) {
    const { DepTime, ArrTime, BoardingTime } = newTimes;

    const flight = await Flight.findByPk(flightID);
    if (!flight) {
        throw new Error('Flight not found');
    }

    if (
        (DepTime && DepTime <= flight.DepTime) ||
        (ArrTime && ArrTime <= flight.ArrTime) ||
        (BoardingTime && BoardingTime <= flight.BoardingTime)
    ) {
        throw new Error('New times must be later than the current times');
    }

    if (!flight.OriginalDepTime && DepTime) flight.OriginalDepTime = flight.DepTime;
    if (!flight.OriginalArrTime && ArrTime) flight.OriginalArrTime = flight.ArrTime;
    if (!flight.OriginalBoardingTime && BoardingTime) flight.OriginalBoardingTime = flight.BoardingTime;

    flight.DepTime = DepTime || flight.DepTime;
    flight.ArrTime = ArrTime || flight.ArrTime;
    flight.BoardingTime = BoardingTime || flight.BoardingTime;

    await flight.save();
    return flight;
}

module.exports = { delayFlight };