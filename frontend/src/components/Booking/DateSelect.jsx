import {useEffect, useState} from "react";

function DateSelect(props) {
    function ChangeDate(date) {
        if (new Date(date).getDate() === new Date(props.date).getDate()) return
        props.setDep(new Date(date).toISOString().split('T')[0])
    }
    function SetDateList(_date) {
        let date = Date.parse(_date) - 86400000 * 3
        let _dates = []
        for (let i = 0; i <= 6; i++) {
           _dates.push(date + i * 86400000)
        }
        return _dates
    }
    useEffect(() => {
        setDates(SetDateList(props.date))
    }, [props]);
    const [dates, setDates] = useState([])
    return (
        <div className="no-scrollbar overflow-x-scroll overflow-y-hidden rounded-xl select-none md:rounded-xl flex w-[95%] md:w-4/6 bg-white mx-auto my-6 items-stretch justify-evenly px-12">
            {dates.map(date =>
                <div onClick={() => ChangeDate(date)}
                    className={(new Date(date).getDate() === new Date(props.date).getDate() ? "bg-gradient-to-tr from-[#6d24cf] to-[#ffe06f] text-white " : "text-[#747474] hover:bg-gray-400 hover:text-white ") +
                    "be-vietnam-pro-bold text-2xl justify-center flex items-center rounded-3xl aspect-square p-4"}
                    key={date}>{new Date(date).toLocaleDateString("en-uk", {
                    weekday: "short",
                    day: "2-digit",
                })}</div>
            )}
        </div>
    )
}

export default DateSelect