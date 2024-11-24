import {useState} from 'react';
import TicketBookingBox from './TicketBookingBox';
import MyFlightBox from './MyFlightBox';
import { FaPlane } from "react-icons/fa"; // Plane Icon for Booking
import { MdAirplaneTicket } from "react-icons/md";
const HomeBox = () => {
  const [activeMode, setActiveMode] = useState('booking'); // State to manage active mode
  return (
    <div className="max-w-4xl mx-auto overflow-hidden">
      {/* Header */}
      <div className="flex">
        {/* Booking Tab */}
        <div
          className={`rounded-l w-1/2 text-center p-4 cursor-pointer flex items-center justify-center space-x-2 ${
            activeMode === 'booking' ? 'bg-[#6d24cf] text-white' : 'bg-gray-200'
          }`}
          onClick={() => {
            setActiveMode('booking')
          }}
        >
          <FaPlane className="text-xl" /> {/* Plane Icon */}
          <h2 className="text-xl font-semibold">Booking</h2>
        </div>

        <div
          className={`rounded-r w-1/2 text-center p-4 cursor-pointer flex items-center justify-center space-x-2 ${
            activeMode === 'myFlight' ? 'bg-[#ffe06f]' : 'bg-gray-200'
          }`}
          onClick={() => {
            setActiveMode('myFlight')
          }}
        >
          <MdAirplaneTicket className="text-xl" />
          <h2 className="text-xl font-semibold">My Flight</h2>
        </div>
      </div>

      {activeMode === 'booking' ?
            <TicketBookingBox/>
          : <MyFlightBox/>}
    </div>
  );
};

export default HomeBox;
