import { useNavigate } from "react-router-dom";
import { useState } from "react";

const MyFlightBox = () => {
  const [ticketID, setTicketID] = useState("");
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [warning, setWarning] = useState("");
  const [passengerID, setPassengerID] = useState("");
  const [searchType, setSearchType] = useState("ticketID");
  const nav = useNavigate();

  function SearchTickets() {
    if ((!ticketID || !firstName || !lastName) && searchType === "ticketID") {
      setWarning("All fields are required.");
      return;
    }
    if ((!passengerID || !firstName || !lastName) && searchType === "passengerID") {
      setWarning("All fields are required.");
      return;
    }

    if (searchType === "ticketID") {
      nav("/myflight", {
        state: {
          ticketID: ticketID,
          firstName: firstName,
          lastName: lastName,
        },
      });
    }
    if (searchType === "passengerID") {
      nav("/myflights", {
        state: {
          passengerID: passengerID,
          firstName: firstName,
          lastName: lastName,
        },
      });
    }
  }

  const handleTicketIDChange = (e) => {
    const value = e.target.value;
    setTicketID(value);

    // Check if the input matches the required format
    const regex = /^T\d{6}$/;
    if (!regex.test(value)) {
      setWarning("Ticket ID must be TXXXXXX with X being a number");
    } else {
      setWarning("");
    }
  };

  const handlePassengerIDChange = (e) => {
    const value = e.target.value;
    setPassengerID(value);

    // Check if the input matches the required format
    const regex = /^\d{12}$/;
    if (!regex.test(value)) {
      setWarning("Passenger ID must be a 12-digit number");
    } else {
      setWarning("");
    }
  };

  return (
    <div className="p-6 h-full">
      <div className="flex space-x-4 mb-6 items-center">
        <button
          onClick={() => setSearchType("ticketID")}
          className={`${
            searchType === "ticketID"
              ? "text-[#6d24cf] font-semibold border-b-4 border-[#ffe06f]"
              : "text-[#778899] font-medium"
          } pb-1`}
        >
          Ticket ID
        </button>
        <button
          onClick={() => setSearchType("passengerID")}
          className={`${
            searchType === "passengerID"
              ? "text-[#6d24cf] font-semibold border-b-4 border-[#ffe06f]"
              : "text-[#778899] font-medium"
          } pb-1`}
        >
          Passenger ID
        </button>
      </div>
      <div className="flex flex-col md:flex-row items-stretch justify-between space-y-4 md:space-y-0">
        <div className="cursor-pointer">
        <p className="text-sm text-gray-500 pb-2 pl-2">
                {searchType === 'ticketID' ? 'Ticket ID' : 'Passenger ID'}
            </p>
            <input
                required={true}
                id={searchType === 'TicketID' ? 'ticketID' : 'passengerID'}
                type="text"
                placeholder={searchType === 'ticketID' ? 'TXXXXXX' : 'XXXXXXXXXXXX'}
                value={searchType === 'ticketID' ? ticketID : passengerID}
                onChange={searchType === 'ticketID' ? handleTicketIDChange : handlePassengerIDChange}
                className="border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-none focus:ring-1 focus:ring-[#6d24cf] focus:border-[#6d24cf] w-full h-[40px]"
            />
          {warning && <p className="text-red-500 text-xs mt-1">{warning}</p>}
        </div>
        {/* Divider */}
        <div className="gradient-border block"></div>
        <div className="cursor-pointer">
          <p className="text-sm text-gray-500 pb-2 pl-2">First Name</p>
          <input
            required={true}
            id="firstName"
            type="text"
            placeholder="HUY QUANG"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            className="border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-none focus:ring-1 focus:ring-[#6d24cf] focus:border-[#6d24cf] w-full h-[40px]"
          />
        </div>
        <div className="cursor-pointer">
          <p className="text-sm text-gray-500 pb-2 pl-2">Last Name</p>
          <input
            required={true}
            id="lastName"
            type="text"
            placeholder="CHU"
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