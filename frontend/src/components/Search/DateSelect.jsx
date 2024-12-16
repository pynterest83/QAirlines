import {useEffect, useRef, useState} from "react";
import {SlArrowLeft, SlArrowRight} from "react-icons/sl";
import {Server} from "../../Server.js";

function DateSelect(props) {
    const date_ref = useRef(null)
    const [dates, setDates] = useState([])
    const current = useRef(null)
    function ChangeDate(date) {
        if (date === props.date) return
        props.setDep(date)
        SetDateList(date, 4)
    }
    function SetDateList(_date, numberOfDate) {
        let date_begin = Date.parse(_date) - 86400000 * numberOfDate
        let date_end = date_begin + 2 * numberOfDate * 86400000
        let temp = []
        for (let i = 0; i <= 2 * numberOfDate; i++) {
            let date = new Date(date_begin + i * 86400000).toISOString().split("T")[0]
            temp.push({Date: date, Price: null})
        }
        setDates(temp)
        fetch(Server + "offers/in-range?" + new URLSearchParams({
            departure: props.from,
            destination: props.to,
            start_date: new Date(date_begin).toISOString().split("T")[0],
            end_date: new Date(date_end).toISOString().split("T")[0],
            ticket_class: props.classType
        }), {
            method: 'GET'
        }).then(r => {
            let _dates = []
            if (r.ok) r.json().then(data => {
                let dataList = data.flights
                for (let i = 0; i <= 2 * numberOfDate; i++) {
                    let date = new Date(date_begin + i * 86400000).toISOString().split("T")[0]
                    let price = dataList.find(el => el.DepTime === date)
                    _dates.push({Date: date, Price: price !== undefined ? price.MinPrice : null})
                }
                setDates(_dates)
            })
            else {
                for (let i = 0; i <= 2 * numberOfDate; i++) {
                    let date = new Date(date_begin + i * 86400000).toISOString().split("T")[0]
                    _dates.push({Date: date, Price: null})
                }
                setDates(_dates)
            }
        })
    }
    useEffect(() => {
        SetDateList(props.date, 4)
    }, [props.date]);
    useEffect(() => {
        if (current.current) {
            current.current.scrollIntoView({block: "center", inline: "center"})
        }
    }, [dates]);
    useEffect(() => {
        console.log("Here")
        SetDateList(props.date, 4)
    }, [props.classType]);
    return (
        <div className="relative h-28 border border-black rounded-xl w-[95%] md:w-4/6 mx-auto my-6 overflow-hidden">
            <div className="absolute bg-transparent left-[0%] w-full top-0 bottom-0 z-0 pointer-events-none">
                <div onClick={() => date_ref.current.scrollBy({behavior: "smooth", left:-112})} className="opacity-ltr bg-white active:bg-gray-400 hover:bg-gray-300 w-[35px] h-full absolute left-0 pointer-events-auto">
                    <SlArrowLeft className="absolute top-1/2 transform -translate-y-1/2"/>
                </div>
                <div onClick={() => date_ref.current.scrollBy({behavior: "smooth", left:112})} className="opacity-rtl bg-white active:bg-gray-400 hover:bg-gray-300 w-[35px] h-full absolute right-0 pointer-events-auto">
                    <SlArrowRight className="right-0 absolute top-1/2 transform -translate-y-1/2"/>
                </div>
            </div>

            <div ref={date_ref}
                 className="w-full h-full no-scrollbar overflow-x-scroll select-none flex bg-white items-stretch px-12">
                {dates.map(date => {
                    const ref = (date.Date === props.date) ? {ref: current} : {}
                    return (
                        <div onClick={() => ChangeDate(date.Date)}
                             className={(date.Date === props.date ? "bg-gradient-to-tr from-[#6d24cf] to-[#ffe06f] text-white " : "text-[#747474] hover:bg-gray-400 hover:text-white ") +
                                 "cursor-pointer mx-auto whitespace-nowrap flex flex-col justify-center items-center be-vietnam-pro-bold text-2xl rounded-3xl aspect-square"}
                             key={date.Date}
                             {...ref}>
                                <div>
                                    {new Date(date.Date).toLocaleDateString("en-uk", {
                                        weekday: "short",
                                        day: "2-digit",
                                    })}
                                </div>
                            {date.Price && <div className="text-xl be-vietnam-pro-medium">{date.Price}</div>}
                        </div>)
                })}
            </div>
        </div>
    )
}

export default DateSelect