import Navigation from "../components/Navigation.jsx";
import Banner from "../components/Homepage/Banner.jsx";
import Notification from "../components/Homepage/Notification.jsx";
import Footer from "../components/Homepage/Footer.jsx";
import News from "../components/Homepage/News.jsx";

function Homepage() {

    return (
        <>
            <Navigation/>
            <Banner/>
            <Notification/>
            <News />
            <Footer/>
        </>
    )
}


export default Homepage