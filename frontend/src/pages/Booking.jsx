import Navigation from "../components/Navigation.jsx";
import {useState} from "react";
import {useLocation} from "react-router-dom";
import PlaneMap from "../components/Booking/PlaneMap.jsx";
import TicketList from "../components/Booking/TicketList.jsx";

function Booking() {
    const [props, setState] = useState(useLocation().state)
    const [seat, setSeat] = useState(null)
    const [newSelection, setNewSelection] = useState({allowed: false})
    function Book() {
        if (props.trip.length > 1) {
            const temp = structuredClone(props)
            temp.trip = temp.trip.slice(1)
            setState(temp)
        }
    }
    return (
        <div className="relative">
            <Navigation selecting={"booking"}/>
            <TicketList Book={Book}
                        ID={props.trip[0].FlightID}
                        setSeat={setSeat}
                        select={setNewSelection}
                        adult={props.passengers.adult}
                        child={props.passengers.children}
                        seat={seat}/>
            <PlaneMap select={newSelection} choose={setSeat} info={props.trip}/>
        </div>
    )
}

export default Booking