import {useLocation} from "react-router-dom";
import {useEffect, useRef, useState} from "react";
import {Server} from "../Server.js";
import Flights from "../components/Search/Flights.jsx";
import Navigation from "../components/Navigation.jsx";
import {HiArrowNarrowRight} from "react-icons/hi";
import {HiArrowsRightLeft } from "react-icons/hi2";
import {FaCalendarAlt} from "react-icons/fa";
import DateSelect from "../components/Search/DateSelect.jsx"

function Search() {
    const props = useLocation().state
    const [flights, setFlights] = useState(null)
    const [from] = useState(props.fromCity)
    const [to] = useState(props.toCity)
    const [departure, setDeparture] = useState(props.departureDate)
    const [returnDate, setReturn] = useState(props.returnDate)
    const [showPassengerBox, setShowPassengerBox] = useState(false)
    const [adults, setAdults] = useState(1)
    const [children, setChildren] = useState(0)
    const [tempAdults, setTempAdults] = useState(1)
    const [tempChildren, setTempChildren] = useState(0)
    const [cabinClass, setCabinClass] = useState("Economy");
    const [showClassBox, setShowClassBox] = useState(false);
    const departureInput = useRef(null)
    const returnInput = useRef(null)
    const toggleClassBox = () => {
        setShowClassBox(!showClassBox);
    }
    useEffect(() => {
        if (!props) return
        if (props.tripType === "oneWay") {
            fetch(Server + "offers/one-way?" + new URLSearchParams({
                departure: props.fromCity,
                destination: props.toCity,
                departure_date: props.departureDate
            }), {
                method: 'GET'
            }).then(r =>{
                if (r.ok) r.json().then(data => {
                    setFlights(data.flights)
                })
                else setFlights(undefined)
            })
        }
    }, [props]);
    function Search() {
        if (props.tripType === "oneWay") {
            fetch(Server + "offers/one-way?" + new URLSearchParams({
                departure: from,
                destination: to,
                departure_date: departure
            }), {
                method: 'GET'
            }).then(r =>{
                if (r.ok) r.json().then(data => {
                    setFlights(data.flights)
                })
                else setFlights(undefined)
            })
        }
        else {
            fetch(Server + "offers/round-trip?" + new URLSearchParams({
                departure: from,
                destination: to,
                departure_date: departure,
                return_date: returnDate
            }), {
                method: 'GET'
            }).then(r => {
                if (r.ok) r.json().then(data => {
                    setFlights(data.flights)
                })
                else setFlights(undefined)
            })
        }
    }
    function setDep(date) {
        setDeparture(date)
    }

    useEffect(() => {
        departureInput.current.value = departure
        Search()
    }, [departure]);

    const togglePassengerBox = () => {
        setShowPassengerBox(!showPassengerBox);
        if (!showPassengerBox) {
            setTempAdults(adults);
            setTempChildren(children);
        }
    }
    const increment = (setter, value) => {
        setter(value + 1);
    };

    const decrement = (setter, value, min) => {
        if (value > min) {
            setter(value - 1);
        }
    }
    const handlePassengerDone = () => {
        setAdults(tempAdults);
        setChildren(tempChildren);
        setShowPassengerBox(false); // Close the modal
    }

    return (
        <div className="relative">
            <Navigation selecting={"booking"}/>

            <div
                className="border border-black px-4 md:px-0 flex-col md:flex-row py-2 w-[95%] md:w-4/6 bg-white rounded-lg md:rounded-2xl mx-auto my-6 flex justify-evenly items-stretch be-vietnam-pro-bold">
                <div className="flex justify-center py-4 md:py-0">
                    <div className="flex items-center text-center text-xl pr-2">{from}</div>
                    <div className="flex text-2xl flex-col justify-center">
                        {props.tripType === "oneWay" && <HiArrowNarrowRight className="long-arrow"/>}
                        {props.tripType === "roundTrip" && <HiArrowsRightLeft className="long-arrow"/>}
                    </div>
                    <div className="flex items-center text-xl pl-2">{to}</div>
                </div>

                <div className="gradient-border block"/>

                <div className="flex items-center py-4 md:py-0">
                    <div className="flex flex-col mr-1">
                        <label className="flex items-center space-x-2">
                            <FaCalendarAlt className="text-gray-500"/>
                            <span className="text-gray-500 text-sm">Departure Date</span>
                        </label>
                        <input
                            ref={departureInput}
                            type="date"
                            value={departure}
                            onChange={(e) => {
                                if (e.target.value !== departure) setDeparture(e.target.value)
                            }}
                            min={new Date().toISOString().split("T")[0]}
                            className="mt-1 p-2 border rounded-md w-full hover:border-[#6d24cf]"
                        />
                    </div>
                    {props.tripType === "roundTrip" && (
                        <div className="flex flex-col ml-1">
                            <label className="flex items-center space-x-2">
                                <FaCalendarAlt className="text-gray-500"/>
                                <span className="text-gray-500 text-sm">Return Date</span>
                            </label>
                            <input
                                ref={returnInput}
                                type="date"
                                value={returnDate}
                                onChange={(e) => setReturn(e.target.value)}
                                min={new Date().toISOString().split("T")[0]}
                                className="mt-1 p-2 border rounded-md w-full hover:border-[#6d24cf]"
                            />
                        </div>
                    )}
                </div>

                <div className="gradient-border block"/>

                <div className="py-4 md:py-0 w-full md:w-auto flex items-center">
                    <div onClick={togglePassengerBox} className="cursor-pointer">
                        <p className="text-sm text-gray-500">Passenger(s)</p>
                        <p className="font-semibold border-b border-gray-300 pb-2 hover:border-[#6d24cf]">
                            {adults} Adult{adults > 1 ? "s" : ""}, {children} Child
                            {children > 1 ? "ren" : ""}
                        </p>
                    </div>

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
                                                disabled={tempAdults + tempChildren >= 9}
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
                                                disabled={tempAdults + tempChildren >= 9}
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
                </div>

                <div className="gradient-border block"/>

                {showClassBox && (
                    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
                        <div className="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">

                            <h2 className="text-2xl font-bold mb-6 text-center text-[#6d24cf]">
                                Select Cabin Class
                            </h2>

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
                                        setCabinClass("First");
                                        setShowClassBox(false);
                                    }}
                                    className={`w-full p-3 border rounded-md text-left ${
                                        cabinClass === "First"
                                            ? "bg-[#ffe06f] text-[#6d24cf] font-semibold border-[#6d24cf]"
                                            : "text-gray-700 hover:bg-[#ffe06f]"
                                    }`}
                                >
                                    First
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
                <div className="py-4 md:py-0 w-full md:w-auto flex items-center">
                    <div onClick={toggleClassBox} className="cursor-pointer">
                        <p className="text-sm text-gray-500">Cabin Class</p>
                        <p className="font-semibold border-b border-gray-300 pb-2 hover:border-[#6d24cf]">
                            {cabinClass}
                        </p>
                    </div>
                </div>
            </div>

            <DateSelect from={from} to={to} classType={cabinClass} setDep={setDep} date={departure}/>
            {flights !== null && <Flights from={from} to={to} flights={flights}/>}
        </div>
    )
}

export default Search