import React from 'react';

const StatsCard = ({ totalBookings, totalIncome, availableAirlines, totalFlights }) => {
  return (
    <div className="flex flex-wrap justify-center gap-4 my-8">
      {/* Total Passengers Card */}
      <div className="bg-blue-800 text-white flex-1 max-w-xs rounded-lg shadow-lg p-6 flex flex-col items-center">
        <div className="bg-blue-900 p-4 rounded-full mb-4">
          <i className="fas fa-users text-3xl"></i>
        </div>
        <p className="text-lg">Total Passengers</p>
        <p className="text-3xl font-bold mt-2">{totalBookings}</p>
      </div>

      {/* Amount Card */}
      <div className="bg-green-500 text-white flex-1 max-w-xs rounded-lg shadow-lg p-6 flex flex-col items-center">
        <div className="bg-green-600 p-4 rounded-full mb-4">
          <i className="fas fa-money-bill-wave text-3xl"></i>
        </div>
        <p className="text-lg">Amount</p>
        <p className="text-3xl font-bold mt-2">${totalIncome}</p>
      </div>

      {/* Flights Card */}
      <div className="bg-red-500 text-white flex-1 max-w-xs rounded-lg shadow-lg p-6 flex flex-col items-center">
        <div className="bg-red-600 p-4 rounded-full mb-4">
          <i className="fas fa-plane text-3xl"></i>
        </div>
        <p className="text-lg">Flights</p>
        <p className="text-3xl font-bold mt-2">{totalFlights}</p>
      </div>

      {/* Available Airlines Card */}
      <div className="bg-blue-500 text-white flex-1 max-w-xs rounded-lg shadow-lg p-6 flex flex-col items-center">
        <div className="bg-blue-600 p-4 rounded-full mb-4">
          <i className="fas fa-plane-departure text-3xl"></i>
        </div>
        <p className="text-lg">Available Airlines</p>
        <p className="text-3xl font-bold mt-2">{availableAirlines}</p>
      </div>
    </div>
  );
};

export default StatsCard;