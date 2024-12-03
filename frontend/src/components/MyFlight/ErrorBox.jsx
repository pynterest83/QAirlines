import React from "react";

const ErrorBox = () => {
  return (
    <div className="flex justify-center items-center">
      <div className="bg-white w-full max-w-[1000px] p-6 rounded-xl shadow-lg">
        {/* Top section */}
        <div className="flex justify-between items-center">
          <h2 className="text-lg font-semibold tracking-wide text-[#6d24cf]">
            BOARDING PASS
          </h2>
          <img className="w-56 py-3" src="/logo.png"/>
        </div>

        {/* Main content */}
        <div className="grid grid-cols-1 md:grid-cols-2 divide-y md:divide-y-0 md:divide-x divide-gray-300 mt-4">
          {/* Left section */}
          <div className="pr-4 pb-4 md:pb-0">
            <div className="mb-4">
              <h3 className="text-sm font-medium text-gray-500">FROM:</h3>
              <h1 className="text-2xl font-bold text-[#6d24cf]">NOT FOUND</h1>
              <p className="text-sm text-gray-500">NOT FOUND</p>
              <p className="text-sm text-gray-500">NOT FOUND</p>
            </div>
            <div>
              <h3 className="text-sm font-medium text-gray-500">TO:</h3>
              <h1 className="text-2xl font-bold text-[#6d24cf]">NOT FOUND</h1>
              <p className="text-sm text-gray-500">NOT FOUND</p>
              <p className="text-sm text-gray-500">NOT FOUND</p>
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
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Class</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
            </div>
            <div className="flex justify-between mb-4">
              <div>
                <h3 className="text-sm font-medium text-gray-500">Date</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Boarding</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Depart</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
            </div>
            <div className="flex justify-between">
              <div>
                <h3 className="text-sm font-medium text-gray-500">Flight</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Terminal</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Gate</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
              <div>
                <h3 className="text-sm font-medium text-gray-500">Seat</h3>
                <p className="text-[#6d24cf] font-semibold">NOT FOUND</p>
              </div>
            </div>
            {/* Error Message */}
            <div className="mt-6">
              <div className="h-10 bg-gray-200 rounded-md overflow-hidden">
                <p className="text-sm text-red-500 font-semibold text-center pt-2">ERROR: Ticket not found</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ErrorBox;