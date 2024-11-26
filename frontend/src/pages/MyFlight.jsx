import { useLocation } from "react-router-dom";
import Navigation from "../components/Navigation.jsx";
import { Server } from "../Server.js";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useEffect } from "react";

function MyFlight() {
    const props = useLocation().state;
    const [ticketID, setTicketID] = useState(props.ticketID);
    const [firstName, setFirstName] = useState(props.firstName);
    const [lastName, setLastName] = useState(props.lastName);
    const nav = useNavigate();

    useEffect(() => {
        if (!props) return;
        // fetch ticket information
        // - **Example:** `/api/tickets/by-id?ticketId=T328760`
        fetch(Server + "/tickets/by-id?" + new URLSearchParams({
            ticketId: props.ticketID,
        }), {
            method: "GET"
        }).then((res) => res.json()).then((data) => {
            console.log(data);
        });
        
    }, [props]);
  
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
      <div className="relative">
        <Navigation selecting={"info"}/>
        <div className="px-4 md:px-0 border-[#000000] border flex-col md:flex-row py-2 w-[95%] md:w-4/6 bg-white rounded-lg md:rounded-lg mx-auto my-6 flex justify-evenly items-stretch be-vietnam-pro-bold">
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
}

export default MyFlight