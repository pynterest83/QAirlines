import {useEffect, useRef, useState} from "react";

function Ticket(props) {
    const firstName = useRef(null)
    const lastName = useRef(null)
    const dob = useRef(null)
    const email = useRef(null)
    const gender = useRef(null)
    const phoneNumber = useRef(null)
    const passport = useRef(null)
    const ssn = useRef(null)
    const seatChosen = useRef(null)
    const guardianSSN = useRef(null)
    const [chosenSeat, choose] = useState(false)
    useEffect(() => {
        if (props.seat) {
            choose(true)
        }
        else choose(false)
    }, [props.seat]);
    function Submit() {
        if (!firstName.current.validity.valid || !lastName.current.validity.valid
        || !dob.current.validity.valid || !props.seat) {
            return
        }
        if (props.currentType === "Adult") {
            if (!email.current.validity.valid
                || !phoneNumber.current.validity.valid || !passport.current.validity.valid
                || !ssn.current.validity.valid) return
            if (!(/^\d+$/.test(phoneNumber.current.value))) {
                phoneNumber.current.setCustomValidity("invalid")
                return
            }
            if (!(/^\d+$/.test(ssn.current.value))) {
                ssn.current.setCustomValidity("invalid")
                return
            }
            let data = {
                firstName: firstName.current.value,
                lastName: lastName.current.value,
                dob: dob.current.value,
                gender: gender.current.value === "Male" ? "M" : "F",
                email: email.current.value,
                phoneNumber: phoneNumber.current.value,
                passport: passport.current.value,
                ssn: ssn.current.value,
                seatNo: props.seat
            }
            email.current.value = ""
            phoneNumber.current.value = ""
            passport.current.value = ""
            ssn.current.value = ""
            props.set(data)
            console.log(data)
        }
        else {
            if (!(/^\d+$/.test(guardianSSN.current.value))) {
                guardianSSN.current.setCustomValidity("invalid")
                return
            }
            let data = {
                firstName: firstName.current.value,
                lastName: lastName.current.value,
                dob: dob.current.value,
                gender: gender.current.value === "Male" ? "M" : "F",
                guardianSSN: guardianSSN.current.value,
                seatNo: props.seat
            }
            guardianSSN.current.value = ""
            props.set(data)
            console.log(data)
        }
        firstName.current.value = ""
        lastName.current.value = ""
        dob.current.value = ""
        gender.current.value = "Male"
    }
    return (
        <div className="lg:m-2 lg:w-1/5 absolute border border-black bg-white rounded-2xl p-4">
            <div className="flex flex-col">
                <label htmlFor="firstname" className="be-vietnam-pro-light">First name</label>
                <input required={true} ref={firstName}
                       onChange={() => firstName.current.setCustomValidity("")}
                       id="firstname"
                       className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>
            <div className="flex flex-col mt-2">
                <label htmlFor="lastname" className="be-vietnam-pro-light">Last name</label>
                <input required={true} ref={lastName}
                       onChange={() => lastName.current.setCustomValidity("")}
                       id="lastname"
                       className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>
            <div className="flex flex-col mt-2">
                <div className="be-vietnam-pro-light">Gender</div>
                <select className="invalid:shadow-[0_2px_0_0_red] mt-2 be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]" ref={gender}>
                    <option>Male</option>
                    <option>Female</option>
                </select>
            </div>
            <div className="flex flex-col mt-2">
                <label htmlFor="dob" className="be-vietnam-pro-light">Date of birth</label>
                <input ref={dob} type="date" id="dob" min={new Date().toISOString().split("T")[0]}
                       onChange={() => dob.current.setCustomValidity("")}
                       required={true}
                       className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>
            {props.currentType === "Adult" &&
            <div className="flex flex-col mt-2">
                <label htmlFor="email" className="be-vietnam-pro-light">Email</label>
                <input required={true} ref={email} type="email" id="email"
                       onChange={() => email.current.setCustomValidity("")}
                       className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.currentType === "Adult" &&
                <div className="flex flex-col mt-2">
                <label htmlFor="phone" className="be-vietnam-pro-light">Phone number</label>
                <input ref={phoneNumber}
                       required={true}
                       id="phone"
                       onChange={() => phoneNumber.current.setCustomValidity("")}
                       className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.currentType === "Adult" &&
                <div className="flex flex-col mt-2">
                <label htmlFor="passport" className="be-vietnam-pro-light">Passport</label>
                <input id="passport" ref={passport}
                       required={true}
                       onChange={() => passport.current.setCustomValidity("")}
                       className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.currentType === "Adult" &&
                <div className="flex flex-col mt-2">
                <label htmlFor="ssn" className="be-vietnam-pro-light">SSN</label>
                <input id="ssn" ref={ssn}
                       required={true}
                       onChange={() => ssn.current.setCustomValidity("")}
                       className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.currentType === "Children" &&
                <div className="flex flex-col mt-2">
                    <label htmlFor="guardianSSN" className="be-vietnam-pro-light">Guardian SSN</label>
                    <input id="guardianSSN" ref={guardianSSN}
                           required={true}
                           onChange={() => guardianSSN.current.setCustomValidity("")}
                           className="invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
                </div>}
            <div className="flex flex-col mt-2 mb-4">
                <div className="be-vietnam-pro-light">Seat</div>
                <div ref={seatChosen}
                    className={
                        (!chosenSeat ? "shadow-[0_2px_0_0_red] " : "shadow-[0_1px_0_0_#6d24cf] ")
                        + "min-h-6 h-fit be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf]"}>
                    {props.seat}
                </div>
            </div>
            <button onClick={Submit} className="p-3 bg-[#812af5] hover:bg-[#6d24cf] text-white rounded-xl be-vietnam-pro-bold">Confirm</button>
        </div>
    )
}

export default Ticket