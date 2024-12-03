import { useState } from "react";
import { HiArrowNarrowRight, HiArrowNarrowLeft } from "react-icons/hi";
import { FaCalendarAlt } from "react-icons/fa";
import { AirportData } from "../../assets/data/AirportData";
import {useNavigate} from "react-router-dom";

const TicketBookingBox = () => {
  const [tripType, setTripType] = useState("oneWay");
  const [fromCity, setFromCity] = useState("FROM");
  const [toCity, setToCity] = useState("TO");
  const [departureDate, setDepartureDate] = useState("");
  const [returnDate, setReturnDate] = useState("");
  const [showCityBox, setShowCityBox] = useState(false);
  const [cityType, setCityType] = useState("");
  const nav = useNavigate()
  const today = new Date().toISOString().split("T")[0];
  function SearchFlights() {
    nav("/search", {state:{
        tripType: tripType,
        fromCity: fromCity,
        toCity: toCity,
        departureDate: departureDate,
        returnDate: returnDate
      }})
  }
  const handleCityClick = (type) => {
    setCityType(type);
    setShowCityBox(true);
  }
  const SwapCities = () => {
    let temp = toCity
    setToCity(fromCity)
    setFromCity(temp)
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
      <div className="p-6 h-full">
        <div className="flex space-x-4 mb-6 items-center">
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

        <div className="flex flex-col md:flex-row items-stretch justify-between space-y-4 md:space-y-0">
          <div className="flex-grow flex items-center justify-between p-4 w-full md:w-auto">
            <div
              className="flex-1 w-auto mr-auto flex items-center space-x-2"
              onClick={() => handleCityClick('from')}
            >
              <div className="cursor-pointer border-transparent border hover:border-[#6d24cf] p-2 rounded">
                <p className="text-2xl font-bold">{fromCity}</p>
                <p className="text-gray-500 text-sm">{AirportData[fromCity]}</p>
              </div>
            </div>
            <div onClick={SwapCities} className="flex-1 flex flex-col items-center border-transparent border p-2 rounded hover:border-[#6d24cf]">
              <HiArrowNarrowRight className="text-2xl long-arrow" />
              <HiArrowNarrowLeft className="text-2xl long-arrow" />
            </div>
            <div
              className="flex-1 w-auto ml-auto flex justify-end items-center space-x-2"
              onClick={() => handleCityClick('to')}
            >
              <div className="cursor-pointer border-transparent border hover:border-[#6d24cf] p-2 rounded">
                <p className="text-2xl font-bold">{toCity}</p>
                <p className="text-gray-500 text-sm">{AirportData[toCity]}</p>
              </div>
            </div>
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

          <div className="gradient-border block"></div>

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

          <div className="flex items-center p-4 w-full md:w-auto">
            <button onClick={SearchFlights} className="h-fit w-full py-2 px-6 be-vietnam-pro-bold gradient-button text-white rounded-md hover:bg-[#ffe06f]">
              Search
            </button>
          </div>
        </div>
      </div>
  );
};

export default TicketBookingBox;