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
    const data = useRef(null)
    function Copy() {
        if (props.type === "Adult") {
            if (!(/^\d+$/.test(phoneNumber.current.value) || phoneNumber.current.value < 9 || phoneNumber.current.value > 15)) {
                phoneNumber.current.setCustomValidity("invalid")
            }
            if (!(/^\d+$/.test(ssn.current.value)) || ssn.current.value.length !== 12) {
                ssn.current.setCustomValidity("invalid")
            }
        }
        else {
            if (!(/^\d+$/.test(guardianSSN.current.value)) || guardianSSN.current.value.length !== 12) {
                guardianSSN.current.setCustomValidity("invalid")
            }
        }
        data.current = {
            firstName: firstName.current.validity.valid ? firstName.current.value : data.current.firstName,
            lastName: lastName.current.validity.valid ? lastName.current.value : data.current.lastName,
            dob: dob.current.validity.valid ? dob.current.value : data.current.dob,
            gender: gender.current.value === "Male" ? "M" : "F",
            seatNo: props.info.seatNo
        }
        if (props.type === "Adult") {
            data.current.email = email.current.validity.valid ? email.current.value : ""
            data.current.phoneNumber = phoneNumber.current.validity.valid ? phoneNumber.current.value : ""
            data.current.ssn = ssn.current.validity.valid ? ssn.current.value : ""
            data.current.passport = passport.current.validity.valid ? passport.current.value : ""
        }
        else {
            data.current.guardianSSN = guardianSSN.current.validity.valid ? guardianSSN.current.value : ""
        }
        props.setInfo(data.current)
    }

    function ChooseSeat() {
        if (!props.info.seatNo) props.openSeatMap()
    }
    const firstRender = useRef(true)
    useEffect(() => {
        if (props.info.seatNo && !firstRender.current) Copy()
        else firstRender.current = false
    }, [props.info.seatNo]);
    useEffect(() => {
        firstName.current.value = props.info.firstName
        lastName.current.value = props.info.lastName
        dob.current.value = props.info.dob
        gender.current.value = props.info.gender === "M" ? "Male" : "Female"
        if (props.type === "Adult") {
            email.current.value = props.info.email
            phoneNumber.current.value = props.info.phoneNumber
            passport.current.value = props.info.passport
            ssn.current.value = props.info.ssn
        }
        else {
            guardianSSN.current.value = props.info.guardianSSN
        }
        if (props.info.seatNo) {
            choose(true)
        }
        else {
            choose(false)
        }
        data.current = {
            firstName: props.info.firstName,
            lastName: props.info.lastName,
            dob: props.info.dob,
            gender: props.info.gender === "Male" ? "M" : "F",
            seatNo: props.info.seatNo
        }
        if (props.type === "Adult") {
            data.current.email = props.info.email
            data.current.phoneNumber = props.info.phoneNumber
            data.current.ssn = props.info.ssn
            data.current.passport = props.info.passport
        }
        else {
            data.current.guardianSSN = props.info.guardianSSN
        }
    }, []);

    return (
        <div className={(props.hidden ? "hidden " : "") + "p-8 shadow-[rgba(0,0,0,0.24)_0px_3px_8px] my-2 md:mx-36 rounded-2xl bg-white"}>
            <div className="flex flex-col">
                <label htmlFor="firstname" className="be-vietnam-pro-light">First name</label>
                <input required={true} ref={firstName}
                       onBlur={Copy}
                       onChange={() => firstName.current.setCustomValidity("")}
                       id="firstname"
                       className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>
            <div className="flex flex-col mt-2">
                <label htmlFor="lastname" className="be-vietnam-pro-light">Last name</label>
                <input required={true} ref={lastName}
                       onBlur={Copy}
                       onChange={() => lastName.current.setCustomValidity("")}
                       id="lastname"
                       className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>
            <div className="flex flex-col mt-2">
                <div className="be-vietnam-pro-light">Gender</div>
                <select onChange={Copy}
                    className="bg-transparent invalid:shadow-[0_2px_0_0_red] mt-2 be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]" ref={gender}>
                    <option>Male</option>
                    <option>Female</option>
                </select>
            </div>
            <div className="flex flex-col mt-2">
                <label htmlFor="dob" className="be-vietnam-pro-light">Date of birth</label>
                <input ref={dob} type="date" id="dob" max={new Date().toISOString().split("T")[0]}
                       onChange={() => dob.current.setCustomValidity("")}
                       onBlur={Copy}
                       required={true}
                       className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>
            {props.type === "Adult" &&
            <div className="flex flex-col mt-2">
                <label htmlFor="email" className="be-vietnam-pro-light">Email</label>
                <input required={true} ref={email} type="email" id="email"
                       onChange={() => email.current.setCustomValidity("")}
                       onBlur={Copy}
                       className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.type === "Adult" &&
                <div className="flex flex-col mt-2">
                <label htmlFor="phone" className="be-vietnam-pro-light">Phone number</label>
                <input ref={phoneNumber}
                       required={true}
                       id="phone"
                       onBlur={Copy}
                       onChange={() => phoneNumber.current.setCustomValidity("")}
                       className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.type === "Adult" &&
                <div className="flex flex-col mt-2">
                <label htmlFor="passport" className="be-vietnam-pro-light">Passport</label>
                <input id="passport" ref={passport}
                       required={true}
                       onBlur={Copy}
                       onChange={() => passport.current.setCustomValidity("")}
                       className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.type === "Adult" &&
                <div className="flex flex-col mt-2">
                <label htmlFor="ssn" className="be-vietnam-pro-light">SSN</label>
                <input id="ssn" ref={ssn}
                       required={true}
                       onBlur={Copy}
                       onChange={() => ssn.current.setCustomValidity("")}
                       className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
            </div>}
            {props.type === "Children" &&
                <div className="flex flex-col mt-2">
                    <label htmlFor="guardianSSN" className="be-vietnam-pro-light">Guardian SSN</label>
                    <input id="guardianSSN" ref={guardianSSN}
                           required={true}
                           onBlur={Copy}
                           onChange={() => guardianSSN.current.setCustomValidity("")}
                           className="bg-transparent invalid:shadow-[0_2px_0_0_red] be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf] shadow-[0_1px_0_0_#6d24cf]"/>
                </div>}
            <div className="flex flex-col mt-2 mb-4">
                <div className="be-vietnam-pro-light">Seat</div>
                <div ref={seatChosen} onClick={ChooseSeat}
                    className={
                        (!chosenSeat ? "shadow-[0_2px_0_0_red] " : "shadow-[0_1px_0_0_#6d24cf] ")
                        + "min-h-6 h-fit be-vietnam-pro-medium focus:outline-none focus:shadow-[0_2px_0_0_#6d24cf]"}>
                    {props.info.seatNo}
                </div>
            </div>
        </div>
    )
}

export default Ticket