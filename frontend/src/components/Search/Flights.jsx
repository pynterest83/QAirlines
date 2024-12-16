import Flight from "./Flight.jsx";
import {useEffect, useRef} from "react";
import loaderGif from '../../assets/images/airplaneLoader.gif'
function Flights(props) {
    useEffect(() => {
        if (props.flights) flightList.current.scrollIntoView({behavior: "smooth"})
    }, [props.flights]);
    const flightList = useRef(null)
    if (props.flights !== undefined && !props.loading)
        return (
            <div ref={flightList} className="my-4 w-full scroll-mt-[80px]">
                {props.flights.map(flight => <Flight numberOfPeople={props.numberOfPeople} confirm={props.confirm}
                                                     from={props.from} to={props.to} key={flight.FlightID}
                                                     info={flight}/>)}
            </div>
        )
    else
        return (
            <div className="relative my-4 w-[95%] md:w-4/6 overflow-hidden h-48 mx-auto bg-white rounded-2xl border border-black p-4">
                {props.loading ?
                    <div>
                        <img className="-top-12 h-64 absolute mx-auto left-1/2 transform -translate-x-1/2"
                             src={loaderGif}
                             alt="Not found"/>
                        <div className="be-vietnam-pro-bold mx-auto text-xl text-center mt-36">
                            Finding flights for you...
                        </div>
                    </div> :
                    <div>
                        <img className="h-24 mx-auto" src="/no-results.png" alt="Not found"/>
                        <div className="be-vietnam-pro-bold mx-auto text-xl text-center mt-4">
                            No flights found.
                        </div>
                        <div className="be-vietnam-pro-medium mx-auto text-base text-center mt-1">
                            We couldn&#39;t find any flight on this day. Consider trying a different date.
                        </div>
                    </div>}
            </div>
        )
}

export default Flights