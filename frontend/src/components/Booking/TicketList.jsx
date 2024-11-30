import {useEffect, useRef, useState} from "react";
import Ticket from "./Ticket.jsx";
import {Server} from "../../Server.js";

function TicketList(props) {
    const ticket_ref = useRef(null)
    const tickets = useRef([])
    const [open, setOpen] = useState([])
    const [filled, fill] = useState([])
    function setInfo(data) {
        let opening = open.indexOf(true)
        if (opening !== -1) {
            let temp = tickets.current.slice()
            let info = structuredClone(temp[opening])
            info.Info.firstName = data.firstName
            info.Info.lastName = data.lastName
            info.Info.dob = data.dob
            info.Info.gender = data.gender
            info.Info.seatNo = data.seatNo
            if (info.Type === "Adult") {
                info.Info.email = data.email
                info.Info.phoneNumber = data.phoneNumber
                info.Info.passport = data.passport
                info.Info.ssn = data.ssn
            }
            else {
                info.Info.guardianSSN = data.guardianSSN
            }
            temp[opening] = info
            tickets.current = temp
            if(Object.values(data).every(o => !!o)) {
                let temp = filled.slice()
                temp[opening] = true
                fill(temp)
            }
        }
    }
    useEffect(() => {
        let list = []
        for (let i = 1; i <= props.adult; i++) list.push({
            Type: "Adult",
            Info: {
                firstName: "",
                lastName: "",
                dob: "",
                gender: "M",
                email: "",
                phoneNumber: "",
                passport: "",
                ssn: "",
                seatNo: ""
            }
        })
        for (let i = 1; i <= props.child; i++) list.push({
            Type: "Children",
            Info: {
                firstName: "",
                lastName: "",
                dob: "",
                gender: "M",
                guardianSSN: "",
                seatNo: ""
            }
        })
        tickets.current = list
        setOpen(new Array(props.adult + props.child).fill(false))
        fill(new Array(props.adult + props.child).fill(false))
    }, []);
    useEffect(() => {
        if (props.seat !== null) {
            let isOpen = open.indexOf(true)
            let temp = tickets.current.slice()
            if (isOpen !== -1) {
                temp[isOpen].Info.seatNo = props.seat
            }
            tickets.current = temp
        }
    }, [props.seat]);
    function toggle(index) {
        let temp = open.slice()
        temp[index] = !temp[index]
        if (temp[index]) {
            temp.forEach((_, i) => {
                if (i !== index) temp[i] = false
            })
            if (!tickets.current[index].Info.seatNo) props.select({allowed: true})
        }
        else {
            props.select({allowed: false})
        }
        props.setSeat(null)
        setOpen(temp)
    }
    const info_ref = useRef(null)
    function scroll(top) {
        ticket_ref.current.scrollTop = top - 43
    }
    function BookTicket() {
        let request = {
            flightID: props.ID,
            passengers: tickets.current.map(ticket => ticket.Info)
        }
        fetch(Server + "tickets/book-ticket", {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(request)
        }).then(r => {
            if (r.ok) r.json().then(data => {
                console.log(data)
                tickets.current.forEach((i, index) => {
                    tickets.current[index].Info.seatNo = ""
                })
                props.Book()
            })
        })
    }
    return (
         <div ref={info_ref} className="flex flex-col h-[600px] absolute right-2 bg-white rounded-2xl border border-black w-[24%] overflow-hidden">
            <div ref={ticket_ref} className="select-none flex-1 overflow-x-hidden overflow-y-scroll thin-scrollbar w-full">
                {tickets.current.map((passenger, index) =>
                <div className="overflow-hidden"
                     key={index}>
                    <div onClick={() => toggle(index)}
                        className={
                            (open[index] ? "bg-[#f1f1f1] " : "") + (filled[index] ? "text-green-600 " : "text-red-600 ") +
                        "py-1 flex items-center"}>
                        <div className={
                            (open[index] ? "shadow-[-4px_0_0_0_#6d24cf] " : "hover:shadow-[-4px_0_0_0_#be2cff] ") +
                            "h-9 py-1 ml-1 pl-1 w-[80%] overflow-ellipsis whitespace-nowrap overflow-hidden"}>
                            {
                                (!filled[index]) ?
                                    (passenger.Type + ": Insufficient information")
                                    : (passenger.Info.firstName + " " + passenger.Info.lastName)
                            }
                        </div>
                        <div className="float-right flex-shrink-0">
                            {
                                passenger.Info.seatNo ? passenger.Info.seatNo :
                                    <div className="be-vietnam-pro-medium-italic text-red-600">Not set</div>
                            }
                        </div>
                    </div>
                    {open[index] &&
                    <Ticket scroll={scroll} setSeat={props.seat} setInfo={setInfo} info={tickets.current[index].Info} type={tickets.current[index].Type}/>}
                </div>
                )}
            </div>
            <div className="flex flex-shrink-0 h-fit w-full py-1">
                <button onClick={BookTicket}
                    disabled={!filled.every(e => !!e)}
                    className={(filled.every(e => !!e) ? "hover:bg-[#6d24cf] " : "opacity-70 ") +
                    "mx-auto p-3 bg-[#812af5] text-white rounded-xl be-vietnam-pro-bold mt-auto"}>Book ticket</button>
            </div>
        </div>
    )
}
export default TicketList