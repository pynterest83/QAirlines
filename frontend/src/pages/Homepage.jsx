import Navigation from "../components/Navigation.jsx";
import Banner from "../components/Homepage/Banner.jsx";
import Notification from "../components/Homepage/Notification.jsx";
import Footer from "../components/Homepage/Footer.jsx";
import News from "../components/Homepage/News.jsx";
import Info from "../components/Homepage/Info.jsx";
import ScrollToTop from "../scroll.jsx";

function Homepage() {

    return (
        <>
            <ScrollToTop/>
            <Navigation/>
            <Banner/>
            <Notification/>
            <News />
            <Info/>
            <Footer/>
        </>
    )
}


export default Homepage