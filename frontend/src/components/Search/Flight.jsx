import { useEffect, useRef, useState } from "react";
import { SlArrowDown } from "react-icons/sl";

const contents = [
    "Hand baggage: Not exceed 7kg\nChecked bag: 2 x 32kg\nAccumulate 100% of miles\nTicket change with fee",
    "Hand baggage: Not exceed 7kg\nChecked bag: 2 x 32kg\nAccumulate 150% of miles\nTicket change without fee\nPriority check-in",
    "Hand baggage: Not exceed 7kg\nChecked bag: 2 x 32kg\nAccumulate 200% of miles\nTicket change without fee\nPriority check-in"
];

function Flight(props) {
    const [departure] = useState(new Date(props.info.DepTime));
    const [arrival] = useState(new Date(props.info.ArrTime));
    const [timeTaken, setTimeTaken] = useState(null);
    const [description, toggleDes] = useState(-1);
    const des = useRef(null);

    const formatDateTime = (dateTime) => {
        const date = new Date(dateTime);
        const formattedDate = date.toISOString().split('T')[0]; // Keep the original date format
        const formattedTime = date.toISOString().split('T')[1].slice(0, 5); // Extract time in HH:MM format
        return `${formattedDate} ${formattedTime}`;
    };

    function ChooseTrip() {
        let trip = {
            AircraftID: props.info.Aircraft.AircraftID,
            FlightID: props.info.FlightID,
            Departure: props.info.DepTime,
            Arrival: props.info.ArrTime,
            Boarding: props.info.BoardingTime,
            From: props.from,
            To: props.to,
            ClassType: description === 0 ? "Economy" : (description === 1 ? "Business" : "First"),
            TicketPrice: props.info.ticketClasses[description].Price
        };
        props.confirm(trip);
    }

    useEffect(() => {
        if (description !== -1) des.current.scrollIntoView({ behavior: "smooth", block: "center" });
    }, [description]);

    useEffect(() => {
        let timeString = "";
        let time = arrival - departure;
        let hour = Math.floor(time / 3600000);
        let minutes = Math.floor((time - hour * 3600000) / 60000);
        if (hour) {
            timeString += hour;
            if (hour > 1) timeString += " hours ";
            else timeString += " hour ";
        }
        if (minutes) {
            timeString += minutes;
            if (minutes > 1) timeString += " minutes";
            else timeString += " minute";
        }
        setTimeTaken(timeString);
    }, [arrival, departure]);

    return (
        <div className="my-12 md:w-4/6 w-[95%] mx-auto">
            <div
                className={
                    (description === -1 ? "rounded-b-2xl border-b " : "") +
                    "border-black border-l overflow-hidden lg:overflow-visible border-r border-t lg:border-t-0 lg:rounded-t-0 rounded-t-2xl w-full lg:h-40 h-auto relative items-stretch bg-white flex flex-col lg:items-stretch lg:justify-between lg:flex-row"
                }
            >
                <div
                    className={
                        (description === -1 ? "rounded-l-2xl " : "rounded-tl-2xl ") +
                        "border-0 p-2 lg:bg-white flex flex-1 justify-center items-center relative z-[2]"
                    }
                >
                    <div className="mr-3">
                        <div className="be-vietnam-pro-bold text-2xl">
                            {formatDateTime(departure).split(' ')[1]}
                        </div>
                        <div className="text-gray-500 be-vietnam-pro-medium">{props.from}</div>
                    </div>
                    <div className="flex flex-col justify-center items-center h-full">
                        <div>{timeTaken}</div>
                        <div className="h-[50px] w-[200px]">
                            <svg width="100%" height="100%">
                                <defs>
                                    <marker
                                        id='head'
                                        orient="auto"
                                        markerWidth='3'
                                        markerHeight='4'
                                        refX='0.1'
                                        refY='2'
                                    >
                                        <path d='M0,0 V4 L2,2 Z' fill="black" />
                                    </marker>
                                </defs>
                                <path
                                    id='arrow-line'
                                    markerEnd='url(#head)'
                                    strokeWidth='4'
                                    fill='none' stroke='black'
                                    d='M0,25, 192 25, 120'
                                />
                            </svg>
                        </div>
                        <div className="be-vietnam-pro-bold">{props.info.FlightID}</div>
                    </div>
                    <div className="ml-3">
                        <div className="be-vietnam-pro-bold text-2xl">
                            {formatDateTime(arrival).split(' ')[1]}
                        </div>
                        <div className="text-gray-500 be-vietnam-pro-medium">{props.to}</div>
                    </div>
                </div>
                <div className="lg:w-1/2 h-full flex lg:flex-row flex-col relative z-[2]">
                    <div
                        className="border border-black lg:block hidden right-[-1px] left-[0.5px] rounded-t-2xl rounded-br-3xl bottom-0 absolute h-[120%] z-[1] bg-[#ffe06f]" />
                    <div onClick={() => toggleDes(description === 0 ? -1 : 0)}
                        className="py-2 cursor-pointer hover:bg-[#909090] hover:text-white [border-image:linear-gradient(to_right,#ffe06f,#6d24cf)_1] lg:[border-image:linear-gradient(to_bottom,#ffe06f,#6d24cf)_1] flex-1 border-l-0 lg:border-l-2 lg:border-t-0 border-t-2 lg:bg-white z-[3] flex flex-col justify-center items-center">
                        <div
                            className="mt-auto pointer-events-none be-vietnam-pro-bold text-2xl">{props.info.ticketClasses[0].ClassName}</div>
                        <div
                            className="pointer-events-none be-vietnam-pro-medium text-xl">{props.info.ticketClasses[0].Price}</div>
                        <div
                            className={
                                (description === 0 ? "rotate-180 " : "") +
                                "h-0 w-full full mt-auto be-vietnam-pro-bold text-xl p-1.5 flex items-center justify-center"
                            }>
                            <SlArrowDown />
                        </div>
                    </div>
                    <div onClick={() => toggleDes(description === 1 ? -1 : 1)}
                        className="py-2 cursor-pointer hover:bg-[#909090] hover:text-white [border-image:linear-gradient(to_right,#ffe06f,#6d24cf)_1] lg:[border-image:linear-gradient(to_bottom,#ffe06f,#6d24cf)_1] flex-1 border-l-0 lg:border-l-2 lg:border-t-0 border-t-2 lg:bg-white z-[3] flex flex-col justify-center items-center">
                        <div
                            className="mt-auto pointer-events-none be-vietnam-pro-bold text-2xl">{props.info.ticketClasses[1].ClassName}</div>
                        <div
                            className="pointer-events-none be-vietnam-pro-medium text-xl">{props.info.ticketClasses[1].Price}</div>
                        <div
                            className={
                                (description === 1 ? "rotate-180 " : "") +
                                "h-0 w-full mt-auto be-vietnam-pro-bold text-xl p-1.5 flex items-center justify-center"
                            }>
                            <SlArrowDown />
                        </div>
                    </div>
                    <div
                        onClick={() => toggleDes(description === 2 ? -1 : 2)}
                        className={(description === -1 ? "lg:rounded-r-2xl " : "lg:rounded-tr-2xl ") +
                            "rounded-0 py-2 cursor-pointer hover:bg-[#909090] hover:text-white [border-image:linear-gradient(to_right,#ffe06f,#6d24cf)_1] lg:[border-image:linear-gradient(to_bottom,#ffe06f,#6d24cf)_1] flex-1 border-l-0 lg:border-l-2 lg:border-t-0 border-t-2 lg:bg-white z-[3] flex flex-col justify-center items-center"}>
                        <div
                            className="mt-auto pointer-events-none be-vietnam-pro-bold text-2xl">{props.info.ticketClasses[2].ClassName}</div>
                        <div
                            className="pointer-events-none be-vietnam-pro-medium text-xl">{props.info.ticketClasses[2].Price}</div>
                        <div
                            className={
                                (description === 2 ? "rotate-180 " : "") +
                                "h-0 w-full mt-auto be-vietnam-pro-bold text-xl p-1.5 flex items-center justify-center"
                            }>
                            <SlArrowDown />
                        </div>
                    </div>
                </div>
                <div className="hidden lg:block rounded-tl-2xl rounded-b-3xl border border-black left-[-0.5px] bottom-0 absolute w-full h-[110%] z-[1] bg-[#6d24cf]" />
            </div>
            {description !== -1 &&
                <div ref={des} className="border-black border-r border-b border-l overflow-auto w-full bg-gray-200 px-6 py-2 rounded-b-2xl">
                    <div className="overflow-auto">
                        <div className="inline-block">
                            <div className="be-vietnam-pro-bold text-2xl">{props.info.ticketClasses[description].ClassName}</div>
                            <div className="be-vietnam-pro-medium text-xl">From {props.info.ticketClasses[description].Price}</div>
                            <div className="be-vietnam-pro-light text-lg">{props.info.ticketClasses[description].AvailableSeats} left</div>
                        </div>
                        <div className="h-fit inline-block whitespace-pre-wrap text-right float-right">{contents[description]}</div>
                    </div>
                    {props.numberOfPeople > props.info.ticketClasses[description].AvailableSeats &&
                        <div className="be-vietnam-pro-medium text-red-600 py-2">Not enough available seat left</div>}
                    <div className="mt-4 md:mt-0 w-full clear-end md:block flex justify-center">
                        <button disabled={props.numberOfPeople > props.info.ticketClasses[description].AvailableSeats}
                            onClick={ChooseTrip}
                            className={(props.numberOfPeople > props.info.ticketClasses[description].AvailableSeats ? "opacity-50 " : "hover:bg-[#6d24cf] ") +
                                "p-4 bg-[#812af5] text-white rounded-xl be-vietnam-pro-bold"}>Confirm and continue</button>
                    </div>
                </div>
            }
        </div>
    );
}

export default Flight;