function TicketList(props) {

    return (
        <div className="fixed right-2 bg-white rounded-2xl border border-black">
            {props.list.map((passenger, index) =>
            <div className="py-3" key={index}>
                {passenger.Info ?
                    <div>
                        Settled.
                    </div>
                :
                    <div className="p-3 bg-[#f5f5f5]">
                        Seat for {passenger.Type.toLowerCase()}: Not set
                    </div>
                }
            </div>
        )}
        </div>
    )
}
export default TicketList