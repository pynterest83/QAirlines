import {useEffect, useRef, useState} from "react";
import {FaCalendarAlt } from "react-icons/fa";
import {useNavigate} from "react-router-dom";
import {HiArrowNarrowRight, HiArrowNarrowLeft} from "react-icons/hi";
import cityList from "../../airports.json";

const TicketBookingBox = () => {
  const [tripType, setTripType] = useState("oneWay");
  const [fromCity, setFromCity] = useState("");
  const [toCity, setToCity] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [returnDate, setReturnDate] = useState("");
  const fromInputRef = useRef(null);
  const toInputRef = useRef(null);
  const [fromSuggestions, setFromSuggestions] = useState([]);
  const [toSuggestions, setToSuggestions] = useState([]);
  const [fromSelectedIndex, setFromSelectedIndex] = useState(-1);
  const [toSelectedIndex, setToSelectedIndex] = useState(-1);
  const nav = useNavigate()
  const today = new Date().toISOString().split("T")[0];
  function SearchFlights() {
    if (!fromCity || !toCity || !departureDate || (tripType === 'roundTrip' && !returnDate)) return
    nav("/search", {state:{
        tripType: tripType,
        fromCity: fromCity.slice(0, fromCity.length - 1).split("(").pop(),
        toCity: toCity.slice(0, toCity.length - 1).split("(").pop(),
        departureDate: departureDate,
        returnDate: returnDate
      }})
  }
  function checker(e) {
    if (!e.target.value) e.target.setCustomValidity("error")
    else e.target.setCustomValidity("")
  }
  const SwapCities = () => {
    let temp = toCity
    setToCity(fromCity)
    setFromCity(temp)
  }
  const handleClickOutside = (event) => {
    if (fromInputRef.current && !fromInputRef.current.contains(event.target)) {
      setFromSuggestions([]);
    }
    if (toInputRef.current && !toInputRef.current.contains(event.target)) {
      setToSuggestions([]);
    }
  };
  useEffect(() => {
    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);
  const handleKeyDown = (e, suggestions, selectedIndex, setSelectedIndex, setCity, setSuggestions, otherCity) => {
    if (e.key === "ArrowDown") {
      setSelectedIndex((prevIndex) => (prevIndex + 1) % suggestions.length);
    } else if (e.key === "ArrowUp") {
      setSelectedIndex((prevIndex) => (prevIndex - 1 + suggestions.length) % suggestions.length);
    } else if (e.key === "Enter" && selectedIndex >= 0) {
      handleSuggestionClick(suggestions[selectedIndex], setCity, setSuggestions, otherCity);
    }
  };
  const handleSuggestionClick = (city, setCity, setSuggestions, otherCity) => {
    if (city !== otherCity) {
      setCity(city[2] + " (" + city[0] + ")");
      setSuggestions([]);
    }
  };
  const handleFromCityChange = (e) => {
    const value = e.target.value.toUpperCase();
    setFromCity(value);
    if (!value.length) {
      setFromSuggestions([])
      return
    }
    setFromSuggestions(
        cityList.filter((e) => e[0].startsWith(value))
    );
    setFromSelectedIndex(-1);
  };
  const handleToCityChange = (e) => {
    const value = e.target.value.toUpperCase();
    setToCity(value);
    if (!value.length) {
      setFromSuggestions([])
      return
    }
    setToSuggestions(
        cityList.filter((e) => e[0].startsWith(value))
    )
    setToSelectedIndex(-1);
  };

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
            <div className="relative flex flex-col" ref={fromInputRef}>
              <input
                  id="fromCity"
                  type="text"
                  value={fromCity}
                  onChange={(e) => {checker(e); handleFromCityChange(e)}}
                  onKeyDown={(e) => handleKeyDown(e, fromSuggestions, fromSelectedIndex, setFromSelectedIndex, setFromCity, setFromSuggestions, toCity)}
                  placeholder=" "
                  className="invalid:shadow-[0_0_0_1px_red] peer pb-2 pt-6 pl-4 border rounded-md w-full focus:border-[#6d24cf] focus:outline-none"
              />
              <label
                  htmlFor="fromCity"
                  className="absolute top-2 left-3 text-gray-500 text-xs transition-all duration-200 ease-in-out transform peer-placeholder-shown:top-4 peer-placeholder-shown:left-4 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-focus:top-2 peer-focus:left-4 peer-focus:text-xs peer-focus:text-[#6d24cf]"
              >
                From
              </label>
              {fromSuggestions.length > 0 && (
                  <ul className="max-h-[240px] no-scrollbar overflow-scroll absolute top-full left-0 w-full bg-white border rounded-md mt-1 z-10">
                    {fromSuggestions.map((city, index) => (
                        <li
                            key={index}
                            className={`p-2 cursor-pointer hover:bg-gray-200 ${index === fromSelectedIndex ? "bg-gray-200" : ""}`}
                            onClick={() => handleSuggestionClick(city, setFromCity, setFromSuggestions, toCity)}
                        >
                          <div>
                            <div className="be-vietnam-pro-bold">{city[0]}</div>
                            <div className="text-sm be-vietnam-pro-medium">{city[1]}</div>
                          </div>
                          <div className="text-xs be-vietnam-pro-medium">
                            <div>{city[2]}</div>
                            <div>{city[3]}</div>
                          </div>
                        </li>
                    ))}
                  </ul>
              )}
            </div>
            <div onClick={SwapCities}
                 className="flex-1 flex flex-col items-center border-transparent border p-2 rounded hover:border-[#6d24cf]">
              <HiArrowNarrowRight className="text-2xl long-arrow"/>
              <HiArrowNarrowLeft className="text-2xl long-arrow"/>
            </div>
            <div className="relative flex flex-col" ref={toInputRef}>
              <input
                  id="toCity"
                  type="text"
                  value={toCity}
                  onChange={(e) => {checker(e); handleToCityChange(e)}}
                  onKeyDown={(e) => handleKeyDown(e, toSuggestions, toSelectedIndex, setToSelectedIndex, setToCity, setToSuggestions, fromCity)}
                  placeholder=" "
                  className="invalid:shadow-[0_0_0_1px_red] peer pb-2 pt-6 pl-4 border rounded-md w-full focus:border-[#6d24cf] focus:outline-none"
              />
              <label
                  htmlFor="toCity"
                  className="absolute top-2 left-3 text-gray-500 text-xs transition-all duration-200 ease-in-out transform peer-placeholder-shown:top-4 peer-placeholder-shown:left-4 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-focus:top-2 peer-focus:left-4 peer-focus:text-xs peer-focus:text-[#6d24cf]"
              >
                To
              </label>
              {toSuggestions.length > 0 && (
                  <ul className="max-h-[240px] no-scrollbar overflow-scroll absolute top-full left-0 w-full bg-white border rounded-md mt-1 z-10">
                    {toSuggestions.map((city, index) => (
                        <li
                            key={index}
                            className={`p-2 cursor-pointer hover:bg-gray-200 ${index === toSelectedIndex ? "bg-gray-200" : ""}`}
                            onClick={() => handleSuggestionClick(city, setToCity, setToSuggestions, fromCity)}
                        >
                          <div>
                            <div className="be-vietnam-pro-bold">{city[0]}</div>
                            <div className="text-sm be-vietnam-pro-medium">{city[1]}</div>
                          </div>
                          <div className="text-xs be-vietnam-pro-medium">
                            <div>{city[2]}</div>
                            <div>{city[3]}</div>
                          </div>
                        </li>
                    ))}
                  </ul>
              )}
            </div>
          </div>

          <div className="gradient-border block"></div>

          <div className="p-4 w-full md:w-auto">
            <div className="flex flex-col">
              <label className="flex items-center space-x-2">
                <FaCalendarAlt className="text-gray-500"/>
                <span className="text-gray-500 text-sm">Departure Date</span>
              </label>
              <input
                  type="date"
                  value={departureDate}
                  onChange={(e) => {setDepartureDate(e.target.value); checker(e)}}
                  min={today}
                  className="invalid:shadow-[0_0_0_1px_red] mt-1 p-2 border rounded-md w-full hover:border-[#6d24cf]"
              />
              {tripType === "roundTrip" && (
                  <div className="mt-4">
                    <label className="flex items-center space-x-2">
                      <FaCalendarAlt className="text-gray-500"/>
                      <span className="text-gray-500 text-sm">Return Date</span>
                    </label>
                    <input
                        type="date"
                        value={returnDate}
                        onChange={(e)=> { setReturnDate(e.target.value); checker(e)}}
                        min={today}
                        className="invalid:shadow-[0_0_0_1px_red] mt-1 p-2 border rounded-md w-full hover:border-[#6d24cf]"
                    />
                  </div>
              )}
            </div>
          </div>

          {/* Divider */}
          <div className="gradient-border block"></div>

          <div className="flex items-center p-4 w-full md:w-auto">
            <button onClick={SearchFlights}
                    className="h-fit w-full py-2 px-6 be-vietnam-pro-bold gradient-button text-white rounded-md hover:bg-[#ffe06f]">
              Search
            </button>
          </div>
        </div>
      </div>
  );
};

export default TicketBookingBox;