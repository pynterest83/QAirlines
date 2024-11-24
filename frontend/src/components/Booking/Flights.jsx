import Flight from "./Flight.jsx";
import {useEffect, useRef} from "react";

function Flights(props) {
    useEffect(() => {
        if (props.flights) flightList.current.scrollIntoView({behavior: "smooth"})
    }, [props.flights]);
    const flightList = useRef(null)
    if (props.flights !== undefined)
        return (
            <div ref={flightList} className="my-4 w-4/6 mx-auto">
                {props.flights.map(flight => <Flight key={flight.FlightID} info={flight}/>)}
            </div>
        )
    else
        return (
            <div className="my-4 w-4/6 mx-auto">No flight available.</div>
        )
}

export default Flights