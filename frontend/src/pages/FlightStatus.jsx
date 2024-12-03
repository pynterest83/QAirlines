import { useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import { AirportData } from "../assets/data/AirportData";
import FlightBox from "../components/FlightStatus/FlightBox";
import Navigation from "../components/Navigation";
import { Server } from "../Server";

const FlightStatus = () => {
  const [fromCity, setFromCity] = useState("");
  const [toCity, setToCity] = useState("");
  const [departureDate, setDepartureDate] = useState(new Date().toISOString().split("T")[0]);
  const [fromSuggestions, setFromSuggestions] = useState([]);
  const [toSuggestions, setToSuggestions] = useState([]);
  const [fromSelectedIndex, setFromSelectedIndex] = useState(-1);
  const [toSelectedIndex, setToSelectedIndex] = useState(-1);
  const [errorMessage, setErrorMessage] = useState("");
  const [flightsByDate, setFlightsByDate] = useState([]);
  const [flightsByFlightID, setFlightsByFlightID] = useState([]);
  const [searchType, setSearchType] = useState("date");
  const [flightID, setFlightID] = useState("");
  const [isFirstTimeDate, setIsFirstTimeDate] = useState(true);
  const [isFirstTimeFlightID, setIsFirstTimeFlightID] = useState(true);
  const today = new Date().toISOString().split("T")[0];

  const fromInputRef = useRef(null);
  const toInputRef = useRef(null);

  useEffect(() => {
    const fetchFlights = async () => {
      try {
        let response;
        if (searchType === "date" && isFirstTimeDate) {
          response = await fetch(Server + `offers/by-date?date=${departureDate}`);
          setIsFirstTimeDate(false);
        } else if (searchType === "FlightID" && isFirstTimeFlightID) {
          response = await fetch(Server + `flights/list`);
          setIsFirstTimeFlightID(false);
        } else {
          return;
        }

        if (response.status === 404) {
          if (searchType === "date") {
            setFlightsByDate([]);
          } else {
            setFlightsByFlightID([]);
          }
        } else {
          const data = await response.json();
          if (searchType === "date") {
            setFlightsByDate(data.flights || []);
          } else {
            setFlightsByFlightID(data.flights || []);
          }
        }
      } catch (error) {
        console.error("Error fetching flights:", error);
      }
    };

    fetchFlights();

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [searchType, isFirstTimeDate, isFirstTimeFlightID]);

  const handleFromCityChange = (e) => {
    const value = e.target.value.toUpperCase();
    setFromCity(value);
    setFromSuggestions(
      Object.entries(AirportData)
        .filter(([code, city]) => 
          (city.toUpperCase().includes(value) || code.includes(value)) &&
          city !== toCity && code !== 'FROM' && code !== 'TO'
        )
        .map(([code, city]) => `${city} (${code})`)
    );
    setFromSelectedIndex(-1);
  };

  const handleToCityChange = (e) => {
    const value = e.target.value.toUpperCase();
    setToCity(value);
    setToSuggestions(
      Object.entries(AirportData)
        .filter(([code, city]) => 
          (city.toUpperCase().includes(value) || code.includes(value)) &&
          city !== fromCity && code !== 'FROM' && code !== 'TO'
        )
        .map(([code, city]) => `${city} (${code})`)
    );
    setToSelectedIndex(-1);
  };

  const handleSuggestionClick = (city, setCity, setSuggestions, otherCity, cityType) => {
    if (city === otherCity) {
      setErrorMessage("From city and To city cannot be the same.");
    } else {
      setCity(city);
      setSuggestions([]);
      setErrorMessage("");
    }
  };

  const handleKeyDown = (e, suggestions, selectedIndex, setSelectedIndex, setCity, setSuggestions, otherCity, cityType) => {
    if (e.key === "ArrowDown") {
      setSelectedIndex((prevIndex) => (prevIndex + 1) % suggestions.length);
    } else if (e.key === "ArrowUp") {
      setSelectedIndex((prevIndex) => (prevIndex - 1 + suggestions.length) % suggestions.length);
    } else if (e.key === "Enter" && selectedIndex >= 0) {
      handleSuggestionClick(suggestions[selectedIndex], setCity, setSuggestions, otherCity, cityType);
    }
  };

  const handleClickOutside = (event) => {
    if (fromInputRef.current && !fromInputRef.current.contains(event.target)) {
      setFromSuggestions([]);
    }
    if (toInputRef.current && !toInputRef.current.contains(event.target)) {
      setToSuggestions([]);
    }
    setErrorMessage("");
  };

  const SearchFlights = async () => {
    try {
      let response;
      if (searchType === "date") {
        if (fromCity === toCity) {
          setErrorMessage("From and To cities cannot be the same.");
          return;
        }
      
        // Extract city codes from fromCity and toCity
        const fromCityCode = fromCity.match(/\(([^)]+)\)/)?.[1] || fromCity;
        const toCityCode = toCity.match(/\(([^)]+)\)/)?.[1] || toCity;
      
        if (!toCityCode) {
          // Fetch all flights if toCityCode is blank
          response = await fetch(`${Server}flights/list`);
        } else {
          // Fetch one-way flights
          response = await fetch(
            `${Server}offers/one-way?departure=${fromCityCode}&destination=${toCityCode}&departure_date=${departureDate}`
          );
        }
      } else if (searchType === "FlightID") {
        if (flightID.length !== 5) {
          setErrorMessage("Flight ID must be exactly 5 characters long.");
          return;
        }
        response = await fetch(`${Server}flights/list?flightIds=${flightID}`);
      }

      if (response.status === 404) {
        if (searchType === "date") {
          setFlightsByDate([]);
        } else {
          setFlightsByFlightID([]);
        }
      } else {
        const data = await response.json();
        if (searchType === "date") {
          setFlightsByDate(data.flights || []);
        } else {
          setFlightsByFlightID(data.flights || []);
        }
      }
    } catch (error) {
      console.error("Error fetching flights:", error);
    }
  };

  return (
    <div className="relative">
      <Navigation selecting={"booking"} />
      <div className="max-w-[1000px] mx-auto p-4">
        <div className="sticky top-[64px] bg-white z-20 p-4 rounded-lg shadow-md">
          <div className="flex space-x-4 mb-6 items-center">
            <button
              onClick={() => setSearchType("date")}
              className={`${
                searchType === "date"
                  ? "text-[#6d24cf] font-semibold border-b-4 border-[#ffe06f]"
                  : "text-[#778899] font-medium"
              } pb-1`}
            >
              Destination
            </button>
            <button
              onClick={() => setSearchType("FlightID")}
              className={`${
                searchType === "FlightID"
                  ? "text-[#6d24cf] font-semibold border-b-4 border-[#ffe06f]"
                  : "text-[#778899] font-medium"
              } pb-1`}
            >
              Flight ID
            </button>
          </div>
          {searchType === "date" ? (
            <div className="relative z-10 grid grid-cols-1 md:grid-cols-4 gap-4 bg-white rounded-lg shadow-md p-6">
              {/* From Input */}
              <div className="relative flex flex-col" ref={fromInputRef}>
                <input
                  id="fromCity"
                  type="text"
                  value={fromCity}
                  onChange={handleFromCityChange}
                  onKeyDown={(e) => handleKeyDown(e, fromSuggestions, fromSelectedIndex, setFromSelectedIndex, setFromCity, setFromSuggestions, toCity, 'from')}
                  placeholder=" "
                  className="peer pb-2 pt-6 pl-4 border rounded-md w-full focus:border-[#6d24cf] focus:outline-none"
                />
                <label
                  htmlFor="fromCity"
                  className="absolute top-2 left-3 text-gray-500 text-xs transition-all duration-200 ease-in-out transform peer-placeholder-shown:top-4 peer-placeholder-shown:left-4 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-focus:top-2 peer-focus:left-4 peer-focus:text-xs peer-focus:text-[#6d24cf]"
                >
                  From
                </label>
                {fromSuggestions.length > 0 && (
                  <ul className="absolute top-full left-0 w-full bg-white border rounded-md mt-1 z-10">
                    {fromSuggestions.map((city, index) => (
                      <li
                        key={index}
                        className={`p-2 cursor-pointer hover:bg-gray-200 ${index === fromSelectedIndex ? "bg-gray-200" : ""}`}
                        onClick={() => handleSuggestionClick(city, setFromCity, setFromSuggestions, toCity, 'from')}
                      >
                        {city}
                      </li>
                    ))}
                  </ul>
                )}
              </div>

              {/* To Input */}
              <div className="relative flex flex-col" ref={toInputRef}>
                <input
                  id="toCity"
                  type="text"
                  value={toCity}
                  onChange={handleToCityChange}
                  onKeyDown={(e) => handleKeyDown(e, toSuggestions, toSelectedIndex, setToSelectedIndex, setToCity, setToSuggestions, fromCity, 'to')}
                  placeholder=" "
                  className="peer pb-2 pt-6 pl-4 border rounded-md w-full focus:border-[#6d24cf] focus:outline-none"
                />
                <label
                  htmlFor="toCity"
                  className="absolute top-2 left-3 text-gray-500 text-xs transition-all duration-200 ease-in-out transform peer-placeholder-shown:top-4 peer-placeholder-shown:left-4 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-focus:top-2 peer-focus:left-4 peer-focus:text-xs peer-focus:text-[#6d24cf]"
                >
                  To
                </label>
                {toSuggestions.length > 0 && (
                  <ul className="absolute top-full left-0 w-full bg-white border rounded-md mt-1 z-10">
                    {toSuggestions.map((city, index) => (
                      <li
                        key={index}
                        className={`p-2 cursor-pointer hover:bg-gray-200 ${index === toSelectedIndex ? "bg-gray-200" : ""}`}
                        onClick={() => handleSuggestionClick(city, setToCity, setToSuggestions, fromCity, 'to')}
                      >
                        {city}
                      </li>
                    ))}
                  </ul>
                )}
              </div>

              {/* Date Input */}
              <div className="relative flex flex-col">
                <input
                  id="departureDate"
                  type="date"
                  value={departureDate}
                  onChange={(e) => setDepartureDate(e.target.value)}
                  min={today}
                  placeholder=" "
                  className="peer pb-2 pt-6 pl-4 pr-2 border rounded-md w-full focus:border-[#6d24cf] focus:outline-none"
                />
                <label
                  htmlFor="departureDate"
                  className="absolute top-2 left-3 text-gray-500 text-xs transition-all duration-200 ease-in-out transform peer-placeholder-shown:top-4 peer-placeholder-shown:left-4 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-focus:top-2 peer-focus:left-4 peer-focus:text-xs peer-focus:text-[#6d24cf]"
                >
                  Departure Date
                </label>
              </div>

              {/* Search Button */}
              <div className="flex items-center">
                <button
                  onClick={SearchFlights}
                  className="h-fit w-full py-3 px-6 gradient-button text-white rounded-md hover:bg-[#ffe06f]"
                >
                  Search
                </button>
              </div>
            </div>
          ) : (
            <div className="relative z-10 grid grid-cols-1 md:grid-cols-2 gap-4 bg-white rounded-lg shadow-md p-6 md:flex md:space-x-4">
              {/* Flight ID Input */}
              <div className="relative flex flex-col md:flex-1">
                <input
                  id="flightID"
                  type="text"
                  value={flightID}
                  onChange={(e) => setFlightID(e.target.value)}
                  placeholder=" "
                  className="peer pb-2 pt-6 pl-4 border rounded-md w-full focus:border-[#6d24cf] focus:outline-none"
                />
                <label
                  htmlFor="flightID"
                  className="absolute top-2 left-3 text-gray-500 text-xs transition-all duration-200 ease-in-out transform peer-placeholder-shown:top-4 peer-placeholder-shown:left-4 peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-400 peer-focus:top-2 peer-focus:left-4 peer-focus:text-xs peer-focus:text-[#6d24cf]"
                >
                  Flight ID (e.g. VN123)
                </label>
              </div>

              {/* Search Button */}
              <div className="flex items-center md:flex-none">
                <button
                  onClick={SearchFlights}
                  className="h-fit w-full py-3 px-6 gradient-button text-white rounded-md hover:bg-[#ffe06f]"
                >
                  Search
                </button>
              </div>
            </div>
          )}
        </div>
        {errorMessage && <div className="text-red-500 mt-2">{errorMessage}</div>}
        {searchType === "date" ? (
          Array.isArray(flightsByDate) && flightsByDate.length > 0 ? (
            flightsByDate.map((flight, index) => <FlightBox key={index} {...flight} />)
          ) : (
            <div className="my-4 w-[95%] md:w-4/6 h-fit mx-auto bg-white rounded-2xl border border-black p-4">
              <img className="h-24 mx-auto" src="/no-results.png" alt="Not found" />
              <div className="be-vietnam-pro-bold mx-auto text-xl text-center mt-8">
                No flights found.
              </div>
              <div className="be-vietnam-pro-medium mx-auto text-base text-center mt-1">
                We couldn&#39;t find any flight on this day. Consider trying a different date.
              </div>
            </div>
          )
        ) : (
          Array.isArray(flightsByFlightID) && flightsByFlightID.length > 0 ? (
            flightsByFlightID.map((flight, index) => <FlightBox key={index} {...flight} />)
          ) : (
            <div className="my-4 w-[95%] md:w-4/6 h-fit mx-auto bg-white rounded-2xl border border-black p-4">
              <img className="h-24 mx-auto" src="/no-results.png" alt="Not found" />
              <div className="be-vietnam-pro-bold mx-auto text-xl text-center mt-8">
                No flights found.
              </div>
              <div className="be-vietnam-pro-medium mx-auto text-base text-center mt-1">
                We couldn&#39;t find any flight with this ID. Consider trying a different ID.
              </div>
            </div>
          )
        )}
      </div>
    </div>
  );
};

export default FlightStatus;