import { useLocation } from "react-router-dom";
import Navigation from "../components/Navigation.jsx";
import { Server } from "../Server.js";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Ticket from "../components/MyFlight/Ticket.jsx";
import ErrorBox from "../components/MyFlight/ErrorBox.jsx";

function MyFlight() {
  const props = useLocation().state;
  const [passengerID, setPassengerID] = useState(props.passengerID);
  const [firstName, setFirstName] = useState(props.firstName);
  const [lastName, setLastName] = useState(props.lastName);
  const [ticketData, setTicketData] = useState(null);
  const [warning, setWarning] = useState("");
  const nav = useNavigate();

  useEffect(() => {
    if (!props) return;
    // fetch ticket information
    fetch(Server + "tickets/my-tickets?" + new URLSearchParams({
      identifier: props.passengerID,
    }), {
      method: "GET"
    }).then((res) => {
      if (!res.ok) {
        throw new Error('Network response was not ok');
      }
      return res.json();
    }).then((data) => {
      setTicketData(data);
    }).catch((error) => {
      console.error('There was a problem with the fetch operation:', error);
    });
  }, [props]);

  function SearchTickets() {
    if (!passengerID || !firstName || !lastName) {
      setWarning("All fields are required.");
      return;
    }
    setWarning(""); // Clear the warning message
    nav("/myflights", {
        state: {
          passengerID: passengerID,
          firstName: firstName,
          lastName: lastName,
        },
    });
  }

  return (
    <div className="relative">
      <Navigation selecting={"info"} />
      <div className="sticky top-[78px] px-4 md:px-0 border-[#000000] border flex-col md:flex-row py-2 w-[95%] md:w-4/6 bg-white rounded-lg md:rounded-lg mx-auto my-6 flex justify-evenly items-stretch be-vietnam-pro-bold">
        <div className="cursor-pointer">
          <p className="text-sm text-gray-500 pb-2 pl-2">Passenger ID</p>
          <input
            id="passengerID"
            type="text"
            placeholder="Enter ID here"
            value={passengerID}
            onChange={(e) => setPassengerID(e.target.value)}
            className="border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-none focus:ring-1 focus:ring-[#6d24cf] focus:border-[#6d24cf] w-full h-[40px]"
          />
          {warning && <p className="text-red-500 text-xs mt-1">{warning}</p>}
        </div>
        {/* Divider */}
        <div className="gradient-border block"></div>
        <div className="cursor-pointer">
          <p className="text-sm text-gray-500 pb-2 pl-2">First Name</p>
          <input
            id="firstName"
            type="text"
            placeholder="First Name"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            className="border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-none focus:ring-1 focus:ring-[#6d24cf] focus:border-[#6d24cf] w-full h-[40px]"
          />
        </div>
        <div className="cursor-pointer">
          <p className="text-sm text-gray-500 pb-2 pl-2">Last Name</p>
          <input
            id="lastName"
            type="text"
            placeholder="Last Name"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            className="border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-none focus:ring-1 focus:ring-[#6d24cf] focus:border-[#6d24cf] w-full h-[40px]"
          />
        </div>

        <div className="gradient-border block"></div>
        <div className="flex items-center p-4 w-full md:w-auto">
          <button onClick={SearchTickets} className="h-fit w-full py-2 px-6 be-vietnam-pro-bold gradient-button text-white rounded-md hover:bg-[#ffe06f]">
            Search
          </button>
        </div>
      </div>
      {ticketData && ticketData.Tickets && ticketData.Tickets.length > 0 ? (
        ticketData.Tickets.map((ticket, index) => (
          <div key={index} className="mb-4"> {/* Add margin-bottom to each Ticket component */}
            <Ticket
              flight={ticket.FlightDetails}
              passenger={ticketData.Passenger}
              class={ticket.Class}
              ticketID={ticket.TicketID}
              seatNo={ticket.SeatNo}
              aircraftID={ticket.AircraftID}
              cancelDL={ticket.CancellationDeadline}
            />
          </div>
        ))
      ) : (
        <ErrorBox />
      )}
    </div>
  );
}

export default MyFlight;