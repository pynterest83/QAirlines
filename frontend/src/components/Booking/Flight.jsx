import {useEffect, useState} from "react";

function Flight(props) {
    const [departure] = useState(new Date(props.info.DepTime))
    const [arrival] = useState(new Date(props.info.ArrTime))
    const [timeTaken, setTimeTaken] = useState(null)
    useEffect(() => {
        let timeString = ""
        let time = arrival - departure
        let hour = Math.floor((time) / 3600000)
        let minutes = Math.floor((time - hour * 3600000) / 60000)
        if (hour) {
            timeString += hour
            if (hour > 1) timeString += " hours "
            else timeString += "hour "
        }
        if (minutes) {
            timeString += minutes
            if (minutes > 1) timeString += " minutes"
            else timeString += "minute"
        }
        setTimeTaken(timeString)
    }, []);
    return (
        <div
            className="rounded-2xl mx-auto w-[95%] md:w-4/6 lg:h-40 h-auto relative items-stretch bg-white lg:bg-transparent my-12 flex flex-col lg:items-stretch lg:justify-between lg:flex-row">
            <div className="p-2 lg:rounded-l-2xl lg:bg-white flex flex-1 justify-center items-center relative z-[2]">
                <div className="mr-3">
                    <div className="be-vietnam-pro-bold text-2xl">{departure.toLocaleTimeString("en-uk", {
                        hour: "numeric",
                        minute: "numeric"
                    })}</div>
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
                                    <path d='M0,0 V4 L2,2 Z' fill="black"/>
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
                    <div className="be-vietnam-pro-bold text-2xl">{arrival.toLocaleTimeString("en-uk", {
                        hour: "numeric",
                        minute: "numeric"
                    })}</div>
                    <div className="text-gray-500 be-vietnam-pro-medium">{props.to}</div>
                </div>
            </div>
            <div className="lg:w-1/2 h-full flex lg:flex-row flex-col relative z-[2]">
                <div className="lg:block hidden left-[0.8px] lg:rounded-2xl bottom-0 absolute w-full h-[120%] z-[1] bg-[#ffe06f]"/>
                <div className="hover:bg-gray-400 hover:text-white [border-image:linear-gradient(to_right,#ffe06f,#6d24cf)_1] lg:[border-image:linear-gradient(to_bottom,#ffe06f,#6d24cf)_1] flex-1 border-l-0 lg:border-l-2 lg:border-t-0 border-t-2 lg:bg-white z-[3] flex flex-col justify-center items-center">
                    <div className="be-vietnam-pro-bold text-2xl">{props.info.ticketClasses[0].ClassName}</div>
                    <div className="be-vietnam-pro-medium text-xl">{props.info.ticketClasses[0].Price}</div>
                </div>
                <div className="hover:bg-gray-400 hover:text-white [border-image:linear-gradient(to_right,#ffe06f,#6d24cf)_1] lg:[border-image:linear-gradient(to_bottom,#ffe06f,#6d24cf)_1] flex-1 border-l-0 lg:border-l-2 lg:border-t-0 border-t-2 lg:bg-white z-[3] flex flex-col justify-center items-center">
                    <div className="be-vietnam-pro-bold text-2xl">{props.info.ticketClasses[1].ClassName}</div>
                    <div className="be-vietnam-pro-medium text-xl">{props.info.ticketClasses[1].Price}</div>
                </div>
                <div className="hover:bg-gray-400 hover:text-white [border-image:linear-gradient(to_right,#ffe06f,#6d24cf)_1] lg:[border-image:linear-gradient(to_bottom,#ffe06f,#6d24cf)_1] flex-1 border-l-0 lg:border-l-2 lg:border-t-0 border-t-2 lg:rounded-r-2xl lg:bg-white z-[3] flex flex-col justify-center items-center">
                    <div className="be-vietnam-pro-bold text-2xl">{props.info.ticketClasses[2].ClassName}</div>
                    <div className="be-vietnam-pro-medium text-xl">{props.info.ticketClasses[2].Price}</div>
                </div>
            </div>
            <div className="hidden lg:block rounded-2xl bottom-0 absolute w-full h-[110%] z-[1] bg-[#6d24cf]"/>
        </div>
    )

}

export default Flight