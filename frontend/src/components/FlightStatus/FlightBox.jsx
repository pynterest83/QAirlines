import React from "react";
import { useNavigate } from "react-router-dom";
import { AirportData } from "../../assets/data/AirportData";

const FlightBox = (props) => {
  const navigate = useNavigate();

  const flightID = props.FlightID;
  const flightStatus = props.Status.toUpperCase();
  const departureTime = new Date(props.DepTime);
  const arrivalTime = new Date(props.ArrTime);
  const boardingTime = new Date(props.BoardingTime);
  const originalDepartureTime = props.OriginalDepTime ? new Date(props.OriginalDepTime) : null;
  const originalArrivalTime = props.OriginalArrTime ? new Date(props.OriginalArrTime) : null;
  const originalBoardingTime = props.OriginalBoardingTime ? new Date(props.OriginalBoardingTime) : null;
  const DepID = props.DepID;
  const DestID = props.DestID;

  const formatDate = (date) => {
    return date.toLocaleString('en-US', {
      weekday: 'short',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const getPlanePosition = () => {
    switch (flightStatus) {
      case 'SCHEDULED':
        return { left: '0%' };
      case 'IN-FLIGHT':
        return { left: '50%' }; // Middle of the line
      case 'ARRIVED':
        return { left: '100%' };
      default:
        return null;
    }
  };

  const planePosition = getPlanePosition();
  const planeLeft = planePosition ? parseFloat(planePosition.left) : 0;

  return (
    <div className="relative z-10 bg-gray-100 py-2">
      <div className="max-w-[1000px] mx-auto">
        {/* Flight List */}
        <div className="mt-5 space-y-5">
          {/* Flight Item */}
          <div className="bg-white rounded-lg p-6 flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0 border border-black relative group">
            <div className="flex flex-col items-center md:items-start">
              <p className="text-2xl text-[#6d24cf] font-semibold">{flightID}</p>  
              <p className="text-yellow-600 font-bold mt-1">{flightStatus}</p>
            </div>
            <hr className="border-t border-gray-300 w-full md:hidden" />
            <div className="flex flex-col items-center md:items-start">
              {originalDepartureTime && (
                <p className="line-through text-gray-400">{formatDate(originalDepartureTime)}</p>
              )}
              <p className="text-yellow-600 font-bold">{formatDate(departureTime)}</p>
              <p className="text-gray-600 mt-1">
                {DepID} - {AirportData[DepID]}
              </p>
              <p className="text-gray-600 font-bold mt-1">Boarding: {formatDate(boardingTime)}</p>
            </div>
            <div className="relative h-[50px] w-[200px]">
              <svg width="100%" height="100%">
                <path
                  id='solid-line'
                  strokeWidth='4'
                  fill='none'
                  stroke='#d3d3d3' // Lighter gray color
                  d={`M0,25 L${planeLeft * 1.92},25`}
                />
                <path
                  id='dashed-line'
                  strokeWidth='4'
                  fill='none'
                  stroke='#d3d3d3' // Lighter gray color
                  strokeDasharray='5,5'
                  d={`M${planeLeft * 1.92},25 L192,25`}
                />
              </svg>
              {planePosition && (
                <i className="fas fa-plane text-[#6d24cf] text-2xl" style={{ position: 'absolute', top: '50%', transform: 'translateY(-50%)', ...planePosition }}></i>
              )}
            </div>
            <div className="flex flex-col items-center md:items-start">
              {originalArrivalTime && (
                <p className="line-through text-gray-400">{formatDate(originalArrivalTime)}</p>
              )}
              <p className="text-purple-600 font-bold">{formatDate(arrivalTime)}</p>
              <p className="text-gray-600 mt-1">
                {DestID} - {AirportData[DestID]}
              </p>
            </div>
            <div className="hidden group-hover:flex absolute inset-0 bg-black bg-opacity-50 justify-center items-center">
              <button
                className="gradient-button text-white py-2 px-4 rounded-md"
                onClick={() => navigate('/')}
              >
                Book Now
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default FlightBox;