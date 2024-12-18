import {useEffect, useState} from "react";
import { useLocation } from "react-router-dom";
import loaderGif from '../src/assets/images/airplaneLoader.gif'

function ScrollToTop() {
    const { pathname } = useLocation();
    const [loading, load] = useState(false)
    useEffect(() => {
        window.scrollTo(0, 0);
        load(true)
        setTimeout(() => load(false), 2000)
    }, [pathname]);
    if (!loading)
        return null;
    return (
        <div className="fixed w-[100vw] h-[100vh] overflow-y-scroll bg-white bg-opacity-70 z-30">
            <img className="top-1/2 h-72 absolute mx-auto left-1/2 transform -translate-x-1/2 -translate-y-1/2"
                 src={loaderGif}
                 alt="Loading..."/>
        </div>
    )
}

export default ScrollToTop