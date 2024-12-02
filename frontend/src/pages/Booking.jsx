import Navigation from "../components/Navigation.jsx";
import {useRef, useState} from "react";
import {useLocation, useNavigate} from "react-router-dom";
import TicketList from "../components/Booking/TicketList.jsx";

function Booking() {
    const nav = useNavigate()
    const [props, setState] = useState(useLocation().state)
    const responses = useRef([])
    const [completed, complete] = useState(false)
    function Book(success= true, response) {
        if (!success) {
            return
        }
        responses.current.push(response)
        if (props.trip.length > 1) {
            const temp = structuredClone(props)
            temp.trip = temp.trip.slice(1)
            setState(temp)
        }
        else complete(true)
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

            {completed && <div
                className="popup-animation fixed p-6 bg-white rounded-2xl items-center flex flex-col border-black border left-1/2 z-30 top-1/2 w-fit transform -translate-x-1/2 -translate-y-1/2">
                <div className="be-vietnam-pro-bold text-xl mb-3 text-center">Ticket booked successfully.</div>
                <div>Ticket IDs:</div>
                <div className="w-full my-3">
                    {responses.current.map((response, index) =>
                        <div className="inline-block w-1/2 text-center" key={index}>
                            {response.tickets.map(ticket => <div key={ticket.TicketID}>{ticket.TicketID}</div>)}
                        </div>
                    )}
                </div>
                <button onClick={() => nav("/")}
                        className="p-3 bg-[#812af5] hover:bg-[#6d24cf] text-white rounded-xl be-vietnam-pro-bold">Back to homepage
                </button>
            </div>}
            {completed && <div className="block fixed top-0 right-0 left-0 bottom-0 bg-black bg-opacity-50 z-20"></div>}
        </div>
    )
}

export default Booking