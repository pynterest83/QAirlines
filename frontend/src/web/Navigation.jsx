function Navigation() {
    return <nav className="pt-1.5 px-2 max-w-full bg-white border-black border-b be-vietnam-pro-medium">
        <ul className="flex max-w-full">
            <li className="ml-auto mr-4">
                <button className="text-xs be-vietnam-pro-light">English</button>
            </li>
            <li className="mr-32">
                <button className="text-xs  be-vietnam-pro-light">Sign up</button>
            </li>
        </ul>
        <div className="flex max-w-full pt-3">
            <ul className="text-base flex w-fit ml-auto">
                <li className="mx-4 cursor-pointer hover:br-color hover:border-b-4">
                    <div>Booking</div>
                </li>
                <li className="mx-4 cursor-pointer hover:br-color hover:border-b-4">
                    <div>Travel info</div>
                </li>
                <li className="mx-4 cursor-pointer hover:br-color hover:border-b-4">
                    <div>Help</div>
                </li>
            </ul>
            <input className="mb-4 text-sm ml-auto mr-2 px-2 py-1 rounded-md border border-black" placeholder="Search a topic..."/>
            <button className="text-sm be-vietnam-pro-bold text-white mb-4 rounded-2xl py-1.5 px-5 mr-32 gradient-button">Login</button>
        </div>
    </nav>
}
export default Navigation