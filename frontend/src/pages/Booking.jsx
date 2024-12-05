import Navigation from "../components/Navigation.jsx";
import {useRef, useState} from "react";
import {useLocation} from "react-router-dom";
import TicketList from "../components/Booking/TicketList.jsx";

function Booking() {
    const [props, setState] = useState(useLocation().state)
    const responses = useRef([])
    function Book(response) {
        responses.current.push(response)
        if (props.trip.length > 1) {
            const temp = structuredClone(props)
            temp.trip = temp.trip.slice(1)
            setState(temp)
        }
        else {
            responses.current.forEach(_r => {
                console.log(_r)
            })
        }
    }
    return (
        <div className="relative flex flex-col">
            <Navigation selecting={"booking"}/>
            <div className="shadow-[rgba(0,0,0,0.24)_0px_3px_8px] mx-auto my-4 rounded-2xl bg-white p-5">
                <div className="text-center be-vietnam-pro-bold text-2xl">Passenger details for {props.trip.length > 1 ? "outbound" : (responses.current.length ? "return" : "the")} flight</div>
                <div className="text-center be-vietnam-pro-medium text-xl">{props.trip[0].From} to {props.trip[0].To}</div>
                <div className="text-center be-vietnam-pro-medium text-xl">
                    {new Date(props.trip[0].Departure).toLocaleString('en-UK', {
                        weekday: 'long',
                        day: 'numeric',
                        month: 'long'
                    })}
                </div>
            </div>
            <TicketList Book={Book}
                        info={props.trip[0]}
                        adult={props.passengers.adult}
                        child={props.passengers.children}/>
        </div>
    )
}

export default Booking