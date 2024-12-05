import {useRef, useState} from "react";

function Payments() {
    const [hidden, hide] = useState(false)
    const method = useRef("Choose payment method")
    const method_list = useRef([
        "Momo", "VNPay", "Visa", "Mastercard"
    ])
    return (
            <div onClick={() => hide(!hidden)} className="hover:bg-[#e8e1df] pr-2 mr-2 ml-auto bg-transparent be-vietnam-pro-medium">
                <div className="flex items-center justify-center">
                    <img className="h-12 p-2 inline-block" alt="" src={"/payments/" + method.current.toLowerCase() + ".png"}/>
                    {method.current}
                </div>

                <div className={(hidden ? "hidden " : "")
                    + "shadow-[rgba(0,0,0,0.24)_0px_3px_8px] absolute rounded-xl bg-white top-full"}>
                    {method_list.current.map((_method) =>
                        <div className="h-12 px-2 flex items-center hover:bg-[#e8e1df]" onClick={() => method.current = _method} key={_method}>
                            <img className="p-2 h-full inline-block" alt="" src={"/payments/" +_method.toLowerCase() + ".png"}/>
                            {_method}
                        </div>
                    )}
                </div>
            </div>
    )
}
export default Payments