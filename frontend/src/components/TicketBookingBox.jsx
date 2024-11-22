import React, { useState } from "react";
import { HiArrowNarrowRight, HiArrowNarrowLeft } from "react-icons/hi";
import { FaCalendarAlt } from "react-icons/fa";
import { AirportData } from "../assets/data/airportData";

const TicketBookingBox = () => {
  const [tripType, setTripType] = useState("oneWay");
  const [fromCity, setFromCity] = useState("FROM");
  const [toCity, setToCity] = useState("TO");
  const [departureDate, setDepartureDate] = useState("");
  const [returnDate, setReturnDate] = useState("");
  const [showPassengerBox, setShowPassengerBox] = useState(false);
  const [showClassBox, setShowClassBox] = useState(false);
  const [showCityBox, setShowCityBox] = useState(false);
  const [cityType, setCityType] = useState("");
  const [adults, setAdults] = useState(1);
  const [children, setChildren] = useState(0);

  // Temporary state for passengers in the modal
  const [tempAdults, setTempAdults] = useState(1);
  const [tempChildren, setTempChildren] = useState(0);

  const [cabinClass, setCabinClass] = useState("Economy");

  const today = new Date().toISOString().split("T")[0];

  const togglePassengerBox = () => {
    setShowPassengerBox(!showPassengerBox);

    // Reset temp state to reflect current state when opening the modal
    if (!showPassengerBox) {
      setTempAdults(adults);
      setTempChildren(children);
    }
  };

  const toggleClassBox = () => {
    setShowClassBox(!showClassBox);
  };

  const increment = (setter, value) => {
    setter(value + 1);
  };

  const decrement = (setter, value, min) => {
    if (value > min) {
      setter(value - 1);
    }
  };

  const handlePassengerDone = () => {
    // Update the main state with temporary values when "Done" is clicked
    setAdults(tempAdults);
    setChildren(tempChildren);
    setShowPassengerBox(false); // Close the modal
  };

  const handleCityClick = (type) => {
    setCityType(type);
    setShowCityBox(true);
  }

  const handleCitySelect = (city) => {
    if (cityType === 'from') {
      if (city === toCity) {
        alert("From city and To city cannot be the same.");
      } else {
        setFromCity(city);
      }
    } else {
      if (city === fromCity) {
        alert("From city and To city cannot be the same.");
      } else {
        setToCity(city);
      }
    }
    setShowCityBox(false);
  };

  const filteredCities = Object.keys(AirportData).filter(
    (city) => city !== fromCity && city !== toCity && city !== 'FROM' && city !== 'TO'
  );

  return (
    <div className="max-w-4xl mx-auto bg-white shadow-md rounded-lg overflow-hidden">
      {/* Booking Container */}
      <div className="p-6">
        {/* Header: Trip Type */}
        <div className="flex space-x-4 mb-6">
          <button
            onClick={() => setTripType("roundTrip")}
            className={`${
              tripType === "roundTrip"
                ? "text-[#6d24cf] font-semibold border-b-4 border-[#ffe06f]"
                : "text-[#778899] font-medium"
            } pb-1`}
          >
            Round Trip
          </button>
          <button
            onClick={() => setTripType("oneWay")}
            className={`${
              tripType === "oneWay"
                ? "text-[#6d24cf] font-semibold border-b-4 border-[#ffe06f]"
                : "text-[#778899] font-medium"
            } pb-1`}
          >
            One Way
          </button>
        </div>

        {/* Flight Details */}
        <div className="flex flex-col md:flex-row items-stretch justify-between space-y-4 md:space-y-0">
          {/* Flight Cities */}
          <div className="flex-grow flex items-center justify-between p-4 w-full md:w-auto">
            <div
              className="flex items-center space-x-2 cursor-pointer hover:border hover:border-[#6d24cf] p-2 rounded"
              onClick={() => handleCityClick('from')}
            >
              <div>
                <p className="text-2xl font-bold">{fromCity}</p>
                <p className="text-gray-500 text-sm">{AirportData[fromCity]}</p>
              </div>
            </div>
            <div className="flex flex-col items-center">
              <HiArrowNarrowRight className="text-2xl long-arrow" />
              <HiArrowNarrowLeft className="text-2xl long-arrow" />
            </div>
            <div
              className="flex items-center space-x-2 cursor-pointer hover:border hover:border-[#6d24cf] p-2 rounded"
              onClick={() => handleCityClick('to')}
            >
              <div>
                <p className="text-2xl font-bold">{toCity}</p>
                <p className="text-gray-500 text-sm">{AirportData[toCity]}</p>
              </div>
            </div>

            {/* City Box */}
            {showCityBox && (
              <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
                <div className="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
                  <h2 className="text-xl font-bold mb-4 text-[#6d24cf]">Choose City</h2>
                  <div className="space-y-2">
                    {filteredCities.map((city) => (
                      <button
                        key={city}
                        onClick={() => handleCitySelect(city)}
                        className="w-full p-2 border rounded-md text-left hover:bg-[#ffe06f] hover:text-[#6d24cf] hover:border-[#6d24cf]"
                      >
                        {city} - {AirportData[city]}
                      </button>
                    ))}
                  </div>
                  <button
                    onClick={() => setShowCityBox(false)}
                    className="mt-4 p-2 bg-gray-200 text-gray-600 rounded-md w-full hover:bg-[#ffe06f] hover:text-black"
                  >
                    Cancel
                  </button>
                </div>
              </div>
            )}
          </div>

          {/* Divider */}
          <div className="gradient-border block"></div>

          {/* Dates */}
          <div className="p-4 w-full md:w-auto">
            <div className="flex flex-col">
              <label className="flex items-center space-x-2">
                <FaCalendarAlt className="text-gray-500" />
                <span className="text-gray-500 text-sm">Departure Date</span>
              </label>
              <input
                type="date"
                value={departureDate}
                onChange={(e) => setDepartureDate(e.target.value)}
                min={today}
                className="mt-1 p-2 border rounded-md w-full hover:border-[#6d24cf]"
              />
              {tripType === "roundTrip" && (
                <div className="mt-4">
                  <label className="flex items-center space-x-2">
                    <FaCalendarAlt className="text-gray-500" />
                    <span className="text-gray-500 text-sm">Return Date</span>
                  </label>
                  <input
                    type="date"
                    value={returnDate}
                    onChange={(e) => setReturnDate(e.target.value)}
                    min={today}
                    className="mt-1 p-2 border rounded-md w-full hover:border-[#6d24cf]"
                  />
                </div>
              )}
            </div>
          </div>

          {/* Divider */}
          <div className="gradient-border block"></div>

          {/* Passenger Info */}
          <div className="p-4 w-full md:w-auto">
            <div onClick={togglePassengerBox} className="cursor-pointer mb-4">
              <p className="text-sm text-gray-500">Passenger(s)</p>
              <p className="font-semibold border-b border-gray-300 pb-2 hover:border-[#6d24cf]">
                {adults} Adult{adults > 1 ? "s" : ""}, {children} Child
                {children > 1 ? "ren" : ""}
              </p>
            </div>
            <div onClick={toggleClassBox} className="cursor-pointer">
              <p className="text-sm text-gray-500">Cabin Class</p>
              <p className="font-semibold border-b border-gray-300 pb-2 hover:border-[#6d24cf]">
                {cabinClass}
              </p>
            </div>

            {/* Passenger Box */}
            {showPassengerBox && (
              <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
                <div className="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
                  <h2 className="text-[#6d24cf] font-bold mb-4">Select Passengers</h2>

                  <div className="space-y-4">
                    {/* Adults */}
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="text-lg font-semibold">Adults</p>
                        <p className="text-sm text-gray-500">12+ years</p>
                      </div>
                      <div className="flex items-center space-x-4">
                        <button
                          className="w-8 h-8 flex items-center justify-center border rounded-full hover:bg-[#ffe06f]"
                          onClick={() => decrement(setTempAdults, tempAdults, 1)}
                        >
                          -
                        </button>
                        <span className="text-lg">{tempAdults}</span>
                        <button
                          className="w-8 h-8 flex items-center justify-center border rounded-full hover:bg-[#ffe06f]"
                          onClick={() => increment(setTempAdults, tempAdults)}
                        >
                          +
                        </button>
                      </div>
                    </div>

                    {/* Children */}
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="text-lg font-semibold">Children</p>
                        <p className="text-sm text-gray-500">2-11 years</p>
                      </div>
                      <div className="flex items-center space-x-4">
                        <button
                          className="w-8 h-8 flex items-center justify-center border rounded-full hover:bg-[#ffe06f]"
                          onClick={() => decrement(setTempChildren, tempChildren, 0)}
                        >
                          -
                        </button>
                        <span className="text-lg">{tempChildren}</span>
                        <button
                          className="w-8 h-8 flex items-center justify-center border rounded-full hover:bg-[#ffe06f]"
                          onClick={() => increment(setTempChildren, tempChildren)}
                        >
                          +
                        </button>
                      </div>
                    </div>
                  </div>

                  {/* Footer */}
                  <div className="mt-6 flex items-center justify-between">
                    <button
                      className="p-2 bg-gray-200 text-gray-600 rounded-md hover:bg-[#ffe06f] hover:text-black"
                      onClick={togglePassengerBox}
                    >
                      Cancel
                    </button>
                    <button
                      className="p-2 bg-[#6d24cf] text-white rounded-md hover:bg-[#ffe06f] hover:text-black"
                      onClick={handlePassengerDone}
                    >
                      Done
                    </button>
                  </div>
                </div>
              </div>
            )}

            {/* Class Box */}
            {showClassBox && (
              <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
                <div className="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
                  {/* Modal Header */}
                  <h2 className="text-2xl font-bold mb-6 text-center text-[#6d24cf]">
                    Select Cabin Class
                  </h2>

                  {/* Class Options */}
                  <div className="space-y-4">
                    <button
                      onClick={() => {
                        setCabinClass("Economy");
                        setShowClassBox(false);
                      }}
                      className={`w-full p-3 border rounded-md text-left ${
                        cabinClass === "Economy"
                          ? "bg-[#ffe06f] text-[#6d24cf] font-semibold border-[#6d24cf]"
                          : "text-gray-700 hover:bg-[#ffe06f]"
                      }`}
                    >
                      Economy
                    </button>
                    <button
                      onClick={() => {
                        setCabinClass("Business");
                        setShowClassBox(false);
                      }}
                      className={`w-full p-3 border rounded-md text-left ${
                        cabinClass === "Business"
                          ? "bg-[#ffe06f] text-[#6d24cf] font-semibold border-[#6d24cf]"
                          : "text-gray-700 hover:bg-[#ffe06f]"
                      }`}
                    >
                      Business
                    </button>
                    <button
                      onClick={() => {
                        setCabinClass("First Class");
                        setShowClassBox(false);
                      }}
                      className={`w-full p-3 border rounded-md text-left ${
                        cabinClass === "First Class"
                          ? "bg-[#ffe06f] text-[#6d24cf] font-semibold border-[#6d24cf]"
                          : "text-gray-700 hover:bg-[#ffe06f]"
                      }`}
                    >
                      First Class
                    </button>
                  </div>

                  {/* Footer */}
                  <div className="mt-6 flex items-center justify-center">
                    <button
                      className="p-2 bg-gray-200 text-gray-600 rounded-md w-32 hover:bg-[#ffe06f] hover:text-black"
                      onClick={toggleClassBox}
                    >
                      Cancel
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>

          {/* Divider */}
          <div className="gradient-border block"></div>

          <div className="p-4 w-full md:w-auto">
            <div className="cursor-pointer mb-4">
              <button className="w-full p-2 gradient-button text-white rounded-md hover:bg-[#ffe06f]">
                Search
              </button>
            </div>
            <div className="cursor-pointer">
              <p className="text-sm text-gray-500">Discount Code</p>
              <input
                id="discountInput"
                type="text"
                placeholder="Enter code here"
                className="border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-none focus:ring-1 focus:ring-[#6d24cf] focus:border-[#6d24cf] w-32"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TicketBookingBox;