import Navigation from "../components/Navigation.jsx";
import ScrollToTop from "../scroll.jsx";

function Classes() {
    return (
        <div className="relative">
            <ScrollToTop/>
            <Navigation/>
            <div className="mt-3 py-5 px-10 w-[90%] mx-auto bg-white rounded-2xl shadow-[rgba(0,0,0,0.24)_0px_3px_8px]">
                <div className="text-[28px] be-vietnam-pro-bold mb-6">
                    Ticket classes
                </div>
                <div className="be-vietnam-pro-medium text-[18px] mb-6">
                    QAirline offers three ticket classes for passengers: Economy, Business and First Class.
                </div>
                <figure className="mx-auto md:max-w-[50%] mb-6">
                    <img className="rounded-xl"
                        src="https://www.vietnamairlines.com/~/media/Upload/A320neo/DSC00834.JPG"
                        alt="Economy"/>
                    <figcaption className="be-vietnam-pro-medium text-center">
                        An example of economy-class seats on an Airbus A320 Neo-300
                    </figcaption>
                </figure>
                <figure className="mx-auto md:max-w-[50%] mb-6">
                    <img className="rounded-xl"
                        src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Cathay_Pacific_-_A330-300_-_Business_Class_%288108289508%29.jpg/1280px-Cathay_Pacific_-_A330-300_-_Business_Class_%288108289508%29.jpg"
                        alt="Business"/>
                    <figcaption className="be-vietnam-pro-medium text-center">
                        A business-class seat on an Airbus A330-300. Visible on the right hand side of the seat is
                        controls to operate the recline, as well as a remote control for the in-flight entertainment
                        system.
                    </figcaption>
                </figure>
                <figure className="mx-auto md:max-w-[50%] mb-6">
                    <img className="rounded-xl"
                        src="https://media.cntraveler.com/photos/5ce2ebfbd1be0293a1fc6a41/master/w_1920%2Cc_limit/Air-France-La-Premiere.jpg"
                        alt="Business"/>
                    <figcaption className="be-vietnam-pro-medium text-center">
                        First class seats on a Boeing 777-300ER
                    </figcaption>
                </figure>
            </div>
            <div className="mx-auto w-fit bg-white p-4 my-6 rounded-2xl shadow-[rgba(0,0,0,0.24)_0px_3px_8px]">
                <table className="table-auto my-5">
                    <thead className="bg-[#6d24cf] text-white">
                    <tr>
                        <th className="p-5">Ticket class</th>
                        <th>Economy</th>
                        <th>Business</th>
                        <th>First</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr className="bg-[#f2f4f7]">
                        <td className="p-5">Luggage</td>
                        <td>7kg</td>
                        <td>7kg</td>
                        <td>7kg</td>
                    </tr>
                    <tr className="bg-[#e3e2e2]">
                        <td className="p-5">Checked bags</td>
                        <td>2 x 32 kg</td>
                        <td>2 x 32 kg</td>
                        <td>2 x 32 kg</td>
                    </tr>
                    <tr className="bg-[#f2f4f7]">
                        <td className="p-5">Meal</td>
                        <td colSpan="3">Served according to the service standard of each route</td>
                    </tr>
                    <tr className="bg-[#e3e2e2]">
                        <td className="p-5">Rebook/reroute (At least 12 hours before scheduled flight time)</td>
                        <td>5% + difference (If any)<br/></td>
                        <td>2% + difference (If any)</td>
                        <td>Difference (If any)</td>
                    </tr>
                    <tr className="bg-[#f2f4f7]">
                        <td className="p-5">Rebook/reroute (Less than 12 hours before scheduled flight time)</td>
                        <td>Not permitted</td>
                        <td>Not permitted</td>
                        <td>2% + Difference (If any)</td>
                    </tr>
                    <tr className="bg-[#e3e2e2]">
                        <td className="p-5">Seat selection</td>
                        <td>Chargeable</td>
                        <td>Chargeable</td>
                        <td>Free</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    )
}

export default Classes