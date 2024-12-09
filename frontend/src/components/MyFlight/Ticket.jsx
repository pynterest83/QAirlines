import React, { useState } from "react";
import { AirportData } from "../../assets/data/AirportData";
import { parseISO, format } from "date-fns";
import { Server } from "../../Server";
import jsPDF from "jspdf";
import html2canvas from "html2canvas";

const Ticket = (props) => {
  console.log(props);
  const [showCancelDialog, setShowCancelDialog] = useState(false);
  const [showDeadlineDialog, setShowDeadlineDialog] = useState(false);
  const [cancelMessage, setCancelMessage] = useState("");

  const depDate = format(parseISO(props.flight.DepTime), "dd MMM yyyy");
  const depTime = format(parseISO(props.flight.DepTime), "HH:mm");
  const arrDate = format(parseISO(props.flight.ArrTime), "dd MMM yyyy");
  const arrTime = format(parseISO(props.flight.ArrTime), "HH:mm");
  const boardingDate = format(parseISO(props.flight.BoardingTime), "dd MMM yyyy");
  const boardingTime = format(parseISO(props.flight.BoardingTime), "HH:mm");
  const cancelDeadline = format(parseISO(props.cancelDL), "dd MMM yyyy HH:mm");

  const courtesy = props.passenger.Gender === "M" ? "Mr." : "Ms.";

  const generatePDF = (containerId) => {
    const ticketElement = document.getElementById(containerId);
  
    // Temporarily hide buttons for PDF
    const buttons = ticketElement.querySelectorAll("button");
    buttons.forEach((button) => (button.style.display = "none"));
  
    html2canvas(ticketElement, { scale: 2 }).then((canvas) => {
      const imgData = canvas.toDataURL("image/png");
      const pdf = new jsPDF("p", "mm", "a4");
      const pdfWidth = pdf.internal.pageSize.getWidth();
      const pdfHeight = (canvas.height * pdfWidth) / canvas.width;
  
      pdf.addImage(imgData, "PNG", 0, 0, pdfWidth, pdfHeight);
      pdf.save("ticket.pdf");
  
      // Restore buttons after generating PDF
      buttons.forEach((button) => (button.style.display = ""));
    });
  };

  const handleCancelClick = () => {
    const currentDate = new Date();
    const deadlineDate = parseISO(props.cancelDL);

    if (currentDate < deadlineDate) {
      setShowCancelDialog(true);
    } else {
      setShowDeadlineDialog(true);
    }
  };

  const closeCancelDialog = () => {
    setShowCancelDialog(false);
  };

  const closeDeadlineDialog = () => {
    setShowDeadlineDialog(false);
  };

  const handleConfirmCancel = () => {
    fetch(Server + "/tickets/cancel-ticket", {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ ticketID: props.ticketID }),
    })
      .then((response) => response.json())
      .then((data) => {
        setCancelMessage(data.message);
        setShowCancelDialog(false);
        window.location.reload(); // Reload the page after successful cancellation
      })
      .catch((error) => {
        console.error("Error:", error);
        setCancelMessage("An error occurred while cancelling the ticket.");
        setShowCancelDialog(false);
      });
  };

  return (
    <div id="ticket-container" className="flex justify-center items-center">
      <div
        className="bg-white w-full max-w-[1000px] p-6 rounded-xl shadow-lg"
        style={{
          backgroundImage: "url('/src/assets/images/worlds.png')",
          backgroundSize: "cover",
          backgroundPosition: "center",

        }}
      >
        {/* Top section */}
        <div className="flex justify-between items-center">
          <h2 className="text-lg font-semibold tracking-wide text-[#6d24cf]">
            BOARDING PASS
          </h2>
          <img className="w-56 py-3" src="/logo.png" alt="Logo"/>
        </div>

        {/* Main content */}
        <div className="grid grid-cols-1 md:grid-cols-2 divide-y md:divide-y-0 md:divide-x divide-gray-300 mt-4">
          {/* Left section */}
          <div className="pr-4 pb-4 md:pb-0">
            <div className="mb-4">
              <h3 className="text-sm font-medium text-gray-500">FROM:</h3>
              <h1 className="text-2xl font-bold text-[#6d24cf]">{props.flight.DepID}</h1>
              <p className="text-sm text-gray-500">{AirportData[props.flight.DepID]}</p>
              <p className="text-sm text-gray-500">{depDate} - {depTime}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium text-gray-500">TO:</h3>
              <h1 className="text-2xl font-bold text-[#6d24cf]">{props.flight.DestID}</h1>
              <p className="text-sm text-gray-500">{AirportData[props.flight.DestID]}</p>
              <p className="text-sm text-gray-500">{arrDate} - {arrTime}</p>
            </div>
            {/* Icon and map illustration */}
            <div className="flex items-center justify-center mt-6">
              <div className="h-[1px] w-2/3 bg-gray-300 relative">
                <i className="fas fa-plane text-[#6d24cf] absolute -top-2 left-1/2 transform -translate-x-1/2"></i>
              </div>
            </div>
          </div>

          {/* Right section */}
          <div className="pl-4 pt-4 md:pt-0">
            <div className="flex justify-between mb-4">
              <div>
                <h3 className="text-sm font-medium text-gray-500">Passenger</h3>
                <p className="text-[#6d24cf] font-semibold">{courtesy} {props.passenger.FirstName} {props.passenger.LastName}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Class</h3>
                <p className="text-[#6d24cf] font-semibold">{props.class}</p>
              </div>
            </div>
            <div className="flex justify-between mb-4">
              <div>
                <h3 className="text-sm font-medium text-gray-500">Date</h3>
                <p className="text-[#6d24cf] font-semibold">{depDate}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Boarding</h3>
                <p className="text-[#6d24cf] font-semibold">{boardingDate} - {boardingTime}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Depart</h3>
                <p className="text-[#6d24cf] font-semibold">{depTime}</p>
              </div>
            </div>
            <div className="flex justify-between">
              <div>
                <h3 className="text-sm font-medium text-gray-500">Flight</h3>
                <p className="text-[#6d24cf] font-semibold">{props.flight.FlightID}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Passenger ID</h3>
                <p className="text-[#6d24cf] font-semibold">{props.passenger.PassID}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">AirCraft ID</h3>
                <p className="text-[#6d24cf] font-semibold">{props.aircraftID}</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Seat</h3>
                <p className="text-[#6d24cf] font-semibold">{props.seatNo}</p>
              </div>
            </div>
            {/* Cancel ticket button OR print ticket Button*/}
            <div className="flex justify-between mt-4">
              <button onClick={() => generatePDF("ticket-container")} className="be-vietnam-pro-semibold w-full px-6 py-2 bg-[#6d24cf] text-white rounded-md hover:bg-[#ffe06f] hover:text-black">Print Ticket</button>
              <button onClick={handleCancelClick} className="be-vietnam-pro-semibold w-full px-6 py-2 bg-[#6d24cf] text-white rounded-md hover:bg-[#B22222] ml-4">Cancel Ticket</button>
            </div>
          </div>
        </div>
      </div>

      {/* Cancel Confirmation Dialog */}
      {showCancelDialog && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white p-6 rounded-lg shadow-lg">
            <h2>Are you sure you want to cancel the ticket?</h2>
            <div className="flex justify-end mt-4">
              <button onClick={closeCancelDialog} className="mr-4 px-4 py-2 bg-gray-300 rounded-md">No</button>
              <button onClick={handleConfirmCancel} className="px-4 py-2 bg-red-500 text-white rounded-md">Yes</button>
            </div>
          </div>
        </div>
      )}

      {/* Deadline Notification Dialog */}
      {showDeadlineDialog && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white p-6 rounded-lg shadow-lg">
            <h2>Cannot cancel the ticket. The deadline was {cancelDeadline}.</h2>
            <div className="flex justify-end mt-4">
              <button onClick={closeDeadlineDialog} className="px-4 py-2 bg-gray-300 rounded-md">OK</button>
            </div>
          </div>
        </div>
      )}

      {/* Cancellation Message */}
      {cancelMessage && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white p-6 rounded-lg shadow-lg">
            <h2>{cancelMessage}</h2>
            <div className="flex justify-end mt-4">
              <button onClick={() => setCancelMessage("")} className="px-4 py-2 bg-gray-300 rounded-md">OK</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Ticket;