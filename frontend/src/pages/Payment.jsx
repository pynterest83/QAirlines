import React, { useState } from "react";
import Navigation from "../components/Navigation.jsx";
import paymentBackground from "../assets/images/bg2.jpg"; // Fixed typo in variable name

const Payment = () => {
  const [activeDropdown, setActiveDropdown] = useState(null);

  const paymentMethods = [
    {
      id: 1,
      name: "Thanh toán bằng mã VietQR",
      logo: "https://placehold.co/40x40",
      alt: "Logo VietQR",
      qrCode: "https://via.placeholder.com/200?text=VietQR",
      price: "2,344,000 VND",
    },
    {
      id: 2,
      name: "Thanh toán bằng mã VNPAY-QR",
      logo: "https://placehold.co/40x40",
      alt: "Logo VNPAY-QR",
      qrCode: "https://via.placeholder.com/200?text=VNPAY-QR",
      price: "2,344,000 VND",
    },
    {
      id: 3,
      name: "Ví điện tử MoMo",
      logo: "https://placehold.co/40x40",
      alt: "Logo MoMo",
      qrCode: "https://via.placeholder.com/200?text=MoMo",
      price: "2,344,000 VND",
    },
    {
      id: 4,
      name: "Thẻ ATM / Thẻ nội địa",
      logo: "https://placehold.co/40x40",
      alt: "Logo ATM/Thẻ nội địa",
      qrCode: "https://via.placeholder.com/200?text=ATM",
      price: "2,344,000 VND",
    },
  ];

  const toggleDropdown = (id) => {
    setActiveDropdown((prev) => (prev === id ? null : id));
  };

  return (
    <div className="relative flex flex-col">
      <Navigation selecting={"booking"} />
      <div
        className="w-full mx-auto my-4 flex items-center justify-center"
        style={{
          backgroundImage: `url(${paymentBackground})`,
          backgroundSize: "cover",
          backgroundPosition: "center",
          height: "200px",
        }}
      >
        <div className="shadow-[rgba(0,0,0,0.24)_0px_3px_8px] rounded-2xl bg-white p-5 max-w-[800px] mx-auto">
          <div className="text-center be-vietnam-pro-bold text-2xl">
            Payment for outbound flight
          </div>
          <div className="text-center be-vietnam-pro-medium text-xl">
            New York to Los Angeles
          </div>
          <div className="text-center be-vietnam-pro-medium text-xl">
            {new Date("2023-12-25T10:00:00").toLocaleString("en-UK", {
              weekday: "long",
              day: "numeric",
              month: "long",
            })}
          </div>
        </div>
      </div>

      {/* Payment Methods Section */}
      <div className="w-full max-w-[1000px] mx-auto space-y-4">
        {paymentMethods.map((method) => (
          <div
            key={method.id}
            className="bg-white shadow-[rgba(0,0,0,0.24)_0px_3px_8px] p-6 rounded-md"
          >
            <div className="flex justify-between items-center h-24">
              <div className="flex items-center space-x-4">
                <img
                  src={method.logo}
                  alt={method.alt}
                  className="w-10 h-10"
                />
                <span className="text-gray-700 font-medium">{method.name}</span>
              </div>
              <button
                onClick={() => toggleDropdown(method.id)}
                className="text-gray-500"
              >
                <i
                  className={`fas ${
                    activeDropdown === method.id
                      ? "fa-chevron-up"
                      : "fa-chevron-down"
                  }`}
                ></i>
              </button>
            </div>
            {activeDropdown === method.id && (
              <div className="slide-out flex justify-between items-center mt-4 space-x-4">
                <img
                  src={method.qrCode}
                  alt={`QR Code for ${method.name}`}
                  className="w-40 h-40"
                />
                {/* Pay Button with price */}
                <button className="bg-purple-500 text-white font-medium py-2 px-6 rounded-lg hover:bg-yellow-600 transition">
                  <i className="fas fa-shopping-cart mr-2"></i> {method.price}
                </button>
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default Payment;
