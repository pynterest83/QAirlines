import { useRef, useState, useEffect } from "react";
import { FiMenu, FiX, FiSearch } from "react-icons/fi";
import { useNavigate } from "react-router-dom";
import { jwtDecode } from "jwt-decode";

function Navigation(props) {
    const [visibleDropdown, setVisibleDropdown] = useState(null);
    const [isLoggedIn, setIsLoggedIn] = useState(false);
    const [username, setUsername] = useState("");
    const list = useRef(null);
    const nav = useNavigate();

    useEffect(() => {
        const token = localStorage.getItem("token");
        if (token) {
            try {
                const decodedToken = jwtDecode(token);
                if (decodedToken.Role == "User") {
                    setIsLoggedIn(true);
                    setUsername(decodedToken.Username);
                } else {
                    // localStorage.removeItem("token");
                }
            } catch (error) {
                console.error("Invalid token:", error);
                setIsLoggedIn(false);
            }
        }
    }, []);

    const toggleMenu = () => {
        if (!list.current.className.includes("hidden"))
            list.current.className += "hidden";
        else {
            list.current.className = list.current.className.replaceAll(
                "hidden",
                ""
            );
        }
    };

    const toggleDropdown = (name) => {
        setVisibleDropdown(visibleDropdown === name ? null : name);
    };

    const handleSignOut = () => {
        localStorage.removeItem("token");
        setIsLoggedIn(false);
        nav("/");
    };

    return (
        <nav className="sticky z-50 top-0 left-0 right-0 px-2 max-w-full bg-white be-vietnam-pro-medium">
            <div className="flex max-w-full">
                <button
                    onClick={toggleMenu}
                    className="w-8 aspect-square inline-block lg:hidden active:bg-gray-300 hover:bg-gray-300"
                >
                    <FiMenu className="block m-auto" size={"1.5rem"} />
                </button>
                <img
                    onClick={() => nav("/")}
                    className="cursor-pointer w-56 py-3"
                    src="/logo.png"
                    alt="Logo"
                />
                <div
                    ref={list}
                    className="slide-from-left bg-white h-full lg:h-auto lg:pt-5 border-black border-r lg:border-none w-11/12 box-border lg:box-content top-0 left-0 lg:bg-white fixed lg:static lg:text-base lg:block lg:w-fit lg:ml-auto z-20 hidden"
                >
                    <button
                        className="lg:hidden ml-auto flex mr-1 my-1 active:bg-gray-300 hover:bg-gray-300"
                        onClick={toggleMenu}
                    >
                        <FiX size={"2rem"} />
                    </button>
                    <div className="lg:hidden flex">
                        <input
                            className="my-2 mx-1 flex-grow inline-flex text-sm p-2 rounded-lg border border-black"
                            placeholder="Search a topic..."
                        />
                        <button className="right-0 mx-1 active:bg-gray-300 hover:bg-gray-300">
                            <FiSearch size={"1.5rem"} />
                        </button>
                    </div>
                    <ul className="lg:h-full flex flex-col lg:flex-row">
                        {/* Booking */}
                        <li
                            className={
                                (props.selecting === "booking"
                                    ? "be-vietnam-pro-bold br-color border-r-4 lg:border-r-0 lg:border-b-4 "
                                    : "") +
                                "group relative p-2 hover:br-color active:br-color active:border-r-4 hover:border-r-4 lg:active:border-r-0 lg:hover:border-r-0 lg:mx-4 cursor-pointer lg:hover:br-color lg:hover:border-b-4 lg:hover:bg-white"
                            }
                            onMouseEnter={() => toggleDropdown("booking")}
                            onMouseLeave={() => toggleDropdown(null)}
                            onClick={() => toggleDropdown("booking")}
                        >
                            <div>Booking</div>
                            {/* Dropdown */}
                            <div
                                className={`${
                                    visibleDropdown === "booking"
                                        ? "block"
                                        : "hidden"
                                } slide-from-up bg-white shadow-md border border-gray-200 w-full lg:absolute lg:top-full lg:left-0 lg:mt-1 lg:w-64 p-4 lg:p-2`}
                            >
                                <ul>
                                    <li 
                                        className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer"
                                        onClick={() => nav("/flightstatus")}
                                    >
                                        Flight Status
                                    </li>
                                    <li className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer">
                                        Hotels
                                    </li>
                                    <li className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer">
                                        Car Rentals
                                    </li>
                                </ul>
                            </div>
                        </li>
                        {/* Travel Info */}
                        <li
                            className={
                                (props.selecting === "info"
                                    ? "be-vietnam-pro-bold br-color border-r-4 lg:border-r-0 lg:border-b-4 "
                                    : "") +
                                "group relative p-2 hover:br-color active:br-color active:border-r-4 hover:border-r-4 lg:active:border-r-0 lg:hover:border-r-0 lg:mx-4 cursor-pointer lg:hover:br-color lg:hover:border-b-4 lg:hover:bg-white"
                            }
                            onMouseEnter={() => toggleDropdown("info")}
                            onMouseLeave={() => toggleDropdown(null)}
                            onClick={() => toggleDropdown("info")}
                        >
                            <div>Travel info</div>
                            {/* Dropdown */}
                            <div
                                className={`${
                                    visibleDropdown === "info"
                                        ? "block"
                                        : "hidden"
                                } slide-from-up bg-white shadow-md border border-gray-200 w-full lg:absolute lg:top-full lg:left-0 lg:mt-1 lg:w-64 p-4 lg:p-2`}
                            >
                                <ul>
                                    <li 
                                        className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer"
                                        onClick={() => nav("/discount")}
                                    >
                                        Discount
                                    </li>
                                    <li className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer">
                                        Baggage Info
                                    </li>
                                    <li className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer">
                                        COVID-19 Guidelines
                                    </li>
                                </ul>
                            </div>
                        </li>
                        {/* Help */}
                        <li
                            className={
                                (props.selecting === "help"
                                    ? "be-vietnam-pro-bold br-color border-r-4 lg:border-r-0 lg:border-b-4 "
                                    : "") +
                                "group relative p-2 hover:br-color active:br-color active:border-r-4 hover:border-r-4 lg:active:border-r-0 lg:hover:border-r-0 lg:mx-4 cursor-pointer lg:hover:br-color lg:hover:border-b-4 lg:hover:bg-white"
                            }
                            onMouseEnter={() => toggleDropdown("help")}
                            onMouseLeave={() => toggleDropdown(null)}
                            onClick={() => toggleDropdown("help")}
                        >
                            <div>About Us</div>
                            {/* Dropdown */}
                            <div
                                className={`${
                                    visibleDropdown === "help"
                                        ? "block"
                                        : "hidden"
                                } slide-from-up bg-white shadow-md border border-gray-200 w-full lg:absolute lg:top-full lg:left-0 lg:mt-1 lg:w-64 p-4 lg:p-2`}
                            >
                                <ul>
                                    <li 
                                        className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer"
                                        onClick={() => nav("/aircrafts")}
                                    >
                                        Aircraft Fleet
                                    </li>
                                    <li 
                                        className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer"
                                        onClick={() => nav("/network")}
                                    >
                                        Flights Network
                                    </li>
                                    <li className="py-2 hover:border-b-2 hover:border-[#6d24cf] cursor-pointer"
                                        onClick={() => nav("/classes")}
                                    >
                                        Flight Classes
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <hr className="lg:hidden h-0.5 bg-black" />
                    {isLoggedIn ? (
                        <>
                            <div className="text-left w-full lg:hidden block be-vietnam-pro-bold px-2 py-3">
                                {username}
                            </div>
                            <button
                                onClick={handleSignOut}
                                className="text-left w-full lg:hidden block be-vietnam-pro-bold px-2 py-3 active:bg-gray-300 hover:bg-gray-300"
                            >
                                Sign out
                            </button>
                        </>
                    ) : (
                        <>
                            <button
                                onClick={() => nav("/login")}
                                className="text-left w-full lg:hidden block be-vietnam-pro-bold px-2 py-3 active:bg-gray-300 hover:bg-gray-300"
                            >
                                Login
                            </button>
                            <button
                                onClick={() => nav("/signup")}
                                className="text-left w-full lg:hidden block be-vietnam-pro-bold px-2 py-3 active:bg-gray-300 hover:bg-gray-300"
                            >
                                Sign up
                            </button>
                        </>
                    )}
                </div>
                <input
                    className="mt-5 hidden lg:inline-flex lg:static mb-4 text-sm ml-auto mr-2 px-2 py-1 rounded-lg border border-black"
                    placeholder="Search a topic..."
                />
                {isLoggedIn ? (
                    <>
                        <button
                            className="hidden lg:inline-block mt-5 text-sm be-vietnam-pro-bold text-white mb-4 rounded-2xl py-1.5 px-5 mr-2 gradient-button"
                        >
                            {username}
                        </button>
                        <button
                            onClick={handleSignOut}
                            className="hidden lg:inline-block mt-5 text-sm be-vietnam-pro-bold text-white mb-4 rounded-2xl py-1.5 px-5 mr-32 gradient-button"
                        >
                            Sign out
                        </button>
                    </>
                ) : (
                    <>
                        <button
                            onClick={() => nav("/login")}
                            className="hidden lg:inline-block mt-5 text-sm be-vietnam-pro-bold text-white mb-4 rounded-2xl py-1.5 px-5 mr-2 gradient-button"
                        >
                            Login
                        </button>
                        <button
                            onClick={() => nav("/signup")}
                            className="hidden lg:inline-block mt-5 text-sm be-vietnam-pro-bold text-white mb-4 rounded-2xl py-1.5 px-5 mr-32 gradient-button"
                        >
                            Sign up
                        </button>
                    </>
                )}
            </div>
        </nav>
    );
}

export default Navigation;