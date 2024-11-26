import { useNavigate } from "react-router-dom";
import { useState } from "react";

const MyFlightBox = () => {
  const [ticketID, setTicketID] = useState("");
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const nav = useNavigate();

  function SearchTickets() {
    console.log(ticketID, firstName, lastName);
    nav("/myflight", {
      state: {
        ticketID: ticketID,
        firstName: firstName,
        lastName: lastName,
      },
    });
  }

  return (
    <div className="p-6 h-full">
      <div className="flex flex-col md:flex-row items-stretch justify-between space-y-4 md:space-y-0">
        <div className="cursor-pointer">
          <p className="text-sm text-gray-500 pb-2 pl-2">Ticket ID</p>
          <input
            id="ticketID"
            type="text"
            placeholder="Enter ID here"
            value={ticketID}
            onChange={(e) => setTicketID(e.target.value)}
            className="border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-none focus:ring-1 focus:ring-[#6d24cf] focus:border-[#6d24cf] w-full h-[40px]"
          />
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
    </div>
  );
};

export default MyFlightBox;