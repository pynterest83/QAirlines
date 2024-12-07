import {useEffect, useRef, useState} from "react";
import Ticket from "./Ticket.jsx";
import PlaneMap from "./PlaneMap.jsx";
import {AiOutlineClose} from "react-icons/ai";
import Payments from "./Payments.jsx";
import {Server} from "../../Server.js";

function TicketList(props) {
    const tickets = useRef([])
    const [open, setOpen] = useState([])
    const [filled, fill] = useState([])
    function setInfo(data) {
        if (bookingError) error(null)
        let temp = tickets.current.slice()
        let info = structuredClone(temp[choosingSeat.current])
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
        temp[choosingSeat.current] = info
        tickets.current = temp
        let _temp = filled.slice()
        _temp[choosingSeat.current] = !!Object.values(data).every(o => !!o);
        fill(_temp)
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
    function toggle(index) {
        let temp = open.slice()
        temp[index] = !temp[index]
        if (temp[index]) {
            if (!tickets.current[index].Info.seatNo) selectable.current = {allowed: true}
            choosingSeat.current = index
        }
        else {
            selectable.current = {allowed: false}
        }
        setOpen(temp)
    }
    const info_ref = useRef(null)
    function BookTicket() {
        let request = {
                flightID: props.info.FlightID,
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
                tickets.current.forEach((i, index) => {
                    tickets.current[index].Info.seatNo = ""
                })
                props.Book(data, true)
            })
            else {
                props.Book(null, false)
                r.json().then(e => error(e.error))
            }
        })
    }
    const [isMapOpen, openMap] = useState(false)
    const selectable = useRef({allowed: false})
    const choosingSeat = useRef(-1)
    function ChooseSeat(seat) {
        tickets.current[choosingSeat.current].Info.seatNo = seat
        selectable.current = {allowed: false}
    }
    function OpenSeatMap() {
        openMap(true)
        selectable.current = {allowed: true}
    }
    const [bookingError, error] = useState(null)
    return (
        <div ref={info_ref} className="flex flex-col flex-1 overflow-hidden">
            <div className="select-none flex-1 overflow-x-hidden w-full">
                {tickets.current.map((passenger, index) =>
                    <div className="overflow-hidden"
                         key={index}>
                        <div onClick={() => toggle(index)}
                             className={
                                 (open[index] ? "bg-[#e8e1df] shadow-[-4px_0_0_0_#6d24cf] " : "") + (filled[index] ? "text-green-600 " : "text-red-800 ") +
                                 "hover:shadow-[-4px_0_0_0_#be2cff] hover:bg-[#e8e1df] md:mx-32 py-1 flex items-center be-vietnam-pro-bold"}>
                            <div className="h-9 py-1 ml-1 pl-2 overflow-ellipsis whitespace-nowrap overflow-hidden">
                                {
                                    (!passenger.Info.firstName || !passenger.Info.lastName) ?
                                        (passenger.Type + ": Insufficient information")
                                        : (passenger.Info.firstName + " " + passenger.Info.lastName)
                                }
                            </div>
                            <div className="float-right mr-5 ml-auto">
                                {
                                    passenger.Info.seatNo ? passenger.Info.seatNo :
                                        <div className="be-vietnam-pro-medium-italic text-red-600">Not set</div>
                                }
                            </div>
                        </div>
                        <Ticket hidden={!open[index]} setInfo={setInfo} openSeatMap={() => OpenSeatMap(index)}
                                info={tickets.current[index].Info} type={tickets.current[index].Type}/>
                    </div>
                )}
                {bookingError &&
                    <div className="mx-auto md:ml-auto md:mr-32 w-fit be-vietnam-pro-medium text-red-500">
                        {bookingError}
                    </div>
                }
                <div className="flex h-fit w-full py-1 items-center justify-center">
                    <Payments/>
                    <button onClick={BookTicket}
                            disabled={!filled.every(e => !!e)}
                            className={(filled.every(e => !!e) ? "hover:bg-[#6d24cf] " : "opacity-70 ") +
                                "ml-2 md:mr-32 mr-10 p-4 bg-[#812af5] text-white rounded-xl be-vietnam-pro-bold mt-auto"}>
                        <i className="fas fa-shopping-cart mr-2"/>
                        ${localStorage.getItem("token") ?
                        Math.round(props.info.TicketPrice * (props.child + props.adult) * 0.95)
                        : props.info.TicketPrice * (props.child + props.adult)}
                        <div className="text-yellow-400 inline-block ml-2 be-vietnam-pro-medium">−5%</div>
                    </button>
                </div>
            </div>

            <div className= {
                (isMapOpen ? "" : "hidden ") +
                "fixed top-20 w-[100vw] h-[90vh] overflow-y-scroll bg-white"}>
                <PlaneMap select={selectable.current} info={props.info} choose={ChooseSeat}/>
                <button onClick={() => openMap(false)} className="fixed top-[85px] right-5 p-3 hover:bg-[#e6e6e6]">
                    <AiOutlineClose/>
                </button>
            </div>
        </div>
    )
}

export default TicketList