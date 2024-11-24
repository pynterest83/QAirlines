function Flight(props) {
    return (
        <div className="bg-white rounded-lg md:h-40 p-4 mb-4 flex flex-col items-stretch justify-between md:flex-row">
            <div className="items-center flex flex-col justify-center pr-3">
                <div className="be-vietnam-pro-bold">{props.info.FlightID}</div>
                <div className="text-sm text-gray-500">{props.info.Status}</div>
            </div>
            <div className="gradient-border block"/>
            <div className="px-3 flex flex-col justify-center">
                <div className="text-sm text-gray-500">Departure time</div>
                <div>{new Date(props.info.DepTime).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})}</div>
            </div>
            <div className="gradient-border block"/>
            <div className="px-3 flex flex-col justify-center">
                <div className="text-sm text-gray-500">Arrival time</div>
                <div>{new Date(props.info.ArrTime).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})}</div>
            </div>
            <div className="gradient-border block"/>
            <div className="px-3 flex flex-col justify-center">
                <div className="text-sm text-gray-500">Boarding time</div>
                <div>{new Date(props.info.BoardingTime).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})}</div>
            </div>
                <div className="ml-5 flex-1 flex justify-evenly">
                    {props.info.ticketClasses.map(ticketclass =>
                        <div className="be-vietnam-pro-bold py-3 mx-1 rounded-lg bg-gray-200 text-center flex-1 px-2 flex flex-col justify-center" key={ticketclass.ClassName}>
                            <div>{ticketclass.ClassName}</div>
                            <div>{ticketclass.Price}</div>
                        </div>)}
                </div>
            </div>
            )
            }

            export default Flight