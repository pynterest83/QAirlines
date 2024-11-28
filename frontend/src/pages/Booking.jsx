import Navigation from "../components/Navigation.jsx";
import {useEffect, useRef, useState} from "react";
import {useLocation} from "react-router-dom";
import PlaneMap from "../components/Booking/PlaneMap.jsx";
import Ticket from "../components/Booking/Ticket.jsx";
import TicketList from "../components/Booking/TicketList.jsx";

function Booking() {
    const props = useLocation().state
    const [tickets, setList] = useState([])
    const [seat, setSeat] = useState("")
    const currentPassenger = useRef(0)
    const [newSelection, setNewSelection] = useState(false)
    const [currentType, setType] = useState("Adult")
    useEffect(() => {
        let list = []
        for (let i = 1; i <= props.passengers.adult; i++) list.push({
            Type: "Adult",
            Info: null
        })
        for (let i = 1; i <= props.passengers.children; i++) list.push({
            Type: "Children",
            Info: null
        })
        setList(list)
    }, []);
    function ChooseSeat(_seat) {
        setSeat(_seat)
    }
    function SetTicket(ticket) {
        let temp = structuredClone(tickets)
        setSeat("")
        //TODO
        temp[currentPassenger.current].Info = ticket
        currentPassenger.current++
        if (currentPassenger.current < props.passengers.adult + props.passengers.children) {
            setNewSelection(!newSelection)
            setType(tickets[currentPassenger.current].Type)
        }
        setList(temp)
    }
    return (
        <div className="relative">
            <Navigation selecting={"booking"}/>
            <Ticket currentType={currentType} set={SetTicket} current={"adult"} seat={seat}/>
            <TicketList list={tickets}/>
            <PlaneMap select={newSelection} choose={ChooseSeat} info={props.trip}/>
        </div>
    )
}

export default Booking