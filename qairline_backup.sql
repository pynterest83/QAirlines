--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: qairline
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO qairline;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: qairline
--

COMMENT ON SCHEMA public IS '';


--
-- Name: enum_Seat_Class; Type: TYPE; Schema: public; Owner: qairline
--

CREATE TYPE public."enum_Seat_Class" AS ENUM (
    'Economy',
    'Business',
    'First'
);


ALTER TYPE public."enum_Seat_Class" OWNER TO qairline;

--
-- Name: enum_TicketClass_ClassName; Type: TYPE; Schema: public; Owner: qairline
--

CREATE TYPE public."enum_TicketClass_ClassName" AS ENUM (
    'Economy',
    'Business',
    'First'
);


ALTER TYPE public."enum_TicketClass_ClassName" OWNER TO qairline;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Aircraft; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Aircraft" (
    "AircraftID" character varying(10) NOT NULL,
    "Model" character varying(50) NOT NULL,
    "Manufacturer" character varying(50) NOT NULL,
    "Capacity" integer NOT NULL,
    "ImagePath" character varying(255),
    "JsonPath" character varying(255),
    "RelatedImages" text
);


ALTER TABLE public."Aircraft" OWNER TO qairline;

--
-- Name: Airport; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Airport" (
    "AirportID" character(3) NOT NULL,
    "AirportName" character varying(100) NOT NULL,
    "City" character varying(50),
    "Country" character varying(50)
);


ALTER TABLE public."Airport" OWNER TO qairline;

--
-- Name: Banner; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Banner" (
    "BannerID" character varying(10) NOT NULL,
    "Title" character varying(100) NOT NULL,
    "Description" text,
    "ImageURL" character varying(255) NOT NULL,
    "DiscountTitle" character varying(50),
    "DiscountDescription" text
);


ALTER TABLE public."Banner" OWNER TO qairline;

--
-- Name: Flight; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Flight" (
    "FlightID" character varying(10) NOT NULL,
    "Status" character varying(20) NOT NULL,
    "DepTime" timestamp with time zone NOT NULL,
    "ArrTime" timestamp with time zone NOT NULL,
    "BoardingTime" timestamp with time zone NOT NULL,
    "DepID" character(3) NOT NULL,
    "DestID" character(3) NOT NULL,
    "AircraftID" character varying(10) NOT NULL,
    "OriginalDepTime" timestamp with time zone,
    "OriginalArrTime" timestamp with time zone,
    "OriginalBoardingTime" timestamp with time zone
);


ALTER TABLE public."Flight" OWNER TO qairline;

--
-- Name: FlightSeat; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."FlightSeat" (
    "FlightID" character varying(10) NOT NULL,
    "AircraftID" character varying(10) NOT NULL,
    "SeatNo" character varying(5) NOT NULL,
    "TicketID" character varying(10)
);


ALTER TABLE public."FlightSeat" OWNER TO qairline;

--
-- Name: Passenger; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Passenger" (
    "PassID" character varying(10) NOT NULL,
    "FirstName" character varying(50) NOT NULL,
    "LastName" character varying(50) NOT NULL,
    "DOB" date NOT NULL,
    "Gender" character(1) NOT NULL,
    "Email" character varying(100),
    "PhoneNumber" character varying(15),
    "Passport" character varying(20),
    "SSN" character(12),
    "GuardianID" character varying(10)
);


ALTER TABLE public."Passenger" OWNER TO qairline;

--
-- Name: Promotion; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Promotion" (
    "PromotionID" character varying(10) NOT NULL,
    "Content" text NOT NULL,
    "Title" character varying(100) NOT NULL,
    "Amount" numeric(10,2) NOT NULL
);


ALTER TABLE public."Promotion" OWNER TO qairline;

--
-- Name: Seat; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Seat" (
    "AircraftID" character varying(10) NOT NULL,
    "SeatNo" character varying(5) NOT NULL,
    "Class" public."enum_Seat_Class" NOT NULL
);


ALTER TABLE public."Seat" OWNER TO qairline;

--
-- Name: Ticket; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Ticket" (
    "TicketID" character varying(10) NOT NULL,
    "FlightID" character varying(10) NOT NULL,
    "AircraftID" character varying(10) NOT NULL,
    "SeatNo" character varying(5) NOT NULL,
    "PassID" character varying(10) NOT NULL,
    "CancellationDeadline" timestamp with time zone NOT NULL
);


ALTER TABLE public."Ticket" OWNER TO qairline;

--
-- Name: TicketClass; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."TicketClass" (
    "ClassName" public."enum_TicketClass_ClassName" NOT NULL,
    "FlightID" character varying(10) NOT NULL,
    "Price" numeric(10,2) NOT NULL
);


ALTER TABLE public."TicketClass" OWNER TO qairline;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: qairline
--

CREATE TABLE public."Users" (
    "UserID" character varying(255) NOT NULL,
    "Username" character varying(50) NOT NULL,
    "Password" character varying(255) NOT NULL,
    "Role" character varying(255) DEFAULT 'User'::character varying NOT NULL
);


ALTER TABLE public."Users" OWNER TO qairline;

--
-- Data for Name: Aircraft; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Aircraft" ("AircraftID", "Model", "Manufacturer", "Capacity", "ImagePath", "JsonPath", "RelatedImages") FROM stdin;
A350	Airbus A350	Airbus	500	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A350/A350.svg	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A350/A350.json	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A350/related-images/A350_1.jpg,https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A350/related-images/A350_2.jpg
A380	Airbus A380	Airbus	500	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A380/A380.svg	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A380/A380.json	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A380/related-images/A380_1.jpg,https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/aircraft-files/A380/related-images/A380_2.jpg
\.


--
-- Data for Name: Airport; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Airport" ("AirportID", "AirportName", "City", "Country") FROM stdin;
OCA	Ocean Reef Club Airport	Key Largo	United States
CUX	Cuddihy Field	Corpus Christi	United States
CSE	Crested Butte Airpark	Crested Butte	United States
CUS	Columbus Airport	Columbus	United States
JCY	LBJ Ranch Airport	Stonewall	United States
WLR	Loring Seaplane Base	Loring	United States
NUP	Nunapitchuk Airport	Nunapitchuk	United States
PTC	Port Alice Seaplane Base	Port Alice	United States
ICY	Icy Bay Airport	Icy Bay	United States
PPV	Port Protection Seaplane Base	Port Protection	United States
KKK	Kalakaket Creek AS Airport	Kalakaket Creek	United States
MHS	Dunsmuir Muni-Mott Airport	Dunsmuir	United States
NIR	Chase Field Industrial Airport	Beeville	United States
GCT	Grand Canyon Bar Ten Airstrip	Littlefield	United States
ELW	Ellamar Seaplane Base	Ellamar	United States
LVD	Lime Village Airport	Lime Village	United States
HGZ	Hog River Airport	Hogatza	United States
OTN	Ed-Air Airport	Oaktown	United States
TLF	Telida Airport	Telida	United States
BZT	Eagle Air Park	Brazoria	United States
HBH	Entrance Island Seaplane Base	Entrance Island	United States
FAK	False Island Seaplane Base	False Island	United States
BYW	Blakely Island Airport	Blakely Island	United States
DRF	Drift River Airport	Kenai	United States
BDF	Rinkenberger Restricted Landing Area	Bradford	United States
TEH	Tetlin Airport	Tetlin	United States
VRS	Roy Otten Memorial Airfield	Versailles	United States
GDH	Golden Horn Lodge Seaplane Base	Golden Horn Lodge	United States
ATT	Atmautluak Airport	Atmautluak	United States
LIV	Livengood Camp Airport	Livengood	United States
PDB	Pedro Bay Airport	Pedro Bay	United States
KOZ	Ouzinkie Airport	Ouzinkie	United States
TNK	Tununak Airport	Tununak	United States
WHD	Hyder Seaplane Base	Hyder	United States
MNT	Minto Al Wright Airport	Minto	United States
TKI	Tokeen Seaplane Base	Tokeen	United States
WKK	Aleknagik / New Airport	Aleknagik	United States
WFB	Ketchikan Harbor Seaplane Base	Ketchikan	United States
RFK	Rollang Field	Rolling Fork	United States
NNK	Naknek Airport	Naknek	United States
BKF	Lake Brooks Seaplane Base	Katmai National Park	United States
BCS	Southern Seaplane Airport	Belle Chasse	United States
MMN	Minute Man Air Field	Stow	United States
SPQ	Catalina Air-Sea Terminal Heliport	San Pedro	United States
TSS	East 34th Street Heliport	New York	United States
NYS	New York Skyports Inc Seaplane Base	New York	United States
BWL	Earl Henry Airport	Blackwell	United States
WYB	Yes Bay Lodge Seaplane Base	Yes Bay	United States
CWS	Center Island Airport	Center Island	United States
TEK	Tatitlek Airport	Tatitlek	United States
DUF	Pine Island Airport	Corolla	United States
SSW	Stuart Island Airpark	Friday Harbor	United States
FOB	Fort Bragg Airport	Fort Bragg	United States
PUL	Port of Poulsbo Marina Moorage Seaplane Base	Poulsbo	United States
CCD	Century City Heliport	Los Angeles	United States
WMK	Meyers Chuck Seaplane Base	Meyers Chuck	United States
AXB	Maxson Airfield	Alexandria Bay	United States
REE	Reese Airpark	Lubbock	United States
WDN	Waldron Airstrip	Eastsound	United States
WWP	Whale Pass Seaplane Float Harbor Facility	Whale Pass	United States
CHU	Chuathbaluk Airport	Chuathbaluk	United States
UGS	Ugashik Airport	Ugashik	United States
JID	Recreation and Conference Center Heliport	City of Industry	United States
PSQ	Philadelphia Seaplane Base	Essington	United States
KLL	Levelock Airport	Levelock	United States
SGW	Saginaw Seaplane Base	Saginaw Bay	United States
WTL	Tuntutuliak Airport	Tuntutuliak	United States
TWA	Twin Hills Airport	Twin Hills	United States
KCQ	Chignik Lake Airport	Chignik Lake	United States
AAD	Adado Airport	Adado	Somalia
ABP	Atkamba Airport	Atkamba Mission	Papua New Guinea
ACM	Arica Airport	Arica	Colombia
ADC	Andakombe Airport	Andekombe	Papua New Guinea
ADV	El Daein Airport	El Daein	Sudan
DJH	Jebel Ali Seaplane Base	Jebel Ali	United Arab Emirates
AEE	Adareil Airport	Adar	South Sudan
AEK	Aseki Airport	Aseki	Papua New Guinea
AEQ	Ar Horqin Airport	Chifeng	China
KHT	"Ghost" International Airport	Khost	Afghanistan
URZ	Orūzgān Airport	Orūzgān	Afghanistan
OLR	Salerno Airport	Khost	Afghanistan
AFK	Kondavattavana Tank Seaplane Base	Ampara	Sri Lanka
AFR	Afore Airstrip		Papua New Guinea
AFT	Afutara Aerodrome	Bila	Solomon Islands
RNA	Ulawa Airport	Arona	Solomon Islands
ATD	Uru Harbour Airport	Atoifi	Solomon Islands
VEV	Barakoma Airport	Barakoma	Solomon Islands
GEF	Geva Airport	Liangia	Solomon Islands
AGG	Angoram Airport	Angoram	Papua New Guinea
AKS	Gwaunaru'u Airport	Auki	Solomon Islands
BNY	Bellona/Anua Airport	Anua	Solomon Islands
CHY	Choiseul Bay Airport		Solomon Islands
BAS	Ballalae Airport	Ballalae	Solomon Islands
FRE	Fera/Maringe Airport	Fera Island	Solomon Islands
HIR	Honiara International Airport	Honiara	Solomon Islands
MBU	Babanakira Airport	Mbambanakira	Solomon Islands
AVU	Avu Avu Airport		Solomon Islands
IRA	Ngorangora Airport	Kirakira	Solomon Islands
SCZ	Santa Cruz/Graciosa Bay/Luova Airport	Santa Cruz/Graciosa Bay/Luova	Solomon Islands
MUA	Munda Airport	Munda	Solomon Islands
NUE	Nuremberg Airport	Nuremberg	Germany
GZO	Nusatupe Airport	Gizo	Solomon Islands
MNY	Mono Airport	Stirling Island	Solomon Islands
PRS	Parasi Airport	Parasi	Solomon Islands
RNL	Rennell/Tingoa Airport	Rennell Island	Solomon Islands
EGM	Sege Airport	Sege	Solomon Islands
NNB	Santa Ana Airport	Santa Ana Island	Solomon Islands
RUS	Marau Airport	Marau	Solomon Islands
VAO	Suavanao Airport	Suavanao	Solomon Islands
XYA	Yandina Airport	Yandina	Solomon Islands
AGK	Kagua Airport	Kagua	Papua New Guinea
KGE	Kaghau Airport	Kagau Island	Solomon Islands
KUE	Kukudu Airport	Kolombangara Island	Solomon Islands
KWS	Kwailabesi Airport	Kwailabesi	Solomon Islands
AGL	Wanigela Airport		Papua New Guinea
LLM	Lomlom Airport	Lomlom	Solomon Islands
NAZ	Nana Airport	Star Harbor	Solomon Islands
MHM	Manaoba Airport	Manaoba	Solomon Islands
GTA	Gatokae Aerodrome	Gatokae	Solomon Islands
RIN	Ringi Cove Airport	Ringi Cove	Solomon Islands
RBV	Ramata Airport	Ramata	Solomon Islands
TLG	Tulaghi Heliport	Tulaghi Island	Solomon Islands
AGY	Argyle Downs Airport	Argyle Downs	Australia
AHJ	Hongyuan Airport	Ngawa (Hongyuan)	China
AHY	Ambatolhy Airport	Ambatolahy	Madagascar
AIE	Aiome Airport	Aiome	Papua New Guinea
AIH	Aiambak Airport	Aiambak	Papua New Guinea
AIC	Ailinglaplap Airok Airport	Bigatyelang Island	Marshall Islands
CEX	Chena Hot Springs Airport	Chena Hot Springs	United States
SOL	Solomon State Field	Solomon	United States
HED	Herendeen Bay Airport	Herendeen Bay	United States
TWE	Taylor Airport	Taylor	United States
KTH	Tikchik Lodge Seaplane Base	Tikchik	United States
NKI	Naukati Bay Seaplane Base	Tuxekan Island	United States
LNI	Point Lonely Short Range Radar Site Airfield	Point Lonely	United States
CDL	Candle 2 Airport	Candle	United States
AOS	Amook Bay Seaplane Base	Amook Bay	United States
BSW	Boswell Bay Airport	Boswell Bay	United States
AKM	Zakuoma Airport	ZaKouma	Chad
ALZ	Alitak Seaplane Base	Lazy Bay	United States
PPE	Mar de Cortés International Airport	Puerto Peñasco	Mexico
AME	Alto Molocue Airport	Alto Molocue	Mozambique
AMF	Ama Airport		Papua New Guinea
AMU	Amanab Airport	Amanab	Papua New Guinea
AMY	Ambatomainty Airport		Madagascar
INU	Nauru International Airport	Yaren District	Nauru
ANZ	Angus Downs Airport	Angus Downs Station	Australia
CTV	Catoca Airport	Saurimo	Angola
ANL	Andulo Airport	Andulo	Angola
CNZ	Cangamba Airport	Cangamba	Angola
DRC	Dirico Airport	Dirico	Angola
KNP	Capanda Airport	Capanda	Angola
NDF	N'dalatando Airport	N'dalatando	Angola
AOB	Annanberg Airport		Papua New Guinea
AOD	Abou-Deïa Airport	Abou-Deïa	Chad
APP	Asapa Airport		Papua New Guinea
APR	April River Airport	April River	Papua New Guinea
AQY	Girdwood-Alyeska Airport	Girdwood	United States
QRF	Bragado Airport	Bragado	Argentina
CVI	Caleta Olivia Airport	Caleta Olivia	Argentina
CNT	Charata Airport	Charata	Argentina
VGS	General Villegas Airport	General Villegas	Argentina
LMD	Los Menucos Airport	Los Menucos	Argentina
VCF	Valcheta Airport	Valcheta	Argentina
NCJ	Sunchales Aeroclub Airport	Sunchales	Argentina
CPG	Carmen de Patagones Airport	Carmen de Patagones	Argentina
PRQ	Termal Airport	Presidencia Roque Sáenz Peña	Argentina
ARP	Aragip Airport		Papua New Guinea
ASZ	Asirim Airport		Papua New Guinea
ATN	Namatanai Airport	Namatanai	Papua New Guinea
ATP	Aitape Airport	Aitape	Papua New Guinea
LYT	Lady Elliot Island Airstrip	Lady Elliot Island	Australia
GYZ	Gruyere Airport	Cosmo Newbery	Australia
KQR	Karara Airport	Karara	Australia
ABH	Alpha Airport	Alpha	Australia
AGW	Agnew Airport	Agnew	Australia
AYD	Alroy Downs Airport	Alroy Downs	Australia
BYX	Baniyala Airport	Baniyala	Australia
COB	Coolibah Airport	Coolibah	Australia
CRJ	Coorabie Airport	Coorabie	Australia
CRY	Carlton Hill Airport	Carlton Hill	Australia
CSD	Cresswell Downs Airport	Cresswell Downs	Australia
DYM	Diamantina Lakes Airport	Diamantina Lakes	Australia
HIS	Hayman Island Resort Seaplane Base	Hayman Island	Australia
HLV	Helenvale Airport	Helenvale	Australia
KBD	Kimberley Downs Airport	Kimberley Downs	Australia
KGR	Kulgera Airport	Ghan	Australia
OKB	Orchid Beach Airport	Orchid Beach	Australia
PEP	Peppimenarti Airport	Peppimenarti	Australia
RDA	Rockhampton Downs Airport	Rockhampton Downs	Australia
SSK	Sturt Creek Airport	Sturt Creek	Australia
SWB	Shaw River Airport	Shaw River	Australia
TPR	Tom Price Airport	Tom Price	Australia
TWP	Torwood Airport	Torwood	Australia
ZVG	Springvale Airport	Springvale	Australia
AUI	Aua Island Airport	Aua Island	Papua New Guinea
AUJ	Ambunti Airport	Ambunti	Papua New Guinea
AUP	Agaun Airport		Papua New Guinea
AUV	Aumo Airport	Aumo	Papua New Guinea
AWE	Alowe Airport	Wonga Wongué Presidential Reserve	Gabon
AWR	Awar Airport (unusable)	Awar	Papua New Guinea
AXF	Alxa Left Banner Bayanhot Airport	Bayanhot	China
AXO	Pantar Kabir Airport	Kabir	Indonesia
KPM	Kompiam Airport		Papua New Guinea
BUA	Buka Airport	Buka Island	Papua New Guinea
BRP	Biaru Airport	Biaru	Papua New Guinea
CMU	Chimbu Airport	Kundiawa	Papua New Guinea
MDM	Munduku Airport	Munduku	Papua New Guinea
KPF	Kondobol Airport	Kondobol	Papua New Guinea
DNU	Dinangat Airport	Dinangat	Papua New Guinea
DOI	Doini Airport	Castori Islets	Papua New Guinea
DAU	Daru Airport	Daru	Papua New Guinea
EMS	Embessa Airport	Embessa	Papua New Guinea
XYR	Edwaki Airport	Yellow River Mission	Papua New Guinea
EPT	Eliptamin Airport	Eliptamin	Papua New Guinea
EGA	Engati Airstrip	Engati	Papua New Guinea
EMO	Emo River Airstrip	Emo Mission	Papua New Guinea
ERU	Erume Airport	Erume	Papua New Guinea
MFZ	Meselia Airport	Demgulu	Papua New Guinea
FRQ	Feramin Airport	Feramin	Papua New Guinea
FAQ	Frieda River Airport	Frieda River	Papua New Guinea
FUM	Fuma Airport	Fuma	Papua New Guinea
GKA	Goroka Airport	Goronka	Papua New Guinea
GUG	Guari Airport	Guari	Papua New Guinea
GRL	Garasa Airport	Au	Papua New Guinea
GUR	Gurney Airport	Gurney	Papua New Guinea
GAP	Gusap Airport	Gusap	Papua New Guinea
PNP	Girua Airport	Popondetta	Papua New Guinea
GBC	Gasuke Airport	Gasuke	Papua New Guinea
HBD	Habi Airport	Habi	Papua New Guinea
HNI	Heiweni Airport	Heiweni	Papua New Guinea
HNN	Honinabi Airport	Honinabi	Papua New Guinea
HKN	Hoskins Airport	Kimbe	Papua New Guinea
HIT	Haivaro Airport	Haivaro	Papua New Guinea
IMN	Imane Airport	Imane	Papua New Guinea
KGM	Kungim Airport	Kungim	Papua New Guinea
IMD	Imonda Airport	Imonda	Papua New Guinea
KIE	Aropa Airport	Kieta	Papua New Guinea
IAL	Ialibu Airport	Ialibu	Papua New Guinea
WIU	Witu Airport	Garove Island	Papua New Guinea
KGH	Yongai Airport	Yongai	Papua New Guinea
LSA	Losuia Airport	Losuia	Papua New Guinea
KPA	Kopiago Airport	Kopiago	Papua New Guinea
UNG	Kiunga Airport	Kiunga	Papua New Guinea
KNE	Kanainj Airport	Kanainj	Papua New Guinea
KRI	Kikori Airport	Kikori	Papua New Guinea
KMA	Kerema Airport	Kerema	Papua New Guinea
KRX	Kar Kar Airport	Kar Kar Island	Papua New Guinea
KUQ	Kuri Airport	Kuri	Papua New Guinea
KVG	Kavieng Airport	Kavieng	Papua New Guinea
LNV	Londolovit Airport	Londolovit	Papua New Guinea
LAB	Lab Lab Airport	Lab Lab Mission	Papua New Guinea
LWI	Lowai Airport	Lowai	Papua New Guinea
LPN	Leron Plains Airport	Leron Plains	Papua New Guinea
LNG	Lese Airport	Lese	Papua New Guinea
LSJ	Long Island Airport	Long Island	Papua New Guinea
AYM	Yas Island Seaplane Base	Abu Dhabi	United Arab Emirates
MRM	Manari Airport	Manari	Papua New Guinea
OBM	Morobe Airport	Morobe	Papua New Guinea
MAG	Madang Airport	Madang	Papua New Guinea
HGU	Mount Hagen Kagamuga Airport	Mount Hagen	Papua New Guinea
GUV	Mougulu Airport	Mougulu	Papua New Guinea
MDU	Mendi Airport	Mendi	Papua New Guinea
MAS	Momote Airport	Manus Island	Papua New Guinea
MXH	Moro Airport	Moro	Papua New Guinea
MIS	Misima Island Airport	Misima Island	Papua New Guinea
MWG	Marawaka Airport	Marawaka	Papua New Guinea
NKN	Nankina Airport	Gwarawon	Papua New Guinea
GBF	Negarbo(Negabo) Airport	Negarbo	Papua New Guinea
MFO	Manguna Airport	Manguna	Papua New Guinea
KSB	Kasonombe Airport	Kasonombe	Papua New Guinea
NMN	Nomane Airport	Namane	Papua New Guinea
NBA	Nambaiyufa Airport	Nambaiyufa	Papua New Guinea
LAE	Nadzab Airport	Lae	Papua New Guinea
KGB	Konge Airport	Konge	Papua New Guinea
OKP	Oksapmin Airport	Oksapmin	Papua New Guinea
HOC	Komako Airport	Komako	Papua New Guinea
KCJ	Komaio Airport	Komaio	Papua New Guinea
KDE	Koroba Airport	Koroba	Papua New Guinea
OPB	Open Bay Airport	Maitanakunai	Papua New Guinea
PGB	Pangoa Airport	Pangoa	Papua New Guinea
PGN	Pangia Airport	Pangia	Papua New Guinea
MPF	Mapoda Airport	Mapoda	Papua New Guinea
PMN	Pumani Airport	Pumani	Papua New Guinea
WLU	Walluanda Airport	Puri	Papua New Guinea
POM	Port Moresby Jacksons International Airport	Port Moresby	Papua New Guinea
SPH	Sopu Airport	Sopu	Papua New Guinea
SXA	Sialum Airport	Sialum	Papua New Guinea
RMN	Rumginae Airport		Papua New Guinea
KMR	Karimui Airport	Karimui	Papua New Guinea
MWI	Maramuni Airport	Maramuni	Papua New Guinea
MRH	May River Airstrip	May River	Papua New Guinea
SBE	Suabi Airport		Papua New Guinea
NIS	Simberi Airport	Simberi Island	Papua New Guinea
SIL	Sila Airport	Sila Mission	Papua New Guinea
SBV	Sabah Airport	Sabah	Papua New Guinea
SIM	Simbai Airport	Simbai	Papua New Guinea
SBC	Selbang Airport	Selbang	Papua New Guinea
SPV	Sepik Plains Airport	Sepik Plains	Papua New Guinea
SXW	Sauren Airport	Sauren	Papua New Guinea
MBV	Masa Airport	Masa	Papua New Guinea
TIZ	Tari Airport	Tari	Papua New Guinea
TBG	Tabubil Airport	Tabubil	Papua New Guinea
TPI	Tapini Airport	Tapini	Papua New Guinea
RAB	Tokua Airport	Kokopo	Papua New Guinea
TKW	Tekin Airport	Tekin	Papua New Guinea
TEP	Tep Tep Airport	Teptep	Papua New Guinea
TSW	Tsewi Airport	Tsewi	Papua New Guinea
TRJ	Tarakbits Airport	Tarakbits	Papua New Guinea
TWY	Tawa Airport	Tawa	Papua New Guinea
TKB	Tekadu Airport	Tekadu	Papua New Guinea
AYU	Aiyura Airport	Aiyura Valley	Papua New Guinea
UMC	Umba Airport	Umba	Papua New Guinea
URU	Uroubi Airport	Uroubi	Papua New Guinea
UPR	Upiara Airport	Upiara	Papua New Guinea
UVO	Uvol Airport	Uvol	Papua New Guinea
TLW	Talasea Airport	Talasea	Papua New Guinea
TCJ	Torembi Airport	Torembi	Papua New Guinea
VAI	Vanimo Airport	Vanimo	Papua New Guinea
TON	Tonu Airport	Tonu	Papua New Guinea
WAO	Wabo Airport	Wabo	Papua New Guinea
WBM	Wapenamanda Airport	Wapenamanda	Papua New Guinea
WAJ	Wawoi Falls Airport	Wavoi Falls	Papua New Guinea
WWK	Wewak International Airport	Wewak	Papua New Guinea
WOA	Wonenara Airport	Wonenara	Papua New Guinea
WKN	Wakunai Airport	Wakunai	Papua New Guinea
WSU	Wasu Airport	Wasu	Papua New Guinea
WTP	Woitape Airport	Fatima Mission	Papua New Guinea
WUG	Wau Airport	Wau	Papua New Guinea
YVD	Yeva Airport	Yeva	Papua New Guinea
SMJ	Sim Airport	Sim	Papua New Guinea
WEP	Weam Airport	Weam	Papua New Guinea
AYY	Arugam Bay SPB	Pottuvil	Sri Lanka
KYX	Yalumet Airport	Yalumet	Papua New Guinea
KSX	Yasuru Airport	Yasuru	Papua New Guinea
WUM	Wasum Airport	Wasum	Papua New Guinea
ZXT	Zabrat Airport	Baku	Azerbaijan
FZL	Fuzuli International Airport	Fuzuli	Azerbaijan
HAE	Lava Falls Heliport	Supai Village	United States
AZB	Amazon Bay Airport		Papua New Guinea
AZJ	Zhenjiang Dalu Airport	Zhenjiang	China
BAJ	Bali Airport	Unea Island	Papua New Guinea
BCP	Bambu Airport	Bambu	Papua New Guinea
BCW	Benguera Island Airport	Benguera Island	Mozambique
BCZ	Milyakburra Airport	Bickerton Island	Australia
ILL	Willmar Municipal Airport John L Rice Field (2006)	Willmar	United States
BDZ	Baindoung Airport		Papua New Guinea
HKV	Malevo Airfield	Malevo	Bulgaria
JAM	Bezmer Air Base	Bezmer	Bulgaria
JEG	Aasiaat Airport	Aasiaat	Greenland
AOQ	Aappilattoq Heliport	Aappilattoq	Greenland
AGM	Tasiilaq Heliport	Tasiilaq	Greenland
QUV	Aappilattoq Heliport	Aappilattoq	Greenland
JRK	Arsuk Heliport	Arsuk	Greenland
QUW	Ammassivik Heliport	Ammassivik	Greenland
QGQ	Attu Heliport	Attu	Greenland
UAK	Narsarsuaq Airport	Narsarsuaq	Greenland
JCH	Qasigiannguit Heliport	Qasigiannguit	Greenland
CNP	Neerlerit Inaat Airport	Neerlerit Inaat	Greenland
QFG	Eqalugaarsuit Heliport	Eqalugaarsuit	Greenland
JGR	Kangilinnguit Heliport	Kangilinnguit	Greenland
GOH	Nuuk Airport	Nuuk	Greenland
JGO	Qeqertarsuaq Heliport	Qeqertarsuaq	Greenland
IKE	Ikerasak Heliport	Ikerasak	Greenland
QFI	Iginniarfik Heliport	Iginniarfik	Greenland
QRY	Ikerassaarsuk Heliport	Ikerassaarsuk	Greenland
XIQ	Ilimanaq Heliport	Ilimanaq	Greenland
IUI	Innarsuit Heliport	Innarsuit	Greenland
IOQ	Isortoq Heliport	Isortoq	Greenland
QJI	Ikamiut Heliport	Ikamiut	Greenland
JJU	Qaqortoq Heliport	Qaqortoq	Greenland
JAV	Ilulissat Airport	Ilulissat	Greenland
QPW	Kangaatsiaq Heliport	Kangaatsiaq	Greenland
KUS	Kulusuk Airport	Kulusuk	Greenland
KUZ	Kuummiut Heliport	Kuummiut	Greenland
KHQ	Kullorsuaq Heliport	Kullorsuaq	Greenland
KGQ	Kangersuatsiaq Heliport	Kangersuatsiaq	Greenland
QJE	Kitsissuarsuit Heliport	Kitsissuarsuit	Greenland
IOT	Illorsuit Heliport	Illorsuit	Greenland
JSU	Maniitsoq Airport	Maniitsoq	Greenland
JNN	Nanortalik Heliport	Nanortalik	Greenland
JUU	Nuugaatsiaq Heliport	Nuugaatsiaq	Greenland
JNS	Narsaq Heliport	Narsaq	Greenland
NIQ	Niaqornat Heliport	Niaqornat	Greenland
NSQ	Nuussuaq Heliport	Nuussuaq	Greenland
JFR	Paamiut Airport	Paamiut	Greenland
PQT	Qeqertaq Heliport	Qeqertaq	Greenland
NAQ	Qaanaaq Airport	Qaanaaq	Greenland
QJH	Qassimiut Heliport	Qassimiut	Greenland
OBY	Ittoqqortoormiit Heliport	Ittoqqortoormiit	Greenland
SFJ	Kangerlussuaq Airport	Kangerlussuaq	Greenland
SGG	Sermiligaaq Heliport	Sermiligaaq	Greenland
SRK	Siorapaluk Heliport	Siorapaluk	Greenland
QOQ	Saarloq Heliport	Saarloq	Greenland
JHS	Sisimiut Airport	Sisimiut	Greenland
SAE	Saattut Heliport	Saattut	Greenland
SVR	Savissivik Heliport	Savissivik	Greenland
TQA	Tasiusaq Heliport	Tasiusaq	Greenland
THU	Pituffik Space Base	Pituffik	Greenland
TQI	Tiniteqilaaq Heliport	Tiniteqilaaq	Greenland
XEQ	Tasiusaq Heliport	Tasiusak	Greenland
JUV	Upernavik Airport	Upernavik	Greenland
UMD	Uummannaq Heliport	Uummannaq	Greenland
JQA	Qaarsut Airport	Uummannaq	Greenland
JUK	Ukkusissat Heliport	Ukkusissat	Greenland
BHL	Bahía de los Ángeles Airport	Ensenada	Mexico
BHT	Brighton Downs Airport	Brighton Downs	Australia
AEY	Akureyri Airport	Akureyri	Iceland
BIU	Bildudalur Airport	Bildudalur	Iceland
BGJ	Borgarfjörður eystri Airport	Borgarfjörður eystri	Iceland
BJD	Bakkafjörður Airport	Bakkafjörður	Iceland
BLO	Hjaltabakki Airport	Blönduós	Iceland
BQD	Búðardalur Airport	Búðardalur	Iceland
BXV	Breiðdalsvík Airport	Breiðdalsvík	Iceland
DJU	Djúpivogur Airport	Djúpivogur	Iceland
EGS	Egilsstaðir Airport	Egilsstaðir	Iceland
FAS	Fáskrúðsfjörður Airport	Fáskrúðsfjörður	Iceland
ENS	Twente Airport	Enschede	Netherlands
FAG	Fagurhólsmýri Airport	Fagurhólsmýri	Iceland
GUU	Grundarfjörður Airport	Grundarfjörður	Iceland
GJR	Gjögur Airport	Gjögur	Iceland
GRY	Grímsey Airport	Grímsey	Iceland
HVK	Hólmavík Airport	Hólmavík	Iceland
HFN	Hornafjörður Airport	Höfn	Iceland
FLI	Holt Airport	Flateyri	Iceland
HZK	Húsavík Airport	Húsavík	Iceland
HLO	Ingjaldssanður Airport	Onundarfjörður	Iceland
IFJ	Ísafjörður Airport	Ísafjörður	Iceland
KEF	Keflavik International Airport	Reykjavík	Iceland
OPA	Kópasker Airport	Kópasker	Iceland
SAK	Sauðárkrókur Airport	Sauðárkrókur	Iceland
NOR	Norðfjörður Airport	Norðfjörður	Iceland
OFJ	Ólafsfjörður Airport	Ólafsfjörður	Iceland
PFJ	Patreksfjörður Airport	Patreksfjörður	Iceland
RHA	Reykhólar Airport	Reykhólar	Iceland
OLI	Rif Airport	Rif	Iceland
RFN	Raufarhöfn Airport	Raufarhöfn	Iceland
RKV	Reykjavik Airport	Reykjavik	Iceland
MVA	Reykjahlíð Airport	Myvatn	Iceland
SIJ	Siglufjörður Airport	Siglufjörður	Iceland
SYK	Stykkishólmur Airport	Stykkishólmur	Iceland
TEY	Þingeyri Airport	Þingeyri	Iceland
THO	Þórshöfn Airport	Þórshöfn	Iceland
VEY	Vestmannaeyjar Airport	Vestmannaeyjar	Iceland
VPN	Vopnafjörður Airport	Vopnafjörður	Iceland
BJE	Baleela Airport	Baleela Base Camp	Sudan
BJQ	Bahja Airport	Bahja	Oman
BJT	Bentota River Waterdrome	Bentota	Sri Lanka
PRN	Priština Adem Jashari International Airport	Prishtina	
BMH	Bomai Airport	Bomai	Papua New Guinea
BMQ	Bamburi Airport	Bamburi	Kenya
BMZ	Bamu Airport	Bamu	Papua New Guinea
BNF	Baranof Warm Springs Float and Seaplane Base	Baranof	United States
BNM	Bodinumu Airport	Bodinumu	Papua New Guinea
BNT	Bundi Airport	Bundi	Papua New Guinea
BNV	Boana Airport	Boana	Papua New Guinea
RBQ	Rurrenabaque Airport	Rurrenabaque	Bolivia
BVL	Baures Airport	Baures	Bolivia
BOK	Brookings Airport	Brookings	United States
BOT	Bosset Airport	Bosset	Papua New Guinea
BOV	Boang Airport	Boang Island	Papua New Guinea
BPF	Batuna Aerodrome	Batuna Mission Station	Solomon Islands
BQV	Bartlett Cove Seaplane Base	Gustavus	United States
CJZ	Pedro Vieira Moreira Airport	Cajazeiras	Brazil
VDC	Glauber de Andrade Rocha Airport	Vitória da Conquista	Brazil
ALT	Alenquer Municipal Airport	Alenquer	Brazil
NSB	Bimini North Seaplane Base	Bimini	Bahamas
BSP	Bensbach Airport	Bensbach	Papua New Guinea
BSV	Besakoa Airport	Besakoa	Madagascar
BTZ	Betong International Airport	Betong	Thailand
BUL	Bulolo Airport	Bulolo	Papua New Guinea
BVR	Esperadinha Airport	Brava Island	Cape Verde
HUK	Hukuntsi Airport	Hukuntsi	Botswana
BWJ	Bawan Airport		Papua New Guinea
BWP	Bewani Airport	Bewani	Papua New Guinea
BXL	Blue Lagoon Seaplane Base	Nanuya Lailai Island	Fiji
BXZ	Bunsil Airport	Bunsil - Umboi Island	Papua New Guinea
TXC	Orsha Airport - Balbasovo Air Base	Orsha	Belarus
BYA	Boundary Airport	Boundary	United States
BYL	Bella Yella Airport	Beliyela	Liberia
BYV	Beira Lake Seaplane Base	Colombo	Sri Lanka
BCV	Hector Silva Airstrip	Belmopan	Belize
BGK	Big Creek Airport	Big Creek	Belize
CUK	Caye Caulker Airport	Caye Caulker	Belize
CYC	Caye Chapel Airport	Caye Chapel	Belize
CZH	Corozal Airport	Corozal	Belize
DGA	Dangriga Airport	Dangriga	Belize
INB	Independence Airport	Independence	Belize
MDB	Melinda Airport	Melinda	Belize
ORZ	H.E Alfredo Martinez (Tower Hill) Airstrip	Orange Walk	Belize
PLJ	Placencia Airport	Placencia	Belize
PND	Punta Gorda Airport	Punta Gorda	Belize
SJX	Sartaneja Airport	Sartaneja	Belize
SPR	John Greif II Airport	San Pedro	Belize
SQS	Matthew Spain Airport	Spanish Lookout	Belize
STU	Santa Cruz Airport	Santa Cruz	Belize
SVK	Silver Creek Airport	Silver Creek	Belize
TZA	Sir Barry Bowen Municipal Airport	Belize City	Belize
BZB	Bazaruto Island Airport	Bazaruto Island	Mozambique
BZM	Bemolanga Airport	Bemolanga	Madagascar
PFM	Primrose Airport	Primrose	Canada
YSV	Saglek Airport	Saglek	Canada
YRR	Stuart Island Airstrip	Big Bay	Canada
YMV	Mary River Aerodrome	Mary River	Canada
YHC	Hakai Passage Water Aerodrome	Hecate Island	Canada
YMF	Montague Harbour Seaplane Base	Galiano Island	Canada
PYS	Paradise Skypark Airport	Paradise	United States
YBW	Bedwell Harbour Seaplane Base	Bedwell Harbour	Canada
YTP	Tofino Harbour Seaplane Base	Tofino	Canada
ZNA	Nanaimo Harbour Water Aerodrome	Nanaimo	Canada
YZZ	Trail Regional Airport	Trail	Canada
YMB	Merritt Airport	Merritt	Canada
YHH	Campbell River Seaplane Base	Campbell River	Canada
YWS	Whistler/Green Lake Water Aerodrome	Whistler	Canada
YBF	Bamfield Seaplane Base	Bamfield	Canada
YIG	Big Bay Seaplane Base	Stuart Island	Canada
CJH	Chilko Lake (Tsylos Park Lodge) Airport	Chilko Lake	Canada
YPT	Pender Harbour Seaplane Base	Sunshine Coast	Canada
ZOF	Ocean Falls Seaplane Base	Ocean Falls	Canada
YCA	Courtenay Airpark	Courtenay	Canada
CFQ	Creston Valley Regional Airport - Art Sutcliffe Field	Creston	Canada
YAA	Anahim Lake Airport	Anahim Lake	Canada
EHU	Ezhou Huahu Airport	Ezhou	China
DGF	Douglas Lake Airport	Douglas Lake	Canada
JHL	Fort MacKay/Albian Aerodrome	Albian Village	Canada
ZTS	Tahsis Seaplane Base	Tahsis	Canada
DUQ	Duncan Airport	Duncan	Canada
YHS	Sechelt-Gibsons Airport	Sechelt	Canada
YKK	Kitkatla Seaplane Base	Kitkatla	Canada
ZQS	Queen Charlotte City Seaplane Base		Canada
WPL	Powell Lake Seaplane Base	Powell River	Canada
XQU	Qualicum Beach Airport	Qualicum Beach	Canada
YMP	Port McNeill Airport	Port McNeill	Canada
YRN	Rivers Inlet Seaplane Base	Rivers Inlet	Canada
YTG	Sullivan Bay Seaplane Base	Sullivan Bay	Canada
YMU	Mansons Landing Seaplane Base		Canada
YAV	Mayne Island Seaplane Base	Miners Bay	Canada
YSX	Bella Bella/Shearwater Seaplane Base	Bella Bella	Canada
YGG	Ganges Seaplane Base	Salt Spring Island	Canada
YTB	Hartley Bay Seaplane Base	Hartley Bay	Canada
YZA	Cache Creek-Ashcroft Regional Airport	Cache Creek	Canada
ZEL	Bella Bella (Campbell Island) Airport	Bella Bella	Canada
CBC	Cherrabun Airport		Australia
YPB	Alberni Valley Regional Airport	Port Alberni	Canada
YBO	Bob Quinn Lake Airport	Bob Quinn Lake	Canada
TNS	Tungsten (Cantung) Airport	Tungsten	Canada
TUX	Tumbler Ridge Airport	Tumbler Ridge	Canada
YWM	Williams Harbour Airport	Williams Harbour	Canada
YSO	Postville Airport	Postville	Canada
YBI	Black Tickle Airport	Black Tickle	Canada
YHG	Charlottetown Airport	Charlottetown	Canada
YFX	St. Lewis (Fox Harbour) Airport	St. Lewis	Canada
YHA	Port Hope Simpson Airport	Port Hope Simpson	Canada
YRG	Rigolet Airport	Rigolet	Canada
KGN	Kasongo-Lunda Airport	Kasongo-Lunda	Congo - Kinshasa
PWO	Pweto Airport (New)	Pweto	Congo - Kinshasa
CDK	George T Lewis Airport	Cedar Key	United States
DVK	Diavik Airport	Diavik	Canada
JOJ	Doris Lake	Hope Bay	Canada
ZFW	Fairview Airport	Fairview	Canada
YJP	Jasper-Hinton Airport	Hinton	Canada
YLE	Whatì Airport	Whatì	Canada
YDC	Drayton Valley Industrial Airport	Drayton Valley	Canada
NML	Fort McMurray / Mildred Lake Airport	Fort McMurray	Canada
CFM	Conklin (Leismer) Airport	Conklin	Canada
KWD	Kavadja Airport	Kavadja	Central African Republic
GSL	Taltheilei Narrows Airport	Taltheilei Narrows	Canada
XMP	Macmillan Pass Airport	Macmillan Pass	Canada
DAS	Great Bear Lake Airport	Great Bear Lake	Canada
YFI	Fort Mackay / Firebag	Suncor Energy Site	Canada
YFJ	Wekweètì Airport	Wekweètì	Canada
YOE	Donnelly Airport	Donnelly	Canada
TIL	Cheadle Airport	Cheadle	Canada
OKG	Okoyo Airport	Okoyo	Congo - Brazzaville
CGA	Craig Seaplane Base	Craig	United States
CGC	Cape Gloucester Airport	Cape Gloucester	Papua New Guinea
CGG	Casiguran Airport	Casiguran	Philippines
GHK	Gahcho Kue		Canada
CHP	Circle Hot Springs Airport	Circle Hot Springs	United States
CIV	Chomley Seaplane Base	Chomley	United States
LRQ	Laurie River Airport	Laurie River	Canada
YDJ	Hatchet Lake Airport	Hatchet Lake	Canada
YDU	Kasba Lake Airport	Kasba Lake	Canada
YFL	Fort Reliance Seaplane Base	Fort Reliance	Canada
XCL	Cluff Lake Airport	Cluff Lake	Canada
YKE	Knee Lake Airport	Knee Lake	Canada
SUR	Summer Beaver Airport	Summer Beaver	Canada
CKD	Crooked Creek Airport	Crooked Creek	United States
YTT	Tisdale Airport	Tisdale	Canada
YAX	Wapekeka Airport	Angling Lake	Canada
WNN	Wunnumin Lake Airport	Wunnumin Lake	Canada
YBS	Opapimiskan Lake Airport	Opapimiskan Lake	Canada
YNO	North Spirit Lake Airport	North Spirit Lake	Canada
CKR	Crane Island Airstrip	Crane Island	United States
CKU	Cordova Municipal Airport	Cordova	United States
YDW	North of Sixty Airport	Obre Lake	Canada
CKX	Chicken Airport	Chicken	United States
WCH	Nuevo Chaitén Airport	Chaitén	Chile
CMT	New Cametá Airport	Cametá	Brazil
CMZ	Caia Airport	Caia	Mozambique
TVS	Tangshan Sannühe Airport	Tangshan (Fengrun)	China
YUA	Yuanmou Air Base	Chuxiong (Yuanmou)	China
ZQZ	Zhangjiakou Ningyuan Airport	Zhangjiakou	China
BSD	Baoshan Yunrui Airport	Baoshan (Longyang)	China
DZU	Dazu Air Base	Dazu	China
LNJ	Lincang Boshang Airport	Lincang	China
RKZ	Xigaze Peace Airport / Shigatse Air Base	Xigazê (Samzhubzê)	China
PZI	Panzhihua Bao'anying Airport	Panzhihua (Renhe)	China
ZKL	Zigong Fengming Airport	Zigong (Gongjing)	China
FUO	Foshan Shadi Airport	Foshan (Nanhai)	China
BZX	Bazhong Enyang Airport	Bazhong (Enyang)	China
XAI	Xinyang Minggang Airport	Xinyang	China
HUZ	Huizhou Pingtan Airport	Huizhou (Pingtan)	China
DFA	Shangluo Airport	Shangluo (Danfeng)	China
HSC	Shaoguan Danxia Airport	Shaoguan	China
JGS	Jinggangshan Airport	Ji'an	China
AEB	Baise (Bose) Bama Airport	Baise (Tianyang)	China
LYG	Lianyungang Huaguoshan International Airport	Lianyungang	China
DOY	Dongying Shengli Airport	Dongying (Kenli)	China
XEN	Xingcheng Air Base	Huludao (Xingcheng)	China
AAT	Altay Xuedu Airport	Altay	China
THQ	Tianshui Maijishan Airport	Tianshui (Maiji)	China
YZY	Zhangye Ganzhou Airport	Zhangye (Ganzhou)	China
DWS	Morin Dawa Banner Airport	Hulunbuir	China
LCT	Shijiazhuang Luancheng Airport	Shijiazhuang	China
WHN	Wuhan Hannan Municipal Airport	Wuhan (Hannan)	China
NAY	Beijing Nanjiao Airport	Beijing	China
DDG	Dandong Langtou Airport	Dandong (Zhenxing)	China
PFA	Harbin Pingfang Airport	Harbin	China
PNJ	Penglai Shahekou Airport	Yantai	China
CBZ	Binzhou Daguo Airport	Binzhou	China
DDR	Rikaze Dingri Airport	Xigazê (Dingri)	China
HQL	Tashikuergan Hongqilafu Airport	Tashikuergan	China
JDE	Jiande Qiandaohu General Airport	Hangzhou	China
HLJ	Zhaodong Beidahuang General Airport	Suihua	China
TYC	Taiyuan Yaocheng Airport	Taiyuan	China
WRH	Orku Baikouquan Airport (under construction)	Urhu	China
JRJ	Ruijin Airport	Ruijin	China
ZHA	Zhanjiang Wuchuan Airport	Zhanjiang	China
APJ	Ali Pulan Airport	Burang Town	China
ZFL	Zhaosu Tianma Airport	Zhaosu	China
YEH	Yinchuan Yueyahu Airport	Yinchuan	China
LCS	Longchuan Guangsong Airport	Dehong (Longchuan)	China
LFH	Lanping Fenghua General Airport	Lanping Bai	China
ZGN	Zhongshan Ferry Port	Zhongshan	China
BZJ	Bozhou Airport (under construction)	Bozhou	China
BKV	Bailing Airport	Bailingmiao	China
HJB	Hejing Bayinbuluke Airport	Hejing	China
OTQ	Otog Front Banner Oljoq Airport	Otog Front Banner	China
JBK	Qitai Jiangbulake Airport	Qitai	China
LIJ	Lishui Airport (under construction)	Lishui	China
YHJ	Nanchang Yaohu Airport	Nanchang	China
OTO	Otog Banner Wulan Airport	Wulan	China
NTG	Nantong Xingdong International Airport	Nantong (Tongzhou)	China
XBE	Bearskin Lake Airport	Bearskin Lake	Canada
YNP	Natuashish Airport	Natuashish	Canada
YWR	White River Seaplane Base	White River	Canada
YPD	Parry Sound Area Municipal Airport	Parry Sound	Canada
XBR	Brockville - Thousand Islands Regional Tackaberry Airport	Brockville	Canada
KIF	Kingfisher Lake Airport	Kingfisher Lake	Canada
YOG	Ogoki Post Airport	Ogoki Post	Canada
LCR	Virgilio Barco Vargas (La Chorrera) Airport	La Chorrera	Colombia
SNT	Las Cruces Airport	Sabana de Torres	Colombia
TCD	Tarapacá Airport	Tarapacá	Colombia
YEB	Bar River Airport	Echo Bay	Canada
CPI	Cape Orford Airport		Papua New Guinea
YSI	Parry Sound/Frying Pan Island-Sans Souci Seaplane Base	Frying Pan Island	Canada
YHP	Poplar Hill Airport	Poplar Hill	Canada
KEW	Keewaywin Airport	Keewaywin	Canada
ACO	Cóbano Airport	Cóbano	Costa Rica
XVQ	Reef Hueston Helicopter Landing	Streatham	Canada
KFM	Kirby Lake Airport	Kirby Lake	Canada
YSA	Sable Island Landing Strip	Sable Island	Canada
YLS	Lebel-sur-Quevillon Airport	Lebel-sur-Quévillon	Canada
YNX	Snap Lake Airport	Snap Lake Mine	Canada
SSQ	La Sarre Airport	La Sarre	Canada
YKU	Chisasibi Airport	Chisasibi	Canada
ZTB	Tête-à-la-Baleine Airport	Tête-à-la-Baleine	Canada
ZKG	Kégashka Airport	Côte-Nord-du-Golfe-du-Saint-Laurent	Canada
YWQ	Chute-Des-Passes/Lac Margane Seaplane Base	Chutes-des-Passes	Canada
CTP	Carutapera Airport	Carutapera	Brazil
YAU	Donaldson Airport	Kattiniq	Canada
ZGS	La Romaine Airport	Le Golfe-du-Saint-Laurent	Canada
YFG	Fontanges Airport	Fontanges	Canada
ZLT	La Tabatière Airport	La Tabatière	Canada
CUJ	Culion Airport	Culion	Philippines
HLI	Hollister Municipal Airport	Hollister	United States
CVL	Cape Vogel Airport		Papua New Guinea
CXC	Chitina Airport	Chitina	United States
GEC	Lefkoniko Airport / Geçitkale Air Base	Lefkoniko (Geçitkale)	Cyprus
YAB	Arctic Bay Airport	Arctic Bay	Canada
YAC	Cat Lake Airport	Cat Lake	Canada
YAR	La Grande-3 Airport	La Grande-3	Canada
YAG	Fort Frances Municipal Airport	Fort Frances	Canada
YAH	La Grande-4 Airport	La Grande-4	Canada
YAL	Alert Bay Airport	Alert Bay	Canada
YAM	Sault Ste Marie Airport	Sault Ste Marie	Canada
XKS	Kasabonika Airport	Kasabonika	Canada
YKG	Kangirsuk Airport	Kangirsuk	Canada
YAT	Attawapiskat Airport	Attawapiskat	Canada
YAY	St. Anthony Airport	St. Anthony	Canada
YAZ	Tofino / Long Beach Airport	Tofino	Canada
YBA	Banff Airport	Banff	Canada
YBB	Kugaaruk Airport	Kugaaruk	Canada
YBC	Baie-Comeau Airport	Baie-Comeau	Canada
QBC	Bella Coola Airport	Bella Coola	Canada
YBE	Uranium City Airport	Uranium City	Canada
YBY	Bonnyville Airport	Bonnyville	Canada
YBG	CFB Bagotville / Saguenay-Bagotville Airport	La Baie	Canada
YBK	Baker Lake Airport	Baker Lake	Canada
YBL	Campbell River Airport	Campbell River	Canada
XTL	Tadoule Lake Airport	Tadoule Lake	Canada
YBR	Brandon Municipal Airport	Brandon	Canada
YBT	Brochet Airport	Brochet	Canada
YBV	Berens River Airport	Berens River	Canada
YBX	Lourdes-de-Blanc-Sablon Airport	Blanc-Sablon	Canada
YRF	Cartwright Airport	Cartwright	Canada
YCB	Cambridge Bay Airport	Cambridge Bay	Canada
YCC	Cornwall Regional Airport	Cornwall	Canada
YCD	Nanaimo Airport	Nanaimo	Canada
YCE	Centralia / James T. Field Memorial Aerodrome	Huron Park	Canada
YCG	Castlegar/West Kootenay Regional Airport	Castlegar	Canada
YCH	Miramichi Airport	Miramichi	Canada
XCM	Chatham Kent Airport	Chatham-Kent	Canada
YCL	Charlo Airport	Charlo	Canada
YCN	Cochrane Airport	Cochrane	Canada
YCO	Kugluktuk Airport	Kugluktuk	Canada
YCQ	Chetwynd Airport	Chetwynd	Canada
YCR	Cross Lake (Charlie Sinclair Memorial) Airport	Cross Lake	Canada
YCS	Chesterfield Inlet Airport	Chesterfield Inlet	Canada
YCT	Coronation Airport	Coronation	Canada
YCW	Chilliwack Airport	Chilliwack	Canada
YCY	Clyde River Airport	Clyde River	Canada
YCZ	Fairmont Hot Springs Airport	Fairmont Hot Springs	Canada
YDA	Dawson City Airport	Dawson City	Canada
YDB	Burwash Airport	Burwash Landing	Canada
YDF	Deer Lake Airport	Deer Lake	Canada
YDL	Dease Lake Airport	Dease Lake	Canada
XRR	Ross River Airport	Ross River	Canada
YDN	Dauphin Barker Airport	Dauphin	Canada
YDO	Dolbeau-Saint-Felicien Airport	Dolbeau-Saint-Felicien	Canada
YDP	Nain Airport	Nain	Canada
YDQ	Dawson Creek Airport	Dawson Creek	Canada
YEG	Edmonton International Airport	Edmonton	Canada
YEK	Arviat Airport	Arviat	Canada
YEL	Elliot Lake Municipal Airport	Elliot Lake	Canada
YEM	Manitoulin East Municipal Airport	Sheguiandah	Canada
YEN	Estevan Airport	Estevan	Canada
YER	Fort Severn Airport	Fort Severn	Canada
YET	Edson Airport	Edson	Canada
YEU	Eureka Airport	Eureka	Canada
YEV	Inuvik Mike Zubko Airport	Inuvik	Canada
YEY	Amos/Magny Airport	Amos	Canada
YFA	Fort Albany Airport	Fort Albany	Canada
YFB	Iqaluit Airport	Iqaluit	Canada
YFC	Fredericton Airport	Fredericton	Canada
YFE	Forestville Airport	Forestville	Canada
YFH	Fort Hope Airport	Fort Hope	Canada
YTM	Mont-Tremblant International Airport	La Macaza	Canada
YFO	Flin Flon Airport	Flin Flon	Canada
YFR	Fort Resolution Airport	Fort Resolution	Canada
YFS	Fort Simpson Airport	Fort Simpson	Canada
YMN	Makkovik Airport	Makkovik	Canada
YGB	Texada Gillies Bay Airport	Texada	Canada
YGH	Fort Good Hope Airport	Fort Good Hope	Canada
YGK	Kingston Norman Rogers Airport	Kingston	Canada
YGL	La Grande Rivière Airport	La Grande Rivière	Canada
YGM	Gimli Industrial Park Airport	Gimli	Canada
YGO	Gods Lake Narrows Airport	Gods Lake Narrows	Canada
YGP	Michel-Pouliot Gaspé Airport	Gaspé	Canada
YGQ	Geraldton Greenstone Regional Airport	Geraldton	Canada
YGR	Îles-de-la-Madeleine Airport	Les Îles-de-la-Madeleine	Canada
YGT	Igloolik Airport	Igloolik	Canada
YGV	Havre-Saint-Pierre Airport	Havre-Saint-Pierre	Canada
YGW	Kuujjuarapik Airport	Kuujjuarapik	Canada
YGX	Gillam Airport	Gillam	Canada
YGZ	Grise Fiord Airport	Grise Fiord	Canada
YQC	Quaqtaq Airport	Quaqtaq	Canada
YHB	Hudson Bay Airport	Hudson Bay	Canada
CXH	Vancouver Harbour Water Aerodrome	Vancouver	Canada
YHD	Dryden Regional Airport	Dryden	Canada
YHE	Hope Airport / FVRD Regional Airpark	Hope	Canada
YHF	Hearst René Fontaine Municipal Airport	Hearst	Canada
YNS	Nemiscau Airport	Nemiscau	Canada
YHI	Ulukhaktok Holman Airport	Ulukhaktok	Canada
YHK	Gjoa Haven Airport	Gjoa Haven	Canada
YHM	John C. Munro Hamilton International Airport	Hamilton	Canada
YHN	Hornepayne Municipal Airport	Hornepayne	Canada
YHO	Hopedale Airport	Hopedale	Canada
YHR	Chevery Airport	Chevery	Canada
YHT	Haines Junction Airport	Haines Junction	Canada
YHU	Montréal / Saint-Hubert Airport	Montréal	Canada
YHY	Hay River / Merlyn Carter Airport	Hay River	Canada
YHZ	Halifax / Stanfield International Airport	Halifax	Canada
YIB	Atikokan Municipal Airport	Atikokan	Canada
YDG	Digby / Annapolis Regional Airport	Digby	Canada
YIF	St Augustin Airport	St-Augustin	Canada
YIK	Ivujivik Airport	Ivujivik	Canada
YIO	Pond Inlet Airport	Pond Inlet	Canada
YIV	Island Lake Airport	Island Lake	Canada
YJA	Jasper Airport	Jasper	Canada
YJF	Fort Liard Airport	Fort Liard	Canada
YJN	St Jean Airport	St Jean	Canada
YJT	Dymond Airport	Stephenville	Canada
YKA	Kamloops John Moose Fulton Field Regional Airport	Kamloops	Canada
YKC	Collins Bay Airport	Collins Bay	Canada
LAK	Aklavik/Freddie Carmichael Airport	Aklavik	Canada
YKF	Region of Waterloo International Airport	Breslau	Canada
YWB	Kangiqsujuaq (Wakeham Bay) Airport	Kangiqsujuaq	Canada
YKJ	Key Lake Airport	Key Lake	Canada
YKL	Schefferville Airport	Schefferville	Canada
YKD	Kincardine Municipal Airport	Kincardine	Canada
AKV	Akulivik Airport	Akulivik	Canada
YKQ	Waskaganish Airport	Waskaganish	Canada
YKX	Kirkland Lake Airport	Kirkland Lake	Canada
YKY	Kindersley Airport	Kindersley	Canada
YPJ	Aupaluk Airport	Aupaluk	Canada
YLB	Lac La Biche Airport	Lac La Biche	Canada
YLC	Kimmirut Airport	Kimmirut	Canada
YLD	Chapleau Airport	Chapleau	Canada
YLH	Lansdowne House Airport	Lansdowne House	Canada
YLJ	Meadow Lake Airport	Meadow Lake	Canada
YSG	Lutselk'e Airport	Lutselk'e	Canada
YLL	Lloydminster Airport	Lloydminster	Canada
YLQ	La Tuque Airport	La Tuque	Canada
YLR	Leaf Rapids Airport	Leaf Rapids	Canada
YLK	Barrie-Lake Simcoe Regional Airport	Barrie	Canada
YLT	Alert Airport	Alert	Canada
XGR	Kangiqsualujjuaq (Georges River) Airport	Kangiqsualujjuaq	Canada
YLW	Kelowna International Airport	Kelowna	Canada
CYM	Chatham Seaplane Base	Chatham	United States
YMA	Mayo Airport	Mayo	Canada
YME	Matane Airport	Matane	Canada
YMG	Manitouwadge Airport	Manitouwadge	Canada
YMH	Mary's Harbour Airport	Mary's Harbour	Canada
YMJ	Moose Jaw Air Vice Marshal C. M. McEwen Airport	Moose Jaw	Canada
YML	Charlevoix Airport	Charlevoix	Canada
YMM	Fort McMurray Airport	Fort McMurray	Canada
YMO	Moosonee Airport	Moosonee	Canada
YMT	Chapais Airport	Chibougamau	Canada
YUD	Umiujaq Airport	Umiujaq	Canada
YMW	Maniwaki Airport	Messines	Canada
YMX	Montreal International (Mirabel) Airport	Montréal	Canada
YNA	Natashquan Airport	Natashquan	Canada
YNC	Wemindji Airport	Wemindji	Canada
YND	Ottawa / Gatineau Airport	Gatineau	Canada
YNE	Norway House Airport	Norway House	Canada
YNH	Hudson's Hope Airport	Hudson's Hope	Canada
YLY	Langley Airport	Langley	Canada
YNL	Points North Landing Airport	Points North Landing	Canada
YNM	Matagami Airport	Matagami	Canada
HZP	Fort Mackay / Horizon Airport	Fort Mackay	Canada
YOA	Ekati Airport	Ekati	Canada
YOC	Old Crow Airport	Old Crow	Canada
YOD	CFB Cold Lake	Cold Lake	Canada
YOH	Oxford House Airport	Oxford House	Canada
YOJ	High Level Airport	High Level	Canada
YOO	Oshawa Executive Airport	Oshawa	Canada
YOP	Rainbow Lake Airport	Rainbow Lake	Canada
YOS	Owen Sound / Billy Bishop Regional Airport	Owen Sound	Canada
YOW	Ottawa Macdonald-Cartier International Airport	Ottawa	Canada
YPA	Prince Albert Glass Field	Prince Albert	Canada
YPC	Paulatuk (Nora Aliqatchialuk Ruben) Airport	Paulatuk	Canada
YPS	Port Hawkesbury Airport	Port Hawkesbury	Canada
YPE	Peace River Airport	Peace River	Canada
YPG	Portage-la-Prairie / Southport Airport	Portage la Prairie	Canada
YPH	Inukjuak Airport	Inukjuak	Canada
YPL	Pickle Lake Airport	Pickle Lake	Canada
YPM	Pikangikum Airport	Pikangikum	Canada
YPN	Port-Menier Airport	Port-Menier	Canada
YPO	Peawanuck Airport	Peawanuck	Canada
YPQ	Peterborough Municipal Airport	Peterborough	Canada
YPR	Prince Rupert Airport	Prince Rupert	Canada
YPW	Powell River Airport	Powell River	Canada
YPX	Puvirnituq Airport	Puvirnituq	Canada
YPY	Fort Chipewyan Airport	Fort Chipewyan	Canada
YPZ	Burns Lake Airport	Burns Lake	Canada
YQA	Muskoka Airport	Gravenhurst	Canada
YQB	Quebec Jean Lesage International Airport	Quebec	Canada
YQD	The Pas Airport	The Pas	Canada
YQF	Red Deer Regional Airport	Springbrook	Canada
YQG	Windsor Airport	Windsor	Canada
YQH	Watson Lake Airport	Watson Lake	Canada
YQI	Yarmouth Airport	Yarmouth	Canada
YQK	Kenora Airport	Kenora	Canada
YQL	Lethbridge County Airport	Lethbridge	Canada
YQM	Greater Moncton Roméo LeBlanc International Airport	Moncton	Canada
YQN	Nakina Airport	Nakina	Canada
YQQ	Comox Valley Airport / CFB Comox	Comox	Canada
YQR	Regina International Airport	Regina	Canada
YQS	St Thomas Municipal Airport	St Thomas	Canada
YQT	Thunder Bay Airport	Thunder Bay	Canada
YQU	Grande Prairie Airport	Grande Prairie	Canada
YQV	Yorkton Municipal Airport	Yorkton	Canada
YQW	North Battleford Airport	North Battleford	Canada
YQX	Gander International Airport / CFB Gander	Gander	Canada
YQY	Sydney / J.A. Douglas McCurdy Airport	Sydney	Canada
YQZ	Quesnel Airport	Quesnel	Canada
YRA	Rae Lakes Airport	Gamètì	Canada
YRB	Resolute Bay Airport	Resolute Bay	Canada
YRI	Rivière-du-Loup Airport	Rivière-du-Loup	Canada
YRJ	Roberval Airport	Roberval	Canada
YRL	Red Lake Airport	Red Lake	Canada
YRM	Rocky Mountain House Airport	Rocky Mountain House	Canada
YRO	Ottawa / Rockcliffe Airport	Ottawa	Canada
YRQ	Trois-Rivières Airport	Trois-Rivières	Canada
YRS	Red Sucker Lake Airport	Red Sucker Lake	Canada
YRT	Rankin Inlet Airport	Rankin Inlet	Canada
YRV	Revelstoke Airport	Revelstoke	Canada
YSB	Sudbury Airport	Sudbury	Canada
YSC	Sherbrooke Airport	Sherbrooke	Canada
YSD	Canadian Forces Base Suffield Heliport	Ralston	Canada
YSE	Squamish Airport	Squamish	Canada
YSF	Stony Rapids Airport	Stony Rapids	Canada
YSH	Smiths Falls-Montague (Russ Beach) Airport	Smiths Falls	Canada
YSJ	Saint John Airport	Saint John	Canada
YSK	Sanikiluaq Airport	Sanikiluaq	Canada
YSL	Saint-Léonard Airport	Saint-Léonard	Canada
YSM	Fort Smith Airport	Fort Smith	Canada
YCM	Niagara District Airport	Niagara-on-the-Lake	Canada
YSP	Marathon Airport	Marathon	Canada
YST	St. Theresa Point Airport	St. Theresa Point	Canada
YSU	Summerside Airport	Slemon Park	Canada
YSY	Sachs Harbour (David Nasogaluak Jr. Saaryuaq) Airport	Sachs Harbour	Canada
YTA	Pembroke Airport	Pembroke	Canada
YTE	Cape Dorset Airport	Kinngait	Canada
YTF	Alma Airport	Alma	Canada
YTH	Thompson Airport	Thompson	Canada
YTL	Big Trout Lake Airport	Big Trout Lake	Canada
YTQ	Tasiujaq Airport	Tasiujaq	Canada
YTR	CFB Trenton	Trenton	Canada
YTS	Timmins/Victor M. Power	Timmins	Canada
YTZ	Billy Bishop Toronto City Centre Airport	Toronto	Canada
YUB	Tuktoyaktuk / James Gruben Airport	Tuktoyaktuk	Canada
YUL	Montreal / Pierre Elliott Trudeau International Airport	Montréal	Canada
YUT	Naujaat Airport	Repulse Bay	Canada
YUX	Hall Beach Airport	Sanirajak	Canada
YUY	Rouyn Noranda Airport	Rouyn-Noranda	Canada
YVB	Bonaventure Airport	Bonaventure	Canada
YVC	La Ronge Airport	La Ronge	Canada
YVG	Vermilion Airport	Vermilion	Canada
YVE	Vernon Regional Airport	Vernon	Canada
YCK	Tommy Kochon Airport	Colville Lake	Canada
YVM	Qikiqtarjuaq Airport	Qikiqtarjuaq	Canada
YVO	Val-d'Or Airport	Val-d'Or	Canada
YVP	Kuujjuaq Airport	Kuujjuaq	Canada
YVQ	Norman Wells Airport	Norman Wells	Canada
YVR	Vancouver International Airport	Vancouver	Canada
YVT	Buffalo Narrows Airport	Buffalo Narrows	Canada
YVV	Wiarton Airport	Wiarton	Canada
YVZ	Deer Lake Airport	Deer Lake	Canada
YWA	Petawawa Airport	Petawawa	Canada
YWG	Winnipeg / James Armstrong Richardson International Airport	Winnipeg	Canada
YWH	Victoria Harbour Seaplane Base	Victoria	Canada
YWJ	Déline Airport	Déline	Canada
YWK	Wabush Airport	Wabush	Canada
YWL	Williams Lake Airport	Williams Lake	Canada
YWP	Webequie Airport	Webequie	Canada
YWY	Wrigley Airport	Wrigley	Canada
YXC	Cranbrook/Canadian Rockies International Airport	Cranbrook	Canada
YXE	Saskatoon John G. Diefenbaker International Airport	Saskatoon	Canada
YXH	Medicine Hat Regional Airport	Medicine Hat	Canada
YXJ	Fort St John / North Peace Regional Airport	Fort Saint John	Canada
YXK	Rimouski Airport	Rimouski	Canada
YXL	Sioux Lookout Airport	Sioux Lookout	Canada
YXN	Whale Cove Airport	Whale Cove	Canada
YXP	Pangnirtung Airport	Pangnirtung	Canada
YXQ	Beaver Creek Airport	Beaver Creek	Canada
YXR	Earlton (Timiskaming Regional) Airport	Earlton	Canada
YXS	Prince George Airport	Prince George	Canada
YXT	Northwest Regional Airport Terrace-Kitimat	Terrace	Canada
YXU	London Airport	London	Canada
YXX	Abbotsford International Airport	Abbotsford	Canada
YXY	Whitehorse / Erik Nielsen International Airport	Whitehorse	Canada
YXZ	Wawa Airport	Wawa	Canada
YYB	North Bay Jack Garland Airport	North Bay	Canada
YYC	Calgary International Airport	Calgary	Canada
YYD	Smithers Airport	Smithers	Canada
YYE	Fort Nelson Airport	Fort Nelson	Canada
YYF	Penticton Airport	Penticton	Canada
YYG	Charlottetown Airport	Charlottetown	Canada
YYH	Taloyoak Airport	Taloyoak	Canada
YYJ	Victoria International Airport	Victoria	Canada
YYL	Lynn Lake Airport	Lynn Lake	Canada
YYM	Cowley Airport	Cowley	Canada
YYN	Swift Current Airport	Swift Current	Canada
YYQ	Churchill Airport	Churchill	Canada
YYR	Goose Bay Airport	Goose Bay	Canada
YYT	St. John's International Airport	St. John's	Canada
YYU	Kapuskasing Airport	Kapuskasing	Canada
YYW	Armstrong Airport	Armstrong	Canada
YYY	Mont Joli Airport	Mont-Joli	Canada
YYZ	Toronto Lester B. Pearson International Airport	Toronto	Canada
YZE	Gore Bay Manitoulin Airport	Gore Bay	Canada
YZF	Yellowknife International Airport	Yellowknife	Canada
YZG	Salluit Airport	Salluit	Canada
YZH	Slave Lake Airport	Slave Lake	Canada
YZP	Sandspit Airport	Sandspit	Canada
YZR	Chris Hadfield Airport	Sarnia	Canada
YZS	Coral Harbour Airport	Coral Harbour	Canada
YZT	Port Hardy Airport	Port Hardy	Canada
YZU	Whitecourt Airport	Whitecourt	Canada
YZV	Sept-Îles Airport	Sept-Îles	Canada
YZW	Teslin Airport	Teslin	Canada
YZX	CFB Greenwood	Greenwood	Canada
ZAC	York Landing Airport	York Landing	Canada
YSN	Shuswap Regional Airport	Salmon Arm	Canada
YDT	Boundary Bay Airport	Delta	Canada
ILF	Ilford Airport	Ilford	Canada
ZBF	Bathurst Airport	South Tetagouche	Canada
ZBM	Bromont (Roland Désourdy) Airport	Bromont	Canada
KES	Kelsey Airport	Kelsey	Canada
ZEM	Eastmain River Airport	Eastmain River	Canada
ZFA	Faro Airport	Faro	Canada
ZFD	Fond-du-Lac Airport	Fond-du-Lac	Canada
XPK	Pukatawagan Airport	Pukatawagan	Canada
ZFM	Fort Mcpherson Airport	Fort Mcpherson	Canada
ZFN	Tulita Airport	Tulita	Canada
ZGF	Grand Forks Airport	Grand Forks	Canada
ZGI	Gods River Airport	Gods River	Canada
ZGR	Little Grand Rapids Airport	Little Grand Rapids	Canada
ZHP	High Prairie Airport	High Prairie	Canada
CZJ	Corazón de Jesús Airport	Tupile	Panama
ZJG	Jenpeg Airport	Jenpeg	Canada
ZJN	Swan River Airport	Swan River	Canada
CZK	Cascade Locks State Airport	Cascade Locks	United States
ZKE	Kashechewan Airport	Kashechewan	Canada
YTD	Thicket Portage Airport	Thicket Portage	Canada
MSA	Muskrat Dam Airport	Muskrat Dam	Canada
ZMH	South Cariboo Region / 108 Mile Airport	108 Mile	Canada
PIW	Pikwitonei Airport	Pikwitonei	Canada
ZMT	Masset Airport	Masset	Canada
CZN	Chisana Airport	Chisana	United States
XPP	Poplar River Airport	Poplar River	Canada
CZO	Chistochina Airport	Chistochina	United States
ZPB	Sachigo Lake Airport	Sachigo Lake	Canada
WPC	Pincher Creek Airport	Pincher Creek	Canada
ZPO	Pinehouse Lake Airport	Pinehouse Lake	Canada
ZRJ	Round Lake (Weagamow Lake) Airport	Round Lake	Canada
ZSJ	Sandy Lake Airport	Sandy Lake	Canada
XSI	South Indian Lake Airport	South Indian Lake	Canada
ZST	Stewart Airport	Stewart	Canada
ZSW	Prince Rupert/Seal Cove Seaplane Base	Prince Rupert	Canada
UDE	Volkel Air Base	Uden	Netherlands
YDV	Bloodvein River Airport	Bloodvein River	Canada
ZTM	Shamattawa Airport	Shamattawa	Canada
ZUC	Ignace Municipal Airport	Ignace	Canada
ZUM	Churchill Falls Airport	Churchill Falls	Canada
XLB	Lac Brochet Airport	Lac Brochet	Canada
ZWL	Wollaston Lake Airport	Wollaston Lake	Canada
IUA	Canandaigua Airport	Ontario County IDA	United States
DJN	Delta Junction Airport	Delta Junction	United States
MQV	Mostaganem Airport	Sayada	Algeria
QLD	Blida Airport	Blida	Algeria
BUJ	Bou Saada Airport	Ouled Sidi Brahim	Algeria
BJA	Soummam–Abane Ramdane Airport	Béjaïa	Algeria
ALG	Houari Boumediene Airport	Algiers	Algeria
DJG	Djanet Inedbirene Airport	Djanet	Algeria
VVZ	Illizi Takhamalt Airport	Illizi	Algeria
QSF	Ain Arnat Airport	Sétif	Algeria
TMR	Aguenar – Hadj Bey Akhamok Airport	Tamanrasset	Algeria
GJL	Jijel Ferhat Abbas Airport	Tahir	Algeria
MZW	Mecheria Airport	Mecheria	Algeria
AAE	Annaba Rabah Bitat Airport	Annaba	Algeria
CZL	Mohamed Boudiaf International Airport	Constantine	Algeria
QMH	Oum El Bouaghi Air Base	Oum El Bouaghi	Algeria
TEE	Cheikh Larbi Tébessi Airport	Tébessi	Algeria
BLJ	Batna Mostefa Ben Boulaid Airport	Batna	Algeria
DAF	Daup Airport		Papua New Guinea
HRM	Hassi R'Mel Airport	Hassi R'Mel	Algeria
QDJ	Tsletsi Airport	Djelfa	Algeria
DAH	Dathina Airport	Dathina	Yemen
DAO	Dabo Airport		Papua New Guinea
TID	Abdelhafid Boussouf Bou Chekif Airport	Tiaret	Algeria
TIN	Tindouf Airport	Tindouf	Algeria
CFK	Chlef Aboubakr Belkaid International Airport	Chlef	Algeria
TAF	Oran Tafraoui Airport	Tafraoui	Algeria
TLM	Zenata – Messali El Hadj Airport	Zenata	Algeria
ORN	Oran Es-Sénia (Ahmed Ben Bella) International Airport	Es-Sénia	Algeria
CBH	Béchar Boudghene Ben Ali Lotfi Airport	Béchar	Algeria
BFW	Sidi Bel Abbes Airport	Sidi Bel Abbès	Algeria
MUW	Ghriss Airport	Ghriss	Algeria
EBH	El Bayadh Airport	El Bayadh	Algeria
INF	In Guezzam Airport	In Guezzam	Algeria
BMW	Bordj Badji Mokhtar Airport	Bordj Badji Mokhtar	Algeria
AZR	Touat Cheikh Sidi Mohamed Belkebir Airport	Adrar	Algeria
BSK	Biskra - Mohamed Khider Airport	Biskra	Algeria
ELG	El Golea Airport	El Menia	Algeria
GHA	Noumérat - Moufdi Zakaria Airport	El Atteuf	Algeria
HME	Hassi Messaoud-Oued Irara Krim Belkacem Airport	Hassi Messaoud	Algeria
INZ	In Salah Airport	In Salah	Algeria
TGR	Touggourt Sidi Madhi Airport	Touggourt	Algeria
LOO	Laghouat - Molay Ahmed Medeghri Airport	Laghouat	Algeria
ELU	Guemar Airport	Guemar	Algeria
TMX	Timimoun Airport	Timimoun	Algeria
OGX	Ain Beida Airport	Ouargla	Algeria
IAM	Zarzaitine - In Aménas Airport	In Aménas	Algeria
COO	Cadjehoun Airport	Cotonou	Benin
DJA	Djougou Airport	Djougou	Benin
KDC	Kandi Airport	Kandi	Benin
NAE	Natitingou Airport	Natitingou	Benin
PKO	Parakou Airport	Parakou	Benin
SVF	Savé Airport	Savé	Benin
DBC	Baicheng Chang'an Airport	Baicheng	China
DBK	Dutch Bay SPB	Kalpitiya Island	Sri Lanka
DBP	Debepare Airport	Debepare	Papua New Guinea
DBU	Dambulu Oya Tank Seaplane Base	Dambulla	Sri Lanka
DCG	Dubai Creek SPB	Dubai	United Arab Emirates
DCK	Dahl Creek Airport	Dahl Creek	United States
DDM	Dodoima Airport		Papua New Guinea
DEQ	Deqing Moganshan Airport	Huzhou	China
DER	Derim Airport	Derim	Papua New Guinea
DEX	Nop Goliat Dekai Airport	Dekai	Indonesia
XKY	Kaya Airport	Kaya	Burkina Faso
OUG	Ouahigouya Airport	Ouahigouya	Burkina Faso
XDJ	Djibo Airport	Djibo	Burkina Faso
XLU	Leo Airport	Leo	Burkina Faso
PUP	Po Airport	Po	Burkina Faso
XBO	Boulsa Airport	Boulsa	Burkina Faso
XBG	Bogande Airport	Bogande	Burkina Faso
DIP	Diapaga Airport	Diapaga	Burkina Faso
DOR	Dori Airport	Dori	Burkina Faso
FNG	Fada N'gourma Airport	Fada N'gourma	Burkina Faso
XGG	Gorom-Gorom Airport	Gorom-Gorom	Burkina Faso
XKA	Kantchari Airport	Kantchari	Burkina Faso
TMQ	Tambao Airport	Tambao	Burkina Faso
XPA	Pama Airport	Pama	Burkina Faso
ARL	Arly Airport	Arly	Burkina Faso
XSE	Sebba Airport	Sebba	Burkina Faso
TEG	Tenkodogo Airport	Tenkodogo	Burkina Faso
XZA	Zabré Airport	Zabré	Burkina Faso
OUA	Ouagadougou Airport	Ouagadougou	Burkina Faso
BNR	Banfora Airport	Banfora	Burkina Faso
DGU	Dedougou Airport	Dedougou	Burkina Faso
XGA	Gaoua Airport	Gaoua	Burkina Faso
XNU	Nouna Airport	Nouna	Burkina Faso
BOY	Bobo Dioulasso Airport	Bobo Dioulasso	Burkina Faso
TUQ	Tougan Airport	Tougan	Burkina Faso
XDE	Diebougou Airport	Diebougou	Burkina Faso
XAR	Aribinda Airport	Aribinda	Burkina Faso
ACC	Kotoka International Airport	Accra	Ghana
TML	Tamale Airport	Tamale	Ghana
WZA	Wa Airport	Wa	Ghana
DGM	Dandugama Seaplane Base	Colombo	Sri Lanka
KMS	Kumasi Airport	Kumasi	Ghana
NYI	Sunyani Airport	Sunyani	Ghana
TKD	Takoradi Airport	Sekondi-Takoradi	Ghana
DHB	Deer Harbor SPB	Deer Harbor	United States
DHG	Dalnegorsk Airport	Dalnegorsk	Russia
DHL	Ad-Dali Airport	Ad-Dali	Yemen
ABO	Aboisso Airport	Aboisso	Côte d’Ivoire
NYE	Nyeri Airport	Nyeri	Kenya
ABJ	Félix-Houphouët-Boigny International Airport	Abidjan	Côte d’Ivoire
OGO	Abengourou Airport	Abengourou	Côte d’Ivoire
BXI	Boundiali Airport	Boundiali	Côte d’Ivoire
BYK	Bouaké Airport	Bouaké	Côte d’Ivoire
BQO	Bouna Airport	Bouna	Côte d’Ivoire
BDK	Soko Airport	Bondoukou	Côte d’Ivoire
DIM	Dimbokro Airport	Dimbokro	Côte d’Ivoire
DJO	Daloa Airport		Côte d’Ivoire
GGN	Gagnoa Airport	Gagnoa	Côte d’Ivoire
GGO	Guiglo Airport	Guiglo	Côte d’Ivoire
BBV	Nero-Mer Airport	Grand-Béréby	Côte d’Ivoire
HGO	Korhogo Airport	Korhogo	Côte d’Ivoire
MJC	Man Airport		Côte d’Ivoire
KEO	Odienne Airport	Odienne	Côte d’Ivoire
OFI	Ouango Fitini Airport	Ouango Fitini	Côte d’Ivoire
SEO	Séguéla Airport	Séguéla	Côte d’Ivoire
SPY	San Pedro Airport		Côte d’Ivoire
ZSS	Sassandra Airport	Sassandra	Côte d’Ivoire
TXU	Tabou Airport	Tabou	Côte d’Ivoire
TOZ	Mahana Airport	Touba	Côte d’Ivoire
DIW	Mawella Lagoon Seaplane Base	Dickwella	Sri Lanka
ASK	Yamoussoukro Airport	Yamoussoukro	Côte d’Ivoire
DLR	Dalnerechensk Airport	Dalnerechensk	Russia
DIO	Diomede Heliport	Diomede	United States
DKA	Katsina Airport	Katsina	Nigeria
ABV	Nnamdi Azikiwe International Airport	Abuja	Nigeria
QUO	Akwa Ibom International Airport	Uyo	Nigeria
AKR	Akure Airport	Akure	Nigeria
ABB	Asaba International Airport	Asaba	Nigeria
BCU	Sir Abubakar Tafawa Balewa International Airport	Bauchi	Nigeria
BNI	Benin Airport	Benin	Nigeria
CBQ	Margaret Ekpo International Airport	Calabar	Nigeria
ENU	Akanu Ibiam International Airport	Enegu	Nigeria
QUS	Gusau Airport	Gusau	Nigeria
IBA	Ibadan Airport	Ibadan	Nigeria
ILR	Ilorin International Airport	Ilorin	Nigeria
QOW	Sam Mbakwe International Airport	Owerri	Nigeria
JOS	Yakubu Gowon Airport	Jos	Nigeria
KAD	Kaduna Airport	Kaduna	Nigeria
KAN	Mallam Aminu International Airport	Kano	Nigeria
MIU	Maiduguri International Airport	Maiduguri	Nigeria
MDI	Makurdi Airport	Makurdi	Nigeria
LOS	Murtala Muhammed International Airport	Lagos	Nigeria
MXJ	Minna Airport	Minna	Nigeria
PHC	Port Harcourt International Airport	Port Harcourt	Nigeria
SKO	Sadiq Abubakar III International Airport	Sokoto	Nigeria
YOL	Yola Airport	Yola	Nigeria
ZAR	Zaria Airport	Zaria	Nigeria
DOO	Dorobisoro Airport	Dorobisoro	Papua New Guinea
DPT	Deputatskiy Airport	Deputatskiy	Russia
DQA	Daqing Sartu Airport	Daqing	China
MFQ	Maradi Airport	Maradi	Niger
NIM	Diori Hamani International Airport	Niamey	Niger
THZ	Tahoua Airport	Tahoua	Niger
AJY	Mano Dayak International Airport	Agadez	Niger
RLT	Arlit Airport	Arlit	Niger
ZND	Zinder Airport	Zinder	Niger
DSG	Dilasag Airport	Dilasag	Philippines
TBJ	Tabarka-Aïn Draham International Airport	Tabarka	Tunisia
MIR	Monastir Habib Bourguiba International Airport	Monastir	Tunisia
NBE	Enfidha - Hammamet International Airport	Enfidha	Tunisia
TUN	Tunis Carthage International Airport	Tunis	Tunisia
GAF	Gafsa Ksar International Airport	Gafsa	Tunisia
GAE	Gabès Matmata International Airport	Gabès	Tunisia
DJE	Djerba Zarzis International Airport	Mellita	Tunisia
EBM	El Borma Airport	El Borma	Tunisia
SFA	Sfax Thyna International Airport	Sfax	Tunisia
TOE	Tozeur Nefta International Airport	Tozeur	Tunisia
DVD	Andavadoaka Airport	Andavadoaka	Madagascar
DWO	Diyawanna Oya Seaplane Base	Sri Jayawardenepura Kotte	Sri Lanka
DWR	Dwyer Airport	Reg	Afghanistan
LRL	Niamtougou International Airport	Niamtougou	Togo
LFW	Lomé–Tokoin International Airport	Lomé	Togo
DZH	Dazhou Jinya Airport	Dazhou (Dachuan)	China
EAL	Elenak Airport	Mejato Island	Marshall Islands
ANR	Antwerp International Airport (Deurne)	Antwerp	Belgium
BRU	Brussels Airport	Zaventem	Belgium
CRL	Brussels South Charleroi Airport	Charleroi	Belgium
GNE	Ghent/Industry Zone Heliport	Gent	Belgium
KJK	Flanders International Airport Kortrijk-Wevelgem	Wevelgem	Belgium
LGG	Liège Airport	Grâce-Hollogne	Belgium
EBO	Ebon Airport	Ebon Atoll	Marshall Islands
OST	Oostende-Brugge International Airport	Oostende	Belgium
OBL	Oostmalle Airfield	Zoersel	Belgium
MZD	Méndez Airport	Santiago de Méndez	Ecuador
EDA	Edna Bay Seaplane Base	Edna Bay	United States
AOC	Leipzig–Altenburg Airport	Nobitz	Germany
HDF	Heringsdorf Airport	Zirchow	Germany
IES	Riesa-Göhlis Airport	Riesa	Germany
REB	Rechlin-Lärz Airport	Lärz	Germany
CSO	Cochstedt Airport	Hecklingen	Germany
BBH	Stralsund-Barth Airport	Barth	Germany
FNB	Neubrandenburg Trollenhagen Airport	Trollenhagen	Germany
GTI	Rügen Airport	Dreschvitz	Germany
KOQ	Köthen Airport	Köthen (Anhalt)	Germany
PEF	Peenemünde Airport	Peenemünde	Germany
BER	Berlin Brandenburg Airport	Berlin	Germany
DRS	Dresden Airport	Dresden	Germany
ERF	Erfurt-Weimar Airport	Erfurt	Germany
FRA	Frankfurt Airport	Frankfurt am Main	Germany
FMO	Münster Osnabrück Airport	Greven	Germany
HAM	Hamburg Helmut Schmidt Airport	Hamburg	Germany
CGN	Cologne Bonn Airport	Köln (Cologne)	Germany
DUS	Düsseldorf Airport	Düsseldorf	Germany
MUC	Munich Airport	Munich	Germany
LEJ	Leipzig/Halle Airport	Schkeuditz	Germany
SCN	Saarbrücken Airport	Saarbrücken	Germany
STR	Stuttgart Airport	Stuttgart	Germany
HAJ	Hannover Airport	Hannover	Germany
BRE	Bremen Airport	Bremen	Germany
HHN	Frankfurt-Hahn Airport	Frankfurt am Main (Lautzenhausen)	Germany
MHG	Mannheim-City Airport	Mannheim	Germany
EIB	Eisenach-Kindel Airport	Hörselberg-Hainich	Germany
ZOE	Ludwigshafen Accident Hospital Heliport	Ludwigshafen	Germany
SGE	Siegerland Airport	Burbach	Germany
IZE	Itzehoe Hungriger Wolf Airfield	Hohenlockstedt	Germany
XFW	Hamburg-Finkenwerder Airport	Hamburg	Germany
KEL	Kiel-Holtenau Airport	Kiel	Germany
LBC	Lübeck Blankensee Airport	Lübeck	Germany
EUM	Neumünster Airport	Neumünster	Germany
FMM	Memmingen Allgau Airport	Memmingen	Germany
AAH	Aachen-Merzbrück Airport	Aachen	Germany
ESS	Essen Mülheim Airport		Germany
BFE	Bielefeld Airport	Bielefeld	Germany
MGL	Mönchengladbach Airport	Mönchengladbach	Germany
PAD	Paderborn Lippstadt Airport	Büren	Germany
NRN	Weeze Airport	Weeze	Germany
DTM	Dortmund Airport	Dortmund	Germany
AGB	Augsburg Airport	Augsburg	Germany
OBF	Oberpfaffenhofen Airport	Weßling	Germany
RBM	Straubing Airport	Atting	Germany
FDH	Friedrichshafen Airport	Friedrichshafen	Germany
BYU	Bayreuth Airport	Bindlach	Germany
URD	Burg Feuerstein Airport	Ebermannstadt	Germany
GHF	Giebelstadt Airport	Giebelstadt	Germany
HOQ	Hof-Plauen Airport	Hof	Germany
BBJ	Bitburg Airport	Bitburg	Germany
ZQW	Zweibrücken Airport	Zweibrücken	Germany
FKB	Karlsruhe Baden-Baden Airport	Rheinmünster	Germany
LHA	Lahr Airport	Lahr/Schwarzwald	Germany
BWE	Braunschweig-Wolfsburg Airport	Braunschweig	Germany
KSF	Kassel Airport	Calden	Germany
EME	Emden Airport	Emden	Germany
AGE	Wangerooge Airport	Wangerooge	Germany
WVN	JadeWeser Airport	Wilhelmshaven	Germany
JUI	Juist Airport	Juist	Germany
LGO	Langeoog Airport	Langeoog	Germany
BMK	Borkum Airport	Borkum	Germany
NOD	Norden-Norddeich Airport	Norddeich	Germany
VAC	Varrelbusch Airfield	Cloppenburg	Germany
NRD	Norderney Airport	Norderney	Germany
BMR	Baltrum Airport	Baltrum	Germany
HEI	Heide-Büsum Airport	Oesterdeichstrich	Germany
FLF	Flensburg-Schäferhaus Airport	Flensburg	Germany
HGL	Helgoland-Düne Airport	Helgoland	Germany
QHU	Husum-Schwesing Airport	Husum	Germany
PSH	Sankt Peter-Ording Airport	Sankt Peter-Ording	Germany
GWT	Westerland Sylt Airport	Sylt	Germany
OHR	Wyk auf Föhr Airport	Wyk auf Föhr	Germany
KDL	Kärdla Airport	Kärdla	Estonia
URE	Kuressaare Airport	Kuressaare	Estonia
EPU	Pärnu Airport	Pärnu	Estonia
EES	Berenice International Airport / Banas Cape Air Base	Berenice Troglodytica	Egypt
TLL	Lennart Meri Tallinn Airport	Tallinn	Estonia
TAY	Tartu Airport	Tartu	Estonia
ENF	Enontekio Airport	Enontekio	Finland
EFG	Efogi Airport	Efogi	Papua New Guinea
KEV	Halli Airport	Jämsä	Finland
HEN	Hernesaari Heliport	Helsinki	Finland
HEL	Helsinki Vantaa Airport	Helsinki	Finland
HYV	Hyvinkää Airfield	Hyvinkää	Finland
KTQ	Kitee Airport	Kitee	Finland
IVL	Ivalo Airport	Ivalo	Finland
JOE	Joensuu Airport	Joensuu	Finland
JYV	Jyväskylä Airport	Jyväskylän Maalaiskunta	Finland
KAU	Kauhava Airfield	Kauhava	Finland
KEM	Kemi-Tornio Airport	Kemi / Tornio	Finland
KAJ	Kajaani Airport	Kajaani	Finland
KHJ	Kauhajoki Airfield		Finland
KOK	Kokkola-Pietarsaari Airport	Kokkola / Kruunupyy	Finland
KAO	Kuusamo Airport	Kuusamo	Finland
KTT	Kittilä Airport	Kittilä	Finland
KUO	Kuopio Airport	Kuopio / Siilinjärvi	Finland
LPP	Lappeenranta Airport	Lappeenranta	Finland
MHQ	Mariehamn Airport	Mariehamn	Finland
MIK	Mikkeli Airport	Mikkeli	Finland
OUL	Oulu Airport	Oulu / Oulunsalo	Finland
POR	Pori Airport	Pori	Finland
RVN	Rovaniemi Airport	Rovaniemi	Finland
SVL	Savonlinna Airport	Savonlinna	Finland
SJY	Seinäjoki Airport	Seinäjoki / Ilmajoki	Finland
SOT	Sodankyla Airport	Sodankyla	Finland
TMP	Tampere-Pirkkala Airport	Tampere / Pirkkala	Finland
TKU	Turku Airport	Turku	Finland
UTI	Utti Air Base	Utti / Valkeala	Finland
VAA	Vaasa Airport	Vaasa	Finland
VRK	Varkaus Airport	Varkaus / Joroinen	Finland
YLI	Ylivieska Airfield		Finland
TFR	Katameya Air Base	New Cairo	Egypt
AUE	Abu Rudeis Airport	Ras Abu Rudeis	Egypt
BFS	Belfast International Airport	Belfast	United Kingdom
ENK	Enniskillen/St Angelo Airport	Enniskillen	United Kingdom
BHD	George Best Belfast City Airport	Belfast	United Kingdom
LDY	City of Derry Airport	Derry	United Kingdom
BHX	Birmingham Airport	Birmingham, West Midlands	United Kingdom
CVT	Coventry Airport	Coventry, West Midlands	United Kingdom
GLO	Gloucestershire Airport	Staverton	United Kingdom
ORM	Sywell Aerodrome	Northampton, Northamptonshire	United Kingdom
NQT	Nottingham Airport	Nottingham	United Kingdom
GBA	Cotswold Airport	Cirencester, Gloucestershire	United Kingdom
MAN	Manchester Airport	Manchester, Greater Manchester	United Kingdom
UPV	Upavon Aerodrome	Upavon	United Kingdom
YEO	RNAS Yeovilton	Yeovil, Somerset	United Kingdom
CAL	Campbeltown Airport	Campbeltown	United Kingdom
EOI	Eday Airport	Eday	United Kingdom
FIE	Fair Isle Airport	Fair Isle	United Kingdom
WHS	Whalsay Airstrip	Whalsay, Shetlands	United Kingdom
COL	Coll Airport	Coll Island	United Kingdom
NRL	North Ronaldsay Airport	North Ronaldsay	United Kingdom
OBN	Oban Airport	North Connel	United Kingdom
PPW	Papa Westray Airport	Papa Westray	United Kingdom
SOY	Stronsay Airport	Stronsay	United Kingdom
NDY	Sanday Airport	Sanday	United Kingdom
LWK	Lerwick / Tingwall Airport	Lerwick	United Kingdom
WRY	Westray Airport	Westray	United Kingdom
CSA	Colonsay Airstrip	Colonsay	United Kingdom
HAW	Haverfordwest Airport	Haverfordwest	United Kingdom
CWL	Cardiff International Airport	Rhoose, Vale of Glamorgan	United Kingdom
SWS	Swansea Airport	Swansea	United Kingdom
BRS	Bristol Airport	Bristol	United Kingdom
LPL	Liverpool John Lennon Airport	Liverpool	United Kingdom
LTN	London Luton Airport	Luton, Bedfordshire	United Kingdom
LEQ	Land's End Airport	Land's End, Cornwall	United Kingdom
ISC	St. Mary's Airport	St. Mary's	United Kingdom
BOH	Bournemouth Airport	Christchurch, Dorset	United Kingdom
SOU	Southampton Airport	Southampton	United Kingdom
BBP	Bembridge Airport	Bembridge, Isle of Wight	United Kingdom
NQY	Cornwall Airport Newquay	Newquay	United Kingdom
QUG	Goodwood Aerodrome	Chichester, West Sussex	United Kingdom
ACI	Alderney Airport	Saint Anne	Guernsey
GCI	Guernsey Airport	Saint Peter Port	Guernsey
JER	Jersey Airport	Saint Helier	Jersey
ESH	Brighton City Airport	Brighton, East Sussex	United Kingdom
BQH	London Biggin Hill Airport	London	United Kingdom
LGW	London Gatwick Airport	Gatwick, Surrey	United Kingdom
LCY	London City Airport	London	United Kingdom
FAB	Farnborough Airport	Farnborough	United Kingdom
BBS	Blackbushe Airport	Camberley, Surrey	United Kingdom
LHR	London Heathrow Airport	London	United Kingdom
SEN	London Southend Airport	Southend-on-Sea, Essex	United Kingdom
LYX	Lydd London Ashford Airport	Romney Marsh, Kent	United Kingdom
CAX	Carlisle Lake District Airport	Carlisle	United Kingdom
BLK	Blackpool International Airport	Blackpool	United Kingdom
HUY	Humberside Airport	Grimsby	United Kingdom
BWF	Barrow Walney Island Airport	Barrow-in-Furness	United Kingdom
LBA	Leeds Bradford Airport	Leeds, West Yorkshire	United Kingdom
WRT	Warton Aerodrome	Warton	United Kingdom
CEG	Hawarden Airport	Broughton	United Kingdom
IOM	Isle of Man Airport	Castletown	Isle of Man
NCL	Newcastle International Airport	Newcastle upon Tyne, Tyne and Wear	United Kingdom
MME	Teesside International Airport	Darlington, Durham	United Kingdom
EMA	East Midlands Airport	Nottingham	United Kingdom
VLY	Anglesey Airport	Angelsey	United Kingdom
KOI	Kirkwall Airport	Orkney Islands	United Kingdom
LSI	Sumburgh Airport	Lerwick	United Kingdom
WIC	Wick Airport	Wick	United Kingdom
ABZ	Aberdeen Dyce Airport	Aberdeen	United Kingdom
INV	Inverness Airport	Inverness	United Kingdom
GLA	Glasgow International Airport	Paisley, Renfrewshire	United Kingdom
EDI	Edinburgh Airport	Edinburgh	United Kingdom
ILY	Islay Airport	Isle of Islay, Argyll and Bute	United Kingdom
PIK	Glasgow Prestwick Airport	Prestwick, South Ayrshire	United Kingdom
BEB	Benbecula Airport	Balivanich	United Kingdom
DND	Dundee Airport	Dundee	United Kingdom
SYY	Stornoway Airport	Stornoway, Western Isles	United Kingdom
BRR	Barra Airport	Eoligarry	United Kingdom
PSL	Perth/Scone Airport	Perth	United Kingdom
TRE	Tiree Airport	Balemartine	United Kingdom
UNT	Unst Airport	Shetland Islands	United Kingdom
ADX	Leuchars Station Airfield	Leuchars, Fife	United Kingdom
LMO	RAF Lossiemouth	Lossiemouth	United Kingdom
CBG	Cambridge City Airport	Cambridge, Cambridgeshire	United Kingdom
NWI	Norwich Airport	Norwich, Norfolk	United Kingdom
STN	London Stansted Airport	London	United Kingdom
HYC	Wycombe Air Park	High Wycombe	United Kingdom
EXT	Exeter International Airport	Exeter, Devon	United Kingdom
OXF	Oxford (Kidlington) Airport	Kidlington	United Kingdom
RCS	Rochester Airport	Rochester, Kent	United Kingdom
BEX	RAF Benson	Benson	United Kingdom
LKZ	RAF Lakenheath	Brandon, Suffolk	United Kingdom
MHZ	RAF Mildenhall	Bury Saint Edmunds, Suffolk	United Kingdom
FFD	RAF Fairford	Fairford	United Kingdom
BZZ	RAF Brize Norton	Carterton, Oxfordshire	United Kingdom
ODH	RAF Odiham	Odiham	United Kingdom
NHT	RAF Northolt	London	United Kingdom
QCY	RAF Coningsby	Coningsby	United Kingdom
BEQ	RAF Honington	Bury Saint Edmunds, Suffolk	United Kingdom
WTN	RAF Waddington	Waddington	United Kingdom
KNF	RAF Marham	King's Lynn, Norfolk	United Kingdom
MPN	Mount Pleasant Airport	Mount Pleasant	Falkland Islands
AMS	Amsterdam Airport Schiphol	Amsterdam	Netherlands
MST	Maastricht Aachen Airport	Maastricht	Netherlands
EIN	Eindhoven Airport	Eindhoven	Netherlands
GRQ	Groningen Airport Eelde	Groningen	Netherlands
GLZ	Gilze Rijen Air Base	Rijen	Netherlands
DHR	De Kooy Airfield / Den Helder Naval Air Station	Den Helder	Netherlands
LEY	Lelystad Airport	Lelystad	Netherlands
LWR	Leeuwarden Air Base	Leeuwarden	Netherlands
RTM	Rotterdam The Hague Airport	Rotterdam	Netherlands
WOE	Woensdrecht Air Base	Hoogerheide	Netherlands
BYT	Bantry Aerodrome	Bantry	Ireland
BLY	Belmullet Aerodrome	Belmullet	Ireland
NNR	Connemara Regional Airport	Inverin	Ireland
ORK	Cork Airport	Cork	Ireland
GWY	Galway Airport	Galway	Ireland
CFN	Donegal Airport	Donegal	Ireland
DUB	Dublin Airport	Dublin	Ireland
IOR	Inishmore Aerodrome	Inis Mór	Ireland
INQ	Inisheer Aerodrome	Inis Oírr	Ireland
KKY	Kilkenny Airport	Kilkenny	Ireland
NOC	Ireland West Knock Airport	Charlestown	Ireland
KIR	Kerry Airport	Killarney	Ireland
LTR	Letterkenny Airfield	Letterkenny	Ireland
IIA	Inishmaan Aerodrome	Inis Meáin	Ireland
SNN	Shannon Airport	Shannon	Ireland
SXL	Sligo Airport	Sligo	Ireland
WAT	Waterford Airport	Waterford	Ireland
EJN	Ejin Banner Taolai Airport	Ejin Banner	China
EJT	Enejit Airport	Enejit Island	Marshall Islands
AAR	Aarhus Airport	Aarhus	Denmark
BLL	Billund Airport	Billund	Denmark
CPH	Copenhagen Kastrup Airport	Copenhagen	Denmark
EBJ	Esbjerg Airport	Esbjerg	Denmark
KRP	Midtjyllands Airport / Air Base Karup	Karup	Denmark
BYR	Læsø Airport	Læsø	Denmark
MRW	Lolland Falster Maribo Airport	Rødby	Denmark
ODE	Odense Hans Christian Andersen Airport	Odense	Denmark
RKE	Copenhagen Roskilde Airport	Roskilde	Denmark
RNN	Bornholm Airport	Rønne	Denmark
SGD	Sønderborg Airport	Sønderborg	Denmark
CNL	Sindal Airport	Sindal	Denmark
SKS	Skrydstrup Air Base	Vojens	Denmark
SQW	Skive Airport	Skive	Denmark
TED	Thisted Airport	Thisted	Denmark
FAE	Vágar Airport	Vágar	Faroe Islands
STA	Stauning Vestjylland  Airport	Skjern	Denmark
AAL	Aalborg Airport	Aalborg	Denmark
LUX	Luxembourg-Findel International Airport	Luxembourg	Luxembourg
EMR	El Mirador Heliport	El Mirador	Guatemala
AES	Ålesund Airport, Vigra	Ålesund	Norway
ANX	Andøya Airport, Andenes	Andenes	Norway
ALF	Alta Airport	Alta	Norway
FDE	Førde Airport, Bringeland	Førde	Norway
BNN	Brønnøysund Airport, Brønnøy	Brønnøy	Norway
BOO	Bodø Airport	Bodø	Norway
BGO	Bergen Airport, Flesland	Bergen	Norway
BJF	Båtsfjord Airport	Båtsfjord	Norway
BVG	Berlevåg Airport	Berlevåg	Norway
KRS	Kristiansand Airport, Kjevik	Kjevik	Norway
BDU	Bardufoss Airport	Målselv	Norway
EVE	Harstad/Narvik Airport, Evenes	Evenes	Norway
VDB	Fagernes Airport, Leirin	Fagernes	Norway
FRO	Florø Airport	Florø	Norway
OSL	Oslo Airport, Gardermoen	Oslo	Norway
HMR	Hamar Lufthavn, Stavsberg	Hamar	Norway
HAU	Haugesund Airport, Karmøy	Karmøy	Norway
HFT	Hammerfest Airport	Hammerfest	Norway
HAA	Hasvik Airport	Hasvik	Norway
HVG	Honningsvåg Airport, Valan	Honningsvåg	Norway
KSU	Kristiansund Airport, Kvernberget	Kvernberget	Norway
GLL	Gol Airport	Klanten flyplass	Norway
KKN	Kirkenes Airport, Høybuktmoen	Kirkenes	Norway
LKN	Leknes Airport	Leknes	Norway
MEH	Mehamn Airport	Mehamn	Norway
MOL	Molde Airport, Årø	Årø	Norway
MJF	Mosjøen Airport, Kjærstad	Mosjøen	Norway
LKL	Lakselv Airport, Banak	Lakselv	Norway
OSY	Namsos Airport	Namsos	Norway
NTB	Notodden Airport	Notodden	Norway
OLA	Ørland Airport	Ørland	Norway
HOV	Ørsta-Volda Airport, Hovden	Ørsta	Norway
MQN	Mo i Rana Airport, Røssvoll	Mo i Rana	Norway
RVK	Rørvik Airport, Ryum	Rørvik	Norway
RRS	Røros Airport	Røros	Norway
RET	Røst Airport	Røst	Norway
RYG	Moss Airport, Rygge	Oslo	Norway
LYR	Svalbard Airport, Longyear	Longyearbyen	Norway
SDN	Sandane Airport, Anda	Sandane	Norway
SOG	Sogndal Airport, Haukåsen	Sogndal	Norway
SVJ	Svolvær Airport, Helle	Svolvær	Norway
SKN	Stokmarknes Airport, Skagen	Hadsel	Norway
SKE	Skien Airport	Geiteryggen	Norway
SRP	Stord Airport, Sørstokken	Leirvik	Norway
SOJ	Sørkjosen Airport	Sørkjosen	Norway
VAW	Vardø Airport, Svartnes	Vardø	Norway
SSJ	Sandnessjøen Airport, Stokka	Alstahaug	Norway
TOS	Tromsø Airport, Langnes	Tromsø	Norway
TRF	Sandefjord Airport, Torp	Torp	Norway
TRD	Trondheim Airport, Værnes	Trondheim	Norway
VDS	Vadsø Airport	Vadsø	Norway
VRY	Værøy Heliport	Værøy	Norway
ENY	Yan'an Nanniwan Airport	Yan'an (Baota)	China
SVG	Stavanger Airport, Sola	Stavanger	Norway
BZG	Bydgoszcz Ignacy Jan Paderewski Airport	Białe Błota	Poland
CZW	Częstochowa-Rudniki Airport	Rudniki	Poland
GDN	Gdańsk Lech Wałęsa Airport	Gdańsk	Poland
KRK	Kraków John Paul II International Airport	Balice	Poland
KTW	Katowice Wojciech Korfanty International Airport	Ożarowice	Poland
LUZ	Lublin Airport	Lublin	Poland
LCJ	Łódź Władysław Reymont Airport	Łódź	Poland
WMI	Modlin Airport	Nowy Dwór Mazowiecki	Poland
POZ	Poznań-Ławica Airport	Poznań	Poland
RDO	Warsaw Radom Airport	Radom	Poland
RZE	Rzeszów-Jasionka Airport	Jasionka	Poland
SZZ	Solidarity Szczecin–Goleniów Airport	Glewice	Poland
SZY	Olsztyn-Mazury Airport	Olsztyn	Poland
WAW	Warsaw Chopin Airport	Warsaw	Poland
WRO	Copernicus Wrocław Airport	Wrocław	Poland
IEG	Zielona Góra-Babimost Airport	Nowe Kramsko	Poland
ERT	Erdenet Airport	Erdenet	Mongolia
RNB	Ronneby Airport	Ronneby	Sweden
GOT	Göteborg Landvetter Airport	Göteborg	Sweden
JKG	Jönköping Airport	Jönköping	Sweden
LDK	Lidköping-Hovby Airport	Lidköping	Sweden
GSE	Säve Airport	Göteborg	Sweden
KVB	Skövde Airport	Skövde	Sweden
THN	Trollhättan-Vänersborg Airport	Trollhättan	Sweden
KSK	Karlskoga Airport		Sweden
MXX	Mora Airport	Mora	Sweden
NYO	Stockholm Skavsta Airport	Nyköping	Sweden
SCR	Scandinavian Mountains Airport	Malung-Sälen	Sweden
KID	Kristianstad Airport	Kristianstad	Sweden
OSK	Oskarshamn Airport		Sweden
KLR	Kalmar Airport	Kalmar	Sweden
MMX	Malmö Sturup Airport	Malmö	Sweden
HAD	Halmstad Airport	Halmstad	Sweden
VXO	Växjö Kronoberg Airport	Växjö	Sweden
EVG	Sveg Airport	Sveg	Sweden
GEV	Gällivare Airport	Gällivare	Sweden
KRF	Kramfors-Sollefteå Höga Kusten Airport	Nyland	Sweden
LYC	Lycksele Airport	Lycksele	Sweden
SDL	Sundsvall-Härnösand Airport	Sundsvall/ Härnösand	Sweden
OER	Örnsköldsvik Airport	Örnsköldsvik	Sweden
KRN	Kiruna Airport	Kiruna	Sweden
SFT	Skellefteå Airport	Skellefteå	Sweden
UME	Umeå Airport	Umeå	Sweden
VHM	Vilhelmina South Lapland Airport	Vilhelmina	Sweden
AJR	Arvidsjaur Airport	Arvidsjaur	Sweden
SOO	Söderhamn Airport	Söderhamn	Sweden
OSD	Åre Östersund Airport	Östersund	Sweden
ORB	Örebro Airport	Örebro	Sweden
HFS	Hagfors Airport	Råda	Sweden
KSD	Karlstad Airport	Karlstad	Sweden
VST	Stockholm Västerås Airport	Stockholm / Västerås	Sweden
LLA	Luleå Airport	Luleå	Sweden
ARN	Stockholm-Arlanda Airport	Stockholm	Sweden
BMA	Stockholm-Bromma Airport	Stockholm	Sweden
BLE	Dala Airport	Borlange	Sweden
HLF	Hultsfred Airport		Sweden
GVX	Gävle Sandviken Airport	Gävle / Sandviken	Sweden
LPI	Linköping City Airport	Linköping	Sweden
NRK	Norrköping Airport	Norrköping	Sweden
TYF	Torsby Airport	Torsby	Sweden
EKT	Eskilstuna Airport	Eskilstuna	Sweden
VBY	Visby Airport	Visby	Sweden
VVK	Västervik Airport	Västervik	Sweden
AGH	Ängelholm-Helsingborg Airport	Ängelholm	Sweden
SQO	Storuman Airport	Storuman	Sweden
IDB	Idre Airport	Idre	Sweden
PJA	Pajala Airport		Sweden
HMV	Hemavan Airport	Hemavan	Sweden
DSE	Kombolcha Airport	Dessie	Ethiopia
GLC	Geladi Airport	Geladi	Ethiopia
SHC	Shire Inda Selassie Airport	Shire Inda Selassie	Ethiopia
SPM	Spangdahlem Air Base	Trier	Germany
RMS	Ramstein Air Base	Ramstein-Miesenbach	Germany
FRZ	Fritzlar Army Airfield	Fritzlar	Germany
ILH	Illesheim Army Heliport	Illesheim	Germany
KZG	Kitzingen Airfield	Kitzingen	Germany
FCN	Sea-Airport Cuxhaven/Nordholz / Nordholz Naval Airbase	Wurster Nordseeküste	Germany
GKE	Geilenkirchen Air Base	Geilenkirchen	Germany
RLG	Rostock-Laage Airport	Laage	Germany
WBG	Schleswig Air Base	Jagel	Germany
WIE	Wiesbaden Army Airfield	Wiesbaden	Germany
IGS	Ingolstadt Manching Airport	Manching	Germany
DGP	Daugavpils International Airport	Daugavpils	Latvia
LPX	Liepāja International Airport	Liepāja	Latvia
RIX	Riga International Airport	Riga	Latvia
VNT	Ventspils International Airport	Ventspils	Latvia
EXI	Excursion Inlet Seaplane Base	Excursion Inlet	United States
KUN	Kaunas International Airport	Kaunas	Lithuania
PLQ	Palanga International Airport	Palanga	Lithuania
PNV	Panevėžys Air Base	Panevėžys	Lithuania
SQQ	Šiauliai International Airport	Šiauliai	Lithuania
VNO	Vilnius International Airport	Vilnius	Lithuania
RGR	Ranger Municipal Airport	Ranger	United States
ALJ	Alexander Bay Airport	Alexander Bay	South Africa
AGZ	Aggeneys Airport	Aggeneys	South Africa
ADY	Alldays Airport	Alldays	South Africa
BIY	Bisho Airport	Bisho	South Africa
BFN	Bram Fischer International Airport	Bloemfontain	South Africa
UTE	Bultfontein Airport	Bultfontein	South Africa
ASS	Arathusa Safari Lodge Airport	Arathusa	South Africa
CDO	Cradock Airport	Cradock	South Africa
CPT	Cape Town International Airport	Cape Town	South Africa
DUK	Mubatuba Airport	Mubatuba	South Africa
PZL	Zulu Inyala Airport	Phinda	South Africa
ELS	Ben Schoeman Airport	East London	South Africa
EMG	Empangeni Airport	Empangeni	South Africa
ELL	Ellisras Matimba Airport	Ellisras	South Africa
FCB	Ficksburg Sentraoes Airport	Ficksburg	South Africa
GCJ	Grand Central Airport	Midrand	South Africa
GRJ	George Airport	George	South Africa
GIY	Giyani Airport	Giyani	South Africa
QRA	Rand Airport	Johannesburg	South Africa
HLW	Hluhluwe Airport	Hluhluwe	South Africa
HRS	Harrismith Airport	Harrismith	South Africa
HDS	Hoedspruit Air Force Base Airport	Hoedspruit	South Africa
KXE	P C Pelser Airport	Klerksdorp	South Africa
KIM	Kimberley Airport	Kimberley	South Africa
MQP	Kruger Mpumalanga International Airport	Mpumalanga	South Africa
KOF	Komatipoort Airport	Komatipoort	South Africa
KMH	Johan Pienaar Airport	Kuruman	South Africa
KLZ	Kleinsee Airport	Kleinsee	South Africa
HLA	Lanseria International Airport	Johannesburg	South Africa
LMR	Lime Acres Finsch Mine Airport	Lime Acres	South Africa
LDZ	Londolozi Airport	Londolozi	South Africa
DUR	King Shaka International Airport	Durban	South Africa
LUJ	Lusikisiki Airport	Lusikisiki	South Africa
LCD	Louis Trichardt Airport	Louis Trichardt	South Africa
SDB	Langebaanweg Airport	Langebaanweg	South Africa
LAY	Ladysmith Airport	Ladysmith	South Africa
AAM	Malamala Airport	Malamala	South Africa
MGH	Margate Airport	Margate	South Africa
MEZ	Musina(Messina) Airport	Musina	South Africa
MBD	Mmabatho International Airport	Mafeking	South Africa
MZY	Mossel Bay Airport	Mossel Bay	South Africa
MZQ	Mkuze Airport	Mkuze	South Africa
NCS	Newcastle Airport	Newcastle	South Africa
NGL	Ngala Airport	Ngala	South Africa
NLP	Nelspruit Airport	Nelspruit	South Africa
OVG	Overberg Airport	Overberg	South Africa
OUH	Oudtshoorn Airport	Oudtshoorn	South Africa
JNB	O.R. Tambo International Airport	Johannesburg	South Africa
AFD	Port Alfred Airport	Port Alfred	South Africa
PLZ	Chief Dawid Stuurman International Airport	Gqeberha (Port Elizabeth)	South Africa
PBZ	Plettenberg Bay Airport	Plettenberg Bay	South Africa
PHW	Hendrik Van Eck Airport	Phalaborwa	South Africa
JOH	Port St Johns Airport	Port St Johns	South Africa
PRK	Prieska Airport	Prieska	South Africa
PZB	Pietermaritzburg Airport	Pietermaritzburg	South Africa
NTY	Pilanesberg International Airport	Pilanesberg	South Africa
PTG	Polokwane International Airport	Polokwane	South Africa
PCF	Potchefstroom Airport	Potchefstroom	South Africa
UTW	Queenstown Airport	Queenstown	South Africa
RCB	Richards Bay Airport	Richards Bay	South Africa
RVO	Reivilo Airport	Reivilo	South Africa
ROD	Robertson Airport	Robertson	South Africa
SBU	Springbok Airport	Springbok	South Africa
ZEC	Secunda Airport	Secunda	South Africa
GSS	Sabi Sabi Airport	Belfast	South Africa
SIS	Sishen Airport	Sishen	South Africa
SZK	Skukuza Airport	Skukuza	South Africa
THY	Thohoyandou Airport	Thohoyandou	South Africa
TCU	Thaba Nchu Tar Airport	Homeward	South Africa
LTA	Tzaneen Airport	Tzaneen	South Africa
ULD	Prince Mangosuthu Buthelezi Airport	Ulundi	South Africa
UTN	Pierre Van Ryneveld Airport	Upington	South Africa
UTT	K. D. Matanzima Airport	Mthatha	South Africa
VRU	Vryburg Airport	Vyrburg	South Africa
VIR	Virginia Airport	Durban	South Africa
VRE	Vredendal Airport	Vredendal	South Africa
VYD	Vryheid Airport	Vryheid	South Africa
PRY	Wonderboom Airport	Pretoria	South Africa
WKF	Waterkloof Air Force Base	Pretoria	South Africa
WEL	Welkom Airport	Welkom	South Africa
FRW	P G Matante Intl	Francistown	Botswana
GNZ	Ghanzi Airport	Ghanzi	Botswana
JWA	Jwaneng Airport	Jwaneng	Botswana
BBK	Kasane Airport	Kasane	Botswana
KHW	Khwai River Lodge Airport	Khwai River Lodge	Botswana
LOQ	Lobatse Airport	Lobatse	Botswana
MUB	Maun Airport	Maun	Botswana
ORP	Orapa Airport	Orapa	Botswana
QPH	Palapye Airport	Palapye	Botswana
GBE	Sir Seretse Khama International Airport	Gaborone	Botswana
SXN	Sua Pan Airport	Sowa	Botswana
PKW	Selebi Phikwe Airport	Selebi Phikwe	Botswana
SVT	Savuti Airport	Savuti	Botswana
SWX	Shakawe Airport	Shakawe	Botswana
TLD	Tuli Lodge Airport	Tuli Lodge	Botswana
TBY	Tshabong Airport	Tshabong	Botswana
BZV	Maya-Maya Airport	Brazzaville	Congo - Brazzaville
DJM	Djambala Airport	Djambala	Congo - Brazzaville
KNJ	Kindamba Airport	Kindamba	Congo - Brazzaville
LCO	Lague Airport	Lague	Congo - Brazzaville
MUY	Mouyondzi Airport	Mouyondzi	Congo - Brazzaville
SIB	Sibiti Airport	Sibiti	Congo - Brazzaville
NKY	Yokangassi Airport	Nkayi	Congo - Brazzaville
ANJ	Zanaga Airport	Zanaga	Congo - Brazzaville
MSX	Mossendjo Airport	Mossendjo	Congo - Brazzaville
BOE	Boundji Airport	Boundji	Congo - Brazzaville
OLL	Oyo Ollombo Airport	Oyo	Congo - Brazzaville
EWO	Ewo Airport	Ewo	Congo - Brazzaville
GMM	Gamboma Airport	Gamboma	Congo - Brazzaville
ION	Impfondo Airport	Impfondo	Congo - Brazzaville
KEE	Kelle Airport	Kelle	Congo - Brazzaville
MKJ	Makoua Airport	Makoua	Congo - Brazzaville
FTX	Owando Airport	Owando	Congo - Brazzaville
SOE	Souanke Airport	Souanke	Congo - Brazzaville
BTB	Betou Airport	Betou	Congo - Brazzaville
OUE	Ouesso Airport		Congo - Brazzaville
KMK	Makabana Airport	Makabana	Congo - Brazzaville
DIS	Ngot Nzoungou Airport	Dolisie	Congo - Brazzaville
PNR	Antonio Agostinho-Neto International Airport	Pointe Noire	Congo - Brazzaville
MTS	Matsapha Airport	Manzini	Eswatini
SHO	King Mswati III International Airport	Mpaka	Eswatini
FEA	Fetlar Airstrip	Fetlar Island	United Kingdom
CRF	Carnot Airport	Carnot	Central African Republic
BGF	Bangui M'Poko International Airport	Bangui	Central African Republic
BGU	Bangassou Airport	Bangassou	Central African Republic
IRO	Birao Airport	Birao	Central African Republic
BBY	Bambari Airport	Bambari	Central African Republic
NDL	N'Délé Airport	N'Délé	Central African Republic
BOP	Bouar Airport	Bouar	Central African Republic
BIV	Bria Airport	Bria	Central African Republic
BSN	Bossangoa Airport	Bossangoa	Central African Republic
BBT	Berbérati Airport	Berbérati	Central African Republic
ODA	Ouadda Airport	Ouadda	Central African Republic
AIG	Yalinga Airport	Yalinga	Central African Republic
IMO	Zemio Airport	Zemio	Central African Republic
MKI	M'Boki Airport	Mboki	Central African Republic
BTG	Batangafo Airport	Batangafo	Central African Republic
GDI	Gordil Airport	Melle	Central African Republic
BMF	Bakouma Airport	Bakouma	Central African Republic
ODJ	Ouanda Djallé Airport	Ouanda Djallé	Central African Republic
RFA	Rafaï Airport	Rafaï	Central African Republic
BCF	Bouca Airport	Bouca	Central African Republic
BOZ	Bozoum Airport	Bozoum	Central African Republic
NBN	Annobón Airport	San Antonio de Palé	Equatorial Guinea
BSG	Bata Airport	Bata	Equatorial Guinea
GEM	President Obiang Nguema International Airport	Mengomeyén	Equatorial Guinea
SSG	Malabo Airport	Malabo	Equatorial Guinea
ASI	RAF Ascension Island	Cat Hill	St. Helena
HLE	Saint Helena Airport	Longwood	St. Helena
MRU	Sir Seewoosagur Ramgoolam International Airport	Plaine Magnien	Mauritius
RRG	Sir Charles Gaetan Duval Airport	Port Mathurin	Mauritius
FIN	Finschhafen Airport	Buki	Papua New Guinea
PHR	Nanuku Airport	Nanuku Auberge Resort	Fiji
KVU	Korolevu Seaplane Base	Korolevu	Fiji
NKW	Diego Garcia Naval Support Facility	Diego Garcia	British Indian Ocean Territory
KBI	Kribi Airport	Kribi	Cameroon
TKC	Tiko Airport	Tiko	Cameroon
DLA	Douala International Airport	Douala	Cameroon
MMF	Mamfe Airport	Mamfe	Cameroon
BLC	Bali Airport	Bali	Cameroon
KLE	Kaélé Airport	Kaélé	Cameroon
OUR	Batouri Airport	Batouri	Cameroon
GXX	Yagoua Airport	Yagoua	Cameroon
MVR	Salak Airport	Maroua	Cameroon
FOM	Foumban Nkounja Airport	Foumban	Cameroon
NGE	N'Gaoundéré Airport	N'Gaoundéré	Cameroon
BTA	Bertoua Airport	Bertoua	Cameroon
GOU	Garoua International Airport	Garoua	Cameroon
DSC	Dschang Airport	Dschang	Cameroon
BFX	Bafoussam Airport	Bafoussam	Cameroon
BPC	Bamenda Airport	Bamenda	Cameroon
EBW	Ebolowa Airport	Ebolowa	Cameroon
YAO	Yaoundé Airport	Yaoundé	Cameroon
NSI	Yaoundé Nsimalen International Airport	Yaoundé	Cameroon
MMQ	Mbala Airport	Mbala	Zambia
CIP	Chipata Airport	Chipata	Zambia
CGX	Chunga Airstrip	Chunga	Zambia
JEK	Jeki Airport	Jeki	Zambia
CGJ	Kasompe Airport	Chingola	Zambia
KLB	Kalabo Airport	Kalabo	Zambia
KMZ	Kaoma Airport	Kaoma	Zambia
KAA	Kasama Airport	Kasama	Zambia
ZKB	Kasaba Bay Airport	Kasaba Bay	Zambia
LVI	Harry Mwanga Nkumbula International Airport	Livingstone	Zambia
LXU	Lukulu Airport	Lukulu	Zambia
LUN	Kenneth Kaunda International Airport	Lusaka	Zambia
MNS	Mansa Airport	Mansa	Zambia
MFU	Mfuwe Airport	Mfuwe	Zambia
MNR	Mongu Airport	Mongu	Zambia
ZGM	Ngoma Airport	Ngoma	Zambia
RYL	Royal Zambezi Lodge Airstrip	Lower Zambezi River	Zambia
NLA	Simon Mwansa Kapwepwe International Airport	Ndola	Zambia
SXG	Senanga Airport	Senanga	Zambia
KIW	Southdowns Airport	Kitwe	Zambia
SJQ	Sesheke Airport	Sesheke	Zambia
SLI	Solwesi Airport	Solwesi	Zambia
FLT	Flat Airport	Flat	United States
BBZ	Zambezi Airport	Zambezi	Zambia
ULI	Ulithi Airport	Falalop Island	Micronesia
HAH	Prince Said Ibrahim International Airport	Moroni	Comoros
NWA	Mohéli Bandar Es Eslam Airport	Fomboni	Comoros
AJN	Ouani Airport	Ouani	Comoros
DZA	Dzaoudzi Pamandzi International Airport	Dzaoudzi	Mayotte
RUN	Roland Garros Airport	Sainte-Marie	Réunion
ZSE	Pierrefonds Airport	Saint-Pierre	Réunion
WML	Malaimbandy Airport	Malaimbandy	Madagascar
ATJ	Antsirabe Airport	Antsirabe	Madagascar
WAQ	Antsalova Airport	Antsalova	Madagascar
VVB	Mahanoro Airport	Mahanoro	Madagascar
TNR	Ivato Airport	Antananarivo	Madagascar
JVA	Ankavandra Airport	Ankavandra	Madagascar
BMD	Belo sur Tsiribihina Airport	Belo sur Tsiribihina	Madagascar
ZVA	Miandrivazo Airport	Miandrivazo	Madagascar
MXT	Maintirano Airport	Maintirano	Madagascar
ILK	Atsinanana Airport	Ilaka	Madagascar
TVA	Morafenobe Airport	Morafenobe	Madagascar
SMS	Sainte Marie Airport	Vohilava	Madagascar
TMM	Toamasina Ambalamanasy Airport	Toamasina	Madagascar
WTA	Tambohorano Airport	Tambohorano	Madagascar
MOQ	Morondava Airport	Morondava	Madagascar
WTS	Tsiroanomandidy Airport	Tsiroanomandidy	Madagascar
VAT	Vatomandry Airport	Vatomandry	Madagascar
WAM	Ambatondrazaka Airport	Ambatondrazaka	Madagascar
DIE	Arrachart Airport	Antisiranana	Madagascar
WBE	Ankaizina Airport	Bealanana	Madagascar
WMR	Mananara Nord Airport	Mananara Nord	Madagascar
ZWA	Andapa Airport		Madagascar
AMB	Ambilobe Airport		Madagascar
WBD	Avaratra Airport	Befandriana	Madagascar
WPB	Port Bergé Airport	Port Bergé	Madagascar
ANM	Antsirabe Airport	Antsirabe	Madagascar
HVA	Analalava Airport	Analalava	Madagascar
MJN	Amborovy Airport	Mahajanga	Madagascar
NOS	Fascene Airport	Nosy Be	Madagascar
DWB	Soalala Airport	Soalala	Madagascar
WMP	Mampikony Airport	Mampikony	Madagascar
BPY	Besalampy Airport	Besalampy	Madagascar
WMN	Maroantsetra Airport	Maroantsetra	Madagascar
SVB	Sambava Airport	Sambava	Madagascar
TTS	Tsaratanana Airport	Tsaratanana	Madagascar
VOH	Vohemar Airport	Vohemar	Madagascar
WAI	Ambalabe Airport	Antsohihy	Madagascar
WMA	Mandritsara Airport	Mandritsara	Madagascar
IVA	Ampampamena Airport		Madagascar
WBO	Antsoa Airport	Beroroha	Madagascar
WMD	Mandabe Airport	Mandabe	Madagascar
FTU	Tôlanaro Airport	Tôlanaro	Madagascar
WFI	Fianarantsoa Airport	Fianarantsoa	Madagascar
RVA	Farafangana Airport	Farafangana	Madagascar
IHO	Ihosy Airport	Ihosy	Madagascar
MJA	Manja Airport	Manja	Madagascar
WVK	Manakara Airport	Manakara	Madagascar
OVA	Bekily Airport	Bekily	Madagascar
MNJ	Mananjary Airport	Mananjary	Madagascar
TDV	Samangoky Airport	Tanandava	Madagascar
MXM	Morombe Airport	Morombe	Madagascar
TLE	Toliara Airport	Toliara	Madagascar
VND	Vangaindrano Airport	Vangaindrano	Madagascar
BKU	Betioky Airport	Betioky	Madagascar
AMP	Ampanihy Airport	Ampanihy	Madagascar
WAK	Ankazoabo Airport	Ankazoabo	Madagascar
AZZ	Ambriz Airport	Ambriz	Angola
SSY	Mbanza Congo Airport	Mbanza Congo	Angola
BUG	Benguela 17th of September Airport	Benguela	Angola
GGC	Lumbala Airport	Lumbala N'guimbo	Angola
CAB	Cabinda Airport	Cabinda	Angola
CFF	Cafunfo Airport	Cafunfo	Angola
PGI	Chitato Airport	Chitato	Angola
CBT	Catumbela Airport	Catumbela	Angola
CTI	Cuito Cuanavale Airport	Cuito Cuanavale	Angola
CXM	Camaxilo Airport	Camaxilo	Angola
CAV	Cazombo Airport	Cazombo	Angola
FND	Funadhoo Airport	Funadhoo	Maldives
DUE	Dundo Airport	Chitato	Angola
FNE	Fane Airport	Fane Mission	Papua New Guinea
VPE	Ngjiva Pereira Airport	Ngiva	Angola
NOV	Nova Lisboa Airport	Huambo	Angola
SVP	Kuito Airport	Kuito	Angola
LLT	Lobito Airport	Lobito	Angola
LBZ	Lucapa Airport	Lucapa	Angola
LAD	Quatro de Fevereiro International Airport	Luanda	Angola
LZM	Luzamba Airport	Luzamba	Angola
MEG	Malanje Airport	Malanje	Angola
SPP	Menongue Airport	Menongue	Angola
MSZ	Welwitschia Mirabilis International Airport	Moçâmedes	Angola
GXG	Negage Airport	Negage	Angola
PBN	Porto Amboim Airport	Port Amboim	Angola
VHC	Saurimo Airport	Saurimo	Angola
SZA	Soyo Airport	Soyo	Angola
NDD	Sumbe Airport	Sumbe	Angola
UAL	Luau Airport	Luau	Angola
SDD	Lubango Airport	Lubango	Angola
LUO	Luena Airport	Luena	Angola
UGO	Uige Airport	Uige	Angola
CEO	Waco Kungo Airport	Waco Kungo	Angola
XGN	Xangongo Airport	Xangongo	Angola
ARZ	N'zeto Airport	N'zeto	Angola
NZA	Nzagi Airport	Nzagi	Angola
BGB	Booue Airport	Booue	Gabon
KDN	Ndende Airport	Ndende	Gabon
FOU	Fougamou Airport	Fougamou	Gabon
MBC	M'Bigou Airport	M'Bigou	Gabon
MGX	Moabi Airport	Moabi	Gabon
KDJ	Ville Airport	N'Djolé	Gabon
KOU	Koulamoutou Mabimbi Airport	Koulamoutou	Gabon
MJL	Mouilla Ville Airport	Mouila	Gabon
OYE	Oyem Airport	Oyem	Gabon
OKN	Okondja Airport	Okondja	Gabon
LBQ	Lambarene Airport	Lambarene	Gabon
MVX	Minvoul Airport	Minvoul	Gabon
BMM	Bitam Airport	Bitam	Gabon
MFF	Moanda Airport	Moanda	Gabon
MKB	Mekambo Airport	Mekambo	Gabon
POG	Port Gentil Airport	Port Gentil	Gabon
OMB	Omboue Hospital Airport	Omboue	Gabon
IGE	Tchongorove Airport	Iguela	Gabon
MKU	Makokou Airport	Makokou	Gabon
LBV	Libreville Leon M'ba International Airport	Libreville	Gabon
MZC	Mitzic Airport	Mitzic	Gabon
MVB	M'Vengue El Hadj Omar Bongo Ondimba International Airport	Franceville	Gabon
LTL	Lastourville Airport	Lastourville	Gabon
TCH	Tchibanga Airport	Tchibanga	Gabon
MYB	Mayumba Airport	Mayumba	Gabon
FOY	Foya Airport	Foya	Liberia
PCP	Principe Airport	São Tomé & Príncipe	São Tomé & Príncipe
TMS	São Tomé International Airport	São Tomé	São Tomé & Príncipe
ANO	Angoche Airport	Angoche	Mozambique
BEW	Beira Airport	Beira	Mozambique
FXO	Cuamba Airport	Cuamba	Mozambique
VPY	Chimoio Airport	Chimoio	Mozambique
IHC	Inhaca Airport	Inhaca	Mozambique
INH	Inhambane Airport	Inhambane	Mozambique
VXC	Lichinga Airport	Lichinga	Mozambique
LFB	Lumbo Airport	Lumbo	Mozambique
MPM	Maputo Airport	Maputo	Mozambique
MUD	Mueda Airport	Mueda	Mozambique
MZB	Mocímboa da Praia Airport	Mocímboa da Praia	Mozambique
MNC	Nacala Airport	Nacala	Mozambique
APL	Nampula Airport	Nampula	Mozambique
POL	Pemba Airport	Pemba / Porto Amelia	Mozambique
PDD	Ponta do Ouro Airport	Ponta do Ouro	Mozambique
UEL	Quelimane Airport	Quelimane	Mozambique
TET	Chingozi Airport	Tete	Mozambique
VNX	Vilankulo Airport	Vilanculo	Mozambique
VJB	Xai-Xai Chongoene Airport	Xai-Xai	Mozambique
DES	Desroches Airport	Desroches Island	Seychelles
SEZ	Seychelles International Airport	Mahe Island	Seychelles
FSL	Fossil Downs Airport	Fossil Downs Station	Australia
PRI	Praslin Island Airport	Praslin Island	Seychelles
BDI	Bird Island Airport	Bird Island	Seychelles
DEI	Denis Island Airport	Denis Island	Seychelles
FRK	Frégate Island Airport (UNUSABLE)	Frégate Island	Seychelles
SRH	Sarh Airport	Sarh	Chad
OGR	Bongor Airport	Bongor	Chad
AEH	Abeche Airport	Abeche	Chad
MQQ	Moundou Airport	Moundou	Chad
LTC	Lai Airport	Lai	Chad
ATV	Ati Airport	Ati	Chad
NDJ	N'Djamena International Airport	N'Djamena	Chad
BKR	Bokoro Airport	Bokoro	Chad
OTC	Bol-Berim Airport	Bol	Chad
MVO	Mongo Airport	Mongo	Chad
AMC	Am Timan Airport	Am Timan	Chad
PLF	Pala Airport	Pala	Chad
OUT	Bousso Airport	Bousso	Chad
AMO	Mao Airport	Mao	Chad
FYT	Faya-Largeau Airport	Faya-Largeau	Chad
FUB	Fulleborn Airport	Fulleborn	Papua New Guinea
BZH	Bumi Hills Airport	Bumi	Zimbabwe
BUQ	Joshua Mqabuko Nkomo International Airport	Bulawayo	Zimbabwe
CHJ	Chipinge Airport	Chipinge	Zimbabwe
BFO	Buffalo Range Airport	Chiredzi	Zimbabwe
VFA	Victoria Falls International Airport	Victoria Falls	Zimbabwe
HRE	Robert Gabriel Mugabe International Airport	Harare	Zimbabwe
KAB	Kariba International Airport	Kariba	Zimbabwe
MJW	Mahenye Airport	Gonarezhou National Park	Zimbabwe
UTA	Mutare Airport	Mutare	Zimbabwe
MVZ	Masvingo International Airport	Masvingo	Zimbabwe
GWE	Gweru - Thornhill Air Base	Gweru	Zimbabwe
HWN	Hwange National Park Airport	Hwange	Zimbabwe
WKI	Hwange (Town) Airport	Hwange	Zimbabwe
CEH	Chelinda Malawi Airport		Malawi
BLZ	Chileka International Airport	Blantyre	Malawi
CMK	Club Makokola Airport	Club Makokola	Malawi
DWA	Dwangwa Airport	Dwangwa	Malawi
KGJ	Karonga Airport	Karonga	Malawi
KBQ	Kasungu Airport	Kasungu	Malawi
LLW	Lilongwe International Airport	Lilongwe	Malawi
LIX	Likoma Island Airport	Likoma Island	Malawi
MAI	Mangochi Airport	Mangochi	Malawi
MYZ	Monkey Bay Airport	Monkey Bay	Malawi
LMB	Salima Airport	Salima	Malawi
ZZU	Mzuzu Airport	Mzuzu	Malawi
LEF	Lebakeng Airport	Lebakeng	Lesotho
LRB	Leribe Airport	Leribe	Lesotho
LES	Lesobeng Airport	Lesobeng	Lesotho
MSG	Matsaile Airport	Matsaile	Lesotho
MFC	Mafeteng Airport	Mafeteng	Lesotho
MKH	Mokhotlong Airport	Mokhotlong	Lesotho
MSU	Moshoeshoe I International Airport	Maseru	Lesotho
NKU	Nkaus Airport	Nkaus	Lesotho
PEL	Pelaneng Airport	Pelaneng	Lesotho
UTG	Quthing Airport	Quthing	Lesotho
UNE	Qacha's Nek Airport	Qacha's Nek	Lesotho
SHK	Sehonghong Airport	Sehonghong	Lesotho
SKQ	Sekakes Airport	Sekakes	Lesotho
SOK	Semonkong Airport	Semonkong	Lesotho
SHZ	Seshutes Airport	Seshutes	Lesotho
THB	Thaba-Tseka Airport	Thaba-Tseka	Lesotho
TKO	Tlokoeng Airport	Tlokoeng	Lesotho
AIW	Ai-Ais Airport	Ai-Ais	
ADI	Arandis Airport	Arandis	
GOG	Gobabis Airport	Gobabis	
GFY	Grootfontein Airport	Grootfontein	
HAL	Halali Airport	Halali	
KAS	Karasburg Airport	Karasburg	
MPA	Katima Mulilo Airport	Mpacha	
KMP	Keetmanshoop Airport	Keetmanshoop	
LHU	Lianshulu Airport	Lianshulu Lodge	
LUD	Luderitz Airport	Luderitz	
MJO	Mount Etjo Airport	Mount Etjo Safari Lodge	
MQG	Midgard Airport	Midgard	
OKU	Mokuti Lodge Airport	Mokuti Lodge	
NNI	Namutoni Airport	Namutoni	
OND	Ondangwa Airport	Ondangwa	
OMG	Omega Airport	Omega	
OMD	Oranjemund Airport	Oranjemund	
OKF	Okaukuejo Airport	Okaukuejo	
OPW	Opuwa Airport	Opuwa	
OHI	Oshakati Airport	Oshakati	
OTJ	Otjiwarongo Airport	Otjiwarongo	
NDU	Rundu Airport	Rundu	
RHN	Skorpion Mine Airport	Rosh Pinah	
SWP	Swakopmund Municipal Aerodrome	Swakopmund	
SZM	Sesriem Airstrip		
TCY	Terrace Bay Airport	Terrace Bay	
TSB	Tsumeb Airport	Tsumeb	
WVB	Walvis Bay Airport	Walvis Bay	
ERS	Eros Airport	Windhoek	
WDH	Hosea Kutako International Airport	Windhoek	
FIH	Ndjili International Airport	Kinshasa	Congo - Kinshasa
NLO	Ndolo Airport	N'dolo	Congo - Kinshasa
MNB	Muanda Airport	Muanda	Congo - Kinshasa
BOA	Boma Airport	Boma	Congo - Kinshasa
LZI	Luozi Airport	Luozi	Congo - Kinshasa
MAT	Tshimpi Airport	Matadi	Congo - Kinshasa
NKL	N'Kolo-Fuma Airport	N'Kolo-Fuma	Congo - Kinshasa
INO	Inongo Airport	Inongo	Congo - Kinshasa
NIO	Nioki Airport	Nioki	Congo - Kinshasa
FDU	Bandundu Airport	Bandundu	Congo - Kinshasa
KRZ	Kiri Airport	Kiri	Congo - Kinshasa
KKW	Kikwit Airport	Kikwit	Congo - Kinshasa
IDF	Idiofa Airport	Idiofa	Congo - Kinshasa
LUS	Lusanga Airport	Lusanga	Congo - Kinshasa
MSM	Masi Manimba Airport	Masi Manimba	Congo - Kinshasa
MDK	Mbandaka Airport	Mbandaka	Congo - Kinshasa
BSU	Basankusu Airport	Basankusu	Congo - Kinshasa
LIE	Libenge Airport	Libenge	Congo - Kinshasa
BDT	Gbadolite Airport	Gbadolite	Congo - Kinshasa
GMA	Gemena Airport	Gemena	Congo - Kinshasa
KLI	Kotakoli Airbase	Kotakoli	Congo - Kinshasa
BMB	Bumba Airport	Bumba	Congo - Kinshasa
LIQ	Lisala Airport	Lisala	Congo - Kinshasa
BNB	Boende Airport	Boende	Congo - Kinshasa
IKL	Ikela Airport	Ikela	Congo - Kinshasa
FKI	Bangoka International Airport	Kisangani	Congo - Kinshasa
YAN	Yangambi Airport	Yangambi	Congo - Kinshasa
IRP	Matari Airport	Isiro	Congo - Kinshasa
BUX	Bunia Airport	Bunia	Congo - Kinshasa
BZU	Buta Zega Airport	Buta	Congo - Kinshasa
BKY	Bukavu Kavumu Airport	Kamakombe	Congo - Kinshasa
RUE	Rughenda Airfield	Butembo	Congo - Kinshasa
GOM	Goma International Airport	Goma	Congo - Kinshasa
BNC	Beni Airport	Beni	Congo - Kinshasa
KND	Kindu Airport	Kindu	Congo - Kinshasa
KLY	Kinkungwa Airport	Kalima	Congo - Kinshasa
PUN	Punia Airport	Punia	Congo - Kinshasa
FBM	Lubumbashi International Airport	Lubumbashi	Congo - Kinshasa
KEC	Kasenga Airport	Kasenga	Congo - Kinshasa
KWZ	Kolwezi Airport	Kolwezi	Congo - Kinshasa
MNO	Manono Airport	Manono	Congo - Kinshasa
BDV	Moba Airport	Moba	Congo - Kinshasa
FMI	Kalemie Airport	Kalemie	Congo - Kinshasa
KBO	Kabalo Airport	Kabalo	Congo - Kinshasa
KOO	Kongolo Airport	Kongolo	Congo - Kinshasa
KMN	Kamina City Airport	Kamina	Congo - Kinshasa
KAP	Kapanga Airport	Kapanga	Congo - Kinshasa
KNM	Kaniama Airport	Kaniama	Congo - Kinshasa
KGA	Kananga Airport	Kananga	Congo - Kinshasa
LZA	Luiza Airport	Luiza	Congo - Kinshasa
TSH	Tshikapa Airport	Tshikapa	Congo - Kinshasa
LJA	Lodja Airport	Lodja	Congo - Kinshasa
LBO	Lusambo Airport	Lusambo	Congo - Kinshasa
MEW	Mweka Airport	Mweka	Congo - Kinshasa
BAN	Basongo Airport	Basongo	Congo - Kinshasa
PFR	Ilebo Airport	Ilebo	Congo - Kinshasa
MJM	Mbuji Mayi Airport	Mbuji Mayi	Congo - Kinshasa
KBN	Tunta Airport	Kabinda	Congo - Kinshasa
NKA	Nkan Airstrip	Ntoum	Gabon
GIM	Miele Mimbale Airport	Miele Mimbale	Gabon
AKE	Akieni Airport	Akieni	Gabon
GAX	Gamba Airport	Gamba	Gabon
GAB	Gabbs Airport	Gabbs	United States
BKO	Modibo Keita International Airport	Bamako	Mali
GUD	Goundam Airport	Goundam	Mali
GAQ	Gao Airport		Mali
KNZ	Kenieba Airport	Kenieba	Mali
KTX	Koutiala Airport	Koutiala	Mali
KYS	Kayes Dag Dag Airport		Mali
MZI	Mopti Ambodédjo International Airport	Sévaré	Mali
NRM	Nara Airport	Nara	Mali
NIX	Nioro du Sahel Airport	Nioro du Sahel	Mali
KSS	Sikasso Airport	Sikasso	Mali
TOM	Timbuktu Airport	Timbuktu	Mali
EYL	Yélimané Airport	Yélimané	Mali
GAZ	Guasopa Airport	Woodlark (Muyua) Island	Papua New Guinea
DOC	Dornoch Airfield	Dornoch, Sunderland	United Kingdom
FLH	Flotta Isle Airstrip	Flotta Isle	United Kingdom
FOA	Foula Airfield	Foula	United Kingdom
OUK	Out Skerries Airfield	Grunay Island	United Kingdom
PSV	Papa Stour Airport	Papa Stour Island	United Kingdom
ULL	Glenforsa Airfield	Glenforsa	United Kingdom
GBM	Garbaharey Airport	Garbaharey	Somalia
BJL	Banjul International Airport	Banjul	Gambia
FUE	Fuerteventura Airport	El Matorral	Spain
GMZ	La Gomera Airport	Alajero, La Gomera Island	Spain
VDE	El Hierro Airport	El Hierro Island	Spain
SPC	La Palma Airport	Sta Cruz de la Palma, La Palma Island	Spain
LPA	Gran Canaria Airport	Gran Canaria Island	Spain
ACE	César Manrique-Lanzarote Airport	San Bartolomé	Spain
TFS	Tenerife Sur Airport	Tenerife	Spain
GCV	Gravatai Airport	Gravatai	Brazil
TFN	Tenerife Norte-Ciudad de La Laguna Airport	Tenerife	Spain
JCU	Ceuta Heliport	Ceuta	Spain
MLN	Melilla Airport	Melilla	Spain
GEW	Gewoia Airport	Gewoia	Papua New Guinea
OYC	Camopi Airport	Camopi	French Guiana
KBS	Bo Airport	Bo	Sierra Leone
GFD	Pope Field	Greenfield	United States
GBK	Gbangbatok Airport	Gbangbatok	Sierra Leone
HGS	Hastings Airport	Freetown	Sierra Leone
KBA	Kabala Airport	Kabala	Sierra Leone
KEN	Kenema Airport	Kenema	Sierra Leone
FNA	Lungi International Airport	Freetown (Lungi-Town)	Sierra Leone
WYE	Yengema Airport	Yengema	Sierra Leone
BQE	Bubaque Airport	Bubaque	Guinea-Bissau
OXB	Osvaldo Vieira International Airport	Bissau	Guinea-Bissau
GHE	Garachiné Airport	Garachiné	Panama
QCU	Akunnaaq Heliport	Akunnaaq	Greenland
UCN	Buchanan Airport	Buchanan	Liberia
CPA	Cape Palmas Airport	Harper	Liberia
SNI	Greenville/Sinoe Airport	Greenville	Liberia
MLW	Spriggs Payne Airport	Monrovia	Liberia
NIA	Nimba Airport	Nimba	Liberia
GLP	Gulgubip Airport	Gulgubip	Papua New Guinea
ROB	Roberts International Airport	Monrovia	Liberia
SAZ	Sasstown Airport	Sasstown	Liberia
THC	Tchien Airport	Zwedru	Liberia
VOI	Voinjama Airport	Voinjama	Liberia
AGA	Al Massira Airport	Agadir (Temsia)	Morocco
TTA	Tan Tan Airport	Tan Tan	Morocco
UAR	Bouarfa Airport	Bouarfa	Morocco
FEZ	Fes Saïss International Airport	Saïss	Morocco
ERH	Moulay Ali Cherif Airport	Errachidia	Morocco
MEK	Bassatine Airport	Meknes	Morocco
OUD	Oujda Angads Airport	Ahl Angad	Morocco
SMW	Smara Airport	Smara	Western Sahara
GMD	Ben Slimane Airport	Ben Slimane	Morocco
BEM	Beni Mellal Airport	Oulad Yaich	Morocco
RBA	Rabat-Salé Airport	Rabat	Morocco
VIL	Dakhla Airport	Dakhla	Western Sahara
ESU	Essaouira-Mogador Airport	Essaouira	Morocco
EUN	Hassan I Airport	El Aaiún	Western Sahara
CMN	Mohammed V International Airport	Casablanca	Morocco
NDR	Nador Al Aaroui International Airport	Al Aaroui	Morocco
RAK	Menara Airport	Marrakech	Morocco
NNA	Kenitra Air Base	Kenitra	Morocco
OZZ	Ouarzazate Airport	Ouarzazate	Morocco
GMQ	Golog Maqên Airport	Golog (Maqên)	China
AHU	Cherif Al Idrissi Airport	Al Hoceima	Morocco
TTU	Sania Ramel Airport	Tétouan	Morocco
TNG	Tangier Ibn Battuta Airport	Tangier	Morocco
GNU	Goodnews Airport	Goodnews	United States
DSS	Blaise Diagne International Airport	Dakar	Senegal
GOC	Gora Airstrip	Gora	Papua New Guinea
KDA	Kolda/Sare Bidji Airport	Kolda	Senegal
ZIG	Ziguinchor Airport	Ziguinchor	Senegal
CSK	Cap Skirring Airport	Cap Skirring	Senegal
KLC	Kaolack Airport	Kaolack	Senegal
DKR	Léopold Sédar Senghor International Airport	Dakar	Senegal
MAX	Ouro Sogui Airport	Ouro Sogui	Senegal
POD	Podor Airport	Podor	Senegal
RDT	Richard Toll Airport	Richard Toll	Senegal
XLS	Saint Louis Airport	Saint Louis	Senegal
BXE	Bakel Airport	Bakel	Senegal
KGG	Kédougou Airport	Kédougou	Senegal
SMY	Simenti Airport	Simenti	Senegal
TUD	Tambacounda Airport	Tambacounda	Senegal
AEO	Aioun el Atrouss Airport	Aioun El Atrouss	Mauritania
OTL	Boutilimit Airport	Boutilimit	Mauritania
THI	Tichitt Airport	Tichitt	Mauritania
TIY	Tidjikja Airport	Tidjikja	Mauritania
BGH	Abbaye Airport	Boghe	Mauritania
KFA	Kiffa Airport	Kiffa	Mauritania
TMD	Timbedra Airport	Timbedra	Mauritania
EMN	Néma Airport	Néma	Mauritania
AJJ	Akjoujt Airport	Akjoujt	Mauritania
KED	Kaédi Airport	Kaédi	Mauritania
MOM	Letfotar Airport	Moudjeria	Mauritania
NKC	Nouakchott–Oumtounsy International Airport	Nouakchott	Mauritania
SEY	Sélibaby Airport	Sélibaby	Mauritania
THT	Tamchakett Airport	Tamchakett	Mauritania
ATR	Atar International Airport	Atar	Mauritania
FGD	Fderik Airport	Fderik	Mauritania
NDB	Nouadhibou International Airport	Nouadhibou	Mauritania
OUZ	Tazadit Airport	Zouérate	Mauritania
GRC	Grand Cess Airport	Grand Cess	Liberia
GMT	Granite Mountain Air Station	Granite Mountain	United States
CIQ	Chiquimula Airport	Chiquimula	Guatemala
DON	Dos Lagunas Airport	Dos Lagunas	Guatemala
ENJ	El Naranjo Airport	El Naranjo	Guatemala
PCG	Paso Caballos Airport	Paso Caballos	Guatemala
UAX	Uaxactun Airport	Uaxactun	Guatemala
PKJ	Playa Grande Airport	Playa Grande	Guatemala
GTZ	Kirawira B Aerodrome	Grumeti Game Reserve	Tanzania
CKY	Conakry International Airport	Conakry	Guinea
GUE	Guriaso (Keraso) Airport	Guriaso	Papua New Guinea
FIG	Fria Airport	Fria	Guinea
FAA	Faranah Airport	Faranah	Guinea
KSI	Kissidougou Airport	Kissidougou	Guinea
LEK	Tata Airport	Labé	Guinea
MCA	Macenta Airport	Macenta	Guinea
NZE	Nzérékoré Airport	Nzérékoré	Guinea
BKJ	Boké Baralande Airport	Boké	Guinea
SBI	Sambailo Airport	Koundara	Guinea
GII	Siguiri Airport	Siguiri	Guinea
KNN	Kankan Airport	Kankan	Guinea
SID	Amílcar Cabral International Airport	Espargos	Cape Verde
NTO	Agostinho Neto Airport	Ponta do Sol	Cape Verde
BVC	Rabil Airport	Rabil	Cape Verde
GVE	Gordonsville Municipal Airport	Gordonsville	United States
MMO	Maio Airport	Vila do Maio	Cape Verde
MTI	Mosteiros Airport	Vila do Mosteiros	Cape Verde
RAI	Nelson Mandela International Airport	Praia	Cape Verde
SFL	São Filipe Airport	São Filipe	Cape Verde
SNE	Preguiça Airport	Preguiça	Cape Verde
VXE	São Pedro Airport	São Pedro	Cape Verde
BCG	Bemichi Airport	Kumaka	Guyana
BTO	Botopasi Airport	Botopasi	Suriname
DOE	Djumu-Djomoe Airport	Djumu-Djomoe	Suriname
LDO	Ladouanie Airport	Aurora	Suriname
WSO	Washabo Airport	Washabo	Suriname
GZI	Ghazni Airport	Ghazni	Afghanistan
ADD	Addis Ababa Bole International Airport	Addis Ababa	Ethiopia
AMH	Arba Minch Airport	Arba Minch	Ethiopia
AXU	Axum Airport	Axum	Ethiopia
BCO	Baco Airport	Baco	Ethiopia
BJR	Bahir Dar Airport	Bahir Dar	Ethiopia
BEI	Beica Airport	Beica	Ethiopia
DEM	Dembidollo Airport	Dembidollo	Ethiopia
DBM	Debre Markos Airport	Debre Markos	Ethiopia
DIR	Aba Tenna Dejazmach Yilma International Airport	Dire Dawa	Ethiopia
DBT	Debre Tabor Airport	Debre Tabor	Ethiopia
FNH	Fincha Airport	Fincha	Ethiopia
GOB	Robe Airport	Goba	Ethiopia
GNN	Ghinnir Airport	Ghinnir	Ethiopia
GMB	Gambela Airport	Gambela	Ethiopia
GDQ	Gondar Airport	Azezo	Ethiopia
GDE	Gode Airport	Gode	Ethiopia
GOR	Gore Airport	Gore	Ethiopia
QHR	Harar Meda Airport	Debre Zeyit	Ethiopia
HUE	Humera Airport	Akwi	Ethiopia
JIJ	Wilwal International Airport	Jijiga	Ethiopia
JIM	Jimma Airport	Jimma	Ethiopia
ABK	Kebri Dahar Airport	Kebri Dahar	Ethiopia
LFO	Kelafo East Airport	Kelafo	Ethiopia
AWA	Hawassa International Airport	Hawassa	Ethiopia
LLI	Lalibella Airport	Lalibela	Ethiopia
MKS	Mekane Selam Airport	Mekane Selam	Ethiopia
MQX	Alula Aba Nega Airport	Mekelle	Ethiopia
ETE	Metema Airport	Metema	Ethiopia
NDM	Mendi Airport	Mendi	Ethiopia
MUJ	Mui River Airport	Omo National Park	Ethiopia
MTF	Mizan Teferi Airport	Mizan Teferi	Ethiopia
EGL	Negele Airport	Negele Borana	Ethiopia
NEJ	Nejjo Airport	Nejo	Ethiopia
NEK	Nekemte Airport	Nekemte	Ethiopia
PWI	Beles Airport	Pawe	Ethiopia
SXU	Soddu Airport	Soddu	Ethiopia
SKR	Shakiso Airport	Shakiso	Ethiopia
SZE	Semera Airport	Semera	Ethiopia
ASO	Asosa Airport	Asosa	Ethiopia
TIE	Tippi Airport	Tippi	Ethiopia
WRA	Warder Airport	Warder	Ethiopia
HAZ	Hatzfeldhaven Airport	Hatzfeldhaven	Papua New Guinea
BJM	Bujumbura Melchior Ndadaye International Airport	Bujumbura	Burundi
GID	Gitega Airport	Gitega	Burundi
KRE	Kirundo Airport	Kirundo	Burundi
HBQ	Haibei Qilian Airport	Haibei (Qilian)	China
HBT	Hambantota Seaplane Base	Hambantota	Sri Lanka
ALU	Caluula Airport	Caluula	Somalia
BIB	Baidoa Airport	Baidoa	Somalia
CXN	Qandala Airport	Qandala	Somalia
BSY	Baardheere Airport	Baardheere	Somalia
HCM	Eil Airport	Eyl	Somalia
BSA	Bosaso / Bender Qassim International Airport	Bosaso	Somalia
GSR	Gardo Airport	Gardo	Somalia
HGA	Egal International Airport	Hargeisa	Somalia
BBO	Berbera Airport	Berbera	Somalia
LGX	Lugh Ganane Airport	Luuq	Somalia
KMU	Kismayo Airport	Kismayo	Somalia
MGQ	Aden Adde International Airport	Mogadishu	Somalia
BLW	Beledweyne Airport	Beledweyne	Somalia
CMO	Hobyo Airport	Hobyo	Somalia
GLK	Galcaio Airport	Galcaio	Somalia
CMS	Iskushuban Airport	Iskushuban	Somalia
ERA	Erigavo Airport	Erigavo	Somalia
BUO	Burao Airport	Burao	Somalia
GGR	Garowe Airport	Garowe	Somalia
JIB	Djibouti-Ambouli Airport	Djibouti City	Djibouti
AII	Ali-Sabieh Airport	Ali-Sabieh	Djibouti
MHI	Moucha Airport	Moucha Island	Djibouti
OBC	Obock Airport	Obock	Djibouti
TDJ	Tadjoura Airport	Tadjoura	Djibouti
EMY	El Minya Airport	El Minya	Egypt
RDL	Bardawil International Airport	El Hassana	Egypt
SQK	Sidi EL Barrani Airport	Sidi El Barrani	Egypt
DBB	El Alamein International Airport	El Alamein	Egypt
AAC	El Arish International Airport	El Arish	Egypt
ATZ	Asyut International Airport	Asyut	Egypt
HBE	Borj El Arab International Airport	Alexandria	Egypt
ABS	Abu Simbel Airport	Abu Simbel	Egypt
CAI	Cairo International Airport	Cairo	Egypt
CCE	Capital International Airport	New Cairo	Egypt
DAK	Ad Dakhla Airport	Dakhla Oases	Egypt
HRG	Hurghada International Airport	Hurghada	Egypt
EGH	El Jora Airport	El Jora	Egypt
UVL	El Kharja Airport	Kharja Oases	Egypt
LXR	Luxor International Airport	Luxor	Egypt
RMF	Marsa Alam International Airport	Marsa Alam	Egypt
MUH	Marsa Matruh International Airport	Marsa Matruh	Egypt
HEO	Haelogo Airport	Haelogo	Papua New Guinea
GSQ	El Owainat East International Airport	Sharq El Owainat	Egypt
PSD	Port Said International Airport	Port Said	Egypt
SKV	Saint Catherine International Airport	Saint Catherine	Egypt
HMB	Suhaj Mubarak International Airport	Suhaj	Egypt
SSH	Sharm El Sheikh International Airport	Sharm El Sheikh	Egypt
ASW	Aswan International Airport	Aswan	Egypt
SEW	Siwa Oasis North Airport	Siwa Oasis	Egypt
SPX	Sphinx International Airport	Al Jiza	Egypt
TCP	Taba International Airport	Taba	Egypt
ELT	At Tur Airport	At Tur	Egypt
HEY	Hanchey Army (Fort Rucker) Heliport	Fort Rucker Ozark	United States
HGT	Tusi (Hunter Liggett) Army Heliport	Jolon	United States
ASM	Asmara International Airport	Asmara	Eritrea
MSW	Massawa International Airport	Massawa	Eritrea
ASA	Assab International Airport	Asab	Eritrea
TES	Tessenei Airport	Tessenei	Eritrea
HPV	Princeville Airport	Hanalei	United States
WKL	Waikoloa Heliport	Waikoloa Village	United States
HIA	Huai'an Lianshui International Airport	Huai'an	China
HIL	Shilavo Airport	Shilavo	Ethiopia
JUB	Juba International Airport	Juba	South Sudan
ASV	Amboseli Airport	Amboseli National Park	Kenya
HKB	Healy Lake Airport	Healy Lake	United States
EDL	Eldoret International Airport	Eldoret	Kenya
EYS	Eliye Springs Airport	Eliye Springs	Kenya
KLK	Kalokol Airport	Kalokol	Kenya
GAS	Garissa Airport	Garissa	Kenya
HOA	Hola Airport	Hola	Kenya
NBO	Jomo Kenyatta International Airport	Nairobi	Kenya
KEU	Keekorok Airport	Keekorok	Kenya
GGM	Kakamega Airport	Kakamega	Kenya
KIS	Kisumu Airport	Kisumu	Kenya
ILU	Kilaguni Airport	Kilaguni	Kenya
KEY	Kericho Airport	Kericho	Kenya
KTL	Kitale Airport	Kitale	Kenya
LKG	Lokichoggio Airport	Lokichoggio	Kenya
LOK	Lodwar Airport	Lodwar	Kenya
LAU	Manda Airport	Lamu	Kenya
LOY	Loyengalani Airport	Loyengalani	Kenya
NDE	Mandera Airport	Mandera	Kenya
RBT	Marsabit Airport	Marsabit	Kenya
JJM	Mulika Lodge Airport	Meru-Kinna	Kenya
MYD	Malindi Airport	Malindi	Kenya
MBA	Moi International Airport	Mombasa	Kenya
MRE	Mara Serena Lodge Airstrip	Masai Mara	Kenya
OYL	Moyale Airport	Moyale (Lower)	Kenya
NUU	Nakuru Airport	Nakuru	Kenya
WIL	Nairobi Wilson Airport	Nairobi	Kenya
NYK	Nanyuki Airport	Nanyuki	Kenya
UAS	Samburu Airport	Samburu	Kenya
UKA	Ukunda Airstrip	Ukunda	Kenya
WJR	Wajir Airport	Wajir	Kenya
SRX	Sirt International Airport / Ghardabiya Airbase	Sirt	Libya
GHT	Ghat Airport	Ghat	Libya
AKF	Kufra Airport	Kufra	Libya
BEN	Benina International Airport	Benina	Libya
MJI	Mitiga International Airport	Tripoli	Libya
LAQ	Al Abraq International Airport	Al Albraq	Libya
SEB	Sabha Airport	Sabha	Libya
LMQ	Marsa al Brega Airport	Marsa al Brega	Libya
NFR	Nafurah 1 Airport	Nafurah 1	Libya
HUQ	Hon Airport		Libya
LTD	Ghadames East Airport	Ghadames	Libya
TOB	Tobruk International Airport	Adam	Libya
ZIS	Alzintan Airport	Zintan	Libya
WAX	Zuwarah International Airport	Zuwarah	Libya
EDQ	Erandique Airport	Erandique	Honduras
HOO	Nhon Co Airfield	Đăk R'Lấp	Vietnam
HRC	Sary Su Airport	Zhayrem	Kazakhstan
GYI	Gisenyi Airport	Gisenyi	Rwanda
BTQ	Butare Airport	Butare	Rwanda
KGL	Kigali International Airport	Kigali	Rwanda
RHG	Ruhengeri Airport	Ruhengeri	Rwanda
KME	Kamembe Airport	Kamembe	Rwanda
ATB	Atbara Airport	Atbara	Sudan
EDB	Al Dabbah Airport	Al Dabbah	Sudan
DOG	Dongola Airport	Dongola	Sudan
RSS	Damazin Airport	Ad Damazin	Sudan
ELF	El Fasher Airport	El Fasher	Sudan
DNX	Galegu Airport	Dinder	Sudan
EGN	Geneina Airport	Geneina	Sudan
HEG	Heglig Airport	Heglig Oilfield	Sudan
HSJ	Zhengzhou Shangjie Airport	Zhengzhou	China
KSL	Kassala Airport	Kassala	Sudan
GBU	Khashm El Girba Airport	Khashm El Girba	Sudan
KDX	Kadugli Airport	Kadugli	Sudan
RBX	Rumbek Airport	Rumbek	South Sudan
MWE	Merowe Airport	Merowe	Sudan
NUD	En Nahud Airport	En Nahud	Sudan
UYL	Nyala Airport	Nyala	Sudan
NHF	New Halfa Airport	New Halfa	Sudan
EBD	El-Obeid Airport	El-Obeid	Sudan
PZU	Port Sudan New International Airport	Port Sudan	Sudan
KRT	Khartoum International Airport	Khartoum	Sudan
MAK	Malakal Airport	Malakal	South Sudan
WHF	Wadi Halfa Airport	Wadi Halfa	Sudan
WUU	Wau Airport	Wau	South Sudan
ZLX	Zalingei Airport	Zalingei	Sudan
ARK	Arusha Airport	Arusha	Tanzania
BKZ	Bukoba Airport	Bukoba	Tanzania
DAR	Julius Nyerere International Airport	Dar es Salaam	Tanzania
DOD	Dodoma Airport	Dodoma	Tanzania
GTC	Chato/Geita Airport	Chato District	Tanzania
MBI	Songwe Airport	Mbeya	Tanzania
IRI	Iringa Airport	Nduli	Tanzania
TKQ	Kigoma Airport	Kigoma	Tanzania
KIY	Kilwa Airport	Kilwa Masoko	Tanzania
JRO	Kilimanjaro International Airport	Arusha	Tanzania
LDI	Lindi Airport	Lindi	Tanzania
LKY	Lake Manyara Airport	Lake Manyara National Park	Tanzania
HTM	Khatgal Airport	Hatgal	Mongolia
MFA	Mafia Airport	Kilindoni	Tanzania
MWN	Mwadui Airport	Mwadui	Tanzania
XMI	Masasi Airport	Masasi	Tanzania
NPY	Mpanda Airport	Mpanda	Tanzania
QSI	Moshi Airport	Moshi	Tanzania
MYW	Mtwara Airport	Mtwara	Tanzania
MUZ	Musoma Airport	Musoma	Tanzania
MWZ	Mwanza Airport	Mwanza	Tanzania
NCH	Nachingwea Airport	Nachingwea	Tanzania
JOM	Njombe Airport	Njombe	Tanzania
PMA	Pemba Airport	Chake Chake	Tanzania
SEU	Seronera Airport	Seronera	Tanzania
SGX	Songea Airport	Songea	Tanzania
SUT	Sumbawanga Airport	Sumbawanga	Tanzania
SHY	Shinyanga Airport	Shinyanga	Tanzania
TBO	Tabora Airport	Tabora	Tanzania
TGT	Tanga Airport	Tanga	Tanzania
ZNZ	Abeid Amani Karume International Airport	Zanzibar	Tanzania
RUA	Arua Airport	Arua	Uganda
EBB	Entebbe International Airport	Kampala	Uganda
ULU	Gulu Airport	Gulu	Uganda
JIN	Jinja Airport	Jinja	Uganda
PAF	Kabalega Falls Airport	Pakuba	Uganda
KJJ	Kajjansi Airfield	Kampala	Uganda
KSE	Kasese Airport	Kasese	Uganda
MBQ	Mbarara Airport	Mbarara	Uganda
KCU	Masindi Airport	Masindi	Uganda
SRT	Soroti Airport	Soroti	Uganda
TRY	Tororo Airport	Tororo	Uganda
HWA	Hawabango Airport	Hawabango	Papua New Guinea
HWI	Hawk Inlet Seaplane Base	Hawk Inlet	United States
HYL	Hollis Clark Bay Seaplane Base	Hollis	United States
HZU	Chengdu Huaizhou Airport	Chengdu (Jintang)	China
IBI	Iboki Airport	Iboki	Papua New Guinea
IBL	Indigo Bay Lodge Airport	Bazaruto Island	Mozambique
ICO	Sicogon Airstrip	Carles	Philippines
PPJ	Pulau Panjang Airport	Jakarta	Indonesia
JBB	Notohadinegoro Airport	Jember	Indonesia
BWX	Banyuwangi International Airport	Banyuwangi	Indonesia
BXW	Bawean - Harun Thohir Airport	Bawean	Indonesia
ENG	Enggano Airport	Enggano	Indonesia
GYO	Blangkejeren Airport	Kabupaten Gayo Lues	Indonesia
KXB	Sangia Nibandera Airport	Kolaka	Indonesia
DHX	Dhoho International Airport	Kediri	Indonesia
NAM	Namniwel Airport	Namniwel	Indonesia
SQG	Tebelian Airport	Sintang	Indonesia
NBX	Douw Aturure Airport	Nabire	Indonesia
SKJ	Singkawang Airport (under construction)		Indonesia
LKM	Bolaang Mongondow Airport	Lolak	Indonesia
PNW	Amman Mineral Nusa Tenggara Airport (under construction)	Pototano	Indonesia
AAS	Apalapsili Airport	Apalapsili	Indonesia
AGD	Anggi Airport	Anggi-Papua Island	Indonesia
AKQ	Gunung Batin Airport	Astraksetra	Indonesia
AYW	Ayawasi Airport	Ayawasi	Indonesia
BXM	Batom Airport	Batom	Indonesia
DRH	Dabra Airport	Dabra	Indonesia
ELR	Elelim Airport	Elelim	Indonesia
EWE	Ewer Asmat Airport	Agats	Indonesia
GAV	Gag Island Airport	Gag Island	Indonesia
IUL	Ilu Airport	Ilu	Indonesia
KBF	Karubaga Airport	Karubaga	Indonesia
KBX	Kambuaya Airport	Kambuaya-Papua Island	Indonesia
KCD	Kamur Airport	Kamur	Indonesia
KOD	Kotabangun Airport	Kotabangun-Borneo Island	Indonesia
KRC	Departi Parbo Airport	Sungai Penuh	Indonesia
LLN	Kelila Airport	Kelila	Indonesia
LWE	Lembata Wonopito Airport	Nubatukan	Indonesia
LYK	Lunyuk Airport	Lunyuk-Simbawa Island	Indonesia
MSI	Masalembo Airport	Masalembo Island	Indonesia
NAF	Banaina Airport	Banaina-Borneo Island	Indonesia
OBD	Obano Airport	Obano	Indonesia
PWL	Jenderal Besar Soedirman Airport	Purwokerto-Java Island	Indonesia
RAQ	Sugimanuru Airport	Raha	Indonesia
RKI	Mentawai Airport	Sipura Island	Indonesia
TBM	Tumbang Samba Airport	Tumbang Samba-Borneo Island	Indonesia
TMY	Tiom Airport	Tiom-Papua Island	Indonesia
ZEG	Senggo Airport	Senggo-Papua Island	Indonesia
UGU	Bilogai-Sugapa Airport	Sugapa	Indonesia
IDN	Indagen Airport	Indagen	Papua New Guinea
IMA	Iamalele Airport	Iamalele, Fergusson Island	Papua New Guinea
IMG	Inhaminga Airport	Inhaminga	Mozambique
PYG	Pakyong Airport	Pakyong	India
AYJ	Ayodhya Airport	Faizabad	India
VDY	Jindal Vijaynagar Airport	Toranagallu	India
DGH	Deoghar Airport	Deoghar	India
NMI	Navi Mumbai International Airport (under construction)	Navi Mumbai	India
GOX	Manohar International Airport	Mopa	India
RQY	Rashtrakavi Kuvempu Airport	Shimoga	India
HGI	Itanagar Donyi Polo Hollongi Airport	Hollongi	India
UKE	Utkela Airport	Bhawanipatna	India
JGB	Jagdalpur Airport	Jagdalpur	India
NVY	Neyveli Airport	Neyveli	India
RJI	Rajouri Airport	Rajouri	India
TEI	Tezu Airport	Tezu	India
JLG	Jalgaon Airport	Jalgaon	India
INE	Chinde Airport	Chinde	Mozambique
IOK	Iokea Airport	Iokea	Papua New Guinea
IOP	Ioma Airport	Ioma	Papua New Guinea
KHA	Khaneh Airport	Khaneh	Iran
IRU	Iranamadu Seaplane Base	Iranamadu	Sri Lanka
ISG	New Ishigaki Airport	Ishigaki	Japan
ITK	Itokama Airport	Itokama	Papua New Guinea
IVI	Viveros Island Airport	Isla Viveros	Panama
JGD	Daxing'anling Elunchun Airport	Jiagedaqi	China
JIC	Jinchang Jinchuan Airport	Jinchang	China
JIO	Jos Orno Imsula Airport	Tiakur	Indonesia
JIQ	Qianjiang Wulingshan Airport	Qianjiang	China
JJD	Comandante Ariston Pessoa Airport	Cruz	Brazil
JLA	Quartz Creek Airport	Cooper Landing	United States
JMB	Jamba Airport	Jamba	Angola
JNZ	Jinzhou Bay Airport	Jinzhou (Linghai)	China
JOP	Josephstaal Airport	Josephstaal	Papua New Guinea
JPN	Pentagon Army Heliport	Washington DC	United States
JRA	West 30th Street Heliport	New York	United States
JRB	Downtown Manhattan Heliport	New York	United States
JUH	Chizhou Jiuhuashan Airport	Chizhou	China
AMK	Animas Air Park	Durango	United States
BDX	Broadus Airport	Broadus	United States
EUE	Eureka Airport	Eureka	United States
KPT	Jackpot Airport/Hayden Field	Jackpot	United States
RLA	Rolla Downtown Airport	Rolla	United States
FID	Elizabeth Field	Fishers Island	United States
HUD	Humboldt Municipal Airport	Humboldt	United States
TWD	Jefferson County International Airport	Port Townsend	United States
MVM	Kayenta Airport	Kayenta	United States
HCC	Columbia County Airport	Hudson	United States
AHD	Ardmore Downtown Executive Airport	Ardmore	United States
GCW	Grand Canyon West Airport	Peach Springs	United States
CKE	Lampson Field	Lakeport	United States
ROF	Montague-Yreka Rohrer Field	Montague	United States
CNE	Fremont County Airport	Penrose	United States
RSX	Rouses Point Seaplane Base	Rouses Point	United States
COP	Cooperstown-Westville Airport	Cooperstown	United States
CIL	Council Airport	Council	United States
NWH	Parlin Field	Newport	United States
IRB	Iraan Municipal Airport	Iraan	United States
ODM	Garrett County Airport	Accident	United States
GNF	Gansner Field	Quincy	United States
CHZ	Chiloquin State Airport	Chiloquin	United States
LTW	St. Mary's County Regional Airport	California	United States
USC	Union County, Troy Shelton Field	Union	United States
AHF	Arapahoe Municipal Airport	Arapahoe	United States
PCT	Princeton Airport	Princeton/Rocky Hill	United States
CTO	Calverton Executive Airpark	Calverton	United States
NRI	Grand Lake Regional Airport	Afton	United States
GTP	Grants Pass Airport	Grants Pass	United States
NLE	Jerry Tyler Memorial Airport	Niles	United States
GCD	Grand Coulee Dam Airport	Electric City	United States
VLE	Valle Airport	Grand Canyon	United States
FPY	Perry-Foley Airport	Perry	United States
NTJ	Manti-Ephraim Airport	Manti	United States
BWK	Brač Airport	Gornji Humac	Croatia
SBO	Salina Gunnison Airport	Salina	United States
JVI	Central Jersey Regional Airport	Manville	United States
UCE	Eunice Airport	Eunice	United States
GOL	Gold Beach Municipal Airport	Gold Beach	United States
KKT	Kentland Municipal Airport	Kentland	United States
PRW	Prentice Airport	Prentice	United States
EGP	Maverick County Memorial International Airport	Eagle Pass	United States
BLD	Boulder City Municipal Airport	Boulder City	United States
MFH	Mesquite International Airport	Mesquite	United States
ECA	Iosco County Airport	East Tawas	United States
FMU	Florence Municipal Airport	Florence	United States
OTS	Anacortes Airport	Anacortes	United States
ROL	Roosevelt Municipal Airport	Roosevelt	United States
CTK	Canton Municipal Airport	Canton	United States
WPO	North Fork Valley Airport	Paonia	United States
ATE	Antlers Municipal Airport	Antlers	United States
ASQ	Austin Airport	Austin	United States
AAF	Apalachicola Regional Airport	Apalachicola	United States
ABE	Lehigh Valley International Airport	Allentown	United States
ABI	Abilene Regional Airport	Abilene	United States
ABQ	Albuquerque International Sunport	Albuquerque	United States
ABR	Aberdeen Regional Airport	Aberdeen	United States
ABY	Southwest Georgia Regional Airport	Albany	United States
ACB	Antrim County Airport	Bellaire	United States
ACK	Nantucket Memorial Airport	Nantucket	United States
ACT	Waco Regional Airport	Waco	United States
ACV	California Redwood Coast-Humboldt County Airport	Arcata/Eureka	United States
ACY	Atlantic City International Airport	Atlantic City	United States
ADG	Lenawee County Airport	Adrian	United States
ADT	Ada Regional Airport	Ada	United States
ADM	Ardmore Municipal Airport	Ardmore	United States
ADS	Addison Airport	Dallas	United States
ADW	Joint Base Andrews	Camp Springs	United States
KAE	Kake Seaplane Base	Kake	United States
AEL	Albert Lea Municipal Airport	Albert Lea	United States
AEX	Alexandria International Airport	Alexandria	United States
KAF	Karato Airport	Karato	Papua New Guinea
AFF	USAF Academy Airfield	Colorado Springs	United States
WSG	Washington County Airport	Washington	United States
AFN	Jaffrey Airfield Silver Ranch Airport	Jaffrey	United States
AFO	Afton Municipal Airport	Afton	United States
AFW	Perot Field/Fort Worth Alliance Airport	Fort Worth	United States
AGC	Allegheny County Airport	Pittsburgh	United States
AGO	Magnolia Municipal Airport / Ralph C Weiser Field	Magnolia	United States
AGS	Augusta Regional At Bush Field	Augusta	United States
AHC	Amedee Army Air Field	Herlong	United States
AHH	Amery Municipal Airport	Amery	United States
AHN	Athens Ben Epps Airport	Athens	United States
AIA	Alliance Municipal Airport	Alliance	United States
AID	Anderson Municipal Darlington Field	Anderson	United States
AIK	Aiken Regional Airport	Aiken	United States
AIO	Atlantic Municipal Airport	Atlantic	United States
AIV	George Downer Airport	Aliceville	United States
AIZ	Lee C Fine Memorial Airport	Kaiser Lake Ozark	United States
KAK	Kar Airport	Kar	Papua New Guinea
AKO	Colorado Plains Regional Airport	Akron	United States
AKC	Akron Fulton International Airport	Akron	United States
ALB	Albany International Airport	Albany	United States
ALI	Alice International Airport	Alice	United States
ALM	Alamogordo White Sands Regional Airport	Alamogordo	United States
ALN	St Louis Regional Airport	Alton/St Louis	United States
ALO	Waterloo Regional Airport	Waterloo	United States
ALS	San Luis Valley Regional Airport/Bergman Field	Alamosa	United States
ALW	Walla Walla Regional Airport	Walla Walla	United States
ALX	Thomas C Russell Field	Alexander City	United States
AMA	Rick Husband Amarillo International Airport	Amarillo	United States
AMN	Gratiot Community Airport	Alma	United States
AMW	Ames Municipal Airport	Ames	United States
ANB	Anniston Regional Airport	Anniston	United States
AND	Anderson Regional Airport	Anderson	United States
SLT	Salida Airport - Harriet Alexander Field	Salida	United States
ANP	Lee Airport	Annapolis	United States
ANQ	Tri State Steuben County Airport	Angola	United States
ANW	Ainsworth Regional Airport	Ainsworth	United States
ANY	Anthony Municipal Airport	Anthony	United States
AOH	Lima Allen County Airport	Lima	United States
AOO	Altoona Blair County Airport	Altoona	United States
APA	Centennial Airport	Denver	United States
APC	Napa County Airport	Napa	United States
APF	Naples Municipal Airport	Naples	United States
APG	Phillips Army Air Field	Aberdeen	United States
APH	Mary Walker LZ Airport	Bowling Green	United States
APN	Alpena County Regional Airport	Alpena	United States
APT	Marion County Airport - Brown Field	Jasper	United States
APV	Apple Valley Airport	Apple Valley	United States
KAQ	Kamulai Airport	Kamulai Mission	Papua New Guinea
ARA	Acadiana Regional Airport	New Iberia	United States
ARB	Ann Arbor Municipal Airport	Ann Arbor	United States
ARG	Walnut Ridge Regional Airport	Walnut Ridge	United States
WHT	Wharton Regional Airport	Wharton	United States
AUZ	Aurora Municipal Airport	Chicago/Aurora	United States
ART	Watertown International Airport	Watertown	United States
ARV	Lakeland Airport Noble F Lee Memorial Field	Woodruff	United States
BFT	Beaufort Executive Airport	Beaufort	United States
ASE	Aspen-Pitkin County Airport (Sardy Field)	Aspen	United States
SPZ	Springdale Municipal Airport	Springdale	United States
ASH	Nashua Airport / Boire Field	Nashua	United States
ASL	Harrison County Airport	Marshall	United States
ASN	Talladega Municipal Airport	Talladega	United States
AST	Astoria Regional Airport	Astoria	United States
ASX	John F Kennedy Memorial Airport	Ashland	United States
ASY	Ashley Municipal Airport	Ashley	United States
ATL	Hartsfield Jackson Atlanta International Airport	Atlanta	United States
ATS	Artesia Municipal Airport	Artesia	United States
ATW	Appleton International Airport	Appleton	United States
ATY	Watertown Regional Airport	Watertown	United States
AUG	Augusta State Airport	Augusta	United States
AUM	Austin Municipal Airport	Austin	United States
AUN	Auburn Municipal Airport	Auburn	United States
AUO	Auburn University Regional Airport	Auburn	United States
AUS	Austin Bergstrom International Airport	Austin	United States
AUW	Wausau Downtown Airport	Wausau	United States
AVL	Asheville Regional Airport	Asheville	United States
AVO	Avon Park Executive Airport	Avon Park	United States
AVP	Wilkes Barre Scranton International Airport	Wilkes-Barre/Scranton	United States
AVW	Marana Regional Airport	Marana	United States
AVX	Catalina Airport	Avalon	United States
AWM	West Memphis Municipal Airport	West Memphis	United States
AXG	Algona Municipal Airport	Algona	United States
AXN	Chandler Field	Alexandria	United States
AXS	Altus Quartz Mountain Regional Airport	Altus	United States
AXV	Neil Armstrong Airport	Wapakoneta	United States
AXX	Angel Fire Airport	Angel Fire	United States
AYS	Waycross Ware County Airport	Waycross	United States
TUH	Arnold Air Force Base	Manchester	United States
AZO	Kalamazoo Battle Creek International Airport	Kalamazoo	United States
BAB	Beale Air Force Base	Beale Air Force Base	United States
BAD	Barksdale Air Force Base	Bossier City	United States
BAF	Westfield-Barnes Regional Airport	Westfield	United States
CLU	Columbus Municipal Airport	Columbus	United States
BAM	Battle Mountain Airport	Battle Mountain	United States
BBB	Benson Municipal Airport	Benson	United States
BBD	Curtis Field	Brady	United States
BKG	Branson Airport	Branson	United States
BTN	Marlboro County Jetport - H E Avent Field Airport	Bennettsville	United States
BBW	Broken Bow Municipal Airport	Broken Bow	United States
BCB	Virginia Tech Montgomery Executive Airport	Blacksburg	United States
BCE	Bryce Canyon Airport	Bryce Canyon	United States
BCT	Boca Raton Airport	Boca Raton	United States
BDE	Baudette International Airport	Baudette	United States
BDG	Blanding Municipal Airport	Blanding	United States
BDL	Bradley International Airport	Hartford	United States
BDR	Igor I Sikorsky Memorial Airport	Bridgeport	United States
WBU	Boulder Municipal Airport	Boulder	United States
KBE	Bell Island Hot Springs Seaplane Base	Bell Island	United States
BEC	Beech Factory Airport	Wichita	United States
BED	Laurence G Hanscom Field	Bedford	United States
BEH	Southwest Michigan Regional Airport	Benton Harbor	United States
BFD	Bradford Regional Airport	Bradford	United States
BFF	Western Neb. Rgnl/William B. Heilig Airport	Scottsbluff	United States
BFI	Boeing Field King County International Airport	Seattle	United States
BFL	Meadows Field	Bakersfield	United States
BFM	Mobile Downtown Airport	Mobile	United States
BFR	Virgil I Grissom Municipal Airport	Bedford	United States
BGD	Hutchinson County Airport	Borger	United States
BGE	Decatur County Industrial Air Park	Bainbridge	United States
BGM	Greater Binghamton/Edwin A Link field	Binghamton	United States
BGR	Bangor International Airport	Bangor	United States
KBH	Kahama Airstrip	Kahama	Tanzania
BHB	Hancock County-Bar Harbor Airport	Bar Harbor	United States
BHM	Birmingham-Shuttlesworth International Airport	Birmingham	United States
BID	Block Island State Airport	Block Island	United States
BIE	Beatrice Municipal Airport	Beatrice	United States
BIF	Biggs Army Air Field (Fort Bliss)	Fort Bliss/El Paso	United States
BIH	Eastern Sierra Regional Airport	Bishop	United States
BIL	Billings Logan International Airport	Billings	United States
BIS	Bismarck Municipal Airport	Bismarck	United States
BIX	Keesler Air Force Base	Biloxi	United States
BJC	Rocky Mountain Metropolitan Airport	Denver	United States
BJI	Bemidji Regional Airport	Bemidji	United States
BJJ	Wayne County Airport	Wooster	United States
BKD	Stephens County Airport	Breckenridge	United States
BKE	Baker City Municipal Airport	Baker City	United States
BFK	Buckley Space Force Base	Aurora	United States
BKL	Burke Lakefront Airport	Cleveland	United States
BKT	Allen C Perkinson Blackstone Army Air Field	Blackstone	United States
BKW	Raleigh County Memorial Airport	Beaver	United States
BKX	Brookings Regional Airport	Brookings	United States
BLF	Mercer County Airport	Bluefield	United States
BLH	Blythe Airport	Blythe	United States
BLI	Bellingham International Airport	Bellingham	United States
BLM	Monmouth Executive Airport	Belmar/Farmingdale	United States
BLU	Blue Canyon Nyack Airport	Emigrant Gap	United States
BLV	Scott AFB/Midamerica Airport	Belleville	United States
KBM	Kabwum		Papua New Guinea
BMC	Brigham City Regional Airport	Brigham City	United States
BMG	Monroe County Airport	Bloomington	United States
BMI	Central Illinois Regional Airport at Bloomington-Normal	Bloomington/Normal	United States
BML	Berlin Regional Airport	Berlin	United States
BMT	Beaumont Municipal Airport	Beaumont	United States
BNA	Nashville International Airport	Nashville	United States
BNG	Banning Municipal Airport	Banning	United States
BNL	Barnwell Regional Airport	Barnwell	United States
BNO	Burns Municipal Airport	Burns	United States
BNW	Boone Municipal Airport	Boone	United States
BOI	Boise Air Terminal/Gowen Field	Boise	United States
BOS	Logan International Airport	Boston	United States
BOW	Bartow Executive Airport	Bartow	United States
HCA	Big Spring Mc Mahon-Wrinkle Airport	Big Spring	United States
BPI	Miley Memorial Field	Big Piney	United States
WMH	Ozark Regional Airport	Mountain Home	United States
BPT	Jack Brooks Regional Airport	Beaumont/Port Arthur	United States
BQK	Brunswick Golden Isles Airport	Brunswick	United States
BRD	Brainerd Lakes Regional Airport	Brainerd	United States
BRL	Southeast Iowa Regional Airport	Burlington	United States
BRO	Brownsville South Padre Island International Airport	Brownsville	United States
BRY	Samuels Field	Bardstown	United States
KBT	Kaben Airport	Kaben	Marshall Islands
BTF	Skypark Airport	Bountiful	United States
BTL	Battle Creek Executive Airport at Kellogg Field	Battle Creek	United States
BTM	Bert Mooney Airport	Butte	United States
TTO	Britton Municipal Airport	Britton	United States
BTP	Pittsburgh/Butler Regional Airport	Butler	United States
BTR	Baton Rouge Metropolitan Airport	Baton Rouge	United States
BTV	Burlington International Airport	South Burlington	United States
BTY	Beatty Airport	Beatty	United States
BUB	Cram Field	Burwell	United States
BUF	Buffalo Niagara International Airport	Buffalo	United States
BUM	Butler Memorial Airport	Butler	United States
BUR	Hollywood Burbank Airport	Burbank	United States
BFP	Beaver County Airport	Beaver Falls	United States
BVO	Bartlesville Municipal Airport	Bartlesville	United States
MVW	Skagit Regional Airport	Burlington	United States
BVX	Batesville Regional Airport	Batesville	United States
BVY	Beverly Regional Airport	Beverly / Danvers	United States
BWC	Brawley Municipal Airport	Brawley	United States
BWD	Brownwood Regional Airport	Brownwood	United States
BWG	Bowling Green Warren County Regional Airport	Bowling Green	United States
BWI	Baltimore/Washington International Thurgood Marshall Airport	Baltimore	United States
WAH	Harry Stern Airport	Wahpeton	United States
BWM	Bowman Regional Airport	Bowman	United States
BXA	George R Carr Memorial Air Field	Bogalusa	United States
BXK	Buckeye Municipal Airport	Buckeye	United States
BYG	Johnson County Airport	Buffalo	United States
BYH	Arkansas International Airport	Blytheville	United States
BYI	Burley Municipal Airport	Burley	United States
BYS	Bicycle Lake Army Air Field	Fort Irwin/Barstow	United States
BBC	Bay City Regional Airport	Bay City	United States
BZN	Bozeman Yellowstone International Airport	Bozeman	United States
XES	Grand Geneva Resort Airport	Lake Geneva	United States
PLY	Plymouth Municipal Airport	Plymouth	United States
CLG	New Coalinga Municipal Airport	Coalinga	United States
CAD	Wexford County Airport	Cadillac	United States
CAE	Columbia Metropolitan Airport	Columbia	United States
CIG	Craig Moffat Airport	Craig	United States
CAK	Akron Canton Regional Airport	Akron	United States
CAO	Clayton Municipal Airpark	Clayton	United States
CAR	Caribou Municipal Airport	Caribou	United States
CBE	Greater Cumberland Regional Airport	Wiley Ford	United States
CBF	Council Bluffs Municipal Airport	Council Bluffs	United States
CBK	Shalz Field	Colby	United States
CBM	Columbus Air Force Base	Columbus	United States
KCC	Coffman Cove Seaplane Base	Coffman Cove	United States
CCB	Upland-Cable Airport	Upland	United States
CCR	Buchanan Field	Concord	United States
CCY	Northeast Iowa Regional Airport	Charles City	United States
LLX	Caledonia County Airport	Lyndonville	United States
CDC	Cedar City Regional Airport	Cedar City	United States
CDH	Harrell Field	Camden	United States
CDN	Woodward Field	Camden	United States
CDR	Chadron Municipal Airport	Chadron	United States
CDS	Childress Municipal Airport	Childress	United States
CDW	Essex County Airport	Caldwell	United States
CEA	Cessna Aircraft Field	Wichita	United States
CEC	Jack Mc Namara Field Airport	Crescent City	United States
CEF	Westover Metropolitan Airport / Westover Air Reserve Base	Chicopee	United States
CEU	Oconee County Regional Airport	Clemson	United States
CEV	Mettel Field	Connersville	United States
CEW	Bob Sikes Airport	Crestview	United States
CEY	Murray-Calloway County Airport Kyle-Oakley Field	Murray	United States
CEZ	Cortez Municipal Airport	Cortez	United States
CFD	Coulter Field	Bryan	United States
TZC	Tuscola Area Airport	Caro	United States
CFT	Greenlee County Airport	Clifton	United States
CFV	Coffeyville Municipal Airport	Coffeyville	United States
CGE	Cambridge Dorchester Airport	Cambridge	United States
CGF	Cuyahoga County Airport	Cleveland	United States
CGI	Cape Girardeau Regional Airport	Cape Girardeau	United States
CGS	College Park Airport	College Park	United States
CGZ	Casa Grande Municipal Airport	Casa Grande	United States
CHA	Chattanooga Metropolitan Airport (Lovell Field)	Chattanooga	United States
CHK	Chickasha Municipal Airport	Chickasha	United States
CHO	Charlottesville Albemarle Airport	Charlottesville	United States
CHS	Charleston International Airport	Charleston	United States
CIC	Chico Regional Airport	Chico	United States
CID	The Eastern Iowa Airport	Cedar Rapids	United States
CIN	Arthur N Neu Airport	Carroll	United States
CIR	Cairo Regional Airport	Cairo	United States
CIU	Chippewa County International Airport	Kincheloe	United States
CKA	Kegelman AF Aux Field	Cherokee	United States
CKB	North Central West Virginia Airport	Bridgeport	United States
GRM	Grand Marais Cook County Airport	Grand Marais	United States
CKM	Fletcher Field	Clarksdale	United States
CKN	Crookston Municipal Kirkwood Field	Crookston	United States
CKV	Clarksville–Montgomery County Regional Airport	Clarksville	United States
KCL	Chignik Lagoon Airport	Chignik Flats	United States
CLE	Cleveland Hopkins International Airport	Cleveland	United States
CLI	Clintonville Municipal Airport	Clintonville	United States
CLK	Clinton Regional Airport	Clinton	United States
CLL	Easterwood Field	College Station	United States
CLM	William R Fairchild International Airport	Port Angeles	United States
CLR	Cliff Hatfield Memorial Airport	Calipatria	United States
CLS	Chehalis Centralia Airport	Chehalis	United States
CLT	Charlotte Douglas International Airport	Charlotte	United States
CLW	Clearwater Air Park	Clearwater	United States
CMH	John Glenn Columbus International Airport	Columbus	United States
CMI	University of Illinois Willard Airport	Savoy	United States
CMX	Houghton County Memorial Airport	Hancock	United States
CMY	Sparta Fort McCoy Airport	Sparta	United States
KCN	Chernofski Harbor Seaplane Base	Chernofski Harbor	United States
CNH	Claremont Municipal Airport	Claremont	United States
CNK	Blosser Municipal Airport	Concordia	United States
CNM	Cavern City Air Terminal	Carlsbad	United States
CNO	Chino Airport	Chino	United States
CNU	Chanute Martin Johnson Airport	Chanute	United States
CNW	TSTC Waco Airport	Waco	United States
CNY	Canyonlands Regional Airport	Moab	United States
COD	Yellowstone Regional Airport	Cody	United States
COE	Coeur D'Alene Airport - Pappy Boyington Field	Coeur d'Alene	United States
COF	Patrick Space Force Base	Cocoa Beach	United States
COI	Merritt Island Airport	Merritt Island	United States
COM	Coleman Municipal Airport	Coleman	United States
CON	Concord Municipal Airport	Concord	United States
COS	City of Colorado Springs Municipal Airport	Colorado Springs	United States
COT	Cotulla-La Salle County Airport	Cotulla	United States
COU	Columbia Regional Airport	Columbia	United States
CPM	Compton Woodley Airport	Compton	United States
CPR	Casper-Natrona County International Airport	Casper	United States
CPS	St Louis Downtown Airport	Cahokia/St Louis	United States
HCW	Cheraw Municipal Airport/Lynch Bellinger Field	Cheraw	United States
KCR	Colorado Creek Airport	Colorado Creek	United States
CRE	Grand Strand Airport	North Myrtle Beach	United States
CRG	Jacksonville Executive at Craig Airport	Jacksonville	United States
CRO	Corcoran Airport	Corcoran	United States
CRP	Corpus Christi International Airport	Corpus Christi	United States
CLD	McClellan-Palomar Airport	Carlsbad	United States
CRS	C David Campbell Field Corsicana Municipal Airport	Corsicana	United States
CRT	Z M Jack Stell Field	Crossett	United States
CRW	Yeager Airport	Charleston	United States
CRX	Roscoe Turner Airport	Corinth	United States
CSG	Columbus Metropolitan Airport	Columbus	United States
CSM	Clinton Sherman Airport	Clinton	United States
CSQ	Creston Municipal Airport	Creston	United States
CSV	Crossville Memorial Airport Whitson Field	Crossville	United States
CTB	Cut Bank International Airport	Cut Bank	United States
CTY	Cross City Airport	Cross City	United States
CTZ	Sampson County Airport	Clinton	United States
CUB	Jim Hamilton L.B. Owens Airport	Columbia	United States
CUH	Cushing Municipal Airport	Cushing	United States
CVG	Cincinnati Northern Kentucky International Airport	Cincinnati / Covington	United States
CKK	Sharp County Regional Airport	Ash Flat	United States
CVN	Clovis Municipal Airport	Clovis	United States
CVO	Corvallis Municipal Airport	Corvallis	United States
CVS	Cannon Air Force Base	Clovis	United States
CWA	Central Wisconsin Airport	Mosinee	United States
KIP	Kickapoo Downtown Airport	Wichita Falls	United States
CWF	Chennault International Airport	Lake Charles	United States
CWI	Clinton Municipal Airport	Clinton	United States
CXL	Calexico International Airport	Calexico	United States
CXO	Conroe-North Houston Regional Airport	Houston	United States
CSN	Carson Airport	Carson City	United States
HAR	Capital City Airport	Harrisburg	United States
CYS	Cheyenne Regional Jerry Olson Field	Cheyenne	United States
CZT	Dimmit County Airport	Carrizo Springs	United States
VEX	Tioga Municipal Airport	Tioga	United States
DAA	Davison Army Air Field	Fort Belvoir	United States
DAB	Daytona Beach International Airport	Daytona Beach	United States
DAG	Barstow Daggett Airport	Daggett	United States
DAL	Dallas Love Field	Dallas	United States
DAN	Danville Regional Airport	Danville	United States
LRS	Leros Airport	Leros Island	Greece
DAY	James M Cox Dayton International Airport	Dayton	United States
DBN	W H 'Bud' Barron Airport	Dublin	United States
DBQ	Dubuque Regional Airport	Dubuque	United States
DCA	Ronald Reagan Washington National Airport	Washington	United States
DCU	Pryor Field Regional Airport	Decatur	United States
DDC	Dodge City Regional Airport	Dodge City	United States
DEC	Decatur Airport	Decatur	United States
DEH	Decorah Municipal Airport	Decorah	United States
DEN	Denver International Airport	Denver	United States
DET	Coleman A. Young Municipal Airport	Detroit	United States
DFI	Defiance Memorial Airport	Defiance	United States
DFW	Dallas Fort Worth International Airport	Dallas-Fort Worth	United States
DGL	Douglas Municipal Airport	Douglas	United States
DGW	Converse County Airport	Douglas	United States
DHN	Dothan Regional Airport	Dothan	United States
DHT	Dalhart Municipal Airport	Dalhart	United States
DIK	Dickinson Theodore Roosevelt Regional Airport	Dickinson	United States
DKK	Chautauqua County-Dunkirk Airport	Dunkirk	United States
DLL	Dillon County Airport	Dillon	United States
DLF	Laughlin Air Force Base	Del Rio	United States
DLH	Duluth International Airport	Duluth	United States
DLN	Dillon Airport	Dillon	United States
DLS	Columbia Gorge Regional Airport	Dallesport / The Dalles	United States
DMA	Davis Monthan Air Force Base	Tucson	United States
DMN	Deming Municipal Airport	Deming	United States
DMO	Sedalia Memorial Airport	Sedalia	United States
DNL	Daniel Field	Augusta	United States
DNN	Dalton Municipal Airport	Dalton	United States
DNS	Denison Municipal Airport	Denison	United States
DNV	Vermilion Regional Airport	Danville	United States
DOV	Dover Air Force Base	Dover	United States
KDP	Kandep Airport	Kandep	Papua New Guinea
DPA	Dupage Airport	Chicago/West Chicago	United States
DPG	Michael AAF (Dugway Proving Ground) Airport	Dugway Proving Ground	United States
KDQ	Kamberatoro Airport	Kamberatoro Mission	Papua New Guinea
DRA	Desert Rock Airport	Mercury	United States
DRI	Beauregard Regional Airport	DeRidder	United States
DRE	Drummond Island Airport	Drummond Island	United States
DRO	Durango La Plata County Airport	Durango	United States
DRT	Del Rio International Airport	Del Rio	United States
KDS	Kamaran Downs Airport	Kamaran Downs	Australia
DSM	Des Moines International Airport	Des Moines	United States
DSV	Dansville Municipal Airport	Dansville	United States
DTA	Delta Municipal Airport	Delta	United States
DTL	Detroit Lakes Airport	Detroit Lakes	United States
DTN	Shreveport Downtown Airport	Shreveport	United States
DSI	Destin Executive Airport	Destin	United States
DTW	Detroit Metropolitan Wayne County Airport	Detroit	United States
DUA	Durant Regional Airport - Eaker Field	Durant	United States
DUC	Halliburton Field	Duncan	United States
DUG	Bisbee Douglas International Airport	Douglas Bisbee	United States
DUJ	DuBois Regional Airport	Dubois	United States
DVL	Devils Lake Regional Airport	Devils Lake	United States
DVN	Davenport Municipal Airport	Davenport	United States
NOT	Marin County Airport - Gnoss Field	Novato	United States
NSL	Slayton Municipal Airport	Slayton	United States
DVT	Phoenix Deer Valley Airport	Phoenix	United States
KDW	Victoria Reservoir Seaplane Base	Kandy	Sri Lanka
DWH	David Wayne Hooks Memorial Airport	Houston	United States
DXR	Danbury Municipal Airport	Danbury	United States
DYL	Doylestown Airport	Doylestown	United States
DYS	Dyess Air Force Base	Abilene	United States
KDZ	Polgolla Reservoir Seaplane Base	Kandy	Sri Lanka
LBN	Lake Baringo (Kampi Ya Samaki) Airport	Lake Baringo	Kenya
VPG	Vipingo Estate Airport	Vipingo Estate	Kenya
KTJ	Kichwa Tembo Airport	Kichwa Tembo	Kenya
OSJ	Ol Seki Airstrip		Kenya
OLG	Olare Orok Airfield		Kenya
HKR	Mara North Conservancy Airstrip	Mara	Kenya
ANA	Angama Airport	Maasai Mara	Kenya
MDR	Musiara Airstrip	Musiara	Kenya
OLX	Olkiombo Airport	Olkiombo	Kenya
KRV	Kerio Valley Airport	Kimwarer	Kenya
KIU	Kiunga Airport	Kiunga	Kenya
LBK	Liboi Airport	Liboi	Kenya
LKU	Lake Rudolf Airport	Kalokol	Kenya
MUM	Mumias Airport	Mumias	Kenya
MIF	Roy Hurd Memorial Airport	Monahans	United States
CCG	Crane County Airport	Crane	United States
ESO	Ohkay Owingeh Airport	Espanola	United States
WTR	Whiteriver Airport	Whiteriver	United States
ALE	Alpine Casparis Municipal Airport	Alpine	United States
BGT	Bagdad Airport	Bagdad	United States
EAN	Phifer Airfield	Wheatland	United States
EAR	Kearney Regional Airport	Kearney	United States
EAT	Pangborn Memorial Airport	Wenatchee	United States
EAU	Chippewa Valley Regional Airport	Eau Claire	United States
KEB	Nanwalek Airport	Nanwalek	United States
EBS	Webster City Municipal Airport	Webster City	United States
ECG	Elizabeth City Regional Airport & Coast Guard Air Station	Elizabeth City	United States
ECP	Northwest Florida Beaches International Airport	Panama City Beach	United States
ECS	Mondell Field	Newcastle	United States
EDE	Northeastern Regional Airport	Edenton	United States
ETS	Enterprise Municipal Airport	Enterprise	United States
EDW	Edwards Air Force Base	Edwards	United States
EED	Needles Airport	Needles	United States
EEN	Dillant Hopkins Airport	Keene	United States
EFD	Ellington Airport	Houston	United States
EFK	Northeast Kingdom International Airport	Newport	United States
EFW	Jefferson Municipal Airport	Jefferson	United States
KEG	Keglsugl Airport	Denglagu Mission	Papua New Guinea
EGE	Eagle County Regional Airport	Eagle	United States
EGI	Duke Field	Crestview	United States
EGV	Eagle River Union Airport	Eagle River	United States
KEK	Ekwok Airport	Ekwok	United States
EKA	Murray Field	Eureka	United States
EKI	Elkhart Municipal Airport	Elkhart	United States
EKN	Elkins-Randolph County Regional Airport	Elkins	United States
EKO	Elko Regional Airport	Elko	United States
EKX	Addington Field / Elizabethtown Regional Airport	Elizabethtown	United States
ELA	Eagle Lake Airport	Eagle Lake	United States
ELD	South Arkansas Regional Airport at Goodwin Field	El Dorado	United States
ELK	Elk City Regional Business Airport	Elk City	United States
ELM	Elmira Corning Regional Airport	Elmira/Corning	United States
ELN	Bowers Field	Ellensburg	United States
LYU	Ely Municipal Airport	Ely	United States
ELP	El Paso International Airport	El Paso	United States
ELY	Ely Airport Yelland Field	Ely	United States
ELZ	Wellsville Municipal Airport - Tarantine Field	Wellsville	United States
EMM	Kemmerer Municipal Airport	Kemmerer	United States
EMP	Emporia Municipal Airport	Emporia	United States
EMT	San Gabriel Valley Airport	El Monte	United States
END	Vance Air Force Base	Enid	United States
ENL	Centralia Municipal Airport	Centralia	United States
ENV	Wendover Airport	Wendover	United States
ENW	Kenosha Regional Airport	Kenosha	United States
EOK	Keokuk Municipal Airport	Keokuk	United States
EOS	Neosho Hugh Robinson Airport	Neosho	United States
EPH	Ephrata Municipal Airport	Ephrata	United States
EDK	Captain Jack Thomas El Dorado Airport	El Dorado	United States
ERI	Erie International Tom Ridge Field	Erie	United States
ERR	Errol Airport	Errol	United States
ERV	Kerrville / Kerr County Airport at Louis Schreiner Field	Kerrville	United States
ESC	Delta County Airport	Escanaba	United States
ESF	Esler Army Airfield / Esler Regional Airport	Alexandria	United States
ESN	Easton Airport / Newnam Field	Easton	United States
EST	Estherville Municipal Airport	Estherville	United States
ESW	Easton State Airport	Easton	United States
ETB	West Bend Municipal Airport	West Bend	United States
ETN	Eastland Municipal Airport	Eastland	United States
EUF	Weedon Field	Eufaula	United States
EUG	Mahlon Sweet Field	Eugene	United States
EVM	Eveleth–Virginia Municipal Airport	Eveleth	United States
EVV	Evansville Regional Airport	Evansville	United States
EVW	Evanston-Uinta County Airport-Burns Field	Evanston	United States
EWB	New Bedford Regional Airport	New Bedford	United States
EWK	Newton City-County Airport	Newton	United States
EWN	Coastal Carolina Regional Airport	New Bern	United States
EWR	Newark Liberty International Airport	Newark	United States
KEX	Kanabea Airport	Kanabea	Papua New Guinea
EYW	Key West International Airport	Key West	United States
KEZ	Kelani-Peliyagoda Seaplane Base	Colombo	Sri Lanka
WIB	Wilbarger County Airport	Vernon	United States
RBK	French Valley Airport	Murrieta	United States
FAF	Felker Army Air Field	Newport News (Fort Eustis)	United States
FAM	Farmington Regional Airport	Farmington	United States
FAR	Hector International Airport	Fargo	United States
FAT	Fresno Yosemite International Airport	Fresno	United States
FAY	Fayetteville Regional Airport - Grannis Field	Fayetteville	United States
FBG	Simmons Army Air Field	Fort Bragg	United States
FBL	Faribault Municipal Airport-Liz Wall Strohfus Field	Faribault	United States
FBR	Fort Bridger Airport	Fort Bridger	United States
FBY	Fairbury Municipal Airport	Fairbury	United States
FCH	Fresno Chandler Executive Airport	Fresno	United States
FCM	Flying Cloud Airport	Minneapolis	United States
FCS	Butts AAF (Fort Carson) Air Field	Fort Carson	United States
FCY	Forrest City Municipal Airport	Forrest City	United States
FDK	Frederick Municipal Airport	Frederick	United States
FDR	Frederick Regional Airport	Frederick	United States
FDY	Findlay Airport	Findlay	United States
FEP	Albertus Airport	Freeport	United States
FET	Fremont Municipal Airport	Fremont	United States
FFA	First Flight Airport	Kill Devil Hills	United States
FFL	Fairfield Municipal Airport	Fairfield	United States
FFM	Fergus Falls Municipal Airport - Einar Mickelson Field	Fergus Falls	United States
FFO	Wright-Patterson Air Force Base	Dayton	United States
FFT	Capital City Airport	Frankfort	United States
MSC	Falcon Field	Mesa	United States
FRD	Friday Harbor Airport	Friday Harbor	United States
FHU	Sierra Vista Municipal Airport / Libby Army Air Field	Fort Huachuca / Sierra Vista	United States
FKL	Venango Regional Airport	Franklin	United States
FKN	Franklin Regional Airport	Franklin	United States
FLD	Fond du Lac County Airport	Fond du Lac	United States
FLG	Flagstaff Pulliam International Airport	Flagstaff	United States
FLL	Fort Lauderdale Hollywood International Airport	Fort Lauderdale	United States
FLO	Florence Regional Airport	Florence	United States
FLP	Marion County Regional Airport	Flippin	United States
FLV	Sherman Army Air Field	Fort Leavenworth	United States
FLX	Fallon Municipal Airport	Fallon	United States
FME	Tipton Airport	Fort Meade(Odenton)	United States
FMH	Cape Cod Coast Guard Air Station	Falmouth	United States
FMN	Four Corners Regional Airport	Farmington	United States
FMY	Page Field	Fort Myers	United States
FNL	Northern Colorado Regional Airport	Loveland	United States
FNT	Bishop International Airport	Flint	United States
FOD	Fort Dodge Regional Airport	Fort Dodge	United States
FOE	Topeka Regional Airport	Topeka	United States
FOK	Francis S Gabreski Airport	Westhampton Beach	United States
FIL	Fillmore Municipal Airport	Fillmore	United States
FPR	St Lucie County International Airport	Fort Pierce	United States
FRG	Republic Airport	Farmingdale	United States
FRH	French Lick Municipal Airport	French Lick	United States
FRI	Marshall Army Air Field	Fort Riley (Junction City)	United States
FRM	Fairmont Municipal Airport	Fairmont	United States
FRR	Front Royal Warren County Airport	Front Royal	United States
FSD	Sioux Falls Regional Airport / Joe Foss Field	Sioux Falls	United States
FSI	Henry Post Army Air Field	Fort Sill	United States
FSK	Fort Scott Municipal Airport	Fort Scott	United States
FSM	Fort Smith Regional Airport	Fort Smith	United States
FST	Fort Stockton Pecos County Airport	Fort Stockton	United States
FSU	Fort Sumner Municipal Airport	Fort Sumner	United States
FMS	Fort Madison Municipal Airport	Fort Madison	United States
FTK	Godman Army Air Field	Fort Knox	United States
FTW	Fort Worth Meacham International Airport	Fort Worth	United States
FTY	Fulton County Airport Brown Field	Atlanta	United States
FUL	Fullerton Municipal Airport	Fullerton	United States
WFK	Northern Aroostook Regional Airport	Frenchville	United States
FWA	Fort Wayne International Airport	Fort Wayne	United States
FXE	Fort Lauderdale Executive Airport	Fort Lauderdale	United States
FXY	Forest City Municipal Airport	Forest City	United States
FYM	Fayetteville Municipal Airport	Fayetteville	United States
FYV	Drake Field	Fayetteville	United States
GAD	Northeast Alabama Regional Airport	Gadsden	United States
GAG	Gage Heibeck Airport	Gage	United States
GAI	Montgomery County Airpark	Gaithersburg	United States
GBD	Great Bend Municipal Airport	Great Bend	United States
GBG	Galesburg Municipal Airport	Galesburg	United States
GBR	Walter J. Koladza Airport	Great Barrington	United States
GCC	Northeast Wyoming Regional Airport	Gillette	United States
JDA	Grant County Regional Airport / Ogilvie Field	John Day	United States
GCK	Garden City Regional Airport	Garden City	United States
GCN	Grand Canyon National Park Airport	Grand Canyon - Tusayan	United States
GCY	Greeneville Municipal Airport	Greeneville	United States
GDM	Gardner Municipal Airport	Gardner	United States
GDV	Dawson Community Airport	Glendive	United States
GDW	Gladwin Zettel Memorial Airport	Gladwin	United States
GED	Delaware Coastal Airport	Georgetown	United States
GEG	Spokane International Airport	Spokane	United States
GEY	South Big Horn County Airport	Greybull	United States
GFA	Malmstrom Air Force Base	Great Falls	United States
GFK	Grand Forks International Airport	Grand Forks	United States
GFL	Floyd Bennett Memorial Airport	Glens Falls	United States
GGE	Georgetown County Airport	Georgetown	United States
GGG	East Texas Regional Airport	Longview	United States
GGW	Glasgow Valley County Airport Wokal Field	Glasgow	United States
GHM	Centerville Municipal Airport	Centerville	United States
GIF	Winter Haven Regional Airport - Gilbert Field	Winter Haven	United States
GJT	Grand Junction Regional Airport	Grand Junction	United States
MEJ	Port Meadville Airport	Meadville	United States
GKT	Gatlinburg-Pigeon Forge Airport	Sevierville	United States
GLD	Goodland Municipal Airport	Goodland	United States
GLE	Gainesville Municipal Airport	Gainesville	United States
GLH	Mid Delta Regional Airport	Greenville	United States
GLR	Gaylord Regional Airport	Gaylord	United States
GLS	Scholes International At Galveston Airport	Galveston	United States
GLW	Glasgow Municipal Airport	Glasgow	United States
GMU	Greenville Downtown Airport	Greenville	United States
GNG	Gooding Municipal Airport	Gooding	United States
GNT	Grants-Milan Municipal Airport	Grants	United States
GNV	Gainesville Regional Airport	Gainesville	United States
GOK	Guthrie-Edmond Regional Airport	Guthrie	United States
GON	Groton New London Airport	Groton	United States
FCA	Glacier Park International Airport	Kalispell	United States
GPT	Gulfport Biloxi International Airport	Gulfport	United States
GPZ	Grand Rapids Itasca Co-Gordon Newstrom field	Grand Rapids	United States
GQQ	Galion Municipal Airport	Galion	United States
GRB	Austin Straubel International Airport	Green Bay	United States
GRD	Greenwood County Airport	Greenwood	United States
GRE	Greenville Airport	Greenville	United States
GRF	Gray Army Air Field	Fort Lewis/Tacoma	United States
GRI	Central Nebraska Regional Airport	Grand Island	United States
GRK	Killeen Regional Airport / Robert Gray Army Airfield	Fort Cavazos	United States
GRN	Gordon Municipal Airport	Gordon	United States
GRR	Gerald R. Ford International Airport	Grand Rapids	United States
GSB	Seymour Johnson Air Force Base	Goldsboro	United States
GSH	Goshen Municipal Airport	Goshen	United States
GSO	Piedmont Triad International Airport	Greensboro	United States
GSP	Greenville Spartanburg International Airport	Greer	United States
GTF	Great Falls International Airport	Great Falls	United States
LXS	Limnos Airport	Limnos Island	Greece
GTG	Grantsburg Municipal Airport	Grantsburg	United States
GTR	Golden Triangle Regional Airport	Columbus/W Point/Starkville	United States
GUC	Gunnison Crested Butte Regional Airport	Gunnison	United States
GUP	Gallup Municipal Airport	Gallup	United States
GUS	Grissom Air Reserve Base	Peru	United States
GUY	Guymon Municipal Airport	Guymon	United States
GVL	Lee Gilmer Memorial Airport	Gainesville	United States
GVT	Majors Airport	Greenville	United States
KGW	Kagi Airport	Kagi	Papua New Guinea
GWO	Greenwood–Leflore Airport	Greenwood	United States
GWS	Glenwood Springs Municipal Airport	Glenwood Springs	United States
KGX	Grayling Airport	Grayling	United States
GXY	Greeley–Weld County Airport	Greeley	United States
GDC	Donaldson Field Airport	Greenville	United States
PNX	North Texas Regional Airport Perrin Field	Denison	United States
GYR	Phoenix Goodyear Airport	Goodyear	United States
GYY	Gary Chicago International Airport	Gary	United States
KGZ	Glacier Creek Airport	Glacier Creek	United States
DSY	Dara Sakor International Airport	Ta Noun	Cambodia
HAB	Marion County Rankin Fite Airport	Hamilton	United States
HAF	Half Moon Bay Airport	Half Moon Bay	United States
HAI	Three Rivers Municipal Dr Haines Airport	Three Rivers	United States
HAO	Butler Co Regional Airport - Hogan Field	Hamilton	United States
HBG	Hattiesburg Bobby L Chain Municipal Airport	Hattiesburg	United States
HBR	Hobart Regional Airport	Hobart	United States
HDE	Brewster Field	Holdrege	United States
HDN	Yampa Valley Airport	Hayden	United States
HEE	Thompson-Robbins Airport	West Helena	United States
MNZ	Manassas Regional Airport/Harry P. Davis Field	Manassas	United States
HEZ	Natchez–Adams County Airport / Hardy-Anders Field	Natchez	United States
HFD	Hartford Brainard Airport	Hartford	United States
HFF	Mackall Army Air Field	Hoffman	United States
HGR	Hagerstown Regional Richard A Henson Field	Hagerstown	United States
HHR	Jack Northrop Field Hawthorne Municipal Airport	Hawthorne	United States
HUJ	Stan Stamper Municipal Airport	Hugo	United States
HIB	Range Regional Airport	Hibbing	United States
HIE	Mount Washington Regional Airport	Whitefield	United States
HIF	Hill Air Force Base	Ogden	United States
HII	Lake Havasu City International Airport	Lake Havasu City	United States
HIO	Portland Hillsboro Airport	Portland	United States
HKA	Blytheville Municipal Airport	Blytheville	United States
HKS	Hawkins Field	Jackson	United States
HKY	Hickory Regional Airport	Hickory	United States
HLB	Hillenbrand Industries Airport	Batesville	United States
HLC	Hill City Municipal Airport	Hill City	United States
HLG	Wheeling Ohio County Airport	Wheeling	United States
HLM	Park Township Airport	Holland	United States
HLN	Helena Regional Airport	Helena	United States
HLR	Hood Army Air Field	Fort Cavazos (Killeen)	United States
HMN	Holloman Air Force Base	Alamogordo	United States
HMT	Hemet Ryan Airport	Hemet	United States
HNB	Huntingburg Airport	Huntingburg	United States
HSH	Henderson Executive Airport	Las Vegas	United States
HOB	Lea County Regional Airport	Hobbs	United States
HON	Huron Regional Airport	Huron	United States
HOP	Campbell Army Airfield (Fort Campbell)	Fort Campbell	United States
HOT	Memorial Field Airport	Hot Springs	United States
HOU	William P Hobby Airport	Houston	United States
HPN	Westchester County Airport	White Plains	United States
HPT	Hampton Municipal Airport	Hampton	United States
HPY	Baytown Airport	Baytown	United States
HQM	Bowerman Airport	Hoquiam	United States
HES	Hermiston Municipal Airport	Hermiston	United States
HRL	Valley International Airport	Harlingen	United States
HRO	Boone County Airport	Harrison	United States
HSB	Harrisburg-Raleigh Airport	Harrisburg	United States
HNC	Billy Mitchell Airport	Hatteras	United States
THP	Hot Springs County Airport	Thermopolis	United States
HSI	Hastings Municipal Airport	Hastings	United States
HSP	Ingalls Field	Hot Springs	United States
HST	Homestead ARB Airport	Homestead	United States
HSV	Huntsville International Carl T Jones Field	Huntsville	United States
HTH	Hawthorne Industrial Airport	Hawthorne	United States
HTL	Roscommon County - Blodgett Memorial Airport	Houghton Lake	United States
HTO	Town of East Hampton Airport	East Hampton	United States
HTS	Tri-State Airport / Milton J. Ferguson Field	Huntington	United States
HTW	Lawrence County Airpark	South Point	United States
HUA	Redstone Army Air Field	Redstone Arsnl Huntsville	United States
HUF	Terre Haute Regional Airport, Hulman Field	Terre Haute	United States
HUL	Houlton International Airport	Houlton	United States
HUM	Houma Terrebonne Airport	Houma	United States
HUT	Hutchinson Municipal Airport	Hutchinson	United States
HVE	Hanksville Airport	Hanksville	United States
HVN	Tweed New Haven Airport	New Haven	United States
HVR	Havre City County Airport	Havre	United States
HVS	Hartsville Regional Airport	Hartsville	United States
HWD	Hayward Executive Airport	Hayward	United States
HWO	North Perry Airport	Hollywood	United States
WSH	Brookhaven Calabro Airport	Shirley	United States
HHH	Hilton Head Airport	Hilton Head Island	United States
HYA	Cape Cod Gateway Airport	Hyannis	United States
HYR	Sawyer County Airport	Hayward	United States
HYS	Hays Regional Airport	Hays	United States
HZL	Hazleton Municipal Airport	Hazleton	United States
JFN	Northeast Ohio Regional Airport	Ashtabula	United States
IAB	McConnell Air Force Base	Wichita	United States
IAD	Washington Dulles International Airport	Dulles	United States
IAG	Niagara Falls International Airport	Niagara Falls	United States
IAH	George Bush Intercontinental Houston Airport	Houston	United States
KIB	Ivanof Bay Seaplane Base	Ivanof Bay	United States
ICL	Schenck Field	Clarinda	United States
ICT	Wichita Eisenhower National Airport	Wichita	United States
IDA	Idaho Falls Regional Airport	Idaho Falls	United States
IDG	Ida Grove Municipal Airport	Ida Grove	United States
IDI	Indiana County–Jimmy Stewart Airport	Indiana	United States
IDP	Independence Municipal Airport	Independence	United States
XPR	Pine Ridge Airport	Pine Ridge	United States
IFA	Iowa Falls Municipal Airport	Iowa Falls	United States
IFP	Laughlin Bullhead International Airport	Bullhead City	United States
IGM	Kingman Airport	Kingman	United States
IJX	Jacksonville Municipal Airport	Jacksonville	United States
IKK	Greater Kankakee Airport	Kankakee	United States
KIL	Kilwa Airport	Kilwa	Congo - Kinshasa
ILE	Skylark Field	Killeen	United States
ILG	Wilmington Airport	Wilmington	United States
ILM	Wilmington International Airport	Wilmington	United States
ILN	Wilmington Airpark	Wilmington	United States
IML	Imperial Municipal Airport	Imperial	United States
IMM	Immokalee Regional Airport	Immokalee	United States
MDN	Madison Municipal Airport	Madison	United States
IMT	Ford Airport	Kingsford	United States
IND	Indianapolis International Airport	Indianapolis	United States
INK	Winkler County Airport	Wink	United States
INL	Falls International Airport	International Falls	United States
INS	Creech Air Force Base	Indian Springs	United States
INT	Smith Reynolds Airport	Winston Salem	United States
INW	Winslow Lindbergh Regional Airport	Winslow	United States
IOW	Iowa City Municipal Airport	Iowa City	United States
IPL	Imperial County Airport	Imperial	United States
IPT	Williamsport Regional Airport	Williamsport	United States
KIQ	Kira Airport	Kira	Papua New Guinea
IRK	Kirksville Regional Airport	Kirksville	United States
IRS	Kirsch Municipal Airport	Sturgis	United States
ISM	Kissimmee Gateway Airport	Orlando	United States
ISO	Kinston Regional Jetport At Stallings Field	Kinston	United States
ISP	Long Island Mac Arthur Airport	Islip	United States
ISQ	Schoolcraft County Airport	Manistique	United States
ISW	Alexander Field South Wood County Airport	Wisconsin Rapids	United States
ITH	Ithaca Tompkins Regional Airport	Ithaca	United States
AZA	Phoenix–Mesa Gateway Airport	Mesa	United States
IWD	Gogebic Iron County Airport	Ironwood	United States
ISS	Wiscasset Airport	Wiscasset	United States
IWS	West Houston Airport	Houston	United States
JCI	New Century AirCenter Airport	New Century	United States
IYK	Inyokern Airport	Inyokern	United States
SQA	Santa Ynez Airport	Santa Ynez	United States
FRY	Eastern Slopes Regional Airport	Fryeburg	United States
JAC	Jackson Hole Airport	Jackson	United States
JAN	Jackson-Medgar Wiley Evers International Airport	Jackson	United States
JAS	Jasper County Airport Bell Field	Jasper	United States
JAX	Jacksonville International Airport	Jacksonville	United States
JBR	Jonesboro Municipal Airport	Jonesboro	United States
JCT	Kimble County Airport	Junction	United States
JDN	Jordan Airport	Jordan	United States
JEF	Jefferson City Memorial Airport	Jefferson City	United States
JFK	John F Kennedy International Airport	New York	United States
JHW	Chautauqua County-Jamestown Airport	Jamestown	United States
GUF	Jack Edwards National Airport	Gulf Shores	United States
JLN	Joplin Regional Airport	Joplin	United States
JMS	Jamestown Regional Airport	Jamestown	United States
JOT	Joliet Regional Airport	Joliet	United States
USA	Concord-Padgett Regional Airport	Concord	United States
JKV	Cherokee County Airport	Jacksonville	United States
JST	John Murtha Johnstown Cambria County Airport	Johnstown	United States
JVL	Southern Wisconsin Regional Airport	Janesville	United States
KJX	Kuala Batu Airport	Blangpidie	Indonesia
JXN	Jackson County Airport/Reynolds Field	Jackson	United States
OSB	Grand Glaize Osage Beach Airport	Osage Beach	United States
KKB	Kitoi Bay Seaplane Base	Kitoi Bay	United States
KIC	Mesa Del Rey Airport	King City	United States
KKL	Karluk Lake Seaplane Base	Karluk Lake	United States
KLS	Southwest Washington Regional Airport	Kelso	United States
KNB	Kanab Municipal Airport	Kanab	United States
KKU	Ekuk Airport	Ekuk	United States
DTH	Furnace Creek Airport	Death Valley	United States
BXS	Borrego Valley Airport	Borrego Springs	United States
RBF	Big Bear City Airport	Big Bear	United States
MYH	Marble Canyon Airport	Marble Canyon	United States
TRH	Trona Airport	Trona	United States
LAA	Southeast Colorado Regional Airport	Lamar	United States
LAF	Purdue University Airport	West Lafayette	United States
LAL	Lakeland Linder International Airport	Lakeland	United States
LAM	Los Alamos Airport	Los Alamos	United States
LAN	Capital City Airport	Lansing	United States
LAR	Laramie Regional Airport	Laramie	United States
LAS	Harry Reid International Airport	Las Vegas	United States
LAW	Lawton Fort Sill Regional Airport	Lawton	United States
LAX	Los Angeles International Airport	Los Angeles	United States
LBB	Lubbock Preston Smith International Airport	Lubbock	United States
LBE	Arnold Palmer Regional Airport	Latrobe	United States
LBF	North Platte Regional Airport Lee Bird Field	North Platte	United States
LBL	Liberal Mid-America Regional Airport	Liberal	United States
LBT	Lumberton Regional Airport	Lumberton	United States
LJN	Texas Gulf Coast Regional Airport	Angleton	United States
LCH	Lake Charles Regional Airport	Lake Charles	United States
LCI	Laconia Municipal Airport	Laconia / Gilford	United States
LCK	Rickenbacker International Airport	Columbus	United States
LCQ	Lake City Gateway Airport	Lake City	United States
LDJ	Linden Airport	Linden	United States
LDM	Mason County Airport	Ludington	United States
LEB	Lebanon Municipal Airport	Lebanon	United States
LEE	Leesburg International Airport	Leesburg	United States
LEM	Lemmon Municipal Airport	Lemmon	United States
LEW	Auburn Lewiston Municipal Airport	Auburn/Lewiston	United States
LEX	Blue Grass Airport	Lexington	United States
LFI	Langley Air Force Base	Hampton	United States
LFK	Angelina County Airport	Lufkin	United States
LFT	Lafayette Regional Airport	Lafayette	United States
LGA	LaGuardia Airport	New York	United States
LGB	Long Beach Airport (Daugherty Field)	Long Beach	United States
LGC	LaGrange Callaway Airport	LaGrange	United States
LGD	La Grande/Union County Airport	La Grande	United States
LGF	Laguna Army Airfield	Yuma Proving Ground(Yuma)	United States
LGU	Logan-Cache Airport	Logan	United States
LHV	William T. Piper Memorial Airport	Lock Haven	United States
LIY	MidCoast Regional Airport at Wright Army Airfield	Hinesville	United States
LFN	Triangle North Executive Airport	Louisburg	United States
LIC	Limon Municipal Airport	Limon	United States
LIT	Bill & Hillary Clinton National Airport/Adams Field	Little Rock	United States
LKP	Lake Placid Airport	Lake Placid	United States
LOW	Louisa County Airport / Freeman Field	Louisa	United States
LKV	Lake County Airport	Lakeview	United States
CHL	Challis Airport	Challis	United States
LMS	Louisville Winston County Airport	Louisville	United States
LMT	Crater Lake-Klamath Regional Airport	Klamath Falls	United States
LNA	Palm Beach County Park Airport	West Palm Beach	United States
LND	Hunt Field	Lander	United States
LNK	Lincoln Airport	Lincoln	United States
LNN	Lake County Executive Airport	Willoughby	United States
LNP	Lonesome Pine Airport	Wise	United States
LNR	Tri-County Regional Airport	Spring Green	United States
LNS	Lancaster Airport	Lancaster	United States
LOL	Derby Field	Lovelock	United States
BBX	Wings Field	Philadelphia	United States
LOT	Lewis University Airport	Chicago/Romeoville	United States
LOU	Bowman Field	Louisville	United States
LOZ	London-Corbin Airport/Magee Field	London	United States
LPC	Lompoc Airport	Lompoc	United States
LQK	Pickens County Airport	Pickens	United States
LRD	Laredo International Airport	Laredo	United States
LRF	Little Rock Air Force Base	Jacksonville	United States
LRJ	Le Mars Municipal Airport	Le Mars	United States
LRU	Las Cruces International Airport	Las Cruces	United States
LSB	Lordsburg Municipal Airport	Lordsburg	United States
LSE	La Crosse Regional Airport	La Crosse	United States
LSF	Lawson Army Air Field	Fort Benning	United States
LSK	Lusk Municipal Airport	Lusk	United States
LSN	Los Banos Municipal Airport	Los Banos	United States
LSV	Nellis Air Force Base	Las Vegas	United States
LTS	Altus Air Force Base	Altus	United States
LUF	Luke Air Force Base	Glendale	United States
LUK	Cincinnati Municipal Airport Lunken Field	Cincinnati	United States
LUL	Hesler Noble Field	Laurel	United States
LVK	Livermore Municipal Airport	Livermore	United States
LVL	Brunswick Municipal Airport	Lawrenceville	United States
LVM	Mission Field	Livingston	United States
LVS	Las Vegas Municipal Airport	Las Vegas	United States
LWB	Greenbrier Valley Airport	Lewisburg	United States
LWC	Lawrence Municipal Airport	Lawrence	United States
LWL	Wells Municipal Airport/Harriet Field	Wells	United States
LWM	Lawrence Municipal Airport	Lawrence	United States
LWS	Lewiston Nez Perce County Airport	Lewiston	United States
LWT	Lewistown Municipal Airport	Lewistown	United States
LWV	Lawrenceville Vincennes International Airport	Lawrenceville	United States
LXN	Jim Kelly Field	Lexington	United States
LXV	Lake County Airport	Leadville	United States
LYH	Lynchburg Regional Airport - Preston Glenn Field	Lynchburg	United States
LYO	Lyons-Rice County Municipal Airport	Lyons	United States
LZU	Gwinnett County Briscoe Field	Lawrenceville	United States
PCU	Poplarville Pearl River County Airport	Poplarville	United States
MLK	Malta Airport	Malta	United States
MAC	Macon Downtown Airport	Macon	United States
MAE	Madera Municipal Airport	Madera	United States
MAF	Midland International Air and Space Port	Midland	United States
MAW	Malden Regional Airport	Malden	United States
KMB	Koinambe Airport	Konambe	Papua New Guinea
MBG	Mobridge Municipal Airport	Mobridge	United States
MBL	Manistee County Blacker Airport	Manistee	United States
DXE	Bruce Campbell Field	Madison	United States
MBS	MBS International Airport	Saginaw	United States
MBY	Omar N Bradley Airport	Moberly	United States
MCB	McComb-Pike County Airport / John E Lewis Field	McComb	United States
MCC	McClellan Airfield	Sacramento	United States
MCD	Mackinac Island Airport	Mackinac Island	United States
MCE	Merced Regional Macready Field	Merced	United States
MCF	MacDill Air Force Base	Tampa	United States
MCI	Kansas City International Airport	Kansas City	United States
MCK	McCook Ben Nelson Regional Airport	McCook	United States
MCN	Middle Georgia Regional Airport	Macon	United States
MCO	Orlando International Airport	Orlando	United States
MCW	Mason City Municipal Airport	Mason City	United States
MDA	Martindale Army Heliport	San Antonio	United States
MDD	Midland Airpark	Midland	United States
MDH	Southern Illinois Airport	Murphysboro	United States
XMD	Madison Municipal Airport	Madison	United States
MDT	Harrisburg International Airport	Harrisburg	United States
MDW	Chicago Midway International Airport	Chicago	United States
MDF	Taylor County Airport	Medford	United States
MXE	Laurinburg Maxton Airport	Maxton	United States
MEI	Key Field / Meridian Regional Airport	Meridian	United States
MEM	Memphis International Airport	Memphis	United States
MER	Castle Airport	Merced	United States
MEV	Minden-Tahoe Airport	Minden	United States
UMZ	Mena Intermountain Municipal Airport	Mena	United States
KMF	Kamina Airport	Hoieti	Papua New Guinea
MFD	Mansfield Lahm Regional Airport	Mansfield	United States
MFE	McAllen Miller International Airport	McAllen	United States
MFI	Marshfield Municipal Airport	Marshfield	United States
MFR	Rogue Valley International Medford Airport	Medford	United States
MFV	Accomack County Airport	Melfa	United States
MGC	Michigan City Municipal Airport	Michigan City	United States
MGE	Dobbins Air Reserve Base	Marietta	United States
MGJ	Orange County Airport	Montgomery	United States
MGM	Montgomery Regional (Dannelly Field) Airport	Montgomery	United States
MGR	Moultrie Municipal Airport	Moultrie	United States
MGW	Morgantown Municipal Airport Walter L. (Bill) Hart Field	Morgantown	United States
MGY	Dayton-Wright Brothers Airport	Dayton	United States
MHE	Mitchell Municipal Airport	Mitchell	United States
MHK	Manhattan Regional Airport	Manhattan	United States
MHL	Marshall Memorial Municipal Airport	Marshall	United States
MHR	Sacramento Mather Airport	Sacramento	United States
MHT	Manchester-Boston Regional Airport	Manchester	United States
MHV	Mojave Airport	Mojave	United States
MIA	Miami International Airport	Miami	United States
MIB	Minot Air Force Base	Minot	United States
MIC	Crystal Airport	Minneapolis	United States
MIE	Delaware County Johnson Field	Muncie	United States
MIO	Miami Municipal Airport	Miami	United States
MIT	Shafter Airport - Minter Field	Shafter	United States
MIV	Millville Municipal Airport	Millville	United States
MIW	Marshalltown Municipal Airport	Marshalltown	United States
MJQ	Jackson Municipal Airport	Jackson	United States
MJX	Ocean County Airport	Toms River	United States
MKA	Miller Municipal Airport	Miller	United States
MKC	Charles B. Wheeler Downtown Airport	Kansas City	United States
MKE	General Mitchell International Airport	Milwaukee	United States
MKG	Muskegon County Airport	Muskegon	United States
MKL	McKellar-Sipes Regional Airport	Jackson	United States
MKO	Muskogee-Davis Regional Airport	Muskogee	United States
MKT	Mankato Regional Airport	Mankato	United States
MRK	Marco Island Executive Airport	Marco Island	United States
MLB	Melbourne Orlando International Airport	Melbourne	United States
MLC	Mc Alester Regional Airport	Mc Alester	United States
MLD	Malad City Airport	Malad City	United States
MIQ	Millard Airport	Omaha	United States
MLF	Milford Municipal-Ben and Judy Briscoe Field	Milford	United States
MLI	Quad City International Airport	Moline	United States
MLJ	Baldwin County Regional Airport	Milledgeville	United States
MLS	Miles City Airport - Frank Wiley Field	Miles City	United States
MLT	Millinocket Municipal Airport	Millinocket	United States
MLU	Monroe Regional Airport	Monroe	United States
KMM	Kimaam Airport	Kimaam	Indonesia
MMH	Mammoth Yosemite Airport	Mammoth Lakes	United States
MMI	McMinn County Airport	Athens	United States
MML	Southwest Minnesota Regional Airport - Marshall/Ryan Field	Marshall	United States
MMS	Selfs Airport	Marks	United States
MMT	Mc Entire Joint National Guard Base	Eastover	United States
MMU	Morristown Municipal Airport	Morristown	United States
MNM	Menominee–Marinette Twin County Airport	Menominee	United States
MNN	Marion Municipal Airport	Marion	United States
MOB	Mobile Regional Airport	Mobile	United States
MOD	Modesto City Co-Harry Sham Field	Modesto	United States
MOP	Mount Pleasant Municipal Airport	Mount Pleasant	United States
MOR	Morristown Regional Airport	Morristown	United States
MOT	Minot International Airport	Minot	United States
MOX	Morris Municipal Airport Charlie Schmidt Field	Morris	United States
RMY	Mariposa Yosemite Airport	Mariposa	United States
MPJ	Petit Jean Park Airport	Morrilton	United States
MPO	Pocono Mountains Municipal Airport	Mount Pocono	United States
MPR	Mc Pherson Airport	Mc Pherson	United States
MPV	Edward F Knapp State Airport	Barre/Montpelier	United States
MPZ	Mount Pleasant Municipal Airport	Mount Pleasant	United States
MQB	Macomb Municipal Airport	Macomb	United States
MEO	Dare County Regional Airport	Manteo	United States
CTH	Chester County G O Carlson Airport	Coatesville	United States
MQW	Telfair Wheeler Airport	Mc Rae	United States
MQY	Smyrna Airport	Smyrna	United States
MRB	Eastern WV Regional Airport/Shepherd Field	Martinsburg	United States
MRC	Maury County Airport	Columbia/Mount Pleasant	United States
MRF	Marfa Municipal Airport	Marfa	United States
MRN	Foothills Regional Airport	Morganton	United States
MRY	Monterey Peninsula Airport	Monterey	United States
MSL	Northwest Alabama Regional Airport	Muscle Shoals	United States
MSN	Dane County Regional Truax Field	Madison	United States
MSO	Missoula International Airport	Missoula	United States
MSP	Minneapolis–Saint Paul International Airport / Wold–Chamberlain Field	Minneapolis	United States
MSS	Massena International Airport Richards Field	Massena	United States
MSV	Sullivan County International Airport	Monticello	United States
MSY	Louis Armstrong New Orleans International Airport	New Orleans	United States
MTC	Selfridge Air National Guard Base Airport	Mount Clemens	United States
MTH	The Florida Keys Marathon Airport	Marathon	United States
MTJ	Montrose Regional Airport	Montrose	United States
MTN	Martin State Airport	Baltimore	United States
MTO	Coles County Memorial Airport	Mattoon	United States
MTP	Montauk Airport	Montauk	United States
MTW	Manitowoc County Airport	Manitowoc	United States
MUI	Muir Army Air Field (Fort Indiantown Gap) Airport	Fort Indiantown Gap(Annville)	United States
MUL	Spence Airport	Moultrie	United States
MUO	Mountain Home Air Force Base	Mountain Home	United States
MUT	Muscatine Municipal Airport	Muscatine	United States
MVC	Monroe County Aeroplex Airport	Monroeville	United States
MVE	Montevideo Chippewa County Airport	Montevideo	United States
MVL	Morrisville-Stowe State Airport	Morrisville	United States
MVN	Mount Vernon Outland Airport	Mount Vernon	United States
MVY	Martha's Vineyard Airport	Martha's Vineyard	United States
MWA	Veterans Airport of Southern Illinois	Marion	United States
MWC	Lawrence J Timmerman Airport	Milwaukee	United States
MWH	Grant County International Airport	Moses Lake	United States
MWL	Mineral Wells Regional Airport	Mineral Wells	United States
MWM	Windom Municipal Airport	Windom	United States
MWO	Middletown Regional Airport	Middletown	United States
MXA	Manila Municipal Airport	Manila	United States
MXF	Maxwell Air Force Base	Montgomery	United States
MXO	Monticello Regional Airport	Monticello	United States
KMY	Moser Bay Seaplane Base	Moser Bay	United States
MYF	Montgomery-Gibbs Executive Airport	San Diego	United States
MYL	McCall Municipal Airport	McCall	United States
MYR	Myrtle Beach International Airport	Myrtle Beach	United States
MYV	Yuba County Airport	Marysville	United States
MZJ	Pinal Airpark	Marana	United States
MZZ	Marion Municipal Airport	Marion	United States
CTX	Cortland County Chase Field	Cortland	United States
SXY	Sidney Municipal Airport	Sidney	United States
ONH	Albert S Nader Regional Airport	Oneonta	United States
NBG	New Orleans NAS JRB/Alvin Callender Field	New Orleans	United States
NHX	Naval Outlying Field Barin	Foley	United States
DGN	Dahlgren Naval Surface Warfare Center Airport	Dahlgren	United States
NEL	Lakehurst Maxfield Field Airport	Lakehurst	United States
NEN	Whitehouse Naval Outlying Field	Jacksonville	United States
NEW	Lakefront Airport	New Orleans	United States
NFL	Fallon Naval Air Station	Fallon	United States
FWH	NAS Fort Worth JRB / Carswell Field	Fort Worth	United States
NGP	Naval Air Station Corpus Christi Truax Field	Corpus Christi	United States
NGU	Norfolk Naval Station (Chambers Field)	Norfolk	United States
NGW	Cabaniss Field Naval Outlying Landing Field	Corpus Christi	United States
NHK	Patuxent River Naval Air Station (Trapnell Field)	Patuxent River	United States
NHZ	Brunswick Executive Airport	Brunswick	United States
NIP	Jacksonville Naval Air Station (Towers Field)	Jacksonville	United States
NJK	El Centro NAF Airport (Vraciu Field)	El Centro	United States
NKX	Miramar Marine Corps Air Station - Mitscher Field	San Diego	United States
NLC	Lemoore Naval Air Station (Reeves Field) Airport	Lemoore	United States
NPA	Naval Air Station Pensacola Forrest Sherman Field	Pensacola	United States
NQA	Millington-Memphis Airport	Millington	United States
NQI	Kingsville Naval Air Station	Kingsville	United States
NQX	Naval Air Station Key West/Boca Chica Field	Key West	United States
NRB	Naval Station Mayport / Admiral David L McDonald Field	Jacksonville	United States
NRS	Naval Outlying Field Imperial Beach (Ream Field)	Imperial Beach	United States
NSE	Whiting Field Naval Air Station - North	Milton	United States
NTD	Point Mugu Naval Air Station (Naval Base Ventura Co)	Point Mugu	United States
NTU	Oceana Naval Air Station	Virginia Beach	United States
NUQ	Moffett Federal Airfield	Mountain View	United States
NUW	Whidbey Island Naval Air Station (Ault Field)	Oak Harbor	United States
NVD	Nevada Municipal Airport	Nevada	United States
NYG	Quantico Marine Corps Airfield / Turner Field	Quantico	United States
YUM	Yuma International Airport / Marine Corps Air Station Yuma	Yuma	United States
NZY	North Island Naval Air Station-Halsey Field	San Diego	United States
NVN	Nervino Airport	Beckwourth	United States
COA	Columbia Airport	Columbia	United States
ODC	Oakdale Airport	Oakdale	United States
EYR	Yerington Municipal Airport	Yerington	United States
OAJ	Albert J Ellis Airport	Richlands	United States
OAK	San Francisco Bay Oakland International Airport	Oakland	United States
OAR	Marina Municipal Airport	Marina	United States
OBE	Okeechobee County Airport	Okeechobee	United States
OCF	Ocala International Airport - Jim Taylor Field	Ocala	United States
OCH	A L Mangham Jr. Regional Airport	Nacogdoches	United States
OCW	Warren Field	Washington	United States
ODT	Odessa Schlemeyer Field	Odessa	United States
OEA	O'Neal Airport	Lawrenceville	United States
OEO	L O Simenstad Municipal Airport	Osceola	United States
OFF	Offutt Air Force Base	Omaha	United States
OFK	Karl Stefan Memorial Airport	Norfolk	United States
OGA	Ogallala Municipal Airport Searle Field	Ogallala	United States
OGB	Orangeburg Municipal Airport	Orangeburg	United States
OGD	Ogden Hinckley Airport	Ogden	United States
OGS	Ogdensburg International Airport	Ogdensburg	United States
OIC	Lt Warren Eaton Airport	Norwich	United States
OJC	Johnson County Executive Airport	Olathe	United States
OCN	Oceanside Municipal Airport	Oceanside	United States
OKC	Will Rogers World Airport	Oklahoma City	United States
ODW	AJ Eisenberg Airport	Oak Harbor	United States
OKK	Kokomo Municipal Airport	Kokomo	United States
OKM	Okmulgee Regional Airport	Okmulgee	United States
OKS	Garden County Airport/King Rhiley Field	Oshkosh	United States
WGO	Winchester Regional Airport	Winchester	United States
OLD	Dewitt Field - Old Town Municipal Airport	Old Town	United States
OLE	Cattaraugus County-Olean Airport	Olean	United States
OLF	L M Clayton Airport	Wolf Point	United States
OLM	Olympia Regional Airport	Olympia	United States
OLS	Nogales International Airport	Nogales	United States
OLU	Columbus Municipal Airport	Columbus	United States
OLV	Olive Branch Airport	Olive Branch	United States
OLY	Olney Noble Airport	Olney-Noble	United States
KOM	Komo-Manda Airport	Komo	Papua New Guinea
OMA	Eppley Airfield	Omaha	United States
OMK	Omak Airport	Omak	United States
ONA	Winona Municipal Airport Max Conrad Field	Winona	United States
ONL	O'Neill Municipal Airport–John L Baker Field	O'Neill	United States
ONM	Socorro Municipal Airport	Socorro	United States
ONO	Ontario Municipal Airport	Oregon	United States
ONP	Newport Municipal Airport	Newport	United States
ONT	Ontario International Airport	Ontario	United States
ONY	Olney Municipal Airport	Olney	United States
OOA	Oskaloosa Municipal Airport	Cedar	United States
OPF	Miami-Opa Locka Executive Airport	Miami	United States
OPL	St Landry Parish Ahart Field	Opelousas	United States
NCO	Quonset State Airport	North Kingstown	United States
KOR	Kakoro(Koroko) Airstrip	Kakoro	Papua New Guinea
ORD	Chicago O'Hare International Airport	Chicago	United States
ORF	Norfolk International Airport	Norfolk	United States
ORH	Worcester Regional Airport	Worcester	United States
ORL	Orlando Executive Airport	Orlando	United States
ESD	Orcas Island Airport	Eastsound	United States
MPS	Mount Pleasant Regional Airport	Mount Pleasant	United States
OSC	Oscoda Wurtsmith Airport	Oscoda	United States
OSH	Wittman Regional Airport	Oshkosh	United States
OSU	The Ohio State University Airport - Don Scott Field	Columbus	United States
OSX	Kosciusko Attala County Airport	Kosciusko	United States
OTG	Worthington Municipal Airport	Worthington	United States
OTH	Southwest Oregon Regional Airport	North Bend	United States
OTM	Ottumwa Regional Airport	Ottumwa	United States
OUN	University of Oklahoma Westheimer Airport	Norman	United States
OVE	Oroville Municipal Airport	Oroville	United States
OWA	Owatonna Degner Regional Airport	Owatonna	United States
OWB	Owensboro Daviess County Airport	Owensboro	United States
OWD	Norwood Memorial Airport	Norwood	United States
OWK	Central Maine/Norridgewock Airport	Norridgewock	United States
OCE	Ocean City Municipal Airport	Ocean City	United States
OXC	Waterbury Oxford Airport	Oxford	United States
OXD	Miami University Airport	Oxford	United States
OXR	Oxnard Airport	Oxnard	United States
KOY	Olga Bay Seaplane Base	Olga Bay	United States
STQ	St Marys Municipal Airport	St Marys	United States
OZA	Ozona Municipal Airport	Ozona	United States
OZR	Cairns AAF (Fort Rucker) Air Field	Fort Rucker/Ozark	United States
UJU	Uiju Airport	Uiju	North Korea
YJS	Samjiyŏn Airport	Samjiyŏn	North Korea
RGO	Orang (Chongjin) Airport	Hoemun-ri	North Korea
BSQ	Bisbee Municipal Airport	Bisbee	United States
PXL	Polacca Airport	Polacca	United States
GLB	San Carlos Apache Airport	Globe	United States
HBK	Holbrook Municipal Airport	Holbrook	United States
CWX	Cochise County Airport	Willcox	United States
CTW	Cottonwood Airport	Cottonwood	United States
PAE	Seattle Paine Field International Airport	Everett	United States
PAH	Barkley Regional Airport	Paducah	United States
PAM	Tyndall Air Force Base	Panama City	United States
PJB	Payson Airport	Payson	United States
PAO	Palo Alto Airport	Palo Alto	United States
KPB	Point Baker Seaplane Base	Point Baker	United States
PBF	Pine Bluff Regional Airport, Grider Field	Pine Bluff	United States
PBG	Plattsburgh International Airport	Plattsburgh	United States
PBI	Palm Beach International Airport	West Palm Beach	United States
PVL	Pike County Airport Hatcher Field	Pikeville	United States
PCD	Prairie Du Chien Municipal Airport	Prairie Du Chien	United States
PDK	DeKalb Peachtree Airport	Atlanta	United States
PDT	Eastern Oregon Regional Airport at Pendleton	Pendleton	United States
PDX	Portland International Airport	Portland	United States
KPE	Yapsiei Airport		Papua New Guinea
PEQ	Pecos Municipal Airport	Pecos	United States
PGA	Page Municipal Airport	Page	United States
PGD	Punta Gorda Airport	Punta Gorda	United States
PGR	Kirk Field	Paragould	United States
PGV	Pitt-Greenville Airport	Greenville	United States
PHD	Harry Clever Field	New Philadelphia	United States
PHF	Newport News Williamsburg International Airport	Newport News	United States
ADR	Robert F Swinnie Airport	Andrews	United States
PHK	Palm Beach County Glades Airport	Pahokee	United States
PHL	Philadelphia International Airport	Philadelphia	United States
PHN	St Clair County International Airport	Port Huron	United States
PHP	Philip Airport	Philip	United States
PHT	Henry County Airport	Paris	United States
PHX	Phoenix Sky Harbor International Airport	Phoenix	United States
PIA	General Wayne A. Downing Peoria International Airport	Peoria	United States
PIB	Hattiesburg Laurel Regional Airport	Moselle	United States
PIE	St. Petersburg Clearwater International Airport	Pinellas Park	United States
PIH	Pocatello Regional Airport	Pocatello	United States
PIM	Harris County Airport	Pine Mountain	United States
PIR	Pierre Regional Airport	Pierre	United States
PIT	Pittsburgh International Airport	Pittsburgh	United States
PKB	Mid Ohio Valley Regional Airport	Parkersburg (Williamstown)	United States
PKD	Park Rapids Municipal Airport Konshok Field	Park Rapids	United States
PKF	Park Falls Municipal Airport	Park Falls	United States
KPL	Kapal Airport	Kapal	Papua New Guinea
PLK	M. Graham Clark Downtown Airport	Branson / Hollister	United States
PLN	Pellston Regional Airport of Emmet County Airport	Pellston	United States
PLR	St Clair County Airport	Pell City	United States
PMB	Pembina Municipal Airport	Pembina	United States
PMD	Palmdale Regional Airport / USAF Plant 42 Airport	Palmdale	United States
PMH	Greater Portsmouth Regional Airport	Portsmouth	United States
PPM	Pompano Beach Airpark	Pompano Beach	United States
PWY	Ralph Wenz Field	Pinedale	United States
PNC	Ponca City Regional Airport	Ponca City	United States
PNE	Northeast Philadelphia Airport	Philadelphia	United States
PNN	Princeton Municipal Airport	Princeton	United States
PNS	Pensacola International Airport	Pensacola	United States
POB	Pope Field	Fort Bragg	United States
POC	Brackett Field	La Verne	United States
POE	Polk Army Air Field	Fort Polk	United States
POF	Poplar Bluff Municipal Airport	Poplar Bluff	United States
POH	Pocahontas Municipal Airport	Pocahontas	United States
POU	Dutchess County Airport	Poughkeepsie	United States
POY	Powell Municipal Airport	Powell	United States
PPA	Perry Lefors Field	Pampa	United States
PPF	Tri-City Airport	Parsons	United States
LPO	La Porte Municipal Airport	La Porte	United States
PQI	Presque Isle International Airport	Presque Isle	United States
PGL	Trent Lott International Airport	Pascagoula	United States
KPR	Port Williams Seaplane Base	Port Williams	United States
PRB	Paso Robles Municipal Airport	Paso Robles	United States
PRC	Prescott International Airport - Ernest A. Love Field	Prescott	United States
PRO	Perry Municipal Airport	Perry	United States
PRX	Cox Field	Paris	United States
PSB	Mid-State Regional Airport	Philipsburg	United States
PSC	Tri Cities Airport	Pasco	United States
PSF	Pittsfield Municipal Airport	Pittsfield	United States
PSK	New River Valley Airport	Dublin	United States
PSM	Portsmouth International at Pease Airport	Portsmouth	United States
PSN	Palestine Municipal Airport	Palestine	United States
PGO	Stevens Field	Pagosa Springs	United States
PSP	Palm Springs International Airport	Palm Springs	United States
PSX	Palacios Municipal Airport	Palacios	United States
PTB	Dinwiddie County Airport	Petersburg	United States
PTK	Oakland County International Airport	Pontiac	United States
PTN	Harry P Williams Memorial Airport	Patterson	United States
PTS	Atkinson Municipal Airport	Pittsburg	United States
PTT	Pratt Regional Airport	Pratt	United States
PTV	Porterville Municipal Airport	Porterville	United States
PTW	Heritage Field	Pottstown	United States
PUB	Pueblo Memorial Airport	Pueblo	United States
PUC	Carbon County Regional Airport / Buck Davis Field	Price	United States
PUW	Pullman-Moscow Regional Airport	Pullman	United States
PVC	Provincetown Municipal Airport	Provincetown	United States
PVD	Theodore Francis Green State Airport	Warwick	United States
PVF	Placerville Airport	Placerville	United States
PVU	Provo-Utah Lake International Airport	Provo	United States
PVW	Hale County Airport	Plainview	United States
PWA	Wiley Post Airport	Oklahoma City	United States
PWD	Sher-Wood Airport	Plentywood	United States
PWK	Chicago Executive Airport	Chicago/Prospect Heights/Wheeling	United States
PWM	Portland International Jetport	Portland	United States
PWT	Bremerton National Airport	Bremerton	United States
KPY	Port Bailey Seaplane Base	Port Bailey	United States
PYM	Plymouth Municipal Airport	Plymouth	United States
QKA	Aban Uqua Airportse	KXXQO City	United States
KQL	Kol Airport	Kol	Papua New Guinea
JCJ	Chuja Port Heliport	Chuja, Hach’uja-do (Chujado Islands)	South Korea
RAC	John H Batten Airport	Racine	United States
RAL	Riverside Municipal Airport	Riverside	United States
RAP	Rapid City Regional Airport	Rapid City	United States
RBD	Dallas Executive Airport	Dallas	United States
RBG	Roseburg Regional Airport	Roseburg	United States
RBL	Red Bluff Municipal Airport	Red Bluff	United States
RBW	Lowcountry Regional Airport	Walterboro	United States
RCA	Ellsworth Air Force Base	Rapid City	United States
RCK	H H Coffield Regional Airport	Rockdale	United States
RCR	Fulton County Airport	Rochester	United States
RCT	Nartron Field	Reed City	United States
RDD	Redding Municipal Airport	Redding	United States
RDG	Reading Regional Airport (Carl A Spaatz Field)	Reading	United States
RDM	Roberts Field	Redmond	United States
RDR	Grand Forks Air Force Base	Grand Forks	United States
RDU	Raleigh Durham International Airport	Raleigh/Durham	United States
REO	Rome State Airport	Rome	United States
RFD	Chicago Rockford International Airport	Chicago/Rockford	United States
RFG	Rooke Field	Refugio	United States
RHI	Rhinelander Oneida County Airport	Rhinelander	United States
RHV	Reid-Hillview Airport of Santa Clara County	San Jose	United States
RIC	Richmond International Airport	Richmond	United States
RID	Richmond Municipal Airport	Richmond	United States
RIF	Richfield Municipal Airport	Richfield	United States
RIL	Garfield County Regional Airport	Rifle	United States
RIR	Flabob Airport	Riverside	United States
RIV	March Air Reserve Base	Riverside	United States
RIW	Central Wyoming Regional Airport	Riverton	United States
KRJ	Karawari Airstrip	Amboin	Papua New Guinea
RKD	Knox County Regional Airport	Rockland	United States
RKP	Aransas County Airport	Rockport	United States
RKR	Robert S Kerr Airport	Poteau	United States
RKS	Southwest Wyoming Regional Airport	Rock Springs	United States
RKW	Rockwood Municipal Airport	Rockwood	United States
RLD	Richland Airport	Richland	United States
RME	Griffiss International Airport	Rome	United States
RMG	Richard B Russell Airport	Rome	United States
RNC	Warren County Memorial Airport	Mc Minnville	United States
RND	Randolph Air Force Base	Universal City	United States
RNH	New Richmond Regional Airport	New Richmond	United States
RNO	Reno Tahoe International Airport	Reno	United States
RNT	Renton Municipal Airport	Renton	United States
ROA	Roanoke–Blacksburg Regional Airport	Roanoke	United States
ROC	Frederick Douglass Greater Rochester International Airport	Rochester	United States
ROG	Rogers Municipal Airport-Carter Field	Rogers	United States
ROW	Roswell Air Center Airport	Roswell	United States
ROX	Roseau Municipal Rudy Billberg Field	Roseau	United States
RIE	Rice Lake Regional Airport - Carl's Field	Rice Lake	United States
RPX	Roundup Airport	Roundup	United States
WBR	Roben Hood Airport	Big Rapids	United States
RQO	El Reno Regional Airport	El Reno	United States
RRL	Merrill Municipal Airport	Merrill	United States
RRT	Warroad International Memorial Airport	Warroad	United States
RSL	Russell Municipal Airport	Russell	United States
RSN	Ruston Regional Airport	Ruston	United States
RST	Rochester International Airport	Rochester	United States
RSW	Southwest Florida International Airport	Fort Myers	United States
RTN	Raton Municipal Airport / Crews Field	Raton	United States
KRU	Kerau Airport	Gunim	Papua New Guinea
SRW	Mid-Carolina Regional Airport	Salisbury	United States
RUT	Rutland - Southern Vermont Regional Airport	Rutland	United States
RED	Mifflin County Airport	Reedsville	United States
RVS	Tulsa Riverside Airport	Tulsa	United States
RWF	Redwood Falls Municipal Airport	Redwood Falls	United States
RWI	Rocky Mount Wilson Regional Airport	Rocky Mount	United States
RWL	Rawlins Municipal Airport/Harvey Field	Rawlins	United States
RXE	Rexburg Madison County Airport	Rexburg	United States
RNZ	Jasper County Airport	Rensselaer	United States
AHM	Ashland Municipal Airport Sumner Parker Field	Ashland	United States
BDY	Bandon State Airport	Bandon	United States
SUO	Sunriver Airport	Sunriver	United States
MDJ	Madras Municipal Airport	Madras	United States
PRZ	Prineville Airport	Prineville	United States
IDH	Idaho County Airport	Grangeville	United States
SAA	Shively Field	Saratoga	United States
SAC	Sacramento Executive Airport	Sacramento	United States
SAD	Safford Regional Airport	Safford	United States
SAF	Santa Fe Municipal Airport	Santa Fe	United States
SAN	San Diego International Airport	San Diego	United States
SAR	Sparta Community Airport - Hunter Field	Sparta	United States
SAT	San Antonio International Airport	San Antonio	United States
SAV	Savannah Hilton Head International Airport	Savannah	United States
MQT	Marquette/Sawyer International Airport	Gwinn	United States
SBA	Santa Barbara Municipal Airport	Santa Barbara	United States
SBD	San Bernardino International Airport	San Bernardino	United States
SBM	Sheboygan County Memorial Airport	Sheboygan	United States
SBN	South Bend Regional Airport	South Bend	United States
SBP	San Luis County Regional Airport	San Luis Obispo	United States
SBS	Steamboat Springs Bob Adams Field	Steamboat Springs	United States
SBX	Shelby Airport	Shelby	United States
SBY	Salisbury Ocean City Wicomico Regional Airport	Salisbury	United States
SCB	Scribner State Airport	Scribner	United States
SCH	Schenectady County Airport	Schenectady	United States
SCK	Stockton Metropolitan Airport	Stockton	United States
SDF	Louisville Muhammad Ali International Airport	Louisville	United States
SCF	Scottsdale Airport	Scottsdale	United States
SDM	Brown Field Municipal Airport	San Diego	United States
SDY	Sidney - Richland Regional Airport	Sidney	United States
SEA	Seattle–Tacoma International Airport	Seattle	United States
SEE	Gillespie Field	San Diego/El Cajon	United States
SEF	Sebring Regional Airport	Sebring	United States
SEG	Penn Valley Airport	Selinsgrove	United States
SEM	Craig Field	Selma	United States
SEP	Stephenville Clark Regional Airport	Stephenville	United States
SER	Freeman Municipal Airport	Seymour	United States
SDX	Sedona Airport	Sedona	United States
SFB	Orlando Sanford International Airport	Orlando	United States
SFF	Felts Field	Spokane	United States
SFM	Sanford Seacoast Regional Airport	Sanford	United States
SFO	San Francisco International Airport	San Francisco	United States
SFZ	North Central State Airport	Pawtucket	United States
SGF	Springfield Branson National Airport	Springfield	United States
SGH	Springfield-Beckley Municipal Airport	Springfield	United States
UST	Northeast Florida Regional Airport	St Augustine	United States
SGR	Sugar Land Regional Airport	Houston	United States
SGT	Stuttgart Municipal Airport / Carl Humphrey Field	Stuttgart	United States
SGU	St George Regional Airport	St George	United States
SHD	Shenandoah Valley Regional Airport	Weyers Cave	United States
SHN	Sanderson Field	Shelton	United States
SHR	Sheridan County Airport	Sheridan	United States
SHV	Shreveport Regional Airport	Shreveport	United States
SIK	Sikeston Memorial Municipal Airport	Sikeston	United States
SIV	Sullivan County Airport	Sullivan	United States
SIY	Siskiyou County Airport	Montague	United States
SJC	Norman Y. Mineta San Jose International Airport	San Jose	United States
SJN	St Johns Industrial Air Park	St Johns	United States
SJT	San Angelo Regional Mathis Field	San Angelo	United States
SKA	Fairchild Air Force Base	Spokane	United States
SKF	Lackland Air Force Base	San Antonio	United States
TSM	Taos Regional Airport	Taos	United States
SLB	Storm Lake Municipal Airport	Storm Lake	United States
SLC	Salt Lake City International Airport	Salt Lake City	United States
SLE	Salem-Willamette Valley Airport/McNary Field	Salem	United States
SLG	Smith Field	Siloam Springs	United States
SLK	Adirondack Regional Airport	Saranac Lake	United States
SLN	Salina Municipal Airport	Salina	United States
SLO	Salem–Leckrone Airport	Salem	United States
SLR	Sulphur Springs Municipal Airport	Sulphur Springs	United States
SMD	Smith Field	Fort Wayne	United States
SME	Lake Cumberland Regional Airport	Somerset	United States
SMF	Sacramento International Airport	Sacramento	United States
SMN	Lemhi County Airport	Salmon	United States
SMO	Santa Monica Municipal Airport	Santa Monica	United States
SUM	Sumter Airport	Sumter	United States
SMX	Santa Maria Public Airport Captain G Allan Hancock Field	Santa Maria	United States
SNA	John Wayne Orange County International Airport	Santa Ana	United States
SNK	Winston Field	Snyder	United States
SNL	Shawnee Regional Airport	Shawnee	United States
SNS	Salinas Municipal Airport	Salinas	United States
SNY	Sidney Municipal Airport Lloyd W Carr Field	Sidney	United States
SOP	Moore County Airport	Carthage	United States
SOW	Show Low Regional Airport	Show Low	United States
KSP	Kosipe Airport	Kosipe Mission	Papua New Guinea
SPA	Spartanburg Downtown Memorial Airport	Spartanburg	United States
SPF	Black Hills Airport-Clyde Ice Field	Spearfish	United States
SPG	Albert Whitted Airport	St Petersburg	United States
SPI	Abraham Lincoln Capital Airport	Springfield	United States
SPS	Wichita Falls Municipal Airport / Sheppard Air Force Base	Wichita Falls	United States
SPW	Spencer Municipal Airport	Spencer	United States
SQI	Whiteside County Airport - Joseph H Bittorf Field	Rock Falls	United States
SQL	San Carlos Airport	San Carlos	United States
SRC	Searcy Municipal Airport	Searcy	United States
SRQ	Sarasota Bradenton International Airport	Sarasota/Bradenton	United States
RUI	Sierra Blanca Regional Airport	Alto	United States
SSC	Shaw Air Force Base	Sumter	United States
SSF	Stinson Municipal Airport	San Antonio	United States
SSI	St Simons Island Airport	St Simons Island	United States
STC	Saint Cloud Regional Airport	Saint Cloud	United States
STE	Stevens Point Municipal Airport	Stevens Point	United States
STJ	Rosecrans Memorial Airport	St Joseph	United States
STK	Sterling Municipal Airport	Sterling	United States
STL	St. Louis Lambert International Airport	St Louis	United States
STP	Saint Paul Downtown Holman Field	Saint Paul	United States
STS	Charles M. Schulz Sonoma County Airport	Santa Rosa	United States
SUA	Witham Field	Stuart	United States
SUD	Stroud Municipal Airport	Stroud	United States
SUE	Door County Cherryland Airport	Sturgeon Bay	United States
SUN	Friedman Memorial Airport	Hailey	United States
SUS	Spirit of St Louis Airport	St Louis	United States
SUU	Travis Air Force Base	Fairfield	United States
SUW	Richard I Bong Memorial Airport	Superior	United States
SUX	Sioux Gateway Airport / Brigadier General Bud Day Field	Sioux City	United States
SVC	Grant County Airport	Silver City	United States
SVE	Susanville Municipal Airport	Susanville	United States
SVH	Statesville Regional Airport	Statesville	United States
SVN	Hunter Army Air Field	Savannah	United States
SWF	New York Stewart International Airport	Newburgh	United States
SWO	Stillwater Regional Airport	Stillwater	United States
SWW	Avenger Field	Sweetwater	United States
SYI	Bomar Field Shelbyville Municipal Airport	Shelbyville	United States
SYR	Syracuse Hancock International Airport	Syracuse	United States
SYV	Sylvester Airport	Sylvester	United States
SZL	Whiteman Air Force Base	Knob Noster	United States
TBC	Tuba City Airport	Tuba City	United States
TAD	Perry Stokes Airport	Trinidad	United States
KTB	Thorne Bay Seaplane Base	Thorne Bay	United States
TBN	Waynesville-St. Robert Regional Airport-Forney Field	Fort Leonard Wood	United States
TBR	Statesboro Bulloch County Airport	Statesboro	United States
KTC	Katiola Airport	Katiola	Côte d’Ivoire
TCC	Tucumcari Municipal Airport	Tucumcari	United States
TCL	Tuscaloosa National Airport	Tuscaloosa	United States
TCM	McChord Air Force Base	Tacoma	United States
TCS	Truth or Consequences Municipal Airport	Truth or Consequences	United States
TDO	Ed Carlson Memorial Field South Lewis County Airport	Toledo	United States
TDW	Tradewind Airport	Amarillo	United States
TDZ	Toledo Executive Airport	Toledo	United States
TEB	Teterboro Airport	Teterboro	United States
TEX	Telluride Regional Airport	Telluride	United States
THA	Tullahoma Regional Airport William Northern Field	Tullahoma	United States
THM	Thompson Falls Airport	Thompson Falls	United States
THV	York Airport	Thomasville	United States
TIK	Tinker Air Force Base	Oklahoma City	United States
TIW	Tacoma Narrows Airport	Tacoma	United States
TIX	Space Coast Regional Airport	Titusville	United States
KNT	Kennett Memorial Airport	Kennett	United States
TLH	Tallahassee Regional Airport	Tallahassee	United States
TLR	Mefford Field	Tulare	United States
TMA	Henry Tift Myers Airport	Tifton	United States
TMB	Miami Executive Airport	Miami	United States
OTK	Tillamook Airport	Tillamook	United States
TNP	Twentynine Palms Airport	Twentynine Palms	United States
TNT	Dade Collier Training and Transition Airport	Miami	United States
TNU	Newton Municipal Airport	Newton	United States
XSD	Tonopah Test Range Airport	Tonopah	United States
TOA	Zamperini Field	Torrance	United States
TOC	Toccoa Airport - R.G. Letourneau Field	Toccoa	United States
TOI	Troy Municipal Airport at N Kenneth Campbell Field	Troy	United States
TOL	Eugene F. Kranz Toledo Express Airport	Toledo	United States
TOP	Philip Billard Municipal Airport	Topeka	United States
TOR	Torrington Municipal Airport	Torrington	United States
TPA	Tampa International Airport	Tampa	United States
TPF	Peter O Knight Airport	Tampa	United States
TPH	Tonopah Airport	Tonopah	United States
TPL	Draughon Miller Central Texas Regional Airport	Temple	United States
TRI	Tri-Cities Regional TN/VA Airport	Blountville	United States
TKF	Truckee Tahoe Airport	Truckee	United States
TRL	Terrell Municipal Airport	Terrell	United States
TRM	Jacqueline Cochran Regional Airport	Palm Springs	United States
TRX	Trenton Municipal Airport	Trenton	United States
TSP	Tehachapi Municipal Airport	Tehachapi	United States
TTD	Portland Troutdale Airport	Portland	United States
TTN	Trenton Mercer Airport	Ewing Township	United States
TUL	Tulsa International Airport	Tulsa	United States
TUP	Tupelo Regional Airport	Tupelo	United States
TUS	Tucson International Airport / Morris Air National Guard Base	Tucson	United States
TVC	Cherry Capital Airport	Traverse City	United States
TVF	Thief River Falls Regional Airport	Thief River Falls	United States
TVI	Thomasville Regional Airport	Thomasville	United States
TVL	Lake Tahoe Airport	South Lake Tahoe	United States
TWF	Joslin Field Magic Valley Regional Airport	Twin Falls	United States
TXK	Texarkana Regional Airport (Webb Field)	Texarkana	United States
TYZ	Taylor Airport	Taylor	United States
TYR	Tyler Pounds Regional Airport	Tyler	United States
TYS	McGhee Tyson Airport	Alcoa	United States
BFG	Bullfrog Basin Airport	Bullfrog	United States
NPH	J. Randy McKnight Nephi Municipal Airport	Nephi	United States
RVR	Green River Municipal Airport	Green River	United States
PNU	Panguitch Municipal Airport	Panguitch	United States
ICS	Cascade Airport	Cascade	United States
UBS	Columbus Lowndes County Airport	Columbus	United States
UCY	Everett-Stewart Regional Airport	Union City	United States
UDD	Bermuda Dunes Airport	Bermuda Dunes	United States
UES	Waukesha County Airport	Waukesha	United States
UGN	Waukegan National Airport	Chicago/Waukegan	United States
UIL	Quillayute Airport	Quillayute	United States
UIN	Quincy Regional Airport Baldwin Field	Quincy	United States
IKB	Wilkes County Airport	North Wilkesboro	United States
UKI	Ukiah Municipal Airport	Ukiah	United States
UKT	Quakertown Airport	Quakertown	United States
ULM	New Ulm Municipal Airport	New Ulm	United States
ATO	Ohio University Airport	Albany	United States
UNU	Dodge County Airport	Juneau	United States
SCE	State College Regional Airport	State College	United States
UOS	Franklin County Airport	Sewanee	United States
UOX	University Oxford Airport	Oxford	United States
KUP	Kupiano Airport	Kupiano	Papua New Guinea
LRA	Larissa Air Base	Larissa	Greece
UTM	Tunica Municipal Airport	Tunica	United States
HTV	Huntsville Regional Airport	Huntsville	United States
NPT	Newport State Airport	Newport	United States
UVA	Garner Field	Uvalde	United States
KUX	Kuyol Airport		Papua New Guinea
RKH	Rock Hill - York County Airport	Rock Hill	United States
VAD	Moody Air Force Base	Valdosta	United States
LLY	South Jersey Regional Airport	Lumberton	United States
VBG	Vandenberg Space Force Base	Lompoc	United States
VCT	Victoria Regional Airport	Victoria	United States
VCV	Southern California Logistics Airport	Victorville	United States
VDI	Vidalia Regional Airport	Vidalia	United States
KVE	Kitava Airport	Kitava Island	Papua New Guinea
VEL	Vernal Regional Airport	Vernal	United States
VGT	North Las Vegas Metropolitan International Airport	Las Vegas	United States
VHN	Culberson County Airport	Van Horn	United States
VIH	Rolla National Airport	Vichy	United States
VIS	Visalia Municipal Airport	Visalia	United States
VJI	Virginia Highlands Airport	Abingdon	United States
VKS	Vicksburg Municipal Airport	Vicksburg	United States
VLA	Vandalia Municipal Airport	Vandalia	United States
VLD	Valdosta Regional Airport	Valdosta	United States
VNC	Venice Municipal Airport	Venice	United States
VNY	Van Nuys Airport	Van Nuys	United States
VOK	Volk Field	Camp Douglas	United States
VPS	Destin-Fort Walton Beach Airport	Valparaiso	United States
VPZ	Porter County Municipal Airport	Valparaiso	United States
VQQ	Cecil Airport	Jacksonville	United States
VRB	Vero Beach Regional Airport	Vero Beach	United States
VSF	Hartness State Airport	North Springfield	United States
VTN	Miller Field	Valentine	United States
VYS	Illinois Valley Regional Airport Walter A Duncan Field	Peru	United States
GTY	Gettysburg Regional Airport	Gettysburg	United States
SQV	Sequim Valley Airport	Sequim	United States
PGC	Grant County Airport	Petersburg	United States
WAL	Wallops Flight Facility Airport	Wallops Island	United States
WAY	Greene County Airport	Waynesburg	United States
WBW	Wilkes Barre Wyoming Valley Airport	Wilkes-Barre	United States
WDG	Enid Woodring Regional Airport	Enid	United States
WDR	Barrow County Airport	Winder	United States
KWF	Waterfall Seaplane Base	Waterfall	United States
WHP	Whiteman Airport	Pacoima	United States
WJF	General William J Fox Airfield	Lancaster	United States
WLD	Strother Field	Winfield / Arkansas City	United States
WLW	Willows Glenn County Airport	Willows	United States
WMC	Winnemucca Municipal Airport	Winnemucca	United States
KWP	West Point Village Seaplane Base	West Point	United States
WRB	Robins Air Force Base	Warner Robins	United States
WRI	Mc Guire Air Force Base	Wrightstown	United States
WRL	Worland Municipal Airport	Worland	United States
WST	Westerly State Airport	Westerly	United States
WVI	Watsonville Municipal Airport	Watsonville	United States
WVL	Waterville Robert Lafleur Airport	Waterville	United States
WWD	Cape May County Airport	Wildwood	United States
WWR	West Woodward Airport	Woodward	United States
KWY	Kiwayu Airport	Kiwayu	Kenya
WYS	Yellowstone Airport	West Yellowstone	United States
KYO	Tampa North Aero Park Airport	Tampa	United States
KXA	Kasaan Seaplane Base	Kasaan	United States
XNA	Northwest Arkansas National Airport	Fayetteville/Springdale/Rogers	United States
WBK	West Branch Community Airport	West Branch	United States
YIP	Willow Run Airport	Detroit	United States
YKM	Yakima Air Terminal McAllister Field	Yakima	United States
YKN	Chan Gurney Municipal Airport	Yankton	United States
YNG	Youngstown Warren Regional Airport	Youngstown/Warren	United States
BXY	Baikonur Krayniy Airport	Baikonur	Kazakhstan
USJ	Usharal Airport	Usharal	Kazakhstan
ATX	Atbasar Airport	Atbasar	Kazakhstan
KZB	Zachar Bay Seaplane Base	Zachar Bay	United States
KZF	Kaintiba Airport	Kaintiba	Papua New Guinea
ZPH	Zephyrhills Municipal Airport	Zephyrhills	United States
ZZV	Zanesville Municipal Airport	Zanesville	United States
PGS	Grand Canyon Caverns Airport	Peach Springs	United States
BOR	Bokeo International Airport	Ton Phueng	Laos
LAC	Layang-Layang Airport	Pulau Layang-Layang (Swallow Reef)	Malaysia
NBJ	Dr. Antonio Agostinho Neto International Airport	Luanda (Ícolo e Bengo)	Angola
KFZ	Kukës International Airport	Kukës	Albania
TIA	Tirana International Airport Mother Teresa	Rinas	Albania
BOJ	Burgas Airport	Burgas	Bulgaria
GOZ	Gorna Oryahovitsa Airport	Gorna Oryahovitsa	Bulgaria
LBH	Palm Beach Seaplane Base	Sydney	Australia
LBM	Luabo Airport	Luabo	Mozambique
PDV	Plovdiv International Airport	Plovdiv	Bulgaria
ROU	Ruse Airport	Shtraklevo	Bulgaria
SOF	Sofia Airport	Sofia	Bulgaria
SZR	Stara Zagora Airport	Stara Zagora	Bulgaria
VAR	Varna Airport	Varna	Bulgaria
ECN	Nicosia (Lefkoşa) Ercan International Airport	Tymbou (Kirklar)	Cyprus
LCA	Larnaca International Airport	Larnaca	Cyprus
LCP	Loncopue Airport	Loncopue	Argentina
PFO	Paphos International Airport	Paphos	Cyprus
AKT	RAF Akrotiri	Akrotiri	Cyprus
DBV	Dubrovnik Ruđer Bošković Airport	Čilipi	Croatia
LSZ	Lošinj Airport	Mali Lošinj	Croatia
OSI	Osijek Airport	Klisa	Croatia
PUY	Pula Airport	Pula	Croatia
RJK	Rijeka Airport	Omišalj	Croatia
SPU	Split Airport	Kaštel Štafilić	Croatia
LDW	Lansdowne Airport	Lansdowne Station	Australia
ZAG	Zagreb Franjo Tuđman International Airport	Velika Gorica	Croatia
ZAD	Zadar Airport	Zemunik Donji (Zadar)	Croatia
ABC	Albacete Airport / Los Llanos Air Base	Albacete	Spain
ALC	Alicante-Elche Miguel Hernández Airport	Alicante	Spain
LEI	Almería Airport	Almería	Spain
OVD	Asturias Airport	Ranón	Spain
ODB	Córdoba Airport	Córdoba	Spain
BIO	Bilbao Airport	Bilbao	Spain
RGS	Burgos Airport	Burgos	Spain
BCN	Josep Tarradellas Barcelona-El Prat Airport	Barcelona	Spain
BJZ	Badajoz Airport	Badajoz	Spain
CDT	Castellón-Costa Azahar Airport	Castellón de la Plana	Spain
LCG	A Coruña Airport	Culleredo	Spain
ILD	Lleida-Alguaire Airport	Lleida	Spain
GRO	Girona-Costa Brava Airport	Girona	Spain
GRX	F.G.L. Airport Granada-Jaén Airport	Granada	Spain
HSK	Huesca-Pirineos Airport	Monflorite/Alcalá del Obispo	Spain
IBZ	Ibiza Airport	Ibiza (Eivissa)	Spain
XRY	Jerez Airport	Jerez de la Frontera	Spain
MJV	San Javier Airport	San Javier	Spain
LEN	León Airport	León	Spain
RJL	Logroño-Agoncillo Airport	Logroño	Spain
MAD	Adolfo Suárez Madrid–Barajas Airport	Madrid	Spain
AGP	Málaga-Costa del Sol Airport	Málaga	Spain
MAH	Menorca Airport	Mahón (Maó)	Spain
RMU	Región de Murcia International Airport	Corvera	Spain
OZP	Moron Air Base	Morón	Spain
LEO	Lekoni Airport	Lekoni	Gabon
PMI	Palma de Mallorca Airport	Palma de Mallorca	Spain
PNA	Pamplona Airport	Pamplona	Spain
CQM	Ciudad Real International Airport	Ciudad Real	Spain
REU	Reus Airport	Reus	Spain
ROZ	Rota Naval Station Airport	Rota	Spain
SLM	Salamanca Airport	Salamanca	Spain
EAS	San Sebastián Airport	Hondarribia	Spain
SCQ	Santiago-Rosalía de Castro Airport	Santiago de Compostela	Spain
LEU	Pirineus - la Seu d'Urgel Airport	La Seu d'Urgell Pyrenees and Andorra	Spain
TEV	Teruel Airport	Teruel	Spain
TOJ	Madrid–Torrejón Airport / Torrejón Air Base	Madrid	Spain
VLC	Valencia Airport	Valencia	Spain
VLL	Valladolid Airport	Valladolid	Spain
VIT	Vitoria Airport	Alava	Spain
VGO	Vigo Airport	Vigo	Spain
SDR	Seve Ballesteros-Santander Airport	Santander	Spain
ZAZ	Zaragoza Airport	Zaragoza	Spain
SVQ	Sevilla Airport	Sevilla	Spain
DPE	Dieppe-Saint-Aubin Airport	Saint-Aubin-sur-Scie	France
CQF	Calais-Dunkerque Airport	Marck	France
BYF	Albert-Picardie Airport	Méaulte, Somme	France
LTQ	Le Touquet-Côte d'Opale Airport	Le Touquet-Paris-Plage	France
AGF	Agen-La Garenne Airport	Agen/La Garenne	France
BOD	Bordeaux-Mérignac Airport	Bordeaux/Mérignac	France
EGC	Bergerac Dordogne Périgord Airport	Bergerac/Roumanière	France
CNG	Cognac-Châteaubernard (BA 709) Air Base	Cognac/Châteaubernard	France
LRH	La Rochelle-Île de Ré Airport	La Rochelle/Île de Ré	France
PIS	Poitiers-Biard Airport	Poitiers/Biard	France
MCU	Montluçon-Guéret Airport	Lépaud, Creuse	France
LIG	Limoges Airport	Limoges/Bellegarde	France
NIT	Niort - Marais Poitevin Airport	Niort/Souché	France
TLS	Toulouse-Blagnac Airport	Toulouse/Blagnac	France
PUF	Pau Pyrénées Airport	Pau/Pyrénées (Uzein)	France
LDE	Tarbes-Lourdes-Pyrénées Airport	Tarbes/Lourdes/Pyrénées	France
ANG	Angoulême-Brie-Champniers Airport	Angoulême/Brie/Champniers	France
PGX	Périgueux-Bassillac Airport	Périgueux/Bassillac	France
BIQ	Biarritz-Anglet-Bayonne Airport	Biarritz/Anglet/Bayonne	France
ZAO	Aérodrome de Cahors-Lalbenque	Cahors/Lalbenque	France
LBI	Albi-Le Séquestre Airport	Albi/Le Séquestre	France
DCM	Castres-Mazamet Airport	Castres/Mazamet	France
RDZ	Rodez–Aveyron Airport	Rodez/Marcillac	France
RYN	Royan-Médis Airport	Royan/Médis	France
RCO	Rochefort-Saint-Agnant (BA 721) Airport	Rochefort/Saint-Agnant	France
BIC	Aérodrome de Belle Île	Bangor	France
OUI	Ouessant Airport	Ushant	France
IDY	Île d'Yeu Airport	Île d'Yeu	France
CMR	Colmar-Houssen Airport	Colmar, Haut-Rhin	France
DLE	Dole-Jura Airport	Tavaux, Jura	France
MVV	Megève Altiport	Megève	France
OBS	Aubenas-Ardèche Méridional Airport	Aubenas/Ardèche Méridional	France
LPY	Le Puy-Loudes Airfield	Chaspuzac, Haute-Loire	France
AHZ	Altiport L'Alpe d'Huez - Henri GIRAUD	L'Alpe d'Huez	France
ETZ	Metz-Nancy-Lorraine Airport	Goin	France
ANE	Angers-Loire Airport	Marcé, Maine-et-Loire	France
BIA	Bastia-Poretta Airport	Bastia/Poretta	France
CLY	Calvi-Sainte-Catherine Airport	Calvi/Sainte-Catherine	France
FSC	Figari Sud-Corse Airport	Figari Sud-Corse	France
AJA	Ajaccio-Napoléon Bonaparte Airport	Ajaccio/Napoléon Bonaparte	France
PRP	Propriano Airport	Propriano	France
SOZ	Solenzara (BA 126) Air Base	Solenzara	France
MFX	Méribel Altiport	Les Allues	France
AUF	Auxerre-Branches Airport	Appoigny, Yonne	France
CMF	Chambéry Savoie Mont Blanc Airport	Viviers-du-Lac	France
CFE	Clermont-Ferrand Auvergne Airport	Aulnat, Puy-de-Dôme	France
BOU	Bourges Airport	Bourges, Cher	France
CVF	Courchevel Altiport	Saint-Bon	France
LYS	Lyon Saint-Exupéry Airport	Colombier-Saugnieu, Rhône	France
SYT	Saint-Yan Airport	L'Hôpital-le-Mercier, Saône-et-Loire	France
RNE	Roanne-Renaison Airport	Saint-Léger-sur-Roanne	France
NCY	Annecy Haute-Savoie Mont Blanc Airport	Epagny Metz-Tessy	France
GNB	Grenoble Alpes Isère Airport	Saint-Étienne-de-Saint-Geoirs, Isère	France
VAF	Valence-Chabeuil Airport	Chabeuil, Drôme	France
VHY	Vichy-Charmeil Airport	Charmeil, Allier	France
AUR	Aurillac Airport	Aurillac	France
CHR	Châteauroux-Déols "Marcel Dassault" Airport	Châteauroux/Déols	France
LYN	Lyon Bron Airport	Chassieu, Lyon	France
CEQ	Cannes-Mandelieu Airport	Cannes, Alpes-Maritimes	France
EBU	Saint-Étienne-Bouthéon Airport	Saint-Étienne/Bouthéon	France
CCF	Carcassonne Airport	Carcassonne/Salvaza	France
MRS	Marseille Provence Airport	Marignane, Bouches-du-Rhône	France
NCE	Nice-Côte d'Azur Airport	Nice, Alpes-Maritimes	France
PGF	Perpignan-Rivesaltes (Llabanère) Airport	Perpignan/Rivesaltes	France
CTT	Le Castellet Airport	Le Castellet, Var	France
BAE	Barcelonnette - Saint-Pons Airfield	Le Castellet	France
MPL	Montpellier-Méditerranée Airport	Montpellier/Méditerranée	France
BZR	Béziers-Vias Airport	Béziers/Vias	France
AVN	Avignon-Caumont Airport	Avignon, Vaucluse	France
GAT	Gap-Tallard Airfield	Tallard, Hautes-Alpes	France
MEN	Mende-Brenoux Airfield	Mende/Brénoux	France
SCP	Mont-Dauphin - St-Crépin Airfield		France
BVA	Paris-Beauvais Airport	Tillé	France
EVX	Évreux-Fauville (BA 105) Air Base	Évreux/Fauville	France
LEH	Le Havre-Octeville Airport	Le Havre	France
XCR	Châlons-Vatry Airport	Bussy-Lettrée	France
LSO	Les Sables-d'Olonne Talmont Airport	Les Sables-d'Olonne	France
URO	Rouen Vallée de Seine Airport	Boos	France
TUF	Tours Val de Loire Airport	Tours, Indre-et-Loire	France
CET	Cholet Le Pontreau Airfield	Cholet/Le Pontreau	France
LVA	Laval-Entrammes Airport	Laval, Mayenne	France
ORE	Orléans – Saint-Denis-de-l'Hôtel Airport	Orléans	France
LBG	Paris-Le Bourget Airport	Paris (Le Bourget, Seine-Saint-Denis)	France
CSF	Creil Air Base	Creil	France
CDG	Charles de Gaulle International Airport	Paris (Roissy-en-France, Val-d'Oise)	France
TNF	Toussus-le-Noble Airport	Toussus-le-Noble, Yvelines	France
ORY	Paris-Orly Airport	Paris (Orly, Val-de-Marne)	France
POX	Pontoise-Cormeilles Aerodrome	Cormeilles-en-Vexin, Val-d'Oise	France
VIY	Vélizy-Villacoublay Air Base	Vélizy-Villacoublay, Yvelines	France
NVS	Nevers-Fourchambault Airport	Marzy, Nièvre	France
LIL	Lille Airport	Lesquin	France
HZB	Merville-Calonne Airport	Merville, Nord	France
BES	Brest Bretagne Airport	Brest/Guipavas	France
CER	Cherbourg-Maupertus Airport	Gonneville-Le Theil, Manche	France
DNR	Dinard-Pleurtuit-Saint-Malo Airport	Pleurtuit, Ille-et-Vilaine	France
LBY	La Baule-Escoublac Airport	La Baule-Escoublac	France
GFR	Granville Airport	Bréville-sur-Mer, Manche	France
DOL	Deauville-Normandie Airport	Deauville, Calvados	France
LRT	Lorient South Brittany (Bretagne Sud) Airport	Lorient/Lann/Bihoué	France
EDM	La Roche-sur-Yon Airport	La Roche-sur-Yon/Les Ajoncs	France
LDV	Landivisiau Air Base	Landivisiau	France
CFR	Caen-Carpiquet Airport	Carpiquet, Calvados	France
LME	Le Mans-Arnage Airport	Le Mans, Sarthe	France
RNS	Rennes-Saint-Jacques Airport	Saint-Jacques-de-la-Lande, Ille-et-Vilaine	France
LAI	Lannion-Côte de Granit Airport	Lannion	France
UIP	Quimper-Cornouaille Airport	Quimper/Pluguffan	France
NTE	Nantes Atlantique Airport	Nantes	France
SBK	Saint-Brieuc-Armor Airport	Trémuson, Côtes-d'Armor	France
MXN	Morlaix-Ploujean Airport	Morlaix/Ploujean	France
VNE	Vannes-Meucon Airport	Vannes/Meucon	France
SNR	Saint-Nazaire-Montoir Airport	Saint-Nazaire/Montoir	France
BSL	EuroAirport Basel-Mulhouse-Freiburg	Saint-Louis	France
DIJ	Dijon-Bourgogne Airport	Ouges, Côte-d'Or	France
EPL	Épinal-Mirecourt Airport	Juvaincourt, Vosges	France
BVE	Brive-Souillac	Brive la Gaillarde	France
ENC	Nancy-Essey Airport	Tomblaine, Meurthe-et-Moselle	France
SXB	Strasbourg Airport	Strasbourg	France
TLN	Toulon-Hyères Airport	Hyères, Var	France
RZV	Rize–Artvin Airport	Rize	Turkey
FNI	Nîmes-Arles-Camargue Airport	Nîmes/Garons	France
LTT	La Môle-Saint-Tropez Airport	La Môle, Var	France
MQC	Miquelon Airport	Miquelon	St. Pierre & Miquelon
FSP	St Pierre Airport	Saint-Pierre	St. Pierre & Miquelon
PYR	Andravida Air Base	Andravida	Greece
AXD	Alexandroupoli Democritus Airport	Alexandroupolis	Greece
ATH	Athens Eleftherios Venizelos International Airport	Spata-Artemida	Greece
VOL	Nea Anchialos National Airport	Nea Anchialos	Greece
LGE	Mulan Airport	Lake Gregory	Australia
JKH	Chios Island National Airport	Chios Island	Greece
JIK	Ikaria Airport	Ikaria Island	Greece
IOA	Ioannina King Pyrrhus National Airport	Ioannina	Greece
HER	Heraklion International Nikos Kazantzakis Airport	Heraklion	Greece
KSO	Kastoria National Airport Aristotle	Argos Orestiko	Greece
KIT	Kithira Airport	Kithira Island	Greece
EFL	Kefallinia Airport	Kefallinia Island	Greece
KZS	Kastelorizo Airport	Kastelorizo Island	Greece
KLX	Kalamata Airport	Kalamata	Greece
KGS	Kos Airport	Kos Island	Greece
AOK	Karpathos Airport	Karpathos Island	Greece
CFU	Corfu Ioannis Kapodistrias International Airport	Kerkyra (Corfu)	Greece
KSJ	Kasos Airport	Kasos Island	Greece
KVA	Kavala Alexander the Great International Airport	Kavala	Greece
JKL	Kalymnos Airport	Kalymnos Island	Greece
KZI	Kozani National Airport Filippos	Kozani	Greece
JMK	Mykonos Island National Airport	Mykonos	Greece
MLO	Milos Airport	Milos Island	Greece
MJT	Mytilene International Airport	Mytilene	Greece
LGN	Linga Linga Airport	Linga Linga	Papua New Guinea
JNX	Naxos Island National Airport	Naxos	Greece
DRP	Bicol International Airport	Legazpi	Philippines
PAS	Paros National Airport	Paros	Greece
JTY	Astypalaia Airport	Astypalaia Island	Greece
PVK	Aktion National Airport	Preveza	Greece
RHO	Diagoras Airport	Rhodes	Greece
GPA	Patras Araxos Agamemnon Airport	Patras	Greece
CHQ	Chania International Airport	Souda	Greece
JSI	Skiathos Island National Airport	Skiathos	Greece
SMI	Samos Airport	Samos Island	Greece
JSY	Syros Airport	Syros Island	Greece
SPJ	Sparti Airfield	Sparti	Greece
JTR	Santorini Airport	Santorini Island	Greece
JSH	Sitia Airport	Crete Island	Greece
SKU	Skiros Airport	Skiros Island	Greece
SKG	Thessaloniki Macedonia International Airport	Thessaloniki	Greece
ZTH	Zakynthos International Airport Dionysios Solomos	Zakynthos	Greece
BUD	Budapest Liszt Ferenc International Airport	Budapest	Hungary
DEB	Debrecen International Airport	Debrecen	Hungary
PEV	Pécs-Pogány Airport	Pogány	Hungary
SOB	Hévíz–Balaton Airport	Sármellék	Hungary
QAQ	L'Aquila–Preturo Airport	L'Aquila	Italy
CRV	Crotone Sant'Anna Pythagoras Airport	Isola di Capo Rizzuto (KR)	Italy
BRI	Bari Karol Wojtyła International Airport	Bari	Italy
FOG	Foggia Gino Lisa Airport	Foggia (FG)	Italy
TAR	Taranto-Grottaglie Marcello Arlotta Airport	Grottaglie	Italy
LCC	Lecce Galatina Air Base / Galatina Fortunato Cesari Airport	Galatina (LE)	Italy
PSR	Abruzzo Airport	Pescara	Italy
BDS	Brindisi Airport	Brindisi	Italy
SUF	Lamezia Terme Sant'Eufemia International Airport	Lamezia Terme (CZ)	Italy
CIY	Comiso Airport	Comiso	Italy
CTA	Catania-Fontanarossa Airport	Catania	Italy
LMP	Lampedusa Airport	Lampedusa	Italy
PNL	Pantelleria Airport	Pantelleria (TP)	Italy
PMO	Falcone–Borsellino Airport	Palermo	Italy
REG	Reggio Calabria Airport	Reggio Calabria	Italy
TPS	Vincenzo Florio Airport Trapani-Birgi	Trapani (TP)	Italy
NSY	Sigonella Navy Air Base	Sigonella (CT)	Italy
BLX	Belluno Arturo dell'Oro Airport	Belluno (BL)	Italy
RAN	Ravenna Airport	Ravenna (RA)	Italy
AHO	Alghero-Fertilia Airport	Alghero	Italy
DCI	Decimomannu Air Base	Decimomannu	Italy
CAG	Cagliari Elmas Airport	Cagliari	Italy
OLB	Olbia Costa Smeralda Airport	Olbia (SS)	Italy
FNU	Oristano-Fenosu Airport	Oristano	Italy
TTB	Tortolì Airport	Arbatax	Italy
MXP	Milan Malpensa International Airport	Ferno (VA)	Italy
BGY	Milan Bergamo Airport / Antonio Locatelli Air Base	Orio al Serio (BG)	Italy
TRN	Turin Airport	Caselle Torinese (TO)	Italy
ALL	Riviera Villanova d'Albenga International Airport	Villanova d'Albenga (SV)	Italy
GOA	Genoa Cristoforo Colombo Airport	Genova (GE)	Italy
LIN	Milano Linate Airport	Segrate (MI)	Italy
PMF	Parma Airport	Parma (PR)	Italy
AOT	Aosta Corrado Gex Airport	Saint-Christophe (AO)	Italy
CUF	Cuneo International Airport	Levaldigi (CN)	Italy
AVB	Aviano Air Base	Aviano (PN)	Italy
BZO	Bolzano Airport	Bolzano (BZ)	Italy
UDN	Udine-Campoformido Air Base	Campoformido (UD)	Italy
BLQ	Bologna Guglielmo Marconi Airport	Bologna	Italy
TSF	Treviso Antonio Canova Airport	Treviso (TV)	Italy
FRL	Forlì Luigi Ridolfi Airport	Forlì (FC)	Italy
VBS	Brescia Gabriele d'Annunzio Airport	Montichiari (BS)	Italy
TRS	Trieste–Friuli Venezia Giulia Airport	Ronchi dei Legionari (GO)	Italy
RMI	Federico Fellini International Airport	Rimini (RN)	Italy
VRN	Verona Villafranca Valerio Catullo Airport	Caselle (VR)	Italy
AOI	Marche Airport	Falconara Marittima (AN)	Italy
VCE	Venice Marco Polo Airport	Venezia (VE)	Italy
LCV	Lucca-Tassignano Airport	Capannori (LU)	Italy
SAY	Siena-Ampugnano Airport	Ampugnano (SI)	Italy
CIA	Ciampino–G. B. Pastine International Airport	Rome	Italy
FCO	Rome–Fiumicino Leonardo da Vinci International Airport	Rome	Italy
QSR	Salerno Costa d'Amalfi Airport	Salerno	Italy
EBA	Marina di Campo Airport	Campo nell'Elba (LI)	Italy
NAP	Naples International Airport	Napoli	Italy
PSA	Pisa International Airport	Pisa (PI)	Italy
FLR	Florence Airport, Peretola	Firenze (FI)	Italy
GRS	Grosseto Corrado Baccarini Air Base / Grosseto Airport	Grosseto (GR)	Italy
PEG	Perugia San Francesco d'Assisi – Umbria International Airport	Perugia (PG)	Italy
LJU	Ljubljana Jože Pučnik Airport	Zgornji Brnik	Slovenia
MBX	Maribor Edvard Rusjan Airport	Orehova Vas	Slovenia
POW	Portorož Airport	Sečovlje	Slovenia
NUA	Nuwara Eliya (Lake Gregory) Waterdrome	Nuwara Eliya	Sri Lanka
LKC	Lekana Airport	Lekana	Congo - Brazzaville
JCL	České Budějovice South Bohemian Airport	České Budějovice	Czechia
UHE	Kunovice Airport	Uherské Hradiště	Czechia
KLV	Karlovy Vary Airport	Karlovy Vary	Czechia
HRA	Mnichovo Hradiště Airport	Mnichovo Hradiště	Czechia
OSR	Ostrava Leos Janáček Airport	Mošnov	Czechia
OLO	Olomouc Airport	Olomouc	Czechia
PED	Pardubice Airport	Pardubice	Czechia
PRV	Přerov Air Base	Přerov	Czechia
PRG	Václav Havel Airport Prague	Prague	Czechia
BRQ	Brno-Tuřany Airport	Brno	Czechia
VOD	Vodochody Airport	Vodochody	Czechia
ZBE	Zábřeh Dolní Benešov Airfield	Dolní Benešov	Czechia
TLV	Ben Gurion International Airport	Tel Aviv	Israel
BEV	Beersheba (Teyman) Airport	Beersheba	Israel
ETM	Ramon International Airport	Eilat	Israel
EIY	Ein Yahav Airfield	Sapir	Israel
LLH	La Lima - Reginaldo Hammer Airport	La Lima	Honduras
HFA	Haifa International Airport	Haifa	Israel
RPN	Rosh Pina Airport	Rosh Pina	Israel
KSW	Kiryat Shmona Airport	Kiryat Shmona	Israel
LLL	Lissadell Airport	Lissadell Station	Australia
MTZ	Bar Yehuda Airfield	Masada	Israel
VTM	Nevatim Air Base	Beersheba	Israel
VDA	Ovda Airport	Eilat	Israel
MIP	Ramon Air Base	Beersheba	Israel
YOT	Yotvata Airfield	Yotvata	Israel
MLA	Malta International Airport	Valletta	Malta
LMV	Madivaru Airport	Naifaru	Maldives
LMZ	Palma Airport	Palma	Mozambique
LNC	Lengbati Airport		Papua New Guinea
LNF	Munbil Airport		Papua New Guinea
LNM	Langimar Airport		Papua New Guinea
MCM	Monaco Heliport	Fontvieille	Monaco
ANT	Sankt Anton am Arlberg Heliport	Sankt Anton am Arlberg	Austria
HOH	Hohenems-Dornbirn Airfield	Hohenems	Austria
LOM	Francisco Primo de Verdad y Ramos Airport	Lagos de Moreno	Mexico
LOR	Lowe AHP (Fort Rucker) Heliport	Fort Rucker Ozark	United States
GRZ	Graz Airport	Feldkirchen bei Graz	Austria
INN	Innsbruck Airport	Innsbruck	Austria
KLU	Klagenfurt Airport	Klagenfurt am Wörthersee	Austria
LNZ	Linz-Hörsching Airport / Vogler Air Base	Linz	Austria
SZG	Salzburg Airport	Salzburg	Austria
VIE	Vienna International Airport	Vienna	Austria
AVR	Alverca Air Base	Vila Franca de Xira	Portugal
SMA	Santa Maria Airport	Vila do Porto	Portugal
BGC	Bragança Airport	Bragança	Portugal
BYJ	Beja Airport / Airbase	Beja	Portugal
BGZ	Braga Municipal Aerodrome	Braga	Portugal
CHV	Aerodromo de Chaves	Chaves	Portugal
CBP	Aerodromo Municipal de Coimbra	Coimbra	Portugal
CVU	Corvo Airport	Corvo	Portugal
CAT	Cascais Airport	Cascais	Portugal
FLW	Flores Airport	Santa Cruz das Flores	Portugal
FAO	Faro Airport	Faro	Portugal
GRW	Graciosa Airport	Santa Cruz da Graciosa	Portugal
HOR	Horta Airport	Horta	Portugal
TER	Lajes Airport	Praia da Vitória	Portugal
FNC	Madeira International Airport Cristiano Ronaldo	Funchal	Portugal
QLR	Monte Real Air Base		Portugal
PDL	João Paulo II Airport	Ponta Delgada	Portugal
PIX	Pico Airport	Pico Island	Portugal
PRM	Portimão Airport	Portimão	Portugal
OPO	Francisco de Sá Carneiro Airport	Porto	Portugal
PXO	Porto Santo Airport	Vila Baleira	Portugal
LIS	Humberto Delgado Airport (Lisbon Portela Airport)	Lisbon	Portugal
SJZ	São Jorge Airport	Velas	Portugal
VRL	Vila Real Airport	Vila Real	Portugal
VSE	Aerodromo Goncalves Lobato (Viseu Airport)	Viseu	Portugal
BNX	Banja Luka International Airport	Banja Luka	Bosnia & Herzegovina
OMO	Mostar International Airport	Mostar	Bosnia & Herzegovina
SJJ	Sarajevo International Airport	Sarajevo	Bosnia & Herzegovina
TZL	Tuzla International Airport	Dubrave Gornje	Bosnia & Herzegovina
ARW	Arad International Airport	Arad	Romania
BCM	Bacău George Enescu International  Airport	Bacău	Romania
BAY	Maramureș International Airport	Tăuții-Măgherăuș	Romania
BBU	Bucharest Băneasa Aurel Vlaicu International Airport	Bucharest	Romania
CND	Mihail Kogălniceanu International Airport	Mihail Kogălniceanu	Romania
CLJ	Cluj Avram Iancu International Airport	Cluj-Napoca	Romania
CSB	Caransebeş Airport	Caransebeş	Romania
CRA	Craiova International Airport	Craiova	Romania
IAS	Iaşi Airport	Iaşi	Romania
OMR	Oradea International Airport	Oradea	Romania
OTP	Bucharest Henri Coandă International Airport	Otopeni	Romania
GHV	Brașov-Ghimbav International Airport	Brașov (Ghimbav)	Romania
SBZ	Sibiu International Airport	Sibiu	Romania
SUJ	Satu Mare International Airport	Satu Mare	Romania
SCV	Suceava Stefan cel Mare Airport	Suceava	Romania
TCE	Tulcea Danube Delta Airport	Mihail Kogălniceanu	Romania
TGM	Târgu Mureş Transilvania International Airport	Recea	Romania
TSR	Timişoara Traian Vuia Airport	Timişoara	Romania
GVA	Geneva Cointrin International Airport	Geneva	Switzerland
SIR	Sion Airport	Sion	Switzerland
EML	Emmen Air Base	Emmen	Switzerland
VIP	Payerne Air Base	Payerne	Switzerland
LUG	Lugano Airport	Agno	Switzerland
BRN	Bern Airport	Bern	Switzerland
BXO	Buochs Airport	Buochs	Switzerland
ZRH	Zürich Airport	Zurich	Switzerland
ACH	Sankt Gallen Altenrhein Airport	St. Gallen	Switzerland
SMV	Samedan Airport	Samedan	Switzerland
GKD	Gökçeada Airport	Gökçeada	Turkey
ESB	Esenboğa International Airport	Ankara	Turkey
ANK	Etimesgut Air Base	Ankara	Turkey
ADA	Adana Şakirpaşa Airport	Seyhan	Turkey
UAB	İncirlik Air Base	Sarıçam	Turkey
AFY	Afyon Air Base	Afyonkarahisar	Turkey
AYT	Antalya International Airport	Antalya	Turkey
GZT	Gaziantep International Airport	Gaziantep	Turkey
KFS	Kastamonu Airport	Kastamonu	Turkey
KYA	Konya Airport	Konya	Turkey
MZH	Amasya Merzifon Airport	Amasya	Turkey
VAS	Sivas Nuri Demirağ Airport	Sivas	Turkey
ONQ	Zonguldak Çaycuma Airport	Zonguldak	Turkey
MLX	Malatya Erhaç Airport	Malatya	Turkey
ASR	Kayseri Erkilet Airport	Kayseri	Turkey
TJK	Tokat Airport	Tokat	Turkey
DNZ	Çardak Airport	Denizli	Turkey
NAV	Nevşehir Kapadokya Airport	Nevşehir	Turkey
ISL	İstanbul Atatürk Airport	Bakırköy, Istanbul	Turkey
CII	Aydın Çıldır Airport	Aydın	Turkey
BZI	Balıkesir Airport	Balıkesir	Turkey
BDM	Bandırma Airport	Bandırma	Turkey
CKZ	Çanakkale Airport	Çanakkale	Turkey
ESK	Eskişehir Air Base		Turkey
ADB	Adnan Menderes International Airport	Gaziemir	Turkey
IGL	Çiğli Airbase	Çiğli	Turkey
USQ	Uşak Airport	Uşak	Turkey
KCO	Cengiz Topel Airport	Kartepe	Turkey
YEI	Bursa Yenişehir Airport	Yenişehir	Turkey
DLM	Dalaman International Airport	Dalaman	Turkey
TEQ	Tekirdağ Çorlu Airport	Çorlu	Turkey
BXN	Bodrum-Imsık Airport	Imsık	Turkey
AOE	Anadolu Airport	Eskişehir	Turkey
KZR	Zafer Airport	Altıntaş	Turkey
EZS	Elazığ Airport	Elazığ	Turkey
OGU	Ordu–Giresun Airport	Ordu	Turkey
DIY	Diyarbakır Airport	Diyarbakır	Turkey
ERC	Erzincan Airport	Erzincan	Turkey
ERZ	Erzurum International Airport	Erzurum	Turkey
KSY	Kars Airport	Kars	Turkey
TZX	Trabzon International Airport	Trabzon	Turkey
VAN	Van Ferit Melen Airport	Van	Turkey
BAL	Batman Airport	Batman	Turkey
MSR	Muş Airport	Muş	Turkey
SXZ	Siirt Airport	Siirt	Turkey
NOP	Sinop Airport	Sinop	Turkey
KCM	Kahramanmaraş Airport	Kahramanmaraş	Turkey
AJI	Ağrı Airport	Ağrı	Turkey
ADF	Adıyaman Airport	Adıyaman	Turkey
MQM	Mardin Airport	Mardin	Turkey
GNY	Şanlıurfa GAP Airport	Şanlıurfa	Turkey
IGD	Iğdır Airport	Iğdır	Turkey
NKT	Şırnak Şerafettin Elçi Airport	Şırnak	Turkey
YKO	Hakkari Yüksekova Airport	Hakkari	Turkey
HTY	Hatay Airport	Antakya	Turkey
LTF	Leitre Airport	Leitre	Papua New Guinea
IZM	Selçuk Efes Airport	Selçuk	Turkey
ISE	Süleyman Demirel International Airport	Isparta	Turkey
EDO	Balıkesir Koca Seyit Airport	Edremit	Turkey
BJV	Milas Bodrum International Airport	Bodrum	Turkey
GZP	Gazipaşa-Alanya Airport	Gazipaşa	Turkey
SZF	Samsun-Çarşamba Airport	Samsun	Turkey
SAW	Istanbul Sabiha Gökçen International Airport	Pendik, Istanbul	Turkey
IST	İstanbul Airport	Arnavutköy, Istanbul	Turkey
BZY	Bălți International Airport	Bălți	Moldova
RMO	Chişinău International Airport	Chişinău	Moldova
LWA	Lebak Rural Airport	Lebak	Philippines
OHD	Ohrid St. Paul the Apostle Airport	Ohrid	North Macedonia
SKP	Skopje International Airport	Ilinden	North Macedonia
GIB	Gibraltar Airport	Gibraltar	Gibraltar
BCQ	Brak Airport	Brak	Libya
DNF	Martuba Air Base	Martuba	Libya
MRA	Misrata International Airport	Misrata	Libya
QUB	Ubari Airport	Ubari	Libya
UZC	Ponikve Airport	Stapari	Serbia
BEG	Belgrade Nikola Tesla Airport	Belgrade	Serbia
IVG	Berane Airport	Berane	Montenegro
BJY	Batajnica Air Base	Zemun	Serbia
KVO	Morava Airport	Kraljevo	Serbia
INI	Niš Constantine the Great Airport	Niš	Serbia
TGD	Podgorica Airport / Podgorica Golubovci Airbase	Podgorica	Montenegro
TIV	Tivat Airport	Tivat	Montenegro
LZG	Langzhong Gucheng Airport	Nanchong (Langzhong)	China
BTS	M. R. Štefánik Airport	Bratislava	Slovakia
KSC	Košice International Airport	Košice	Slovakia
LUE	Lučenec Airfield	Lučenec	Slovakia
PZY	Piešťany Airport	Piešťany	Slovakia
POV	Prešov Air Base	Prešov	Slovakia
SLD	Sliač Airport	Sliač	Slovakia
TAT	Poprad-Tatry Airport	Poprad	Slovakia
ILZ	Žilina-Dolný Hričov Airport	Dolný Hričov	Slovakia
DRU	Drummond Airport	Drummond	United States
GLN	Guelmim Airport	Guelmim	Morocco
UWA	Ware Airport	Ware	United States
MAP	Mamai Airport	Mamai	Papua New Guinea
GDT	JAGS McCartney International Airport	Cockburn Town	Turks & Caicos Islands
MDS	Middle Caicos Airport	Middle Caicos	Turks & Caicos Islands
NCA	North Caicos Airport	North Caicos	Turks & Caicos Islands
PIC	Pine Cay Airport	Pine Cay	Turks & Caicos Islands
PLS	Providenciales International Airport	Providenciales	Turks & Caicos Islands
XSC	South Caicos Airport	South Caicos	Turks & Caicos Islands
SLX	Salt Cay Airport	Salt Cay	Turks & Caicos Islands
BRX	Maria Montez International Airport	Barahona	Dominican Republic
CBJ	Cabo Rojo Airport	Cabo Rojo	Dominican Republic
AZS	Samaná El Catey International Airport	Samana	Dominican Republic
COZ	Constanza - Expedición 14 de Junio National Airport	Costanza	Dominican Republic
JBQ	La Isabela International Airport	La Isabela	Dominican Republic
LRM	Casa De Campo International Airport	La Romana	Dominican Republic
PUJ	Punta Cana International Airport	Punta Cana	Dominican Republic
POP	Gregorio Luperon International Airport	Puerto Plata	Dominican Republic
SDQ	Las Américas International Airport	Santo Domingo	Dominican Republic
STI	Cibao International Airport	Santiago	Dominican Republic
MDV	Médouneu Airport	Médouneu, Gabon	Equatorial Guinea
LIZ	Loring International Airport	Limestone	United States
MEF	Melfi Airport	Melfi	Chad
OHB	Ambohibary Airport	Moramanga	Madagascar
NKO	Ankokoambo Airport	Ankokoambo	Madagascar
RLR	Relais de la Reine Airport	Isalo	Madagascar
DOA	Doany Airport	Doany	Madagascar
CBV	Coban Airport	Coban	Guatemala
CMM	Carmelita Airport	Carmelita	Guatemala
CTF	Coatepeque Airport	Coatepeque	Guatemala
GUA	La Aurora Airport	Guatemala City	Guatemala
HUG	Huehuetenango Airport	Huehuetenango	Guatemala
MGI	National Wildlife Refuge Airport	Matagorda Island	United States
MGP	Manga Airport	Manga Mission	Papua New Guinea
PBR	Puerto Barrios Airport	Puerto Barrios	Guatemala
PON	Poptún Airport	Poptún	Guatemala
AQB	Quiché Airport	Santa Cruz del Quiché	Guatemala
AAZ	Quezaltenango Airport	Quezaltenango	Guatemala
RUV	Rubelsanto Airport	Rubelsanto	Guatemala
LCF	Las Vegas Airport	Rio Dulce	Guatemala
RER	Retalhuleu Airport	Retalhuleu	Guatemala
GSJ	San José Airport	Puerto San José	Guatemala
FRS	Mundo Maya International Airport	San Benito	Guatemala
AIM	Ailuk Airport	Ailuk Island	Marshall Islands
AUL	Aur Island Airport	Aur Atoll	Marshall Islands
BII	Enyu Airfield	Bikini Atoll	Marshall Islands
EBN	Ebadon Airport	Ebadon Island	Marshall Islands
JAT	Jabot Airport	Ailinglapalap Atoll	Marshall Islands
JEJ	Jeh Airport	Ailinglapalap Atoll	Marshall Islands
LIK	Likiep Airport	Likiep Island	Marshall Islands
LML	Lae Island Airport	Lae Island	Marshall Islands
MAV	Maloelap Island Airport	Maloelap Island	Marshall Islands
MJB	Mejit Atoll Airport	Mejit Atoll	Marshall Islands
MJE	Majkin Airport	Majkin	Marshall Islands
NDK	Namorik Airport	Namorik Atoll	Marshall Islands
RNP	Rongelap Island Airport	Rongelap Island	Marshall Islands
TIC	Tinak Airport	Arno Atoll	Marshall Islands
UIT	Jaluit Airport	Jabor Jaluit Atoll	Marshall Islands
WJA	Woja Airport	Woja	Marshall Islands
WTE	Wotje Airport	Wotje	Marshall Islands
WTO	Wotho Island Airport	Wotho Island	Marshall Islands
AHS	Ahuas Airport	Ahuas	Honduras
BHG	Brus Laguna Airport	Brus Laguna	Honduras
LUI	Carta Airport	La Unión	Honduras
CYL	Coyoles Airport	Coyoles	Honduras
CDD	Cauquira Airport	Cauquira	Honduras
OAN	El Arrayán Airport	Olanchito	Honduras
CAA	El Aguacate Airport	El Aguacate	Honduras
GAC	Celaque Gracias Airport	Gracias	Honduras
IRN	Iriona Airport	Iriona	Honduras
JUT	Jutigalpa airport	Jutigalpa	Honduras
LCE	Goloson International Airport	La Ceiba	Honduras
LEZ	La Esperanza Airport	La Esperanza	Honduras
SAP	Ramón Villeda Morales International Airport	San Pedro Sula	Honduras
LMH	Limon Airport	Limón	Honduras
MHN	Hooker County Airport	Mullen	United States
GJA	La Laguna Airport	Guanaja	Honduras
PCH	Palacios Airport	Palacios	Honduras
PEU	Puerto Lempira Airport	Puerto Lempira	Honduras
RTB	Juan Manuel Gálvez International Airport	Coxen Hole	Honduras
RUY	Rioamarillo Airport	Copán Ruinas	Honduras
XPL	Palmerola International Airport / José Enrique Soto Cano Air Base	Palmerola	Honduras
TEA	Tela Airport	Tela	Honduras
TGU	Toncontín International Airport	Tegucigalpa	Honduras
TJI	Trujillo Airport	Trujillo	Honduras
TCF	Tocoa Airport	Tocoa	Honduras
SCD	Sulaco Airport	Sulaco	Honduras
UII	Utila Airport	Utila Island	Honduras
MHY	Morehead Airport	Morehead	Papua New Guinea
ORO	Yoro Airport	Yoro	Honduras
MIZ	Mainoru Airstrip	Mainoru	Australia
MJJ	Moki Airport	Moki	Papua New Guinea
MJS	Maganja da Costa Airport	Maganja	Mozambique
OCJ	Ian Fleming International Airport	Boscobel	Jamaica
KIN	Norman Manley International Airport	Kingston	Jamaica
MBJ	Sangster International Airport	Montego Bay	Jamaica
POT	Ken Jones Airport	Ken Jones	Jamaica
MKN	Malekolon Airport	Babase Island	Papua New Guinea
NEG	Negril Airport	Negril	Jamaica
KTP	Tinson Pen Airport	Tinson Pen	Jamaica
MIJ	Mili Island Airport	Mili Island	Marshall Islands
MLQ	Malalaua Airport	Malalaua	Papua New Guinea
HEB	Hinthada Airport	Hinthada	Myanmar (Burma)
HEH	Heho Airport	Kalaw Township	Myanmar (Burma)
TZM	Aeródromo de Cupul	Tizimin	Mexico
ACA	Aeropuerto Internacional Juan N. Álvarez	Ciudad de Acapulco	Mexico
NTR	Del Norte International Airport	Monterrey	Mexico
AGU	Aeropuerto Internacional Jesús Terán Peredo	Aguascalientes	Mexico
HUX	Bahías de Huatulco International Airport	Huatulco	Mexico
CNA	Cananea National Airport	Cananea	Mexico
CVJ	Aeropuerto Internacional Mariano Matamoros	Temixco	Mexico
ACN	Ciudad Acuña New International Airport	Ciudad Acuña	Mexico
CME	Ciudad del Carmen International Airport	Ciudad del Carmen	Mexico
NCG	Aeropuerto Municipal de Nuevo Casas Grandes	Nuevo Casas Grandes	Mexico
CUL	Bachigualato Federal International Airport	Culiacán	Mexico
CTM	Aeropuerto Internacional de Chetumal	Chetumal	Mexico
CEN	Ciudad Obregón International Airport	Ciudad Obregón	Mexico
CJT	San Antonio Copalar Airport	Comitán	Mexico
CPE	Ingeniero Alberto Acuña Ongay International Airport	Campeche	Mexico
CJS	Abraham González International Airport	Ciudad Juárez	Mexico
CZA	Aeropuerto Internacional de Chichen Itza	Chichen Itza	Mexico
CUU	General Roberto Fierro Villalobos International Airport	Chihuahua	Mexico
CVM	General Pedro Jose Mendez International Airport	Ciudad Victoria	Mexico
CYW	Aeropuerto Nacional Captain Rogelio Castillo	Celaya	Mexico
NKD	Sinak Airport	Sinak	Indonesia
CZM	Aeropuerto Internacional de Cozumel	Ciudad de Cozumel	Mexico
CUA	Ciudad Constitución National Airport	Comondú	Mexico
MMC	Ciudad Mante Los Huastecas National Airport	Ciudad Mante	Mexico
DGO	Aeropuerto Internacional General Guadalupe Victoria	Ciudad de Durango	Mexico
TPQ	Amado Nervo National Airport	Tepic	Mexico
ESE	Aeropuerto Internacional de Ensenada	Ensenada	Mexico
GDL	Guadalajara International Airport	Guadalajara	Mexico
GYM	General José María Yáñez International Airport	Guaymas	Mexico
GUB	Guerrero Negro Airport	San Quintín	Mexico
TCN	Tehuacan Airport		Mexico
HMO	General Ignacio P. Garcia International Airport	Hermosillo	Mexico
CLQ	Aeropuerto Internacional Licenciado Miguel de la Madrid	Colima	Mexico
ISJ	Aeropuerto Nacional de Isla Mujeres	Isla Mujeres	Mexico
SLW	Plan De Guadalupe International Airport	Saltillo	Mexico
IZT	Aeropuerto Nacional General Antonio Cárdenas Rodríguez	Ixtepec	Mexico
JAL	El Lencero Airport	Xalapa	Mexico
AZP	Aeropuerto Nacional Jorge Jiménez Cantú	Atizapán de Zaragoza	Mexico
LZC	Lázaro Cárdenas Airport	Lázaro Cárdenas	Mexico
LMM	Valle del Fuerte International Airport	Los Mochis	Mexico
BJX	Aeropuerto Internacional del Bajío	Silao	Mexico
LAP	Manuel Márquez de León International Airport	La Paz	Mexico
LTO	Loreto International Airport	Loreto	Mexico
MAM	General Servando Canales International Airport	Matamoros	Mexico
MID	Aeropuerto Internacional Manuel Crescencio Rejón	Ciudad de Mérida	Mexico
MUG	Mulege Airport	Mulege	Mexico
MXL	Aeropuerto Internacional Gral. Rodolfo Sánchez Taboada	Mexicali	Mexico
MLM	General Francisco J. Mujica International Airport	Morelia	Mexico
MTT	Minatitlán/Coatzacoalcos International Airport	Cosoleacaque	Mexico
LOV	Monclova International Airport	Monclova	Mexico
MEX	Benito Juárez International Airport	Ciudad de México	Mexico
MTY	Monterrey International Airport	Monterrey	Mexico
MZT	General Rafael Buelna International Airport	Mazatlàn	Mexico
NOG	Nogales International Airport	Nogales	Mexico
NLD	Quetzalcóatl International Airport	Nuevo Laredo	Mexico
OAX	Aeropuerto Internacional Xoxocotlán	Oaxaca	Mexico
PAZ	El Tajín National Airport	Poza Rica	Mexico
PBC	Aeropuerto Internacional Hermanos Serdán	Puebla	Mexico
PDS	Piedras Negras International Airport	Piedras Negras	Mexico
PCO	Punta Colorada Airport	La Ribera	Mexico
UPN	Uruapan - Licenciado y General Ignacio Lopez Rayon International Airport	Uruapan	Mexico
PQM	Palenque International Airport	Palenque	Mexico
PVR	Puerto Vallarta International Airport	Puerto Vallarta	Mexico
PXM	Aeropuerto Internacional de Puerto Escondido	Puerto Escondido	Mexico
QRO	Querétaro Intercontinental Airport	Querétaro	Mexico
REX	General Lucio Blanco International Airport	Reynosa	Mexico
SJD	Aeropuerto Internacional de Los Cabos	San José del Cabo	Mexico
SFH	Aeropuerto Internacional San Felipe	Mexicali	Mexico
NLU	Aeropuerto Internacional General Felipe Ángeles	Mexico City	Mexico
SLP	Ponciano Arriaga International Airport	San Luis Potosí	Mexico
TRC	Francisco Sarabia Tinoco International Airport	Torreón	Mexico
TGZ	Angel Albino Corzo International Airport	Tuxtla Gutiérrez	Mexico
TIJ	Aeropuerto Internacional Gral. Abelardo Rodriguez	Ciudad de Tijuana	Mexico
TQO	Felipe Carrillo Puerto International Airport	Tulum	Mexico
TAM	General Francisco Javier Mina International Airport	Tampico	Mexico
TSL	Aeropuerto Nacional de Tamuín	Tamuin	Mexico
TLC	Adolfo López Mateos International Airport	Toluca	Mexico
TAP	Aeropuerto Internacional de Tapachula	Tapachula	Mexico
CUN	Aeropuerto Internacional de Cancún	Cancún	Mexico
MMV	Mal Airport	Mal Island	Papua New Guinea
VSA	Carlos Rovirosa Pérez International Airport	Villahermosa	Mexico
VER	General Heriberto Jara International Airport	Veracruz	Mexico
ZCL	Aeropuerto Internacional General Leobardo C. Ruiz	Zacatecas	Mexico
ZIH	Aeropuerto Internacional de Zihuatanejo	Ixtapa	Mexico
ZMM	Zamora Airport		Mexico
ZLO	Aeropuerto Internacional Playa de Oro	Manzanillo	Mexico
MXW	Mandalgobi Airport	Mandalgobi	Mongolia
BEF	Bluefields Airport	Bluefileds	Nicaragua
BZA	San Pedro Airport	Bonanza	Nicaragua
ECI	Costa Esmeralda Airport	Tola	Nicaragua
RNI	Corn Island Airport	Corn Island	Nicaragua
MGA	Augusto C. Sandino (Managua) International Airport	Managua	Nicaragua
MNP	Maron Island Airport	Hermit Islands	Papua New Guinea
PUZ	Puerto Cabezas Airport	Puerto Cabezas	Nicaragua
RFS	Rosita Airport	La Rosita	Nicaragua
NCR	San Carlos Airport	San Carlos	Nicaragua
SIU	Siuna	Siuna	Nicaragua
WSP	Waspam Airport	Waspam	Nicaragua
MOH	Maleo Airport	Morowali	Indonesia
MOS	Moses Point Airport	Elim	United States
BOC	Bocas del Toro International Airport	Isla Colón	Panama
CTD	Alonso Valderrama Airport	Chitré	Panama
CHX	Changuinola Captain Manuel Niño International Airport	Changuinola	Panama
DAV	Enrique Malek International Airport	David	Panama
ONX	Enrique Adolfo Jimenez Airport	Colón	Panama
MPG	Makini Airport	Makini	Papua New Guinea
BLB	Panamá Pacífico International Airport	Panamá City	Panama
MPI	Mamitupu Airport	Mamitupu	Panama
JQE	Jaqué Airport	Jaqué	Panama
PAC	Marcos A. Gelabert International Airport	Albrook	Panama
PUE	Puerto Obaldía Airport	Puerto Obaldía	Panama
PDM	Capt. J. Montenegro Airport	Pedasí	Panama
PDC	Mueo Airport	Népoui	New Caledonia
RIH	Scarlett Martinez International Airport	Río Hato	Panama
SYP	Ruben Cantu Airport	Santiago	Panama
PTY	Tocumen International Airport	Tocumen	Panama
MPU	Mapua(Mabua) Airport	Tatau Island	Papua New Guinea
PVE	El Porvenir Airport	El Porvenir	Panama
NBL	San Blas Airport	Warsobtugua	Panama
MPX	Miyanmin Airport	Miyanmin	Papua New Guinea
MQO	Malam Airport	Malam	Papua New Guinea
FON	La Fortuna Arenal Airport	La Fortuna	Costa Rica
BAI	Buenos Aires Airport	Punta Arenas	Costa Rica
BCL	Barra del Colorado Airport	Pococi	Costa Rica
TTQ	Barra del Tortuguero	Tortuguero	Costa Rica
OTR	Coto 47 Airport	Corredores	Costa Rica
JAP	Chacarita Airport	Puntarenas	Costa Rica
PLD	Playa Samara/Carrillo Airport	Carrillo	Costa Rica
DRK	Drake Bay Airport	Puntarenas	Costa Rica
FMG	Flamingo Airport	Brasilito	Costa Rica
GLF	Golfito Airport	Golfito	Costa Rica
GPL	Guapiles Airport	Pococi	Costa Rica
PBP	Islita Airport	Nandayure	Costa Rica
LIR	Guanacaste Airport	Liberia	Costa Rica
LSL	Los Chiles Airport	Los Chiles	Costa Rica
LIO	Limon International Airport	Puerto Limon	Costa Rica
CSC	Mojica Airport	Cañas	Costa Rica
NCT	Guanacaste Airport	Nicoya/Guanacate	Costa Rica
NOB	Nosara Airport	Nicoya	Costa Rica
SJO	Juan Santamaría International Airport	San José (Alajuela)	Costa Rica
PJM	Puerto Jimenez Airport	Puerto Jimenez	Costa Rica
PMZ	Palmar Sur Airport	Palmar Sur	Costa Rica
SYQ	Tobías Bolaños International Airport	San Jose	Costa Rica
XQP	Quepos Managua Airport	Quepos	Costa Rica
RFR	Rio Frio / Progreso Airport	Rio Frio / Progreso	Costa Rica
IPZ	San Isidro del General Airport	Pérez Zeledón	Costa Rica
TOO	San Vito de Java Airport	Coto Brus	Costa Rica
MRT	Moroak Airport	Moroak	Australia
TNO	Tamarindo Airport	Tamarindo	Costa Rica
TMU	Tambor Airport	Nicoya	Costa Rica
UPL	Upala Airport	Upala	Costa Rica
MSB	Marigot Seaplane Base	Saint Martin	St. Martin
SAL	Monseñor Óscar Arnulfo Romero International Airport	San Salvador (San Luis Talpa)	El Salvador
ILS	Ilopango International Airport	San Salvador	El Salvador
CYA	Les Cayes Airport	Les Cayes	Haiti
CAP	Cap Haitien International Airport	Cap Haitien	Haiti
MTX	Metro Field	Fairbanks	United States
JAK	Jacmel Airport	Jacmel	Haiti
JEE	Jérémie Airport	Jeremie	Haiti
PAP	Toussaint Louverture International Airport	Port-au-Prince	Haiti
PAX	Port-de-Paix Airport	Port-de-Paix	Haiti
MTU	Montepuez Airport	Montepuez	Mozambique
AHG	Agalega Island Airstrip	Vingt Cinq	Mauritius
BCA	Gustavo Rizo Airport	Baracoa	Cuba
BWW	Las Brujas Airport	Cayo Santa Maria	Cuba
BYM	Carlos Manuel de Cespedes Airport	Bayamo	Cuba
AVI	Máximo Gómez Airport	Ciro Redondo	Cuba
CCC	Jardines Del Rey Airport	Cayo Coco	Cuba
CFG	Jaime Gonzalez Airport	Cienfuegos	Cuba
CYO	Vilo Acuña International Airport	Cayo Largo del Sur	Cuba
CMW	Ignacio Agramonte International Airport	Camaguey	Cuba
SCU	Antonio Maceo International Airport	Santiago	Cuba
NBW	Leeward Point Field	Guantanamo Bay Naval Station	Cuba
GAO	Mariana Grajales Airport	Guantánamo	Cuba
HAV	José Martí International Airport	Havana	Cuba
HOG	Frank Pais International Airport	Holguin	Cuba
VRO	Kawama Airport	Santa Marta	Cuba
LCL	La Coloma Airport	Pinar del Rio	Cuba
UMA	Alfredo Noa Díaz Airport	Maisí	Cuba
MJG	Mayajigua Airport	Mayajigua	Cuba
MOA	Orestes Acosta Airport	Moa	Cuba
MZO	Sierra Maestra International Airport	Manzanillo	Cuba
GER	Rafael Cabrera Airport	Nueva Gerona	Cuba
UPB	Playa Baracoa Airport	Havana	Cuba
SNU	Abel Santamaria Airport	Santa Clara	Cuba
SNJ	San Julián Air Base	Sandino	Cuba
SZJ	Siguanea Airport	Isla de la Juventud	Cuba
USS	Sancti Spiritus Airport	Sancti Spiritus	Cuba
TND	Alberto Delgado Airport	Trinidad	Cuba
VRA	Juan Gualberto Gomez International Airport	Matanzas	Cuba
VTU	Hermanos Ameijeiras Airport	Las Tunas	Cuba
FMT	Faresmaathoda Airport	Faresmaathodaa	Maldives
CYB	Charles Kirkconnell International Airport	West End	Cayman Islands
LYB	Edward Bodden Little Cayman Airfield	Blossom Village	Cayman Islands
GCM	Owen Roberts International Airport	George Town	Cayman Islands
MWR	Motswari Airport	Motswari Private Game Reserve	South Africa
MWU	Mussau Airport	Mussau Island	Papua New Guinea
AJS	Punta Abreojos Airport	Mulegé	Mexico
AZG	Apatzingán - Pablo L. Sidar Airport	Apatzingán	Mexico
PCM	Aeropuerto Nacional de Playa del Carmen	Solidaridad	Mexico
PCV	Punta Chivato Airport	Mulegé	Mexico
SCX	Estación Aeronaval de Salina Cruz	Salina Cruz	Mexico
SGM	San Ignacio Airport	Mulegé	Mexico
TUY	Base Aeronaval de Tulum	Tulum	Mexico
UAC	San Luis Río Colorado Airport	San Luis Río Colorado	Mexico
XAL	Álamos Airport	Álamos	Mexico
MXC	Monticello Airport	Monticello	United States
MXK	Mindik Airport	Mindik	Papua New Guinea
GTK	Sungai Tekai Airport	Sungai Tekai	Malaysia
LBP	Long Banga Airport	Long Banga	Malaysia
SPT	Sipitang Airport	Sipitang	Malaysia
MAY	Clarence A. Bain Airport	Mangrove Cay	Bahamas
ASD	Andros Town Airport		Bahamas
TZN	Congo Town Airport	Andros	Bahamas
MHH	Leonard M Thompson International Airport	Marsh Harbour	Bahamas
SAQ	San Andros Airport	Andros Island	Bahamas
AXP	Spring Point Airport	Spring Point	Bahamas
TCB	Treasure Cay Airport	Treasure Cay	Bahamas
WKR	Walkers Cay Airport	Walkers Cay	Bahamas
CCZ	Chub Cay Airport		Bahamas
GHC	Great Harbour Cay Airport	Bullocks Harbour	Bahamas
BIM	South Bimini Airport	South Bimini	Bahamas
ATC	Arthur's Town Airport	Arthur's Town	Bahamas
TBI	New Bight Airport	Cat Island	Bahamas
CXY	Cat Cay Airport	North Cat Cay	Bahamas
CRI	Colonel Hill Airport	Colonel Hill	Bahamas
PWN	Pitts Town Airport	Pitts Town	Bahamas
GGT	Exuma International Airport	Moss Town	Bahamas
ELH	North Eleuthera Airport	North Eleuthera	Bahamas
GHB	Governor's Harbour Airport	Governor's Harbour	Bahamas
NMC	Normans Cay Airport	Normans Cay	Bahamas
RSD	Rock Sound Airport	Rock Sound	Bahamas
TYM	Staniel Cay Airport		Bahamas
FPO	Grand Bahama International Airport	Freeport	Bahamas
WTD	West End Airport	West End	Bahamas
IGA	Inagua Airport	Matthew Town	Bahamas
MYK	May Creek Airport	May Creek	United States
LGI	Deadman's Cay Airport	Deadman's Cay	Bahamas
SML	Stella Maris Airport	Stella Maris	Bahamas
MYG	Mayaguana Airport	Abrahams Bay	Bahamas
NAS	Lynden Pindling International Airport	Nassau	Bahamas
DCT	Duncan Town Airport		Bahamas
RCY	Rum Cay International Airport	Port Nelson	Bahamas
MYS	Moyale Airport	Moyale	Ethiopia
ZSA	San Salvador Airport	San Salvador	Bahamas
MYX	Menyamya Airport	Menyamya	Papua New Guinea
NTC	Paradise Island Airport	Santa Carolina	Mozambique
IBO	Ibo Airport	Ibo	Mozambique
TGS	Chokwé Airport	Chokwé	Mozambique
BZE	Philip S. W. Goldson International Airport	Belize City	Belize
MZE	Manatee Airport		Belize
CYD	San Ignacio Town (Maya Flats) Airstrip	Maya Flats	Belize
IMI	Ine Airport	Arno Atoll	Marshall Islands
BQI	Bagani Airport	Bagani	
OGV	Ongava Lodge Airstrip	Ombika	
NBS	Changbaishan Airport	Baishan	China
AIT	Aitutaki Airport	Aitutaki	Cook Islands
AIU	Enua Airport	Atiu Island	Cook Islands
MGS	Mangaia Island Airport	Mangaia Island	Cook Islands
MHX	Manihiki Island Airport	Manihiki Island	Cook Islands
MUK	Mauke Airport	Mauke Island	Cook Islands
MOI	Mitiaro Island Airport	Mitiaro Island	Cook Islands
PZK	Pukapuka Island Airport	Pukapuka Atoll	Cook Islands
PYE	Tongareva Airport	Penrhyn Island	Cook Islands
RAR	Rarotonga International Airport	Avarua	Cook Islands
NDI	Namudi Airport	Namudi	Papua New Guinea
NDN	Nadunumu Airport	Nadunumu	Papua New Guinea
EPG	Browns Airport	Weeping Water	United States
ICI	Cicia Airport	Cicia	Fiji
CST	Castaway Island Seaplane Base	Castaway Island	Fiji
NAN	Nadi International Airport	Nadi	Fiji
PTF	Malolo Lailai Island Airport	Malolo Lailai Island	Fiji
RBI	Rabi Island Airport	Rabi Island	Fiji
KDV	Vunisea Airport	Vunisea	Fiji
MNF	Mana Island Airport	Mana Island	Fiji
MFJ	Moala Airport	Moala	Fiji
SUV	Nausori International Airport	Nausori	Fiji
LEV	Levuka Airfield	Bureta	Fiji
NGI	Ngau Airport	Ngau	Fiji
LUC	Laucala Island Airport	Laucala Island	Fiji
LKB	Lakeba Island Airport	Lakeba Island	Fiji
LBS	Labasa Airport	Labasa	Fiji
TVU	Matei Airport	Matei	Fiji
KXF	Koro Island Airport	Koro Island	Fiji
RTA	Rotuma Airport	Rotuma	Fiji
SVU	Savusavu Airport	Savusavu	Fiji
KAY	Wakaya Island Airport	Wakaya Island	Fiji
ONU	Ono-i-Lau Airport	Ono-i-Lau	Fiji
YAS	Yasawa Island Airport	Yasawa Island	Fiji
EUA	Kaufana Airport	Eua Island	Tonga
TBU	Fua'amotu International Airport	Nuku'alofa	Tonga
HPA	Lifuka Island Airport	Lifuka	Tonga
NFO	Mata'aho Airport	Angaha, Niuafo'ou Island	Tonga
NTT	Kuini Lavenia Airport	Niuatoputapu	Tonga
VAV	Vava'u International Airport	Vava'u Island	Tonga
TTL	Turtle Island Seaplane Base	Nanuya Levu Island	Fiji
VBV	Vanua Balavu Airport	Vanua Balavu	Fiji
VTF	Vatulele Airport	Vatulele	Fiji
GMO	Gombe Lawanti International Airport	Gombe	Nigeria
PHG	Port Harcourt City Airport / Port Harcourt Air Force Base	Port Harcourt	Nigeria
QRW	Warri Airport	Warri	Nigeria
ABF	Abaiang Airport	Abaiang	Kiribati
BEZ	Beru Airport	Beru	Kiribati
FUN	Funafuti International Airport	Funafuti	Tuvalu
KUC	Kuria Airport	Kuria	Kiribati
MNK	Maiana Airport	Maiana	Kiribati
MZK	Marakei Airport	Marakei	Kiribati
MTK	Makin Island Airport	Makin Island	Kiribati
NIG	Nikunau Airport	Nikunau	Kiribati
OOT	Onotoa Airport	Onotoa	Kiribati
TRW	Bonriki International Airport	Tarawa	Kiribati
AEA	Abemama Airport	Abemama	Kiribati
TBF	Tabiteuea North Airport		Kiribati
TMN	Tamana Island Airport	Tamana Island	Kiribati
NON	Nonouti Airport	Nonouti	Kiribati
AIS	Arorae Island Airport	Arorae Island	Kiribati
TSU	Tabiteuea South Airport	Tabiteuea South	Kiribati
BBG	Butaritari Airport	Butaritari	Kiribati
AAK	Aranuka Airport	Buariki	Kiribati
NIK	Niokolo-Koba Airport	Niokolo-Koba National Park	Senegal
NIN	Ninilchik Airport	Ninilchik	United States
IUE	Niue International Airport	Alofi	Niue
NJJ	Nenjiang Melgen Airport	Heihe	China
NLH	Ninglang Luguhu Airport	Ninglang	China
FUT	Pointe Vele Airport	Futuna Island	Wallis & Futuna
WLS	Hihifo Airport	Wallis Island	Wallis & Futuna
HBB	Industrial Airpark	Hobbs	United States
NND	Nangade Airport	Nangade	Mozambique
NOM	Nomad River Airport	Nomad River	Papua New Guinea
NOO	Naoro Airport	Naoro Vilage	Papua New Guinea
PKR	Pokhara International Airport	Pokhara	Nepal
NPG	Nipa Airport	Nipa	Papua New Guinea
NRY	Newry Airport	Newry	Australia
OFU	Ofu Airport	Ofu	American Samoa
AAU	Asau Airport	Asau	Samoa
APW	Faleolo International Airport	Apia	Samoa
FGI	Fagali'i Airport	Apia	Samoa
FTI	Fitiuta Airport	Fitiuta Village	American Samoa
MXS	Maota Airport	Maota	Samoa
PPG	Pago Pago International Airport	Pago Pago	American Samoa
PPT	Faa'a International Airport	Papeete	French Polynesia
RMT	Rimatara Airport	Rimatara Island	French Polynesia
RUR	Rurutu Airport		French Polynesia
TUB	Tubuai Airport		French Polynesia
RVV	Raivavae Airport		French Polynesia
AAA	Anaa Airport	Anaa	French Polynesia
FGU	Fangatau Airport	Fangatau	French Polynesia
TIH	Tikehau Airport		French Polynesia
APK	Apataki Airport	Apataki	French Polynesia
REA	Reao Airport	Reao	French Polynesia
FAV	Fakarava Airport		French Polynesia
HHZ	Hikueru Airport	Hikueru	French Polynesia
XMH	Manihi Airport		French Polynesia
GMR	Totegegie Airport		French Polynesia
KKR	Kaukura Airport	Raitahiti	French Polynesia
MKP	Makemo Airport	Makemo	French Polynesia
NAU	Napuka Island Airport	Napuka Island	French Polynesia
TKV	Tatakoto Airport	Tatakoto	French Polynesia
PKP	Puka Puka Airport		French Polynesia
PUK	Pukaruha Airport	Pukaruha	French Polynesia
TKP	Takapoto Airport		French Polynesia
AXR	Arutua Airport		French Polynesia
MVT	Mataiva Airport		French Polynesia
NUK	Nukutavake Airport	Nukutavake	French Polynesia
ZTA	Tureia Airport	Tureia	French Polynesia
AHE	Ahe Airport	Ahe Atoll	French Polynesia
KHZ	Kauehi Airport	Kauehi	French Polynesia
FAC	Faaite Airport	Faaite	French Polynesia
FHZ	Fakahina Airport	Fakahina	French Polynesia
RKA	Aratika Nord Airport		French Polynesia
TJN	Takume Airport	Takume	French Polynesia
NIU	Naiu Airport	Naiu Atoll	French Polynesia
RRR	Raroia Airport	Raroia	French Polynesia
TKX	Takaroa Airport		French Polynesia
KXU	Katiu Airport	Katiu	French Polynesia
NKP	Nukutepipi Airport	Nukutepipi	French Polynesia
NHV	Nuku Hiva Airport	Nuku Hiva	French Polynesia
AUQ	Hiva Oa-Atuona Airport	Hiva Oa Island	French Polynesia
UAP	Ua Pou Airport	Ua Pou	French Polynesia
UAH	Ua Huka Airport	Ua Huka	French Polynesia
BOB	Bora Bora Airport	Motu Mute	French Polynesia
TTI	Tetiaroa Airport	Tetiaroa	French Polynesia
RGI	Rangiroa Airport		French Polynesia
HUH	Huahine-Fare Airport	Fare	French Polynesia
MOZ	Moorea Temae Airport	Moorea-Maiao	French Polynesia
HOI	Hao Airport	Otepa	French Polynesia
MAU	Maupiti Airport		French Polynesia
RFP	Raiatea Airport	Uturoa	French Polynesia
TPX	Tupai Airport	Tupai Atoll	French Polynesia
UOA	Moruroa Airport	Moruroa Atoll	French Polynesia
VHZ	Vahitahi Airport	Vahitahi	French Polynesia
NUF	Castlereagh Lake Seaplane Base	Hatton	Sri Lanka
NUG	Nuguria Airstrip	Nuguria Island	Papua New Guinea
UCC	Yucca Airstrip	Mercury	United States
MTV	Mota Lava Airport	Ablow	Vanuatu
SLH	Sola Airport	Sola	Vanuatu
TOH	Torres Airstrip	Loh/Linua	Vanuatu
EAE	Siwo Airport	Emae Island	Vanuatu
CCV	Craig Cove Airport	Craig Cove	Vanuatu
LOD	Longana Airport	Longana	Vanuatu
SSR	Sara Airport	Pentecost Island	Vanuatu
PBJ	Tavie Airport	Paama Island	Vanuatu
LPM	Lamap Airport	Lamap	Vanuatu
LNB	Lamen Bay Airport	Lamen Bay	Vanuatu
MWF	Maewo-Naone Airport	Maewo Island	Vanuatu
LNE	Lonorore Airport	Lonorore	Vanuatu
NUS	Norsup Airport	Norsup	Vanuatu
ZGU	Gaua Island Airport	Gaua Island	Vanuatu
RCL	Redcliffe Airport	Redcliffe	Vanuatu
SON	Santo Pekoa International Airport	Luganville	Vanuatu
TGH	Tongoa Airport	Tongoa Island	Vanuatu
ULB	Uléi Airport	Ambrym Island	Vanuatu
VLS	Valesdir Airport	Epi Island	Vanuatu
WLH	Walaha Airport	Walaha	Vanuatu
SWJ	Southwest Bay Airport	Malekula Island	Vanuatu
OLJ	North West Santo Airport	Olpoi	Vanuatu
AUY	Aneityum Airport	Anatom Island	Vanuatu
AWD	Aniwa Airport	Aniwa	Vanuatu
DLY	Dillon's Bay Airport	Dillon's Bay	Vanuatu
FTA	Futuna Airport	Futuna Island	Vanuatu
IPA	Ipota Airport	Ipota	Vanuatu
VLI	Bauerfield International Airport	Port Vila	Vanuatu
TAH	Tanna Airport		Vanuatu
NWT	Nowata Airport	Nowata	Papua New Guinea
TGJ	Tiga Airport	Tiga	New Caledonia
BMY	Île Art - Waala Airport	Waala	New Caledonia
KNQ	Koné Airport	Koné	New Caledonia
ILP	Île des Pins Airport	Île des Pins	New Caledonia
HLU	Nesson Airport	Houailou	New Caledonia
KOC	Koumac Airport	Koumac	New Caledonia
LIF	Lifou Airport	Lifou	New Caledonia
GEA	Nouméa Magenta Airport	Nouméa	New Caledonia
PUV	Poum / Malabou Airport	Malabou	New Caledonia
MEE	Maré Airport	Maré	New Caledonia
TOU	Touho Airport	Touho	New Caledonia
UVE	Ouvéa Airport	Ouvéa	New Caledonia
NOU	La Tontouta International Airport	Nouméa (La Tontouta)	New Caledonia
FGL	Fox Glacier Aerodrome	Fox Glacier	New Zealand
AKL	Auckland International Airport	Auckland	New Zealand
TUO	Taupo Airport	Taupo	New Zealand
AMZ	Ardmore Airport	Manurewa	New Zealand
ASG	Ashburton Aerodrome		New Zealand
CHC	Christchurch International Airport	Christchurch	New Zealand
CHT	Chatham Islands / Tuuta Airport	Te One	New Zealand
CMV	Coromandel Aerodrome		New Zealand
DGR	Dargaville Aerodrome		New Zealand
DUD	Dunedin International Airport	Dunedin	New Zealand
WHO	Franz Josef Aerodrome		New Zealand
GBZ	Great Barrier Aerodrome	Claris	New Zealand
GMN	Greymouth Airport		New Zealand
GIS	Gisborne Airport	Gisborne	New Zealand
GTN	Glentanner Airport	Glentanner Station	New Zealand
HKK	Hokitika Airfield		New Zealand
HLZ	Hamilton International Airport	Hamilton	New Zealand
WIK	Waiheke Reeve Airport		New Zealand
KBZ	Kaikoura Airport		New Zealand
KKE	Kerikeri Airport	Kerikeri	New Zealand
KKO	Kaikohe Airport	Kaikohe	New Zealand
KAT	Kaitaia Airport	Awanui	New Zealand
ALR	Alexandra Aerodrome	Alexandra	New Zealand
MTA	Matamata Glider Airport		New Zealand
MHB	Mechanics Bay Heliport	Auckland City	New Zealand
MON	Mount Cook Airport		New Zealand
MFN	Milford Sound Airport		New Zealand
MZP	Motueka Airport		New Zealand
TEU	Manapouri Airport		New Zealand
MRO	Hood Airport	Masterton	New Zealand
NPL	New Plymouth Airport	New Plymouth	New Zealand
NPE	Hawke's Bay Airport	Napier	New Zealand
NSN	Nelson Airport	Nelson	New Zealand
IVC	Invercargill Airport	Invercargill	New Zealand
OHA	RNZAF Base Ohakea		New Zealand
OAM	Oamaru Airport		New Zealand
PMR	Palmerston North Airport	Palmerston North	New Zealand
PCN	Picton Aerodrome	Koromiko	New Zealand
PPQ	Paraparaumu Airport		New Zealand
ZQN	Queenstown International Airport	Queenstown	New Zealand
RAG	Raglan Aerodrome	Raglan	New Zealand
SZS	Ryan's Creek Aerodrome	Oban	New Zealand
ROT	Rotorua Regional Airport	Rotorua	New Zealand
TRG	Tauranga Airport	Tauranga	New Zealand
TMZ	Thames Aerodrome		New Zealand
KTF	Takaka Airport		New Zealand
TKZ	Tokoroa Airfield	Tokoroa	New Zealand
THH	Taharoa Aerodrome	Taharoa	New Zealand
TIU	Timaru Airport		New Zealand
TWZ	Pukaki Airport	Twitzel	New Zealand
BHE	Woodbourne Airport	Blenheim	New Zealand
WKA	Wanaka Airport	Wanaka	New Zealand
WHK	Whakatane Airport		New Zealand
WLG	Wellington International Airport	Wellington	New Zealand
WIR	Wairoa Airport	Wairoa	New Zealand
WRE	Whangarei Airport	Whangarei	New Zealand
WSZ	Westport Airport	Westport	New Zealand
WTZ	Whitianga Airport	Whitianga	New Zealand
WAG	Wanganui Airport	Wanganui	New Zealand
NLN	Kneeland Airport	Kneeland	United States
BZF	Benton Field	Redding	United States
OAA	Shank Air Base	Baraki Barak	Afghanistan
BIN	Bamyan Airport	Bamyan	Afghanistan
BST	Bost Airport	Lashkar Gah	Afghanistan
CCN	Chaghcharan Airport	Chaghcharan	Afghanistan
SBF	Sardeh Band Airport	Sardeh Band	Afghanistan
DAZ	Darwaz Airport	Darwaz	Afghanistan
FAH	Farah Airport	Farah	Afghanistan
FBD	Fayzabad Airport	Fayzabad	Afghanistan
GRG	Gardez Airport	Gardez	Afghanistan
KWH	Khwahan Airport	Khwahan	Afghanistan
HEA	Herat - Khwaja Abdullah Ansari International Airport	Guzara	Afghanistan
OAI	Bagram Airfield	Bagram	Afghanistan
JAA	Jalalabad Airport	Jalalabad	Afghanistan
KBL	Kabul International Airport	Kabul	Afghanistan
KDH	Ahmad Shah Baba International Airport / Kandahar Airfield	Khvoshab	Afghanistan
MMZ	Maymana Zahiraddin Faryabi Airport	Maymana	Afghanistan
MZR	Mazar-i-Sharif International Airport	Mazar-i-Sharif	Afghanistan
URN	Urgun Airport	Urgun	Afghanistan
LQN	Qala-i-Naw Airport	Qala-i-Naw	Afghanistan
KUR	Razer Airport	Skazar	Afghanistan
OAS	Sharana Airstrip	Sharana	Afghanistan
OAH	Shindand Air Base	Shindand	Afghanistan
SGA	Sheghnan Airport	Shiveh	Afghanistan
TII	Tarinkot Airport	Tarinkot	Afghanistan
TQN	Taleqan Airport	Taleqan	Afghanistan
UND	Kunduz Airport	Kunduz	Afghanistan
OAZ	Camp Shorabak Airfield	Lashkar Gah	Afghanistan
ZAJ	Zaranj Airport	Zaranj	Afghanistan
BAH	Bahrain International Airport	Manama	Bahrain
OCS	Corisco International Airport	Corisco Island	Equatorial Guinea
AHB	Abha International Airport	Abha	Saudi Arabia
HOF	Al-Ahsa International Airport	Hofuf	Saudi Arabia
ABT	King Saud Bin Abdulaziz (Al Baha) Airport	Al-Baha	Saudi Arabia
BHH	Bisha Airport	Bisha	Saudi Arabia
DMM	King Fahd International Airport	Ad Dammam	Saudi Arabia
DWD	King Salman Abdulaziz Airport	Dawadmi	Saudi Arabia
DHA	King Abdulaziz Air Base	Dhahran	Saudi Arabia
GIZ	Jizan Regional Airport / King Abdullah bin Abdulaziz Airport	Jizan	Saudi Arabia
ELQ	Gassim Airport	Buraidah	Saudi Arabia
URY	Gurayat Domestic Airport	Gurayat	Saudi Arabia
HAS	Ha'il Airport	Ha'il	Saudi Arabia
QJB	Jubail Airport	Jubail	Saudi Arabia
JED	King Abdulaziz International Airport	Jeddah	Saudi Arabia
KMC	King Khaled Military City Airport	King Khaled Military City	Saudi Arabia
KMX	King Khalid Air Base	Khamis Mushait	Saudi Arabia
MED	Prince Mohammad Bin Abdulaziz Airport	Medina	Saudi Arabia
EAM	Najran Domestic Airport	Najran	Saudi Arabia
NUM	Neom Bay Airport	Sharma	Saudi Arabia
AQI	Al Qaisumah/Hafr Al Batin Airport	Qaisumah	Saudi Arabia
AKH	Prince Sultan Air Base		Saudi Arabia
RAH	Rafha Domestic Airport	Rafha	Saudi Arabia
RUH	King Khaled International Airport	Riyadh	Saudi Arabia
RAE	Arar Domestic Airport	Arar	Saudi Arabia
SHW	Sharurah Domestic Airport	Sharurah	Saudi Arabia
AJF	Al-Jawf Domestic Airport	Al-Jawf	Saudi Arabia
SLF	As-Sulayyil Airport	As-Sulayyil	Saudi Arabia
TUU	Tabuk Airport	Tabuk	Saudi Arabia
TIF	Ta’if Regional Airport	Ta’if	Saudi Arabia
TUI	Turaif Domestic Airport	Turaif	Saudi Arabia
WAE	Wadi Al Dawasir Domestic Airport	Wadi Al Dawasir	Saudi Arabia
EJH	Al Wajh Domestic Airport	Al Wajh	Saudi Arabia
YNB	Prince Abdul Mohsin bin Abdulaziz International Airport / Yanbu Airport	Yanbu	Saudi Arabia
ZUL	Zilfi Airport	Zilfi	Saudi Arabia
OGE	Ogeranang Airport		Papua New Guinea
OGM	Ogobsucum Airport	Ustupu	Panama
IAQ	Bahregan Airport	Imam Hassan	Iran
ABD	Abadan Airport	Abadan	Iran
DEF	Dezful Airport	Dezful	Iran
AKW	Aghajari Airport	Aghajari	Iran
GCH	Gachsaran Airport	Gachsaran	Iran
QMJ	Shahid Asiyaee Airport	Masjed Soleyman	Iran
OMI	Omidiyeh Airport	Omidiyeh	Iran
MRX	Mahshahr Airport	Mahshahr	Iran
AWZ	Lieutenant General Qasem Soleimani International Airport	Ahvaz	Iran
AEU	Abu Musa Island Airport	Abu Musa	Iran
BUZ	Bushehr Airport	Bushehr	Iran
KNR	Jam Airport	Jam	Iran
KIH	Kish International Airport	Kish Island	Iran
BDH	Bandar Lengeh International Airport	Bandar Lengeh	Iran
PGU	Persian Gulf International Airport	Khiyaroo	Iran
KHK	Khark Airport	Khark	Iran
SXI	Siri Airport	Siri	Iran
LVP	Lavan Airport	Lavan Airport	Iran
KSH	Shahid Ashrafi Esfahani Airport	Kermanshah	Iran
IIL	Ilam Airport	Ilam	Iran
KHD	Khoram Abad Airport		Iran
SDG	Sanandaj Airport		Iran
IFH	Hesa Airport	Hesa	Iran
KKS	Kashan Airport	Kashan	Iran
IFN	Isfahan Shahid Beheshti International Airport	Isfahan	Iran
CQD	Shahrekord Airport	Shahrekord	Iran
RAS	Sardar-e-Jangal Airport	Rasht	Iran
HDM	Hamadan Airport	Hamadan	Iran
AJK	Arak Airport	Araak	Iran
NUJ	Nojeh Air Base	Amirabad	Iran
IKA	Imam Khomeini International Airport	Tehran	Iran
THR	Mehrabad International Airport	Tehran	Iran
GZW	Qazvin Airport	Qazvin	Iran
PYK	Payam Karaj International Airport	Karaj	Iran
SNX	Semnan Municipal Airport	Semnan	Iran
BND	Bandar Abbas International Airport	Bandar Abbas	Iran
JYR	Jiroft Airport	Jiroft	Iran
KER	Ayatollah Hashemi Rafsanjani International Airport	Kerman	Iran
BXR	Bam Airport	Bam	Iran
HDR	Havadarya Airport	Bandar Abbas	Iran
GSM	Qeshm Dayrestan International Airport	Dayrestan	Iran
RJN	Rafsanjan Airport	Rafsanjan	Iran
SYJ	Sirjan Airport	Sirjan	Iran
XBJ	Birjand International Airport	Birjand	Iran
CKT	Sarakhs Airport	Sarakhs	Iran
RUD	Shahrud International Airport	Shahrud	Iran
MHD	Mashhad International Airport	Mashhad	Iran
BJB	Bojnord Airport	Bojnord	Iran
AFZ	Sabzevar National Airport	Sabzevar	Iran
TCX	Tabas Airport	Tabas	Iran
KLM	Kalaleh Airport	Kalaleh	Iran
GBT	Gorgan Airport	Gorgan	Iran
BSM	Bishe Kola Air Base	Amol	Iran
NSH	Nowshahr Airport	Nowshahr	Iran
RZR	Ramsar Airport	Ramsar	Iran
SRY	Sari Dasht-e Naz International Airport	Sari	Iran
FAZ	Fasa Airport	Fasa	Iran
JAR	Jahrom Airport	Jahrom	Iran
LRR	Lar Airport	Lar	Iran
LFM	Lamerd Airport	Lamerd	Iran
SYZ	Shiraz Shahid Dastghaib International Airport	Shiraz	Iran
YES	Yasuj Airport	Yasuj	Iran
KHY	Khoy Airport	Khoy	Iran
ADU	Ardabil Airport	Ardabil	Iran
ACP	Sahand Airport	Maragheh	Iran
PFQ	Parsabad-Moghan Airport	Parsabad	Iran
OMH	Urmia Airport	Urmia	Iran
TBZ	Tabriz International Airport	Tabriz	Iran
IMQ	Maku National Airport	Showt	Iran
JWN	Zanjan Airport	Zanjan	Iran
AZD	Shahid Sadooghi Airport	Yazd	Iran
ACZ	Zabol Airport	Zabol	Iran
ZBR	Chabahar Konarak International Airport	Konarak	Iran
ZAH	Zahedan International Airport	Zahedan	Iran
IHR	Iranshahr Airport	Iranshahr	Iran
JSK	Jask Airport	Bandar-e-Jask	Iran
AMM	Queen Alia International Airport	Amman	Jordan
ADJ	Amman Civil (Marka International) Airport	Amman	Jordan
AQJ	Aqaba King Hussein International Airport	Aqaba	Jordan
OMF	King Hussein Air College	Mafraq	Jordan
XIJ	Ahmed Al Jaber Air Base	Ahmed Al Jaber AB	Kuwait
KWI	Kuwait International Airport	Kuwait City	Kuwait
OKV	Okao Airport	Okao	Papua New Guinea
BEY	Beirut Rafic Hariri International Airport	Beirut	Lebanon
OLH	Old Harbor Airport	Old Harbor	United States
KYE	Rene Mouawad Air Base / Kleyate Airport	Tripoli	Lebanon
OLQ	Olsobip Airport	Olsobip	Papua New Guinea
BYB	Dibba Airport	Dibba al Baya	Oman
AOM	Adam Airport	Adam	Oman
DQM	Duqm International Airport	Duqm	Oman
MNH	Mussanah Airport	Al Masna'ah	Oman
AUH	Zayed International Airport	Abu Dhabi	United Arab Emirates
AZI	Al Bateen Executive Airport	Abu Dhabi	United Arab Emirates
AAN	Al Ain International Airport	Al Ain	United Arab Emirates
DHF	Al Dhafra Air Base		United Arab Emirates
XSB	Sir Bani Yas Airport	Sir Bani Yas	United Arab Emirates
DXB	Dubai International Airport	Dubai	United Arab Emirates
NHD	Al Minhad Air Base	Dubai	United Arab Emirates
DWC	Al Maktoum International Airport	Jebel Ali	United Arab Emirates
FJR	Fujairah International Airport	Fujairah	United Arab Emirates
OMN	Osmanabad Airport	Osmanabad	India
RKT	Ras Al Khaimah International Airport	Ras Al Khaimah	United Arab Emirates
SHJ	Sharjah International Airport	Sharjah	United Arab Emirates
OMY	Preah Vinhear Airport	Tbeng Meanchey	Cambodia
ONB	Ononge Airport	Onange Mission	Papua New Guinea
RMB	Buraimi Airport	Buraimi	Oman
FAU	Fahud Airport	Fahud	Oman
RNM	Qarn Alam Airport	Ghaba	Oman
JNJ	Ja'Aluni Airport	Duqm	Oman
KHS	Khasab Airport	Khasab	Oman
LKW	Lekhwair Airport	Lekhwair	Oman
MSH	RAFO Masirah	Masirah	Oman
MCT	Muscat International Airport	Muscat	Oman
OMM	Marmul Airport	Marmul	Oman
SLL	Salalah Airport	Salalah	Oman
OHS	Sohar Airport	Sohar	Oman
TTH	Thumrait Air Base	Thumrait	Oman
DDU	Dadu West Airport	Dadu	Pakistan
BHW	Bhagatanwala Airport	Bhagatanwala	Pakistan
BNP	Bannu Airport	Bannu	Pakistan
WGB	Bahawalnagar Airport	Bahawalnagar	Pakistan
BHV	Bahawalpur Airport	Bahawalpur	Pakistan
CJL	Chitral Airport	Chitral	Pakistan
CHB	Chilas Airport	Chilas	Pakistan
DBA	Dalbandin Airport	Dalbandin	Pakistan
DEA	Dera Ghazi Khan Airport	Dera Ghazi Khan	Pakistan
DSK	Dera Ismael Khan Airport	Dera Ismael Khan	Pakistan
LYP	Faisalabad International Airport	Faisalabad	Pakistan
GWD	Gwadar International Airport	Gwadar	Pakistan
GIL	Gilgit Airport	Gilgit	Pakistan
ISB	Islamabad International Airport	Attock	Pakistan
JAG	Shahbaz Air Base	Jacobabad	Pakistan
KHI	Jinnah International Airport	Karachi	Pakistan
HDD	Hyderabad Airport	Hyderabad	Pakistan
KDD	Khuzdar Airport	Khuzdar	Pakistan
OHT	Kohat Airport	Kohat	Pakistan
LHE	Allama Iqbal International Airport	Lahore	Pakistan
LRG	Loralai Airport	Loralai	Pakistan
XJM	Mangla Airport	Mangla	Pakistan
MFG	Muzaffarabad Airport	Muzaffarabad	Pakistan
MWD	Mianwali Air Base	Mianwali	Pakistan
MJD	Moenjodaro Airport	Moenjodaro	Pakistan
MPD	Sindhri Tharparkar Airport	Sindhri	Pakistan
ATG	Minhas Air Base	Kamra	Pakistan
MUX	Multan International Airport	Multan	Pakistan
WNS	Shaheed Benazirabad Airport	Nawabashah	Pakistan
ORW	Ormara Airport	Ormara Raik	Pakistan
PAJ	Parachinar Airport	Parachinar	Pakistan
PJG	Panjgur Airport	Panjgur	Pakistan
PSI	Pasni Airport	Pasni	Pakistan
PEW	Peshawar International Airport	Peshawar	Pakistan
UET	Quetta International Airport	Quetta	Pakistan
RYK	Shaikh Zaid Airport	Rahim Yar Khan	Pakistan
RAZ	Rawalakot Airport	Rawalakot	Pakistan
SBQ	Sibi Airport	Sibi	Pakistan
KDU	Skardu Airport	Skardu	Pakistan
SKZ	Sukkur Airport	Mirpur Khas	Pakistan
SYW	Sehwan Sharif Airport	Sehwan Sharif	Pakistan
SGI	Mushaf Air Base	Sargodha	Pakistan
SDT	Saidu Sharif Airport	Saidu Sharif	Pakistan
SKT	Sialkot International Airport	Sialkot	Pakistan
SUL	Sui Airport	Sui	Pakistan
RZS	Sawan Airport	Sawan Gas Field	Pakistan
TLB	Tarbela Dam Airport	Tarbela	Pakistan
BDN	Talhar Airport	Badin	Pakistan
TFT	Taftan Airport	Taftan	Pakistan
TUK	Turbat International Airport	Turbat	Pakistan
WAF	Wana Airport	Waana	Pakistan
PZH	Zhob Airport	Fort Sandeman	Pakistan
IQA	Al Asad Air Base	Hīt	Iraq
TQD	Al Taqaddum Air Base	Al Habbaniyah	Iraq
BMN	Bamarni Airport	Bamarni	Iraq
BGW	Baghdad International Airport / New Al Muthana Air Base	Baghdad	Iraq
OSM	Mosul International Airport	Mosul	Iraq
EBL	Erbil International Airport	Arbil	Iraq
ORI	Port Lions Airport	Port Lions	United States
KIK	Kirkuk Air Base	Kirkuk	Iraq
BSR	Basra International Airport	Basra	Iraq
NJF	Al Najaf International Airport	Najaf	Iraq
RQW	Qayyarah West Airport	Qayyarah	Iraq
ISU	Sulaymaniyah International Airport	Sulaymaniyah	Iraq
XNH	Ali Air Base	Nasiriyah	Iraq
ALP	Aleppo International Airport	Aleppo	Syria
DAM	Damascus International Airport	Damascus	Syria
DEZ	Deir ez-Zor Airport	Deir ez-Zor	Syria
OSE	Omora Airport	Omora	Papua New Guinea
OSG	Ossima Airport	Ossima	Papua New Guinea
KAC	Qamishli Airport	Qamishly	Syria
LTK	Hmeimim Air Base	Latakia	Syria
PMS	Palmyra Airport	Tadmur	Syria
DIA	Doha International Airport	Doha	Qatar
XJD	Al Udeid Air Base	Ar Rayyan	Qatar
DOH	Hamad International Airport	Doha	Qatar
OTT	Andre Maggi Airport	Cotriguaçu	Brazil
OUM	Oum Hadjer Airport	Oum Hadjer	Chad
OXO	Orientos Airport	Orientos	Australia
ADE	Aden International Airport	Aden	Yemen
EAB	Abs Airport	Abs	Yemen
AXK	Ataq Airport	Ataq	Yemen
BYD	Al-Bayda Airport	Al-Bayda	Yemen
BHN	Beihan Airport	Beihan	Yemen
BUK	Al-Bough Airport	Al-Bough	Yemen
AAY	Al Ghaydah International Airport	Al Ghaydah	Yemen
HOD	Hodeidah International Airport	Hodeida	Yemen
KAM	Kamaran Airport	Kamaran	Yemen
MYN	Marib Airport	Marib	Yemen
UKR	Mukeiras Airport	Mukayras	Yemen
IHN	Qishn Airport	Qishn	Yemen
RIY	Riyan Mukalla International Airport	Riyan	Yemen
SYE	Sadah Airport	Sa'dah	Yemen
SAH	Sana'a International Airport	Sana'a	Yemen
SCT	Socotra International Airport	Socotra Islands	Yemen
GXF	Seiyun Hadhramaut International Airport	Seiyun	Yemen
TAI	Ta'izz International Airport	Ta'izz	Yemen
OZG	Zagora Airport	Zagora	Morocco
ACU	Achutupu Airport	Mamitupu	Panama
AIL	Ailigandí Airport	Isla Lorenzo Bello	Panama
CTE	Carti Airport	Carti	Panama
MPP	Mulatupo Airport	Mulatupo	Panama
PYC	Playón Chico Airport	Ukupseni	Panama
NMG	San Miguel Airport	Isla del Rey	Panama
TUW	Tubualá Airport	Coetupo	Panama
PYV	Yaviza Airport	Yaviza	Panama
AML	Puerto Armuelles Airport	Puerto Armuelles	Panama
BFQ	Bahia Piña Airport	Puerto Piña	Panama
ELE	EL Real Airport	El Real de Santa María	Panama
OTD	Raul Arias Espinoza Airport	Contadora Island	Panama
SAX	Sambú Airport	Boca de Sábalo	Panama
AKB	Atka Airport	Atka	United States
PML	Port Moller Airport	Cold Bay	United States
PTD	Port Alexander Seaplane Base	Port Alexander	United States
PAQ	Warren "Bud" Woods Palmer Municipal Airport	Palmer	United States
ATU	Casco Cove Coast Guard Station	Attu	United States
BTI	Barter Island Long Range Radar Station Airport	Barter Island	United States
BET	Bethel Airport	Bethel	United States
BVU	Beluga Airport	Beluga	United States
BIG	Allen Army Airfield	Delta Junction Ft Greely	United States
BKC	Buckland Airport	Buckland	United States
BMX	Big Mountain Airport	Big Mountain	United States
BRW	Wiley Post Will Rogers Memorial Airport	Utqiaġvik	United States
BTT	Bettles Airport	Bettles	United States
CDB	Cold Bay Airport	Cold Bay	United States
CEM	Central Airport	Central	United States
CIK	Chalkyitsik Airport	Chalkyitsik	United States
CYF	Chefornak Airport	Chefornak	United States
SCM	Scammon Bay Airport	Scammon Bay	United States
IRC	Circle City (New) Airport	Circle	United States
WSF	Cape Sarichef Airport	Cape Sarichef	United States
CDV	Merle K (Mudhole) Smith Airport	Cordova	United States
CXF	Coldfoot Airport	Coldfoot	United States
CYT	Yakataga Airport	Yakataga	United States
CZF	Cape Romanzof LRRS Airport	Cape Romanzof	United States
DRG	Deering Airport	Deering	United States
RDB	Red Dog Airport	Red Dog	United States
ADK	Adak Airport	Adak	United States
DLG	Dillingham Airport	Dillingham	United States
MLL	Marshall Don Hunter Sr Airport	Marshall	United States
ADQ	Kodiak Airport	Kodiak	United States
DUT	Tom Madsen (Dutch Harbor) Airport	Unalaska	United States
KKH	Kongiganak Airport	Kongiganak	United States
EDF	Elmendorf Air Force Base	Anchorage	United States
EEK	Eek Airport	Eek	United States
EAA	Eagle Airport	Eagle	United States
EHM	Cape Newenham LRRS Airport	Cape Newenham	United States
EIL	Eielson Air Force Base	Fairbanks	United States
ELV	Elfin Cove Seaplane Base	Elfin Cove	United States
EMK	Emmonak Airport	Emmonak	United States
ENA	Kenai Municipal Airport	Kenai	United States
FAI	Fairbanks International Airport	Fairbanks	United States
FBK	Ladd Army Airfield	Fairbanks	United States
ABL	Ambler Airport	Ambler	United States
FRN	Bryant Army Airfield	Fort Richardson	United States
NIB	Nikolai Airport	Nikolai	United States
FWL	Farewell Airport	Farewell	United States
GAL	Edward G. Pitka Sr Airport	Galena	United States
GBH	Galbraith Lake Airport	Galbraith Lake	United States
KWK	Kwigillingok Airport	Kwigillingok	United States
SHG	Shungnak Airport	Shungnak	United States
GKN	Gulkana Airport	Gulkana	United States
GLV	Golovin Airport	Golovin	United States
GAM	Gambell Airport	Gambell	United States
AGN	Angoon Seaplane Base	Angoon	United States
BGQ	Big Lake Airport	Big Lake	United States
GST	Gustavus Airport	Gustavus	United States
NME	Nightmute Airport	Nightmute	United States
SGY	Skagway Airport	Skagway	United States
HCR	Holy Cross Airport	Holy Cross	United States
HSL	Huslia Airport	Huslia	United States
HNS	Haines Airport	Haines	United States
HOM	Homer Airport	Homer	United States
HPB	Hooper Bay Airport	Hooper Bay	United States
HUS	Hughes Airport	Hughes	United States
SHX	Shageluk Airport	Shageluk	United States
HYG	Hydaburg Seaplane Base	Hydaburg	United States
IGG	Igiugig Airport	Igiugig	United States
EGX	Egegik Airport	Egegik	United States
IAN	Bob Baker Memorial Airport	Kiana	United States
ILI	Iliamna Airport	Iliamna	United States
UTO	Indian Mountain LRRS Airport	Utopia Creek	United States
MCL	Denali National Park Airport	Denali Park	United States
WAA	Wales Airport	Wales	United States
KCG	Chignik Airport	Chignik	United States
JNU	Juneau International Airport	Juneau	United States
KGK	Koliganek Airport	Koliganek	United States
KDK	Kodiak Municipal Airport	Kodiak	United States
KFP	False Pass Airport	False Pass	United States
AKK	Akhiok Airport	Akhiok	United States
KPN	Kipnuk Airport	Kipnuk	United States
KKA	Koyuk Alfred Adams Airport	Koyuk	United States
LKK	Kulik Lake Airport	Kulik Lake	United States
AKN	King Salmon Airport	King Salmon	United States
IKO	Nikolski Air Station	Nikolski	United States
AKP	Anaktuvuk Pass Airport	Anaktuvuk Pass	United States
KTN	Ketchikan International Airport	Ketchikan	United States
UUK	Ugnu-Kuparuk Airport	Kuparuk	United States
KAL	Kaltag Airport	Kaltag	United States
KLW	Klawock Airport	Klawock	United States
KYK	Karluk Airport	Karluk	United States
KLN	Larsen Bay Airport	Larsen Bay	United States
KLG	Kalskag Airport	Kalskag	United States
WCR	Chandalar Lake Airport	Chandalar Lake	United States
LUR	Cape Lisburne LRRS Airport	Cape Lisburne	United States
KMO	Manokotak Airport	Manokotak	United States
MCG	McGrath Airport	McGrath	United States
MDO	Middleton Island Airport	Middleton Island	United States
LMA	Minchumina Airport	Minchumina	United States
SMK	St Michael Airport	St Michael	United States
MLY	Manley Hot Springs Airport	Manley Hot Springs	United States
MTM	Metlakatla Seaplane Base	Metlakatla	United States
MOU	Mountain Village Airport	Mountain Village	United States
MRI	Merrill Field	Anchorage	United States
MXY	Mc Carthy Airport	Mccarthy	United States
MYU	Mekoryuk Airport	Mekoryuk	United States
WNA	Napakiak Airport	Napakiak	United States
ANC	Ted Stevens Anchorage International Airport	Anchorage	United States
ANI	Aniak Airport	Aniak	United States
ENN	Nenana Municipal Airport	Nenana	United States
NNL	Nondalton Airport	Nondalton	United States
FNR	Funter Bay Seaplane Base	Funter Bay	United States
ANN	Annette Island Airport	Metlakatla	United States
NUL	Nulato Airport	Nulato	United States
ANV	Anvik Airport	Anvik	United States
KNW	New Stuyahok Airport	New Stuyahok	United States
OBU	Kobuk Airport	Kobuk	United States
PCA	Portage Creek Airport	Portage Creek	United States
HNH	Hoonah Airport	Hoonah	United States
OME	Nome Airport	Nome	United States
OOK	Toksook Bay Airport	Toksook Bay	United States
ORT	Northway Airport	Northway	United States
OTZ	Ralph Wien Memorial Airport	Kotzebue	United States
NLG	Nelson Lagoon Airport	Nelson Lagoon	United States
STG	St George Airport	St George	United States
KPC	Port Clarence Coast Guard Station	Port Clarence	United States
KPV	Perryville Airport	Perryville	United States
PSG	Petersburg James A Johnson Airport	Petersburg	United States
PTH	Port Heiden Airport	Port Heiden	United States
PKA	Napaskiak Airport	Napaskiak	United States
PTU	Platinum Airport	Platinum	United States
PIP	Pilot Point Airport	Pilot Point	United States
PHO	Point Hope Airport	Point Hope	United States
PPC	Prospect Creek Airport	Prospect Creek	United States
KWN	Quinhagak Airport	Quinhagak	United States
NUI	Nuiqsut Airport	Nuiqsut	United States
ARC	Arctic Village Airport	Arctic Village	United States
RSH	Russian Mission Airport	Russian Mission	United States
RBY	Ruby Airport	Ruby	United States
SVA	Savoonga Airport	Savoonga	United States
SCC	Deadhorse Airport	Deadhorse	United States
SDP	Sand Point Airport	Sand Point	United States
SHH	Shishmaref Airport	Shishmaref	United States
SIT	Sitka Rocky Gutierrez Airport	Sitka	United States
WLK	Selawik Airport	Selawik	United States
SLQ	Sleetmute Airport	Sleetmute	United States
KSM	St Mary's Airport	St Mary's	United States
SNP	St Paul Island Airport	St Paul Island	United States
SOV	Seldovia Airport	Seldovia	United States
SMU	Sheep Mountain Airport	Sheep Mountain	United States
UMM	Summit Airport	Cantwell	United States
SVW	Sparrevohn LRRS Airport	Sparrevohn	United States
SKW	Skwentna Airport	Skwentna	United States
SXQ	Soldotna Airport	Soldotna	United States
SYA	Eareckson Air Station	Shemya	United States
TAL	Ralph M Calhoun Memorial Airport	Tanana	United States
TNC	Tin City Long Range Radar Station Airport	Tin City	United States
TLA	Teller Airport	Teller	United States
TOG	Togiak Airport	Togiak Village	United States
TKA	Talkeetna Airport	Talkeetna	United States
TLJ	Tatalina LRRS Airport	Takotna	United States
ATK	Atqasuk Edward Burnell Sr Memorial Airport	Atqasuk	United States
AUK	Alakanuk Airport	Alakanuk	United States
UMT	Umiat Airport	Umiat	United States
UNK	Unalakleet Airport	Unalakleet	United States
WOW	Willow Airport	Willow	United States
KQA	Akutan Airport	Akutan	United States
VAK	Chevak Airport	Chevak	United States
KVC	King Cove Airport	King Cove	United States
VDZ	Valdez Pioneer Field	Valdez	United States
VEE	Venetie Airport	Venetie	United States
KVL	Kivalina Airport	Kivalina	United States
WBQ	Beaver Airport	Beaver	United States
SWD	Seward Airport	Seward	United States
WRG	Wrangell Airport	Wrangell	United States
AIN	Wainwright Airport	Wainwright	United States
WMO	White Mountain Airport	White Mountain	United States
WTK	Noatak Airport	Noatak	United States
WWA	Wasilla Airport	Wasilla	United States
YAK	Yakutat Airport	Yakutat	United States
CIS	Canton Island Airport	Abariringa	Kiribati
PCQ	Boun Neau Airport	Phongsaly	Laos
PDI	Pindiu Airport	Pindiu	Papua New Guinea
PDR	Presidente José Sarney Airport	Presidente Dutra	Brazil
PTL	Walter Braedt Segú Airport	Máncora	Peru
PEB	Pebane Airport	Pebane	Mozambique
PEC	Pelican Seaplane Base	Pelican	United States
AKI	Akiak Airport	Akiak	United States
AET	Allakaket Airport	Allakaket	United States
PFC	Pacific City State Airport	Pacific City	United States
NCN	Chenega Bay Airport	Chenega	United States
CLP	Clarks Point Airport	Clarks Point	United States
ELI	Elim Airport	Elim	United States
KUK	Kasigluk Airport	Kasigluk	United States
KNK	Kokhanok Airport	Kokhanok	United States
KOT	Kotlik Airport	Kotlik	United States
KTS	Brevig Mission Airport	Brevig Mission	United States
KYU	Koyukuk Airport	Koyukuk	United States
KWT	Kwethluk Airport	Kwethluk	United States
ORV	Robert (Bob) Curtis Memorial Airport	Noorvik	United States
SKK	Shaktoolik Airport	Shaktoolik	United States
TKJ	Tok Junction Airport	Tok	United States
WSN	South Naknek Number 2 Airport	South Naknek	United States
FYU	Fort Yukon Airport	Fort Yukon	United States
CPN	Cape Rodney Airport	Cape Rodney	Papua New Guinea
EMI	Emirau Airport	Emirau Island	Papua New Guinea
ERE	Erave Airport	Erave	Papua New Guinea
ESA	Esa'ala Airport	Esa'ala	Papua New Guinea
GAR	Garaina Airport	Garaina	Papua New Guinea
GOE	Gonaili Airport	Gonaili	Papua New Guinea
BPD	Bapi Airstrip	Bapi	Papua New Guinea
BPK	Biangabip Airport	Biangabip	Papua New Guinea
MZN	Minj Airport	Minj	Papua New Guinea
SGK	Sengapi Airstrip	Sengapi	Papua New Guinea
KII	Kibuli Airstrip	Kibuli	Papua New Guinea
SMP	Stockholm Landing Strip	Stockholm	Papua New Guinea
BRH	Brahman Airstrip	Brahman Mission	Papua New Guinea
BIJ	Biliau Airport		Papua New Guinea
AKG	Anguganak Airport	Anguganak	Papua New Guinea
TAJ	Tadji Airport	Aitape	Papua New Guinea
AWB	Awaba Airport	Awaba	Papua New Guinea
BAA	Bialla Airport	Bialla, Matalilu, Ewase	Papua New Guinea
CVB	Chungribu Airport	Chungribu	Papua New Guinea
GMI	Gasmata Island Airport	Gasmata Island	Papua New Guinea
GVI	Green River Airport	Green River	Papua New Guinea
HYF	Hayfields Airport	Bainyik	Papua New Guinea
IHU	Ihu Airport	Ihu	Papua New Guinea
IIS	Nissan Island Airport	Nissan Island	Papua New Guinea
JAQ	Jacquinot Bay Airport	Jacquinot Bay	Papua New Guinea
KDR	Kandrian Airport	Kandrian	Papua New Guinea
KKD	Kokoda Airport	Kokoda	Papua New Guinea
KUY	Kamusi Airport	Kamusi	Papua New Guinea
KWO	Kawito Airport	Kawito	Papua New Guinea
LMI	Lumi Airport	Lumi	Papua New Guinea
LMY	Lake Murray Airport	Lake Murray	Papua New Guinea
OBX	Obo Airport	Obo	Papua New Guinea
OPU	Balimo Airport	Balimo	Papua New Guinea
SKC	Suki Airport	Suki	Papua New Guinea
TFI	Tufi Airport	Tufi	Papua New Guinea
TFM	Telefomin Airport	Telefomin	Papua New Guinea
TLO	Tol Airport	Tol	Papua New Guinea
UKU	Nuku Airport	Nuku	Papua New Guinea
ULE	Sule Airport	Sule	Papua New Guinea
VMU	Baimuru Airport	Baimuru	Papua New Guinea
WPM	Wipim Airport	Wipim	Papua New Guinea
PGE	Yegepa Airport		Papua New Guinea
PGM	Port Graham Airport	Port Graham	United States
ROP	Rota International Airport	Rota Island	Northern Mariana Islands
SPN	Saipan International Airport	I Fadang, Saipan	Northern Mariana Islands
UAM	Andersen Air Force Base	Yigo	Guam
GUM	Antonio B. Won Pat International Airport	Hagåtña	Guam
TIQ	Tinian International Airport	Tinian Island	Northern Mariana Islands
CGY	Laguindingan International Airport	Cagayan de Oro	Philippines
LLC	Cagayan North International Airport	Lal-lo	Philippines
TGB	Tagbita Airstrip	Rizal	Philippines
ENI	El Nido Airport	El Nido	Philippines
BKH	Barking Sands Airport	Kekaha	United States
HDH	Kawaihapai Airfield	Mokuleia	United States
HHI	Wheeler Army Airfield	Wahiawa	United States
HNM	Hana Airport	Hana	United States
HIK	Hickam Air Force Base	Honolulu	United States
JHM	Kapalua Airport	Lahaina	United States
JRF	Kalaeloa Airport	Kapolei	United States
KOA	Ellison Onizuka Kona International Airport at Keahole	Kailua-Kona	United States
LIH	Lihue Airport	Lihue	United States
LUP	Kalaupapa Airport	Kalaupapa	United States
MKK	Molokai Airport	Kaunakakai	United States
MUE	Waimea Kohala Airport	Waimea (Kamuela)	United States
NGF	Kaneohe Bay MCAS (Marion E. Carl Field) Airport	Kaneohe	United States
HNL	Daniel K Inouye International Airport	Honolulu	United States
LNY	Lanai Airport	Lanai City	United States
OGG	Kahului International Airport	Kahului	United States
PAK	Port Allen Airport	Hanapepe	United States
BSF	Bradshaw Army Airfield	Waimea (Kamuela)	United States
ITO	Hilo International Airport	Hilo	United States
UPP	Upolu Airport	Hawi	United States
BHC	Bhurban Heliport	Bhurban	Pakistan
CWP	Campbellpore Airport	Campbellpore	Pakistan
GRT	Gujrat Airport	Gujrat	Pakistan
KCF	Kadanwari Airport	Kadanwari	Pakistan
REQ	Reko Diq Airport	Chagai	Pakistan
ENT	Eniwetok Airport	Eniwetok Atoll	Marshall Islands
MAJ	Marshall Islands International Airport	Majuro Atoll	Marshall Islands
KAI	Kaieteur International Airport	Kaieteur Falls	Guyana
KWA	Bucholz Army Air Field	Kwajalein	Marshall Islands
CXI	Cassidy International Airport	Kiritimati	Kiribati
PLE	Paiela Airport	Paiela	Papua New Guinea
TNV	Tabuaeran Island Airport	Tabuaeran Island	Kiribati
TNQ	Washington Island Airstrip	Teraina	Kiribati
MDY	Henderson Field	Sand Island	U.S. Outlying Islands
PMP	Pimaga Airport	Pimaga	Papua New Guinea
PIZ	Point Lay LRRS Airport	Point Lay	United States
PPX	Param Airport	Nepesi	Papua New Guinea
PQD	Passikudah Helipad	Batticaloa	Sri Lanka
HUC	Dr Hermenegildo Ortiz Quinones Airport	Humacao	Puerto Rico
XSO	Siocon Airport	Siocon	Philippines
TKK	Chuuk International Airport	Weno Island	Micronesia
PNI	Pohnpei International Airport	Pohnpei Island	Micronesia
ROR	Babelthuap Airport	Babelthuap Island	Palau
KSA	Kosrae International Airport	Okat	Micronesia
YAP	Yap International Airport	Yap Island	Micronesia
PUA	Puas Airport	Puas Mission	Papua New Guinea
AWK	Wake Island Airfield	Wake Island	U.S. Outlying Islands
PWR	Port Walter Seaplane Base	Port Walter	United States
BFA	Aeródromo de Bahía Negra	Bahía Negra	Paraguay
OLK	Fuerte Olimpo Airport	Fuerte Olimpo	Paraguay
PBT	Aeródromo de Puerto Leda	Puerto Leda	Paraguay
PCJ	Aeródromo de Puerto La Victoria	Puerto La Victoria	Paraguay
PYL	Perry Island Seaplane Base	Perry Island	United States
KIO	Kili Airport	Kili Island	Marshall Islands
QFX	Igaliku Heliport	Igaliku	Greenland
QJP	Pocheon (G-217) Airport	Pocheon	South Korea
RAA	Rakanda Airport	Rakanda	Papua New Guinea
RAW	Arawa Airport	Arawa	Papua New Guinea
RAX	Oram Airport		Papua New Guinea
RBP	Raba Raba Airport	Rabaraba	Papua New Guinea
KNH	Kinmen Airport	Shang-I	Taiwan
LZN	Matsu Nangan Airport	Matsu (Nangan)	Taiwan
TTT	Taitung Airport	Taitung City	Taiwan
GNI	Lyudao Airport	Lyudao	Taiwan
KHH	Kaohsiung International Airport	Kaohsiung (Xiaogang)	Taiwan
CYI	Chiayi Airport	Chiayi City	Taiwan
HCN	Hengchun Airport	Hengchung	Taiwan
KYD	Lanyu Airport	Orchid Island	Taiwan
RMQ	Taichung International Airport / Ching Chuang Kang Air Base	Taichung (Qingshui)	Taiwan
MFK	Matsu Beigan Airport	Matsu (Beigan)	Taiwan
TNN	Tainan International Airport / Tainan Air Base	Tainan (Rende)	Taiwan
HSZ	Hsinchu Air Base	Hsinchu City	Taiwan
MZG	Penghu Magong Airport	Huxi	Taiwan
PIF	Pingtung North Airport	Pingtung	Taiwan
TSA	Taipei Songshan Airport	Taipei City	Taiwan
TPE	Taiwan Taoyuan International Airport	Taoyuan	Taiwan
WOT	Wang'an Airport	Wang'an	Taiwan
HUN	Hualien Airport	Hualien City	Taiwan
RDV	Red Devil Airport	Red Devil	United States
RHR	Ras al Khaimah Al Hamra Seaplane Base	Ras Al Khaimah	United Arab Emirates
RHT	Alxa Right Banner Badanjilin Airport	Badanjilin	China
NRT	Narita International Airport	Narita	Japan
MMJ	Shinshu-Matsumoto Airport	Matsumoto	Japan
IBR	Ibaraki Airport / JASDF Hyakuri Air Base	Omitama	Japan
MUS	JMSDF Minami Torishima Air Base	Ogasawara	Japan
IWO	Ioto (Iwo Jima) Airbase	Ogasawara	Japan
KIX	Kansai International Airport	Osaka	Japan
SHM	Nanki Shirahama Airport	Shirahama	Japan
UKB	Kobe Airport	Kobe	Japan
HIW	Hiroshima Heliport	Hiroshima	Japan
TJH	Konotori Tajima Airport	Toyooka	Japan
OBO	Tokachi-Obihiro Airport	Obihiro	Japan
CTS	New Chitose Airport	Sapporo	Japan
HKD	Hakodate Airport	Hakodate	Japan
KUH	Kushiro Airport	Kushiro	Japan
MMB	Memanbetsu Airport	Ōzora	Japan
SHB	Nakashibetsu Airport	Nakashibetsu	Japan
OKD	Sapporo Okadama Airport	Sapporo	Japan
RBJ	Rebun Airport	Rebun	Japan
WKJ	Wakkanai Airport	Wakkanai	Japan
AXJ	Amakusa Airport	Amakusa	Japan
IKI	Iki Airport	Iki	Japan
UBJ	Yamaguchi Ube Airport	Ube	Japan
TSJ	Tsushima Airport	Tsushima	Japan
OMJ	JMSDF Omura Air Base	Nagasaki	Japan
MBE	Monbetsu Airport	Monbetsu	Japan
AKJ	Asahikawa Airport	Higashikagura	Japan
OIR	Okushiri Airport	Okushiri Island	Japan
RIS	Rishiri Airport	Rishiri	Japan
KUM	Yakushima Airport	Yakushima	Japan
FUJ	Fukue Airport	Goto	Japan
FUK	Fukuoka Airport	Fukuoka	Japan
TNE	New Tanegashima Airport	Tanegashima	Japan
KOJ	Kagoshima Airport	Kagoshima	Japan
KMI	Miyazaki Airport	Miyazaki	Japan
OIT	Oita Airport	Oita	Japan
KKJ	Kitakyushu Airport	Kitakyushu	Japan
HSG	Saga Airport	Saga	Japan
KMJ	Kumamoto Airport	Kumamoto	Japan
NGS	Nagasaki Airport	Nagasaki	Japan
NGO	Chubu Centrair International Airport	Tokoname	Japan
ASJ	Amami Airport	Amami	Japan
OKE	Okinoerabu Airport	Wadomari	Japan
KKX	Kikai Airport	Kikai	Japan
TKN	Tokunoshima Airport	Amagi	Japan
NKM	Nagoya Airport / JASDF Komaki Air Base	Nagoya	Japan
FKJ	Fukui Airport		Japan
QGU	Gifu Airport	Gifu	Japan
KMQ	Komatsu Airport / JASDF Komatsu Air Base	Kanazawa	Japan
OKI	Oki Global Geopark Airport	Okinoshima	Japan
FSZ	Mount Fuji Shizuoka Airport	Makinohara / Shimada	Japan
TOY	Toyama Airport	Toyama	Japan
NTQ	Noto Satoyama Airport	Wajima	Japan
HIJ	Hiroshima Airport	Hiroshima	Japan
OKJ	Okayama Momotaro Airport	Okayama	Japan
IZO	Izumo Enmusubi Airport	Izumo	Japan
YGJ	Yonago Kitaro Airport / JASDF Miho Air Base	Yonago	Japan
IWK	Iwakuni Kintaikyo Airport / Marine Corps Air Station Iwakuni	Iwakuni	Japan
KCZ	Kochi Ryoma Airport	Nankoku	Japan
MYJ	Matsuyama Airport	Matsuyama	Japan
ITM	Osaka International Airport	Osaka	Japan
TTJ	Tottori Sand Dunes Conan Airport	Tottori	Japan
TKS	Tokushima Awaodori Airport / JMSDF Tokushima Air Base	Tokushima	Japan
TAK	Takamatsu Airport	Takamatsu	Japan
IWJ	Iwami Airport	Masuda	Japan
AOJ	Aomori Airport	Aomori	Japan
GAJ	Yamagata Airport	Higashine	Japan
SDS	Sado Airport	Sado	Japan
FKS	Fukushima Airport	Sukagawa	Japan
HHE	JMSDF Hachinohe Air Base / Hachinohe Airport	Hachinohe	Japan
HNA	Iwate Hanamaki Airport	Hanamaki	Japan
AXT	Akita Airport	Akita	Japan
MSJ	Misawa Airport / Misawa Air Base	Misawa	Japan
KIJ	Niigata Airport	Niigata	Japan
ONJ	Odate Noshiro Airport	Kitaakita	Japan
SDJ	Sendai Airport	Natori	Japan
SYO	Shonai Airport	Shonai	Japan
NJA	JMSDF Atsugi Air Base / Naval Air Facility Atsugi	Ayase / Yamato	Japan
HAC	Hachijojima Airport	Hachijojima	Japan
OIM	Oshima Airport	Izu Oshima	Japan
MYE	Miyakejima Airport	Miyakejima	Japan
HND	Tokyo Haneda International Airport	Tokyo	Japan
OKO	Yokota Air Base	Fussa	Japan
MWX	Muan International Airport	Muan (Piseo-ri)	South Korea
KWJ	Gwangju Airport	Gwangju	South Korea
KUV	Gunsan Airport / Gunsan Air Base	Gunsan	South Korea
CHN	Jeonju (G 703) Air Base	Jeonju	South Korea
RSU	Yeosu Airport	Yeosu	South Korea
KAG	Gangneung Airport (K-18)	Gangneung	South Korea
WJU	Wonju Airport / Hoengseong Air Base (K-38/K-46)	Wonju	South Korea
YNY	Yangyang International Airport	Gonghang-ro	South Korea
CJU	Jeju International Airport	Jeju City	South Korea
JDG	Jeongseok Airport	Jeju Island	South Korea
CHF	Jinhae Air Base	Jinhae	South Korea
PUS	Gimhae International Airport	Busan	South Korea
HIN	Sacheon Airport / Sacheon Air Base	Sacheon	South Korea
USN	Ulsan Airport	Ulsan	South Korea
ICN	Incheon International Airport	Seoul	South Korea
SSN	Seoul Air Base (K-16)	Seongnam	South Korea
OSN	Osan Air Base	Pyeongtaek	South Korea
GMP	Gimpo International Airport	Seoul	South Korea
SWU	Suwon Airport	Suwon	South Korea
QDY	Taean Airport	Taean	South Korea
KPO	Pohang Airport (G-815/K-3)	Pohang	South Korea
JWO	Jungwon Air Base/Chungju Airport	Gimseang-ro	South Korea
TAE	Daegu Airport	Daegu	South Korea
HMY	Seosan Air Base	Seosan	South Korea
CJJ	Cheongju International Airport/Cheongju Air Base (K-59/G-513)	Cheongju	South Korea
YEC	Yecheon Airbase	Yecheon-ri	South Korea
RKU	Kairuku Airport	Yule Island	Papua New Guinea
RKY	Rokeby Airport	Rokeby	Australia
RLP	Rosella Plains Airport	Rosella Plains	Australia
RMP	Rampart Airport	Rampart	United States
OKA	Naha Airport / JASDF Naha Air Base	Naha	Japan
DNA	Kadena Air Base		Japan
UEO	Kumejima Airport	Kumejima	Japan
KJP	Kerama Airport	Zamami	Japan
MMD	Minamidaito Airport	Minamidaito	Japan
MMY	Miyako Airport	Miyako City	Japan
AGJ	Aguni Airport	Aguni	Japan
IEJ	Iejima Airport	Ie	Japan
HTR	Hateruma Airport	Taketomi	Japan
KTD	Kitadaito Airport	Kitadaitōjima	Japan
SHI	Miyako Shimojishima Airport	Miyakojima	Japan
TRA	Tarama Airport	Tarama	Japan
RNJ	Yoron Airport	Yoron	Japan
OGN	Yonaguni Airport	Yonaguni	Japan
BSI	Balesin Island Airport	Balesin	Philippines
SFS	Subic Bay International Airport / Naval Air Station Cubi Point	Olongapo	Philippines
CRK	Clark International Airport / Clark Air Base	Mabalacat	Philippines
LAO	Laoag International Airport	Laoag City	Philippines
MNL	Ninoy Aquino International Airport	Manila (Pasay)	Philippines
CYU	Cuyo Airport	Cuyo	Philippines
SGL	Danilo Atienza Air Base	Cavite	Philippines
LBX	Lubang Airport		Philippines
AAV	Allah Valley Airport	Surallah	Philippines
CBO	Cotabato (Awang) Airport	Datu Odin Sinsuat	Philippines
DVO	Francisco Bangoy International Airport	Davao	Philippines
BXU	Bancasi Airport	Butuan	Philippines
BPH	Bislig Airport	Bislig	Philippines
DPL	Dipolog Airport	Dipolog	Philippines
CGM	Camiguin Airport	Mambajao	Philippines
IGN	Maria Cristina (Iligan) Airport	Balo-i	Philippines
JOL	Jolo Airport		Philippines
MLP	Malabang Airport	Malabang	Philippines
TWT	Sanga Sanga Airport	Bongao	Philippines
OZC	Labo Airport	Ozamiz	Philippines
PAG	Pagadian Airport	Pagadian	Philippines
MXI	Mati National Airport	Mati	Philippines
GES	General Santos International Airport	General Santos	Philippines
SUG	Surigao Airport	Surigao City	Philippines
CDY	Cagayan de Sulu Airport	Mapun	Philippines
IPE	Ipil Airport	Ipil	Philippines
TDG	Tandag Airport	Tandag	Philippines
ZAM	Zamboanga International Airport	Zamboanga City	Philippines
IAO	Siargao Airport	Del Carmen	Philippines
RZP	Cesar Lim Rodriguez (Taytay-Sandoval) Airport	Taytay	Philippines
TAG	Bohol-Panglao International Airport	Panglao	Philippines
SWL	San Vicente Airport	San Vicente	Philippines
BAG	Loakan Airport	Baguio City	Philippines
DTE	Daet Airport	Daet	Philippines
SJI	San Jose Airport	San Jose	Philippines
MBO	Mamburao Airport	Mamburao	Philippines
WNP	Naga Airport	Naga	Philippines
BSO	Basco Airport	Basco	Philippines
BQA	Dr Juan C Angara Airport	Baler	Philippines
SFE	San Fernando Airport		Philippines
TUG	Tuguegarao Airport	Tuguegarao City	Philippines
VRC	Virac Airport	Virac	Philippines
MRQ	Marinduque Airport	Gasan	Philippines
CYZ	Cauayan Airport	Cauayan City	Philippines
RPV	Roper Valley Airport	Roper Valley	Australia
TAC	Daniel Z. Romualdez Airport	Tacloban City	Philippines
BCD	Bacolod-Silay Airport	Bacolod City	Philippines
CYP	Calbayog Airport	Calbayog City	Philippines
DGT	Sibulan Airport	Dumaguete City	Philippines
MPH	Godofredo P. Ramos Airport	Caticlan	Philippines
CRM	Catarman National Airport	Catarman	Philippines
ILO	Iloilo International Airport	Cabatuan	Philippines
MBT	Moises R. Espinosa Airport	Masbate	Philippines
KLO	Kalibo International Airport	Kalibo	Philippines
CEB	Mactan Cebu International Airport	Lapu-Lapu City	Philippines
OMC	Ormoc Airport	Ormoc City	Philippines
PPS	Puerto Princesa International Airport / PAF Antonio Bautista Air Base	Puerto Princesa	Philippines
RXS	Roxas Airport	Roxas City	Philippines
EUQ	Evelio Javier Airport	San Jose	Philippines
TBH	Tugdan Airport	Tablas Island	Philippines
USU	Francisco B. Reyes (Busuanga) Airport	Coron	Philippines
BPA	Borongan Airport	Borongan City	Philippines
RRM	Marromeu Airport	Marromeu	Mozambique
RSE	Rose Bay Seaplane Base	Sydney	Australia
RSI	Red Sea International Airport	Hanak	Saudi Arabia
NGK	Nogliki Airport	Nogliki	Russia
GRV	Grozny Airport	Grozny	Russia
TKM	Taksimo Airport	Taksimo	Russia
NOI	Krymsk Air Base	Krymsk	Russia
KDY	Typliy Klyuch Airport	Khandyga	Russia
MJY	Motygino Airport	Motygino	Russia
UHS	Aleksandrovsk-Sakhalinskiy Airport	Aleksandrovsk-Sakhalinskiy	Russia
VUS	Velikiy Ustyug Airport	Velikiy Ustyug	Russia
RUU	Ruti Airport	Kawbenaberi	Papua New Guinea
RVC	River Cess Airport and Heliport	River Cess	Liberia
LPS	Lopez Island Airport	Lopez	United States
KEH	Kenmore Air Harbor LLC Seaplane Base	Kenmore	United States
MJR	Miramar Airport	Miramar	Argentina
COC	Comodoro Pierrestegui Airport	Concordia	Argentina
GHU	Gualeguaychu Airport	Gualeguaychu	Argentina
PRA	General Urquiza Airport	Parana	Argentina
ROS	Rosario Islas Malvinas International Airport	Rosario	Argentina
SFN	Sauce Viejo Airport	Santa Fe	Argentina
AEP	Jorge Newbery Airpark	Buenos Aires	Argentina
LCM	La Cumbre Airport	La Cumbre	Argentina
COR	Ingeniero Ambrosio Taravella Airport	Cordoba	Argentina
LPG	La Plata Airport	La Plata	Argentina
EPA	El Palomar Airport	El Palomar	Argentina
EZE	Minister Pistarini International Airport	Buenos Aires (Ezeiza)	Argentina
RAF	Rafaela Airport	Rafaela	Argentina
HOS	Chos Malal Airport	Chos Malal	Argentina
CVH	Caviahue Airport	Lafontaine	Argentina
GNR	Dr. Arturo H. Illia Airport	General Roca	Argentina
RDS	Rincon De Los Sauces Airport	Rincon de los Sauces	Argentina
APZ	Zapala Airport	Zapala	Argentina
SAM	Salamo Airport	Salamo	Papua New Guinea
MDZ	El Plumerillo Airport	Mendoza	Argentina
LGS	Comodoro D.R. Salomón Airport	Malargue	Argentina
AFA	Suboficial Ay Santiago Germano Airport	San Rafael	Argentina
CTC	Coronel Felipe Varela International Airport	Catamarca	Argentina
SDE	Vicecomodoro Angel D. La Paz Aragonés Airport	Santiago del Estero	Argentina
IRJ	Capitan V A Almonacid Airport	La Rioja	Argentina
RHD	Termas de Río Hondo international Airport	Termas de Río Hondo	Argentina
TUC	Teniente Benjamin Matienzo Airport	San Miguel de Tucumán	Argentina
UAQ	Domingo Faustino Sarmiento Airport	San Juan	Argentina
CRR	Ceres Airport	Ceres	Argentina
RCU	Area De Material Airport	Rio Cuarto	Argentina
VDR	Villa Dolores Airport	Villa Dolores	Argentina
VME	Villa Reynolds Airport	Villa Mercedes	Argentina
RLO	Valle Del Conlara International Airport	Merlo	Argentina
LUQ	Brigadier Mayor D Cesar Raul Ojeda Airport	San Luis	Argentina
CNQ	Corrientes Airport	Corrientes	Argentina
RES	Resistencia International Airport	Resistencia	Argentina
FMA	Aeropuerto Nacional de Formosa	Formosa	Argentina
IGR	Cataratas Del Iguazú International Airport	Puerto Iguazu	Argentina
AOL	Paso De Los Libres Airport	Paso de los Libres	Argentina
MCS	Monte Caseros Airport	Monte Caseros	Argentina
PSS	Libertador Gral D Jose De San Martin Airport	Posadas	Argentina
SAS	Salton Sea Airport	Salton City	United States
SLA	Martin Miguel De Guemes International Airport	Salta	Argentina
JUJ	Gobernador Horacio Guzman International Airport	San Salvador de Jujuy	Argentina
ORA	Orán Airport	Orán	Argentina
TTG	General Enrique Mosconi Airport	Tartagal	Argentina
CLX	Aeródromo de Clorinda	Clorinda	Argentina
ELO	El Dorado Airport	El Dorado	Argentina
OYA	Goya Airport	Goya	Argentina
LLS	Alferez Armando Rodriguez Airport	Las Lomitas	Argentina
MDX	Mercedes Airport	Mercedes	Argentina
RCQ	Reconquista Airport	Reconquista	Argentina
UZU	Curuzu Cuatia Airport	Curuzu Cuatia	Argentina
EHL	El Bolson Airport	El Bolson	Argentina
CRD	General E. Mosconi Airport	Comodoro Rivadavia	Argentina
EMX	El Maiten Airport	El Maiten	Argentina
EQS	Brigadier Antonio Parodi Airport	Esquel	Argentina
LHS	Las Heras Airport	Las Heras	Argentina
IGB	Ingeniero Jacobacci - Captain H R Bordón Airport	Ingeniero Jacobacci	Argentina
OLN	Lago Musters Airport	Sarmiento	Argentina
OES	Antoine de Saint Exupéry Airport	San Antonio Oeste	Argentina
MQD	Maquinchao Airport	Maquinchao	Argentina
ARR	D. Casimiro Szlapelis Airport	Alto Rio Senguerr	Argentina
SGV	Sierra Grande Airport	Sierra Grande	Argentina
REL	Almirante Marco Andres Zar Airport	Rawson	Argentina
VDM	Gobernador Castello Airport	Viedma / Carmen de Patagones	Argentina
PMY	El Tehuelche Airport	Puerto Madryn	Argentina
FTE	El Calafate - Commander Armando Tola International Airport	El Calafate	Argentina
PUD	Puerto Deseado Airport	Puerto Deseado	Argentina
RGA	Gobernador Ramón Trejo Noel International Airport	Rio Grande	Argentina
RGL	Piloto Civil N. Fernández Airport	Rio Gallegos	Argentina
USH	Malvinas Argentinas Airport	Ushuaia	Argentina
ULA	Capitan D Daniel Vazquez Airport	San Julian	Argentina
ROY	Rio Mayo Airport	Rio Mayo	Argentina
PMQ	Perito Moreno Airport	Perito Moreno	Argentina
GGS	Gobernador Gregores Airport	Gobernador Gregores	Argentina
JSM	Jose De San Martin Airport	Chubut	Argentina
RYO	28 de Noviembre Airport	Rio Turbio	Argentina
RZA	Santa Cruz Airport	Puerto Santa Cruz	Argentina
BHI	Comandante Espora Airport	Bahia Blanca	Argentina
CSZ	Brigadier D.H.E. Ruiz Airport	Coronel Suarez	Argentina
OVR	Olavarria Airport	Olavarria	Argentina
GPO	General Pico Airport	General Pico	Argentina
OYO	Tres Arroyos Airport	Tres Arroyos	Argentina
SST	Santa Teresita Airport	Santa Teresita	Argentina
MDQ	Ástor Piazzola International Airport	Mar del Plata	Argentina
NQN	Presidente Peron Airport	Neuquen	Argentina
NEC	Necochea Airport	Necochea	Argentina
PEH	Comodoro Pedro Zanni Airport	Pehuajó	Argentina
RSA	Santa Rosa Airport	Santa Rosa	Argentina
BRC	San Carlos De Bariloche Airport	San Carlos de Bariloche	Argentina
TDL	Héroes De Malvinas Airport	Tandil	Argentina
VLG	Villa Gesell Airport	Villa Gesell	Argentina
CUT	Cutral-Co Airport	Cutral-Co	Argentina
CPC	Aviador C. Campos Airport	Chapelco/San Martin de los Andes	Argentina
VIU	Viru Harbour Airstrip	Viru	Solomon Islands
CDJ	Conceição do Araguaia Airport	Conceição do Araguaia	Brazil
ARX	Aracati Dragão do Mar Regional Airport	Aracati	Brazil
AQA	Araraquara Airport	Araraquara	Brazil
AJU	Aracaju - Santa Maria International Airport	Aracaju	Brazil
AFL	Piloto Osvaldo Marques Dias Airport	Alta Floresta	Brazil
ARU	Araçatuba Airport	Araçatuba	Brazil
AAX	Romeu Zema Airport	Araxá	Brazil
BEL	Val de Cans/Júlio Cezar Ribeiro International Airport	Belém	Brazil
BGX	Comandante Gustavo Kraemer Airport	Bagé	Brazil
PLU	Pampulha - Carlos Drummond de Andrade Airport	Belo Horizonte	Brazil
BFH	Bacacheri Airport	Curitiba	Brazil
BJP	Estadual Arthur Siqueira Airport	Bragança Paulista	Brazil
BSB	Presidente Juscelino Kubitschek International Airport	Brasília	Brazil
BAT	Chafei Amsei Airport	Barretos	Brazil
BVB	Atlas Brasil Cantanhede Airport	Boa Vista	Brazil
BPG	Barra do Garças Airport	Barra do Garças	Brazil
BZC	Umberto Modiano Airport	Cabo Frio	Brazil
CAC	Coronel Adalberto Mendes da Silva Airport	Cascavel	Brazil
CFB	Cabo Frio Airport	Cabo Frio	Brazil
CFC	Caçador Airport	Caçador	Brazil
CNF	Tancredo Neves International Airport	Belo Horizonte	Brazil
CGR	Campo Grande Airport	Campo Grande	Brazil
XAP	Serafin Enoss Bertaso Airport	Chapecó	Brazil
CLN	Brig. Lysias Augusto Rodrigues Airport	Carolina	Brazil
CKS	Carajás Airport	Parauapebas	Brazil
CCM	Forquilhinha - Criciúma  Airport	Criciúma	Brazil
CLV	Nelson Ribeiro Guimarães Airport	Caldas Novas	Brazil
QNS	Canoas Air Force Base	Porto Alegre	Brazil
CAW	Bartolomeu Lisandro Airport	Campos Dos Goytacazes	Brazil
CMG	Corumbá International Airport	Corumbá	Brazil
CWB	Afonso Pena Airport	Curitiba	Brazil
CRQ	Caravelas Airport	Caravelas	Brazil
CXJ	Hugo Cantergiani Regional Airport	Caxias Do Sul	Brazil
CGB	Marechal Rondon Airport	Cuiabá	Brazil
CZS	Cruzeiro do Sul Airport	Cruzeiro Do Sul	Brazil
BYO	Bonito Airport	Bonito	Brazil
PPB	Presidente Prudente Airport	Presidente Prudente	Brazil
MAO	Eduardo Gomes International Airport	Manaus	Brazil
JCR	Jacareacanga Airport	Jacareacanga	Brazil
IGU	Cataratas International Airport	Foz do Iguaçu	Brazil
FLN	Hercílio Luz International Airport	Florianópolis	Brazil
FEN	Fernando de Noronha Airport	Fernando de Noronha	Brazil
FOR	Pinto Martins International Airport	Fortaleza	Brazil
GIG	Rio Galeão – Tom Jobim International Airport	Rio De Janeiro	Brazil
GJM	Guajará-Mirim Airport	Guajará-Mirim	Brazil
GYN	Santa Genoveva Airport	Goiânia	Brazil
GRU	Guarulhos - Governador André Franco Montoro International Airport	São Paulo	Brazil
GPB	Tancredo Thomas de Faria Airport	Guarapuava	Brazil
GVR	Coronel Altino Machado Airport	Governador Valadares	Brazil
GUJ	Edu Chaves Field	Guaratinguetá	Brazil
ATM	Altamira Interstate Airport	Altamira	Brazil
ITA	Itacoatiara Airport	Itacoatiara	Brazil
ITB	Itaituba Airport	Itaituba	Brazil
IOS	Bahia - Jorge Amado Airport	Ilhéus	Brazil
IPN	Usiminas Airport	Ipatinga	Brazil
ITR	Francisco Vilela do Amaral Airport	Itumbiara	Brazil
IMP	Prefeito Renato Moreira Airport	Imperatriz	Brazil
JJG	Humberto Ghizzo Bortoluzzi Regional Airport	Jaguaruna	Brazil
QDV	Comte. Rolim Adolfo Amaro–Jundiaí State Airport	Jundiaí	Brazil
JDF	Francisco de Assis Airport	Juiz de Fora	Brazil
JHF	São Paulo Catarina Executive Airport	São Roque	Brazil
JPA	Presidente Castro Pinto International Airport	João Pessoa	Brazil
RRJ	Jacarepaguá - Roberto Marinho Airport	Rio De Janeiro	Brazil
JDO	Orlando Bezerra de Menezes Airport	Juazeiro do Norte	Brazil
JOI	Lauro Carneiro de Loyola Airport	Joinville	Brazil
CPV	Presidente João Suassuna Airport	Campina Grande	Brazil
VCP	Viracopos International Airport	Campinas	Brazil
LEC	Coronel Horácio de Mattos Airport	Lençóis	Brazil
LAJ	Lages Airport	Lages	Brazil
LIP	Lins Airport	Lins	Brazil
LDB	Governador José Richa Airport	Londrina	Brazil
LAZ	Bom Jesus da Lapa Airport	Bom Jesus da Lapa	Brazil
MAB	João Correa da Rocha Airport	Marabá	Brazil
MQH	Minaçu Airport	Minaçu	Brazil
MEU	Monte Dourado - Serra do Areão Airport	Almeirim	Brazil
MEA	Macaé Benedito Lacerda Airport	Macaé	Brazil
MGF	Regional de Maringá - Sílvio Name Júnior Airport	Maringá	Brazil
MOC	Mário Ribeiro Airport	Montes Claros	Brazil
MII	Frank Miloye Milenkowichi–Marília State Airport	Marília	Brazil
PLL	Ponta Pelada Airport / Manaus Air Base	Manaus	Brazil
MCZ	Zumbi dos Palmares Airport	Maceió	Brazil
MCP	Macapá - Alberto Alcolumbre International Airport	Macapá	Brazil
MVF	Dix-Sept Rosado Airport	Mossoró	Brazil
RTE	Campo de Marte Airport	São Paulo	Brazil
MNX	Manicoré Airport	Manicoré	Brazil
NVT	Ministro Victor Konder International Airport	Navegantes	Brazil
GEL	Santo Ângelo Airport	Santo Ângelo	Brazil
OYK	Oiapoque Airport	Oiapoque	Brazil
POA	Salgado Filho International Airport	Porto Alegre	Brazil
PHB	Parnaíba - Prefeito Doutor João Silva Filho International Airport	Parnaíba	Brazil
POO	Poços de Caldas - Embaixador Walther Moreira Salles Airport	Poços De Caldas	Brazil
PFB	Lauro Kurtz Airport	Passo Fundo	Brazil
PMW	Brigadeiro Lysias Rodrigues Airport	Palmas	Brazil
PET	João Simões Lopes Neto International Airport	Pelotas	Brazil
PNZ	Senador Nilo Coelho Airport	Petrolina	Brazil
PNB	Porto Nacional Airport	Porto Nacional	Brazil
PMG	Ponta Porã Airport	Ponta Porã	Brazil
BPS	Porto Seguro Airport	Porto Seguro	Brazil
PVH	Governador Jorge Teixeira de Oliveira Airport	Porto Velho	Brazil
RBR	Rio Branco-Plácido de Castro International Airport	Rio Branco	Brazil
REC	Recife/Guararapes - Gilberto Freyre International Airport	Recife	Brazil
SDU	Santos Dumont Airport	Rio de Janeiro	Brazil
RAO	Leite Lopes Airport	Ribeirão Preto	Brazil
BRB	Barreirinhas National Airport	Barreirinhas	Brazil
SNZ	Santa Cruz Air Force Base	Rio de Janeiro	Brazil
NAT	São Gonçalo do Amarante - Governador Aluízio Alves International Airport	Natal	Brazil
SJK	Professor Urbano Ernesto Stumpf Airport	São José Dos Campos	Brazil
SLZ	Marechal Cunha Machado International Airport	São Luís	Brazil
RIA	Santa Maria Airport	Santa Maria	Brazil
STM	Santarém - Maestro Wilson Fonseca International Airport	Santarém	Brazil
SMT	Adolino Bedin Regional Airport	Sorriso	Brazil
CGH	Congonhas Airport	São Paulo	Brazil
SJP	Prof. Eribelto Manoel Reino State Airport	São José do Rio Preto	Brazil
SSZ	Santos Nero Moura Air Base / Guarujá Airport	Guarujá	Brazil
SSA	Deputado Luiz Eduardo Magalhães International Airport	Salvador	Brazil
TMT	Trombetas Airport	Oriximiná	Brazil
UNA	Una-Comandatuba Airport	Una	Brazil
TOW	Toledo - Luiz Dalcanale Filho Municipal Airport	Toledo	Brazil
THE	Senador Petrônio Portela Airport	Teresina	Brazil
TFF	Tefé Airport	Tefé	Brazil
TRQ	Tarauacá Airport	Tarauacá	Brazil
TEC	Telêmaco Borba Airport	Telêmaco Borba	Brazil
TSQ	Torres Airport	Torres	Brazil
TBT	Tabatinga Airport	Tabatinga	Brazil
TUR	Tucuruí Airport	Tucuruí	Brazil
SJL	São Gabriel da Cachoeira Airport	São Gabriel da Cachoeira	Brazil
PAV	Paulo Afonso Airport	Paulo Afonso	Brazil
URG	Rubem Berta Airport	Uruguaiana	Brazil
UDI	Ten. Cel. Aviador César Bombonato Airport	Uberlândia	Brazil
UBA	Mário de Almeida Franco Airport	Uberaba	Brazil
RPU	Urucu Airport	Urucu	Brazil
VAG	Major Brigadeiro Trompowsky Airport	Varginha	Brazil
BVH	Brigadeiro Camarão Airport	Vilhena	Brazil
VIX	Eurico de Aguiar Salles Airport	Vitória	Brazil
QPS	Campo Fontenelle	Pirassununga	Brazil
IZA	Presidente Itamar Franco Airport	Juiz de Fora	Brazil
ZUD	Pupelde Airport	Ancud	Chile
LOB	San Rafael Airport	Los Andes	Chile
WAP	Alto Palena Airport	Alto Palena	Chile
ARI	Chacalluta Airport	Arica	Chile
WPA	Cabo 1° Juan Román Airport	Puerto Aysen	Chile
CPO	Desierto de Atacama Airport	Copiapo	Chile
BBA	Balmaceda Airport	Balmaceda	Chile
TOQ	Barriles Airport	Tocopilla	Chile
DPB	Pampa Guanaco Airport	Bahia Inutil	Chile
CCH	Chile Chico Airport	Chile Chico	Chile
CJC	El Loa Airport	Calama	Chile
YAI	Gral. Bernardo O´Higgins Airport	Chillan	Chile
PUQ	President Carlos Ibañez del Campo International Airport	Punta Arenas	Chile
COW	Tambillos Airport	Coquimbo	Chile
GXQ	Teniente Vidal Airport	Coyhaique	Chile
IQQ	Diego Aracena Airport	Iquique	Chile
SCL	Comodoro Arturo Merino Benítez International Airport	Santiago	Chile
ESR	Ricardo García Posada Airport	El Salvador	Chile
FRT	El Avellano Airport	Frutillar	Chile
ANF	Andrés Sabella Gálvez International Airport	Antofagasta	Chile
WPR	Captain Fuentes Martinez Airport	Porvenir	Chile
FFU	Futaleufú Airport	Futaleufu	Chile
UGL	Union Glacier Blue-Ice Runway	Union Glacier Camp	Antarctica
LSQ	María Dolores Airport	Los Angeles	Chile
WPU	Guardiamarina Zañartu Airport	Puerto Williams	Chile
LGR	Cochrane Airport	Cochrane	Chile
CCP	Carriel Sur Airport	Concepcion	Chile
IPC	Mataveri Airport	Isla De Pascua	Chile
ZOS	Cañal Bajo Carlos - Hott Siebert Airport	Osorno	Chile
CPP	Coposa Airport	Pica	Chile
VLR	Vallenar Airport	Vallenar	Chile
ZLR	Municipal de Linares Airport	Linares	Chile
PNT	Lieutenant Julio Gallardo Airport	Puerto Natales	Chile
OVL	El Tuqui Airport	Ovalle	Chile
ZPC	Pucón Airport	Pucon	Chile
MHC	Mocopulli Airport	Dalcahue	Chile
PUX	El Mirador Airport	Puerto Varas	Chile
ZCO	La Araucanía Airport	Temuco	Chile
CNR	Chañaral Airport	Chañaral	Chile
VAP	Rodelillo Airport	Viña Del Mar	Chile
TNM	Teniente Rodolfo Marsh Martin Airport	Villa Las Estrellas	Antarctica
SMB	Franco Bianco Airport	Cerro Sombrero	Chile
LSC	La Florida Airport	La Serena-Coquimbo	Chile
SSD	Víctor Lafón Airport	San Felipe	Chile
WCA	Gamboa Airport	Castro	Chile
PZS	Maquehue Airport	Temuco	Chile
PMC	El Tepual Airport	Puerto Montt	Chile
TLX	Panguilemo Airport	Talca	Chile
ZIC	Victoria Airport	Victoria	Chile
TTC	Las Breas Airport	Taltal	Chile
ZAL	Pichoy Airport	Valdivia	Chile
KNA	Viña del Mar Airport	Viña del Mar	Chile
GDR	Angra dos Reis Airport	Angra dos Reis	Brazil
OLC	Senadora Eunice Micheles Airport	São Paulo De Olivença	Brazil
SOD	Sorocaba Airport	Sorocaba	Brazil
SDI	Saidor Airport	Saidor	Papua New Guinea
JTN	Itanhaém Airport	Itanhaém	Brazil
JLS	Jales Airport	Jales	Brazil
PBA	Fábio Perini Airport	Cairu	Brazil
JMR	Maricá Airport	Maricá	Brazil
NVM	Brigadeiro Eduardo Gomes Airport	Nova Mutum	Brazil
OUS	Jornalista Benedito Pimentel Airport	Ourinhos	Brazil
OIA	Ourilândia do Norte Airport	Ourilândia do Norte	Brazil
REZ	Resende Airport	Resende	Brazil
QSC	Mário Pereira Lopes–São Carlos Airport	São Carlos	Brazil
JPY	Paraty Airport	Paraty	Brazil
UBT	Ubatuba Gastão Madeira State Airport	Ubatuba	Brazil
ITP	Itaperuna Airport	Itaperuna	Brazil
VOT	Domingos Pignatari Airport	Votuporanga	Brazil
JTA	Pedro Teixeira Castelo Airport	Tauá	Brazil
ATF	Chachoán Regional Airport	Ambato	Ecuador
OCC	Francisco De Orellana Airport	Coca	Ecuador
CUE	Mariscal Lamar Airport	Cuenca	Ecuador
GPS	Seymour Galapagos Ecological Airport	Isla Baltra	Ecuador
GYE	José Joaquín de Olmedo International Airport	Guayaquil	Ecuador
IBB	General Villamil Airport	Puerto Villamil	Ecuador
JIP	Jipijapa Airport	Jipijapa	Ecuador
LTX	Cotopaxi International Airport	Latacunga	Ecuador
MRR	Jose Maria Velasco Ibarra Airport	Macará	Ecuador
XMS	Coronel E Carvajal Airport	Macas	Ecuador
MEC	Eloy Alfaro International Airport	Manta	Ecuador
LGQ	Nueva Loja Airport	Lago Agrio	Ecuador
PYO	Putumayo Airport	Puerto Putumayo	Ecuador
PVO	Reales Tamarindos Airport	Portoviejo	Ecuador
UIO	Mariscal Sucre International Airport	Quito	Ecuador
ETR	Santa Rosa - Artillery Colonel Victor Larrea International Airport	Santa Rosa	Ecuador
SNC	General Ulpiano Paez Airport	Salinas	Ecuador
SUQ	Sucúa Airport	Sucúa	Ecuador
PTZ	Rio Amazonas Airport	Shell Mera	Ecuador
SCY	San Cristóbal Airport	Puerto Baquerizo Moreno	Ecuador
BHA	Los Perales Airport	Bahía de Caraquez	Ecuador
TSC	Taisha Airport	Taisha	Ecuador
TPN	Tiputini Airport	Tiputini	Ecuador
LOH	Ciudad de Catamayo Airport	La Toma (Catamayo)	Ecuador
ESM	Carlos Concha Torres International Airport	Tachina	Ecuador
TPC	Tarapoa Airport	Tarapoa	Ecuador
TUA	Lieutenant Colonel Luis A. Mantilla International Airport	Tulcán	Ecuador
PSY	Port Stanley Airport	Stanley	Falkland Islands
SFU	Safia Airport	Safia	Papua New Guinea
ASU	Silvio Pettirossi International Airport.	Asunción	Paraguay
AYO	Aeropuerto Nacional de Juan De Ayolas	Ayolas	Paraguay
CIO	Aeropuerto Nacional Tte. Cnel. Carmelo Peralta	Concepción	Paraguay
ENO	Aeropuerto Internacional Tte. Amin Ayub González	Encarnación	Paraguay
AGT	Aeropuerto Internacional Guaraní	Ciudad del Este	Paraguay
FLM	Aeródromo de Filadelfia	Filadelfia	Paraguay
ESG	Aeropuerto Internacional Dr. Luis Maria Argaña	Mariscal Estigarribia	Paraguay
PIL	Aeródromo Don Carlos Miguel Gimenez	Pilar	Paraguay
PJC	Dr. Augusto Roberto Fuster Airport	Pedro Juan Caballero	Paraguay
SIC	San José Island Airport	Las Perlas	Panama
ITJ	Campo Comandantes Airport	Itajaí	Brazil
LVR	Municipal Bom Futuro Airport	Lucas do Rio Verde	Brazil
SFV	Fazenda Trêz Irmãos Airport	Santa Fé Do Sul	Brazil
IPI	San Luis Airport	Ipiales	Colombia
FRC	Tenente Lund Pressoto Airport	Franca	Brazil
MUU	Barra Grande Airport	Maraú	Brazil
SIZ	Sissano Airport	Sissano	Papua New Guinea
JUA	Inácio Luís do Nascimento Airport	Juara	Brazil
SJF	Cruz Bay Seaplane Base	Saint John Island	U.S. Virgin Islands
CFO	Confresa Airport	Confresa	Brazil
NPR	Novo Progresso Airport	Novo Progresso	Brazil
AQM	Ariquemes Airport	Ariquemes	Brazil
JRT	Juruti Airport	Juruti	Brazil
RIG	Rio Grande Regional Airport	Rio Grande	Brazil
JTC	Bauru/Arealva–Moussa Nakhal Tobias State Airport	Bauru	Brazil
ARS	Aragarças Airport	Aragarças	Brazil
ECO	El Encanto Airport	El Encanto	Colombia
MIX	Miriti Parana Airport	Mirití-Paraná	Colombia
ARO	Arboletes Airport	Arboletes	Colombia
ULS	Mulatos Airport	Mulatos	Colombia
SJR	San Juan De Uraba Airport	San Juan De Uraba	Colombia
NPU	San Pedro Airport	San Pedro de Urabá	Colombia
PCC	Puerto Rico Airport	Puerto Rico	Colombia
SQF	Solano Airport	Solano	Colombia
AYI	Yari Airport	Yari	Colombia
CUI	Currillo Airport	Currillo	Colombia
MOY	Monterrey Airport	Monterrey	Colombia
NUH	Nunchia Airport	Nunchia	Colombia
EUO	Paratebueno Airport	Paratebueno	Colombia
PRE	Pore Airport	Pore	Colombia
SQE	San Luis De Palenque Airport	San Luis De Palenque	Colombia
TTM	Tablón De Tamara Airport	Tablón De Tamara	Colombia
TAU	Tauramena Airport	Tauramena	Colombia
LMX	Lopez de Micay Airport	Micay	Colombia
TBD	Timbiqui Airport	Timbiqui	Colombia
AYC	Ayacucho Airport	Ayacucho	Colombia
GRA	Gamarra Airport	Puerto Mosquito	Colombia
DZI	Las Flores Airport	Codazzi	Colombia
SJH	San Juan Del César Airport	San Juan Del César	Colombia
JUO	Juradó Airport	Juradó	Colombia
PZR	Pizarro Airport	Bajo Baudó	Colombia
UNC	Unguía Airport	Unguía	Colombia
AYA	Ayapel Airport	Ayapel	Colombia
SCA	Santa Catalina Airport	Santa Catalina	Colombia
NBB	Barranco Minas Airport	Barranco Minas	Colombia
MND	Medina Airport	Medina	Colombia
NAD	Macanal Airport	Macanal	Colombia
GCA	Guacamayas Airport	Guacamayas	Colombia
SRO	Santana Ramos Airport	Santana Ramos	Colombia
IVO	Chivolo Airport	Chivolo	Colombia
GAA	Guamal Airport	Guamal	Colombia
BAC	Barranca De Upia Airport	Barranca De Upia	Colombia
CJD	Candilejas Airport	Candilejas	Colombia
CQT	Caquetania Airport	Caquetania	Colombia
ELJ	El Recreo Airport	Ruperto Polania	Colombia
MSK	Morelia Airport	Puerto Gaitán	Colombia
SOH	Solita Airport	Solita	Colombia
ECR	El Charco Airport	El Charco	Colombia
MQR	Mosquera Airport	Mosquera	Colombia
PYN	Payán Airport	Payán	Colombia
ISD	Santa Bárbara Airport	Iscuandé	Colombia
AZT	Zapatoca Airport	Zapatoca	Colombia
HRR	Herrera Airport	Campiña	Colombia
PLA	Planadas Airport	Planadas	Colombia
SQB	Santa Ana Airport	Piedras	Colombia
ARF	Acaricuara Airport	Acaricuara	Colombia
MFB	Monfort Airport	Monfort	Colombia
MHF	Morichal Airport	Morichal	Colombia
VAB	Yavarate Airport	Yavarate	Colombia
CSR	Casuarito Airport	Casuarito	Colombia
GMC	Guerima Airport	Puerto Carreño	Colombia
LPE	La Primavera Airport	La Primavera	Colombia
ACR	Araracuara Airport	Araracuara	Colombia
ACD	Alcides Fernández Airport	Acandí	Colombia
HAY	Hacaritama Airport	Aguachica	Colombia
AFI	Amalfi Airport	Amalfi	Colombia
API	Gomez Nino Apiay Air Base	Apiay	Colombia
AXM	El Eden Airport	Armenia	Colombia
PUU	Tres De Mayo Airport	Puerto Asís	Colombia
ARQ	El Troncal Airport	Arauquita	Colombia
ELB	Las Flores Airport	El Banco	Colombia
BGA	Palonegro Airport	Bucaramanga	Colombia
BOG	El Dorado International Airport	Bogota	Colombia
BAQ	Ernesto Cortissoz International Airport	Barranquilla	Colombia
BSC	José Celestino Mutis Airport	Bahía Solano	Colombia
BUN	Gerardo Tobar López Airport	Buenaventura	Colombia
CPB	Capurganá Airport	Acandí	Colombia
CUC	Camilo Daza International Airport	Cúcuta	Colombia
COG	Mandinga Airport	Condoto	Colombia
CTG	Rafael Nuñez International Airport	Cartagena	Colombia
CCO	Carimagua Airport	Puerto López	Colombia
CLO	Alfonso Bonilla Aragon International Airport	Cali	Colombia
CIM	Cimitarra Airport	Cimitarra	Colombia
RAV	Cravo Norte Airport	Cravo Norte	Colombia
TCO	La Florida Airport	Tumaco	Colombia
BHF	Cupica Airport	Bahía Solano	Colombia
CUO	Carurú Airport	Carurú	Colombia
CAQ	Juan H White Airport	Caucasia	Colombia
CVE	Coveñas Airport	Coveñas	Colombia
CZU	Las Brujas Airport	Corozal	Colombia
EBG	El Bagre Airport	El Bagre	Colombia
EJA	Yariguíes Airport	Barrancabermeja	Colombia
FLA	Gustavo Artunduaga Paredes Airport	Florencia	Colombia
FDA	Fundación Airport	Fundación	Colombia
LGT	La Gaviota Airport		Colombia
GIR	Santiago Vila Airport	Girardot	Colombia
CRC	Santa Ana Airport	Cartago	Colombia
GPI	Juan Casiano Airport	Guapi	Colombia
CPL	General Navas Pardo Airport	Chaparral	Colombia
HTZ	Hato Corozal Airport	Hato Corozal	Colombia
IBE	Perales Airport	Ibagué	Colombia
IGO	Jaime Ortiz Betancourt Airport	Chigorodó	Colombia
APO	Antonio Roldán Betancur Airport	Carepa	Colombia
LQM	Caucaya Airport	Puerto Leguízamo	Colombia
MCJ	Jorge Isaac Airport	La Mina-Maicao	Colombia
LPD	La Pedrera Airport	La Pedrera	Colombia
LET	Alfredo Vásquez Cobo International Airport	Leticia	Colombia
EOH	Enrique Olaya Herrera Airport	Medellín	Colombia
MFS	Miraflores Airport	Miraflores	Colombia
MGN	Baracoa Airport	Magangué	Colombia
MTB	Montelibano Airport	Montelíbano	Colombia
MMP	San Bernardo Airport	Santa Cruz de Mompóx	Colombia
MTR	Los Garzones Airport	Montería	Colombia
MVP	Fabio Alberto Leon Bentley Airport	Mitú	Colombia
MZL	La Nubia Airport	Manizales	Colombia
LMC	La Macarena Airport	La Macarena	Colombia
NCI	Necocli Airport	Necocli	Colombia
NQU	Reyes Murillo Airport	Nuquí	Colombia
NVA	Benito Salas Airport	Neiva	Colombia
OCV	Aguas Claras Airport	Ocaña	Colombia
ORC	Orocue Airport	Orocue	Colombia
OTU	Otu Airport	Remedios	Colombia
RON	Juan Jose Rondon Airport	Paipa	Colombia
PCR	German Olano Airport	Puerto Carreño	Colombia
PDA	Obando Cesar Gaviria Trujillo Airport	Puerto Inírida	Colombia
PEI	Matecaña International Airport	Pereira	Colombia
PTX	Pitalito Airport	Pitalito	Colombia
PLT	Plato Airport	Plato	Colombia
NAR	Puerto Nare Airport	Armenia	Colombia
PPN	Guillermo León Valencia Airport	Popayán	Colombia
PAL	German Olano Air Base	La Dorada	Colombia
PBE	Puerto Berrio Airport	Puerto Berrio	Colombia
PSO	Antonio Nariño Airport	Chachagüí	Colombia
PVA	El Embrujo Airport	Providencia	Colombia
PZA	Paz De Ariporo Airport	Paz De Ariporo	Colombia
MQU	Mariquita Airport	Mariquita	Colombia
MDE	Jose Maria Córdova International Airport	Medellín	Colombia
RCH	Almirante Padilla Airport	Riohacha	Colombia
RVE	Los Colonizadores Airport	Saravena	Colombia
SJE	Jorge E. Gonzalez Torres Airport	San José Del Guaviare	Colombia
SSL	Santa Rosalia Airport	Santa Rosalia	Colombia
SMR	Simón Bolívar International Airport	Santa Marta	Colombia
SOX	Alberto Lleras Camargo Airport	Sogamoso	Colombia
ADZ	Gustavo Rojas Pinilla International Airport	San Andrés	Colombia
SRS	San Marcos Airport	San Marcos	Colombia
SVI	Eduardo Falla Solano Airport	San Vicente Del Caguán	Colombia
TIB	Tibú Airport	Tibú	Colombia
TDA	Trinidad Airport	Trinidad	Colombia
TLU	Golfo de Morrosquillo Airport	Santiago de Tolú	Colombia
TME	Gustavo Vargas Airport	Tame	Colombia
TQS	Captain Ernesto Esguerra Cubides Air Base	Tres Esquinas	Colombia
TRB	Gonzalo Mejía Airport	Turbo	Colombia
URI	Uribe Airport	La Uribe	Colombia
AUC	Santiago Perez Airport	Arauca	Colombia
UIB	El Caraño Airport	Quibdó	Colombia
ULQ	Heriberto Gíl Martínez Airport	Tuluá	Colombia
URR	Urrao Airport	Urrao	Colombia
VGZ	Villa Garzón Airport	Villa Garzón	Colombia
PYA	Velásquez Airport	Puerto Boyacá	Colombia
VUP	Alfonso López Pumarejo Airport	Valledupar	Colombia
VVC	Vanguardia Airport	Villavicencio	Colombia
AYG	Yaguara Airport	San Vicente Del Caguán	Colombia
EYP	El Yopal Airport	El Yopal	Colombia
MHW	Monteagudo Airport	El Bañado	Bolivia
SRE	Alcantarí Airport	Yamparaez	Bolivia
APB	Apolo Airport	Apolo	Bolivia
ASC	Ascención De Guarayos Airport	Ascensión de Guarayos	Bolivia
BJO	Bermejo Airport	Bermejo	Bolivia
CAM	Camiri Airport	Camiri	Bolivia
CBB	Jorge Wilsterman International Airport	Cochabamba	Bolivia
CCA	Chimore Airport	Chimore	Bolivia
CIJ	Capitán Aníbal Arab Airport	Cobija	Bolivia
CEP	Concepción Airport	Concepción	Bolivia
SRZ	El Trompillo Airport	Santa Cruz	Bolivia
GYA	Guayaramerín Airport	Guayaramerín	Bolivia
BVK	Huacaraje Airport	Itenes	Bolivia
SLJ	Solomon Airport	Karijini National Park	Australia
SJS	San José De Chiquitos Airport	San José de Chiquitos	Bolivia
SJB	San Joaquín Airport	San Joaquín	Bolivia
SJV	San Javier Airport	San Javier	Bolivia
LPB	El Alto International Airport	La Paz / El Alto	Bolivia
MGD	Magdalena Airport	Magdalena	Bolivia
ORU	Juan Mendoza Airport	Oruro	Bolivia
POI	Capitan Nicolas Rojas Airport	Potosí	Bolivia
PUR	Puerto Rico Airport	Puerto Rico/Manuripi	Bolivia
PSZ	Capitán Av. Salvador Ogaya G. airport	Puerto Suárez	Bolivia
SRD	San Ramón Airport	San Ramón / Mamoré	Bolivia
RBO	Roboré Airport	Roboré	Bolivia
RIB	Capitán Av. Selin Zeitun Lopez Airport	Riberalta	Bolivia
REY	Reyes Airport	Reyes	Bolivia
SBL	Santa Ana Del Yacuma Airport	Santa Ana del Yacuma	Bolivia
SRJ	Capitán Av. German Quiroga G. Airport	San Borja	Bolivia
SNG	Capitán Av. Juan Cochamanidis S. Airport	San Ignacio de Velasco	Bolivia
SNM	San Ignacio de Moxos Airport	San Ignacio de Moxos	Bolivia
SRB	Santa Rosa De Yacuma Airport	Santa Rosa	Bolivia
MQK	San Matías Airport	San Matías	Bolivia
TJA	Capitan Oriel Lea Plaza Airport	Tarija	Bolivia
TDD	Teniente Av. Jorge Henrich Arauz Airport	Trinidad	Bolivia
UYU	Uyuni Joya Andina Airport	Quijarro	Bolivia
VAH	Capitán Av. Vidal Villagomez Toledo Airport	Vallegrande	Bolivia
VLM	Teniente Coronel Rafael Pabón Airport	Villamontes	Bolivia
VVI	Viru Viru International Airport	Santa Cruz	Bolivia
BYC	Yacuiba Airport	Yacuíba	Bolivia
ABN	Albina Airport	Albina	Suriname
TOT	Totness Airport	Totness	Suriname
DRJ	Drietabbetje Airport	Drietabbetje	Suriname
SMH	Sapmanga Airport	Sapmanga	Papua New Guinea
PBM	Johan Adolf Pengel International Airport	Zandery	Suriname
MOJ	Moengo Airstrip	Moengo	Suriname
ICK	Nieuw Nickerie - Major Henk Fernandes Airport	Nieuw Nickerie	Suriname
OEM	Vincent Fayks Airport	Paloemeu	Suriname
SMZ	Stoelmanseiland Airport	Stoelmanseiland	Suriname
AGI	Wageningen Airstrip	Wageningen	Suriname
ORG	Zorg en Hoop Airport	Paramaribo	Suriname
JSO	Dr. Luciano de Arruda Coelho Regional Airport	Sobral	Brazil
JAW	Araripina Airport	Araripina	Brazil
APY	Alto Parnaíba Airport	Alto Parnaíba	Brazil
APQ	Arapiraca Airport	Arapiraca	Brazil
AMJ	Cirilo Queiróz Airport	Almenara	Brazil
AIF	Marcelo Pires Halzhausen Airport	Assis	Brazil
BDC	Barra do Corda Airport	Barra do Corda	Brazil
BVM	Belmonte Airport	Belmonte	Brazil
BRA	Dom Ricardo Weberberger Airport	Barreiras	Brazil
BSS	Balsas Airport	Balsas	Brazil
BMS	Sócrates Mariani Bittencourt Airport	Brumado	Brazil
BQQ	Barra Airport	Barra	Brazil
MXQ	Lorenzo Airport	Cairu	Brazil
EEA	Planalto Serrano Regional Airport	Correia Pinto	Brazil
CPU	Cururupu Airport	Cururupu	Brazil
QCH	Colatina Airport	Colatina	Brazil
RDC	Redenção Airport	Redenção	Brazil
LEP	Leopoldina Airport	Leopoldina	Brazil
DTI	Diamantina Airport	Diamantina	Brazil
DIQ	Brigadeiro Cabral Airport	Divinópolis	Brazil
JPE	Nagib Demachki Airport	Paragominas	Brazil
CNV	Sócrates Rezende Airport	Canavieiras	Brazil
VCC	Vacaria Airport	Vacaria	Brazil
SXX	São Félix do Xingu Airport	São Félix do Xingu	Brazil
GUZ	Guarapari Airport	Guarapari	Brazil
GDP	Guadalupe Airport	Guadalupe	Brazil
GNM	Guanambi Airport	Guanambi	Brazil
QGP	Garanhuns Airport	Garanhuns	Brazil
ITN	Tertuliano Guedes de Pinho Airport	Itabuna	Brazil
SET	Santa Magalhães Airport	Serra Talhada	Brazil
IRE	Irecê Airport	Irecê	Brazil
QIG	Iguatu Airport	Iguatu	Brazil
QIT	Itapetinga Airport	Itapetinga	Brazil
IPU	Ipiaú Airport	Ipiaú	Brazil
JCM	Jacobina Airport	Jacobina	Brazil
FEC	João Durval Carneiro Airport	Feira de Santana	Brazil
JEQ	Jequié Airport	Jequié	Brazil
JMA	Aeroporto Elias Breder Airport	Manhuaçu	Brazil
JNA	Januária Airport	Januária	Brazil
JDR	Prefeito Octávio de Almeida Neves Airport	São João Del Rei	Brazil
CDI	Cachoeiro do Itapemirim - Raimundo de Andrade Airport	Cachoeiro do Itapemirim	Brazil
QCP	Currais Novos Airport	Currais Novos	Brazil
LHN	Linhares Municipal Airport	Linhares	Brazil
SSO	São Lourenço Airport	São Lourenço	Brazil
MTE	Monte Alegre Airport	Monte Alegre	Brazil
MVS	Mucuri Airport	Mucuri	Brazil
SBJ	São Mateus - Ernesto Bonomo Airport	São Mateus	Brazil
PTQ	Porto de Moz Airport	Porto De Moz	Brazil
NNU	Nanuque Airport	Nanuque	Brazil
PSW	Municipal José Figueiredo Airport	Passos	Brazil
FEJ	Feijó Airport	Feijó	Brazil
ORX	Oriximiná Airport	Oriximiná	Brazil
PCS	Picos Airport	Picos	Brazil
POJ	Patos de Minas Airport	Patos de Minas	Brazil
PIV	Pirapora Airport	Pirapora	Brazil
SNQ	San Quintín Military Airstrip	San Quintín	Mexico
FLB	Cangapara Airport	Floriano	Brazil
CHD	Mucugê Airport	Mucugê	Brazil
PDF	Prado Airport	Prado	Brazil
CAU	Caruaru Airport	Caruaru	Brazil
OPP	Salinópolis Airport	Salinópolis	Brazil
SFK	Soure Airport	Soure	Brazil
TXF	9 de Maio - Teixeira de Freitas Airport	Teixeira de Freitas	Brazil
OBI	Óbidos Municipal Airport	Óbidos	Brazil
TFL	Juscelino Kubitscheck Airport	Teófilo Otoni	Brazil
JPO	Aeroporto Brigadeiro Firmino Ayres	Patos	Brazil
AIY	Araçuaí Airport	Araçuaí	Brazil
VAL	Valença Airport	Valença	Brazil
BVS	Breves Airport	Breves	Brazil
CMC	Camocim - Pinto Martins Airport	Camocim	Brazil
JCS	Crateús Airport	Crateús	Brazil
GGF	Almeirim Airport	Almeirim	Brazil
PHI	Pinheiro Airport	Pinheiro	Brazil
GMS	Antônio Guerreiro Airport	Guimarães	Brazil
PPY	Pouso Alegre Airport	Pouso Alegre	Brazil
PYT	Pedro Rabelo de Souza Airport	Paracatu	Brazil
ITE	Ituberá Airport	Ituberá	Brazil
LKR	Las Khorey Airport	Las Khorey	Somalia
GUO	Guriel Airport	Guriel	Somalia
BXX	Borama Airport	Borama	Somalia
SOA	Sóc Trăng Airport	Sóc Trăng	Vietnam
CAY	Cayenne – Félix Eboué Airport	Matoury	French Guiana
GSI	Grand-Santi Airport	Grand-Santi	French Guiana
MPY	Maripasoula Airport	Maripasoula	French Guiana
OYP	Saint-Georges-de-l'Oyapock Airport	Saint-Georges-de-l'Oyapock	French Guiana
LDX	Saint-Laurent-du-Maroni Airport	Saint-Laurent-du-Maroni	French Guiana
REI	Régina Airport	Régina	French Guiana
XAU	Saül Airport	Saül	French Guiana
SOR	Al Thaurah Airport	T2	Syria
ALD	Alerta Airport	Fortaleza	Peru
AOP	Alferez FAP Alfredo Vladimir Sara Bauer Airport	Andoas	Peru
AYX	Teniente General Gerardo Pérez Pinedo Airport	Atalaya	Peru
MBP	Moyobamba Airport	Moyobamba	Peru
BLP	Huallaga Airport	Bellavista	Peru
IBP	Iberia Airport	Iberia	Peru
PCL	Cap FAP David Abenzur Rengifo International Airport	Pucallpa	Peru
TDP	Trompeteros Airport	Corrientes	Peru
CHM	FAP Lieutenant Jaime Andres de Montreuil Morales Airport	Chimbote	Peru
TGI	Tingo Maria Airport	Tingo Maria	Peru
CIX	Air Force Captain Jose A Quinones Gonzales International Airport	Chiclayo	Peru
AYP	Air Force Colonel Alfredo Mendivil Duarte Airport	Ayacucho	Peru
ANS	Andahuaylas Airport	Andahuaylas	Peru
ATA	Comandante FAP German Arias Graziani Airport	Anta	Peru
UMI	Quincemil Air Base	Quince Mil	Peru
LIM	Jorge Chávez International Airport	Lima	Peru
UCZ	Uchiza Airport	Uchiza	Peru
RIJ	Juan Simons Vela Airport	Rioja	Peru
JAE	Shumba Airport	Jaén	Peru
JJI	Juanjui Airport	Juanjuí	Peru
JAU	Francisco Carle Airport	Jauja	Peru
JUL	Inca Manco Capac International Airport	Juliaca	Peru
SJA	San Juan de Marcona Airport	San Juan de Marcona	Peru
CJA	Mayor General FAP Armando Revoredo Iglesias Airport	Cajamarca	Peru
RIM	San Nicolas Airport	Rodriguez de Mendoza	Peru
ILQ	General Jorge Fernandez Maldon Airport	Ilo	Peru
TBP	Captain Pedro Canga Rodríguez International Airport	Tumbes	Peru
MZA	Mayor PNP Nancy Flores Paucar Airport	Mazamari	Peru
YMS	Moises Benzaquen Rengifo Airport	Yurimaguas	Peru
HUU	Alferez Fap David Figueroa Fernandini Airport	Huánuco	Peru
SQU	Saposoa Airport	Plaza Saposoa	Peru
CHH	Chachapoyas Airport	Chachapoyas	Peru
IQT	Coronel FAP Francisco Secada Vignetta International Airport	Iquitos	Peru
AQP	Rodríguez Ballón International Airport	Arequipa	Peru
TRU	Capitan FAP Carlos Martinez De Pinillos International Airport	Trujillo	Peru
PIO	Captain Renán Elías Olivera International Airport	Pisco	Peru
TPP	Cadete FAP Guillermo Del Castillo Paredes Airport	Tarapoto	Peru
SYC	Shiringayoc Airport	Shiringayoc	Peru
TCQ	Coronel FAP Carlos Ciriani Santa Rosa International Airport	Tacna	Peru
PEM	Padre Aldamiz International Airport	Puerto Maldonado	Peru
PIU	Capitán FAP Guillermo Concha Iberico International Airport	Piura	Peru
TYL	Captain Victor Montes Arias International Airport	Talara	Peru
NZC	Maria Reiche Neuman Airport	Nazca	Peru
CUZ	Alejandro Velasco Astete International Airport	Cusco	Peru
SQD	Shangrao Sanqingshan Airport	Shangrao	China
SQJ	Sanming Shaxian Airport	Sanming	China
SQT	China Strait Airstrip	Samarai Island	Papua New Guinea
AAJ	Cayana Airstrip	Awaradam	Suriname
KCB	Tepoe Airstrip	Kasikasima	Suriname
SRL	Palo Verde Airport	Mulegé	Mexico
SRM	Sandringham Airport	Sandringham Station	Australia
SRV	Stony River 2 Airport	Stony River	United States
CZB	Carlos Ruhl Airport	Cruz Alta	Brazil
APU	Captain João Busse Airport	Apucarana	Brazil
BGV	Aeroclube de Bento Gonçalves Airport	Bento Gonçalves	Brazil
BNU	Blumenau Airport	Blumenau	Brazil
CCI	Olavo Cecco Rigon Airport	Concórdia	Brazil
CSS	Cassilândia Airport	Cassilândia	Brazil
CEL	Canela Airport	Canela	Brazil
CKO	Cornélio Procópio Airport	Cornélio Procópio	Brazil
GGH	Engenheiro Gastão de Mesquita Filho Airport	Cianorte	Brazil
DOU	Dourados Airport	Dourados	Brazil
ERM	Erechim Airport	Erechim	Brazil
FBE	Paulo Abdala Airport	Francisco Beltrão	Brazil
GGJ	Guaíra Airport	Guaíra	Brazil
HRZ	Walter Bündchen Airport	Horizontina	Brazil
IJU	João Batista Bos Filho Airport	Ijuí	Brazil
ITQ	Itaqui Airport	Itaqui	Brazil
JCB	Santa Terezinha Airport	Joaçaba	Brazil
CBW	Campo Mourão Airport	Campo Mourão	Brazil
QDB	Cachoeira do Sul Airport	Cachoeira Do Sul	Brazil
OAL	Cacoal Airport	Cacoal	Brazil
LOI	Helmuth Baungarten Airport	Lontras	Brazil
ALQ	Alegrete Novo Airport	Alegrete	Brazil
QGF	Montenegro Airport	Montenegro	Brazil
QHV	Novo Hamburgo Airport	Novo Hamburgo	Brazil
SQX	São Miguel do Oeste Airport	São Miguel Do Oeste	Brazil
APX	Arapongas Airport	Arapongas	Brazil
VRZ	Padre Israel Airport	Lavras	Brazil
PTO	Juvenal Loureiro Cardoso Airport	Pato Branco	Brazil
PNG	Paranaguá Airport	Paranaguá	Brazil
PVI	Paranavaí Airport	Paranavaí	Brazil
PBB	Paranaíba Airport	Paranaíba	Brazil
SQY	São Lourenço do Sul Airport	São Lourenço Do Sul	Brazil
SSS	Siassi Airport	Siassi	Papua New Guinea
JBS	São Borja Airport	São Borja	Brazil
CSU	Santa Cruz do Sul Airport	Santa Cruz Do Sul	Brazil
TJL	Plínio Alarcom Airport	Três Lagoas	Brazil
UMU	Orlando de Carvalho Airport	Umuarama	Brazil
ZFU	Unifly Heliport	Arujá	Brazil
UVI	União da Vitória Airport	União da Vitória	Brazil
VIA	Videira Airport	Videira	Brazil
CTQ	Santa Vitória do Palmar Airport	Santa Vitória do Palmar	Brazil
AXE	Xanxerê Airport	Xanxerê	Brazil
AAG	Avelino Vieira Airport	Arapoti	Brazil
SRA	Luis Alberto Lehr Airport	Santa Rosa	Brazil
PGZ	Ponta Grossa Airport - Comandante Antonio Amilton Beraldo	Ponta Grossa	Brazil
ATI	Artigas International Airport	Artigas	Uruguay
BUV	Placeres Airport	Bella Union	Uruguay
CYR	Colonia Laguna de Los Patos International Airport	Colonia del Sacramento	Uruguay
DZO	Santa Bernardina International Airport	Durazno	Uruguay
PDP	Capitan Corbeta CA Curbelo International Airport	Punta del Este	Uruguay
MLZ	Cerro Largo International Airport	Melo	Uruguay
MVD	Carrasco General Cesáreo L. Berisso International Airport	Ciudad de la Costa	Uruguay
PDU	Tydeo Larre Borges Airport	Paysandú	Uruguay
RVY	Presidente General Don Oscar D. Gestido International Airport	Rivera	Uruguay
STY	Nueva Hesperides International Airport	Salto	Uruguay
TAW	Tacuarembo Airport	Tacuarembo	Uruguay
TYT	Treinta y Tres Airport	Treinta y Tres	Uruguay
VCH	Vichadero Airport	Vichadero	Uruguay
AGV	Oswaldo Guevara Mujica Airport	Acarigua	Venezuela
AAO	Anaco Airport	Anaco	Venezuela
LPJ	Armando Schwarck Airport	Guayabal	Venezuela
BLA	General José Antonio Anzoategui International Airport	Barcelona	Venezuela
BNS	Barinas Airport	Barinas	Venezuela
BRM	Barquisimeto International Airport	Barquisimeto	Venezuela
MYC	Escuela Mariscal Sucre Airport	Maracay	Venezuela
CBL	Aeropuerto "General Tomas de Heres". Ciudad Bolivar		Venezuela
CXA	Caicara del Orinoco Airport		Venezuela
ZRZ	Zaraza Airport	Zaraza	Venezuela
CUV	Casigua El Cubo Airport	Casigua El Cubo	Venezuela
CLZ	Calabozo Airport	Guarico	Venezuela
CAJ	Canaima Airport	Canaima	Venezuela
CUP	General Francisco Bermúdez Airport	Carúpano	Venezuela
CZE	José Leonardo Chirinos Airport	Coro	Venezuela
CUM	Cumaná (Antonio José de Sucre) Airport		Venezuela
PPZ	Puerto Paez Airport	Puerto Paez	Venezuela
EOR	El Dorado Airport	Bolivar	Venezuela
EOZ	Elorza Airport		Venezuela
GDO	Guasdualito Airport	Guasdualito	Venezuela
GUI	Guiria Airport		Venezuela
GUQ	Guanare Airport	Guanare	Venezuela
HGE	Higuerote Airport	Higuerote	Venezuela
ICA	Icabarú Airport		Venezuela
ICC	Andrés Miguel Salazar Marcano Airport	Isla de Coche	Venezuela
LSP	Josefa Camejo International Airport	Paraguaná	Venezuela
KAV	Kavanayen Airport	Kavanayén	Venezuela
LFR	La Fria Airport		Venezuela
MAR	La Chinita International Airport	Maracaibo	Venezuela
MRD	Alberto Carnevalli Airport	Mérida	Venezuela
PMV	Del Caribe Santiago Mariño International Airport	Isla Margarita	Venezuela
CCS	Simón Bolívar International Airport	Caracas	Venezuela
MUN	Maturín Airport	Maturín	Venezuela
CBS	Oro Negro Airport	Cabimas	Venezuela
PYH	Cacique Aramare Airport	Puerto Ayacucho	Venezuela
PBL	General Bartolome Salom International Airport		Venezuela
PDZ	Pedernales Airport		Venezuela
PPH	Perai-Tepuy Airport	Parai-tepuí	Venezuela
SCI	Paramillo Airport		Venezuela
PZO	General Manuel Carlos Piar International Airport	Puerto Ordaz-Ciudad Guayana	Venezuela
PTM	Palmarito Airport	Palmarito	Venezuela
LRV	Los Roques Airport	Gran Roque Island	Venezuela
SVS	Stevens Village Airport	Stevens Village	United States
SVZ	San Antonio Del Tachira Airport		Venezuela
SBB	Santa Bárbara de Barinas Airport	Santa Bárbara	Venezuela
SNV	Santa Elena de Uairen Airport		Venezuela
STD	Mayor Buenaventura Vivas International Airport	Santo Domingo	Venezuela
SNF	Sub Teniente Nestor Arias Airport	San Felipe	Venezuela
SFD	San Fernando De Apure Airport	Inglaterra	Venezuela
SOM	San Tomé Airport	El Tigre	Venezuela
STB	Miguel Urdaneta Fernández Airport	San Carlos del Zulia	Venezuela
TUV	Tucupita Airport	Tucupita	Venezuela
TMO	Tumeremo Airport		Venezuela
URM	Uriman Airport		Venezuela
VLN	Arturo Michelena International Airport	Valencia	Venezuela
VIG	Juan Pablo Pérez Alfonso Airport	El Vigía	Venezuela
VLV	Dr. Antonio Nicolás Briceño Airport	Valera	Venezuela
VDP	Valle de La Pascua Airport		Venezuela
BAZ	Barcelos Airport	Barcelos	Brazil
JSB	Walfrido Salmito de Almeida Airport	São Benedito	Brazil
LCB	André Antônio Maggi Airport	Pontes e Lacerda	Brazil
RBB	Borba Airport	Borba	Brazil
CAF	Carauari Airport	Carauari	Brazil
CQS	Costa Marques Airport	Costa Marques	Brazil
DMT	Diamantino Airport	Diamantino	Brazil
DNO	Dianópolis Airport	Dianópolis	Brazil
SWE	Siwea Airport	Siwea	Papua New Guinea
ERN	Eirunepé Airport	Eirunepé	Brazil
CQA	Canarana Airport	Canarana	Brazil
SXO	São Félix do Araguaia Airport	São Félix Do Araguaia	Brazil
SWG	Satwag Airport	Satwag	Papua New Guinea
GRP	Gurupi Airport	Gurupi	Brazil
AUX	Araguaína Airport	Araguaína	Brazil
GGB	Frederico Carlos Müller Airport	Água Boa	Brazil
HUW	Humaitá Airport	Humaitá	Brazil
IPG	Ipiranga Airport	Santo Antônio do Içá	Brazil
IDO	Santa Izabel do Morro Airport	Cristalândia	Brazil
JPR	Ji-Paraná Airport	Ji-Paraná	Brazil
JIA	Juína Airport	Juína	Brazil
JRN	Juruena Airport	Juruena	Brazil
JTI	Jataí Airport	Jataí	Brazil
CCX	Cáceres Airport	Cáceres	Brazil
CIZ	Coari Airport	Coari	Brazil
NSR	Serra da Capivara Airport	São Raimundo Nonato	Brazil
TLZ	Catalão Airport	Catalão	Brazil
LBR	Lábrea Airport	Lábrea	Brazil
RVD	General Leite de Castro Airport	Rio Verde	Brazil
MBZ	Maués Airport	Maués	Brazil
NVP	Novo Aripuanã Airport	Novo Aripuanã	Brazil
BCR	Novo Campo Airport	Boca do Acre	Brazil
NQL	Niquelândia Airport	Niquelândia	Brazil
APS	Anápolis Airport	Anápolis	Brazil
FBA	Fonte Boa Airport	Fonte Boa	Brazil
PIN	Parintins Airport	Parintins	Brazil
PBQ	Pimenta Bueno Airport	Pimenta Bueno	Brazil
PBX	Fazenda Piraguassu Airport	Porto Alegre do Norte	Brazil
SWR	Silur Airport	Silur Mission	Papua New Guinea
AAI	Arraias Airport	Arraias	Brazil
ROO	Maestro Marinho Franco Airport	Rondonópolis	Brazil
AIR	Aripuanã Airport	Aripuanã	Brazil
OPS	Presidente João Batista Figueiredo Airport	Sinop	Brazil
STZ	Santa Terezinha Airport	Santa Terezinha	Brazil
IRZ	Tapuruquara Airport	Santa Isabel Do Rio Negro	Brazil
TGQ	Tangará da Serra Airport	Tangará da Serra	Brazil
AZL	Fazenda Tucunaré Airport	Sapezal	Brazil
QHN	Taguatinga Airport	Taguatinga	Brazil
SQM	São Miguel do Araguaia Airport	São Miguel Do Araguaia	Brazil
MTG	Vila Bela da Santíssima Trindade Airport	Vila Bela Da Santíssima Trindade	Brazil
VLP	Vila Rica Airport	Vila Rica	Brazil
MBK	Regional Orlando Villas Boas Airport	Matupá	Brazil
NOK	Xavantina Airport	Nova Xavantina	Brazil
IUP	Apuí Airport	Apuí	Brazil
SWZ	Western Sydney International (Nancy Bird Walton) Airport	Sydney (Badgerys Creek)	Australia
ITI	Fazenda Americana Airport	Itambacuri	Brazil
SXH	Sehulea Airport	Sehulea	Papua New Guinea
SXP	Nunam Iqua Airport	Nunam Iqua	United States
AHL	Aishalton Airport	Aishalton	Guyana
NAI	Annai Airport	Annai	Guyana
SYB	Seal Bay Seaplane Base	Seal Bay	United States
BMJ	Baramita Airport	Baramita	Guyana
GFO	Bartica A Airport	Bartica	Guyana
GEO	Cheddi Jagan International Airport	Georgetown	Guyana
SYF	Silva Bay Seaplane Base	Gabriola Island	Canada
OGL	Eugene F. Correira International Airport	Ogle	Guyana
IMB	Imbaimadai Airport	Imbaimadai	Guyana
KAR	Kamarang Airport	Kamarang	Guyana
KRM	Karanambo Airport	Karanambo	Guyana
KRG	Karasabai Airport	Karasabai	Guyana
KTO	Kato Airport	Kato	Guyana
KKG	Konawaruk Airport	Konawaruk	Guyana
SYL	Roberts Army Heliport	Camp Roberts/San Miguel	United States
LUB	Lumid Pau Airport	Lumid Pau	Guyana
LTM	Lethem Airport	Lethem	Guyana
USI	Mabaruma Airport	Mabaruma	Guyana
MHA	Mahdia Airport	Mahdia	Guyana
VEG	Maikwak Airport	Maikwak	Guyana
MYM	Monkey Mountain Airport	Monkey Mountain	Guyana
MWJ	Matthews Ridge Airport	Matthews Ridge	Guyana
SYN	Stanton Airfield	Dennison	United States
QSX	New Amsterdam Airport	New Amsterdam	Guyana
ORJ	Orinduik Airport	Orinduik	Guyana
PKM	Port Kaituma Airport	Port Kaituma	Guyana
PIQ	Pipillipai Airport	Pipillipai	Guyana
PMT	Paramakatoi Airport	Paramakatoi	Guyana
PRR	Paruima Airport	Paruima	Guyana
SDC	Sand Creek Airport	Sand Creek	Guyana
SKM	Skeldon Airport	Skeldon	Guyana
SZN	Santa Cruz Island Airport	Santa Cruz Island	United States
SZP	Santa Paula Airport	Santa Paula	United States
TAO	Qingdao Jiaodong International Airport	Qingdao (Jiaozhou)	China
ANU	V C Bird International Airport	Osbourn	Antigua & Barbuda
BBQ	Codrington Airport	Codrington	Antigua & Barbuda
TBE	Timbunke Airport	Timbunke	Papua New Guinea
BGI	Grantley Adams International Airport	Bridgetown	Barbados
TBQ	Tarabo Airport	Tarabo	Papua New Guinea
TBV	Tabal Airstrip	Tabal Island	Marshall Islands
TCK	Tinboli Airport	Tinboli	Papua New Guinea
TCT	Takotna Airport	Takotna	United States
TDB	Tetebedi Airport	Tetebedi	Papua New Guinea
DCF	Canefield Airport	Canefield	Dominica
DOM	Douglas-Charles Airport	Marigot	Dominica
TDS	Sasereme Airport	Sasereme	Papua New Guinea
TEO	Terapo Airport	Terapo Mission	Papua New Guinea
TFB	Tifalmin Airport	Tifalmin	Papua New Guinea
DSD	La Désirade Airport	Grande Anse	Guadeloupe
BBR	Basse-Terre Baillif Airport	Basse-Terre	Guadeloupe
SFC	St-François Airport	St-François	Guadeloupe
FDF	Martinique Aimé Césaire International Airport	Fort-de-France	Martinique
SFG	Grand Case-Espérance Airport	Grand Case	St. Martin
SBH	Saint Barthélemy - Rémy de Haenen Airport	Gustavia / Saint-Jean	St. Barthélemy
GBJ	Marie-Galante Airport	Grand Bourg	Guadeloupe
PTP	Pointe-à-Pitre Le Raizet International  Airport	Pointe-à-Pitre	Guadeloupe
LSS	Terre-de-Haut Airport	Les Saintes	Guadeloupe
TGL	Tagula Airport	Sudest Island	Papua New Guinea
GND	Maurice Bishop International Airport	Saint George's	Grenada
CRU	Lauriston Airport	Carriacou Island	Grenada
THW	Trincomalee Harbor Waterdrome	Trincomalee	Sri Lanka
STT	Cyril E. King Airport	Charlotte Amalie	U.S. Virgin Islands
STX	Henry E Rohlsen Airport	Christiansted	U.S. Virgin Islands
ARE	Antonio Nery Juarbe Pol Airport	Arecibo	Puerto Rico
BQN	Rafael Hernández International Airport	Aguadilla	Puerto Rico
TJC	Ticantiquí Airport	Ticantiquí	Panama
CPX	Benjamin Rivera Noriega Airport	Culebra	Puerto Rico
SIG	Fernando Luis Ribas Dominicci Airport	San Juan	Puerto Rico
MAZ	Eugenio Maria De Hostos Airport	Mayaguez	Puerto Rico
PSE	Mercedita Airport	Ponce	Puerto Rico
NRR	José Aponte de la Torre Airport	Ceiba	Puerto Rico
SJU	Luis Munoz Marin International Airport	San Juan	Puerto Rico
VQS	Antonio Rivera Rodriguez Airport	Vieques	Puerto Rico
TKE	Tenakee Seaplane Base	Tenakee Springs	United States
TKL	Taku Lodge Seaplane Base	Taku Lodge	United States
SKB	Robert L. Bradshaw International Airport	Basseterre	St. Kitts & Nevis
NEV	Vance W. Amory International Airport	Charlestown	St. Kitts & Nevis
TLP	Tumolbil Airport	Tumolbil	Papua New Guinea
SLU	George F. L. Charles Airport	Castries	St. Lucia
UVF	Hewanorra International Airport	Vieux Fort	St. Lucia
SYS	Saskylakh Airport	Saskylakh	Russia
TLT	Tuluksak Airport	Tuluksak	United States
KEA	Kerki Airport	Kerki	Turkmenistan
AUA	Queen Beatrix International Airport	Oranjestad	Aruba
BON	Flamingo International Airport	Kralendijk, Bonaire	Caribbean Netherlands
CUR	Hato International Airport	Willemstad	Curaçao
EUX	F. D. Roosevelt Airport	Sint Eustatius	Caribbean Netherlands
SXM	Princess Juliana International Airport	Saint Martin	Sint Maarten
SAB	Juancho E. Yrausquin Airport	Saba	Caribbean Netherlands
TNW	Jumandy Airport	Ahuano	Ecuador
TOK	Torokina Airport	Torokina	Papua New Guinea
TOV	Tortola West End Seaplane Base	Tortola	British Virgin Islands
PTA	Port Alsworth Airport	Port Alsworth	United States
TPT	Tapeta Airport	Tapeta	Liberia
AXA	Clayton J Lloyd International Airport	The Valley	Anguilla
BGG	Bingöl Airport	Bingöl	Turkey
COV	Çukurova International Airport	Tarsus	Turkey
MNI	John A. Osborne Airport	Gerald's Park	Montserrat
TSG	Tanacross Airport	Tanacross	United States
TSI	Tsile Tsile Airport	Tsile Tsile	Papua New Guinea
TAB	A.N.R. Robinson International Airport	Scarborough	Trinidad & Tobago
POS	Piarco International Airport	Port of Spain	Trinidad & Tobago
TTW	Tissa Tank Waterdrome	Tissamaharama	Sri Lanka
TUJ	Tum Airport	Tum	Ethiopia
NGD	Captain Auguste George Airport	Anegada	British Virgin Islands
EIS	Terrance B. Lettsome International Airport	Road Town	British Virgin Islands
VIJ	Virgin Gorda Airport	Spanish Town	British Virgin Islands
SVD	Argyle International Airport	Kingstown	St. Vincent & Grenadines
BQU	J F Mitchell Airport	Bequia	St. Vincent & Grenadines
CIW	Canouan Airport	Canouan	St. Vincent & Grenadines
MQS	Mustique Airport	Mustique Island	St. Vincent & Grenadines
UNI	Union Island International Airport	Union Island	St. Vincent & Grenadines
DSX	Dongsha Island (Pratas Island) Airport	Kaohsiung (Cijin - Pratas Island)	Taiwan
CMJ	Qimei Airport	Qimei	Taiwan
TWC	Tumxuk Tangwangcheng Airport	Tumxuk	China
TWH	Two Harbors Amphibious Terminal	Two Harbors	United States
BDA	L.F. Wade International Airport	Hamilton	Bermuda
TYE	Tyonek Airport	Tyonek	United States
GIT	Mchauru Airport	Geita	Tanzania
LUY	Lushoto Airport	Lushoto	Tanzania
TZO	Tsimiroro Airport	Ankisatra	Madagascar
DBS	Dubois Municipal Airport	Dubois	United States
MXR	Myrhorod Air Base	Myrhorod	Ukraine
KHU	Kakhnovka Airfield	Kremenchuk	Ukraine
KCP	Kam'yanets'-Podil's'kyi Airfield	Kamyan'ka	Ukraine
ALA	Almaty International Airport	Almaty	Kazakhstan
BXH	Balkhash Airport	Balkhash	Kazakhstan
BXJ	Boralday Airport	Boralday	Kazakhstan
TDK	Taldykorgan Airport	Taldykorgan	Kazakhstan
NQZ	Nursultan Nazarbayev International Airport	Astana	Kazakhstan
KOV	Kokshetau Airport	Kokshetau	Kazakhstan
PPK	Petropavl Airport	Petropavl	Kazakhstan
DMB	Taraz Airport	Taraz	Kazakhstan
UAE	Mount Aue Airport		Papua New Guinea
IKU	Issyk-Kul International Airport	Tamchy	Kyrgyzstan
FRU	Manas International Airport	Bishkek	Kyrgyzstan
OSS	Osh Airport	Osh	Kyrgyzstan
CIT	Shymkent Airport	Shymkent	Kazakhstan
HSA	Hazrat Sultan International Airport	Turkıstan	Kazakhstan
DZN	Zhezkazgan National Airport	Zhezkazgan	Kazakhstan
KGF	Sary-Arka Airport	Karaganda	Kazakhstan
KZO	Kyzylorda Airport	Kyzylorda	Kazakhstan
URA	Uralsk Airport	Uralsk	Kazakhstan
EKB	Ekibastuz Airport	Ekibastuz	Kazakhstan
UKK	Ust-Kamenogorsk Airport	Ust-Kamenogorsk (Oskemen)	Kazakhstan
PWQ	Pavlodar Airport	Pavlodar	Kazakhstan
PLX	Semey Airport	Semey	Kazakhstan
SZI	Zaysan Airport	Zaysan	Kazakhstan
SCO	Aktau Airport	Aktau	Kazakhstan
GUW	Atyrau International Airport	Atyrau	Kazakhstan
AKX	Aktobe Airport	Aktobe	Kazakhstan
AYK	Arkalyk North Airport	Arkalyk	Kazakhstan
KSN	Kostanay West Airport	Kostanay	Kazakhstan
GYD	Heydar Aliyev International Airport	Baku	Azerbaijan
GNJ	Ganja International Airport	Ganja	Azerbaijan
LLK	Lankaran International Airport	Lankaran	Azerbaijan
NAJ	Nakhchivan Airport	Nakhchivan	Azerbaijan
GBB	Gabala International Airport	Gabala	Azerbaijan
ZTU	Zaqatala International Airport	Zaqatala	Azerbaijan
ZZE	Zangilan International Airport	Zangilan	Azerbaijan
YLV	Yevlakh Airport	Yevlakh	Azerbaijan
UBI	Buin Airport	Buin	Papua New Guinea
LWN	Shirak International Airport	Gyumri	Armenia
EVN	Zvartnots International Airport	Yerevan	Armenia
BQJ	Batagay Airport	Batagay	Russia
SUK	Sakkyryr Airport	Batagay-Alyta	Russia
UKG	Ust-Kuyga Airport	Ust-Kuyga	Russia
TLK	Talakan Airport	Talakan Oil Field	Russia
ADH	Aldan Airport	Aldan	Russia
YKS	Yakutsk Airport	Yakutsk	Russia
NER	Chulman Airport	Neryungri	Russia
MQJ	Moma Airport	Khonuu	Russia
GYG	Magan Airport	Magan	Russia
OLZ	Olyokminsk Airport	Olyokminsk	Russia
USR	Ust-Nera Airport	Ust-Nera	Russia
UMS	Ust-Maya Airport	Ust-Maya	Russia
VHV	Verkhnevilyuisk Airport	Verkhnevilyuisk	Russia
NYR	Nyurba Airport	Nyurba	Russia
SUY	Suntar Airport	Suntar	Russia
VYI	Vilyuisk Airport	Vilyuisk	Russia
ULK	Lensk Airport	Lensk	Russia
ONK	Olenyok Airport	Olenyok	Russia
PYJ	Polyarny Airport	Yakutia	Russia
MJZ	Mirny Airport	Mirny	Russia
BGN	Belaya Gora Airport	Belaya Gora	Russia
SEK	Srednekolymsk Airport	Srednekolymsk	Russia
CKH	Chokurdakh Airport	Chokurdah	Russia
CYX	Cherskiy Airport	Cherskiy	Russia
IKS	Tiksi Airport	Tiksi	Russia
ZKP	Zyryanka Airport	Zyryanka	Russia
KXO	Kisoro Airport	Kisoro	Uganda
KHX	Savannah Airstrip	Kihihi	Uganda
OYG	Moyo Airport	Moyo	Uganda
UGB	Ugashik Bay Airport	Pilot Point	United States
KUT	David the Builder Kutaisi International Airport	Kopitnari	Georgia
BUS	Batumi International Airport	Batumi	Georgia
SUI	Sukhumi Babushara /  Vladislav Ardzinba International Airport	Sukhumi	Georgia
TBS	Tbilisi International Airport	Tbilisi	Georgia
BQS	Ignatyevo Airport	Blagoveschensk	Russia
EYA	Zeya Airport	Zeya	Russia
TYD	Tynda Airport	Tynda	Russia
KHV	Khabarovsk Novy Airport	Khabarovsk	Russia
KXK	Komsomolsk-on-Amur Airport	Komsomolsk-on-Amur	Russia
GVN	Sovetskaya Gavan (Maygatka) Airport	Sovetskaya Gavan	Russia
DYR	Ugolny Yuri Ryktheu Airport	Anadyr	Russia
PVS	Provideniya Bay Airport	Chukotka	Russia
KPW	Keperveem Airport	Keperveem	Russia
GDX	Sokol Airport	Magadan	Russia
KVM	Markovo Airport	Markovo	Russia
PWE	Pevek Airport	Apapelgino	Russia
SWV	Severo-Evensk Airport	Evensk	Russia
BQG	Bogorodskoye Airport	Bogorodskoye	Russia
NLI	Nikolayevsk-na-Amure Airport	Nikolayevsk-na-Amure Airport	Russia
OHO	Okhotsk Airport	Okhotsk	Russia
PKC	Yelizovo Airport	Petropavlovsk-Kamchatsky	Russia
BVV	Burevestnik Airport	Kurilsk	Russia
OHH	Okha Airport	Okha	Russia
ITU	Iturup Airport	Kurilsk	Russia
EKS	Shakhtyorsk Airport	Shakhtyorsk	Russia
DEE	Yuzhno-Kurilsk Mendeleyevo Airport	Yuzhno-Kurilsk	Russia
ZZO	Zonalnoye Airport	Tymovskoye	Russia
UUS	Yuzhno-Sakhalinsk Airport	Yuzhno-Sakhalinsk	Russia
AEM	Amgu Airport	Amgu	Russia
ETL	Svetlaya Airport	Svetlaya	Russia
EDN	Yedinka Airport	Yedinka	Russia
KVR	Kavalerovo Airport	Kavalerovo	Russia
TLY	Plastun Airport	Plastun	Russia
NEI	Terney Airport	Terney	Russia
VVO	Vladivostok International Airport	Artyom	Russia
HTA	Chita-Kadala International Airport	Chita	Russia
CZR	Chara Airport	Chara	Russia
BTK	Bratsk Airport	Bratsk	Russia
UIK	Ust-Ilimsk Airport	Ust-Ilimsk	Russia
IKT	Irkutsk International Airport	Irkutsk	Russia
ODO	Bodaybo Airport	Bodaybo	Russia
ERG	Yerbogachen Airport	Erbogachen	Russia
KCK	Kirensk Airport	Kirensk	Russia
RZH	Preobrazheniye Airport	Preobrazheniye	Russia
UKX	Ust-Kut Airport	Ust-Kut	Russia
NZG	Nizhneangarsk International Airport	Nizhneangarsk	Russia
UUD	Baikal International Airport	Ulan Ude	Russia
UJE	Ujae Atoll Airport	Ujae Atoll	Marshall Islands
UJN	Uljin Airport	Bongsan-ri, Uljin	South Korea
KBP	Boryspil International Airport	Boryspil	Ukraine
KRQ	Kramatorsk Airport	Kramatorsk	Ukraine
MPW	Mariupol International Airport	Mariupol	Ukraine
ERD	Berdyansk Airport	Berdyansk	Ukraine
DNK	Dnipro International Airport	Dnipro	Ukraine
OZH	Zaporizhzhia International Airport	Zaporizhia	Ukraine
KWG	Kryvyi Rih International Airport	Kryvyi Rih	Ukraine
UKS	Sevastopol International Airport / Belbek Air Base	Sevastopol	Ukraine
SIP	Simferopol International Airport	Simferopol	Ukraine
KHC	Kerch Airport	Kerch	Ukraine
UKH	Mukhaizna Airport	Mukhaizna Oil Field	Oman
HRK	Kharkiv International Airport	Kharkiv	Ukraine
PLV	Suprunovka Airport	Poltava	Ukraine
UMY	Sumy Airport	Sumy	Ukraine
CKC	Cherkasy International Airport	Cherkasy	Ukraine
KGO	Kirovograd Airport	Kirovograd	Ukraine
IEV	Ihor Sikorsky Kyiv International Airport (Zhuliany)	Kyiv	Ukraine
ZTR	Zhytomyr Airport		Ukraine
UCK	Lutsk Airport	Lutsk	Ukraine
HMJ	Khmelnytskyi Airport	Khmelnytskyi	Ukraine
IFO	Ivano-Frankivsk International Airport	Ivano-Frankivsk	Ukraine
LWO	Lviv International Airport	Lviv	Ukraine
CWC	Chernivtsi International Airport	Chernivtsi	Ukraine
RWN	Rivne International Airport	Rivne	Ukraine
TNL	Ternopil International Airport	Ternopil	Ukraine
UDJ	Uzhhorod International Airport	Uzhhorod	Ukraine
KHE	Kherson International Airport	Kherson	Ukraine
NLV	Mykolaiv International Airport	Nikolayev	Ukraine
ODS	Odessa International Airport	Odessa	Ukraine
VIN	Vinnytsia/Gavyryshivka International Airport	Vinnitsa	Ukraine
ARH	Talagi Airport	Archangelsk	Russia
VKV	Vaskovo Airport	Arkhangelsk	Russia
LDG	Leshukonskoye Airport	Leshukonskoye	Russia
NNM	Naryan Mar Airport	Naryan Mar	Russia
CSH	Solovki Airport	Solovetsky Islands	Russia
CEE	Cherepovets Airport	Cherepovets	Russia
AMV	Amderma Airport	Amderma	Russia
VRI	Varandey Airport	Varandey	Russia
ULH	Majeed Bin Abdulaziz Airport	Al Ula	Saudi Arabia
KSZ	Kotlas Airport	Kotlas	Russia
LED	Pulkovo Airport	St. Petersburg	Russia
KVK	Kirovsk-Apatity Airport	Apatity	Russia
MMK	Murmansk Airport	Murmansk	Russia
PKV	Pskov Airport	Pskov	Russia
PES	Petrozavodsk Airport	Petrozavodsk	Russia
VGD	Vologda Airport	Vologda	Russia
BQT	Brest Airport	Brest	Belarus
GME	Gomel Airport	Gomel	Belarus
VTB	Vitebsk Vostochny Airport	Vitebsk	Belarus
KGD	Khrabrovo Airport	Kaliningrad	Russia
GNA	Hrodna Airport	Hrodna	Belarus
MSQ	Minsk National Airport	Minsk	Belarus
MVQ	Mogilev Airport	Mogilev	Belarus
ABA	Abakan International Airport	Abakan	Russia
BAX	Barnaul Airport	Barnaul	Russia
RGK	Gorno-Altaysk Airport	Gorno-Altaysk	Russia
KEJ	Kemerovo Airport	Kemerovo	Russia
BKA	Baykit Airport	Baykit	Russia
EIE	Yeniseysk Airport	Yeniseysk	Russia
YAE	Yartsevo Airport	Yartsevo	Russia
TGP	Podkamennaya Tunguska Airport	Bor	Russia
VEO	Severo-Yeniseysk Airport	Severo-Yeniseysk	Russia
GOY	Tura Mountain Airport	Tura	Russia
VAQ	Vanavara Airport	Vanavara	Russia
BGS	Boguchany Airport	Boguchany	Russia
KNY	Kodinsk Airport		Russia
KJA	Krasnoyarsk International Airport	Krasnoyarsk	Russia
KCY	Krasnoyarsk Cheremshanka Airport	Krasnoyarsk	Russia
ACS	Achinsk Airport	Achinsk	Russia
KYZ	Kyzyl Airport	Kyzyl	Russia
OVB	Novosibirsk Tolmachevo Airport	Novosibirsk	Russia
OMS	Omsk Central Airport	Omsk	Russia
SWT	Strezhevoy Airport	Strezhevoy	Russia
TOF	Bogashevo Airport	Tomsk	Russia
NOZ	Spichenkovo Airport	Novokuznetsk	Russia
DKS	Dikson Airport	Dikson	Russia
HTG	Khatanga Airport	Khatanga	Russia
SES	Svetlogorsk Airport	Svetlogorsk	Russia
IAA	Igarka Airport	Igarka	Russia
NSK	Norilsk-Alykel Airport	Norilsk	Russia
THX	Turukhansk Airport	Turukhansk	Russia
AAQ	Anapa Vityazevo Airport	Krasnyi Kurgan	Russia
EIK	Yeysk Airport	Yeysk	Russia
GDZ	Gelendzhik Airport	Gelendzhik	Russia
KRR	Krasnodar Pashkovsky International Airport	Krasnodar	Russia
MCX	Makhachkala Uytash International Airport	Makhachkala	Russia
MRV	Mineralnyye Vody Airport	Mineralnyye Vody	Russia
NAL	Nalchik Airport	Nalchik	Russia
OGZ	Vladikavkaz Beslan International Airport	Beslan	Russia
IGT	Magas Airport	Sunzha	Russia
STW	Stavropol Shpakovskoye Airport	Stavropol	Russia
ROV	Platov International Airport	Rostov-on-Don	Russia
TGK	Taganrog Yuzhny Airport	Taganrog	Russia
AER	Sochi International Airport	Sochi	Russia
ASF	Astrakhan Narimanovo Boris M. Kustodiev International Airport	Astrakhan	Russia
ESL	Elista Airport	Elista	Russia
VOG	Volgograd International Airport	Volgograd	Russia
BNH	Cape Air Seaplanes on Boston Harbor Seaplane Base	Boston	United States
XWA	Williston Basin International Airport	Williston	United States
RTL	Spirit Lake Municipal Airport	Okoboji	United States
WWT	Mertarvik Airport	Mertarvik	United States
PQS	Pilot Station Airport	Pilot Station	United States
CEK	Chelyabinsk Balandino Airport	Chelyabinsk	Russia
MQF	Magnitogorsk International Airport	Magnitogorsk	Russia
SBT	Sabetta International Airport	Sabetta	Russia
BVJ	Bovanenkovo Airport	Bovanenkovo	Russia
SLY	Salekhard Airport	Salekhard	Russia
YMK	Mys Kamenny Airport	Mys Kamennyi	Russia
KKQ	Krasnoselkup Airport	Krasnoselkup	Russia
TQL	Tarko-Sale Airport	Tarko-Sale	Russia
UEN	Urengoy Airport	Urengoy	Russia
EZV	Berezovo Airport		Russia
HMA	Khanty Mansiysk Airport	Khanty-Mansiysk	Russia
IRM	Igrim Airport		Russia
KXD	Kondinskoye Airport	Kondinskoye	Russia
NYA	Nyagan Airport	Nyagan	Russia
OVS	Sovetskiy Airport	Sovetskiy	Russia
URJ	Uray Airport	Uray	Russia
EYK	Beloyarskiy Airport		Russia
IJK	Izhevsk Airport	Izhevsk	Russia
KVX	Pobedilovo Airport	Kirov	Russia
NYM	Nadym Airport	Nadym	Russia
NUX	Novy Urengoy Airport	Novy Urengoy	Russia
NJC	Nizhnevartovsk Airport	Nizhnevartovsk	Russia
PEE	Perm International Airport	Perm	Russia
KGP	Kogalym International Airport	Kogalym	Russia
NFG	Nefteyugansk Airport	Nefteyugansk	Russia
NOJ	Noyabrsk Airport	Noyabrsk	Russia
SGC	Surgut Airport	Surgut	Russia
SVX	Koltsovo Airport	Yekaterinburg	Russia
RMZ	Remezov Airport	Tobolsk	Russia
TOX	Tobolsk Airport	Tobolsk	Russia
TJM	Roshchino International Airport	Tyumen	Russia
KRO	Kurgan Airport	Kurgan	Russia
BKN	Balkanabat Airport	Balkanabat	Turkmenistan
GMV	Monument Valley Airport	Oljato-Monument Valley	United States
ASB	Ashgabat International Airport	Ashgabat	Turkmenistan
KRW	Turkmenbashi International Airport	Turkmenbashi	Turkmenistan
MYP	Mary International Airport	Mary	Turkmenistan
TAZ	Daşoguz Airport	Daşoguz	Turkmenistan
CRZ	Türkmenabat International Airport	Türkmenabat	Turkmenistan
DYU	Dushanbe Airport	Dushanbe	Tajikistan
TJU	Kulob Airport	Kulyab	Tajikistan
LBD	Khujand Airport	Khujand	Tajikistan
KQT	Qurghonteppa International Airport	Kurgan-Tyube	Tajikistan
AZN	Andizhan Airport	Andizhan	Uzbekistan
FEG	Fergana International Airport	Fergana	Uzbekistan
OQN	Kokand Airport	Kokand	Uzbekistan
NMA	Namangan Airport	Namangan	Uzbekistan
MOK	Muynak Airport	Muynak	Uzbekistan
NCU	Nukus Airport	Nukus	Uzbekistan
UGC	Urgench Airport	Urgench	Uzbekistan
NVI	Navoi Airport	Navoi	Uzbekistan
BHK	Bukhara International Airport	Bukhara	Uzbekistan
KSQ	Karshi Airport	Karshi	Uzbekistan
AFS	Sugraly Airport	Zarafshan	Uzbekistan
SKD	Samarkand Airport	Samarkand	Uzbekistan
TMJ	Termez Airport	Termez	Uzbekistan
TAS	Tashkent International Airport	Tashkent	Uzbekistan
UTU	Ustupu Airport	Ustupu	Panama
KMW	Kostroma Sokerkino Airport	Kostroma	Russia
KLF	Grabtsevo Airport	Kaluga	Russia
IWA	Ivanovo South Airport	Ivanovo	Russia
RYB	Staroselye Airport	Rybinsk	Russia
BZK	Bryansk Airport	Bryansk	Russia
ZIA	Zhukovsky International Airport	Moscow	Russia
DME	Domodedovo International Airport	Moscow	Russia
IAR	Tunoshna Airport	Tunoshna	Russia
SVO	Sheremetyevo International Airport	Moscow	Russia
KLD	Migalovo Air Base	Tver	Russia
OSF	Ostafyevo International Airport	Moscow	Russia
CKL	Chkalovskiy Air Base	Moscow	Russia
EGO	Belgorod International Airport	Belgorod	Russia
URS	Kursk East Airport	Kursk	Russia
LPK	Lipetsk Airport	Lipetsk	Russia
VOZ	Voronezh International Airport	Voronezh	Russia
TBW	Donskoye Airport	Tambov	Russia
UUU	Manumu Airport	Manumu	Papua New Guinea
TYA	Klokovo Airfield	Tula	Russia
VKO	Vnukovo International Airport	Moscow	Russia
UCT	Ukhta Airport	Ukhta	Russia
INA	Inta Airport	Inta	Russia
PEX	Pechora Airport	Pechora	Russia
USK	Usinsk Airport	Usinsk	Russia
VKT	Vorkuta Airport	Vorkuta	Russia
UTS	Ust-Tsylma Airport	Ust-Tsylma	Russia
SCW	Syktyvkar Airport	Syktyvkar	Russia
GOJ	Nizhny Novgorod Strigino International Airport	Nizhny Novgorod	Russia
UUA	Bugulma Airport	Bugulma	Russia
KZN	Kazan International Airport	Kazan	Russia
NBC	Begishevo Airport	Nizhnekamsk	Russia
JOK	Yoshkar-Ola Airport	Yoshkar-Ola	Russia
CSY	Cheboksary Airport	Cheboksary	Russia
ZIX	Zhigansk Airport	Zhigansk	Russia
ULV	Ulyanovsk Baratayevka Airport	Ulyanovsk	Russia
ULY	Ulyanovsk East Airport	Cherdakly	Russia
REN	Orenburg Central Airport	Orenburg	Russia
OSW	Orsk Airport	Orsk	Russia
PEZ	Penza Airport	Penza	Russia
SKX	Saransk Airport	Saransk	Russia
BWO	Balakovo Airport	Balakovo	Russia
GSV	Gagarin International Airport	Saratov	Russia
BCX	Beloretsk Airport	Beloretsk	Russia
OKT	Oktyabrskiy Airport	Kzyl-Yar	Russia
UFA	Ufa International Airport	Ufa	Russia
KUF	Kurumoch International Airport	Samara	Russia
RBZ	Shahrisabz Southwest Airport	Shahrisabz	Uzbekistan
UZM	Hope Bay Aerodrome	Hope Bay	Canada
UZR	Urzhar Airport	Urzhar	Kazakhstan
REW	Rewa Airport, Chorhata, REWA	Rewa	India
DIU	Diu Airport	Diu	India
GDB	Gondia Airport	Gondia	India
AMD	Sardar Vallabh Bhai Patel International Airport	Ahmedabad	India
AKD	Akola Airport	Akola	India
IXU	Aurangabad Airport	Aurangabad	India
BOM	Chhatrapati Shivaji International Airport	Mumbai	India
PAB	Bilaspur Airport	Bilaspur	India
BHJ	Bhuj Airport	Bhuj	India
IXG	Belagavi Airport	Belgaum	India
BDQ	Vadodara Airport	Vadodara	India
BHO	Raja Bhoj International Airport	Bhopal	India
BHU	Bhavnagar Airport	Bhavnagar	India
NMB	Daman Airport	Daman	India
GUX	Guna Airport		India
GOI	Dabolim Airport	Vasco da Gama	India
HBX	Hubli Airport	Hubli	India
HSR	Rajkot International Airport	Rajkot	India
IDR	Devi Ahilyabai Holkar Airport	Indore	India
JLR	Jabalpur Airport	Jabalpur	India
JGA	Jamnagar Airport	Jamnagar	India
IXY	Kandla Airport	Kandla	India
HJR	Khajuraho Airport	Khajuraho	India
KLH	Kolhapur Airport	Kolhapur	India
IXK	Keshod Airport	Keshod	India
NDC	Nanded Airport	Nanded	India
NAG	Dr. Babasaheb Ambedkar International Airport	Nagpur	India
ISK	Nashik Airport	Nasik	India
PNQ	Pune Airport / Lohagaon Air Force Station	Pune	India
PBD	Porbandar Airport	Porbandar	India
RTC	Ratnagiri Airport		India
RAJ	Rajkot Airport	Rajkot	India
RPR	Swami Vivekananda Airport	Raipur	India
SAG	Shirdi Airport	Kakadi	India
SSE	Solapur Airport	Solapur	India
STV	Surat Airport	Surat	India
UDR	Maharana Pratap Airport	Udaipur	India
CMB	Bandaranaike International Colombo Airport	Colombo	Sri Lanka
ACJ	Anuradhapura Airport	Anuradhapura	Sri Lanka
BTC	Batticaloa Airport	Batticaloa	Sri Lanka
RML	Colombo Ratmalana Airport	Colombo	Sri Lanka
ADP	Ampara Airport	Ampara	Sri Lanka
HIM	Hingurakgoda Air Force Base	Polonnaruwa Town	Sri Lanka
JAF	Jaffna International Airport	Jaffna	Sri Lanka
KCT	Koggala Airport	Galle	Sri Lanka
KTY	Katukurunda Air Force Base	Kalutara	Sri Lanka
GIU	Sigiriya Air Force Base	Sigiriya	Sri Lanka
TRR	China Bay Airport	Trincomalee	Sri Lanka
WRZ	Weerawila Airport	Weerawila	Sri Lanka
HRI	Mattala Rajapaksa International Airport	Mattala	Sri Lanka
BBM	Battambang Airport	Battambang	Cambodia
KZC	Kampong Chhnang Airport	Kampong Chhnang	Cambodia
KKZ	Koh Kong Airport	Krong Khemara Phoumin	Cambodia
MWV	Mondulkiri Airport	Sen Monorom	Cambodia
PNH	Phnom Penh International Airport	Phnom Penh (Pou Senchey)	Cambodia
RBE	Ratanakiri Airport	Ratanakiri	Cambodia
SAI	Siem Reap-Angkor International Airport	Siem Reap	Cambodia
TNX	Stung Treng Airport	Stung Treng	Cambodia
KOS	Sihanoukville International Airport	Preah Sihanouk	Cambodia
KZD	Krakor Airport	Krakor	Cambodia
LGY	Lagunillas Airport	Lagunillas	Venezuela
KTV	Kamarata Airport	Kamarata	Venezuela
SFX	Macagua Airport	Ciudad Guayana	Venezuela
SVV	San Salvador de Paul Airport	San Salvador de Paul	Venezuela
WOK	Wonken Airport	Wonken	Venezuela
ELX	El Tigre Airport	El Tigre	Venezuela
DBR	Darbhanga Airport	Darbhanga	India
AZH	Azamgarh Airport	Azamgarh	India
IXV	Along Airport		India
IXA	Agartala - Maharaja Bir Bikram Airport	Agartala	India
IXB	Bagdogra Airport	Siliguri	India
RGH	Balurghat Airport	Balurghat	India
SHL	Shillong Airport	Shillong	India
BBI	Biju Patnaik Airport	Bhubaneswar	India
CCU	Netaji Subhash Chandra Bose International Airport	Kolkata	India
COH	Cooch Behar Airport	Cooch Behar	India
CWK	Chitrakoot Airport	Chitrakoot	India
DBD	Dhanbad Airport		India
RDP	Kazi Nazrul Islam Airport	Durgapur	India
DEP	Daporijo Airport	Daporijo	India
GOP	Gorakhpur Airport	Gorakhpur	India
GAU	Lokpriya Gopinath Bordoloi International Airport	Guwahati	India
GAY	Gaya Airport	Gaya	India
IMF	Imphal Airport	Imphal	India
JRG	Jharsuguda Airport		India
PYB	Jeypore Airport	Jeypore	India
IXW	Sonari Airport	Jamshedpur	India
JRH	Jorhat Airport	Jorhat	India
KBK	Kushinagar International Airport	Kushinagar	India
IXQ	Kamalpur Airport	Manik Bhandar	India
IXH	Kailashahar Airport	Kailashahar	India
IXS	Silchar Airport	Silchar	India
IXN	Khowai Airport	Khowai	India
AJL	Lengpui Airport	Aizawl (Lengpui)	India
IXI	Lilabari North Lakhimpur Airport	Lilabari	India
LDA	Malda Airport	Malda	India
DIB	Dibrugarh Airport	Dibrugarh	India
DMU	Dimapur Airport	Dimapur	India
MZU	Muzaffarpur Airport	Muzaffarpur	India
IXT	Pasighat Airport	Pasighat	India
PAT	Jay Prakash Narayan Airport	Patna	India
IXR	Birsa Munda Airport	Ranchi	India
RRK	Rourkela Airport	Rourkela	India
RUP	Rupsi Airport	Rupsi	India
TEZ	Tezpur Airport		India
VTZ	Visakhapatnam Airport	Visakhapatnam	India
ZER	Ziro Airport	Ziro	India
RAD	Road Town Seaplane Base	Tortola	British Virgin Islands
BZL	Barisal Airport	Barisal	Bangladesh
CXB	Cox's Bazar Airport	Cox's Bazar	Bangladesh
CLA	Comilla Airport	Comilla	Bangladesh
CGP	Shah Amanat International Airport	Chattogram (Chittagong)	Bangladesh
IRD	Ishurdi Airport	Ishurdi	Bangladesh
JSR	Jessore Airport	Jashore (Jessore)	Bangladesh
RJH	Shah Mokhdum Airport	Rajshahi	Bangladesh
SPD	Saidpur Airport	Saidpur	Bangladesh
TKR	Thakurgaon Airport	Thakurgaon	Bangladesh
ZHM	Shamshernagar Airport	Shamshernagar	Bangladesh
ZYL	Osmany International Airport	Sylhet	Bangladesh
DAC	Hazrat Shahjalal International Airport	Dhaka	Bangladesh
HKG	Hong Kong International Airport	Hong Kong	Hong Kong SAR China
HHP	Shun Tak Heliport	Central and Western	Hong Kong SAR China
SPB	Charlotte Amalie Harbor Seaplane Base	Charlotte Amalie St Thomas	U.S. Virgin Islands
SSB	Christiansted Harbor Seaplane Base	Christiansted St Croix	U.S. Virgin Islands
AGR	Agra Airport / Agra Air Force Station	Agra	India
HRH	Aligarh Airport	Aligarh	India
IXD	Prayagraj Airport	Allahabad	India
ATQ	Sri Guru Ram Dass Jee International Airport	Amritsar	India
AIP	Adampur Airport	Adampur	India
BKB	Nal Airport	Bikaner	India
VNS	Lal Bahadur Shastri Airport	Varanasi	India
KUU	Kullu Manali Airport	Bhuntar	India
BUP	Bhatinda Air Force Station		India
BEK	Bareilly Air Force Station	Bareilly	India
IXC	Chandigarh International Airport	Chandigarh	India
KNU	Kanpur Airport	Kanpur	India
DED	Dehradun Jolly Grant Airport	Dehradun (Jauligrant)	India
DEL	Indira Gandhi International Airport	New Delhi	India
HDO	Hindon Airport / Hindon Air Force Station	Ghaziabad	India
DHM	Kangra Airport	Kangra	India
GWL	Gwalior Airport	Gwalior	India
HSS	Hisar Airport	Hisar	India
JDH	Jodhpur Airport	Jodhpur	India
JAI	Jaipur International Airport	Jaipur	India
JSA	Jaisalmer Airport		India
IXJ	Jammu Airport	Jammu	India
KQH	Kishangarh Airport Ajmer	Ajmer (Kishangarh)	India
KTU	Kota Airport	Kota	India
LUH	Ludhiana Airport		India
IXL	Leh Kushok Bakula Rimpochee Airport	Leh	India
LKO	Chaudhary Charan Singh International Airport	Lucknow	India
MZS	Moradabad Airport	Moradabad	India
IXP	Pathankot Airport	Pathankot	India
PGH	Pantnagar Airport	Pantnagar	India
SLV	Shimla Airport	Jubbarhatti	India
SWN	Sarsawa Air Force Station	Sherpur Naqeebpur	India
SXR	Sheikh ul Alam International Airport	Srinagar	India
TNI	Satna Airport		India
VSV	Shravasti Airport	Shravasti	India
VIV	Vivigani Airfield	Vivigani	Papua New Guinea
VJQ	Gurue Airport	Gurue	Mozambique
AOU	Attopeu Airport	Attopeu	Laos
HOE	Ban Huoeisay Airport	Huay Xai	Laos
LPQ	Luang Phabang International Airport	Luang Phabang	Laos
LXG	Luang Namtha Airport	Luang Namtha	Laos
ODY	Oudomsay Airport	Oudomsay	Laos
PKZ	Pakse International Airport	Pakse	Laos
ZBY	Sayaboury Airport	Sainyabuli	Laos
ZVK	Savannakhet Airport		Laos
NEU	Sam Neua Airport		Laos
VNA	Saravane Airport	Saravane	Laos
THK	Thakhek Airport	Thakhek	Laos
VTE	Wattay International Airport	Vientiane	Laos
XKH	Xieng Khouang Airport	Xieng Khouang	Laos
XIE	Xienglom Airport	Xienglom	Laos
VMI	Aeropuerto Nacional Dr. Juan Plate	Puerto Vallemi	Paraguay
MFM	Macau International Airport	Nossa Senhora do Carmo	Macao SAR China
VDH	Dong Hoi Airport	Dong Hoi	Vietnam
PHU	Phu Giao Airport	Phu Giao	Vietnam
BJH	Bajhang Airport	Bajhang	Nepal
BHP	Bhojpur Airport	Bhojpur	Nepal
BGL	Baglung Airport	Baglung	Nepal
BHR	Bharatpur Airport	Bharatpur	Nepal
BJU	Bajura Airport	Bajura	Nepal
BIT	Baitadi Airport	Baitadi	Nepal
BWA	Gautam Buddha International Airport	Siddharthanagar (Bhairahawa)	Nepal
BDP	Bhadrapur Airport	Bhadrapur	Nepal
DNP	Tulsipur Airport	Dang	Nepal
DHI	Dhangarhi Airport	Dhangarhi	Nepal
DAP	Darchula Airport	Darchula	Nepal
DOP	Dolpa Airport	Dolpa	Nepal
SIH	Silgadi Doti Airport	Silgadi Doti	Nepal
GKH	Palungtar Airport	Gorkha	Nepal
JIR	Jiri Airport	Jiri	Nepal
JUM	Jumla Airport	Jumla	Nepal
JKR	Janakpur Airport	Janakpur	Nepal
JMO	Jomsom Airport	Jomsom	Nepal
KTM	Tribhuvan International Airport	Kathmandu	Nepal
LDN	Lamidanda Airport	Lamidanda	Nepal
LUA	Lukla Airport	Lukla	Nepal
LTG	Langtang Airport	Langtang	Nepal
NGX	Manang Airport	Ngawal	Nepal
MEY	Meghauli Airport	Meghauli	Nepal
XMG	Mahendranagar Airport	Mahendranagar	Nepal
KEP	Nepalgunj Airport	Nepalgunj	Nepal
PPL	Phaplu Airport	Phaplu	Nepal
RJB	Rajbiraj Airport	Rajbiraj	Nepal
RHP	Ramechhap Airport	Ramechhap	Nepal
RUK	Rukum Chaurjahari Airport	Rukumkot	Nepal
RPA	Rolpa Airport	Rolpa	Nepal
RUM	Rumjatar Airport	Rumjatar	Nepal
SYH	Syangboche Airport	Namche Bazaar	Nepal
SIF	Simara Airport	Simara	Nepal
SKH	Surkhet Airport	Surkhet	Nepal
FEB	Sanfebagar Airport	Sanfebagar	Nepal
IMK	Simikot Airport	Simikot	Nepal
TPJ	Taplejung Airport	Taplejung	Nepal
TPU	Tikapur Airport	Tikapur	Nepal
TMI	Tumling Tar Airport	Tumling Tar	Nepal
BIR	Biratnagar Airport	Biratnagar	Nepal
LTU	Murod Kond Airport	Latur	India
TCR	Tuticorin Airport	Vagaikulam	India
AGX	Agatti Airport	Agatti	India
BEP	Bellary Airport	Bellary	India
BLR	Kempegowda International Airport	Bangalore	India
IXX	Bidar Airport / Bidar Air Force Station	Bidar	India
VGA	Vijayawada Airport	Gannavaram	India
CJB	Coimbatore International Airport	Coimbatore	India
COK	Cochin International Airport	Kochi	India
CCJ	Calicut International Airport	Calicut	India
CDP	Kadapa Airport	Kadapa	India
CBD	Car Nicobar Air Force Base	IAF Camp	India
GBI	Kalaburagi Airport	Kalaburagi	India
HYD	Rajiv Gandhi International Airport	Hyderabad	India
BPM	Begumpet Airport	Hyderabad	India
CNN	Kannur International Airport	Kannur	India
KJB	Kurnool Airport	Orvakal	India
IXM	Madurai Airport	Madurai	India
IXE	Mangalore International Airport	Mangalore	India
MAA	Chennai International Airport	Chennai	India
MYQ	Mysore Airport	Mysore	India
IXZ	Veer Savarkar International Airport / INS Utkrosh	Port Blair	India
PNY	Pondicherry Airport	Puducherry (Pondicherry)	India
PUT	Sri Sathya Sai Airport	Puttaparthi	India
RMD	Basanth Nagar Airport	Ramagundam	India
RJA	Rajahmundry Airport	Madhurapudi	India
SXV	Salem Airport	Salem	India
SDW	Sindhudurg Airport	Sindhudurg	India
TJV	Thanjavur Air Force Station	Thanjavur	India
TIR	Tirupati Airport	Tirupati	India
TRZ	Tiruchirappalli International Airport	Tiruchirappalli	India
TRV	Thiruvananthapuram International Airport	Thiruvananthapuram	India
WGC	Warangal Airport	Warangal	India
YON	Yongphulla Airport	Yongphulla	Bhutan
BUT	Bathpalathang Airport	Jakar	Bhutan
GLU	Gelephu Airport	Gelephu	Bhutan
PBH	Paro International Airport	Paro	Bhutan
HRF	Hoarafushi Airport		Maldives
HDK	Kulhudhuffushi Airport	Kulhudhuffushi	Maldives
NMF	Maafaru International Airport	Noonu Atoll	Maldives
IFU	Ifuru Airport	Ifuru Island	Maldives
DRV	Dharavandhoo Airport	Baa Atoll	Maldives
FVM	Fuvahmulah Airport	Fuvahmulah Island	Maldives
GAN	Gan International Airport	Gan	Maldives
HAQ	Hanimaadhoo Airport	Haa Dhaalu Atoll	Maldives
KDO	Kadhdhoo Airport	Kadhdhoo	Maldives
MLE	Malé International Airport	Malé	Maldives
GKK	Kooddoo Airport	Huvadhu Atoll	Maldives
KDM	Kaadedhdhoo Airport	Huvadhu Atoll	Maldives
DDD	Dhaalu Atoll Airport	Kudahuvadhoo	Maldives
VAM	Villa International Airport Maamigili	Maamigili	Maldives
TMF	Thimarafushi Airport	Thimarafushi	Maldives
RUL	Maavaarulaa Airport	Maavaarulu	Maldives
DMK	Don Mueang International Airport	Bangkok	Thailand
KKM	Sa Pran Nak Airport		Thailand
KDT	Kamphaeng Saen Airport	Nakhon Pathom	Thailand
TDX	Trat Airport	Laem Ngop	Thailand
BKK	Suvarnabhumi Airport	Bangkok	Thailand
UTP	U-Tapao International Airport	Rayong	Thailand
CNX	Chiang Mai International Airport	Chiang Mai	Thailand
HGN	Mae Hong Son Airport	Mae Hong Son	Thailand
PYY	Pai Airport	Pai	Thailand
LPT	Lampang Airport		Thailand
NNT	Nan Airport		Thailand
PRH	Phrae Airport		Thailand
CEI	Mae Fah Luang - Chiang Rai International Airport	Chiang Rai	Thailand
BAO	Udorn Air Base	Ban Mak Khaen	Thailand
PHY	Phetchabun Airport		Thailand
HHQ	Hua Hin Airport	Hua Hin	Thailand
TKH	Takhli Airport		Thailand
MAQ	Mae Sot Airport		Thailand
THS	Sukhothai Airport		Thailand
PHS	Phitsanulok Airport	Phitsanulok	Thailand
TKT	Tak Airport		Thailand
UTR	Uttaradit Airport	Uttaradit	Thailand
URT	Surat Thani Airport	Surat Thani	Thailand
NAW	Narathiwat Airport		Thailand
CJM	Chumphon Airport	Chumphon	Thailand
NST	Nakhon Si Thammarat Airport	Nakhon Si Thammarat	Thailand
KBV	Krabi Airport	Krabi	Thailand
SGZ	Songkhla Airport		Thailand
PAN	Pattani Airport		Thailand
USM	Samui Airport	Na Thon (Ko Samui Island)	Thailand
HKT	Phuket International Airport	Phuket	Thailand
UNN	Ranong Airport	Ranong	Thailand
HDY	Hat Yai International Airport	Hat Yai	Thailand
TST	Trang Airport	Trang	Thailand
UTH	Udon Thani Airport	Udon Thani	Thailand
SNO	Sakon Nakhon Airport		Thailand
PXR	Surin Airport	Surin	Thailand
KKC	Khon Kaen Airport	Khon Kaen	Thailand
LOE	Loei Airport		Thailand
BFV	Buri Ram Airport	Buriram	Thailand
NAK	Nakhon Ratchasima Airport	Chaloem Phra Kiat	Thailand
UBP	Ubon Ratchathani Airport	Ubon Ratchathani	Thailand
ROI	Roi Et Airport	Roi Et	Thailand
KOP	Nakhon Phanom Airport	Nakhon Phanom	Thailand
VUU	Mvuu Camp Airport	Liwonde National Park	Malawi
BMV	Buon Ma Thuot Airport	Buon Ma Thuot	Vietnam
VCL	Chu Lai Airport	Tam Nghĩa	Vietnam
HPH	Cat Bi International Airport	Haiphong (Hai An)	Vietnam
CAH	Cà Mau Airport	Ca Mau City	Vietnam
CXR	Cam Ranh International Airport / Cam Ranh Air Base	Cam Ranh	Vietnam
VCS	Con Dao Airport	Con Dao	Vietnam
VCA	Can Tho International Airport	Can Tho	Vietnam
DIN	Dien Bien Phu Airport	Dien Bien Phu	Vietnam
DLI	Lien Khuong Airport	Da Lat	Vietnam
DAD	Da Nang International Airport	Da Nang	Vietnam
VVN	Las Malvinas/Echarate Airport	Las Malvinas	Peru
HAN	Noi Bai International Airport	Hanoi	Vietnam
SQH	Na San Airport	Mai Son	Vietnam
HUI	Phu Bai International Airport	Huế	Vietnam
UIH	Phu Cat Airport	Quy Nohn	Vietnam
PXU	Pleiku Airport	Pleiku	Vietnam
PQC	Phu Quoc International Airport	Phu Quoc Island	Vietnam
PHA	Phan Rang Airport	Phan Rang	Vietnam
VKG	Rach Gia Airport	Rach Gia	Vietnam
TBB	Dong Tac Airport	Tuy Hoa	Vietnam
SGN	Tan Son Nhat International Airport	Ho Chi Minh City	Vietnam
THD	Tho Xuan Airport	Thanh Hóa	Vietnam
VDO	Van Don International Airport	Van Don	Vietnam
VII	Vinh Airport	Vinh	Vietnam
VTG	Vung Tau Airport	Vũng Tàu	Vietnam
VBA	Ann Airport	Aeng	Myanmar (Burma)
NYU	Bagan Airport	Nyaung U	Myanmar (Burma)
BMO	Banmaw Airport	Banmaw	Myanmar (Burma)
VBP	Bokpyinn Airport	Bokpyinn	Myanmar (Burma)
VBC	Chanmyathazi Airport	Mandalay	Myanmar (Burma)
TVY	Dawei Airport	Dawei	Myanmar (Burma)
NYT	Nay Pyi Taw International Airport	Pyinmana	Myanmar (Burma)
SRU	Surbung Airport	Falam	Myanmar (Burma)
GAW	Gangaw Airport	Gangaw	Myanmar (Burma)
GWA	Gwa Airport	Gwa	Myanmar (Burma)
HOX	Hommalinn Airport	Hommalinn	Myanmar (Burma)
TIO	Tilin Airport	Tilin	Myanmar (Burma)
KET	Kengtung Airport	Kengtung	Myanmar (Burma)
KHM	Kanti Airport	Kanti	Myanmar (Burma)
KMV	Kalay Airport	Kalemyo	Myanmar (Burma)
KYP	Kyaukpyu Airport	Kyaukpyu	Myanmar (Burma)
KAW	Kawthoung Airport	Kawthoung	Myanmar (Burma)
KYT	Kyauktu Airport	Kyauktu	Myanmar (Burma)
LIW	Loikaw Airport	Loikaw	Myanmar (Burma)
LSH	Lashio Airport	Lashio	Myanmar (Burma)
MDL	Mandalay International Airport	Mandalay	Myanmar (Burma)
MGZ	Myeik Airport	Mkeik	Myanmar (Burma)
MYT	Myitkyina Airport	Myitkyina	Myanmar (Burma)
MNU	Mawlamyine Airport	Mawlamyine	Myanmar (Burma)
MGU	Manaung Airport	Manaung	Myanmar (Burma)
MOE	Momeik Airport		Myanmar (Burma)
MOG	Mong Hsat Airport	Mong Hsat	Myanmar (Burma)
MGK	Mong Tong Airport	Mong Tong	Myanmar (Burma)
MWQ	Magway Airport	Magway	Myanmar (Burma)
NYW	Monywar Airport	Monywar	Myanmar (Burma)
NMS	Namsang Airport	Namsang	Myanmar (Burma)
NMT	Namtu Airport	Namtu	Myanmar (Burma)
PAA	Hpa-N Airport	Hpa-N	Myanmar (Burma)
PAU	Pauk Airport	Pauk	Myanmar (Burma)
BSX	Pathein Airport	Pathein	Myanmar (Burma)
PPU	Hpapun Airport	Pa Pun	Myanmar (Burma)
PBU	Putao Airport	Putao	Myanmar (Burma)
PKK	Pakhokku Airport	Pakhokku	Myanmar (Burma)
PRU	Pyay Airport	Pye	Myanmar (Burma)
AKY	Sittwe Airport	Sittwe	Myanmar (Burma)
SNW	Thandwe Airport	Thandwe	Myanmar (Burma)
THL	Tachileik Airport	Tachileik	Myanmar (Burma)
XYE	Ye Airport	Ye	Myanmar (Burma)
RGN	Yangon International Airport	Yangon	Myanmar (Burma)
ARM	Armidale Airport	Armidale	Australia
FBS	Friday Harbor Seaplane Base	Friday Harbor	United States
RSJ	Rosario Seaplane Base	Rosario	United States
LKE	Kenmore Air Harbor Seaplane Base	Seattle	United States
RCE	Roche Harbor Airport	Roche Harbor	United States
TQQ	Maranggo Airport	Waha-Tomea Island	Indonesia
WSX	Westsound/WSX Seaplane Base	West Sound	United States
UPG	Hasanuddin International Airport	Ujung Pandang	Indonesia
BIK	Frans Kaisiepo Airport	Biak	Indonesia
ONI	Moanamani Airport	Moanamani	Indonesia
FOO	Kornasoren Airport	Kornasoren	Indonesia
WET	Deiyai / Waghete Baru Airport	Wagethe	Indonesia
ILA	Ilaga Airport	Ilaga	Indonesia
KOX	Kokonao Airport	Kokonao	Indonesia
TIM	Mozes Kilangin Airport	Timika	Indonesia
EWI	Enarotali Airport	Enarotali	Indonesia
WAD	Andriamena Airport	Andriamena	Madagascar
AMI	Selaparang Airport	Mataram	Indonesia
BMU	Sultan Muhammad Salahuddin Airport	Bima	Indonesia
DPS	Ngurah Rai (Bali) International Airport	Denpasar	Indonesia
LOP	Lombok International Airport	Mataram	Indonesia
SWQ	Sumbawa Besar Airport	Sumbawa Island	Indonesia
TMC	Tambolaka Airport	Radamata	Indonesia
WGP	Umbu Mehang Kunda Airport	Waingapu-Sumba Island	Indonesia
OTI	Pitu Airport	Gotalalamo-Morotai Island	Indonesia
TRT	Toraja Airport	Toraja	Indonesia
LLO	Bua - Palopo Lagaligo Airport	Palopo	Indonesia
PLW	Mutiara - SIS Al-Jufrie Airport	Palu	Indonesia
MJU	Tampa Padang Airport	Mamuju	Indonesia
MXB	Andi Jemma Airport	Masamba	Indonesia
PSJ	Kasiguncu Airport	Poso-Celebes Island	Indonesia
OJU	Tanjung Api Airport	Tojo Una-Una	Indonesia
LUW	Syukuran Aminuddin Amir Airport	Luwok	Indonesia
HMS	Haji Muhammad Sidik Airport	Muara Teweh	Indonesia
KLP	Seruyan Kuala Pembuang Airport	Seruyan	Indonesia
PKY	Tjilik Riwut Airport	Palangkaraya	Indonesia
YIA	Yogyakarta International Airport	Yogyakarta	Indonesia
CXP	Tunggul Wulung Airport	Cilacap	Indonesia
KWB	Dewadaru Airport	Karimunjawa	Indonesia
BUI	Bokondini Airport	Bokondini	Indonesia
ZRM	Mararena Sarmi Airport	Sarmi	Indonesia
DJJ	Dortheys Hiyo Eluay International Airport	Sentani	Indonesia
LHI	Lereh Airport	Lereh-Papua Island	Indonesia
LII	Mulia Airport	Mulia-Papua Island	Indonesia
OKL	Oksibil Airport	Oksibil	Indonesia
SEH	Senggeh Airport	Senggeh	Indonesia
MDP	Mindiptana Airport	Mindiptana-Papua Island	Indonesia
BXD	Bade Airport	Bade	Indonesia
MKQ	Mopah International Airport	Merauke	Indonesia
OKQ	Okaba Airport	Okaba	Indonesia
KEI	Kepi Airport	Kepi	Indonesia
TMH	Tanah Merah Airport	Tanah Merah	Indonesia
GHS	Melalan Airport	Melak-Borneo Island	Indonesia
TJS	Tanjung Harapan Airport	Tanjung Selor-Borneo Island	Indonesia
DTD	Datadawai Airport	Datadawai-Borneo Island	Indonesia
BEJ	Kalimarau Airport	Tanjung Redeb - Borneo Island	Indonesia
BPN	Sultan Aji Muhammad Sulaiman Sepinggan International Airport	Balikpapan	Indonesia
TRK	Juwata International Airport / Suharnoko Harbani AFB	Tarakan	Indonesia
AAP	Aji Pangeran Tumenggung Pranoto International Airport	Samarinda	Indonesia
TSX	Tanjung Santan Airport	Santan-Borneo Island	Indonesia
BYQ	Bunyu Airport	Bunju Island	Indonesia
GLX	Gamarmalamo Airport	Galela-Celebes Island	Indonesia
BJG	Kota Mobagu/Mopait Airport	Kota Mobagu	Indonesia
PGQ	Buli Airport	Pekaulang	Indonesia
GTO	Jalaluddin Airport	Gorontalo-Celebes Island	Indonesia
NAH	Naha Airport	Tahuna-Sangihe Island	Indonesia
TLI	Sultan Bantilan Airport	Toli Toli-Celebes Island	Indonesia
GEB	Gebe Airport	Gebe Island	Indonesia
KAZ	Kuabang Airport	Kao-Celebes Island	Indonesia
MDC	Sam Ratulangi Airport	Manado	Indonesia
MNA	Melangguane Airport	Karakelong Island	Indonesia
BRG	Siau/Sitaro Airport	Balirangen	Indonesia
MWS	Indonesia Morowali Industrial Park (IMIP) Airport	Morowali	Indonesia
TTE	Sultan Babullah Airport	Sango	Indonesia
UOL	Buol - Pogogul Airport	Buol-Celebes Island	Indonesia
WAN	Waverney Airport	Waverney	Australia
BTW	Batu Licin Airport	Batu Licin	Indonesia
PKN	Iskandar Airport	Pangkalanbun	Indonesia
KBU	Gusti Syamsir Alam Airport	Stagen	Indonesia
TJG	Warukin Airport	Tanta-Tabalong	Indonesia
BDJ	Syamsudin Noor International Airport	Landasan Ulin	Indonesia
SMQ	Sampit (Hasan) Airport	Sampit	Indonesia
AHI	Amahai Airport	Amahai	Indonesia
NDA	Bandanaira Airport	Bandanaira	Indonesia
DOB	Rar Gwamar Airport	Dobo-Warmar Island	Indonesia
MAL	Mangole Airport, Falabisahaya	Mangole Island	Indonesia
LUV	Karel Sadsuitubun Airport	Langgur	Indonesia
NRE	Namrole Airport	Namrole	Indonesia
LAH	Oesman Sadik Airport	Labuha-Halmahera Island	Indonesia
BJK	Benjina Airport	Maikoor Island	Indonesia
SQN	Emalamo Sanana Airport	Sanana	Indonesia
AMQ	Pattimura International Airport	Ambon	Indonesia
TAX	Taliabu Island Airport	Tikong-Taliabu Island	Indonesia
WBA	Wahai Airport	Wahai	Indonesia
RTU	Berau/Maratua Airport		Indonesia
LNU	Robert Atty Bessing	Malinau	Indonesia
MLG	Abdul Rachman Saleh Airport	Malang	Indonesia
CPF	Ngloram Airport	Tjepu-Java Island	Indonesia
JOG	Adisutjipto International Airport	Yogyakarta	Indonesia
SOC	Adisumarmo International Airport	Surakarta	Indonesia
SUB	Juanda International Airport	Surabaya	Indonesia
SRG	Achmad Yani Airport	Semarang	Indonesia
SUP	Trunojoyo Airport	Sumenep-Madura Island	Indonesia
NTI	Stenkol Airport	Bintuni	Indonesia
RSK	Abresso Airport	Ransiki-Papua Island	Indonesia
KEQ	Kebar Airport	Kebar	Indonesia
FKQ	Fakfak Airport	Fakfak	Indonesia
INX	Inanwatan Airport	Inanwatan	Indonesia
KNG	Kaimana Airport	Kaimana	Indonesia
RDE	Merdey Airport	Merdei-Papua Island	Indonesia
RJM	Marinda Airport	Waisai	Indonesia
BXB	Babo Airport	Babo	Indonesia
MKW	Rendani Airport	Manokwari	Indonesia
TXM	Teminabuan Airport	Atinjoe	Indonesia
WSR	Wasior Airport	Wasior-Papua Island	Indonesia
BJW	Bajawa Soa Airport	Soa	Indonesia
MOF	Frans Xavier Seda Airport	Waioti	Indonesia
ENE	H. Hasan Aroeboesman (Ende) Airport	Ende	Indonesia
RTG	Frans Sales Lega Airport	Satar Tacik	Indonesia
ARD	Alor Island - Mali Airport	Kabola	Indonesia
LBJ	Komodo Airport	Labuan Bajo	Indonesia
RTI	David Constantijn Saudale Airport	Ba'a - Rote Island	Indonesia
SAU	Sabu-Tardanu Airport	Sabu-Sawu Island	Indonesia
KOE	El Tari Airport	Kupang	Indonesia
WMX	Wamena Airport	Wamena	Indonesia
BUW	Betoambari Airport	Bau Bau	Indonesia
WNI	Matahora Airport	Wangi-wangi Island	Indonesia
KSR	Selayar - Haji Aroeppala Airport	Benteng	Indonesia
APD	Arung Palakka Airport	Bone	Indonesia
SQR	Soroako Airport	Soroako	Indonesia
TTR	Pongtiku Airport	Makale	Indonesia
KDI	Haluoleo Airport	Kendari	Indonesia
SOQ	Domine Eduard Osok Airport	Sorong	Indonesia
WBB	Stebbins Airport	Stebbins	United States
WBC	Wapolu Airport	Wapolu	Papua New Guinea
BTU	Bintulu Airport	Bintulu	Malaysia
BLG	Belaga Airport	Belaga	Malaysia
LSM	Long Semado Airport	Long Semado	Malaysia
LGL	Long Lellang Airport	Long Datih	Malaysia
KCH	Kuching International Airport	Kuching	Malaysia
ODN	Long Seridan Airport	Long Seridan	Malaysia
LMN	Limbang Airport	Limbang	Malaysia
MKM	Mukah Airport	Mukah	Malaysia
LKH	Long Akah Airport	Long Akah	Malaysia
MUR	Marudi Airport	Marudi	Malaysia
BSE	Sematan Airport	Sematan	Malaysia
KPI	Kapit Airport	Kapit	Malaysia
BKM	Bakalalan Airport	Bakalalan	Malaysia
MYY	Miri Airport	Miri	Malaysia
SBW	Sibu Airport	Sibu	Malaysia
TGC	Tanjung Manis Airport	Belawai	Malaysia
LSU	Long Sukang Airport	Long Sukang	Malaysia
LWY	Lawas Airport	Lawas	Malaysia
BBN	Bario Airport	Bario	Malaysia
SMM	Semporna Airport	Semporna	Malaysia
LDU	Lahad Datu Airport	Lahad Datu	Malaysia
TEL	Telupid Airport	Telupid	Malaysia
KGU	Keningau Airport	Keningau	Malaysia
SXS	Sahabat [Sahabat 16] Airport	Sahabat	Malaysia
BKI	Kota Kinabalu International Airport	Kota Kinabalu	Malaysia
LBU	Labuan Airport	Labuan	Malaysia
TMG	Tomanggong Airport	Tomanggong	Malaysia
GSA	Long Pasia Airport	Long Miau	Malaysia
SPE	Sepulot Airport	Sepulot	Malaysia
PAY	Pamol Airport	Pamol	Malaysia
RNU	Ranau Airport	Ranau	Malaysia
SDK	Sandakan Airport	Sandakan	Malaysia
KUD	Kudat Airport	Kudat	Malaysia
TWU	Tawau Airport	Tawau	Malaysia
MZV	Mulu Airport	Mulu	Malaysia
BWN	Brunei International Airport	Bandar Seri Begawan	Brunei
WDA	Al Ain Airport Ain District, Shabwah Governorate, Yemen	Ain District	Yemen
WEA	Parker County Airport	Weatherford	United States
WED	Wedau Airport	Wedau	Papua New Guinea
WHL	Welshpool Airport	Welshpool	Australia
CJN	Nusawiru Airport	Cijulang	Indonesia
PKU	Sultan Syarif Kasim II International Airport / Roesmin Nurjadin AFB	Pekanbaru	Indonesia
DUM	Pinang Kampai Airport	Dumai	Indonesia
RGT	Japura Airport	Rengat-Sumatra Island	Indonesia
SEQ	Sungai Pakning Bengkalis Airport	Bengkalis-Sumatra Island	Indonesia
TJB	Raja Haji Abdullah Airport	Tanjung Balai-Karinmunbesar Island	Indonesia
KJT	Kertajati International Airport	Kertajati	Indonesia
RTO	Budiarto Airport	Tangerang-Java Island	Indonesia
BDO	Husein Sastranegara International Airport	Bandung	Indonesia
CBN	Penggung Airport	Cirebon-Java Island	Indonesia
TSY	Cibeureum Airport	Tasikmalaya-Java Island	Indonesia
TBX	Tambelan Airport	Tambelan	Indonesia
BTH	Hang Nadim International Airport	Batam	Indonesia
PPR	Tuanku Tambusai Airport	Pasir Pengarayan	Indonesia
LMU	Letung Airport	Bukit Padi	Indonesia
MWK	Matak Airport	Palmatak	Indonesia
TNJ	Raja Haji Fisabilillah International Airport	Tanjung Pinang-Bintan Island	Indonesia
SIQ	Dabo Airport	Pasirkuning-Singkep Island	Indonesia
MPC	Muko Muko Airport	Muko Muko	Indonesia
HLP	Halim Perdanakusuma International Airport	Jakarta	Indonesia
PCB	Pondok Cabe Air Base	Jakarta	Indonesia
CGK	Soekarno-Hatta International Airport	Jakarta	Indonesia
TKG	Radin Inten II International Airport	Bandar Lampung	Indonesia
TFY	Muhammad Taufiq Kiemas Airport	Krui	Indonesia
GNS	Binaka Airport	Gunungsitoli	Indonesia
AEG	Aek Godang Airport	Padang Sidempuan	Indonesia
JHN	Jenderal Besar Abdul Haris Nasution Airport		Indonesia
MES	Soewondo Air Force Base	Medan	Indonesia
KNO	Kualanamu International Airport	Medan	Indonesia
DTB	Silangit Airport	Siborong-Borong	Indonesia
SIW	Sibisa Airport	Parapat-Sumatra Island	Indonesia
FLZ	Dr. Ferdinand Lumban Tobing Airport	Sibolga (Pinangsori)	Indonesia
LSR	Alas Leuser Airport	Kutacane	Indonesia
TJQ	H A S Hanandjoeddin International Airport	Tanjung Pandan	Indonesia
NPO	Nanga Pinoh Airport	Nanga Pinoh-Borneo Island	Indonesia
KTG	Rahadi Osman Airport	Ketapang	Indonesia
NTX	Ranai Airport	Ranai-Natuna Besar Island	Indonesia
PNK	Supadio Airport	Pontianak	Indonesia
PSU	Pangsuma Airport	Putussibau-Borneo Island	Indonesia
DJB	Sultan Thaha Airport	Jambi	Indonesia
LLJ	Silampari Airport	Lubuk Linggau	Indonesia
BUU	Muara Bungo Airport	Muara Bungo	Indonesia
PGK	Depati Amir Airport	Pangkal Pinang	Indonesia
BKS	Fatmawati Soekarno Airport	Bengkulu	Indonesia
PLM	Sultan Mahmud Badaruddin II Airport	Palembang	Indonesia
PDO	Pendopo Airport	Talang Gudang-Sumatra Island	Indonesia
PDG	Minangkabau International Airport	Padang (Katapiang)	Indonesia
PXA	Bentayan Airport	Bentayan-Sumatra Island	Indonesia
TPK	Teuku Cut Ali Airport	Tapaktuan	Indonesia
SBG	Maimun Saleh Airport	Sabang	Indonesia
MEQ	Cut Nyak Dhien Airport	Kuala Pesisir	Indonesia
LKI	Lasikin Airport	Lubang	Indonesia
TXE	Rembele Airport	Takengon	Indonesia
LSX	Lhok Sukon Airport	Lhok Sukon-Sumatra Island	Indonesia
LSW	Malikus Saleh Airport	Lhok Seumawe-Sumatra Island	Indonesia
BTJ	Sultan Iskandar Muda International Airport	Banda Aceh	Indonesia
SXT	Sungai Tiang Airport	Taman Negara	Malaysia
MEP	Mersing Airport	Mersing	Malaysia
SWY	Sitiawan Airport	Sitiawan	Malaysia
TPG	Taiping (Tekah) Airport	Taiping	Malaysia
TOD	Tioman Airport	Tioman Island	Malaysia
AOR	Sultan Abdul Halim Airport	Alor Satar	Malaysia
BWH	RMAF Butterworth Air Base	Butterworth	Malaysia
KBR	Sultan Ismail Petra Airport	Kota Baharu	Malaysia
KUA	Kuantan Airport	Kuantan	Malaysia
KTE	Kerteh Airport	Kerteh	Malaysia
IPH	Sultan Azlan Shah Airport	Ipoh	Malaysia
JHB	Senai International Airport	Johor Bahru	Malaysia
KUL	Kuala Lumpur International Airport	Sepang	Malaysia
LGK	Langkawi International Airport	Langkawi	Malaysia
MKZ	Malacca International Airport	Malacca	Malaysia
TGG	Sultan Mahmud Airport	Kuala Terengganu	Malaysia
PEN	Penang International Airport	Penang	Malaysia
PKG	Pulau Pangkor Airport	Pangkor Island	Malaysia
RDN	LTS Pulau Redang Airport	Redang	Malaysia
SZB	Sultan Abdul Aziz Shah International Airport	Subang	Malaysia
DTR	Decatur Shores Airport	Decatur	United States
WNU	Wanuma Airport	Wanuma	Papua New Guinea
SXK	Mathilda Batlayeri Airport	Saumlaki-Yamdena Island	Indonesia
AUT	Atauro Airport	Vila	Timor-Leste
UAI	Suai Airport	Suai	Timor-Leste
DIL	Presidente Nicolau Lobato International Airport	Dili	Timor-Leste
BCH	Cakung Airport	Baucau	Timor-Leste
MPT	Maliana Airport	Maliana	Timor-Leste
OEC	Rota Do Sândalo Oecusse Airport	Oecussi-Ambeno	Timor-Leste
VIQ	Viqueque Airport	Viqueque	Timor-Leste
ABU	AA Bere Tallo (Haliwen) Airport	Atambua	Indonesia
LKA	Larantuka Gewayentana Airport	Tiwatobi	Indonesia
SGQ	Sanggata/Sangkimah Airport	Sanggata/Sangkimah	Indonesia
LBW	Yuvai Semaring Airport	Long Bawan	Indonesia
BXT	Bontang Airport	Bontang-Borneo Island	Indonesia
NNX	Nunukan Airport	Nunukan-Nunukan Island	Indonesia
TNB	Tanah Grogot Airport	Tanah Grogot	Indonesia
LPU	Long Apung Airport	Long Apung-Borneo Island	Indonesia
WSA	Wasua Airport	Wasua	Papua New Guinea
QPG	Paya Lebar Air Base	Paya Lebar	Singapore
TGA	Tengah Air Base	Western Water Catchment	Singapore
WSB	Steamboat Bay Seaplane Base	Steamboat Bay	United States
UGI	San Juan /Uganik/ Seaplane Base	San Juan	United States
WSM	Wiseman Airport	Wiseman	United States
XSP	Seletar Airport	Seletar	Singapore
SIN	Singapore Changi Airport	Singapore	Singapore
WTT	Wantoat Airport	Wantoat	Papua New Guinea
WUV	Wuvulu Island Airport	Wuvulu Island	Papua New Guinea
WUZ	Wuzhou Xijiang Airport	Tangbu	China
GWV	Glendale Fokker Field	Glendale	United States
WZQ	Urad Middle Banner Airport	Urad Middle Banner	China
MPB	Miami Seaplane Base	Miami	United States
XBB	Blubber Bay Seaplane Base	Blubber Bay	Canada
XBN	Biniguni Airport	Biniguni	Papua New Guinea
SKL	Broadford Airstrip	Ashaig	United Kingdom
XIG	Xinguara Municipal Airport	Xinguara	Brazil
XMA	Maramag Airport	Maramag	Philippines
XRQ	New Barag Right Banner Baogede Airport	New Barag Right Banner	China
LNX	Smolensk North Airport	Smolensk	Russia
XZM	Macau Heliport at Outer Harbour Ferry Terminal	Sé	Macao SAR China
UKN	Waukon Municipal Airport	Waukon	United States
ALH	Albany Airport	Albany	Australia
ABG	Abingdon Downs Airport	Abingdon Downs	Australia
AWN	Alton Downs Airport		Australia
AUD	Augustus Downs Airport		Australia
YAJ	Lyall Harbour Seaplane Base	Saturna Island	Canada
MRP	Marla Airport	Marla	Australia
AXL	Alexandria Homestead Airport		Australia
AXC	Aramac Airport		Australia
ADO	Andamooka Airport		Australia
AMX	Ammaroo Airport		Australia
AMT	Amata Airport		Australia
WLP	West Angelas Airport		Australia
AYL	Anthony Lagoon Airport		Australia
YAQ	Maple Bay Seaplane Base	Maple Bay	Canada
ARY	Ararat Airport	Ararat	Australia
GYL	Argyle Airport		Australia
AAB	Arrabury Airport	Tanbar	Australia
AUU	Aurukun Airport	Aurukun	Australia
AWP	Austral Downs Airport		Australia
AVG	Auvergne Airport		Australia
AYQ	Ayers Rock Connellan Airport	Yulara	Australia
AYR	Ayr Airport	Ayr	Australia
MBN	Mount Barnett Airport	Wunaamin Miliwundi Ranges	Australia
BCI	Barcaldine Airport	Barcaldine	Australia
ASP	Alice Springs Airport	Alice Springs	Australia
BDD	Badu Island Airport	Badu Island	Australia
BKP	Barkly Downs Airport		Australia
BNE	Brisbane International Airport	Brisbane	Australia
OOL	Gold Coast Airport	Gold Coast	Australia
BKQ	Blackall Airport	Blackall	Australia
CNS	Cairns International Airport	Cairns	Australia
CTL	Charleville Airport	Charleville	Australia
BDW	Bedford Downs Airport		Australia
BXG	Bendigo Airport		Australia
BVI	Birdsville Airport		Australia
BXF	Bellburn Airstrip	Pumululu National Park	Australia
BTX	Betoota Airport		Australia
BEE	Beagle Bay Airport	Dampier Peninsula	Australia
OCM	Boolgeeda		Australia
BQW	Balgo Hill Airport	Balgo	Australia
YBH	Bull Harbour Water Aerodrome	Bull Harbour	Canada
BHQ	Broken Hill Airport	Broken Hill	Australia
HTI	Hamilton Island Airport	Hamilton Island	Australia
BEU	Bedourie Airport		Australia
BIW	Billiluna Airport		Australia
BZP	Bizant Airport	Lakefield National Park	Australia
YBJ	Baie-Johan-Beetz Water Aerodrome	Baie-Johan-Beetz	Canada
BRK	Bourke Airport		Australia
BUC	Burketown Airport		Australia
BLN	Benalla Airport		Australia
LCN	Balcanoona Airport		Australia
ZBL	Biloela Airport	Biloela	Australia
BLS	Bollon Airport		Australia
BQB	Busselton Margaret River Regional Airport	Busselton	Australia
ISA	Mount Isa Airport	Mount Isa	Australia
BFC	Bloomfield River Airport		Australia
MKY	Mackay Airport	Mackay	Australia
BNK	Ballina Byron Gateway Airport	Ballina	Australia
BSJ	Bairnsdale Airport	Bairnsdale	Australia
GIC	Boigu Island Airport	Boigu Island	Australia
OKY	Oakey Army Aviation Centre		Australia
BQL	Boulia Airport		Australia
YBP	Yibin Wuliangye Airport	Yibin (Cuiping)	China
BMP	Brampton Island Airport		Australia
KAH	Melbourne Heliport, Batman Park	Melbourne	Australia
PPP	Proserpine Whitsunday Coast Airport	Proserpine	Australia
YBQ	Telegraph Harbour Seaplane Base	Thetis Island	Canada
ROK	Rockhampton Airport	Rockhampton	Australia
BOX	Borroloola Airport		Australia
BME	Broome International Airport	Broome	Australia
BZD	Balranald Airport		Australia
BTD	Brunette Downs Airport		Australia
BWQ	Brewarrina Airport		Australia
BYP	Barimunya Airport		Australia
MCY	Sunshine Coast Airport	Maroochydore	Australia
BHS	Bathurst Airport	Bathurst	Australia
BRT	Bathurst Island Airport	Wurrumiyanga	Australia
TSV	Townsville Airport / RAAF Base Townsville	Townsville	Australia
BLT	Blackwater Airport		Australia
BVW	Batavia Downs Airport		Australia
BDB	Bundaberg Airport	Bundaberg	Australia
BUY	Bunbury Airport		Australia
BIP	Bulimba Airport		Australia
ZBO	Bowen Airport	Bowen	Australia
WEI	Weipa Airport	Weipa	Australia
BCK	Bolwarra Airport		Australia
WTB	Toowoomba Wellcamp Airport	Toowoomba	Australia
BWB	Barrow Island Airport		Australia
BVZ	Beverley Springs Airport	Wunaamin Miliwundi Ranges	Australia
CTR	Cattle Creek Airport		Australia
CGV	Caiguna Airport		Australia
CLH	Coolah Airport		Australia
CVQ	Carnarvon Airport	Carnarvon	Australia
CSI	Casino Airport		Australia
CAZ	Cobar Airport		Australia
COJ	Coonabarabran Airport		Australia
CBY	Canobie Airport	Canobie	Australia
CBI	Cape Barren Island Airport		Australia
CPD	Coober Pedy Airport	Coober Pedy	Australia
CRB	Collarenebri Airport		Australia
CCL	Chinchilla Airport	Chinchilla	Australia
CNC	Coconut Island Airport		Australia
CNJ	Cloncurry Airport	Cloncurry	Australia
CBX	Condobolin Airport		Australia
CUD	Caloundra Airport	Caloundra	Australia
CED	Ceduna Airport		Australia
CVC	Cleve Airport		Australia
YCF	Cortes Bay Water Aerodrome	Cortes Bay	Canada
CFI	Camfield Airport		Australia
CFH	Clifton Hills Airport	Clifton Hills	Australia
CQP	Cape Flattery Airport		Australia
CFS	Coffs Harbour Airport	Coffs Harbour	Australia
LLG	Chillagoe Airport	Chillagoe	Australia
CRH	Cherrabah Airport	Cherrabah Homestead Resort	Australia
CKW	Christmas Creek Airport	Christmas Creek Mine	Australia
CXT	Charters Towers Airport		Australia
DCN	RAAF Base Curtin	Derby	Australia
CKI	Croker Island Airport		Australia
CTN	Cooktown Airport		Australia
CMQ	Clermont Airport		Australia
CMA	Cunnamulla Airport		Australia
CML	Camooweal Airport		Australia
NIF	Camp Nifty Airport		Australia
CES	Cessnock Airport		Australia
CNB	Coonamble Airport		Australia
ODL	Cordillo Downs Airport	Cordillo Downs	Australia
CUQ	Coen Airport	Coen	Australia
CIE	Collie Airport	Collie	Australia
OOM	Cooma Snowy Mountains Airport	Cooma	Australia
CDA	Cooinda Airport		Australia
CWW	Corowa Airport		Australia
CFP	Carpentaria Downs Airport	Carpentaria Downs	Australia
CYG	Corryong Airport		Australia
CXQ	Christmas Creek Station Airport	Wangkat Jungka	Australia
CDQ	Croydon Airport		Australia
KCE	Collinsville Airport		Australia
CMD	Cootamundra Airport		Australia
CUG	Cudal Airport		Australia
CUY	Cue Airport		Australia
CJF	Coondewanna Airport	Coondewanna	Australia
CWR	Cowarie Airport		Australia
CCW	Cowell Airport		Australia
CWT	Cowra Airport		Australia
COY	Coolawanyah Airport	Coolawanyah Station	Australia
DJR	Dajarra Airport		Australia
DBY	Dalby Airport		Australia
DRN	Dirranbandi Airport		Australia
DNB	Dunbar Airport	Maramie	Australia
DRB	Derby Airport	Derby	Australia
DFP	Drumduff Airport	Palmer	Australia
DDI	Daydream Island Helipad	Whitsundays	Australia
DGD	Dalgaranga Gold Mine Airport		Australia
DNG	Doongan Airport	Drysdale River	Australia
DXD	Dixie Airport	New Dixie	Australia
DKI	Dunk Island Airport	Dunk Island	Australia
DLK	Dulkaninna Airport	Dulkaninna	Australia
DNQ	Deniliquin Airport	Deniliquin	Australia
DDN	Delta Downs Airport		Australia
DLV	Delissaville Airport		Australia
DYW	Daly Waters Airport	Daly Waters	Australia
DMD	Doomadgee Airport		Australia
DVR	Daly River Airport	Nauiyu	Australia
NLF	Darnley Island Airport	Darnley Island	Australia
DRD	Dorunda Airport	Dorunda Outstation	Australia
DVP	Davenport Downs Airport		Australia
DPO	Devonport Airport	Devonport	Australia
DOX	Dongara Airport	Dongara	Australia
DRY	Drysdale River Airport	Drysdale River	Australia
DHD	Durham Downs Airport		Australia
DRR	Durrie Airport		Australia
SRR	Dunwich Airport	North Stradbroke Island	Australia
DKV	Docker River Airport	Kaltukatjara	Australia
DYA	Dysart Airport		Australia
RXA	Ar Rawdah Airport	Ar Rawdah	Yemen
ECH	Echuca Airport		Australia
EUC	Eucla Airport		Australia
ETD	Etadunna Airport	Etadunna	Australia
ENB	Eneabba Airport	Eneabba	Australia
EIH	Einasleigh Airport	Einasleigh	Australia
ELC	Elcho Island Airport	Elcho Island	Australia
EKD	Elkedra Airport		Australia
EMD	Emerald Airport	Emerald	Australia
YEQ	Yenkis(Yankisa) Airport		Papua New Guinea
EDD	Erldunda Airport	Ghan	Australia
ERB	Ernabella Airport		Australia
ERQ	Elrose Airport	Elrose Mine	Australia
EPR	Esperance Airport	Esperance	Australia
EVD	Eva Downs Airport	Eva Downs	Australia
EVH	Evans Head Aerodrome		Australia
WHB	Eliwana		Australia
EXM	Exmouth Airport		Australia
FRB	Forbes Airport	Forbes	Australia
KFE	Fortescue - Dave Forrest Aerodrome	Cloudbreak Village	Australia
FLY	Finley Airport		Australia
FLS	Flinders Island Airport	Flinders Island	Australia
FVL	Flora Valley Airport		Australia
FIK	Finke Airport	Finke	Australia
FOS	Forrest Airport		Australia
FVR	Oombulgurri Airport	Oombulgurri	Australia
FOT	Forster (Wallis Is) Airport		Australia
JFM	Fremantle Heliport	Fremantle	Australia
FIZ	Fitzroy Crossing Airport		Australia
YGA	Yongchuan Da'an General Airport	Chongqing	China
GBP	Gamboola Airport	Gamboola	Australia
GAH	Gayndah Airport	Gayndah	Australia
GBL	South Goulburn Is Airport		Australia
GUH	Gunnedah Airport		Australia
GOO	Goondiwindi Airport		Australia
GDD	Gordon Downs Airport	Gordon Downs	Australia
GGD	Gregory Downs Airport		Australia
YGE	Gorge Harbour Seaplane Base	Gorge Harbour	Canada
GET	Geraldton Airport	Geraldton	Australia
GFN	Clarence Valley Regional Airport	Grafton	Australia
GBW	Ginbata Airport	Ginbata	Australia
GBV	Gibb River Airport	Gibb	Australia
GKL	Great Keppel Is Airport	Great Keppel Island	Australia
GLT	Gladstone Airport	Gladstone	Australia
GUL	Goulburn Airport		Australia
GLG	Glengyle Airport		Australia
GLI	Glen Innes Airport	Glen Innes	Australia
GLM	Glenormiston Airport		Australia
YGN	Greenway Sound Seaplane Base	Broughton Island	Canada
GFE	Grenfell Airport	Grenfell	Australia
GVP	Greenvale Airport		Australia
GPD	Mount Gordon Airport	Mount Gordon Mine	Australia
GPN	Garden Point Airport	Pirlangimpi	Australia
GSC	Gascoyne Junction Airport	Gascoyne Junction	Australia
GTE	Groote Eylandt Airport	Groote Eylandt	Australia
GFF	Griffith Airport	Griffith	Australia
GTT	Georgetown Airport	Georgetown	Australia
GEE	Georgetown Airport	Georgetown	Australia
GYP	Gympie Airport		Australia
HWK	Wilpena Pound Airport	Hawker	Australia
HXX	Hay Airport		Australia
HVB	Hervey Bay Airport	Hervey Bay	Australia
HUB	Humbert River Airport		Australia
HRY	Henbury Airport	Ghan	Australia
HIP	Headingly Airport		Australia
HIG	Highbury Airport	Highbury	Australia
HID	Horn Island Airport	Horn	Australia
HLL	Hillside Airport	Hillside	Australia
HCQ	Halls Creek Airport		Australia
HMG	Hermannsburg Airport	Hermannsburg (Ntaria)	Australia
HLT	Hamilton Airport		Australia
HOK	Hooker Creek Airport	Lajamanu	Australia
MHU	Mount Hotham Airport	Mount Hotham	Australia
HAP	Happy Bay Helipad	Long Island	Australia
HTU	Hopetoun Airport		Australia
HPE	Hope Vale Airport	Hope Vale	Australia
HSM	Horsham Airport		Australia
HAT	Heathlands Airport	Shelburne	Australia
HGD	Hughenden Airport		Australia
IBM	Iron Bridge Mine Airport	Japal Camp	Australia
IDK	Indulkana Airport	Indulkana	Australia
IFL	Innisfail Airport		Australia
IFF	Iffley Airport		Australia
IGH	Ingham Airport		Australia
IKP	Inkerman Airport	Inkerman	Australia
INJ	Injune Airport	Injune	Australia
INM	Innamincka Airport		Australia
IVW	Inverway Airport	Inverway	Australia
ISI	Isisford Airport		Australia
IVR	Inverell Airport	Inverell	Australia
JAB	Jabiru Airport		Australia
JUN	Jundah Airport	Jundah	Australia
JCK	Julia Creek Airport		Australia
JUR	Jurien Bay Airport	Jurien Bay	Australia
UBU	Kalumburu Airport	Kalumburu	Australia
KYB	Ken's Bore airport	Ken's Bore	Australia
KDB	Kambalda Airport	Kambalda	Australia
KAX	Kalbarri Airport	Kalbarri	Australia
KBY	Streaky Bay Airport		Australia
KBJ	Kings Canyon Airport	Petermann	Australia
KCS	Kings Creek Airport	Petermann	Australia
OOD	Koodaideri Mine Airport	Koodaideri Mine	Australia
KRA	Kerang Airport		Australia
KNS	King Island Airport		Australia
KBB	Kirkimbie Station Airport	Kirkimbie	Australia
KFG	Kalkgurung Airport		Australia
KOH	Koolatah Airport	Maramie	Australia
KKP	Koolburra Airport	Koolburra	Australia
KCI	Koolan Central Airport	Koolan Island	Australia
KRB	Karumba Airport		Australia
KML	Kamileroi Airport		Australia
KPS	Kempsey Airport		Australia
KNI	Katanning Airport		Australia
KWM	Kowanyama Airport	Kowanyama	Australia
KPP	Kalpowar Airport	Kalpower	Australia
KGY	Kingaroy Airport		Australia
KGC	Kingscote Airport		Australia
YKT	Klemtu Water Aerodrome	Klemtu	Canada
KUG	Kubin Island Airport	Kubin Island	Australia
KRD	Kurundi Airport	Kurundi Station	Australia
LWH	Lawn Hill Airport		Australia
LGH	Leigh Creek Airport		Australia
LNO	Leonora Airport	Leonora	Australia
LEL	Lake Evella Airport		Australia
LFP	Lakefield Airport	Lakefield	Australia
LDH	Lord Howe Island Airport	Lord Howe Island	Australia
IRG	Lockhart River Airport	Lockhart River	Australia
LTP	Lyndhurst Airport	Lyndhurst	Australia
LIB	Limbunya Airport	Limbunya	Australia
LDC	Lindeman Island Airport	Lindeman Island	Australia
LSY	Lismore Airport	Lismore	Australia
LNH	Lake Nash Airport	Alpurrurulam	Australia
BBL	Ballera Airport		Australia
BEO	Lake Macquarie Airport	City of Lake Macquarie	Australia
LKD	Lakeland Airport	Lakeland Downs	Australia
LOC	Lock Airport	Lock	Australia
LOA	Lorraine Airport		Australia
LTV	Lotus Vale Airport	Lotus Vale	Australia
YLP	Mingan Airport	Longue-Pointe-de-Mingan	Canada
LUU	Laura Airport		Australia
LHG	Lightning Ridge Airport		Australia
LRE	Longreach Airport	Longreach	Australia
LUT	New Laura Airport	Laura Station	Australia
LER	Leinster Airport		Australia
LVO	Laverton Airport	Laverton	Australia
TGN	Latrobe Valley Airport	Morwell	Australia
LZR	Lizard Island Airport		Australia
UBB	Mabuiag Island Airport	Mabuiag Island	Australia
MYI	Murray Island Airport	Murray Island	Australia
AVV	Avalon Airport	Lara	Australia
ABX	Albury Airport	Albury	Australia
MRG	Mareeba Airport	Mareeba	Australia
MBB	Marble Bar Airport		Australia
XMC	Mallacoota Airport		Australia
MFP	Manners Creek Airport		Australia
MLR	Millicent Airport		Australia
DGE	Mudgee Airport	Mudgee	Australia
MQA	Mandora Airport	Mandora	Australia
MNW	Macdonald Downs Airport		Australia
MKR	Meekatharra Airport		Australia
MEB	Melbourne Essendon Airport	Essendon Fields	Australia
MIM	Merimbula Airport	Merimbula	Australia
MLV	Merluna Airport	Merluna	Australia
MGT	Milingimbi Airport	Milingimbi Island	Australia
MNG	Maningrida Airport	Maningrida	Australia
GSN	Mount Gunson Airport	Mount Gunson	Australia
MGV	Margaret River (Station) Airport		Australia
MQZ	Margaret River Airport		Australia
MVU	Musgrave Airport	Musgrave	Australia
HBA	Hobart International Airport	Hobart	Australia
MHO	Mount House Airport	Wunaamin Miliwundi Ranges	Australia
MCV	McArthur River Mine Airport	McArthur River Mine	Australia
MQL	Mildura Airport	Mildura	Australia
XML	Minlaton Airport		Australia
MIH	Mitchell Plateau Airport	Mitchell Plateau	Australia
MWY	Miranda Downs Airport	Miranda Downs	Australia
MTQ	Mitchell Airport		Australia
MJP	Manjimup Airport		Australia
WLE	Miles Airport		Australia
LST	Launceston Airport	Launceston	Australia
MBW	Melbourne Moorabbin Airport	Melbourne	Australia
WUI	Murrin Murrin Airport	Murrin Murrin	Australia
MEL	Melbourne International Airport	Melbourne	Australia
MMM	Middlemount Airport		Australia
MTL	Maitland Airport		Australia
WME	Mount Keith Airport		Australia
ONR	Monkira Airport		Australia
MSF	Mount Swan Airport		Australia
OXY	Morney Airport		Australia
MMG	Mount Magnet Airport		Australia
OOR	Mooraberree Airport		Australia
MRZ	Moree Airport	Moree	Australia
MET	Moreton Airport	Moreton	Australia
MIN	Minnipa Airport		Australia
MQE	Marqua Airport	Marqua	Australia
MOV	Moranbah Airport	Moranbah	Australia
RRE	Marree Airport		Australia
MWB	Morawa Airport		Australia
MYA	Moruya Airport	Moruya	Australia
MTD	Mount Sanford Station Airport		Australia
MIY	Mittebah Airport		Australia
UTB	Muttaburra Airport		Australia
MGB	Mount Gambier Airport	Mount Gambier	Australia
ONG	Mornington Island Airport		Australia
MNQ	Monto Airport		Australia
MUQ	Muccan Station Airport	Muccan Station	Australia
MNE	Mungeranie Airport	Mungeranie	Australia
MVK	Mulka Airport	Mulka	Australia
MUP	Mulga Park Airport		Australia
MNV	Mount Valley Airport		Australia
MXU	Mullewa Airport		Australia
MWT	Moolawatana Airport	Moolawatana Station	Australia
MXD	Marion Downs Airport	Marion Downs	Australia
MBH	Maryborough Airport	Maryborough	Australia
MYO	Myroodan Station Airport		Australia
RTY	Merty Merty Airport		Australia
NMR	Nappa Merrie Airport		Australia
NRA	Narrandera Airport	Narrandera	Australia
NAA	Narrabri Airport	Narrabri	Australia
RPM	Ngukurr Airport		Australia
NBH	Nambucca Heads Airport	Nambucca Heads	Australia
NLS	Nicholson Airport		Australia
NKB	Noonkanbah Airport		Australia
NMP	New Moon Airport	Basalt	Australia
NPP	Napperby Airport	Napperby	Australia
ABM	Northern Peninsula Airport	Bamaga	Australia
NAC	Naracoorte Airport		Australia
NRG	Narrogin Airport	Narrogin	Australia
QRM	Narromine Airport		Australia
RVT	Ravensthorpe Airport		Australia
NSV	Noosa Airport		Australia
NSM	Norseman Airport		Australia
YNT	Yantai Penglai International Airport	Yantai	China
NTN	Normanton Airport	Normanton	Australia
NUR	Nullabor Motel Airport		Australia
NLL	Nullagine Airport		Australia
NUB	Numbulwar Airport		Australia
UTD	Nutwood Downs Airport	Nutwood Downs	Australia
ZNE	Newman Airport	Newman	Australia
NYN	Nyngan Airport		Australia
OPI	Oenpelli Airport		Australia
YOI	Opinaca Aerodrome	Éléonore Mine	Canada
XCO	Colac Airport	Colac	Australia
OLP	Olympic Dam Airport	Olympic Dam	Australia
ONS	Onslow Airport		Australia
ODD	Oodnadatta Airport		Australia
MOO	Moomba Airport	Moomba	Australia
RBS	Orbost Airport		Australia
OAG	Orange Airport	Orange	Australia
ODR	Ord River Airport	Ord River	Australia
OSO	Osborne Mine Airport		Australia
OYN	Ouyen Airport	Ouyen	Australia
ADL	Adelaide International Airport	Adelaide	Australia
PUG	Port Augusta Airport		Australia
PMK	Palm Island Airport		Australia
PBO	Paraburdoo Airport	Paraburdoo	Australia
CCK	Cocos (Keeling) Islands Airport	West Island	Cocos (Keeling) Islands
PDN	Parndana Airport	Kangaroo Island	Australia
PDE	Pandie Pandie Airport		Australia
DRW	Darwin International Airport / RAAF Darwin	Darwin	Australia
PRD	Pardoo Airport	Pardoo	Australia
GOV	Gove Airport	Nhulunbuy	Australia
PPI	Port Pirie Airport		Australia
JAD	Perth Jandakot Airport	Perth	Australia
KTA	Karratha Airport	Karratha	Australia
KGI	Kalgoorlie Boulder Airport	Broadwood	Australia
PKE	Parkes Airport	Parkes	Australia
PKT	Port Keats Airport	Wadeye	Australia
KNX	East Kimberley Regional (Kununurra) Airport	Kununurra	Australia
PLO	Port Lincoln Airport	Port Lincoln	Australia
LEA	Learmonth Airport	Exmouth	Australia
PXH	Prominent Hill Airport	Mount Eba	Australia
EDR	Pormpuraaw Airport	Pormpuraaw	Australia
PQQ	Port Macquarie Airport	Port Macquarie	Australia
PEY	Penong Airport	Penong	Australia
PTJ	Portland Airport		Australia
MBF	Porepunkah Airport		Australia
PHE	Port Hedland International Airport	Port Hedland	Australia
PER	Perth International Airport	Perth	Australia
PEA	Penneshaw Airport	Ironstone	Australia
KTR	Tindal Airport		Australia
UMR	Woomera Airfield	Woomera	Australia
XCH	Christmas Island Airport	Flying Fish Cove	Christmas Island
UIR	Quirindi Airport		Australia
YQJ	April Point Seaplane Base	Quadra Island	Canada
ULP	Quilpie Airport		Australia
UEE	Queenstown Airport		Australia
RRV	Robinson River Airport		Australia
YRC	Refuge Cove Seaplane Base	Desolation Sound	Canada
YRD	Dean River Airport	Kimsquit Valley	Canada
RMK	Renmark Airport		Australia
RCM	Richmond Airport		Australia
RAM	Ramingining Airport		Australia
ROH	Robinhood Airport		Australia
RBU	Roebourne Airport	Roebourne	Australia
RBC	Robinvale Airport	Robinvale	Australia
RMA	Roma Airport	Roma	Australia
RPB	Roper Bar Airport	Roper Bar	Australia
RSB	Roseberth Airport		Australia
RTS	Rottnest Island Airport		Australia
RTP	Rutland Plains Airport	Yagoonya	Australia
RHL	Roy Hill Station Airport		Australia
NDS	Sandstone Airport	Sandstone	Australia
BWU	Sydney Bankstown Airport	Sydney	Australia
CBR	Canberra International Airport	Canberra	Australia
WCD	Carosue Dam Airport	Cundeelee	Australia
CDU	Camden Airport	Cobbitty	Australia
NSO	Scone Airport		Australia
SQC	Southern Cross Airport		Australia
DBO	Dubbo City Regional Airport	Dubbo	Australia
SGO	St George Airport		Australia
SIX	Singleton Airport	Singleton	Australia
ZGL	South Galway Airport		Australia
SGP	Shay Gap Airport	Shay Gap	Australia
MJK	Shark Bay Airport	Denham	Australia
WOL	Shellharbour Airport	Albion Park Rail	Australia
WSY	Shute Harbour/Whitsunday Airport	Shute Harbour	Australia
SHT	Shepparton Airport		Australia
SBR	Saibai Island Airport	Saibai Island	Australia
GOS	Somersby Airstrip	Gosford	Australia
SIO	Smithton Airport		Australia
SOI	South Molle Island Helipad	South Molle Island Resort	Australia
SHU	Smith Point Airport		Australia
STH	Strathmore Airport	Strathmore	Australia
SNB	Snake Bay Airport	Milikapiti	Australia
NLK	Norfolk Island International Airport	Burnt Pine	Norfolk Island
NOA	Naval Air Station Nowra - HMAS Albatross	Nowra Hill	Australia
SNH	Stanthorpe Airport		Australia
SCG	Spring Creek Airport		Australia
SHQ	Southport Airport		Australia
KSV	Springvale Airport		Australia
XRH	RAAF Base Richmond	Richmond	Australia
SRN	Strahan Airport		Australia
SYD	Sydney Kingsford Smith International Airport	Sydney	Australia
HLS	St Helens Airport		Australia
STF	Stephens Island Seaplane Base	Stephens Island	Australia
TMW	Tamworth Airport	Tamworth	Australia
SSP	Silver Plains Airport	Silver Plains	Australia
WGA	Wagga Wagga City Airport	Wagga Wagga	Australia
SWH	Swan Hill Airport		Australia
SWC	Stawell Airport		Australia
XTR	Tara Airport		Australia
TBL	Tableland Homestead Airport		Australia
XTO	Taroom Airport		Australia
TAQ	Tarcoola Airport	Tarcoola	Australia
TBK	Timber Creek Airport		Australia
TDR	Theodore Airport		Australia
TQP	Trepell Airport	Trepell	Australia
TEF	Telfer Airport		Australia
TEM	Temora Airport	Temora	Australia
TAN	Tangalooma Airport		Australia
XTG	Thargomindah Airport	Thargomindah	Australia
GTS	The Granites Airport	The Granites Gold Mine	Australia
TDN	Theda Station Airport	Drysdale River	Australia
TYG	Thylungra Airport		Australia
TYB	Tibooburra Airport		Australia
TKY	Turkey Creek Airport	Turkey Creek	Australia
PHQ	The Monument Airport	Phosphate Hill	Australia
TUM	Tumut Airport		Australia
TYP	Tobermorey Airport	Tobermorey	Australia
TXR	Tanbar Airport	Tanbar Station	Australia
THG	Thangool Airport	Biloela	Australia
TCA	Tennant Creek Airport	Tennant Creek	Australia
TCW	Tocumwal Airport		Australia
TRO	Taree Airport	Taree	Australia
TTX	Truscott-Mungalalu Airport	Anjo Peninsula	Australia
TWB	Toowoomba Airport	Toowoomba	Australia
UDA	Undara Airport		Australia
CZY	Cluny Airport		Australia
USL	Useless Loop Airport	Useless Loop	Australia
VCD	Victoria River Downs Airport	Victoria River	Australia
VNR	Vanrook Station Airport		Australia
WAU	Wauchope Airport	Wauchope	Australia
WLA	Wallal Airport	Wallal	Australia
WAV	Wave Hill Airport		Australia
WMB	Warrnambool Airport		Australia
SYU	Warraber Island Airport	Sue Islet	Australia
WIO	Wilcannia Airport		Australia
WLC	Walcha Airport		Australia
WAZ	Warwick Airport		Australia
WND	Windarra Airport	Laverton	Australia
WRN	Windarling Airport	Windarling Mine	Australia
WNR	Windorah Airport		Australia
WON	Wondoola Airport	Wondoola	Australia
MFL	Mount Full Stop Airport	Wando Vale	Australia
GYB	Port Hedland/Wodgina Airport	Wodgina	Australia
WGT	Wangaratta Airport		Australia
WYA	Whyalla Airport	Whyalla	Australia
WIT	Wittenoom Airport		Australia
WKB	Warracknabeal Airport		Australia
WGE	Walgett Airport		Australia
NTL	Newcastle Airport	Williamtown	Australia
WUN	Wiluna Airport		Australia
WPK	Wrotham Park Airport	Wrotham Park	Australia
WDI	Wondai Airport		Australia
WLL	Wollogorang Airport		Australia
SXE	West Sale Airport	Sale	Australia
WLO	Waterloo Airport		Australia
WIN	Winton Airport		Australia
WUD	Wudinna Airport		Australia
WEW	Wee Waa Airport		Australia
WRW	Warrawagine Airport		Australia
WWI	Woodie Woodie Airport	Woodie Woodie	Australia
WWY	West Wyalong Airport	West Wyalong	Australia
WYN	Wyndham Airport		Australia
BWT	Wynyard Airport	Burnie	Australia
YYA	Yueyang Sanhe Airport	Yueyang (Yueyanglou)	China
YLG	Yalgoo Airport	Yalgoo	Australia
OKR	Yorke Island Airport	Yorke Island	Australia
KYF	Yeelirrie Airport		Australia
XMY	Yam Island Airport	Yam Island	Australia
YUE	Yuendumu Airport		Australia
NGA	Young Airport		Australia
ORR	Yorketown Airport		Australia
KYI	Yalata Mission Airport	Yalata Mission	Australia
KKI	Akiachak Airport	Akiachak	United States
BCC	Bear Creek 3 Airport	Bear Creek	United States
JBT	Bethel Seaplane Base	Bethel	United States
CZP	Cape Pole Seaplane Base	Cape Pole	United States
KBW	Chignik Bay Seaplane Base	Chignik	United States
KBC	Birch Creek Airport	Birch Creek	United States
CZC	Copper Center 2 Airport	Copper Center	United States
HPR	Pretoria Central Heliport	Pretoria	South Africa
ULX	Ulusaba Airport	Ulusaba	South Africa
TDT	Tanda Tula Airport	Timbavati	South Africa
HZV	Hazyview Airport	Hazyview	South Africa
KHO	Khoka Moya Airport	Khoka Moya	South Africa
MBM	Mkambati Airport	Mkambati	South Africa
INY	Inyati Airport	Inyati	South Africa
TSD	Tshipise Airport	Tshipise	South Africa
SSX	Singita Safari Lodge Airport	Singita Safari Lodge	South Africa
LLE	Malelane Airport		South Africa
KIG	Koingnaas Airport	Koingnaas	South Africa
PEK	Beijing Capital International Airport	Beijing	China
PKX	Beijing Daxing International Airport	Beijing	China
CDE	Chengde Puning Airport	Chengde	China
CIF	Chifeng Yulong Airport	Chifeng	China
CIH	Changzhi Wangcun Airport	Changzhi	China
BPE	Qinhuangdao Beidaihe Airport	Qinhuangdao (Changli)	China
DSN	Ordos Ejin Horo Airport	Ordos	China
DAT	Datong Yungang Airport	Datong	China
ERL	Erenhot Saiwusu International Airport	Erenhot	China
YIE	Arxan Yi'ershi Airport	Arxan	China
HDG	Handan Airport	Handan	China
HET	Hohhot Baita International Airport	Hohhot	China
HUO	Holingol Huolinhe Airport	Holingol	China
HLD	Hulunbuir Hailar Airport	Hailar	China
LFQ	Linfen Yaodu Airport	Linfen (Yaodu)	China
LLV	Lüliang Dawu Airport	Lüliang	China
NZH	Manzhouli Xijiao Airport	Manzhouli	China
BAV	Baotou Donghe Airport	Baotou	China
SZH	Shuozhou Zirun Airport	Shuozhou	China
SJW	Shijiazhuang Zhengding International Airport	Shijiazhuang	China
TSN	Tianjin Binhai International Airport	Tianjin	China
TGO	Tongliao Airport	Tongliao	China
UCB	Ulanqab Jining Airport	Ulanqab	China
WUA	Wuhai Airport	Wuhai	China
HLH	Ulanhot Yilelite Airport	Ulanhot	China
XIL	Xilinhot Airport	Xilinhot	China
XNT	Xingtai Dalian Airport	Xingtai	China
WUT	Xinzhou Wutaishan Airport	Xinzhou	China
YCU	Yuncheng Zhangxiao Airport	Yuncheng (Yanhu)	China
TYN	Taiyuan Wusu Airport	Taiyuan	China
RLK	Bayannur Tianjitai Airport	Bavannur	China
NZL	Zhalantun Genghis Khan Airport	Zhalantun	China
ZDM	Ramallah Heliport	Ramallah	Palestinian Territories
ZDY	Delma Airport	Delma Island	United Arab Emirates
ZEN	Zenag Airport	Zenag	Papua New Guinea
BHY	Beihai Fucheng Airport	Beihai (Yinhai)	China
CGD	Changde Taohuayuan Airport	Changde (Dingcheng)	China
HJJ	Huaihua Zhijiang Airport	Huaihua	China
HCZ	Chenzhou Beihu Airport	Chenzhou	China
DYG	Zhangjiajie Hehua International Airport	Zhangjiajie (Yongding)	China
CAN	Guangzhou Baiyun International Airport	Guangzhou (Huadu)	China
CSX	Changsha Huanghua International Airport	Changsha (Changsha)	China
HCJ	Hechi Jinchengjiang Airport	Hechi (Jinchengjiang)	China
SHF	Shihezi Huayuan Airport	Shihezi	China
HNY	Hengyang Nanyue Airport	Hengyang	China
KWL	Guilin Liangjiang International Airport	Guilin (Lingui)	China
LLF	Yongzhou Lingling Airport	Yongzhou	China
MXZ	Meizhou Meixian Changgangji International Airport	Meizhou (Meixian)	China
NNG	Nanning Wuxu Airport	Nanning (Jiangnan)	China
SWA	Jieyang Chaoshan International Airport	Jieyang (Rongcheng)	China
ZUH	Zhuhai Jinwan Airport	Zhuhai (Jinwan)	China
WGN	Shaoyang Wugang Airport	Shaoyang (Wugang)	China
SZX	Shenzhen Bao'an International Airport	Shenzhen (Bao'an)	China
XIN	Xingning Air Base	Meizhou (Xingning)	China
DXJ	Xiangxi Biancheng Airport	Xiangxi	China
YLX	Yulin Fumian Airport	Yùlín	China
LZH	Liuzhou Bailian Airport / Bailian Air Base	Liuzhou (Liujiang)	China
AYN	Anyang Yindu Airport	Anyang	China
CGO	Zhengzhou Xinzheng International Airport	Zhengzhou	China
ENH	Enshi Xujiaping Airport	Enshi (Enshi)	China
LHK	Guangzhou MR Air Base / Guanghua Airport	Xiangyang (Laohekou)	China
WUH	Wuhan Tianhe International Airport	Wuhan (Huangpi)	China
SHS	Jingzhou Shashi Airport	Jingzhou (Shashi)	China
LYA	Luoyang Beijiao Airport	Luoyang (Laocheng)	China
NNY	Nanyang Jiangying Airport	Nanyang (Wancheng)	China
HQQ	Anyang Hongqiqu Airport	Anyang	China
HPG	Shennongjia Hongping Airport	Shennongjia (Hongping)	China
WDS	Shiyan Wudangshan Airport	Shiyan (Maojian)	China
XFN	Xiangyang Liuji Airport	Xiangyang (Xiangzhou)	China
YIH	Yichang Sanxia Airport	Yichang (Xiaoting)	China
ZIZ	Zamzama Heliport	Zamzama Gas Field	Pakistan
HAK	Haikou Meilan International Airport	Haikou (Meilan)	China
BAR	Qionghai Bo'ao Airport	Qionghai (Basuo)	China
SYX	Sanya Phoenix International Airport	Sanya (Tianya)	China
XYI	Yongxing Dao (Woody Island) Airport	Sansha (Yongxing Dao / Woody Island)	China
FNJ	Pyongyang Sunan International Airport	Pyongyang	North Korea
DSO	Sondok Airport	Sŏndŏng-ni	North Korea
WOS	Wonsan Kalma International Airport	Wonsan	North Korea
AKA	Ankang Fuqiang Airport	Ankang (Hanbin)	China
DNH	Dunhuang Mogao International Airport	Dunhuang	China
HXD	Delingha Airport	Delingha	China
GOQ	Golmud Airport	Golmud	China
GYU	Guyuan Liupanshan Airport	Guyuan (Yuanzhou)	China
HTT	Huatugou Airport	Mengnai	China
HZG	Hanzhong Chenggu Airport	Hanzhong (Chenggu)	China
INC	Yinchuan Hedong International Airport	Yinchuan	China
JGN	Jiayuguan Airport	Jiayuguan	China
LHW	Lanzhou Zhongchuan International Airport	Lanzhou (Yongdeng)	China
LNL	Longnan Chengzhou Airport	Longnan (Cheng)	China
IQN	Qingyang Xifeng Airport	Qingyang (Xifeng)	China
SIA	Xi'an Xiguan Airport	Xi'an (Baqiao)	China
GXH	Gannan Xiahe Airport	Gannan (Xiahe)	China
XNN	Xining Caojiabao International Airport	Haidong (Huzhu Tu Autonomous County)	China
XIY	Xi'an Xianyang International Airport	Xianyang (Weicheng)	China
UYN	Yulin Yuyang Airport	Yulin	China
ZHY	Zhongwei Shapotou Airport	Zhongwei (Shapotou)	China
UMB	Kalumbila Airport	Kalumbila	Zambia
AVK	Arvaikheer Airport	Arvaikheer	Mongolia
LTI	Altai Airport	Altai	Mongolia
BYN	Bayankhongor Airport	Bayankhongor	Mongolia
UGA	Bulgan Airport	Bulgan	Mongolia
UGT	Bulagtai Resort Airport	Khankhongor	Mongolia
HBU	Bulgan Sum Airport	Bulgan	Mongolia
UUN	Baruun Urt Airport		Mongolia
COQ	Choibalsan Airport		Mongolia
UBN	Ulaanbaatar Chinggis Khaan International Airport	Ulaanbaatar (Sergelen)	Mongolia
ZMD	Sena Madureira Airport	Sena Madureira	Brazil
ULZ	Donoi Airport	Uliastai	Mongolia
DLZ	Dalanzadgad Airport	Dalanzadgad	Mongolia
KHR	Kharkhorin Airport		Mongolia
HJT	Khujirt Airport	Khujirt	Mongolia
HVD	Khovd Airport	Khovd	Mongolia
MXV	Mörön Airport	Mörön	Mongolia
TSZ	Tsetserleg Airport	Tsetserleg	Mongolia
TNZ	Tosontsengel Airport	Tosontsengel	Mongolia
ULN	Buyant-Ukhaa International Airport	Ulaanbaatar	Mongolia
ULO	Ulaangom Airport	Ulaangom	Mongolia
ULG	Ölgii Mongolei Airport	Ölgii	Mongolia
ZNC	Nyac Airport	Nyac	United States
ZNU	Namu Water Aerodrome	Namu	Canada
CWJ	Cangyuan Washan Airport	Lincang (Cangyuan)	China
DLU	Dali Fengyi Airport	Dali (Xiaguan)	China
DIG	Diqing Shangri-La Airport	Diqing (Shangri-La)	China
JHG	Xishuangbanna Gasa International Airport	Jinghong (Gasa)	China
JMJ	Lancang Jingmai Airport	Pu'er (Lancang)	China
LJG	Lijiang Sanyi International Airport	Lijiang (Gucheng)	China
LUM	Dehong Mangshi Airport	Dehong (Mangshi)	China
KMG	Kunming Changshui International Airport	Kunming	China
SYM	Pu'er Simao Airport	Pu'er	China
WNH	Wenshan Puzhehei Airport	Wenshan	China
ZAT	Zhaotong Airport	Zhaotong (Zhaoyang)	China
ZRI	Stevanus Rumbewas Airport	Serui	Indonesia
XMN	Xiamen Gaoqi International Airport	Xiamen	China
AQG	Anqing Tianzhushan Airport / Anqing North Air Base	Anqing	China
BFU	Bengbu Tenghu Airport	Bengbu	China
CZX	Changzhou Benniu International Airport	Changzhou	China
KHN	Nanchang Changbei International Airport	Nanchang	China
FUG	Fuyang Xiguan Airport	Yingzhou, Fuyang	China
FOC	Fuzhou Changle International Airport	Fuzhou	China
KOW	Ganzhou Huangjin Airport	Ganzhou	China
HGH	Hangzhou Xiaoshan International Airport	Hangzhou	China
HZA	Heze Mudan Airport	Heze (Dingtao)	China
JDZ	Jingdezhen Luojia Airport	Jingdezhen	China
JNG	Jining Da'an Airport	Jining	China
JIU	Jiujiang Lushan Airport	Jiujiang	China
TNA	Jinan Yaoqiang International Airport	Jinan (Licheng)	China
JUZ	Quzhou Airport	Quzhou	China
LCX	Longyan Guanzhishan Airport	Longyan	China
HYN	Taizhou Luqiao Airport	Huangyan	China
LYI	Linyi Qiyang Airport	Linyi (Hedong)	China
NGB	Ningbo Lishe International Airport	Ningbo	China
NKG	Nanjing Lukou International Airport	Nanjing	China
HFE	Hefei Xinqiao International Airport	Hefei	China
PVG	Shanghai Pudong International Airport	Shanghai (Pudong)	China
JJN	Quanzhou Jinjiang International Airport	Quanzhou	China
RUG	Rugao Air Base	Rugao (Nantong)	China
RIZ	Rizhao Shanzihe Airport	Rizhao (Donggang)	China
SHA	Shanghai Hongqiao International Airport	Shanghai (Minhang)	China
SZV	Suzhou Guangfu Airport	Suzhou	China
TXN	Tunxi International Airport	Huangshan	China
WHA	Wuhu Xuanzhou Airport	Wuhu	China
WEF	Weifang Nanyuan Airport	Weifang (Kuiwen)	China
WEH	Weihai Dashuibo Airport	Weihai	China
WHU	Wuhu Wanli Airport / Wuhu Air Base	Wuhu	China
WUX	Sunan Shuofang International Airport	Wuxi	China
WUS	Nanping Wuyishan Airport	Wuyishan	China
WNZ	Wenzhou Longwan International Airport	Wenzhou	China
XUZ	Xuzhou Guanyin International Airport	Xuzhou	China
YTY	Yangzhou Taizhou Airport	Yangzhou	China
YIC	Yichun Mingyueshan Airport	Yichun	China
YNZ	Yancheng Nanyang International Airport	Yancheng (Tinghu)	China
YIW	Yiwu Airport	Yiwu	China
HSN	Zhoushan Putuoshan Airport	Zhoushan	China
NGQ	Ngari Gunsa Airport	Shiquanhe	China
AVA	Anshun Huangguoshu Airport	Anshun (Xixiu)	China
BCJ	Beichuan Yongchang Airport	Mianyang	China
BPX	Qamdo Bangda Airport	Bangda	China
BFJ	Bijie Feixiong Airport	Bijie	China
CKG	Chongqing Jiangbei International Airport	Chongqing	China
DCY	Daocheng Yading Airport	Garzê (Daocheng)	China
DAX	Dachuan Airport	Dazhou (Daxian)	China
GHN	Guanghan Airport	Deyang (Guanghan)	China
GYS	Guangyuan Panlong Airport	Guangyuan (Lizhou)	China
KWE	Guiyang Longdongbao International Airport	Guiyang (Nanming)	China
GZG	Garze Gesar Airport	Garzê (Garzê)	China
JZH	Jiuzhai Huanglong Airport	Ngawa (Songpan)	China
KGT	Kangding Airport	Garzê (Kangding)	China
KJH	Kaili Huangping Airport	Kaili  (Huangping)	China
LLB	Libo Airport	Qiannan (Libo)	China
LIA	Liangping Airport	Liangping	China
LXA	Lhasa Gonggar Airport	Shannan (Gonggar)	China
LZO	Luzhou Yunlong Airport	Luzhou (Yunlong)	China
UNR	Öndörkhaan Airport	Öndörkhaan	Mongolia
WMT	Zunyi Maotai Airport	Zunyi	China
MIG	Mianyang Nanjiao Airport	Mianyang (Fucheng)	China
NAO	Nanchong Gaoping Airport	Nanchong (Gaoping)	China
HZH	Liping Airport	Liping	China
LZY	Nyingchi Mainling Airport	Nyingchi (Mainling)	China
LPF	Liupanshui Yuezhao Airport	Liupanshui (Zhongshan)	China
LGZ	Shannan Longzi Airport	Shannan	China
TCZ	Tengchong Tuofeng Airport	Baoshan (Tengchong)	China
TFU	Chengdu Tianfu International Airport	Chengdu (Jianyang)	China
TEN	Tongren Fenghuang Airport	Tongren (Daxing)	China
CTU	Chengdu Shuangliu International Airport	Chengdu (Shuangliu)	China
CQW	Chongqing Xiannüshan Airport	Wulong	China
WSK	Chongqing Wushan Airport	Wushan	China
WXN	Wanzhou Wuqiao Airport	Wanzhou	China
XIC	Xichang Qingshan Airport	Liangshan (Xichang)	China
ACX	Xingyi Wanfenglin Airport	Xingyi	China
ZYI	Zunyi Xinzhou Airport	Zunyi	China
AKU	Aksu Hongqipo Airport	Aksu (Onsu)	China
ACF	Aral Tarim Airport	Aral	China
BPL	Bole Alashankou Airport	Bole	China
IQM	Qiemo Yudu Airport	Qiemo	China
FYN	Fuyun Koktokay Airport	Fuyun	China
HMI	Hami Airport	Hami	China
KCA	Kuqa Qiuci Airport	Kuqa	China
KRL	Korla Licheng Airport	Korla	China
KRY	Karamay Airport	Karamay	China
KJI	Burqin Kanas Airport	Burqin	China
NLT	Xinyuan Nalati Airport	Xinyuan	China
RQA	Ruoqiang Loulan Airport	Ruoqiang Town	China
QSZ	Shache Airport	Shache	China
KHG	Kashgar Airport	Kashgar	China
SXJ	Shanshan Airport	Shanshan	China
TCG	Tacheng Qianquan Airport	Tacheng	China
TLQ	Turpan Jiaohe Airport	Turpan	China
HTN	Hotan Airport	Hotan	China
URC	Ürümqi Diwopu International Airport	Ürümqi	China
YIN	Yining Airport	Ili (Yining / Ghulja)	China
YTW	Yutian Wanfang Airport	Hotan (Yutian)	China
AOG	Anshan Teng'ao Airport / Anshan Air Base	Anshan	China
CGQ	Changchun Longjia International Airport	Changchun	China
CNI	Changhai Airport	Dalian (Changhai)	China
CHG	Chaoyang Airport	Shuangta, Chaoyang	China
DTU	Wudalianchi Dedu Airport	Heihe	China
FYJ	Fuyuan Dongji Airport	Fuyuan	China
HRB	Harbin Taiping International Airport	Harbin	China
HEK	Heihe Aihui Airport	Heihe	China
JIL	Jilin Ertaizi Airport	Jilin	China
JMU	Jiamusi Dongjiao Airport	Jiamusi	China
JSJ	Jiansanjiang Shidi Airport	Jiansanjiang	China
JXA	Jixi Xingkaihu Airport	Jixi	China
LDS	Yichun Lindu Airport	Yichun	China
YUS	Yushu Batang Airport	Yushu (Batang)	China
MDG	Mudanjiang Hailang International Airport	Mudanjiang	China
OHE	Mohe Gulian Airport	Mohe	China
NDG	Qiqihar Sanjiazi Airport	Qiqihar	China
HSF	Suifenhe Dongning Airport	Suifenhe	China
YSQ	Songyuan Chaganhu Airport	Qian Gorlos Mongol Autonomous County	China
DLC	Dalian Zhoushuizi International Airport	Dalian (Ganjingzi)	China
TNH	Tonghua Sanyuanpu Airport	Tonghua	China
SHE	Shenyang Taoxian International Airport	Hunnan, Shenyang	China
YNJ	Yanji Chaoyangchuan Airport	Yanji	China
YKH	Yingkou Lanqi Airport	Yingkou (Laobian)	China
\.


--
-- Data for Name: Banner; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Banner" ("BannerID", "Title", "Description", "ImageURL", "DiscountTitle", "DiscountDescription") FROM stdin;
BNW7L2F9VT	Beijing welcomes you	Discover the Heart of China	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/banner-files/BNW7L2F9VT/Beijing.jpg	Discover Beijing with 20% Off	Try authentic Chinese culture with a 20% discount
BNP2947LMS	Kyoto: Where Tradition Meets Tranquility	Explore the Serenity of Kyoto's Ancient Temples	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/banner-files/BNP2947LMS/Kyoto.jpeg	Discover Kyoto with 10% Off	Enjoy traditional Japanese culture in Kyoto with a 10% discount
BNQ6828CTY	Paris: The City of Romance	In the city of love	https://mnmeanwagbiimebjrsgm.supabase.co/storage/v1/object/public/banner-files/BNQ6828CTY/Paris.jpg	Paris Romance Special	Have a romantic getaway in Paris and enjoy a 15% discount
\.


--
-- Data for Name: Flight; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Flight" ("FlightID", "Status", "DepTime", "ArrTime", "BoardingTime", "DepID", "DestID", "AircraftID", "OriginalDepTime", "OriginalArrTime", "OriginalBoardingTime") FROM stdin;
ZE355	Scheduled	2024-12-20 03:00:00+00	2024-12-20 07:00:00+00	2024-12-20 02:30:00+00	HAN	SGN	A380	\N	\N	\N
AY611	Scheduled	2024-12-21 11:00:00+00	2024-12-21 15:00:00+00	2024-12-21 10:30:00+00	SGN	HAN	A350	\N	\N	\N
WV763	Arrived	2024-12-15 03:00:00+00	2024-12-15 07:00:00+00	2024-12-15 02:30:00+00	HAN	SGN	A380	\N	\N	\N
WW137	Arrived	2024-12-15 07:00:00+00	2024-12-15 11:00:00+00	2024-12-15 06:30:00+00	HAN	SGN	A350	\N	\N	\N
PA645	Arrived	2024-12-15 11:00:00+00	2024-12-15 15:00:00+00	2024-12-15 10:30:00+00	HAN	SGN	A380	\N	\N	\N
OH179	Arrived	2024-12-15 15:22:00+00	2024-12-15 05:22:00+00	2024-12-15 14:22:00+00	HAN	SGN	A350	\N	\N	\N
IT851	Arrived	2024-12-16 03:00:00+00	2024-12-16 07:00:00+00	2024-12-16 02:30:00+00	HAN	SGN	A380	\N	\N	\N
XK135	Arrived	2024-12-16 07:00:00+00	2024-12-16 11:00:00+00	2024-12-16 06:30:00+00	CDG	LHR	A350	\N	\N	\N
YY762	Arrived	2024-12-16 11:00:00+00	2024-12-16 15:00:00+00	2024-12-16 10:30:00+00	SGN	HAN	A350	\N	\N	\N
VP730	Arrived	2024-12-17 03:00:00+00	2024-12-17 07:00:00+00	2024-12-17 02:30:00+00	DXB	CDG	A380	\N	\N	\N
ZI116	Arrived	2024-12-17 07:00:00+00	2024-12-17 11:00:00+00	2024-12-17 06:30:00+00	HAN	SGN	A350	\N	\N	\N
PM765	Arrived	2024-12-17 11:00:00+00	2024-12-17 15:00:00+00	2024-12-17 10:30:00+00	SYD	CDG	A350	\N	\N	\N
WW790	Arrived	2024-12-18 03:00:00+00	2024-12-18 07:00:00+00	2024-12-18 02:30:00+00	SGN	HAN	A350	\N	\N	\N
RN302	Arrived	2024-12-18 07:00:00+00	2024-12-18 11:00:00+00	2024-12-18 06:30:00+00	LAX	SIN	A350	\N	\N	\N
HR357	Arrived	2024-12-18 11:00:00+00	2024-12-18 15:00:00+00	2024-12-18 10:30:00+00	SYD	DXB	A350	\N	\N	\N
VJ796	Arrived	2024-12-19 03:00:00+00	2024-12-19 07:00:00+00	2024-12-19 02:30:00+00	SGN	HAN	A350	\N	\N	\N
QU263	Arrived	2024-12-19 07:00:00+00	2024-12-19 11:00:00+00	2024-12-19 06:30:00+00	HAN	SGN	A350	\N	\N	\N
CR158	Arrived	2024-12-19 11:00:00+00	2024-12-19 15:00:00+00	2024-12-19 10:30:00+00	SIN	HND	A350	\N	\N	\N
SU399	Scheduled	2024-12-20 11:00:00+00	2024-12-20 15:00:00+00	2024-12-20 10:30:00+00	HAN	SGN	A380	\N	\N	\N
XJ392	Scheduled	2024-12-21 03:00:00+00	2024-12-21 07:00:00+00	2024-12-21 02:30:00+00	HAN	SGN	A350	\N	\N	\N
SS216	Scheduled	2024-12-21 07:00:00+00	2024-12-21 11:00:00+00	2024-12-21 06:30:00+00	SGN	HAN	A380	\N	\N	\N
LP699	Scheduled	2024-12-20 04:10:00+00	2024-12-20 06:10:00+00	2024-12-20 03:50:00+00	HAN	SGN	A350	\N	\N	\N
UG650	Scheduled	2024-12-20 08:11:00+00	2024-12-20 10:12:00+00	2024-12-20 07:11:00+00	HAN	SGN	A380	\N	\N	\N
AX776	Scheduled	2024-12-22 04:16:00+00	2024-12-21 18:16:00+00	2024-12-22 03:16:00+00	SGN	HAN	A380	\N	\N	\N
ZD340	Scheduled	2024-12-22 07:16:00+00	2024-12-22 09:17:00+00	2024-12-22 06:17:00+00	SGN	HAN	A350	\N	\N	\N
BK248	Scheduled	2024-12-24 04:18:00+00	2024-12-24 06:18:00+00	2024-12-24 03:18:00+00	HAN	SGN	A350	\N	\N	\N
OQ831	Delayed	2024-12-20 14:30:00+00	2024-12-20 19:00:00+00	2024-12-20 15:00:00+00	SGN	HAN	A350	2024-12-20 07:00:00+00	2024-12-20 11:00:00+00	2024-12-20 06:30:00+00
WI105	Scheduled	2024-12-24 16:43:00+00	2024-12-24 18:44:00+00	2024-12-24 15:44:00+00	HAN	SGN	A350	\N	\N	\N
VB710	Scheduled	2024-12-23 10:10:00+00	2024-12-23 11:10:00+00	2024-12-23 09:11:00+00	HAN	SGN	A350	\N	\N	\N
BQ968	Scheduled	2024-12-21 07:00:00+00	2024-12-21 11:00:00+00	2024-12-21 06:30:00+00	HAN	SGN	A380	\N	\N	\N
OW423	Scheduled	2024-12-21 15:00:00+00	2024-12-21 19:00:00+00	2024-12-21 14:30:00+00	JID	OCA	A350	\N	\N	\N
\.


--
-- Data for Name: FlightSeat; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."FlightSeat" ("FlightID", "AircraftID", "SeatNo", "TicketID") FROM stdin;
VJ796	A350	45B	\N
AY611	A350	47H	\N
AY611	A350	47J	\N
AY611	A350	47K	\N
AY611	A350	48A	\N
AY611	A350	48B	\N
AY611	A350	48C	\N
AY611	A350	48D	\N
AY611	A350	48E	\N
AY611	A350	48G	\N
AY611	A350	48H	\N
AY611	A350	48J	\N
AY611	A350	48K	\N
AY611	A350	49A	\N
AY611	A350	49B	\N
AY611	A350	49C	\N
AY611	A350	49D	\N
AY611	A350	49E	\N
AY611	A350	49G	\N
AY611	A350	49H	\N
AY611	A350	49J	\N
AY611	A350	49K	\N
AY611	A350	5A	\N
AY611	A350	5C	\N
AY611	A350	5H	\N
AY611	A350	5K	\N
AY611	A350	50A	\N
AY611	A350	50B	\N
AY611	A350	50C	\N
AY611	A350	50D	\N
AY611	A350	50E	\N
AY611	A350	50G	\N
AY611	A350	50H	\N
AY611	A350	50J	\N
AY611	A350	50K	\N
AY611	A350	51A	\N
AY611	A350	51B	\N
AY611	A350	51C	\N
AY611	A350	51D	\N
AY611	A350	51E	\N
AY611	A350	51G	\N
AY611	A350	51H	\N
AY611	A350	51J	\N
AY611	A350	51K	\N
AY611	A350	52A	\N
AY611	A350	52B	\N
AY611	A350	52C	\N
AY611	A350	52D	\N
AY611	A350	52E	\N
AY611	A350	52G	\N
AY611	A350	52H	\N
AY611	A350	52J	\N
AY611	A350	52K	\N
AY611	A350	53A	\N
AY611	A350	53B	\N
AY611	A350	53C	\N
AY611	A350	53D	\N
AY611	A350	53E	\N
AY611	A350	53G	\N
AY611	A350	53H	\N
AY611	A350	53J	\N
AY611	A350	53K	\N
AY611	A350	54A	\N
AY611	A350	54B	\N
AY611	A350	54C	\N
AY611	A350	54D	\N
AY611	A350	54E	\N
AY611	A350	54G	\N
AY611	A350	54H	\N
AY611	A350	54J	\N
AY611	A350	54K	\N
AY611	A350	55A	\N
AY611	A350	55B	\N
AY611	A350	55C	\N
AY611	A350	55D	\N
AY611	A350	55E	\N
AY611	A350	55G	\N
AY611	A350	55H	\N
AY611	A350	56H	\N
AY611	A350	56J	\N
AY611	A350	56K	\N
AY611	A350	57A	\N
AY611	A350	57B	\N
AY611	A350	57C	\N
AY611	A350	57D	\N
AY611	A350	57E	\N
AY611	A350	57G	\N
AY611	A350	57H	\N
AY611	A350	57J	\N
AY611	A350	57K	\N
AY611	A350	58A	\N
AY611	A350	58B	\N
AY611	A350	58C	\N
AY611	A350	58D	\N
AY611	A350	58E	\N
AY611	A350	58G	\N
AY611	A350	58H	\N
AY611	A350	58J	\N
AY611	A350	58K	\N
AY611	A350	59A	\N
AY611	A350	59B	\N
AY611	A350	59C	\N
AY611	A350	59D	\N
AY611	A350	59E	\N
AY611	A350	59G	\N
AY611	A350	59H	\N
AY611	A350	59J	\N
AY611	A350	59K	\N
AY611	A350	6A	\N
AY611	A350	6C	\N
AY611	A350	6D	\N
AY611	A350	6E	\N
AY611	A350	6F	\N
AY611	A350	6G	\N
AY611	A350	6H	\N
AY611	A350	6K	\N
AY611	A350	60A	\N
AY611	A350	60C	\N
AY611	A350	60D	\N
AY611	A350	60E	\N
AY611	A350	60G	\N
AY611	A350	61D	\N
AY611	A350	61E	\N
AY611	A350	61G	\N
AY611	A350	7A	\N
AY611	A350	7C	\N
AY611	A350	7D	\N
AY611	A350	7E	\N
AY611	A350	7F	\N
AY611	A350	7G	\N
AY611	A350	7H	\N
AY611	A350	7K	\N
AY611	A350	8A	\N
AY611	A350	8C	\N
AY611	A350	8D	\N
AY611	A350	8E	\N
AY611	A350	8F	\N
AY611	A350	8G	\N
AY611	A350	8H	\N
AY611	A350	8K	\N
AY611	A350	9A	\N
AY611	A350	9C	\N
AY611	A350	9D	\N
AY611	A350	9E	\N
AY611	A350	9F	\N
AY611	A350	9G	\N
AY611	A350	9H	\N
AY611	A350	9K	\N
WV763	A380	21D	\N
PA645	A380	21D	\N
PA645	A380	24J	\N
IT851	A380	20A	\N
VP730	A380	20A	\N
ZE355	A380	24J	\N
SU399	A380	20A	\N
SS216	A380	20A	\N
VJ796	A350	10E	T668011
OH179	A350	28J	\N
OH179	A350	28K	\N
OH179	A350	29A	\N
OH179	A350	29B	\N
AY611	A350	55J	\N
AY611	A350	55K	\N
AY611	A350	56A	\N
AY611	A350	56B	\N
AY611	A350	56C	\N
AY611	A350	56D	\N
AY611	A350	56E	\N
AY611	A350	56G	\N
OH179	A350	29C	\N
OH179	A350	29D	\N
OH179	A350	29E	\N
OH179	A350	29G	\N
OH179	A350	29H	\N
OH179	A350	29J	\N
OH179	A350	29K	\N
OH179	A350	30A	\N
OH179	A350	30B	\N
OH179	A350	30C	\N
OH179	A350	30D	\N
OH179	A350	30E	\N
OH179	A350	30G	\N
OH179	A350	30H	\N
OH179	A350	30J	\N
OH179	A350	30K	\N
OH179	A350	31A	\N
OH179	A350	31B	\N
OH179	A350	31C	\N
OH179	A350	31D	\N
OH179	A350	31E	\N
OH179	A350	31G	\N
OH179	A350	31H	\N
OH179	A350	31J	\N
OH179	A350	31K	\N
OH179	A350	32A	\N
OH179	A350	32B	\N
OH179	A350	32C	\N
OH179	A350	32D	\N
OH179	A350	32E	\N
OH179	A350	32G	\N
OH179	A350	32H	\N
OH179	A350	32J	\N
OH179	A350	32K	\N
OH179	A350	33A	\N
OH179	A350	33B	\N
OH179	A350	33C	\N
OH179	A350	33D	\N
OH179	A350	33E	\N
OH179	A350	33G	\N
OH179	A350	33H	\N
OH179	A350	33J	\N
OH179	A350	33K	\N
OH179	A350	34A	\N
OH179	A350	34B	\N
OH179	A350	34C	\N
OH179	A350	34D	\N
OH179	A350	34E	\N
OH179	A350	34G	\N
OH179	A350	34H	\N
OH179	A350	34J	\N
OH179	A350	34K	\N
OH179	A350	35A	\N
OH179	A350	35B	\N
OH179	A350	35C	\N
OH179	A350	35D	\N
OH179	A350	35E	\N
OH179	A350	35G	\N
OH179	A350	35H	\N
OH179	A350	35J	\N
OH179	A350	35K	\N
OH179	A350	36A	\N
OH179	A350	36B	\N
OH179	A350	36C	\N
OH179	A350	36D	\N
OH179	A350	36E	\N
OH179	A350	36G	\N
OH179	A350	36H	\N
OH179	A350	36J	\N
OH179	A350	36K	\N
OH179	A350	37A	\N
OH179	A350	37B	\N
OH179	A350	37C	\N
OH179	A350	37D	\N
OH179	A350	37E	\N
OH179	A350	37G	\N
OH179	A350	37H	\N
OH179	A350	37J	\N
OH179	A350	37K	\N
OH179	A350	38A	\N
OH179	A350	38B	\N
OH179	A350	38C	\N
OH179	A350	38D	\N
OH179	A350	38E	\N
OH179	A350	38G	\N
OH179	A350	38H	\N
OH179	A350	38J	\N
OH179	A350	38K	\N
OH179	A350	39A	\N
OH179	A350	39B	\N
OH179	A350	39C	\N
OH179	A350	39D	\N
OH179	A350	39E	\N
OH179	A350	39G	\N
OH179	A350	39H	\N
OH179	A350	39J	\N
OH179	A350	39K	\N
OH179	A350	40D	\N
OH179	A350	40E	\N
OH179	A350	40G	\N
OH179	A350	45A	\N
OH179	A350	45B	\N
OH179	A350	45C	\N
OH179	A350	45D	\N
OH179	A350	45E	\N
OH179	A350	45G	\N
OH179	A350	45H	\N
OH179	A350	45J	\N
OH179	A350	45K	\N
OH179	A350	46A	\N
OH179	A350	46B	\N
OH179	A350	46C	\N
OH179	A350	46D	\N
OH179	A350	46E	\N
OH179	A350	46G	\N
OH179	A350	46H	\N
OH179	A350	46J	\N
OH179	A350	46K	\N
OH179	A350	47A	\N
OH179	A350	47B	\N
OH179	A350	47C	\N
OH179	A350	47D	\N
OH179	A350	47E	\N
OH179	A350	47G	\N
OH179	A350	47H	\N
OH179	A350	47J	\N
OH179	A350	47K	\N
OH179	A350	48A	\N
OH179	A350	48B	\N
OH179	A350	48C	\N
OH179	A350	48D	\N
OH179	A350	48E	\N
OH179	A350	48G	\N
OH179	A350	48H	\N
OH179	A350	48J	\N
OH179	A350	48K	\N
OH179	A350	49A	\N
OH179	A350	49B	\N
OH179	A350	49C	\N
OH179	A350	49D	\N
OH179	A350	49E	\N
OH179	A350	49G	\N
OH179	A350	49H	\N
OH179	A350	49J	\N
OH179	A350	49K	\N
OH179	A350	5A	\N
OH179	A350	5C	\N
OH179	A350	5H	\N
OH179	A350	5K	\N
OH179	A350	50A	\N
OH179	A350	50B	\N
OH179	A350	50C	\N
OH179	A350	50D	\N
OH179	A350	50E	\N
OH179	A350	50G	\N
OH179	A350	50H	\N
OH179	A350	50J	\N
OH179	A350	50K	\N
OH179	A350	51A	\N
OH179	A350	51B	\N
OH179	A350	51C	\N
OH179	A350	51D	\N
OH179	A350	51E	\N
OH179	A350	51G	\N
OH179	A350	51H	\N
OH179	A350	51J	\N
OH179	A350	51K	\N
OH179	A350	52A	\N
OH179	A350	52B	\N
OH179	A350	52C	\N
OH179	A350	52D	\N
OH179	A350	52E	\N
OH179	A350	52G	\N
WV763	A380	1E	\N
OH179	A350	52H	\N
OH179	A350	52J	\N
OH179	A350	52K	\N
OH179	A350	53A	\N
OH179	A350	53B	\N
OH179	A350	53C	\N
OH179	A350	53D	\N
OH179	A350	53E	\N
OH179	A350	53G	\N
OH179	A350	53H	\N
OH179	A350	53J	\N
OH179	A350	53K	\N
OH179	A350	54A	\N
OH179	A350	54B	\N
OH179	A350	54C	\N
OH179	A350	54D	\N
OH179	A350	54E	\N
OH179	A350	54G	\N
OH179	A350	54H	\N
OH179	A350	54J	\N
OH179	A350	54K	\N
OH179	A350	55A	\N
OH179	A350	55B	\N
OH179	A350	55C	\N
OH179	A350	55D	\N
OH179	A350	55E	\N
OH179	A350	55G	\N
OH179	A350	55H	\N
OH179	A350	55J	\N
OH179	A350	55K	\N
OH179	A350	56A	\N
OH179	A350	56B	\N
OH179	A350	56C	\N
OH179	A350	56D	\N
OH179	A350	56E	\N
OH179	A350	56G	\N
OH179	A350	56H	\N
OH179	A350	56J	\N
OH179	A350	56K	\N
OH179	A350	57A	\N
OH179	A350	57B	\N
OH179	A350	57C	\N
OH179	A350	57D	\N
OH179	A350	57E	\N
OH179	A350	57G	\N
OH179	A350	57H	\N
OH179	A350	57J	\N
OH179	A350	57K	\N
OH179	A350	58A	\N
OH179	A350	58B	\N
OH179	A350	58C	\N
OH179	A350	58D	\N
OH179	A350	58E	\N
OH179	A350	58G	\N
OH179	A350	58H	\N
OH179	A350	58J	\N
OH179	A350	58K	\N
OH179	A350	59A	\N
OH179	A350	59B	\N
OH179	A350	59C	\N
OH179	A350	59D	\N
OH179	A350	59E	\N
OH179	A350	59G	\N
OH179	A350	59H	\N
OH179	A350	59J	\N
OH179	A350	59K	\N
OH179	A350	6A	\N
OH179	A350	6C	\N
OH179	A350	6D	\N
OH179	A350	6E	\N
OH179	A350	6F	\N
OH179	A350	6G	\N
OH179	A350	6H	\N
OH179	A350	6K	\N
OH179	A350	60A	\N
OH179	A350	60C	\N
OH179	A350	60D	\N
OH179	A350	60E	\N
OH179	A350	60G	\N
OH179	A350	61D	\N
OH179	A350	61E	\N
OH179	A350	61G	\N
OH179	A350	7A	\N
OH179	A350	7C	\N
OH179	A350	7D	\N
OH179	A350	7E	\N
OH179	A350	7F	\N
OH179	A350	7G	\N
OH179	A350	7H	\N
OH179	A350	7K	\N
OH179	A350	8A	\N
OH179	A350	8C	\N
OH179	A350	8D	\N
OH179	A350	8E	\N
OH179	A350	8F	\N
OH179	A350	8G	\N
OH179	A350	8H	\N
OH179	A350	8K	\N
OH179	A350	9A	\N
OH179	A350	9C	\N
OH179	A350	9D	\N
OH179	A350	9E	\N
OH179	A350	9F	\N
OH179	A350	9G	\N
OH179	A350	9H	\N
OH179	A350	9K	\N
WV763	A380	1A	\N
WV763	A380	1F	\N
WV763	A380	1K	\N
WV763	A380	10B	\N
WV763	A380	10D	\N
WV763	A380	10G	\N
WV763	A380	10J	\N
WV763	A380	11A	\N
WV763	A380	11E	\N
WV763	A380	11F	\N
WV763	A380	11K	\N
WV763	A380	12B	\N
WV763	A380	12D	\N
WV763	A380	12G	\N
WV763	A380	12J	\N
WV763	A380	14A	\N
WV763	A380	14E	\N
WV763	A380	14F	\N
WV763	A380	14K	\N
WV763	A380	15B	\N
WV763	A380	15D	\N
WV763	A380	15G	\N
WV763	A380	15J	\N
WV763	A380	16A	\N
WV763	A380	16E	\N
WV763	A380	16F	\N
WV763	A380	16K	\N
WV763	A380	17B	\N
WV763	A380	17D	\N
WV763	A380	17G	\N
WV763	A380	17J	\N
WV763	A380	18A	\N
WV763	A380	18E	\N
WV763	A380	18F	\N
WV763	A380	18K	\N
WV763	A380	19B	\N
WV763	A380	19D	\N
WV763	A380	19G	\N
WV763	A380	19J	\N
WV763	A380	2A	\N
WV763	A380	2E	\N
WV763	A380	2F	\N
WV763	A380	2K	\N
WV763	A380	20A	\N
WV763	A380	20E	\N
WV763	A380	20F	\N
WV763	A380	20K	\N
WV763	A380	21B	\N
WV763	A380	21G	\N
WV763	A380	21J	\N
WV763	A380	22D	\N
WV763	A380	22G	\N
WV763	A380	23A	\N
WV763	A380	23E	\N
WV763	A380	23F	\N
WV763	A380	23K	\N
WV763	A380	24B	\N
WV763	A380	24D	\N
WV763	A380	24G	\N
WV763	A380	25A	\N
WV763	A380	25E	\N
WV763	A380	25F	\N
WV763	A380	25K	\N
WV763	A380	26B	\N
WV763	A380	26D	\N
WV763	A380	26G	\N
WV763	A380	26J	\N
WV763	A380	3A	\N
WV763	A380	3E	\N
WV763	A380	3F	\N
WV763	A380	3K	\N
WV763	A380	4A	\N
WV763	A380	4K	\N
WV763	A380	43A	\N
WV763	A380	43B	\N
WV763	A380	43C	\N
WV763	A380	43H	\N
VJ796	A350	10F	T855556
WV763	A380	43J	\N
WV763	A380	43K	\N
WV763	A380	44A	\N
WV763	A380	44B	\N
WV763	A380	44C	\N
WV763	A380	44H	\N
WV763	A380	44J	\N
WV763	A380	44K	\N
WV763	A380	45A	\N
WV763	A380	45B	\N
WV763	A380	45C	\N
WV763	A380	45D	\N
WV763	A380	45E	\N
WV763	A380	45F	\N
WV763	A380	45G	\N
WV763	A380	45H	\N
WV763	A380	45J	\N
WV763	A380	45K	\N
WV763	A380	46A	\N
WV763	A380	46B	\N
WV763	A380	46C	\N
WV763	A380	46D	\N
WV763	A380	46E	\N
WV763	A380	46F	\N
WV763	A380	46G	\N
WV763	A380	46H	\N
WV763	A380	46J	\N
WV763	A380	46K	\N
WV763	A380	47A	\N
WV763	A380	47B	\N
WV763	A380	47C	\N
WV763	A380	47D	\N
WV763	A380	47E	\N
WV763	A380	47F	\N
WV763	A380	47G	\N
WV763	A380	47H	\N
WV763	A380	47J	\N
WV763	A380	47K	\N
WV763	A380	48A	\N
WV763	A380	48B	\N
WV763	A380	48C	\N
WV763	A380	48D	\N
WV763	A380	48E	\N
WV763	A380	48F	\N
WV763	A380	48G	\N
WV763	A380	48H	\N
WV763	A380	48J	\N
WV763	A380	48K	\N
WV763	A380	49A	\N
WV763	A380	49B	\N
WV763	A380	49C	\N
WV763	A380	49D	\N
WV763	A380	49E	\N
WV763	A380	49F	\N
WV763	A380	49G	\N
WV763	A380	49H	\N
WV763	A380	49J	\N
WV763	A380	49K	\N
WV763	A380	50A	\N
WV763	A380	50B	\N
WV763	A380	50C	\N
WV763	A380	50D	\N
WV763	A380	50E	\N
WV763	A380	50F	\N
WV763	A380	50G	\N
WV763	A380	50H	\N
WV763	A380	50J	\N
WV763	A380	50K	\N
WV763	A380	51D	\N
WV763	A380	51E	\N
WV763	A380	51F	\N
WV763	A380	51G	\N
WV763	A380	52A	\N
WV763	A380	52B	\N
WV763	A380	52C	\N
WV763	A380	52H	\N
WV763	A380	52J	\N
WV763	A380	52K	\N
WV763	A380	53A	\N
WV763	A380	53B	\N
WV763	A380	53C	\N
WV763	A380	53H	\N
WV763	A380	53J	\N
WV763	A380	53K	\N
WV763	A380	54A	\N
WV763	A380	54B	\N
WV763	A380	54C	\N
WV763	A380	54D	\N
WV763	A380	54E	\N
WV763	A380	54F	\N
WV763	A380	54G	\N
WV763	A380	54H	\N
WV763	A380	54J	\N
WV763	A380	54K	\N
WV763	A380	55A	\N
WV763	A380	55B	\N
WV763	A380	55C	\N
WV763	A380	55D	\N
WV763	A380	55E	\N
WV763	A380	55F	\N
WV763	A380	55G	\N
WV763	A380	55H	\N
WV763	A380	55J	\N
WV763	A380	55K	\N
WV763	A380	56A	\N
WV763	A380	56B	\N
WV763	A380	24J	\N
WV763	A380	56C	\N
WV763	A380	56D	\N
WV763	A380	56E	\N
WV763	A380	56F	\N
WV763	A380	56G	\N
WV763	A380	56H	\N
WV763	A380	56J	\N
WV763	A380	56K	\N
WV763	A380	57A	\N
WV763	A380	57B	\N
WV763	A380	57C	\N
WV763	A380	57D	\N
WV763	A380	57E	\N
WV763	A380	57F	\N
WV763	A380	57G	\N
WV763	A380	57H	\N
WV763	A380	57J	\N
WV763	A380	57K	\N
WV763	A380	58A	\N
WV763	A380	58B	\N
WV763	A380	58C	\N
WV763	A380	58D	\N
WV763	A380	58E	\N
WV763	A380	58F	\N
WV763	A380	58G	\N
WV763	A380	58H	\N
WV763	A380	58J	\N
WV763	A380	58K	\N
WV763	A380	59A	\N
WV763	A380	59B	\N
WV763	A380	59C	\N
WV763	A380	59D	\N
WV763	A380	59E	\N
WV763	A380	59F	\N
WV763	A380	59G	\N
WV763	A380	59H	\N
WV763	A380	59J	\N
WV763	A380	59K	\N
WV763	A380	6D	\N
WV763	A380	6G	\N
WV763	A380	60A	\N
WV763	A380	60B	\N
WV763	A380	60C	\N
WV763	A380	60D	\N
WV763	A380	60E	\N
WV763	A380	60F	\N
WV763	A380	60G	\N
WV763	A380	60H	\N
WV763	A380	60J	\N
WV763	A380	60K	\N
WV763	A380	61A	\N
WV763	A380	61B	\N
WV763	A380	61C	\N
WV763	A380	61D	\N
WV763	A380	61E	\N
WV763	A380	61F	\N
WV763	A380	61G	\N
WV763	A380	61H	\N
WV763	A380	61J	\N
WV763	A380	61K	\N
WV763	A380	62A	\N
WV763	A380	62B	\N
WV763	A380	62C	\N
WV763	A380	62D	\N
WV763	A380	62E	\N
WV763	A380	62F	\N
WV763	A380	62G	\N
WV763	A380	62H	\N
WV763	A380	62J	\N
WV763	A380	62K	\N
WV763	A380	63A	\N
WV763	A380	63B	\N
WV763	A380	63C	\N
WV763	A380	63D	\N
WV763	A380	63E	\N
WV763	A380	63F	\N
WV763	A380	63G	\N
WV763	A380	63H	\N
WV763	A380	63J	\N
WV763	A380	63K	\N
WV763	A380	64A	\N
WV763	A380	64B	\N
WV763	A380	64C	\N
WV763	A380	64D	\N
WV763	A380	64E	\N
WV763	A380	64F	\N
WV763	A380	64G	\N
WV763	A380	64H	\N
WV763	A380	64J	\N
WV763	A380	64K	\N
WV763	A380	65A	\N
WV763	A380	65B	\N
WV763	A380	65C	\N
WV763	A380	65D	\N
WV763	A380	65E	\N
WV763	A380	65F	\N
WV763	A380	65G	\N
WV763	A380	65H	\N
WV763	A380	65J	\N
WV763	A380	65K	\N
WV763	A380	66H	\N
WV763	A380	66J	\N
WV763	A380	66K	\N
WV763	A380	67B	\N
WV763	A380	67C	\N
WV763	A380	67D	\N
WV763	A380	67E	\N
WV763	A380	67F	\N
WV763	A380	67G	\N
WV763	A380	67H	\N
WV763	A380	67J	\N
WV763	A380	68A	\N
WV763	A380	68B	\N
WV763	A380	68C	\N
WV763	A380	68D	\N
WV763	A380	68E	\N
WV763	A380	68F	\N
WV763	A380	68G	\N
WV763	A380	68H	\N
WV763	A380	68J	\N
WV763	A380	68K	\N
WV763	A380	69A	\N
WV763	A380	69B	\N
WV763	A380	69C	\N
WV763	A380	69D	\N
WV763	A380	69E	\N
WV763	A380	69F	\N
WV763	A380	69G	\N
WV763	A380	69H	\N
WV763	A380	69J	\N
WV763	A380	69K	\N
WV763	A380	7A	\N
WV763	A380	7E	\N
WV763	A380	7F	\N
WV763	A380	7K	\N
WV763	A380	70A	\N
WV763	A380	70B	\N
WV763	A380	70C	\N
WV763	A380	70D	\N
WV763	A380	70E	\N
WV763	A380	70F	\N
WV763	A380	70G	\N
WV763	A380	70H	\N
WV763	A380	70J	\N
WV763	A380	70K	\N
WV763	A380	71A	\N
WV763	A380	71B	\N
WV763	A380	71C	\N
WV763	A380	71D	\N
WV763	A380	71E	\N
WV763	A380	71F	\N
WV763	A380	71G	\N
WV763	A380	71H	\N
WV763	A380	71J	\N
WV763	A380	71K	\N
WV763	A380	72A	\N
WV763	A380	72B	\N
WV763	A380	72C	\N
WV763	A380	72D	\N
WV763	A380	72E	\N
WV763	A380	72F	\N
WV763	A380	72G	\N
WV763	A380	72H	\N
WV763	A380	72J	\N
WV763	A380	72K	\N
WV763	A380	73A	\N
WV763	A380	73B	\N
WV763	A380	73C	\N
WV763	A380	73D	\N
WV763	A380	73E	\N
WV763	A380	73F	\N
WV763	A380	73G	\N
WV763	A380	73H	\N
WV763	A380	73J	\N
WV763	A380	73K	\N
WV763	A380	74A	\N
WV763	A380	74B	\N
WV763	A380	74C	\N
WV763	A380	74D	\N
WV763	A380	74E	\N
WV763	A380	74F	\N
WV763	A380	74G	\N
WV763	A380	74H	\N
WV763	A380	74J	\N
WV763	A380	74K	\N
WV763	A380	75A	\N
WV763	A380	75B	\N
WV763	A380	75C	\N
WV763	A380	75D	\N
WV763	A380	75E	\N
WV763	A380	75F	\N
WV763	A380	75G	\N
WV763	A380	75H	\N
WV763	A380	75J	\N
WV763	A380	75K	\N
WV763	A380	76A	\N
WV763	A380	76B	\N
WV763	A380	76C	\N
WV763	A380	76D	\N
WV763	A380	76E	\N
WV763	A380	76F	\N
WV763	A380	76G	\N
WV763	A380	76H	\N
WV763	A380	76J	\N
WV763	A380	76K	\N
WV763	A380	77A	\N
WV763	A380	77B	\N
WV763	A380	77C	\N
WV763	A380	77D	\N
WV763	A380	77E	\N
WV763	A380	77F	\N
WV763	A380	77G	\N
WV763	A380	77H	\N
WV763	A380	77J	\N
WV763	A380	77K	\N
WV763	A380	78A	\N
WV763	A380	78B	\N
WV763	A380	78C	\N
WV763	A380	78D	\N
WV763	A380	78E	\N
WV763	A380	78F	\N
WV763	A380	78G	\N
WV763	A380	78H	\N
WV763	A380	78J	\N
WV763	A380	78K	\N
WV763	A380	79A	\N
WV763	A380	79B	\N
WV763	A380	79C	\N
WV763	A380	79H	\N
WV763	A380	79J	\N
WV763	A380	79K	\N
WV763	A380	8B	\N
WV763	A380	8D	\N
WV763	A380	8G	\N
WV763	A380	8J	\N
WV763	A380	80B	\N
WV763	A380	80C	\N
WV763	A380	80H	\N
WV763	A380	80J	\N
WV763	A380	81A	\N
WV763	A380	81B	\N
WV763	A380	81C	\N
WV763	A380	81H	\N
WV763	A380	81J	\N
WV763	A380	81K	\N
WV763	A380	82A	\N
WV763	A380	82B	\N
WV763	A380	82C	\N
WV763	A380	82D	\N
WV763	A380	82E	\N
WV763	A380	82F	\N
WV763	A380	82G	\N
WV763	A380	82H	\N
WV763	A380	82J	\N
WV763	A380	82K	\N
WV763	A380	83A	\N
WV763	A380	83B	\N
WV763	A380	83C	\N
WV763	A380	83D	\N
WV763	A380	83E	\N
WV763	A380	83F	\N
WV763	A380	83G	\N
WV763	A380	83H	\N
WV763	A380	83J	\N
WV763	A380	83K	\N
WV763	A380	84A	\N
WV763	A380	84B	\N
WV763	A380	84C	\N
WV763	A380	84D	\N
WV763	A380	84E	\N
WV763	A380	84F	\N
WV763	A380	84G	\N
WV763	A380	84H	\N
WV763	A380	84J	\N
WV763	A380	84K	\N
WV763	A380	85A	\N
WV763	A380	85B	\N
WV763	A380	85C	\N
WV763	A380	85H	\N
WV763	A380	85J	\N
WV763	A380	85K	\N
WV763	A380	86A	\N
WV763	A380	86B	\N
WV763	A380	86C	\N
WV763	A380	86H	\N
WV763	A380	86J	\N
WV763	A380	86K	\N
WV763	A380	87A	\N
WV763	A380	87B	\N
WV763	A380	87C	\N
WV763	A380	87H	\N
WV763	A380	87J	\N
WV763	A380	87K	\N
WV763	A380	88A	\N
WV763	A380	88B	\N
WV763	A380	88C	\N
WV763	A380	88H	\N
WV763	A380	88J	\N
WV763	A380	88K	\N
WV763	A380	9A	\N
WV763	A380	9E	\N
WV763	A380	9F	\N
WV763	A380	9K	\N
WW137	A350	1A	\N
WW137	A350	1C	\N
WW137	A350	1D	\N
WW137	A350	1G	\N
WW137	A350	1H	\N
WW137	A350	1K	\N
WW137	A350	10A	\N
WW137	A350	10C	\N
WW137	A350	10D	\N
WW137	A350	10E	\N
WW137	A350	10F	\N
WW137	A350	10G	\N
WW137	A350	10H	\N
WW137	A350	10K	\N
WW137	A350	11A	\N
WW137	A350	11C	\N
WW137	A350	11D	\N
WW137	A350	11E	\N
WW137	A350	11F	\N
WW137	A350	11G	\N
WW137	A350	11H	\N
WW137	A350	11K	\N
WW137	A350	12D	\N
WW137	A350	12E	\N
WW137	A350	12F	\N
WW137	A350	12G	\N
WW137	A350	15D	\N
WW137	A350	15E	\N
WW137	A350	15F	\N
WW137	A350	15G	\N
WW137	A350	15H	\N
WW137	A350	15K	\N
WW137	A350	16A	\N
WW137	A350	16C	\N
WW137	A350	16D	\N
WW137	A350	16E	\N
WW137	A350	16F	\N
WW137	A350	16G	\N
WW137	A350	16H	\N
WW137	A350	16K	\N
WW137	A350	17A	\N
WW137	A350	17C	\N
WW137	A350	17D	\N
WW137	A350	17E	\N
WW137	A350	17F	\N
WW137	A350	17G	\N
WW137	A350	17H	\N
WW137	A350	17K	\N
WW137	A350	18A	\N
WW137	A350	18C	\N
WW137	A350	18D	\N
WW137	A350	18E	\N
WW137	A350	18F	\N
WW137	A350	18G	\N
WW137	A350	18H	\N
WW137	A350	18K	\N
WW137	A350	19A	\N
WW137	A350	19C	\N
WW137	A350	19D	\N
WW137	A350	19E	\N
WW137	A350	19F	\N
WW137	A350	19G	\N
WW137	A350	19H	\N
WW137	A350	19K	\N
WW137	A350	2A	\N
WW137	A350	2C	\N
WW137	A350	2D	\N
WW137	A350	2G	\N
WW137	A350	2H	\N
WW137	A350	2K	\N
WW137	A350	27A	\N
WW137	A350	27B	\N
WW137	A350	27C	\N
WW137	A350	27D	\N
WW137	A350	27E	\N
WW137	A350	27G	\N
WW137	A350	27H	\N
WW137	A350	27J	\N
WW137	A350	27K	\N
WW137	A350	28A	\N
WW137	A350	28B	\N
WW137	A350	28C	\N
WW137	A350	28D	\N
WW137	A350	28E	\N
WW137	A350	28G	\N
WW137	A350	28H	\N
WW137	A350	28J	\N
WW137	A350	28K	\N
WW137	A350	29A	\N
WW137	A350	29B	\N
WW137	A350	29C	\N
WW137	A350	29D	\N
WW137	A350	29E	\N
WW137	A350	29G	\N
WW137	A350	29H	\N
WW137	A350	29J	\N
WW137	A350	29K	\N
WW137	A350	30A	\N
WW137	A350	30B	\N
WW137	A350	30C	\N
WW137	A350	30D	\N
WW137	A350	30E	\N
WW137	A350	30G	\N
WW137	A350	30H	\N
WW137	A350	30J	\N
WW137	A350	30K	\N
WW137	A350	31A	\N
WW137	A350	31B	\N
WW137	A350	31C	\N
WW137	A350	31D	\N
WW137	A350	31E	\N
WW137	A350	31G	\N
WW137	A350	31H	\N
WW137	A350	31J	\N
WW137	A350	31K	\N
WW137	A350	32A	\N
WW137	A350	32B	\N
WW137	A350	32C	\N
WW137	A350	32D	\N
WW137	A350	32E	\N
WW137	A350	32G	\N
WW137	A350	32H	\N
WW137	A350	32J	\N
WW137	A350	32K	\N
WW137	A350	33A	\N
WW137	A350	33B	\N
WW137	A350	33C	\N
WW137	A350	33D	\N
WW137	A350	33E	\N
WW137	A350	33G	\N
WW137	A350	33H	\N
WW137	A350	33J	\N
WW137	A350	33K	\N
WW137	A350	34A	\N
WW137	A350	34B	\N
WW137	A350	34C	\N
WW137	A350	34D	\N
WW137	A350	34E	\N
WW137	A350	34G	\N
WW137	A350	34H	\N
WW137	A350	34J	\N
WW137	A350	34K	\N
WW137	A350	35A	\N
WW137	A350	35B	\N
WW137	A350	35C	\N
WW137	A350	51E	\N
WW137	A350	51G	\N
WW137	A350	35D	\N
WW137	A350	35E	\N
WW137	A350	35G	\N
WW137	A350	35H	\N
WW137	A350	35J	\N
WW137	A350	35K	\N
WW137	A350	36A	\N
WW137	A350	36B	\N
WW137	A350	36C	\N
WW137	A350	36D	\N
WW137	A350	36E	\N
WW137	A350	36G	\N
WW137	A350	36H	\N
WW137	A350	36J	\N
WW137	A350	36K	\N
WW137	A350	37A	\N
WW137	A350	37B	\N
WW137	A350	37C	\N
WW137	A350	37D	\N
WW137	A350	37E	\N
WW137	A350	37G	\N
WW137	A350	37H	\N
WW137	A350	37J	\N
WW137	A350	37K	\N
WW137	A350	38A	\N
WW137	A350	38B	\N
WW137	A350	38C	\N
WW137	A350	38D	\N
WW137	A350	38E	\N
WW137	A350	38G	\N
WW137	A350	38H	\N
WW137	A350	38J	\N
WW137	A350	38K	\N
WW137	A350	39A	\N
WW137	A350	39B	\N
WW137	A350	39C	\N
WW137	A350	39D	\N
WW137	A350	39E	\N
WW137	A350	39G	\N
WW137	A350	39H	\N
WW137	A350	39J	\N
WW137	A350	39K	\N
WW137	A350	40D	\N
WW137	A350	40E	\N
WW137	A350	40G	\N
WW137	A350	45A	\N
WW137	A350	45B	\N
WW137	A350	45C	\N
WW137	A350	45D	\N
WW137	A350	45E	\N
WW137	A350	45G	\N
WW137	A350	45H	\N
WW137	A350	45J	\N
WW137	A350	45K	\N
WW137	A350	46A	\N
WW137	A350	46B	\N
WW137	A350	46C	\N
WW137	A350	46D	\N
WW137	A350	46E	\N
WW137	A350	46G	\N
WW137	A350	46H	\N
WW137	A350	46J	\N
WW137	A350	46K	\N
WW137	A350	47A	\N
WW137	A350	47B	\N
WW137	A350	47C	\N
WW137	A350	47D	\N
WW137	A350	47E	\N
WW137	A350	47G	\N
WW137	A350	47H	\N
WW137	A350	47J	\N
WW137	A350	47K	\N
WW137	A350	48A	\N
WW137	A350	48B	\N
WW137	A350	48C	\N
WW137	A350	48D	\N
WW137	A350	48E	\N
WW137	A350	48G	\N
WW137	A350	48H	\N
WW137	A350	48J	\N
WW137	A350	48K	\N
WW137	A350	49A	\N
WW137	A350	49B	\N
WW137	A350	49C	\N
WW137	A350	49D	\N
WW137	A350	49E	\N
WW137	A350	49G	\N
WW137	A350	49H	\N
WW137	A350	49J	\N
WW137	A350	49K	\N
WW137	A350	5A	\N
WW137	A350	5C	\N
WW137	A350	5H	\N
WW137	A350	5K	\N
WW137	A350	50A	\N
WW137	A350	50B	\N
WW137	A350	50C	\N
WW137	A350	50D	\N
WW137	A350	50E	\N
WW137	A350	50G	\N
WW137	A350	50H	\N
WW137	A350	50J	\N
WW137	A350	50K	\N
WW137	A350	51A	\N
WW137	A350	51B	\N
WW137	A350	51C	\N
WW137	A350	51D	\N
WW137	A350	51H	\N
WW137	A350	51J	\N
WW137	A350	51K	\N
WW137	A350	52A	\N
WW137	A350	52B	\N
WW137	A350	52C	\N
WW137	A350	52D	\N
WW137	A350	52E	\N
WW137	A350	52G	\N
WW137	A350	52H	\N
WW137	A350	52J	\N
WW137	A350	52K	\N
WW137	A350	53A	\N
WW137	A350	53B	\N
WW137	A350	53C	\N
WW137	A350	53D	\N
WW137	A350	53E	\N
WW137	A350	53G	\N
WW137	A350	53H	\N
WW137	A350	53J	\N
WW137	A350	53K	\N
WW137	A350	54A	\N
WW137	A350	54B	\N
WW137	A350	54C	\N
WW137	A350	54D	\N
WW137	A350	54E	\N
WW137	A350	54G	\N
WW137	A350	54H	\N
WW137	A350	54J	\N
WW137	A350	54K	\N
WW137	A350	55A	\N
WW137	A350	55B	\N
WW137	A350	55C	\N
WW137	A350	55D	\N
WW137	A350	55E	\N
WW137	A350	55G	\N
WW137	A350	55H	\N
WW137	A350	55J	\N
WW137	A350	55K	\N
WW137	A350	56A	\N
WW137	A350	56B	\N
WW137	A350	56C	\N
WW137	A350	56D	\N
WW137	A350	56E	\N
WW137	A350	56G	\N
WW137	A350	56H	\N
WW137	A350	56J	\N
WW137	A350	56K	\N
WW137	A350	57A	\N
WW137	A350	57B	\N
WW137	A350	57C	\N
WW137	A350	57D	\N
WW137	A350	57E	\N
WW137	A350	57G	\N
WW137	A350	57H	\N
WW137	A350	57J	\N
WW137	A350	57K	\N
WW137	A350	58A	\N
WW137	A350	58B	\N
WW137	A350	58C	\N
WW137	A350	58D	\N
WW137	A350	58E	\N
WW137	A350	58G	\N
WW137	A350	58H	\N
WW137	A350	58J	\N
WW137	A350	58K	\N
WW137	A350	59A	\N
WW137	A350	59B	\N
WW137	A350	59C	\N
WW137	A350	59D	\N
WW137	A350	59E	\N
WW137	A350	59G	\N
WW137	A350	59H	\N
WW137	A350	59J	\N
VJ796	A350	1A	T736218
WW137	A350	59K	\N
WW137	A350	6A	\N
WW137	A350	6C	\N
WW137	A350	6D	\N
WW137	A350	6E	\N
WW137	A350	6F	\N
WW137	A350	6G	\N
WW137	A350	6H	\N
WW137	A350	6K	\N
WW137	A350	60A	\N
WW137	A350	60C	\N
WW137	A350	60D	\N
WW137	A350	60E	\N
WW137	A350	60G	\N
WW137	A350	61D	\N
WW137	A350	61E	\N
WW137	A350	61G	\N
WW137	A350	7A	\N
WW137	A350	7C	\N
WW137	A350	7D	\N
WW137	A350	7E	\N
WW137	A350	7F	\N
WW137	A350	7G	\N
WW137	A350	7H	\N
WW137	A350	7K	\N
WW137	A350	8A	\N
WW137	A350	8C	\N
WW137	A350	8D	\N
WW137	A350	8E	\N
WW137	A350	8F	\N
WW137	A350	8G	\N
WW137	A350	8H	\N
WW137	A350	8K	\N
WW137	A350	9A	\N
WW137	A350	9C	\N
WW137	A350	9D	\N
WW137	A350	9E	\N
WW137	A350	9F	\N
WW137	A350	9G	\N
WW137	A350	9H	\N
WW137	A350	9K	\N
PA645	A380	1A	\N
PA645	A380	1E	\N
PA645	A380	1F	\N
PA645	A380	1K	\N
PA645	A380	10B	\N
PA645	A380	10D	\N
PA645	A380	10G	\N
PA645	A380	10J	\N
PA645	A380	11A	\N
PA645	A380	11E	\N
PA645	A380	11F	\N
PA645	A380	11K	\N
PA645	A380	12B	\N
PA645	A380	12D	\N
PA645	A380	12G	\N
PA645	A380	12J	\N
PA645	A380	14A	\N
PA645	A380	14E	\N
PA645	A380	14F	\N
PA645	A380	14K	\N
PA645	A380	15B	\N
PA645	A380	15D	\N
PA645	A380	15G	\N
PA645	A380	15J	\N
PA645	A380	16A	\N
PA645	A380	16E	\N
PA645	A380	16F	\N
PA645	A380	16K	\N
PA645	A380	17B	\N
PA645	A380	17D	\N
PA645	A380	17G	\N
PA645	A380	17J	\N
PA645	A380	18A	\N
PA645	A380	18E	\N
PA645	A380	18F	\N
PA645	A380	18K	\N
PA645	A380	19B	\N
PA645	A380	19D	\N
PA645	A380	19G	\N
PA645	A380	19J	\N
PA645	A380	2A	\N
PA645	A380	2E	\N
PA645	A380	2F	\N
PA645	A380	2K	\N
PA645	A380	20A	\N
PA645	A380	20E	\N
PA645	A380	20F	\N
PA645	A380	20K	\N
PA645	A380	21B	\N
PA645	A380	21G	\N
PA645	A380	21J	\N
PA645	A380	22D	\N
PA645	A380	22G	\N
PA645	A380	23A	\N
PA645	A380	23E	\N
PA645	A380	23F	\N
PA645	A380	23K	\N
PA645	A380	24B	\N
PA645	A380	24D	\N
PA645	A380	24G	\N
PA645	A380	25A	\N
PA645	A380	25E	\N
PA645	A380	25F	\N
PA645	A380	25K	\N
PA645	A380	26B	\N
PA645	A380	26D	\N
PA645	A380	26G	\N
PA645	A380	26J	\N
PA645	A380	3A	\N
PA645	A380	3E	\N
PA645	A380	3F	\N
PA645	A380	3K	\N
PA645	A380	4A	\N
PA645	A380	4K	\N
PA645	A380	43A	\N
PA645	A380	43B	\N
PA645	A380	43C	\N
PA645	A380	43H	\N
PA645	A380	43J	\N
PA645	A380	43K	\N
PA645	A380	44A	\N
PA645	A380	44B	\N
PA645	A380	44C	\N
PA645	A380	44H	\N
PA645	A380	44J	\N
PA645	A380	44K	\N
PA645	A380	45A	\N
PA645	A380	45B	\N
PA645	A380	45C	\N
PA645	A380	45D	\N
PA645	A380	45E	\N
PA645	A380	45F	\N
PA645	A380	45G	\N
PA645	A380	45H	\N
PA645	A380	45J	\N
PA645	A380	45K	\N
PA645	A380	46A	\N
PA645	A380	46B	\N
PA645	A380	46C	\N
PA645	A380	46D	\N
PA645	A380	46E	\N
PA645	A380	46F	\N
PA645	A380	46G	\N
PA645	A380	46H	\N
PA645	A380	46J	\N
PA645	A380	46K	\N
PA645	A380	47A	\N
PA645	A380	47B	\N
PA645	A380	47C	\N
PA645	A380	47D	\N
PA645	A380	47E	\N
PA645	A380	47F	\N
PA645	A380	47G	\N
PA645	A380	47H	\N
PA645	A380	47J	\N
PA645	A380	47K	\N
PA645	A380	48A	\N
PA645	A380	48B	\N
PA645	A380	48C	\N
PA645	A380	48D	\N
PA645	A380	48E	\N
PA645	A380	48F	\N
PA645	A380	48G	\N
PA645	A380	48H	\N
PA645	A380	48J	\N
PA645	A380	48K	\N
PA645	A380	49A	\N
PA645	A380	49B	\N
PA645	A380	49C	\N
PA645	A380	49D	\N
PA645	A380	49E	\N
PA645	A380	49F	\N
PA645	A380	49G	\N
PA645	A380	49H	\N
PA645	A380	49J	\N
PA645	A380	49K	\N
PA645	A380	50A	\N
PA645	A380	50B	\N
PA645	A380	50C	\N
PA645	A380	50D	\N
PA645	A380	50E	\N
PA645	A380	50F	\N
PA645	A380	50G	\N
PA645	A380	50H	\N
PA645	A380	50J	\N
PA645	A380	50K	\N
PA645	A380	51D	\N
PA645	A380	51E	\N
PA645	A380	51F	\N
PA645	A380	51G	\N
PA645	A380	52A	\N
PA645	A380	52B	\N
PA645	A380	52C	\N
PA645	A380	52H	\N
PA645	A380	52J	\N
PA645	A380	52K	\N
PA645	A380	53A	\N
PA645	A380	53B	\N
PA645	A380	53C	\N
PA645	A380	53H	\N
PA645	A380	53J	\N
PA645	A380	53K	\N
PA645	A380	54A	\N
PA645	A380	54B	\N
PA645	A380	54C	\N
PA645	A380	54D	\N
PA645	A380	54E	\N
PA645	A380	54F	\N
PA645	A380	54G	\N
PA645	A380	54H	\N
PA645	A380	54J	\N
PA645	A380	54K	\N
PA645	A380	55A	\N
PA645	A380	55B	\N
PA645	A380	55C	\N
PA645	A380	55D	\N
PA645	A380	55E	\N
PA645	A380	55F	\N
PA645	A380	55G	\N
PA645	A380	55H	\N
PA645	A380	55J	\N
PA645	A380	55K	\N
PA645	A380	56A	\N
PA645	A380	56B	\N
PA645	A380	56C	\N
PA645	A380	56D	\N
PA645	A380	56E	\N
PA645	A380	56F	\N
PA645	A380	56G	\N
PA645	A380	56H	\N
PA645	A380	56J	\N
PA645	A380	56K	\N
PA645	A380	57A	\N
PA645	A380	57B	\N
PA645	A380	57C	\N
PA645	A380	57D	\N
PA645	A380	57E	\N
PA645	A380	57F	\N
PA645	A380	57G	\N
PA645	A380	57H	\N
PA645	A380	57J	\N
PA645	A380	57K	\N
PA645	A380	58A	\N
PA645	A380	58B	\N
PA645	A380	58C	\N
PA645	A380	58D	\N
PA645	A380	58E	\N
PA645	A380	58F	\N
PA645	A380	58G	\N
PA645	A380	58H	\N
PA645	A380	58J	\N
PA645	A380	58K	\N
PA645	A380	59A	\N
PA645	A380	59B	\N
PA645	A380	59C	\N
PA645	A380	59D	\N
PA645	A380	59E	\N
PA645	A380	59F	\N
PA645	A380	59G	\N
PA645	A380	59H	\N
PA645	A380	59J	\N
PA645	A380	59K	\N
PA645	A380	6D	\N
PA645	A380	6G	\N
PA645	A380	60A	\N
PA645	A380	60B	\N
PA645	A380	60C	\N
PA645	A380	60D	\N
PA645	A380	60E	\N
PA645	A380	60F	\N
PA645	A380	60G	\N
PA645	A380	60H	\N
PA645	A380	60J	\N
PA645	A380	60K	\N
PA645	A380	61A	\N
PA645	A380	61B	\N
PA645	A380	61C	\N
PA645	A380	61D	\N
PA645	A380	61E	\N
PA645	A380	61F	\N
PA645	A380	61G	\N
PA645	A380	61H	\N
PA645	A380	61J	\N
PA645	A380	61K	\N
PA645	A380	62A	\N
PA645	A380	62B	\N
PA645	A380	62C	\N
PA645	A380	62D	\N
PA645	A380	62E	\N
PA645	A380	62F	\N
PA645	A380	62G	\N
PA645	A380	62H	\N
PA645	A380	62J	\N
PA645	A380	62K	\N
PA645	A380	63A	\N
PA645	A380	63B	\N
PA645	A380	63C	\N
PA645	A380	63D	\N
PA645	A380	63E	\N
PA645	A380	63F	\N
PA645	A380	63G	\N
PA645	A380	63H	\N
PA645	A380	63J	\N
PA645	A380	63K	\N
PA645	A380	64A	\N
PA645	A380	64B	\N
PA645	A380	64C	\N
PA645	A380	64D	\N
PA645	A380	64E	\N
PA645	A380	64F	\N
PA645	A380	64G	\N
PA645	A380	64H	\N
PA645	A380	64J	\N
PA645	A380	64K	\N
PA645	A380	65A	\N
PA645	A380	65B	\N
PA645	A380	65C	\N
PA645	A380	65D	\N
PA645	A380	65E	\N
PA645	A380	65F	\N
PA645	A380	65G	\N
PA645	A380	65H	\N
PA645	A380	65J	\N
PA645	A380	65K	\N
PA645	A380	66H	\N
PA645	A380	66J	\N
PA645	A380	66K	\N
PA645	A380	67B	\N
PA645	A380	67C	\N
PA645	A380	67D	\N
PA645	A380	67E	\N
PA645	A380	67F	\N
PA645	A380	67G	\N
PA645	A380	67H	\N
PA645	A380	67J	\N
PA645	A380	68A	\N
PA645	A380	68B	\N
PA645	A380	68C	\N
PA645	A380	68D	\N
PA645	A380	68E	\N
PA645	A380	68F	\N
PA645	A380	68G	\N
PA645	A380	68H	\N
PA645	A380	68J	\N
PA645	A380	68K	\N
PA645	A380	69A	\N
PA645	A380	69B	\N
PA645	A380	69C	\N
PA645	A380	69D	\N
PA645	A380	69E	\N
PA645	A380	69F	\N
PA645	A380	69G	\N
PA645	A380	69H	\N
PA645	A380	69J	\N
PA645	A380	69K	\N
PA645	A380	7A	\N
PA645	A380	7E	\N
PA645	A380	7F	\N
PA645	A380	7K	\N
PA645	A380	70A	\N
PA645	A380	70B	\N
PA645	A380	70C	\N
PA645	A380	70D	\N
PA645	A380	70E	\N
PA645	A380	70F	\N
PA645	A380	70G	\N
PA645	A380	70H	\N
PA645	A380	70J	\N
PA645	A380	70K	\N
PA645	A380	82H	\N
PA645	A380	71A	\N
PA645	A380	71B	\N
PA645	A380	71C	\N
PA645	A380	71D	\N
PA645	A380	71E	\N
PA645	A380	71F	\N
PA645	A380	71G	\N
PA645	A380	71H	\N
PA645	A380	71J	\N
PA645	A380	71K	\N
PA645	A380	72A	\N
PA645	A380	72B	\N
PA645	A380	72C	\N
PA645	A380	72D	\N
PA645	A380	72E	\N
PA645	A380	72F	\N
PA645	A380	72G	\N
PA645	A380	72H	\N
PA645	A380	72J	\N
PA645	A380	72K	\N
PA645	A380	73A	\N
PA645	A380	73B	\N
PA645	A380	73C	\N
PA645	A380	73D	\N
PA645	A380	73E	\N
PA645	A380	73F	\N
PA645	A380	73G	\N
PA645	A380	73H	\N
PA645	A380	73J	\N
PA645	A380	73K	\N
PA645	A380	74A	\N
PA645	A380	74B	\N
PA645	A380	74C	\N
PA645	A380	74D	\N
PA645	A380	74E	\N
PA645	A380	74F	\N
PA645	A380	74G	\N
PA645	A380	74H	\N
PA645	A380	74J	\N
PA645	A380	74K	\N
PA645	A380	75A	\N
PA645	A380	75B	\N
PA645	A380	75C	\N
PA645	A380	75D	\N
PA645	A380	75E	\N
PA645	A380	75F	\N
PA645	A380	75G	\N
PA645	A380	75H	\N
PA645	A380	75J	\N
PA645	A380	75K	\N
PA645	A380	76A	\N
PA645	A380	76B	\N
PA645	A380	76C	\N
PA645	A380	76D	\N
PA645	A380	76E	\N
PA645	A380	76F	\N
PA645	A380	76G	\N
PA645	A380	76H	\N
PA645	A380	76J	\N
PA645	A380	76K	\N
PA645	A380	77A	\N
PA645	A380	77B	\N
PA645	A380	77C	\N
PA645	A380	77D	\N
PA645	A380	77E	\N
PA645	A380	77F	\N
PA645	A380	77G	\N
PA645	A380	77H	\N
PA645	A380	77J	\N
PA645	A380	77K	\N
PA645	A380	78A	\N
PA645	A380	78B	\N
PA645	A380	78C	\N
PA645	A380	78D	\N
PA645	A380	78E	\N
PA645	A380	78F	\N
PA645	A380	78G	\N
PA645	A380	78H	\N
PA645	A380	78J	\N
PA645	A380	78K	\N
PA645	A380	79A	\N
PA645	A380	79B	\N
PA645	A380	79C	\N
PA645	A380	79H	\N
PA645	A380	79J	\N
PA645	A380	79K	\N
PA645	A380	8B	\N
PA645	A380	8D	\N
PA645	A380	8G	\N
PA645	A380	8J	\N
PA645	A380	80B	\N
PA645	A380	80C	\N
PA645	A380	80H	\N
PA645	A380	80J	\N
PA645	A380	81A	\N
PA645	A380	81B	\N
PA645	A380	81C	\N
PA645	A380	81H	\N
PA645	A380	81J	\N
PA645	A380	81K	\N
PA645	A380	82A	\N
PA645	A380	82B	\N
PA645	A380	82C	\N
PA645	A380	82D	\N
PA645	A380	82E	\N
PA645	A380	82F	\N
PA645	A380	82G	\N
PA645	A380	82J	\N
PA645	A380	82K	\N
PA645	A380	83A	\N
PA645	A380	83B	\N
PA645	A380	83C	\N
PA645	A380	83D	\N
PA645	A380	83E	\N
PA645	A380	83F	\N
PA645	A380	83G	\N
PA645	A380	83H	\N
PA645	A380	83J	\N
PA645	A380	83K	\N
PA645	A380	84A	\N
PA645	A380	84B	\N
PA645	A380	84C	\N
PA645	A380	84D	\N
PA645	A380	84E	\N
PA645	A380	84F	\N
PA645	A380	84G	\N
PA645	A380	84H	\N
PA645	A380	84J	\N
PA645	A380	84K	\N
PA645	A380	85A	\N
PA645	A380	85B	\N
PA645	A380	85C	\N
PA645	A380	85H	\N
PA645	A380	85J	\N
PA645	A380	85K	\N
PA645	A380	86A	\N
PA645	A380	86B	\N
PA645	A380	86C	\N
PA645	A380	86H	\N
PA645	A380	86J	\N
PA645	A380	86K	\N
PA645	A380	87A	\N
PA645	A380	87B	\N
PA645	A380	87C	\N
PA645	A380	87H	\N
PA645	A380	87J	\N
PA645	A380	87K	\N
PA645	A380	88A	\N
PA645	A380	88B	\N
PA645	A380	88C	\N
PA645	A380	88H	\N
PA645	A380	88J	\N
PA645	A380	88K	\N
PA645	A380	9A	\N
PA645	A380	9E	\N
PA645	A380	9F	\N
PA645	A380	9K	\N
IT851	A380	1A	\N
IT851	A380	1E	\N
IT851	A380	1F	\N
IT851	A380	1K	\N
IT851	A380	10B	\N
IT851	A380	10D	\N
IT851	A380	10G	\N
IT851	A380	10J	\N
IT851	A380	11A	\N
IT851	A380	11E	\N
IT851	A380	11F	\N
IT851	A380	11K	\N
IT851	A380	12B	\N
IT851	A380	12D	\N
IT851	A380	12G	\N
IT851	A380	12J	\N
IT851	A380	14A	\N
IT851	A380	14E	\N
IT851	A380	14F	\N
IT851	A380	14K	\N
IT851	A380	15B	\N
IT851	A380	15D	\N
IT851	A380	15G	\N
IT851	A380	15J	\N
IT851	A380	16A	\N
IT851	A380	16E	\N
VJ796	A350	10D	T768650
IT851	A380	16F	\N
IT851	A380	16K	\N
IT851	A380	17B	\N
IT851	A380	17D	\N
IT851	A380	17G	\N
IT851	A380	17J	\N
IT851	A380	18A	\N
IT851	A380	18E	\N
IT851	A380	18F	\N
IT851	A380	18K	\N
IT851	A380	19B	\N
IT851	A380	19D	\N
IT851	A380	19G	\N
IT851	A380	19J	\N
IT851	A380	2A	\N
IT851	A380	2E	\N
IT851	A380	2F	\N
IT851	A380	2K	\N
IT851	A380	20E	\N
IT851	A380	20F	\N
IT851	A380	20K	\N
IT851	A380	21B	\N
IT851	A380	21D	\N
IT851	A380	21G	\N
IT851	A380	21J	\N
IT851	A380	22D	\N
IT851	A380	22G	\N
IT851	A380	23A	\N
IT851	A380	23E	\N
IT851	A380	23F	\N
IT851	A380	23K	\N
IT851	A380	24B	\N
IT851	A380	24D	\N
IT851	A380	24G	\N
IT851	A380	24J	\N
IT851	A380	25A	\N
IT851	A380	25E	\N
IT851	A380	25F	\N
IT851	A380	25K	\N
IT851	A380	26B	\N
IT851	A380	26D	\N
IT851	A380	26G	\N
IT851	A380	26J	\N
IT851	A380	3A	\N
IT851	A380	3E	\N
IT851	A380	3F	\N
IT851	A380	3K	\N
IT851	A380	4A	\N
IT851	A380	4K	\N
IT851	A380	43A	\N
IT851	A380	43B	\N
IT851	A380	43C	\N
IT851	A380	43H	\N
IT851	A380	43J	\N
IT851	A380	43K	\N
IT851	A380	44A	\N
IT851	A380	44B	\N
IT851	A380	44C	\N
IT851	A380	44H	\N
IT851	A380	44J	\N
IT851	A380	44K	\N
IT851	A380	45A	\N
IT851	A380	45B	\N
IT851	A380	45C	\N
IT851	A380	45D	\N
IT851	A380	45E	\N
IT851	A380	45F	\N
IT851	A380	45G	\N
IT851	A380	45H	\N
IT851	A380	45J	\N
IT851	A380	45K	\N
IT851	A380	46A	\N
IT851	A380	46B	\N
IT851	A380	46C	\N
IT851	A380	46D	\N
IT851	A380	46E	\N
IT851	A380	46F	\N
IT851	A380	46G	\N
IT851	A380	46H	\N
IT851	A380	46J	\N
IT851	A380	46K	\N
IT851	A380	47A	\N
IT851	A380	47B	\N
IT851	A380	47C	\N
IT851	A380	47D	\N
IT851	A380	47E	\N
IT851	A380	47F	\N
IT851	A380	47G	\N
IT851	A380	47H	\N
IT851	A380	47J	\N
IT851	A380	47K	\N
IT851	A380	48A	\N
IT851	A380	48B	\N
IT851	A380	48C	\N
IT851	A380	48D	\N
IT851	A380	48E	\N
IT851	A380	48F	\N
IT851	A380	48G	\N
IT851	A380	48H	\N
IT851	A380	48J	\N
IT851	A380	48K	\N
IT851	A380	49A	\N
IT851	A380	49B	\N
IT851	A380	49C	\N
IT851	A380	49D	\N
IT851	A380	49E	\N
IT851	A380	49F	\N
IT851	A380	49G	\N
IT851	A380	49H	\N
IT851	A380	49J	\N
IT851	A380	49K	\N
IT851	A380	50A	\N
IT851	A380	50B	\N
IT851	A380	50C	\N
IT851	A380	50D	\N
IT851	A380	50E	\N
IT851	A380	50F	\N
IT851	A380	50G	\N
IT851	A380	50H	\N
IT851	A380	50J	\N
IT851	A380	50K	\N
IT851	A380	51D	\N
IT851	A380	51E	\N
IT851	A380	51F	\N
IT851	A380	51G	\N
IT851	A380	52A	\N
IT851	A380	52B	\N
IT851	A380	52C	\N
IT851	A380	52H	\N
IT851	A380	52J	\N
IT851	A380	52K	\N
IT851	A380	53A	\N
IT851	A380	53B	\N
IT851	A380	53C	\N
IT851	A380	53H	\N
IT851	A380	53J	\N
IT851	A380	53K	\N
IT851	A380	54A	\N
IT851	A380	54B	\N
IT851	A380	54C	\N
IT851	A380	54D	\N
IT851	A380	54E	\N
IT851	A380	54F	\N
IT851	A380	54G	\N
IT851	A380	54H	\N
IT851	A380	54J	\N
IT851	A380	54K	\N
IT851	A380	55A	\N
IT851	A380	55B	\N
IT851	A380	55C	\N
IT851	A380	55D	\N
IT851	A380	55E	\N
IT851	A380	55F	\N
IT851	A380	55G	\N
IT851	A380	55H	\N
IT851	A380	55J	\N
IT851	A380	55K	\N
IT851	A380	56A	\N
IT851	A380	56B	\N
IT851	A380	56C	\N
IT851	A380	56D	\N
IT851	A380	56E	\N
IT851	A380	56F	\N
IT851	A380	56G	\N
IT851	A380	56H	\N
IT851	A380	56J	\N
IT851	A380	56K	\N
IT851	A380	57A	\N
IT851	A380	57B	\N
IT851	A380	57C	\N
IT851	A380	57D	\N
IT851	A380	57E	\N
IT851	A380	57F	\N
IT851	A380	57G	\N
IT851	A380	57H	\N
IT851	A380	57J	\N
IT851	A380	57K	\N
IT851	A380	58A	\N
IT851	A380	58B	\N
IT851	A380	58C	\N
IT851	A380	58D	\N
IT851	A380	58E	\N
IT851	A380	58F	\N
IT851	A380	58G	\N
IT851	A380	58H	\N
IT851	A380	58J	\N
IT851	A380	58K	\N
IT851	A380	59A	\N
IT851	A380	59B	\N
IT851	A380	59C	\N
IT851	A380	59D	\N
IT851	A380	59E	\N
IT851	A380	59F	\N
IT851	A380	59G	\N
IT851	A380	59H	\N
IT851	A380	59J	\N
IT851	A380	59K	\N
IT851	A380	6D	\N
IT851	A380	6G	\N
IT851	A380	60A	\N
IT851	A380	60B	\N
IT851	A380	60C	\N
IT851	A380	60D	\N
IT851	A380	60E	\N
IT851	A380	60F	\N
IT851	A380	60G	\N
IT851	A380	60H	\N
IT851	A380	60J	\N
IT851	A380	60K	\N
IT851	A380	61A	\N
IT851	A380	61B	\N
IT851	A380	61C	\N
IT851	A380	61D	\N
IT851	A380	61E	\N
IT851	A380	61F	\N
IT851	A380	61G	\N
IT851	A380	61H	\N
IT851	A380	61J	\N
IT851	A380	61K	\N
IT851	A380	62A	\N
IT851	A380	62B	\N
IT851	A380	62C	\N
IT851	A380	62D	\N
IT851	A380	62E	\N
IT851	A380	62F	\N
IT851	A380	62G	\N
IT851	A380	62H	\N
IT851	A380	62J	\N
IT851	A380	62K	\N
IT851	A380	63A	\N
IT851	A380	63B	\N
IT851	A380	63C	\N
IT851	A380	63D	\N
IT851	A380	63E	\N
IT851	A380	63F	\N
IT851	A380	63G	\N
IT851	A380	63H	\N
IT851	A380	63J	\N
IT851	A380	63K	\N
IT851	A380	64A	\N
IT851	A380	64B	\N
IT851	A380	64C	\N
IT851	A380	64D	\N
IT851	A380	64E	\N
IT851	A380	64F	\N
IT851	A380	64G	\N
IT851	A380	64H	\N
IT851	A380	64J	\N
IT851	A380	64K	\N
IT851	A380	65A	\N
IT851	A380	65B	\N
IT851	A380	65C	\N
IT851	A380	65D	\N
IT851	A380	65E	\N
IT851	A380	65F	\N
IT851	A380	65G	\N
IT851	A380	65H	\N
IT851	A380	65J	\N
IT851	A380	65K	\N
IT851	A380	66H	\N
IT851	A380	66J	\N
IT851	A380	66K	\N
IT851	A380	67B	\N
IT851	A380	67C	\N
IT851	A380	67D	\N
IT851	A380	67E	\N
IT851	A380	67F	\N
IT851	A380	67G	\N
IT851	A380	67H	\N
IT851	A380	67J	\N
IT851	A380	68A	\N
IT851	A380	68B	\N
IT851	A380	68C	\N
IT851	A380	68D	\N
IT851	A380	68E	\N
IT851	A380	68F	\N
IT851	A380	68G	\N
IT851	A380	68H	\N
IT851	A380	68J	\N
IT851	A380	68K	\N
IT851	A380	69A	\N
IT851	A380	69B	\N
IT851	A380	69C	\N
IT851	A380	69D	\N
IT851	A380	69E	\N
IT851	A380	69F	\N
IT851	A380	69G	\N
IT851	A380	69H	\N
IT851	A380	69J	\N
IT851	A380	69K	\N
IT851	A380	7A	\N
IT851	A380	7E	\N
IT851	A380	7F	\N
IT851	A380	7K	\N
IT851	A380	70A	\N
IT851	A380	70B	\N
IT851	A380	70C	\N
IT851	A380	70D	\N
IT851	A380	70E	\N
IT851	A380	70F	\N
IT851	A380	70G	\N
IT851	A380	70H	\N
IT851	A380	70J	\N
IT851	A380	70K	\N
IT851	A380	71A	\N
IT851	A380	71B	\N
IT851	A380	71C	\N
IT851	A380	71D	\N
IT851	A380	71E	\N
IT851	A380	71F	\N
IT851	A380	71G	\N
IT851	A380	71H	\N
IT851	A380	71J	\N
IT851	A380	71K	\N
IT851	A380	72A	\N
IT851	A380	72B	\N
IT851	A380	72C	\N
IT851	A380	72D	\N
IT851	A380	72E	\N
IT851	A380	72F	\N
IT851	A380	72G	\N
IT851	A380	72H	\N
IT851	A380	72J	\N
IT851	A380	72K	\N
IT851	A380	73A	\N
IT851	A380	73B	\N
IT851	A380	73C	\N
IT851	A380	73D	\N
IT851	A380	73E	\N
IT851	A380	73F	\N
IT851	A380	73G	\N
IT851	A380	73H	\N
IT851	A380	73J	\N
IT851	A380	73K	\N
IT851	A380	74A	\N
IT851	A380	74B	\N
IT851	A380	74C	\N
IT851	A380	74D	\N
IT851	A380	74E	\N
IT851	A380	74F	\N
IT851	A380	74G	\N
IT851	A380	74H	\N
IT851	A380	74J	\N
IT851	A380	74K	\N
IT851	A380	75A	\N
IT851	A380	75B	\N
IT851	A380	75C	\N
IT851	A380	75D	\N
IT851	A380	75E	\N
IT851	A380	75F	\N
IT851	A380	75G	\N
IT851	A380	75H	\N
IT851	A380	75J	\N
IT851	A380	75K	\N
IT851	A380	76A	\N
IT851	A380	76B	\N
IT851	A380	76C	\N
IT851	A380	76D	\N
IT851	A380	76E	\N
IT851	A380	76F	\N
IT851	A380	76G	\N
IT851	A380	76H	\N
IT851	A380	76J	\N
IT851	A380	76K	\N
IT851	A380	77A	\N
IT851	A380	77B	\N
IT851	A380	77C	\N
IT851	A380	77D	\N
IT851	A380	77E	\N
IT851	A380	77F	\N
IT851	A380	77G	\N
IT851	A380	77H	\N
IT851	A380	77J	\N
IT851	A380	77K	\N
IT851	A380	78A	\N
IT851	A380	78B	\N
IT851	A380	78C	\N
IT851	A380	78D	\N
IT851	A380	78E	\N
IT851	A380	78F	\N
IT851	A380	78G	\N
IT851	A380	78H	\N
IT851	A380	78J	\N
IT851	A380	78K	\N
IT851	A380	79A	\N
IT851	A380	79B	\N
IT851	A380	79C	\N
IT851	A380	79H	\N
IT851	A380	79J	\N
IT851	A380	79K	\N
IT851	A380	8B	\N
IT851	A380	8D	\N
IT851	A380	8G	\N
IT851	A380	8J	\N
IT851	A380	80B	\N
IT851	A380	80C	\N
IT851	A380	80H	\N
IT851	A380	80J	\N
IT851	A380	81A	\N
IT851	A380	81B	\N
IT851	A380	81C	\N
IT851	A380	81H	\N
IT851	A380	81J	\N
IT851	A380	81K	\N
IT851	A380	82A	\N
IT851	A380	82B	\N
IT851	A380	82C	\N
IT851	A380	82D	\N
IT851	A380	82E	\N
IT851	A380	82F	\N
IT851	A380	82G	\N
IT851	A380	82H	\N
IT851	A380	82J	\N
IT851	A380	82K	\N
IT851	A380	83A	\N
IT851	A380	83B	\N
IT851	A380	83C	\N
IT851	A380	83D	\N
IT851	A380	83E	\N
IT851	A380	83F	\N
IT851	A380	83G	\N
IT851	A380	83H	\N
IT851	A380	83J	\N
IT851	A380	83K	\N
IT851	A380	84A	\N
IT851	A380	84B	\N
IT851	A380	84C	\N
IT851	A380	84D	\N
IT851	A380	84E	\N
IT851	A380	84F	\N
IT851	A380	84G	\N
IT851	A380	84H	\N
IT851	A380	84J	\N
IT851	A380	84K	\N
IT851	A380	85A	\N
IT851	A380	85B	\N
IT851	A380	85C	\N
IT851	A380	85H	\N
IT851	A380	85J	\N
IT851	A380	85K	\N
IT851	A380	86A	\N
IT851	A380	86B	\N
IT851	A380	86C	\N
IT851	A380	86H	\N
IT851	A380	86J	\N
IT851	A380	86K	\N
IT851	A380	87A	\N
IT851	A380	87B	\N
IT851	A380	87C	\N
IT851	A380	87H	\N
IT851	A380	87J	\N
IT851	A380	87K	\N
IT851	A380	88A	\N
IT851	A380	88B	\N
IT851	A380	88C	\N
IT851	A380	88H	\N
IT851	A380	88J	\N
IT851	A380	88K	\N
IT851	A380	9A	\N
IT851	A380	9E	\N
IT851	A380	9F	\N
IT851	A380	9K	\N
XK135	A350	1A	\N
XK135	A350	1C	\N
XK135	A350	1D	\N
XK135	A350	1G	\N
XK135	A350	1H	\N
XK135	A350	1K	\N
XK135	A350	10A	\N
XK135	A350	10C	\N
XK135	A350	10D	\N
XK135	A350	10E	\N
XK135	A350	10F	\N
XK135	A350	10G	\N
XK135	A350	10H	\N
XK135	A350	10K	\N
XK135	A350	11A	\N
XK135	A350	11C	\N
XK135	A350	11D	\N
XK135	A350	11E	\N
XK135	A350	11F	\N
XK135	A350	11G	\N
XK135	A350	11H	\N
XK135	A350	11K	\N
XK135	A350	12D	\N
XK135	A350	12E	\N
XK135	A350	12F	\N
XK135	A350	12G	\N
XK135	A350	15D	\N
XK135	A350	15E	\N
XK135	A350	15F	\N
XK135	A350	15G	\N
XK135	A350	15H	\N
XK135	A350	15K	\N
XK135	A350	16A	\N
XK135	A350	16C	\N
XK135	A350	16D	\N
XK135	A350	16E	\N
XK135	A350	16F	\N
XK135	A350	16G	\N
XK135	A350	16H	\N
XK135	A350	16K	\N
XK135	A350	17A	\N
XK135	A350	17C	\N
XK135	A350	17D	\N
XK135	A350	17E	\N
XK135	A350	17F	\N
XK135	A350	17G	\N
XK135	A350	17H	\N
XK135	A350	17K	\N
XK135	A350	18A	\N
XK135	A350	18C	\N
XK135	A350	18D	\N
XK135	A350	18E	\N
XK135	A350	18F	\N
XK135	A350	18G	\N
XK135	A350	18H	\N
XK135	A350	18K	\N
XK135	A350	19A	\N
XK135	A350	19C	\N
XK135	A350	19D	\N
XK135	A350	19E	\N
XK135	A350	19F	\N
XK135	A350	19G	\N
XK135	A350	19H	\N
XK135	A350	19K	\N
XK135	A350	2A	\N
XK135	A350	2C	\N
XK135	A350	2D	\N
XK135	A350	2G	\N
XK135	A350	2H	\N
XK135	A350	2K	\N
XK135	A350	27A	\N
XK135	A350	27B	\N
XK135	A350	27C	\N
XK135	A350	27D	\N
XK135	A350	27E	\N
XK135	A350	27G	\N
XK135	A350	27H	\N
XK135	A350	27J	\N
XK135	A350	27K	\N
XK135	A350	28A	\N
XK135	A350	28B	\N
XK135	A350	28C	\N
XK135	A350	28D	\N
XK135	A350	28E	\N
XK135	A350	28G	\N
XK135	A350	28H	\N
XK135	A350	28J	\N
XK135	A350	28K	\N
XK135	A350	29A	\N
XK135	A350	29B	\N
XK135	A350	29C	\N
XK135	A350	29D	\N
XK135	A350	29E	\N
XK135	A350	29G	\N
XK135	A350	29H	\N
XK135	A350	29J	\N
XK135	A350	29K	\N
XK135	A350	30A	\N
XK135	A350	30B	\N
XK135	A350	30C	\N
XK135	A350	30D	\N
XK135	A350	30E	\N
XK135	A350	30G	\N
XK135	A350	30H	\N
XK135	A350	30J	\N
XK135	A350	30K	\N
XK135	A350	31A	\N
XK135	A350	31B	\N
XK135	A350	31C	\N
XK135	A350	31D	\N
XK135	A350	31E	\N
XK135	A350	31G	\N
XK135	A350	31H	\N
XK135	A350	31J	\N
XK135	A350	31K	\N
XK135	A350	32A	\N
XK135	A350	32B	\N
XK135	A350	32C	\N
XK135	A350	32D	\N
XK135	A350	32E	\N
XK135	A350	32G	\N
XK135	A350	32H	\N
XK135	A350	32J	\N
XK135	A350	32K	\N
XK135	A350	33A	\N
XK135	A350	33B	\N
XK135	A350	33C	\N
XK135	A350	33D	\N
XK135	A350	33E	\N
XK135	A350	33G	\N
XK135	A350	33H	\N
XK135	A350	33J	\N
XK135	A350	33K	\N
XK135	A350	34A	\N
XK135	A350	34B	\N
XK135	A350	34C	\N
XK135	A350	34D	\N
XK135	A350	34E	\N
XK135	A350	34G	\N
XK135	A350	34H	\N
XK135	A350	34J	\N
XK135	A350	34K	\N
XK135	A350	35A	\N
XK135	A350	35B	\N
XK135	A350	35C	\N
XK135	A350	35D	\N
XK135	A350	35E	\N
XK135	A350	35G	\N
XK135	A350	35H	\N
XK135	A350	35J	\N
XK135	A350	35K	\N
XK135	A350	36A	\N
XK135	A350	36B	\N
XK135	A350	36C	\N
XK135	A350	36D	\N
XK135	A350	36E	\N
XK135	A350	36G	\N
XK135	A350	36H	\N
XK135	A350	36J	\N
XK135	A350	36K	\N
XK135	A350	37A	\N
XK135	A350	37B	\N
XK135	A350	37C	\N
XK135	A350	37D	\N
XK135	A350	37E	\N
XK135	A350	37G	\N
XK135	A350	37H	\N
XK135	A350	37J	\N
XK135	A350	37K	\N
XK135	A350	38A	\N
XK135	A350	38B	\N
XK135	A350	38C	\N
XK135	A350	38D	\N
XK135	A350	38E	\N
XK135	A350	38G	\N
XK135	A350	38H	\N
XK135	A350	38J	\N
XK135	A350	38K	\N
XK135	A350	39A	\N
XK135	A350	39B	\N
XK135	A350	39C	\N
XK135	A350	39D	\N
XK135	A350	39E	\N
XK135	A350	39G	\N
XK135	A350	39H	\N
XK135	A350	39J	\N
XK135	A350	39K	\N
XK135	A350	40D	\N
XK135	A350	40E	\N
XK135	A350	40G	\N
XK135	A350	45A	\N
XK135	A350	45B	\N
XK135	A350	45C	\N
XK135	A350	45D	\N
XK135	A350	45E	\N
XK135	A350	45G	\N
XK135	A350	45H	\N
XK135	A350	45J	\N
XK135	A350	45K	\N
XK135	A350	46A	\N
XK135	A350	46B	\N
XK135	A350	46C	\N
XK135	A350	46D	\N
XK135	A350	46E	\N
XK135	A350	46G	\N
XK135	A350	46H	\N
XK135	A350	46J	\N
XK135	A350	46K	\N
XK135	A350	47A	\N
XK135	A350	47B	\N
XK135	A350	47C	\N
XK135	A350	47D	\N
XK135	A350	47E	\N
XK135	A350	47G	\N
XK135	A350	47H	\N
XK135	A350	47J	\N
XK135	A350	47K	\N
XK135	A350	48A	\N
XK135	A350	48B	\N
XK135	A350	48C	\N
XK135	A350	48D	\N
XK135	A350	48E	\N
XK135	A350	48G	\N
XK135	A350	48H	\N
XK135	A350	48J	\N
XK135	A350	48K	\N
XK135	A350	49A	\N
XK135	A350	49B	\N
XK135	A350	49C	\N
XK135	A350	49D	\N
XK135	A350	49E	\N
XK135	A350	49G	\N
XK135	A350	49H	\N
XK135	A350	49J	\N
XK135	A350	49K	\N
XK135	A350	5A	\N
XK135	A350	5C	\N
XK135	A350	5H	\N
XK135	A350	5K	\N
XK135	A350	50A	\N
XK135	A350	50B	\N
XK135	A350	50C	\N
XK135	A350	50D	\N
XK135	A350	50E	\N
XK135	A350	50G	\N
XK135	A350	50H	\N
XK135	A350	50J	\N
XK135	A350	50K	\N
XK135	A350	51A	\N
XK135	A350	51B	\N
XK135	A350	51C	\N
XK135	A350	51D	\N
XK135	A350	51E	\N
XK135	A350	51G	\N
XK135	A350	51H	\N
XK135	A350	51J	\N
XK135	A350	51K	\N
XK135	A350	52A	\N
XK135	A350	52B	\N
XK135	A350	52C	\N
XK135	A350	52D	\N
XK135	A350	52E	\N
XK135	A350	52G	\N
XK135	A350	52H	\N
XK135	A350	52J	\N
XK135	A350	52K	\N
XK135	A350	53A	\N
XK135	A350	53B	\N
XK135	A350	53C	\N
XK135	A350	53D	\N
XK135	A350	53E	\N
XK135	A350	53G	\N
XK135	A350	53H	\N
XK135	A350	53J	\N
XK135	A350	53K	\N
XK135	A350	54A	\N
XK135	A350	54B	\N
XK135	A350	54C	\N
XK135	A350	54D	\N
XK135	A350	54E	\N
XK135	A350	54G	\N
XK135	A350	54H	\N
XK135	A350	54J	\N
XK135	A350	54K	\N
XK135	A350	55A	\N
XK135	A350	55B	\N
XK135	A350	55C	\N
XK135	A350	55D	\N
XK135	A350	55E	\N
XK135	A350	55G	\N
XK135	A350	55H	\N
XK135	A350	55J	\N
XK135	A350	55K	\N
XK135	A350	56A	\N
XK135	A350	56B	\N
XK135	A350	56C	\N
XK135	A350	56D	\N
XK135	A350	56E	\N
XK135	A350	56G	\N
XK135	A350	56H	\N
XK135	A350	56J	\N
XK135	A350	56K	\N
XK135	A350	57A	\N
XK135	A350	57B	\N
XK135	A350	57C	\N
XK135	A350	57D	\N
XK135	A350	57E	\N
XK135	A350	57G	\N
XK135	A350	57H	\N
XK135	A350	57J	\N
XK135	A350	57K	\N
XK135	A350	58A	\N
XK135	A350	58B	\N
XK135	A350	58C	\N
XK135	A350	58D	\N
XK135	A350	58E	\N
XK135	A350	58G	\N
XK135	A350	58H	\N
XK135	A350	58J	\N
XK135	A350	58K	\N
XK135	A350	59A	\N
XK135	A350	59B	\N
XK135	A350	59C	\N
XK135	A350	59D	\N
XK135	A350	59E	\N
XK135	A350	59G	\N
XK135	A350	59H	\N
XK135	A350	59J	\N
XK135	A350	59K	\N
XK135	A350	6A	\N
XK135	A350	6C	\N
XK135	A350	6D	\N
XK135	A350	6E	\N
XK135	A350	6F	\N
XK135	A350	6G	\N
XK135	A350	6H	\N
XK135	A350	6K	\N
XK135	A350	60A	\N
XK135	A350	60C	\N
XK135	A350	60D	\N
XK135	A350	60E	\N
XK135	A350	60G	\N
XK135	A350	61D	\N
XK135	A350	61E	\N
XK135	A350	61G	\N
XK135	A350	7A	\N
XK135	A350	7C	\N
XK135	A350	7D	\N
XK135	A350	7E	\N
XK135	A350	7F	\N
XK135	A350	7G	\N
XK135	A350	7H	\N
XK135	A350	7K	\N
XK135	A350	8A	\N
XK135	A350	8C	\N
XK135	A350	8D	\N
XK135	A350	8E	\N
XK135	A350	8F	\N
XK135	A350	8G	\N
XK135	A350	8H	\N
XK135	A350	8K	\N
XK135	A350	9A	\N
XK135	A350	9C	\N
XK135	A350	9D	\N
XK135	A350	9E	\N
XK135	A350	9F	\N
XK135	A350	9G	\N
XK135	A350	9H	\N
XK135	A350	9K	\N
YY762	A350	1A	\N
YY762	A350	1C	\N
YY762	A350	1D	\N
YY762	A350	1G	\N
YY762	A350	1H	\N
YY762	A350	1K	\N
YY762	A350	10A	\N
YY762	A350	10C	\N
YY762	A350	10D	\N
YY762	A350	10E	\N
YY762	A350	10F	\N
YY762	A350	10G	\N
YY762	A350	10H	\N
YY762	A350	10K	\N
YY762	A350	11A	\N
YY762	A350	11C	\N
YY762	A350	11D	\N
YY762	A350	11E	\N
YY762	A350	11F	\N
YY762	A350	11G	\N
YY762	A350	11H	\N
YY762	A350	11K	\N
YY762	A350	12D	\N
YY762	A350	12E	\N
YY762	A350	12F	\N
YY762	A350	12G	\N
YY762	A350	15D	\N
YY762	A350	15E	\N
YY762	A350	15F	\N
YY762	A350	15G	\N
YY762	A350	15H	\N
YY762	A350	15K	\N
YY762	A350	16A	\N
YY762	A350	16C	\N
YY762	A350	16D	\N
YY762	A350	16E	\N
YY762	A350	16F	\N
YY762	A350	16G	\N
YY762	A350	16H	\N
YY762	A350	16K	\N
YY762	A350	17A	\N
YY762	A350	17C	\N
YY762	A350	17D	\N
YY762	A350	17E	\N
YY762	A350	17F	\N
YY762	A350	17G	\N
YY762	A350	17H	\N
YY762	A350	17K	\N
YY762	A350	18A	\N
YY762	A350	18C	\N
YY762	A350	18D	\N
YY762	A350	18E	\N
YY762	A350	18F	\N
YY762	A350	18G	\N
YY762	A350	18H	\N
YY762	A350	18K	\N
YY762	A350	19A	\N
YY762	A350	19C	\N
YY762	A350	19D	\N
YY762	A350	19E	\N
YY762	A350	19F	\N
YY762	A350	19G	\N
YY762	A350	19H	\N
YY762	A350	19K	\N
YY762	A350	2A	\N
YY762	A350	2C	\N
YY762	A350	2D	\N
YY762	A350	2G	\N
YY762	A350	2H	\N
YY762	A350	2K	\N
YY762	A350	27A	\N
YY762	A350	27B	\N
YY762	A350	27C	\N
YY762	A350	27D	\N
YY762	A350	27E	\N
YY762	A350	27G	\N
YY762	A350	27H	\N
YY762	A350	27J	\N
YY762	A350	27K	\N
YY762	A350	28A	\N
YY762	A350	28B	\N
YY762	A350	28C	\N
YY762	A350	28D	\N
YY762	A350	28E	\N
YY762	A350	28G	\N
YY762	A350	28H	\N
YY762	A350	28J	\N
YY762	A350	28K	\N
YY762	A350	29A	\N
YY762	A350	29B	\N
YY762	A350	29C	\N
YY762	A350	29D	\N
YY762	A350	29E	\N
YY762	A350	29G	\N
YY762	A350	29H	\N
YY762	A350	29J	\N
YY762	A350	29K	\N
YY762	A350	30A	\N
YY762	A350	30B	\N
YY762	A350	30C	\N
YY762	A350	30D	\N
YY762	A350	30E	\N
YY762	A350	30G	\N
YY762	A350	30H	\N
YY762	A350	30J	\N
YY762	A350	30K	\N
YY762	A350	31A	\N
YY762	A350	31B	\N
YY762	A350	31C	\N
YY762	A350	31D	\N
YY762	A350	31E	\N
YY762	A350	31G	\N
YY762	A350	31H	\N
YY762	A350	31J	\N
YY762	A350	31K	\N
YY762	A350	32A	\N
YY762	A350	32B	\N
YY762	A350	32C	\N
YY762	A350	32D	\N
YY762	A350	32E	\N
YY762	A350	32G	\N
YY762	A350	32H	\N
YY762	A350	32J	\N
YY762	A350	32K	\N
YY762	A350	33A	\N
YY762	A350	33B	\N
YY762	A350	33C	\N
YY762	A350	33D	\N
YY762	A350	33E	\N
YY762	A350	33G	\N
YY762	A350	33H	\N
YY762	A350	33J	\N
YY762	A350	33K	\N
YY762	A350	34A	\N
YY762	A350	34B	\N
YY762	A350	34C	\N
YY762	A350	34D	\N
YY762	A350	34E	\N
YY762	A350	34G	\N
YY762	A350	34H	\N
YY762	A350	34J	\N
YY762	A350	34K	\N
YY762	A350	35A	\N
YY762	A350	35B	\N
YY762	A350	35C	\N
YY762	A350	35D	\N
YY762	A350	35E	\N
YY762	A350	35G	\N
YY762	A350	35H	\N
YY762	A350	35J	\N
YY762	A350	35K	\N
YY762	A350	36A	\N
YY762	A350	36B	\N
YY762	A350	36C	\N
YY762	A350	36D	\N
YY762	A350	36E	\N
YY762	A350	36G	\N
YY762	A350	36H	\N
YY762	A350	36J	\N
YY762	A350	36K	\N
YY762	A350	37A	\N
YY762	A350	37B	\N
YY762	A350	37C	\N
YY762	A350	37D	\N
YY762	A350	37E	\N
YY762	A350	37G	\N
YY762	A350	37H	\N
YY762	A350	37J	\N
YY762	A350	37K	\N
YY762	A350	38A	\N
YY762	A350	38B	\N
YY762	A350	38C	\N
YY762	A350	38D	\N
YY762	A350	38E	\N
YY762	A350	38G	\N
YY762	A350	38H	\N
YY762	A350	38J	\N
YY762	A350	38K	\N
YY762	A350	39A	\N
YY762	A350	39B	\N
YY762	A350	39C	\N
YY762	A350	39D	\N
YY762	A350	39E	\N
YY762	A350	39G	\N
YY762	A350	39H	\N
YY762	A350	39J	\N
YY762	A350	39K	\N
YY762	A350	40D	\N
YY762	A350	40E	\N
YY762	A350	40G	\N
YY762	A350	45A	\N
YY762	A350	45B	\N
YY762	A350	45C	\N
YY762	A350	45D	\N
YY762	A350	45E	\N
YY762	A350	45G	\N
YY762	A350	45H	\N
YY762	A350	45J	\N
YY762	A350	45K	\N
YY762	A350	46A	\N
YY762	A350	46B	\N
YY762	A350	46C	\N
YY762	A350	46D	\N
YY762	A350	46E	\N
YY762	A350	46G	\N
YY762	A350	46H	\N
YY762	A350	46J	\N
YY762	A350	46K	\N
YY762	A350	47A	\N
YY762	A350	47B	\N
YY762	A350	47C	\N
YY762	A350	47D	\N
YY762	A350	47E	\N
YY762	A350	47G	\N
YY762	A350	47H	\N
YY762	A350	47J	\N
YY762	A350	47K	\N
YY762	A350	48A	\N
YY762	A350	48B	\N
YY762	A350	48C	\N
YY762	A350	48D	\N
YY762	A350	48E	\N
YY762	A350	48G	\N
YY762	A350	48H	\N
YY762	A350	48J	\N
YY762	A350	48K	\N
YY762	A350	49A	\N
YY762	A350	49B	\N
YY762	A350	49C	\N
YY762	A350	49D	\N
YY762	A350	49E	\N
YY762	A350	49G	\N
YY762	A350	49H	\N
YY762	A350	49J	\N
YY762	A350	49K	\N
YY762	A350	5A	\N
YY762	A350	5C	\N
YY762	A350	5H	\N
YY762	A350	5K	\N
YY762	A350	50A	\N
YY762	A350	50B	\N
YY762	A350	50C	\N
YY762	A350	50D	\N
YY762	A350	50E	\N
YY762	A350	50G	\N
YY762	A350	50H	\N
YY762	A350	50J	\N
YY762	A350	50K	\N
YY762	A350	51A	\N
YY762	A350	51B	\N
YY762	A350	51C	\N
YY762	A350	51D	\N
YY762	A350	51E	\N
YY762	A350	51G	\N
YY762	A350	51H	\N
YY762	A350	51J	\N
YY762	A350	51K	\N
YY762	A350	52A	\N
YY762	A350	52B	\N
YY762	A350	52C	\N
YY762	A350	52D	\N
YY762	A350	52E	\N
YY762	A350	52G	\N
YY762	A350	52H	\N
YY762	A350	52J	\N
YY762	A350	52K	\N
YY762	A350	53A	\N
YY762	A350	53B	\N
YY762	A350	53C	\N
YY762	A350	53D	\N
YY762	A350	53E	\N
YY762	A350	53G	\N
YY762	A350	53H	\N
YY762	A350	53J	\N
YY762	A350	53K	\N
YY762	A350	54A	\N
YY762	A350	54B	\N
YY762	A350	54C	\N
YY762	A350	54D	\N
VP730	A380	14E	\N
YY762	A350	54E	\N
YY762	A350	54G	\N
YY762	A350	54H	\N
YY762	A350	54J	\N
YY762	A350	54K	\N
YY762	A350	55A	\N
YY762	A350	55B	\N
YY762	A350	55C	\N
YY762	A350	55D	\N
YY762	A350	55E	\N
YY762	A350	55G	\N
YY762	A350	55H	\N
YY762	A350	55J	\N
YY762	A350	55K	\N
YY762	A350	56A	\N
YY762	A350	56B	\N
YY762	A350	56C	\N
YY762	A350	56D	\N
YY762	A350	56E	\N
YY762	A350	56G	\N
YY762	A350	56H	\N
YY762	A350	56J	\N
YY762	A350	56K	\N
YY762	A350	57A	\N
YY762	A350	57B	\N
YY762	A350	57C	\N
YY762	A350	57D	\N
YY762	A350	57E	\N
YY762	A350	57G	\N
YY762	A350	57H	\N
YY762	A350	57J	\N
YY762	A350	57K	\N
YY762	A350	58A	\N
YY762	A350	58B	\N
YY762	A350	58C	\N
YY762	A350	58D	\N
YY762	A350	58E	\N
YY762	A350	58G	\N
YY762	A350	58H	\N
YY762	A350	58J	\N
YY762	A350	58K	\N
YY762	A350	59A	\N
YY762	A350	59B	\N
YY762	A350	59C	\N
YY762	A350	59D	\N
YY762	A350	59E	\N
YY762	A350	59G	\N
YY762	A350	59H	\N
YY762	A350	59J	\N
YY762	A350	59K	\N
YY762	A350	6A	\N
YY762	A350	6C	\N
YY762	A350	6D	\N
YY762	A350	6E	\N
YY762	A350	6F	\N
YY762	A350	6G	\N
YY762	A350	6H	\N
YY762	A350	6K	\N
YY762	A350	60A	\N
YY762	A350	60C	\N
YY762	A350	60D	\N
YY762	A350	60E	\N
YY762	A350	60G	\N
YY762	A350	61D	\N
YY762	A350	61E	\N
YY762	A350	61G	\N
YY762	A350	7A	\N
YY762	A350	7C	\N
YY762	A350	7D	\N
YY762	A350	7E	\N
YY762	A350	7F	\N
YY762	A350	7G	\N
YY762	A350	7H	\N
YY762	A350	7K	\N
YY762	A350	8A	\N
YY762	A350	8C	\N
YY762	A350	8D	\N
YY762	A350	8E	\N
YY762	A350	8F	\N
YY762	A350	8G	\N
YY762	A350	8H	\N
YY762	A350	8K	\N
YY762	A350	9A	\N
YY762	A350	9C	\N
YY762	A350	9D	\N
YY762	A350	9E	\N
YY762	A350	9F	\N
YY762	A350	9G	\N
YY762	A350	9H	\N
YY762	A350	9K	\N
VP730	A380	1A	\N
VP730	A380	1E	\N
VP730	A380	1F	\N
VP730	A380	1K	\N
VP730	A380	10B	\N
VP730	A380	10D	\N
VP730	A380	10G	\N
VP730	A380	10J	\N
VP730	A380	11A	\N
VP730	A380	11E	\N
VP730	A380	11F	\N
VP730	A380	11K	\N
VP730	A380	12B	\N
VP730	A380	12D	\N
VP730	A380	12G	\N
VP730	A380	12J	\N
VP730	A380	14A	\N
VP730	A380	14F	\N
VP730	A380	14K	\N
VP730	A380	15B	\N
VP730	A380	15D	\N
VP730	A380	15G	\N
VP730	A380	15J	\N
VP730	A380	16A	\N
VP730	A380	16E	\N
VP730	A380	16F	\N
VP730	A380	16K	\N
VP730	A380	17B	\N
VP730	A380	17D	\N
VP730	A380	17G	\N
VP730	A380	17J	\N
VP730	A380	18A	\N
VP730	A380	18E	\N
VP730	A380	18F	\N
VP730	A380	18K	\N
VP730	A380	19B	\N
VP730	A380	19D	\N
VP730	A380	19G	\N
VP730	A380	19J	\N
VP730	A380	2A	\N
VP730	A380	2E	\N
VP730	A380	2F	\N
VP730	A380	2K	\N
VP730	A380	20E	\N
VP730	A380	20F	\N
VP730	A380	20K	\N
VP730	A380	21B	\N
VP730	A380	21G	\N
VP730	A380	21J	\N
VP730	A380	22D	\N
VP730	A380	22G	\N
VP730	A380	23A	\N
VP730	A380	23E	\N
VP730	A380	23F	\N
VP730	A380	23K	\N
VP730	A380	24B	\N
VP730	A380	24D	\N
VP730	A380	24G	\N
VP730	A380	24J	\N
VP730	A380	25A	\N
VP730	A380	25E	\N
VP730	A380	25F	\N
VP730	A380	25K	\N
VP730	A380	26B	\N
VP730	A380	26D	\N
VP730	A380	26G	\N
VP730	A380	26J	\N
VP730	A380	3A	\N
VP730	A380	3E	\N
VP730	A380	3F	\N
VP730	A380	3K	\N
VP730	A380	4A	\N
VP730	A380	4K	\N
VP730	A380	43A	\N
VP730	A380	43B	\N
VP730	A380	43C	\N
VP730	A380	43H	\N
VP730	A380	43J	\N
VP730	A380	43K	\N
VP730	A380	44A	\N
VP730	A380	44B	\N
VP730	A380	44C	\N
VP730	A380	44H	\N
VP730	A380	44J	\N
VP730	A380	44K	\N
VP730	A380	45A	\N
VP730	A380	45B	\N
VP730	A380	45C	\N
VP730	A380	45D	\N
VP730	A380	45E	\N
VP730	A380	45F	\N
VP730	A380	45G	\N
VP730	A380	45H	\N
QU263	A350	1K	T659609
VP730	A380	45J	\N
VP730	A380	45K	\N
VP730	A380	46A	\N
VP730	A380	46B	\N
VP730	A380	46C	\N
VP730	A380	46D	\N
VP730	A380	46E	\N
VP730	A380	46F	\N
VP730	A380	46G	\N
VP730	A380	46H	\N
VP730	A380	46J	\N
VP730	A380	46K	\N
VP730	A380	47A	\N
VP730	A380	47B	\N
VP730	A380	47C	\N
VP730	A380	47D	\N
VP730	A380	47E	\N
VP730	A380	47F	\N
VP730	A380	47G	\N
VP730	A380	47H	\N
VP730	A380	47J	\N
VP730	A380	47K	\N
VP730	A380	48A	\N
VP730	A380	48B	\N
VP730	A380	48C	\N
VP730	A380	48D	\N
VP730	A380	48E	\N
VP730	A380	48F	\N
VP730	A380	48G	\N
VP730	A380	48H	\N
VP730	A380	48J	\N
VP730	A380	48K	\N
VP730	A380	49A	\N
VP730	A380	49B	\N
VP730	A380	49C	\N
VP730	A380	49D	\N
VP730	A380	49E	\N
VP730	A380	49F	\N
VP730	A380	49G	\N
VP730	A380	49H	\N
VP730	A380	49J	\N
VP730	A380	49K	\N
VP730	A380	50A	\N
VP730	A380	50B	\N
VP730	A380	50C	\N
VP730	A380	50D	\N
VP730	A380	50E	\N
VP730	A380	50F	\N
VP730	A380	50G	\N
VP730	A380	50H	\N
VP730	A380	50J	\N
VP730	A380	50K	\N
VP730	A380	51D	\N
VP730	A380	51E	\N
VP730	A380	51F	\N
VP730	A380	51G	\N
VP730	A380	52A	\N
VP730	A380	52B	\N
VP730	A380	52C	\N
VP730	A380	52H	\N
VP730	A380	52J	\N
VP730	A380	52K	\N
VP730	A380	53A	\N
VP730	A380	53B	\N
VP730	A380	53C	\N
VP730	A380	53H	\N
VP730	A380	53J	\N
VP730	A380	53K	\N
VP730	A380	54A	\N
VP730	A380	54B	\N
VP730	A380	54C	\N
VP730	A380	54D	\N
VP730	A380	54E	\N
VP730	A380	54F	\N
VP730	A380	54G	\N
VP730	A380	54H	\N
VP730	A380	54J	\N
VP730	A380	54K	\N
VP730	A380	55A	\N
VP730	A380	55B	\N
VP730	A380	55C	\N
VP730	A380	55D	\N
VP730	A380	55E	\N
VP730	A380	55F	\N
VP730	A380	55G	\N
VP730	A380	55H	\N
VP730	A380	55J	\N
VP730	A380	55K	\N
VP730	A380	56A	\N
VP730	A380	56B	\N
VP730	A380	56C	\N
VP730	A380	56D	\N
VP730	A380	56E	\N
VP730	A380	56F	\N
VP730	A380	56G	\N
VP730	A380	56H	\N
VP730	A380	56J	\N
VP730	A380	56K	\N
VP730	A380	57A	\N
VP730	A380	57B	\N
VP730	A380	57C	\N
VP730	A380	57D	\N
VP730	A380	57E	\N
VP730	A380	57F	\N
VP730	A380	57G	\N
VP730	A380	57H	\N
VP730	A380	21D	\N
VP730	A380	57J	\N
VP730	A380	57K	\N
VP730	A380	58A	\N
VP730	A380	58B	\N
VP730	A380	58C	\N
VP730	A380	58D	\N
VP730	A380	58E	\N
VP730	A380	58F	\N
VP730	A380	58G	\N
VP730	A380	58H	\N
VP730	A380	58J	\N
VP730	A380	58K	\N
VP730	A380	59A	\N
VP730	A380	59B	\N
VP730	A380	59C	\N
VP730	A380	59D	\N
VP730	A380	59E	\N
VP730	A380	59F	\N
VP730	A380	59G	\N
VP730	A380	59H	\N
VP730	A380	59J	\N
VP730	A380	59K	\N
VP730	A380	6D	\N
VP730	A380	6G	\N
VP730	A380	60A	\N
VP730	A380	60B	\N
VP730	A380	60C	\N
VP730	A380	60D	\N
VP730	A380	60E	\N
VP730	A380	60F	\N
VP730	A380	60G	\N
VP730	A380	60H	\N
VP730	A380	60J	\N
VP730	A380	60K	\N
VP730	A380	61A	\N
VP730	A380	61B	\N
VP730	A380	61C	\N
VP730	A380	61D	\N
VP730	A380	61E	\N
VP730	A380	61F	\N
VP730	A380	61G	\N
VP730	A380	61H	\N
VP730	A380	61J	\N
VP730	A380	61K	\N
VP730	A380	62A	\N
VP730	A380	62B	\N
VP730	A380	62C	\N
VP730	A380	62D	\N
VP730	A380	62E	\N
VP730	A380	62F	\N
VP730	A380	62G	\N
VP730	A380	62H	\N
VP730	A380	62J	\N
VP730	A380	62K	\N
VP730	A380	63A	\N
VP730	A380	63B	\N
VP730	A380	63C	\N
VP730	A380	63D	\N
VP730	A380	63E	\N
VP730	A380	63F	\N
VP730	A380	63G	\N
VP730	A380	63H	\N
VP730	A380	63J	\N
VP730	A380	63K	\N
VP730	A380	64A	\N
VP730	A380	64B	\N
VP730	A380	64C	\N
VP730	A380	64D	\N
VP730	A380	64E	\N
VP730	A380	64F	\N
VP730	A380	64G	\N
VP730	A380	64H	\N
VP730	A380	64J	\N
VP730	A380	64K	\N
VP730	A380	65A	\N
VP730	A380	65B	\N
VP730	A380	65C	\N
VP730	A380	65D	\N
VP730	A380	65E	\N
VP730	A380	65F	\N
VP730	A380	65G	\N
VP730	A380	65H	\N
VP730	A380	65J	\N
VP730	A380	65K	\N
VP730	A380	66H	\N
VP730	A380	66J	\N
VP730	A380	66K	\N
VP730	A380	67B	\N
VP730	A380	67C	\N
VP730	A380	67D	\N
VP730	A380	67E	\N
VP730	A380	67F	\N
VP730	A380	67G	\N
VP730	A380	67H	\N
VP730	A380	67J	\N
VP730	A380	68A	\N
VP730	A380	68B	\N
VP730	A380	68C	\N
VP730	A380	68D	\N
VP730	A380	68E	\N
VP730	A380	68F	\N
VP730	A380	68G	\N
VP730	A380	68H	\N
VP730	A380	68J	\N
VP730	A380	68K	\N
VP730	A380	69A	\N
VP730	A380	69B	\N
VP730	A380	69C	\N
VP730	A380	69D	\N
VP730	A380	69E	\N
VP730	A380	69F	\N
VP730	A380	69G	\N
VP730	A380	69H	\N
VP730	A380	69J	\N
VP730	A380	69K	\N
VP730	A380	7A	\N
VP730	A380	7E	\N
VP730	A380	7F	\N
VP730	A380	7K	\N
VP730	A380	70A	\N
VP730	A380	70B	\N
VP730	A380	70C	\N
VP730	A380	70D	\N
VP730	A380	70E	\N
VP730	A380	70F	\N
VP730	A380	70G	\N
VP730	A380	70H	\N
VP730	A380	70J	\N
VP730	A380	70K	\N
VP730	A380	71A	\N
VP730	A380	71B	\N
VP730	A380	71C	\N
VP730	A380	71D	\N
VP730	A380	71E	\N
VP730	A380	71F	\N
VP730	A380	71G	\N
VP730	A380	71H	\N
VP730	A380	71J	\N
VP730	A380	71K	\N
VP730	A380	72A	\N
VP730	A380	72B	\N
VP730	A380	72C	\N
VP730	A380	72D	\N
VP730	A380	72E	\N
VP730	A380	72F	\N
VP730	A380	72G	\N
VP730	A380	72H	\N
VP730	A380	72J	\N
VP730	A380	72K	\N
VP730	A380	73A	\N
VP730	A380	73B	\N
VP730	A380	73C	\N
VP730	A380	73D	\N
VP730	A380	73E	\N
VP730	A380	73F	\N
VP730	A380	73G	\N
VP730	A380	73H	\N
VP730	A380	73J	\N
VP730	A380	73K	\N
VP730	A380	74A	\N
VP730	A380	74B	\N
VP730	A380	74C	\N
VP730	A380	74D	\N
VP730	A380	74E	\N
VP730	A380	74F	\N
VP730	A380	74G	\N
VP730	A380	74H	\N
VP730	A380	74J	\N
VP730	A380	74K	\N
VP730	A380	75A	\N
VP730	A380	75B	\N
VP730	A380	75C	\N
VP730	A380	75D	\N
VP730	A380	75E	\N
VP730	A380	75F	\N
VP730	A380	75G	\N
VP730	A380	75H	\N
VP730	A380	75J	\N
VP730	A380	75K	\N
VP730	A380	76A	\N
VP730	A380	76B	\N
VP730	A380	76C	\N
VP730	A380	76D	\N
VP730	A380	76E	\N
VP730	A380	76F	\N
VP730	A380	76G	\N
VP730	A380	76H	\N
VP730	A380	76J	\N
VP730	A380	76K	\N
VP730	A380	77A	\N
VP730	A380	77B	\N
VP730	A380	77C	\N
VP730	A380	77D	\N
VP730	A380	77E	\N
VP730	A380	77F	\N
VP730	A380	77G	\N
VP730	A380	77H	\N
VP730	A380	77J	\N
VP730	A380	77K	\N
VP730	A380	78A	\N
VP730	A380	78B	\N
VP730	A380	78C	\N
VP730	A380	78D	\N
VP730	A380	78E	\N
VP730	A380	78F	\N
VP730	A380	78G	\N
VP730	A380	78H	\N
VP730	A380	78J	\N
VP730	A380	78K	\N
VP730	A380	79A	\N
VP730	A380	79B	\N
VP730	A380	79C	\N
VP730	A380	79H	\N
VP730	A380	79J	\N
VP730	A380	79K	\N
VP730	A380	8B	\N
VP730	A380	8D	\N
VP730	A380	8G	\N
VP730	A380	8J	\N
VP730	A380	80B	\N
VP730	A380	80C	\N
VP730	A380	80H	\N
VP730	A380	80J	\N
VP730	A380	81A	\N
VP730	A380	81B	\N
VP730	A380	81C	\N
VP730	A380	81H	\N
VP730	A380	81J	\N
VP730	A380	81K	\N
VP730	A380	82A	\N
VP730	A380	82B	\N
VP730	A380	82C	\N
VP730	A380	82D	\N
VP730	A380	82E	\N
VP730	A380	82F	\N
VP730	A380	82G	\N
VP730	A380	82H	\N
VP730	A380	82J	\N
VP730	A380	82K	\N
VP730	A380	83A	\N
VP730	A380	83B	\N
VP730	A380	83C	\N
VP730	A380	83D	\N
VP730	A380	83E	\N
VP730	A380	83F	\N
VP730	A380	83G	\N
VP730	A380	83H	\N
VP730	A380	83J	\N
VP730	A380	83K	\N
VP730	A380	84A	\N
VP730	A380	84B	\N
VP730	A380	84C	\N
VP730	A380	84D	\N
VP730	A380	84E	\N
VP730	A380	84F	\N
VP730	A380	84G	\N
VP730	A380	84H	\N
VP730	A380	84J	\N
VP730	A380	84K	\N
VP730	A380	85A	\N
VP730	A380	85B	\N
VP730	A380	85C	\N
VP730	A380	85H	\N
VP730	A380	85J	\N
VP730	A380	85K	\N
VP730	A380	86A	\N
VP730	A380	86B	\N
VP730	A380	86C	\N
VP730	A380	86H	\N
VP730	A380	86J	\N
VP730	A380	86K	\N
VP730	A380	87A	\N
VP730	A380	87B	\N
VP730	A380	87C	\N
VP730	A380	87H	\N
VP730	A380	87J	\N
VP730	A380	87K	\N
VP730	A380	88A	\N
VP730	A380	88B	\N
VP730	A380	88C	\N
VP730	A380	88H	\N
VP730	A380	88J	\N
VP730	A380	88K	\N
VP730	A380	9A	\N
VP730	A380	9E	\N
VP730	A380	9F	\N
VP730	A380	9K	\N
ZI116	A350	1A	\N
ZI116	A350	1C	\N
ZI116	A350	1D	\N
ZI116	A350	1G	\N
ZI116	A350	1H	\N
ZI116	A350	1K	\N
ZI116	A350	10A	\N
ZI116	A350	10C	\N
ZI116	A350	10D	\N
ZI116	A350	10E	\N
ZI116	A350	10F	\N
ZI116	A350	10G	\N
ZI116	A350	10H	\N
ZI116	A350	10K	\N
ZI116	A350	11A	\N
ZI116	A350	11C	\N
ZI116	A350	11D	\N
ZI116	A350	11E	\N
ZI116	A350	11F	\N
ZI116	A350	11G	\N
ZI116	A350	11H	\N
ZI116	A350	11K	\N
ZI116	A350	12D	\N
ZI116	A350	12E	\N
ZI116	A350	12F	\N
ZI116	A350	12G	\N
ZI116	A350	15D	\N
ZI116	A350	15E	\N
ZI116	A350	15F	\N
ZI116	A350	15G	\N
ZI116	A350	15H	\N
ZI116	A350	15K	\N
ZI116	A350	16A	\N
ZI116	A350	16C	\N
ZI116	A350	16D	\N
ZI116	A350	16E	\N
ZI116	A350	16F	\N
ZI116	A350	16G	\N
ZI116	A350	16H	\N
ZI116	A350	16K	\N
ZI116	A350	17A	\N
ZI116	A350	17C	\N
ZI116	A350	17D	\N
ZI116	A350	17E	\N
ZI116	A350	17F	\N
ZI116	A350	17G	\N
ZI116	A350	17H	\N
ZI116	A350	17K	\N
ZI116	A350	18A	\N
ZI116	A350	18C	\N
ZI116	A350	18D	\N
ZI116	A350	18E	\N
ZI116	A350	18F	\N
ZI116	A350	18G	\N
ZI116	A350	18H	\N
ZI116	A350	18K	\N
ZI116	A350	19A	\N
ZI116	A350	19C	\N
ZI116	A350	19D	\N
ZI116	A350	19E	\N
ZI116	A350	19F	\N
ZI116	A350	19G	\N
ZI116	A350	19H	\N
ZI116	A350	19K	\N
ZI116	A350	2A	\N
ZI116	A350	2C	\N
ZI116	A350	2D	\N
ZI116	A350	2G	\N
ZI116	A350	2H	\N
ZI116	A350	2K	\N
ZI116	A350	27A	\N
ZI116	A350	27B	\N
ZI116	A350	27C	\N
ZI116	A350	27D	\N
ZI116	A350	27E	\N
ZI116	A350	27G	\N
ZI116	A350	27H	\N
ZI116	A350	27J	\N
ZI116	A350	27K	\N
ZI116	A350	28A	\N
ZI116	A350	28B	\N
ZI116	A350	28C	\N
ZI116	A350	28D	\N
ZI116	A350	28E	\N
ZI116	A350	28G	\N
ZI116	A350	28H	\N
ZI116	A350	28J	\N
ZI116	A350	28K	\N
ZI116	A350	29A	\N
ZI116	A350	29B	\N
ZI116	A350	29C	\N
ZI116	A350	29D	\N
ZI116	A350	29E	\N
ZI116	A350	29G	\N
ZI116	A350	29H	\N
ZI116	A350	29J	\N
ZI116	A350	29K	\N
ZI116	A350	30A	\N
ZI116	A350	30B	\N
ZI116	A350	30C	\N
ZI116	A350	30D	\N
ZI116	A350	30E	\N
ZI116	A350	30G	\N
ZI116	A350	30H	\N
ZI116	A350	30J	\N
ZI116	A350	30K	\N
ZI116	A350	31A	\N
ZI116	A350	31B	\N
ZI116	A350	31C	\N
ZI116	A350	31D	\N
ZI116	A350	31E	\N
ZI116	A350	31G	\N
ZI116	A350	31H	\N
ZI116	A350	31J	\N
ZI116	A350	31K	\N
ZI116	A350	32A	\N
ZI116	A350	32B	\N
ZI116	A350	32C	\N
ZI116	A350	32D	\N
ZI116	A350	32E	\N
ZI116	A350	32G	\N
ZI116	A350	32H	\N
ZI116	A350	32J	\N
ZI116	A350	32K	\N
ZI116	A350	33A	\N
ZI116	A350	33B	\N
ZI116	A350	33C	\N
ZI116	A350	33D	\N
ZI116	A350	33E	\N
ZI116	A350	33G	\N
ZI116	A350	33H	\N
ZI116	A350	33J	\N
ZI116	A350	33K	\N
ZI116	A350	34A	\N
ZI116	A350	34B	\N
ZI116	A350	34C	\N
ZI116	A350	34D	\N
ZI116	A350	34E	\N
ZI116	A350	34G	\N
ZI116	A350	34H	\N
ZI116	A350	34J	\N
ZI116	A350	34K	\N
ZI116	A350	35A	\N
ZI116	A350	35B	\N
ZI116	A350	35C	\N
ZI116	A350	35D	\N
ZI116	A350	35E	\N
ZI116	A350	35G	\N
ZI116	A350	35H	\N
ZI116	A350	35J	\N
ZI116	A350	35K	\N
ZI116	A350	36A	\N
ZI116	A350	36B	\N
ZI116	A350	36C	\N
ZI116	A350	36D	\N
ZI116	A350	36E	\N
ZI116	A350	36G	\N
ZI116	A350	36H	\N
ZI116	A350	36J	\N
ZI116	A350	36K	\N
ZI116	A350	37A	\N
ZI116	A350	37B	\N
ZI116	A350	37C	\N
ZI116	A350	37D	\N
ZI116	A350	37E	\N
ZI116	A350	37G	\N
ZI116	A350	37H	\N
ZI116	A350	37J	\N
ZI116	A350	37K	\N
ZI116	A350	38A	\N
ZI116	A350	38B	\N
ZI116	A350	38C	\N
ZI116	A350	38D	\N
ZI116	A350	38E	\N
ZI116	A350	38G	\N
ZI116	A350	38H	\N
ZI116	A350	38J	\N
ZI116	A350	38K	\N
ZI116	A350	39A	\N
ZI116	A350	39B	\N
ZI116	A350	39C	\N
ZI116	A350	39D	\N
ZI116	A350	39E	\N
ZI116	A350	39G	\N
ZI116	A350	39H	\N
ZI116	A350	39J	\N
ZI116	A350	39K	\N
ZI116	A350	40D	\N
ZI116	A350	40E	\N
ZI116	A350	40G	\N
ZI116	A350	45A	\N
ZI116	A350	45B	\N
ZI116	A350	45C	\N
ZI116	A350	45D	\N
ZI116	A350	45E	\N
ZI116	A350	45G	\N
ZI116	A350	45H	\N
ZI116	A350	45J	\N
ZI116	A350	45K	\N
ZI116	A350	46A	\N
ZI116	A350	46B	\N
ZI116	A350	46C	\N
ZI116	A350	46D	\N
ZI116	A350	46E	\N
ZI116	A350	46G	\N
ZI116	A350	46H	\N
ZI116	A350	46J	\N
ZI116	A350	46K	\N
ZI116	A350	47A	\N
ZI116	A350	47B	\N
ZI116	A350	47C	\N
ZI116	A350	47D	\N
ZI116	A350	47E	\N
ZI116	A350	47G	\N
ZI116	A350	47H	\N
ZI116	A350	47J	\N
ZI116	A350	47K	\N
ZI116	A350	48A	\N
ZI116	A350	48B	\N
ZI116	A350	48C	\N
ZI116	A350	48D	\N
ZI116	A350	48E	\N
ZI116	A350	48G	\N
ZI116	A350	48H	\N
ZI116	A350	48J	\N
ZI116	A350	48K	\N
ZI116	A350	49A	\N
ZI116	A350	49B	\N
ZI116	A350	49C	\N
ZI116	A350	49D	\N
ZI116	A350	49E	\N
ZI116	A350	49G	\N
ZI116	A350	49H	\N
ZI116	A350	49J	\N
ZI116	A350	49K	\N
ZI116	A350	5A	\N
ZI116	A350	5C	\N
ZI116	A350	5H	\N
ZI116	A350	5K	\N
ZI116	A350	50A	\N
ZI116	A350	50B	\N
ZI116	A350	50C	\N
ZI116	A350	50D	\N
ZI116	A350	50E	\N
ZI116	A350	50G	\N
ZI116	A350	50H	\N
ZI116	A350	50J	\N
ZI116	A350	50K	\N
ZI116	A350	51A	\N
ZI116	A350	51B	\N
ZI116	A350	51C	\N
ZI116	A350	51D	\N
ZI116	A350	51E	\N
ZI116	A350	51G	\N
ZI116	A350	51H	\N
ZI116	A350	51J	\N
ZI116	A350	51K	\N
ZI116	A350	52A	\N
ZI116	A350	52B	\N
ZI116	A350	52C	\N
ZI116	A350	52D	\N
ZI116	A350	52E	\N
ZI116	A350	52G	\N
ZI116	A350	52H	\N
ZI116	A350	52J	\N
ZI116	A350	52K	\N
ZI116	A350	53A	\N
ZI116	A350	53B	\N
ZI116	A350	53C	\N
ZI116	A350	53D	\N
ZI116	A350	53E	\N
ZI116	A350	53G	\N
ZI116	A350	53H	\N
ZI116	A350	53J	\N
ZI116	A350	53K	\N
ZI116	A350	54A	\N
ZI116	A350	54B	\N
ZI116	A350	54C	\N
ZI116	A350	54D	\N
ZI116	A350	54E	\N
ZI116	A350	54G	\N
ZI116	A350	54H	\N
ZI116	A350	54J	\N
ZI116	A350	54K	\N
ZI116	A350	55A	\N
ZI116	A350	55B	\N
ZI116	A350	55C	\N
ZI116	A350	55D	\N
ZI116	A350	55E	\N
ZI116	A350	55G	\N
ZI116	A350	55H	\N
ZI116	A350	55J	\N
ZI116	A350	55K	\N
ZI116	A350	56A	\N
ZI116	A350	56B	\N
ZI116	A350	56C	\N
ZI116	A350	56D	\N
ZI116	A350	56E	\N
ZI116	A350	56G	\N
ZI116	A350	56H	\N
ZI116	A350	56J	\N
ZI116	A350	56K	\N
ZI116	A350	57A	\N
ZI116	A350	57B	\N
ZI116	A350	57C	\N
ZI116	A350	57D	\N
ZI116	A350	57E	\N
ZI116	A350	57G	\N
ZI116	A350	57H	\N
ZI116	A350	57J	\N
ZI116	A350	57K	\N
ZI116	A350	58A	\N
ZI116	A350	58B	\N
ZI116	A350	58C	\N
ZI116	A350	58D	\N
ZI116	A350	58E	\N
ZI116	A350	58G	\N
ZI116	A350	58H	\N
ZI116	A350	58J	\N
ZI116	A350	58K	\N
ZI116	A350	59A	\N
ZI116	A350	59B	\N
ZI116	A350	59C	\N
ZI116	A350	59D	\N
ZI116	A350	59E	\N
ZI116	A350	59G	\N
ZI116	A350	59H	\N
ZI116	A350	59J	\N
ZI116	A350	59K	\N
ZI116	A350	6A	\N
ZI116	A350	6C	\N
ZI116	A350	6D	\N
ZI116	A350	6E	\N
ZI116	A350	6F	\N
ZI116	A350	6G	\N
ZI116	A350	6H	\N
ZI116	A350	6K	\N
ZI116	A350	60A	\N
ZI116	A350	60C	\N
ZI116	A350	60D	\N
ZI116	A350	60E	\N
ZI116	A350	60G	\N
ZI116	A350	61D	\N
ZI116	A350	61E	\N
ZI116	A350	61G	\N
ZI116	A350	7A	\N
ZI116	A350	7C	\N
ZI116	A350	7D	\N
ZI116	A350	7E	\N
ZI116	A350	7F	\N
ZI116	A350	7G	\N
ZI116	A350	7H	\N
ZI116	A350	7K	\N
ZI116	A350	8A	\N
ZI116	A350	8C	\N
ZI116	A350	8D	\N
ZI116	A350	8E	\N
ZI116	A350	8F	\N
ZI116	A350	8G	\N
ZI116	A350	8H	\N
ZI116	A350	8K	\N
ZI116	A350	9A	\N
ZI116	A350	9C	\N
ZI116	A350	9D	\N
ZI116	A350	9E	\N
ZI116	A350	9F	\N
ZI116	A350	9G	\N
ZI116	A350	9H	\N
ZI116	A350	9K	\N
PM765	A350	1A	\N
PM765	A350	1C	\N
PM765	A350	1D	\N
PM765	A350	1G	\N
PM765	A350	1H	\N
PM765	A350	1K	\N
PM765	A350	10A	\N
PM765	A350	10C	\N
PM765	A350	10D	\N
PM765	A350	10E	\N
PM765	A350	10F	\N
PM765	A350	10G	\N
PM765	A350	10H	\N
PM765	A350	10K	\N
PM765	A350	11A	\N
PM765	A350	11C	\N
PM765	A350	11D	\N
PM765	A350	11E	\N
PM765	A350	11F	\N
PM765	A350	11G	\N
PM765	A350	11H	\N
PM765	A350	11K	\N
PM765	A350	12D	\N
PM765	A350	12E	\N
PM765	A350	12F	\N
PM765	A350	12G	\N
PM765	A350	15D	\N
PM765	A350	15E	\N
PM765	A350	15F	\N
PM765	A350	15G	\N
PM765	A350	15H	\N
PM765	A350	15K	\N
PM765	A350	16A	\N
PM765	A350	16C	\N
PM765	A350	16D	\N
PM765	A350	16E	\N
PM765	A350	16F	\N
PM765	A350	16G	\N
PM765	A350	16H	\N
PM765	A350	16K	\N
PM765	A350	17A	\N
PM765	A350	17C	\N
PM765	A350	17D	\N
PM765	A350	17E	\N
PM765	A350	17F	\N
PM765	A350	17G	\N
PM765	A350	17H	\N
PM765	A350	17K	\N
PM765	A350	18A	\N
PM765	A350	18C	\N
PM765	A350	18D	\N
PM765	A350	18E	\N
PM765	A350	18F	\N
PM765	A350	18G	\N
PM765	A350	18H	\N
PM765	A350	18K	\N
PM765	A350	19A	\N
PM765	A350	19C	\N
PM765	A350	19D	\N
PM765	A350	19E	\N
PM765	A350	19F	\N
PM765	A350	19G	\N
PM765	A350	19H	\N
PM765	A350	19K	\N
PM765	A350	2A	\N
PM765	A350	2C	\N
PM765	A350	2D	\N
PM765	A350	2G	\N
PM765	A350	2H	\N
PM765	A350	2K	\N
PM765	A350	27A	\N
PM765	A350	27B	\N
PM765	A350	27C	\N
PM765	A350	27D	\N
PM765	A350	27E	\N
PM765	A350	27G	\N
PM765	A350	27H	\N
PM765	A350	27J	\N
PM765	A350	27K	\N
PM765	A350	28A	\N
PM765	A350	28B	\N
PM765	A350	28C	\N
PM765	A350	28D	\N
PM765	A350	28E	\N
PM765	A350	28G	\N
PM765	A350	28H	\N
PM765	A350	28J	\N
PM765	A350	28K	\N
PM765	A350	29A	\N
PM765	A350	29B	\N
PM765	A350	29C	\N
PM765	A350	29D	\N
PM765	A350	29E	\N
PM765	A350	29G	\N
PM765	A350	29H	\N
PM765	A350	29J	\N
PM765	A350	29K	\N
PM765	A350	30A	\N
PM765	A350	30B	\N
PM765	A350	30C	\N
PM765	A350	30D	\N
PM765	A350	30E	\N
PM765	A350	30G	\N
PM765	A350	30H	\N
PM765	A350	30J	\N
PM765	A350	30K	\N
PM765	A350	31A	\N
PM765	A350	31B	\N
PM765	A350	31C	\N
PM765	A350	31D	\N
PM765	A350	31E	\N
PM765	A350	31G	\N
PM765	A350	31H	\N
PM765	A350	31J	\N
PM765	A350	31K	\N
PM765	A350	32A	\N
PM765	A350	32B	\N
PM765	A350	32C	\N
PM765	A350	32D	\N
PM765	A350	32E	\N
PM765	A350	32G	\N
PM765	A350	32H	\N
PM765	A350	32J	\N
PM765	A350	32K	\N
PM765	A350	33A	\N
PM765	A350	33B	\N
PM765	A350	33C	\N
PM765	A350	33D	\N
PM765	A350	33E	\N
PM765	A350	33G	\N
PM765	A350	33H	\N
PM765	A350	33J	\N
PM765	A350	33K	\N
PM765	A350	34A	\N
PM765	A350	34B	\N
PM765	A350	34C	\N
PM765	A350	34D	\N
PM765	A350	34E	\N
PM765	A350	34G	\N
PM765	A350	34H	\N
PM765	A350	34J	\N
PM765	A350	34K	\N
PM765	A350	35A	\N
PM765	A350	35B	\N
PM765	A350	35C	\N
PM765	A350	35D	\N
PM765	A350	35E	\N
PM765	A350	35G	\N
PM765	A350	35H	\N
PM765	A350	35J	\N
PM765	A350	35K	\N
PM765	A350	36A	\N
PM765	A350	36B	\N
PM765	A350	36C	\N
PM765	A350	36D	\N
PM765	A350	36E	\N
PM765	A350	36G	\N
PM765	A350	36H	\N
PM765	A350	36J	\N
PM765	A350	36K	\N
PM765	A350	37A	\N
PM765	A350	37B	\N
PM765	A350	37C	\N
PM765	A350	37D	\N
PM765	A350	37E	\N
PM765	A350	37G	\N
PM765	A350	37H	\N
PM765	A350	37J	\N
PM765	A350	37K	\N
PM765	A350	38A	\N
PM765	A350	38B	\N
PM765	A350	38C	\N
PM765	A350	38D	\N
PM765	A350	38E	\N
PM765	A350	38G	\N
PM765	A350	38H	\N
PM765	A350	38J	\N
PM765	A350	38K	\N
PM765	A350	39A	\N
PM765	A350	39B	\N
PM765	A350	39C	\N
PM765	A350	39D	\N
PM765	A350	39E	\N
PM765	A350	39G	\N
PM765	A350	39H	\N
PM765	A350	39J	\N
PM765	A350	39K	\N
PM765	A350	40D	\N
PM765	A350	40E	\N
PM765	A350	40G	\N
PM765	A350	45A	\N
PM765	A350	45B	\N
PM765	A350	45C	\N
PM765	A350	45D	\N
PM765	A350	45E	\N
PM765	A350	45G	\N
PM765	A350	45H	\N
PM765	A350	45J	\N
PM765	A350	45K	\N
PM765	A350	46A	\N
PM765	A350	46B	\N
PM765	A350	46C	\N
PM765	A350	46D	\N
PM765	A350	46E	\N
PM765	A350	46G	\N
PM765	A350	46H	\N
PM765	A350	46J	\N
PM765	A350	46K	\N
PM765	A350	47A	\N
PM765	A350	47B	\N
PM765	A350	47C	\N
PM765	A350	47D	\N
PM765	A350	47E	\N
PM765	A350	47G	\N
PM765	A350	47H	\N
PM765	A350	47J	\N
PM765	A350	47K	\N
PM765	A350	48A	\N
PM765	A350	48B	\N
PM765	A350	48C	\N
PM765	A350	48D	\N
PM765	A350	48E	\N
PM765	A350	48G	\N
PM765	A350	48H	\N
PM765	A350	48J	\N
PM765	A350	48K	\N
PM765	A350	49A	\N
PM765	A350	49B	\N
PM765	A350	49C	\N
PM765	A350	49D	\N
PM765	A350	49E	\N
PM765	A350	49G	\N
PM765	A350	49H	\N
PM765	A350	49J	\N
PM765	A350	49K	\N
PM765	A350	5A	\N
PM765	A350	5C	\N
PM765	A350	5H	\N
PM765	A350	5K	\N
PM765	A350	50A	\N
PM765	A350	50B	\N
PM765	A350	50C	\N
PM765	A350	50D	\N
PM765	A350	50E	\N
PM765	A350	50G	\N
PM765	A350	50H	\N
PM765	A350	50J	\N
PM765	A350	50K	\N
PM765	A350	51A	\N
PM765	A350	51B	\N
PM765	A350	51C	\N
PM765	A350	51D	\N
PM765	A350	51E	\N
PM765	A350	51G	\N
PM765	A350	51H	\N
PM765	A350	51J	\N
PM765	A350	51K	\N
PM765	A350	52A	\N
PM765	A350	52B	\N
PM765	A350	52C	\N
PM765	A350	52D	\N
PM765	A350	52E	\N
PM765	A350	52G	\N
PM765	A350	52H	\N
PM765	A350	52J	\N
PM765	A350	52K	\N
PM765	A350	53A	\N
PM765	A350	53B	\N
PM765	A350	53C	\N
PM765	A350	53D	\N
PM765	A350	53E	\N
PM765	A350	53G	\N
PM765	A350	53H	\N
PM765	A350	53J	\N
PM765	A350	53K	\N
PM765	A350	54A	\N
PM765	A350	54B	\N
PM765	A350	54C	\N
PM765	A350	54D	\N
PM765	A350	54E	\N
PM765	A350	54G	\N
PM765	A350	54H	\N
PM765	A350	54J	\N
PM765	A350	54K	\N
PM765	A350	55A	\N
PM765	A350	55B	\N
PM765	A350	55C	\N
PM765	A350	55D	\N
PM765	A350	55E	\N
PM765	A350	55G	\N
PM765	A350	55H	\N
PM765	A350	55J	\N
PM765	A350	55K	\N
PM765	A350	56A	\N
PM765	A350	56B	\N
PM765	A350	56C	\N
PM765	A350	56D	\N
PM765	A350	56E	\N
PM765	A350	56G	\N
PM765	A350	56H	\N
PM765	A350	56J	\N
PM765	A350	56K	\N
PM765	A350	57A	\N
PM765	A350	57B	\N
PM765	A350	57C	\N
PM765	A350	57D	\N
PM765	A350	57E	\N
PM765	A350	57G	\N
PM765	A350	57H	\N
PM765	A350	57J	\N
PM765	A350	57K	\N
PM765	A350	58A	\N
PM765	A350	58B	\N
PM765	A350	58C	\N
PM765	A350	58D	\N
PM765	A350	58E	\N
PM765	A350	58G	\N
PM765	A350	58H	\N
PM765	A350	58J	\N
PM765	A350	58K	\N
PM765	A350	59A	\N
PM765	A350	59B	\N
PM765	A350	59C	\N
PM765	A350	59D	\N
PM765	A350	59E	\N
PM765	A350	59G	\N
PM765	A350	59H	\N
PM765	A350	59J	\N
PM765	A350	59K	\N
PM765	A350	6A	\N
PM765	A350	6C	\N
PM765	A350	6D	\N
PM765	A350	6E	\N
PM765	A350	6F	\N
PM765	A350	6G	\N
PM765	A350	6H	\N
PM765	A350	6K	\N
PM765	A350	60A	\N
PM765	A350	60C	\N
PM765	A350	60D	\N
PM765	A350	60E	\N
PM765	A350	60G	\N
PM765	A350	61D	\N
PM765	A350	61E	\N
PM765	A350	61G	\N
PM765	A350	7A	\N
PM765	A350	7C	\N
PM765	A350	7D	\N
PM765	A350	7E	\N
PM765	A350	7F	\N
PM765	A350	7G	\N
PM765	A350	7H	\N
PM765	A350	7K	\N
PM765	A350	8A	\N
PM765	A350	8C	\N
PM765	A350	8D	\N
PM765	A350	8E	\N
PM765	A350	8F	\N
PM765	A350	8G	\N
PM765	A350	8H	\N
PM765	A350	8K	\N
PM765	A350	9A	\N
PM765	A350	9C	\N
PM765	A350	9D	\N
PM765	A350	9E	\N
PM765	A350	9F	\N
PM765	A350	9G	\N
PM765	A350	9H	\N
PM765	A350	9K	\N
WW790	A350	1A	\N
WW790	A350	1C	\N
WW790	A350	1D	\N
WW790	A350	1G	\N
WW790	A350	1H	\N
WW790	A350	1K	\N
WW790	A350	10A	\N
WW790	A350	10C	\N
WW790	A350	10D	\N
WW790	A350	10E	\N
WW790	A350	10F	\N
WW790	A350	10G	\N
WW790	A350	10H	\N
WW790	A350	10K	\N
WW790	A350	11A	\N
WW790	A350	11C	\N
WW790	A350	11D	\N
WW790	A350	11E	\N
WW790	A350	11F	\N
WW790	A350	11G	\N
WW790	A350	11H	\N
WW790	A350	11K	\N
WW790	A350	12D	\N
WW790	A350	12E	\N
WW790	A350	12F	\N
WW790	A350	12G	\N
WW790	A350	15D	\N
WW790	A350	15E	\N
WW790	A350	15F	\N
WW790	A350	15G	\N
WW790	A350	15H	\N
WW790	A350	15K	\N
WW790	A350	16A	\N
WW790	A350	16C	\N
WW790	A350	16D	\N
WW790	A350	16E	\N
WW790	A350	16F	\N
WW790	A350	16G	\N
WW790	A350	16H	\N
WW790	A350	16K	\N
WW790	A350	17A	\N
WW790	A350	17C	\N
WW790	A350	17D	\N
WW790	A350	17E	\N
WW790	A350	17F	\N
WW790	A350	17G	\N
WW790	A350	17H	\N
WW790	A350	17K	\N
WW790	A350	18A	\N
WW790	A350	18C	\N
WW790	A350	18D	\N
WW790	A350	18E	\N
WW790	A350	18F	\N
WW790	A350	18G	\N
WW790	A350	18H	\N
WW790	A350	18K	\N
WW790	A350	19A	\N
WW790	A350	19C	\N
WW790	A350	19D	\N
WW790	A350	19E	\N
WW790	A350	19F	\N
WW790	A350	19G	\N
WW790	A350	19H	\N
WW790	A350	19K	\N
WW790	A350	2A	\N
WW790	A350	2C	\N
WW790	A350	2D	\N
WW790	A350	2G	\N
WW790	A350	2H	\N
WW790	A350	2K	\N
WW790	A350	27A	\N
WW790	A350	27B	\N
WW790	A350	27C	\N
WW790	A350	27D	\N
WW790	A350	27E	\N
WW790	A350	27G	\N
WW790	A350	27H	\N
WW790	A350	27J	\N
WW790	A350	27K	\N
WW790	A350	28A	\N
WW790	A350	28B	\N
WW790	A350	28C	\N
WW790	A350	28D	\N
WW790	A350	28E	\N
WW790	A350	28G	\N
WW790	A350	28H	\N
WW790	A350	28J	\N
WW790	A350	28K	\N
WW790	A350	29A	\N
WW790	A350	29B	\N
WW790	A350	29C	\N
WW790	A350	29D	\N
WW790	A350	29E	\N
WW790	A350	29G	\N
WW790	A350	29H	\N
WW790	A350	29J	\N
WW790	A350	29K	\N
WW790	A350	30A	\N
WW790	A350	30B	\N
WW790	A350	30C	\N
WW790	A350	30D	\N
WW790	A350	30E	\N
WW790	A350	30G	\N
WW790	A350	30H	\N
WW790	A350	30J	\N
WW790	A350	30K	\N
WW790	A350	31A	\N
WW790	A350	31B	\N
WW790	A350	31C	\N
WW790	A350	31D	\N
WW790	A350	31E	\N
WW790	A350	31G	\N
WW790	A350	31H	\N
WW790	A350	31J	\N
WW790	A350	31K	\N
WW790	A350	32A	\N
WW790	A350	32B	\N
WW790	A350	32C	\N
WW790	A350	32D	\N
WW790	A350	32E	\N
WW790	A350	32G	\N
WW790	A350	32H	\N
WW790	A350	32J	\N
WW790	A350	32K	\N
WW790	A350	33A	\N
WW790	A350	33B	\N
WW790	A350	33C	\N
WW790	A350	33D	\N
WW790	A350	33E	\N
WW790	A350	33G	\N
WW790	A350	33H	\N
WW790	A350	33J	\N
WW790	A350	33K	\N
WW790	A350	34A	\N
WW790	A350	34B	\N
WW790	A350	34C	\N
WW790	A350	34D	\N
WW790	A350	34E	\N
WW790	A350	34G	\N
WW790	A350	34H	\N
WW790	A350	34J	\N
WW790	A350	34K	\N
WW790	A350	35A	\N
WW790	A350	35B	\N
WW790	A350	35C	\N
WW790	A350	35D	\N
WW790	A350	35E	\N
WW790	A350	35G	\N
WW790	A350	35H	\N
WW790	A350	35J	\N
WW790	A350	35K	\N
WW790	A350	36A	\N
WW790	A350	36B	\N
WW790	A350	36C	\N
WW790	A350	36D	\N
WW790	A350	36E	\N
WW790	A350	36G	\N
WW790	A350	36H	\N
WW790	A350	36J	\N
WW790	A350	36K	\N
WW790	A350	37A	\N
WW790	A350	37B	\N
WW790	A350	37C	\N
WW790	A350	37D	\N
WW790	A350	37E	\N
WW790	A350	37G	\N
WW790	A350	37H	\N
WW790	A350	37J	\N
WW790	A350	37K	\N
WW790	A350	38A	\N
WW790	A350	38B	\N
WW790	A350	38C	\N
WW790	A350	38D	\N
WW790	A350	38E	\N
WW790	A350	38G	\N
WW790	A350	38H	\N
WW790	A350	38J	\N
WW790	A350	38K	\N
WW790	A350	39A	\N
WW790	A350	39B	\N
WW790	A350	39C	\N
WW790	A350	39D	\N
WW790	A350	39E	\N
WW790	A350	39G	\N
WW790	A350	39H	\N
WW790	A350	39J	\N
WW790	A350	39K	\N
WW790	A350	40D	\N
WW790	A350	40E	\N
WW790	A350	40G	\N
WW790	A350	45A	\N
WW790	A350	45B	\N
WW790	A350	45C	\N
WW790	A350	45D	\N
WW790	A350	45E	\N
WW790	A350	45G	\N
WW790	A350	45H	\N
WW790	A350	45J	\N
WW790	A350	45K	\N
WW790	A350	46A	\N
WW790	A350	46B	\N
WW790	A350	46C	\N
WW790	A350	46D	\N
WW790	A350	46E	\N
WW790	A350	46G	\N
WW790	A350	46H	\N
WW790	A350	46J	\N
WW790	A350	46K	\N
WW790	A350	47A	\N
WW790	A350	47B	\N
WW790	A350	47C	\N
WW790	A350	47D	\N
WW790	A350	47E	\N
WW790	A350	47G	\N
WW790	A350	47H	\N
WW790	A350	47J	\N
WW790	A350	47K	\N
WW790	A350	48A	\N
WW790	A350	48B	\N
WW790	A350	48C	\N
WW790	A350	48D	\N
WW790	A350	48E	\N
WW790	A350	48G	\N
WW790	A350	48H	\N
WW790	A350	48J	\N
WW790	A350	48K	\N
WW790	A350	49A	\N
WW790	A350	49B	\N
WW790	A350	49C	\N
WW790	A350	49D	\N
WW790	A350	49E	\N
WW790	A350	49G	\N
WW790	A350	49H	\N
WW790	A350	49J	\N
WW790	A350	49K	\N
WW790	A350	5A	\N
WW790	A350	5C	\N
WW790	A350	5H	\N
WW790	A350	5K	\N
WW790	A350	50A	\N
WW790	A350	50B	\N
WW790	A350	50C	\N
WW790	A350	50D	\N
WW790	A350	50E	\N
WW790	A350	50G	\N
WW790	A350	50H	\N
WW790	A350	50J	\N
WW790	A350	50K	\N
WW790	A350	51A	\N
WW790	A350	51B	\N
WW790	A350	51C	\N
WW790	A350	51D	\N
WW790	A350	51E	\N
WW790	A350	51G	\N
WW790	A350	51H	\N
WW790	A350	51J	\N
WW790	A350	51K	\N
WW790	A350	52A	\N
WW790	A350	52B	\N
WW790	A350	52C	\N
WW790	A350	52D	\N
WW790	A350	52E	\N
WW790	A350	52G	\N
WW790	A350	52H	\N
WW790	A350	52J	\N
WW790	A350	52K	\N
WW790	A350	53A	\N
WW790	A350	53B	\N
WW790	A350	53C	\N
WW790	A350	53D	\N
WW790	A350	53E	\N
WW790	A350	53G	\N
WW790	A350	53H	\N
WW790	A350	53J	\N
WW790	A350	53K	\N
WW790	A350	54A	\N
WW790	A350	54B	\N
WW790	A350	54C	\N
WW790	A350	54D	\N
WW790	A350	54E	\N
WW790	A350	54G	\N
WW790	A350	54H	\N
WW790	A350	54J	\N
WW790	A350	54K	\N
WW790	A350	55A	\N
WW790	A350	55B	\N
WW790	A350	55C	\N
WW790	A350	55D	\N
WW790	A350	55E	\N
WW790	A350	55G	\N
WW790	A350	55H	\N
WW790	A350	55J	\N
WW790	A350	55K	\N
WW790	A350	56A	\N
WW790	A350	56B	\N
WW790	A350	56C	\N
WW790	A350	56D	\N
WW790	A350	56E	\N
WW790	A350	56G	\N
WW790	A350	56H	\N
WW790	A350	56J	\N
WW790	A350	56K	\N
WW790	A350	57A	\N
WW790	A350	57B	\N
WW790	A350	57C	\N
WW790	A350	57D	\N
WW790	A350	57E	\N
WW790	A350	57G	\N
WW790	A350	57H	\N
WW790	A350	57J	\N
WW790	A350	57K	\N
WW790	A350	58A	\N
WW790	A350	58B	\N
WW790	A350	58C	\N
WW790	A350	58D	\N
WW790	A350	58E	\N
WW790	A350	58G	\N
WW790	A350	58H	\N
WW790	A350	58J	\N
WW790	A350	58K	\N
WW790	A350	59A	\N
WW790	A350	59B	\N
WW790	A350	59C	\N
WW790	A350	59D	\N
WW790	A350	59E	\N
WW790	A350	59G	\N
WW790	A350	59H	\N
WW790	A350	59J	\N
WW790	A350	59K	\N
WW790	A350	6A	\N
WW790	A350	6C	\N
WW790	A350	6D	\N
WW790	A350	6E	\N
WW790	A350	6F	\N
WW790	A350	6G	\N
WW790	A350	6H	\N
WW790	A350	6K	\N
WW790	A350	60A	\N
WW790	A350	60C	\N
WW790	A350	60D	\N
WW790	A350	60E	\N
WW790	A350	60G	\N
WW790	A350	61D	\N
WW790	A350	61E	\N
WW790	A350	61G	\N
WW790	A350	7A	\N
WW790	A350	7C	\N
WW790	A350	7D	\N
WW790	A350	7E	\N
WW790	A350	7F	\N
WW790	A350	7G	\N
WW790	A350	7H	\N
WW790	A350	7K	\N
WW790	A350	8A	\N
WW790	A350	8C	\N
WW790	A350	8D	\N
WW790	A350	8E	\N
WW790	A350	8F	\N
WW790	A350	8G	\N
WW790	A350	8H	\N
WW790	A350	8K	\N
WW790	A350	9A	\N
WW790	A350	9C	\N
WW790	A350	9D	\N
WW790	A350	9E	\N
WW790	A350	9F	\N
WW790	A350	9G	\N
WW790	A350	9H	\N
WW790	A350	9K	\N
RN302	A350	1A	\N
RN302	A350	1C	\N
RN302	A350	1D	\N
RN302	A350	1G	\N
RN302	A350	1H	\N
RN302	A350	1K	\N
RN302	A350	10A	\N
RN302	A350	10C	\N
RN302	A350	10D	\N
RN302	A350	10E	\N
RN302	A350	10F	\N
RN302	A350	10G	\N
RN302	A350	10H	\N
RN302	A350	10K	\N
RN302	A350	11A	\N
RN302	A350	11C	\N
RN302	A350	11D	\N
RN302	A350	11E	\N
RN302	A350	11F	\N
RN302	A350	11G	\N
RN302	A350	11H	\N
RN302	A350	11K	\N
RN302	A350	12D	\N
RN302	A350	12E	\N
RN302	A350	12F	\N
RN302	A350	12G	\N
RN302	A350	15D	\N
RN302	A350	15E	\N
RN302	A350	15F	\N
RN302	A350	15G	\N
RN302	A350	15H	\N
RN302	A350	15K	\N
RN302	A350	16A	\N
RN302	A350	16C	\N
RN302	A350	16D	\N
RN302	A350	16E	\N
RN302	A350	16F	\N
RN302	A350	16G	\N
RN302	A350	16H	\N
RN302	A350	16K	\N
RN302	A350	17A	\N
RN302	A350	17C	\N
RN302	A350	17D	\N
RN302	A350	17E	\N
RN302	A350	17F	\N
RN302	A350	17G	\N
RN302	A350	17H	\N
RN302	A350	17K	\N
RN302	A350	18A	\N
RN302	A350	18C	\N
RN302	A350	18D	\N
RN302	A350	18E	\N
RN302	A350	18F	\N
RN302	A350	18G	\N
RN302	A350	18H	\N
RN302	A350	18K	\N
RN302	A350	19A	\N
RN302	A350	19C	\N
RN302	A350	19D	\N
RN302	A350	19E	\N
RN302	A350	19F	\N
RN302	A350	19G	\N
RN302	A350	19H	\N
RN302	A350	19K	\N
RN302	A350	2A	\N
RN302	A350	2C	\N
RN302	A350	2D	\N
RN302	A350	2G	\N
RN302	A350	2H	\N
RN302	A350	2K	\N
RN302	A350	27A	\N
RN302	A350	27B	\N
RN302	A350	27C	\N
RN302	A350	27D	\N
RN302	A350	27E	\N
RN302	A350	27G	\N
RN302	A350	27H	\N
RN302	A350	27J	\N
RN302	A350	27K	\N
RN302	A350	28A	\N
RN302	A350	28B	\N
RN302	A350	28C	\N
RN302	A350	28D	\N
RN302	A350	28E	\N
RN302	A350	28G	\N
RN302	A350	28H	\N
RN302	A350	28J	\N
RN302	A350	28K	\N
RN302	A350	29A	\N
RN302	A350	29B	\N
RN302	A350	29C	\N
RN302	A350	29D	\N
RN302	A350	29E	\N
RN302	A350	29G	\N
RN302	A350	29H	\N
RN302	A350	29J	\N
RN302	A350	29K	\N
RN302	A350	30A	\N
RN302	A350	30B	\N
RN302	A350	30C	\N
RN302	A350	30D	\N
RN302	A350	30E	\N
RN302	A350	30G	\N
RN302	A350	30H	\N
RN302	A350	30J	\N
RN302	A350	30K	\N
RN302	A350	31A	\N
RN302	A350	31B	\N
RN302	A350	31C	\N
RN302	A350	31D	\N
RN302	A350	31E	\N
RN302	A350	31G	\N
RN302	A350	31H	\N
RN302	A350	31J	\N
RN302	A350	31K	\N
RN302	A350	32A	\N
RN302	A350	32B	\N
RN302	A350	32C	\N
RN302	A350	32D	\N
RN302	A350	32E	\N
RN302	A350	32G	\N
RN302	A350	32H	\N
RN302	A350	32J	\N
RN302	A350	32K	\N
RN302	A350	33A	\N
RN302	A350	33B	\N
RN302	A350	33C	\N
RN302	A350	33D	\N
RN302	A350	33E	\N
RN302	A350	33G	\N
RN302	A350	33H	\N
RN302	A350	33J	\N
RN302	A350	33K	\N
RN302	A350	34A	\N
RN302	A350	34B	\N
RN302	A350	34C	\N
RN302	A350	34D	\N
RN302	A350	34E	\N
RN302	A350	34G	\N
RN302	A350	34H	\N
RN302	A350	34J	\N
RN302	A350	34K	\N
RN302	A350	35A	\N
RN302	A350	35B	\N
RN302	A350	35C	\N
RN302	A350	35D	\N
RN302	A350	35E	\N
RN302	A350	35G	\N
RN302	A350	35H	\N
RN302	A350	35J	\N
RN302	A350	35K	\N
RN302	A350	36A	\N
RN302	A350	36B	\N
RN302	A350	36C	\N
RN302	A350	36D	\N
RN302	A350	36E	\N
RN302	A350	36G	\N
RN302	A350	36H	\N
RN302	A350	36J	\N
RN302	A350	36K	\N
RN302	A350	37A	\N
RN302	A350	37B	\N
RN302	A350	37C	\N
RN302	A350	37D	\N
RN302	A350	37E	\N
RN302	A350	37G	\N
RN302	A350	37H	\N
RN302	A350	37J	\N
RN302	A350	37K	\N
RN302	A350	38A	\N
RN302	A350	38B	\N
RN302	A350	38C	\N
RN302	A350	38D	\N
RN302	A350	38E	\N
RN302	A350	38G	\N
RN302	A350	38H	\N
RN302	A350	38J	\N
RN302	A350	38K	\N
RN302	A350	39A	\N
RN302	A350	39B	\N
RN302	A350	39C	\N
RN302	A350	39D	\N
RN302	A350	39E	\N
RN302	A350	39G	\N
RN302	A350	39H	\N
RN302	A350	39J	\N
RN302	A350	39K	\N
RN302	A350	40D	\N
RN302	A350	40E	\N
RN302	A350	40G	\N
RN302	A350	45A	\N
RN302	A350	45B	\N
RN302	A350	45C	\N
RN302	A350	45D	\N
RN302	A350	45E	\N
RN302	A350	45G	\N
RN302	A350	45H	\N
RN302	A350	45J	\N
RN302	A350	45K	\N
RN302	A350	46A	\N
RN302	A350	46B	\N
RN302	A350	46C	\N
RN302	A350	46D	\N
RN302	A350	46E	\N
RN302	A350	46G	\N
RN302	A350	46H	\N
RN302	A350	46J	\N
RN302	A350	46K	\N
RN302	A350	47A	\N
RN302	A350	47B	\N
RN302	A350	47C	\N
RN302	A350	47D	\N
RN302	A350	47E	\N
RN302	A350	47G	\N
RN302	A350	47H	\N
RN302	A350	47J	\N
RN302	A350	47K	\N
RN302	A350	48A	\N
RN302	A350	48B	\N
RN302	A350	48C	\N
RN302	A350	48D	\N
RN302	A350	48E	\N
RN302	A350	48G	\N
RN302	A350	48H	\N
RN302	A350	48J	\N
RN302	A350	48K	\N
RN302	A350	49A	\N
RN302	A350	49B	\N
RN302	A350	49C	\N
RN302	A350	49D	\N
RN302	A350	49E	\N
RN302	A350	49G	\N
RN302	A350	49H	\N
RN302	A350	49J	\N
RN302	A350	49K	\N
RN302	A350	5A	\N
RN302	A350	5C	\N
RN302	A350	5H	\N
RN302	A350	5K	\N
RN302	A350	50A	\N
RN302	A350	50B	\N
RN302	A350	50C	\N
RN302	A350	50D	\N
RN302	A350	50E	\N
RN302	A350	50G	\N
RN302	A350	50H	\N
RN302	A350	50J	\N
RN302	A350	50K	\N
RN302	A350	51A	\N
RN302	A350	51B	\N
RN302	A350	51C	\N
RN302	A350	51D	\N
RN302	A350	51E	\N
RN302	A350	51G	\N
RN302	A350	51H	\N
RN302	A350	51J	\N
RN302	A350	51K	\N
RN302	A350	52A	\N
RN302	A350	52B	\N
RN302	A350	52C	\N
RN302	A350	52D	\N
RN302	A350	52E	\N
RN302	A350	52G	\N
RN302	A350	52H	\N
RN302	A350	52J	\N
RN302	A350	52K	\N
RN302	A350	53A	\N
RN302	A350	53B	\N
RN302	A350	53C	\N
RN302	A350	53D	\N
RN302	A350	53E	\N
RN302	A350	53G	\N
RN302	A350	53H	\N
RN302	A350	53J	\N
RN302	A350	53K	\N
RN302	A350	54A	\N
RN302	A350	54B	\N
RN302	A350	54C	\N
RN302	A350	54D	\N
RN302	A350	54E	\N
RN302	A350	54G	\N
RN302	A350	54H	\N
RN302	A350	54J	\N
RN302	A350	54K	\N
RN302	A350	55A	\N
RN302	A350	55B	\N
RN302	A350	55C	\N
RN302	A350	55D	\N
RN302	A350	55E	\N
RN302	A350	55G	\N
RN302	A350	55H	\N
RN302	A350	55J	\N
RN302	A350	55K	\N
RN302	A350	56A	\N
RN302	A350	56B	\N
RN302	A350	56C	\N
RN302	A350	56D	\N
RN302	A350	56E	\N
RN302	A350	56G	\N
RN302	A350	56H	\N
RN302	A350	56J	\N
RN302	A350	56K	\N
RN302	A350	57A	\N
RN302	A350	57B	\N
RN302	A350	57C	\N
RN302	A350	57D	\N
RN302	A350	57E	\N
RN302	A350	57G	\N
RN302	A350	57H	\N
RN302	A350	57J	\N
RN302	A350	57K	\N
RN302	A350	58A	\N
RN302	A350	58B	\N
RN302	A350	58C	\N
RN302	A350	58D	\N
RN302	A350	58E	\N
RN302	A350	58G	\N
RN302	A350	58H	\N
RN302	A350	58J	\N
RN302	A350	58K	\N
RN302	A350	59A	\N
RN302	A350	59B	\N
RN302	A350	59C	\N
RN302	A350	59D	\N
RN302	A350	59E	\N
RN302	A350	59G	\N
RN302	A350	59H	\N
RN302	A350	59J	\N
RN302	A350	59K	\N
RN302	A350	6A	\N
RN302	A350	6C	\N
RN302	A350	6D	\N
RN302	A350	6E	\N
RN302	A350	6F	\N
RN302	A350	6G	\N
RN302	A350	6H	\N
RN302	A350	6K	\N
RN302	A350	60A	\N
RN302	A350	60C	\N
RN302	A350	60D	\N
RN302	A350	60E	\N
RN302	A350	60G	\N
RN302	A350	61D	\N
RN302	A350	61E	\N
RN302	A350	61G	\N
RN302	A350	7A	\N
RN302	A350	7C	\N
RN302	A350	7D	\N
RN302	A350	7E	\N
RN302	A350	7F	\N
RN302	A350	7G	\N
RN302	A350	7H	\N
RN302	A350	7K	\N
RN302	A350	8A	\N
RN302	A350	8C	\N
RN302	A350	8D	\N
RN302	A350	8E	\N
RN302	A350	8F	\N
RN302	A350	8G	\N
RN302	A350	8H	\N
RN302	A350	8K	\N
RN302	A350	9A	\N
RN302	A350	9C	\N
RN302	A350	9D	\N
RN302	A350	9E	\N
RN302	A350	9F	\N
RN302	A350	9G	\N
RN302	A350	9H	\N
RN302	A350	9K	\N
HR357	A350	1A	\N
HR357	A350	1C	\N
HR357	A350	1D	\N
HR357	A350	1G	\N
HR357	A350	1H	\N
HR357	A350	1K	\N
HR357	A350	10A	\N
HR357	A350	10C	\N
HR357	A350	10D	\N
HR357	A350	10E	\N
HR357	A350	10F	\N
HR357	A350	10G	\N
HR357	A350	10H	\N
HR357	A350	10K	\N
HR357	A350	11A	\N
HR357	A350	11C	\N
HR357	A350	11D	\N
HR357	A350	11E	\N
HR357	A350	11F	\N
HR357	A350	11G	\N
HR357	A350	11H	\N
HR357	A350	11K	\N
HR357	A350	12D	\N
HR357	A350	12E	\N
HR357	A350	12F	\N
HR357	A350	12G	\N
HR357	A350	15D	\N
HR357	A350	15E	\N
HR357	A350	15F	\N
HR357	A350	15G	\N
HR357	A350	15H	\N
HR357	A350	15K	\N
HR357	A350	16A	\N
HR357	A350	16C	\N
HR357	A350	16D	\N
HR357	A350	16E	\N
HR357	A350	16F	\N
HR357	A350	16G	\N
HR357	A350	16H	\N
HR357	A350	16K	\N
HR357	A350	17A	\N
HR357	A350	17C	\N
HR357	A350	17D	\N
HR357	A350	17E	\N
HR357	A350	17F	\N
HR357	A350	17G	\N
HR357	A350	17H	\N
HR357	A350	17K	\N
HR357	A350	18A	\N
HR357	A350	18C	\N
HR357	A350	18D	\N
HR357	A350	18E	\N
HR357	A350	18F	\N
HR357	A350	18G	\N
HR357	A350	18H	\N
HR357	A350	18K	\N
HR357	A350	19A	\N
HR357	A350	19C	\N
HR357	A350	19D	\N
HR357	A350	19E	\N
HR357	A350	19F	\N
HR357	A350	19G	\N
HR357	A350	19H	\N
HR357	A350	19K	\N
HR357	A350	2A	\N
HR357	A350	2C	\N
HR357	A350	2D	\N
HR357	A350	2G	\N
HR357	A350	2H	\N
HR357	A350	2K	\N
HR357	A350	27A	\N
HR357	A350	27B	\N
HR357	A350	27C	\N
HR357	A350	27D	\N
HR357	A350	27E	\N
HR357	A350	27G	\N
HR357	A350	27H	\N
HR357	A350	27J	\N
HR357	A350	27K	\N
HR357	A350	28A	\N
HR357	A350	28B	\N
HR357	A350	28C	\N
HR357	A350	28D	\N
HR357	A350	28E	\N
HR357	A350	28G	\N
HR357	A350	28H	\N
HR357	A350	28J	\N
HR357	A350	28K	\N
HR357	A350	29A	\N
HR357	A350	29B	\N
HR357	A350	29C	\N
HR357	A350	29D	\N
HR357	A350	29E	\N
HR357	A350	29G	\N
HR357	A350	29H	\N
HR357	A350	29J	\N
HR357	A350	29K	\N
HR357	A350	30A	\N
HR357	A350	30B	\N
HR357	A350	30C	\N
HR357	A350	30D	\N
HR357	A350	30E	\N
HR357	A350	30G	\N
HR357	A350	30H	\N
HR357	A350	30J	\N
HR357	A350	30K	\N
HR357	A350	31A	\N
HR357	A350	31B	\N
HR357	A350	31C	\N
HR357	A350	31D	\N
HR357	A350	31E	\N
HR357	A350	31G	\N
HR357	A350	31H	\N
HR357	A350	31J	\N
HR357	A350	31K	\N
HR357	A350	32A	\N
HR357	A350	32B	\N
HR357	A350	32C	\N
HR357	A350	32D	\N
HR357	A350	32E	\N
HR357	A350	32G	\N
HR357	A350	32H	\N
HR357	A350	32J	\N
HR357	A350	32K	\N
HR357	A350	33A	\N
HR357	A350	33B	\N
HR357	A350	33C	\N
HR357	A350	33D	\N
HR357	A350	33E	\N
HR357	A350	33G	\N
HR357	A350	33H	\N
HR357	A350	33J	\N
HR357	A350	33K	\N
HR357	A350	34A	\N
HR357	A350	34B	\N
HR357	A350	34C	\N
HR357	A350	34D	\N
HR357	A350	34E	\N
HR357	A350	34G	\N
HR357	A350	34H	\N
HR357	A350	34J	\N
HR357	A350	34K	\N
HR357	A350	35A	\N
HR357	A350	35B	\N
HR357	A350	35C	\N
HR357	A350	35D	\N
HR357	A350	35E	\N
HR357	A350	35G	\N
HR357	A350	35H	\N
HR357	A350	35J	\N
HR357	A350	35K	\N
HR357	A350	36A	\N
HR357	A350	36B	\N
HR357	A350	36C	\N
HR357	A350	36D	\N
HR357	A350	36E	\N
HR357	A350	36G	\N
HR357	A350	36H	\N
HR357	A350	36J	\N
HR357	A350	36K	\N
HR357	A350	37A	\N
HR357	A350	37B	\N
HR357	A350	37C	\N
HR357	A350	37D	\N
HR357	A350	37E	\N
HR357	A350	37G	\N
HR357	A350	37H	\N
HR357	A350	37J	\N
HR357	A350	37K	\N
HR357	A350	38A	\N
HR357	A350	38B	\N
HR357	A350	38C	\N
HR357	A350	38D	\N
HR357	A350	38E	\N
HR357	A350	38G	\N
HR357	A350	38H	\N
HR357	A350	38J	\N
HR357	A350	38K	\N
HR357	A350	39A	\N
HR357	A350	39B	\N
HR357	A350	39C	\N
HR357	A350	39D	\N
HR357	A350	39E	\N
HR357	A350	39G	\N
HR357	A350	39H	\N
HR357	A350	39J	\N
HR357	A350	39K	\N
HR357	A350	40D	\N
HR357	A350	40E	\N
HR357	A350	40G	\N
HR357	A350	45A	\N
HR357	A350	45B	\N
HR357	A350	45C	\N
HR357	A350	45D	\N
HR357	A350	45E	\N
HR357	A350	45G	\N
HR357	A350	45H	\N
HR357	A350	45J	\N
HR357	A350	45K	\N
HR357	A350	46A	\N
HR357	A350	46B	\N
HR357	A350	46C	\N
HR357	A350	46D	\N
HR357	A350	46E	\N
HR357	A350	46G	\N
HR357	A350	46H	\N
HR357	A350	46J	\N
HR357	A350	46K	\N
HR357	A350	47A	\N
HR357	A350	47B	\N
HR357	A350	47C	\N
HR357	A350	47D	\N
HR357	A350	47E	\N
HR357	A350	47G	\N
HR357	A350	47H	\N
HR357	A350	47J	\N
HR357	A350	47K	\N
HR357	A350	48A	\N
HR357	A350	48B	\N
HR357	A350	48C	\N
HR357	A350	48D	\N
HR357	A350	48E	\N
HR357	A350	48G	\N
HR357	A350	48H	\N
HR357	A350	48J	\N
HR357	A350	48K	\N
HR357	A350	49A	\N
HR357	A350	49B	\N
HR357	A350	49C	\N
HR357	A350	49D	\N
HR357	A350	49E	\N
HR357	A350	49G	\N
HR357	A350	49H	\N
HR357	A350	49J	\N
HR357	A350	49K	\N
HR357	A350	5A	\N
HR357	A350	5C	\N
HR357	A350	5H	\N
HR357	A350	5K	\N
HR357	A350	50A	\N
HR357	A350	50B	\N
HR357	A350	50C	\N
HR357	A350	50D	\N
HR357	A350	50E	\N
HR357	A350	50G	\N
HR357	A350	50H	\N
HR357	A350	50J	\N
HR357	A350	50K	\N
HR357	A350	51A	\N
HR357	A350	51B	\N
HR357	A350	51C	\N
HR357	A350	51D	\N
HR357	A350	51E	\N
HR357	A350	51G	\N
HR357	A350	51H	\N
HR357	A350	51J	\N
HR357	A350	51K	\N
HR357	A350	52A	\N
HR357	A350	52B	\N
HR357	A350	52C	\N
HR357	A350	52D	\N
HR357	A350	52E	\N
HR357	A350	52G	\N
HR357	A350	52H	\N
HR357	A350	52J	\N
HR357	A350	52K	\N
HR357	A350	53A	\N
HR357	A350	53B	\N
HR357	A350	53C	\N
HR357	A350	53D	\N
HR357	A350	53E	\N
HR357	A350	53G	\N
HR357	A350	53H	\N
HR357	A350	53J	\N
HR357	A350	53K	\N
HR357	A350	54A	\N
HR357	A350	54B	\N
HR357	A350	54C	\N
HR357	A350	54D	\N
HR357	A350	54E	\N
HR357	A350	54G	\N
HR357	A350	54H	\N
HR357	A350	54J	\N
HR357	A350	54K	\N
HR357	A350	55A	\N
HR357	A350	55B	\N
HR357	A350	55C	\N
HR357	A350	55D	\N
HR357	A350	55E	\N
HR357	A350	55G	\N
HR357	A350	55H	\N
HR357	A350	55J	\N
HR357	A350	55K	\N
HR357	A350	56A	\N
HR357	A350	56B	\N
HR357	A350	56C	\N
HR357	A350	56D	\N
HR357	A350	56E	\N
HR357	A350	56G	\N
HR357	A350	56H	\N
HR357	A350	56J	\N
HR357	A350	56K	\N
HR357	A350	57A	\N
HR357	A350	57B	\N
HR357	A350	57C	\N
HR357	A350	57D	\N
HR357	A350	57E	\N
HR357	A350	57G	\N
HR357	A350	57H	\N
HR357	A350	57J	\N
HR357	A350	57K	\N
HR357	A350	58A	\N
HR357	A350	58B	\N
HR357	A350	58C	\N
HR357	A350	58D	\N
HR357	A350	58E	\N
HR357	A350	58G	\N
HR357	A350	58H	\N
HR357	A350	58J	\N
HR357	A350	58K	\N
HR357	A350	59A	\N
HR357	A350	59B	\N
HR357	A350	59C	\N
HR357	A350	59D	\N
HR357	A350	59E	\N
HR357	A350	59G	\N
HR357	A350	59H	\N
HR357	A350	59J	\N
HR357	A350	59K	\N
HR357	A350	6A	\N
HR357	A350	6C	\N
HR357	A350	6D	\N
HR357	A350	6E	\N
HR357	A350	6F	\N
HR357	A350	6G	\N
HR357	A350	6H	\N
HR357	A350	6K	\N
HR357	A350	60A	\N
HR357	A350	60C	\N
HR357	A350	60D	\N
HR357	A350	60E	\N
HR357	A350	60G	\N
HR357	A350	61D	\N
HR357	A350	61E	\N
HR357	A350	61G	\N
HR357	A350	7A	\N
HR357	A350	7C	\N
HR357	A350	7D	\N
HR357	A350	7E	\N
HR357	A350	7F	\N
HR357	A350	7G	\N
HR357	A350	7H	\N
HR357	A350	7K	\N
HR357	A350	8A	\N
HR357	A350	8C	\N
HR357	A350	8D	\N
HR357	A350	8E	\N
HR357	A350	8F	\N
HR357	A350	8G	\N
HR357	A350	8H	\N
HR357	A350	8K	\N
HR357	A350	9A	\N
HR357	A350	9C	\N
HR357	A350	9D	\N
HR357	A350	9E	\N
HR357	A350	9F	\N
HR357	A350	9G	\N
HR357	A350	9H	\N
HR357	A350	9K	\N
VJ796	A350	1C	\N
VJ796	A350	1D	\N
VJ796	A350	1G	\N
VJ796	A350	1H	\N
VJ796	A350	1K	\N
VJ796	A350	10C	\N
VJ796	A350	10G	\N
VJ796	A350	10H	\N
VJ796	A350	10K	\N
VJ796	A350	11A	\N
VJ796	A350	11C	\N
VJ796	A350	11D	\N
VJ796	A350	11E	\N
VJ796	A350	11F	\N
VJ796	A350	11G	\N
VJ796	A350	11H	\N
VJ796	A350	11K	\N
VJ796	A350	12D	\N
VJ796	A350	12E	\N
VJ796	A350	12F	\N
VJ796	A350	12G	\N
VJ796	A350	15D	\N
VJ796	A350	15E	\N
VJ796	A350	15F	\N
VJ796	A350	15G	\N
VJ796	A350	15H	\N
VJ796	A350	15K	\N
VJ796	A350	16A	\N
VJ796	A350	16C	\N
VJ796	A350	16D	\N
VJ796	A350	16E	\N
VJ796	A350	16F	\N
VJ796	A350	16G	\N
VJ796	A350	16H	\N
VJ796	A350	16K	\N
VJ796	A350	17A	\N
VJ796	A350	17C	\N
VJ796	A350	17D	\N
VJ796	A350	17E	\N
VJ796	A350	17F	\N
VJ796	A350	17G	\N
VJ796	A350	17H	\N
VJ796	A350	17K	\N
VJ796	A350	18A	\N
VJ796	A350	18C	\N
VJ796	A350	18D	\N
VJ796	A350	18E	\N
VJ796	A350	18F	\N
VJ796	A350	18G	\N
VJ796	A350	18H	\N
VJ796	A350	18K	\N
VJ796	A350	19A	\N
VJ796	A350	19C	\N
VJ796	A350	19D	\N
VJ796	A350	19E	\N
VJ796	A350	19F	\N
VJ796	A350	19G	\N
VJ796	A350	19H	\N
VJ796	A350	19K	\N
VJ796	A350	2A	\N
VJ796	A350	2C	\N
VJ796	A350	2D	\N
VJ796	A350	2G	\N
VJ796	A350	2H	\N
VJ796	A350	2K	\N
VJ796	A350	27A	\N
VJ796	A350	27B	\N
VJ796	A350	27C	\N
VJ796	A350	27D	\N
VJ796	A350	27E	\N
VJ796	A350	27G	\N
VJ796	A350	27H	\N
VJ796	A350	27J	\N
VJ796	A350	27K	\N
VJ796	A350	28A	\N
VJ796	A350	28B	\N
VJ796	A350	28C	\N
VJ796	A350	28D	\N
VJ796	A350	28E	\N
VJ796	A350	28G	\N
VJ796	A350	28H	\N
VJ796	A350	28J	\N
VJ796	A350	28K	\N
VJ796	A350	29A	\N
VJ796	A350	29B	\N
VJ796	A350	29C	\N
VJ796	A350	29D	\N
VJ796	A350	29E	\N
VJ796	A350	29G	\N
VJ796	A350	29H	\N
VJ796	A350	29J	\N
VJ796	A350	29K	\N
VJ796	A350	30A	\N
VJ796	A350	30B	\N
VJ796	A350	30C	\N
VJ796	A350	30D	\N
VJ796	A350	30E	\N
VJ796	A350	30G	\N
VJ796	A350	30H	\N
VJ796	A350	30J	\N
VJ796	A350	30K	\N
VJ796	A350	31A	\N
VJ796	A350	31B	\N
VJ796	A350	31C	\N
VJ796	A350	31D	\N
VJ796	A350	31E	\N
VJ796	A350	31G	\N
VJ796	A350	31H	\N
VJ796	A350	31J	\N
VJ796	A350	31K	\N
VJ796	A350	32A	\N
VJ796	A350	32B	\N
VJ796	A350	32C	\N
VJ796	A350	32D	\N
VJ796	A350	32E	\N
VJ796	A350	32G	\N
VJ796	A350	32H	\N
VJ796	A350	32J	\N
VJ796	A350	32K	\N
VJ796	A350	33A	\N
VJ796	A350	33B	\N
VJ796	A350	33C	\N
VJ796	A350	33D	\N
VJ796	A350	33E	\N
VJ796	A350	33G	\N
VJ796	A350	33H	\N
VJ796	A350	33J	\N
VJ796	A350	33K	\N
VJ796	A350	34A	\N
VJ796	A350	34B	\N
VJ796	A350	34C	\N
VJ796	A350	34D	\N
VJ796	A350	34E	\N
VJ796	A350	34G	\N
VJ796	A350	34H	\N
VJ796	A350	34J	\N
VJ796	A350	34K	\N
VJ796	A350	35A	\N
VJ796	A350	35B	\N
VJ796	A350	35C	\N
VJ796	A350	35D	\N
VJ796	A350	35E	\N
VJ796	A350	35G	\N
VJ796	A350	35H	\N
VJ796	A350	35J	\N
VJ796	A350	35K	\N
VJ796	A350	36A	\N
VJ796	A350	36B	\N
VJ796	A350	36C	\N
VJ796	A350	36D	\N
VJ796	A350	36E	\N
VJ796	A350	36G	\N
VJ796	A350	36H	\N
VJ796	A350	36J	\N
VJ796	A350	36K	\N
VJ796	A350	37A	\N
VJ796	A350	37B	\N
VJ796	A350	37C	\N
VJ796	A350	37D	\N
VJ796	A350	37E	\N
VJ796	A350	37G	\N
VJ796	A350	37H	\N
VJ796	A350	37J	\N
VJ796	A350	37K	\N
VJ796	A350	38A	\N
VJ796	A350	38B	\N
VJ796	A350	38C	\N
VJ796	A350	38D	\N
VJ796	A350	38E	\N
VJ796	A350	38G	\N
VJ796	A350	38H	\N
VJ796	A350	38J	\N
VJ796	A350	38K	\N
VJ796	A350	39A	\N
VJ796	A350	39B	\N
VJ796	A350	39C	\N
VJ796	A350	39D	\N
VJ796	A350	39E	\N
VJ796	A350	39G	\N
VJ796	A350	39H	\N
VJ796	A350	39J	\N
VJ796	A350	39K	\N
VJ796	A350	40D	\N
VJ796	A350	40G	\N
VJ796	A350	45A	\N
VJ796	A350	45C	\N
VJ796	A350	45D	\N
VJ796	A350	45E	\N
VJ796	A350	45G	\N
VJ796	A350	45H	\N
VJ796	A350	45J	\N
VJ796	A350	45K	\N
VJ796	A350	46A	\N
VJ796	A350	46B	\N
VJ796	A350	46C	\N
VJ796	A350	46D	\N
VJ796	A350	46E	\N
VJ796	A350	46G	\N
VJ796	A350	46H	\N
VJ796	A350	46J	\N
VJ796	A350	46K	\N
VJ796	A350	47A	\N
VJ796	A350	47B	\N
VJ796	A350	47C	\N
VJ796	A350	47D	\N
VJ796	A350	47E	\N
VJ796	A350	47G	\N
VJ796	A350	47H	\N
VJ796	A350	47J	\N
VJ796	A350	47K	\N
VJ796	A350	48A	\N
VJ796	A350	48B	\N
VJ796	A350	48C	\N
VJ796	A350	48D	\N
VJ796	A350	48E	\N
VJ796	A350	48G	\N
VJ796	A350	48H	\N
VJ796	A350	48J	\N
VJ796	A350	48K	\N
VJ796	A350	49A	\N
VJ796	A350	49B	\N
VJ796	A350	49C	\N
VJ796	A350	49D	\N
VJ796	A350	49E	\N
VJ796	A350	49G	\N
VJ796	A350	49H	\N
VJ796	A350	49J	\N
VJ796	A350	49K	\N
VJ796	A350	5A	\N
VJ796	A350	5C	\N
VJ796	A350	5H	\N
VJ796	A350	5K	\N
VJ796	A350	50A	\N
VJ796	A350	50B	\N
VJ796	A350	50C	\N
VJ796	A350	50D	\N
VJ796	A350	50E	\N
VJ796	A350	50G	\N
VJ796	A350	50H	\N
VJ796	A350	50J	\N
VJ796	A350	50K	\N
VJ796	A350	51A	\N
VJ796	A350	51B	\N
VJ796	A350	51C	\N
VJ796	A350	51D	\N
VJ796	A350	51E	\N
VJ796	A350	51G	\N
VJ796	A350	51H	\N
VJ796	A350	51J	\N
VJ796	A350	51K	\N
VJ796	A350	52A	\N
VJ796	A350	52B	\N
VJ796	A350	52C	\N
VJ796	A350	52D	\N
VJ796	A350	52E	\N
VJ796	A350	52G	\N
VJ796	A350	52H	\N
VJ796	A350	52J	\N
VJ796	A350	52K	\N
VJ796	A350	53A	\N
VJ796	A350	53B	\N
VJ796	A350	53C	\N
VJ796	A350	53D	\N
VJ796	A350	53E	\N
VJ796	A350	53G	\N
VJ796	A350	53H	\N
VJ796	A350	53J	\N
VJ796	A350	53K	\N
VJ796	A350	54A	\N
VJ796	A350	54B	\N
VJ796	A350	54C	\N
VJ796	A350	54D	\N
VJ796	A350	54E	\N
VJ796	A350	54G	\N
VJ796	A350	54H	\N
VJ796	A350	54J	\N
VJ796	A350	54K	\N
VJ796	A350	55A	\N
VJ796	A350	55B	\N
VJ796	A350	55C	\N
VJ796	A350	55D	\N
VJ796	A350	55E	\N
VJ796	A350	55G	\N
VJ796	A350	55H	\N
VJ796	A350	55J	\N
VJ796	A350	55K	\N
VJ796	A350	56A	\N
VJ796	A350	56B	\N
VJ796	A350	56C	\N
VJ796	A350	56D	\N
VJ796	A350	56E	\N
VJ796	A350	56G	\N
VJ796	A350	56H	\N
VJ796	A350	56J	\N
VJ796	A350	56K	\N
VJ796	A350	57A	\N
VJ796	A350	57B	\N
VJ796	A350	57C	\N
VJ796	A350	57D	\N
VJ796	A350	57E	\N
VJ796	A350	57G	\N
VJ796	A350	57H	\N
VJ796	A350	57J	\N
VJ796	A350	57K	\N
VJ796	A350	58A	\N
VJ796	A350	58B	\N
VJ796	A350	58C	\N
VJ796	A350	58D	\N
VJ796	A350	58E	\N
VJ796	A350	58G	\N
VJ796	A350	58H	\N
VJ796	A350	58J	\N
VJ796	A350	58K	\N
VJ796	A350	59A	\N
VJ796	A350	59B	\N
VJ796	A350	59C	\N
VJ796	A350	59D	\N
VJ796	A350	59E	\N
VJ796	A350	59G	\N
VJ796	A350	59H	\N
VJ796	A350	59J	\N
VJ796	A350	59K	\N
VJ796	A350	6A	\N
VJ796	A350	6C	\N
VJ796	A350	6D	\N
VJ796	A350	6E	\N
VJ796	A350	6F	\N
VJ796	A350	6G	\N
VJ796	A350	6H	\N
VJ796	A350	6K	\N
VJ796	A350	60A	\N
VJ796	A350	60C	\N
VJ796	A350	60D	\N
VJ796	A350	60E	\N
VJ796	A350	60G	\N
VJ796	A350	61D	\N
VJ796	A350	61E	\N
VJ796	A350	61G	\N
VJ796	A350	7A	\N
VJ796	A350	7C	\N
VJ796	A350	7D	\N
VJ796	A350	7E	\N
VJ796	A350	7F	\N
VJ796	A350	7G	\N
VJ796	A350	7H	\N
VJ796	A350	7K	\N
VJ796	A350	8A	\N
VJ796	A350	8C	\N
VJ796	A350	8D	\N
VJ796	A350	8E	\N
VJ796	A350	8F	\N
VJ796	A350	8G	\N
VJ796	A350	8H	\N
VJ796	A350	8K	\N
VJ796	A350	9A	\N
VJ796	A350	9C	\N
VJ796	A350	9D	\N
VJ796	A350	9E	\N
VJ796	A350	9F	\N
VJ796	A350	9G	\N
VJ796	A350	9H	\N
VJ796	A350	9K	\N
QU263	A350	1C	\N
QU263	A350	1G	\N
QU263	A350	1H	\N
QU263	A350	10A	\N
QU263	A350	10C	\N
QU263	A350	10D	\N
QU263	A350	10F	\N
QU263	A350	10H	\N
QU263	A350	10K	\N
QU263	A350	11A	\N
QU263	A350	11C	\N
QU263	A350	11D	\N
QU263	A350	11E	\N
QU263	A350	11F	\N
QU263	A350	11G	\N
QU263	A350	11H	\N
QU263	A350	11K	\N
QU263	A350	12D	\N
QU263	A350	12E	\N
QU263	A350	12F	\N
QU263	A350	12G	\N
QU263	A350	15D	\N
QU263	A350	15E	\N
QU263	A350	15F	\N
QU263	A350	15G	\N
QU263	A350	15H	\N
QU263	A350	15K	\N
QU263	A350	16A	\N
QU263	A350	16C	\N
QU263	A350	16D	\N
QU263	A350	16E	\N
QU263	A350	16F	\N
QU263	A350	16G	\N
QU263	A350	16H	\N
QU263	A350	16K	\N
QU263	A350	17A	\N
QU263	A350	17C	\N
QU263	A350	17D	\N
QU263	A350	17E	\N
QU263	A350	17F	\N
QU263	A350	17G	\N
QU263	A350	17H	\N
QU263	A350	17K	\N
QU263	A350	18A	\N
QU263	A350	18C	\N
QU263	A350	18D	\N
QU263	A350	18E	\N
QU263	A350	18F	\N
QU263	A350	18G	\N
QU263	A350	18H	\N
QU263	A350	18K	\N
QU263	A350	19A	\N
QU263	A350	19C	\N
QU263	A350	19D	\N
QU263	A350	19E	\N
QU263	A350	19F	\N
QU263	A350	19G	\N
QU263	A350	19H	\N
QU263	A350	19K	\N
QU263	A350	2A	\N
QU263	A350	2C	\N
QU263	A350	2D	\N
QU263	A350	2G	\N
QU263	A350	2H	\N
QU263	A350	2K	\N
QU263	A350	27A	\N
QU263	A350	27B	\N
QU263	A350	27C	\N
QU263	A350	27D	\N
QU263	A350	27E	\N
QU263	A350	27G	\N
QU263	A350	27J	\N
QU263	A350	27K	\N
QU263	A350	28A	\N
QU263	A350	28B	\N
QU263	A350	28C	\N
QU263	A350	28D	\N
QU263	A350	28E	\N
QU263	A350	28G	\N
QU263	A350	28H	\N
QU263	A350	28J	\N
QU263	A350	28K	\N
QU263	A350	29A	\N
QU263	A350	29B	\N
QU263	A350	29C	\N
QU263	A350	29D	\N
QU263	A350	29E	\N
QU263	A350	29G	\N
QU263	A350	29H	\N
QU263	A350	29J	\N
QU263	A350	29K	\N
QU263	A350	30A	\N
QU263	A350	30B	\N
QU263	A350	30C	\N
QU263	A350	30D	\N
QU263	A350	30E	\N
QU263	A350	30G	\N
QU263	A350	30H	\N
QU263	A350	30J	\N
QU263	A350	30K	\N
QU263	A350	31A	\N
QU263	A350	31B	\N
QU263	A350	31C	\N
QU263	A350	31D	\N
QU263	A350	31E	\N
QU263	A350	31G	\N
QU263	A350	31H	\N
QU263	A350	31J	\N
QU263	A350	31K	\N
QU263	A350	32A	\N
QU263	A350	32B	\N
QU263	A350	32C	\N
QU263	A350	32D	\N
QU263	A350	32E	\N
QU263	A350	32G	\N
QU263	A350	32H	\N
QU263	A350	32J	\N
QU263	A350	32K	\N
QU263	A350	33A	\N
QU263	A350	33B	\N
QU263	A350	33C	\N
QU263	A350	33D	\N
QU263	A350	33E	\N
QU263	A350	33G	\N
QU263	A350	33H	\N
QU263	A350	33J	\N
QU263	A350	33K	\N
QU263	A350	34A	\N
QU263	A350	34B	\N
QU263	A350	34C	\N
QU263	A350	34D	\N
QU263	A350	34E	\N
QU263	A350	34G	\N
QU263	A350	34H	\N
QU263	A350	34J	\N
QU263	A350	34K	\N
QU263	A350	35A	\N
QU263	A350	35B	\N
QU263	A350	35C	\N
QU263	A350	35D	\N
QU263	A350	35E	\N
QU263	A350	35G	\N
QU263	A350	35H	\N
QU263	A350	35J	\N
QU263	A350	35K	\N
QU263	A350	36A	\N
QU263	A350	36B	\N
QU263	A350	36C	\N
QU263	A350	36D	\N
QU263	A350	36E	\N
QU263	A350	36G	\N
QU263	A350	36H	\N
QU263	A350	36J	\N
QU263	A350	36K	\N
QU263	A350	37A	\N
QU263	A350	37B	\N
QU263	A350	37C	\N
QU263	A350	37D	\N
QU263	A350	37E	\N
QU263	A350	37G	\N
QU263	A350	37H	\N
QU263	A350	37J	\N
QU263	A350	37K	\N
QU263	A350	10G	T800786
QU263	A350	38A	\N
QU263	A350	38B	\N
QU263	A350	38C	\N
QU263	A350	38D	\N
QU263	A350	38E	\N
QU263	A350	38G	\N
QU263	A350	38H	\N
QU263	A350	38J	\N
QU263	A350	38K	\N
QU263	A350	39A	\N
QU263	A350	39B	\N
QU263	A350	39C	\N
QU263	A350	39D	\N
QU263	A350	39E	\N
QU263	A350	39G	\N
QU263	A350	39H	\N
QU263	A350	39J	\N
QU263	A350	39K	\N
QU263	A350	40D	\N
QU263	A350	40E	\N
QU263	A350	40G	\N
QU263	A350	45A	\N
QU263	A350	45B	\N
QU263	A350	45C	\N
QU263	A350	45D	\N
QU263	A350	45E	\N
QU263	A350	45G	\N
QU263	A350	45H	\N
QU263	A350	45J	\N
QU263	A350	45K	\N
QU263	A350	46A	\N
QU263	A350	46B	\N
QU263	A350	46C	\N
QU263	A350	46D	\N
QU263	A350	46E	\N
QU263	A350	46G	\N
QU263	A350	46H	\N
QU263	A350	46J	\N
QU263	A350	46K	\N
QU263	A350	47A	\N
QU263	A350	47B	\N
QU263	A350	47C	\N
QU263	A350	47D	\N
QU263	A350	47E	\N
QU263	A350	47G	\N
QU263	A350	47H	\N
QU263	A350	47J	\N
QU263	A350	47K	\N
QU263	A350	48A	\N
QU263	A350	48B	\N
QU263	A350	48C	\N
QU263	A350	48D	\N
QU263	A350	48E	\N
QU263	A350	48G	\N
QU263	A350	48H	\N
QU263	A350	48J	\N
QU263	A350	48K	\N
QU263	A350	49A	\N
QU263	A350	49B	\N
QU263	A350	49C	\N
QU263	A350	49D	\N
QU263	A350	49E	\N
QU263	A350	49G	\N
QU263	A350	49H	\N
QU263	A350	49J	\N
QU263	A350	49K	\N
QU263	A350	5A	\N
QU263	A350	5C	\N
QU263	A350	5H	\N
QU263	A350	5K	\N
QU263	A350	50A	\N
QU263	A350	50B	\N
QU263	A350	50C	\N
QU263	A350	50D	\N
QU263	A350	50E	\N
QU263	A350	50G	\N
QU263	A350	50H	\N
QU263	A350	50J	\N
QU263	A350	50K	\N
QU263	A350	51A	\N
QU263	A350	51B	\N
QU263	A350	51C	\N
QU263	A350	51D	\N
QU263	A350	51E	\N
QU263	A350	51G	\N
QU263	A350	51H	\N
QU263	A350	51J	\N
QU263	A350	51K	\N
QU263	A350	52A	\N
QU263	A350	52B	\N
QU263	A350	52C	\N
QU263	A350	52D	\N
QU263	A350	52E	\N
QU263	A350	52G	\N
QU263	A350	52H	\N
QU263	A350	52J	\N
QU263	A350	52K	\N
QU263	A350	53A	\N
QU263	A350	53B	\N
QU263	A350	53C	\N
QU263	A350	53D	\N
QU263	A350	53E	\N
QU263	A350	53G	\N
QU263	A350	53H	\N
QU263	A350	53J	\N
QU263	A350	53K	\N
QU263	A350	54A	\N
QU263	A350	54B	\N
QU263	A350	54C	\N
QU263	A350	54D	\N
QU263	A350	54E	\N
QU263	A350	54G	\N
QU263	A350	54H	\N
QU263	A350	54J	\N
QU263	A350	54K	\N
QU263	A350	55A	\N
QU263	A350	55B	\N
QU263	A350	55C	\N
QU263	A350	55D	\N
QU263	A350	55E	\N
QU263	A350	55G	\N
QU263	A350	55H	\N
QU263	A350	55J	\N
QU263	A350	55K	\N
QU263	A350	56A	\N
QU263	A350	56B	\N
QU263	A350	56C	\N
QU263	A350	56D	\N
QU263	A350	56E	\N
QU263	A350	56G	\N
QU263	A350	56H	\N
QU263	A350	56J	\N
QU263	A350	56K	\N
QU263	A350	57A	\N
QU263	A350	57B	\N
QU263	A350	57C	\N
QU263	A350	57D	\N
QU263	A350	57E	\N
QU263	A350	57G	\N
QU263	A350	57H	\N
QU263	A350	57J	\N
QU263	A350	57K	\N
QU263	A350	58A	\N
QU263	A350	58B	\N
QU263	A350	58C	\N
QU263	A350	58D	\N
QU263	A350	58E	\N
QU263	A350	58G	\N
QU263	A350	58H	\N
QU263	A350	58J	\N
QU263	A350	58K	\N
QU263	A350	59A	\N
QU263	A350	59B	\N
QU263	A350	59C	\N
QU263	A350	59D	\N
QU263	A350	59E	\N
QU263	A350	59G	\N
QU263	A350	59H	\N
QU263	A350	59J	\N
QU263	A350	59K	\N
QU263	A350	6A	\N
QU263	A350	6C	\N
QU263	A350	6D	\N
QU263	A350	6E	\N
QU263	A350	6F	\N
QU263	A350	6G	\N
QU263	A350	6H	\N
QU263	A350	6K	\N
QU263	A350	60A	\N
QU263	A350	60C	\N
QU263	A350	60D	\N
QU263	A350	60E	\N
QU263	A350	60G	\N
QU263	A350	61D	\N
QU263	A350	61E	\N
QU263	A350	61G	\N
QU263	A350	7A	\N
QU263	A350	7C	\N
QU263	A350	7D	\N
QU263	A350	7E	\N
QU263	A350	7F	\N
QU263	A350	7G	\N
QU263	A350	7H	\N
QU263	A350	7K	\N
QU263	A350	8A	\N
QU263	A350	8C	\N
QU263	A350	8D	\N
QU263	A350	8E	\N
QU263	A350	8F	\N
QU263	A350	8G	\N
QU263	A350	8H	\N
QU263	A350	8K	\N
QU263	A350	9A	\N
QU263	A350	9C	\N
QU263	A350	9D	\N
QU263	A350	9E	\N
QU263	A350	9F	\N
QU263	A350	9G	\N
QU263	A350	9H	\N
QU263	A350	9K	\N
CR158	A350	1A	\N
CR158	A350	1C	\N
CR158	A350	1H	\N
CR158	A350	1K	\N
CR158	A350	10D	\N
CR158	A350	10E	\N
CR158	A350	10G	\N
CR158	A350	10H	\N
CR158	A350	10K	\N
CR158	A350	11A	\N
CR158	A350	11C	\N
CR158	A350	11D	\N
CR158	A350	11E	\N
CR158	A350	11F	\N
CR158	A350	11G	\N
CR158	A350	11H	\N
CR158	A350	11K	\N
CR158	A350	12D	\N
CR158	A350	12E	\N
CR158	A350	12F	\N
CR158	A350	12G	\N
CR158	A350	15D	\N
CR158	A350	15E	\N
CR158	A350	15F	\N
CR158	A350	15G	\N
CR158	A350	15H	\N
CR158	A350	15K	\N
CR158	A350	16A	\N
CR158	A350	16C	\N
CR158	A350	16D	\N
CR158	A350	16E	\N
CR158	A350	16F	\N
CR158	A350	16G	\N
CR158	A350	16H	\N
CR158	A350	16K	\N
CR158	A350	17A	\N
CR158	A350	17C	\N
CR158	A350	17D	\N
CR158	A350	17E	\N
CR158	A350	17F	\N
CR158	A350	17G	\N
CR158	A350	17H	\N
CR158	A350	17K	\N
CR158	A350	18A	\N
CR158	A350	18C	\N
CR158	A350	18D	\N
CR158	A350	18E	\N
CR158	A350	18F	\N
CR158	A350	18G	\N
CR158	A350	18H	\N
CR158	A350	18K	\N
CR158	A350	19A	\N
CR158	A350	19C	\N
CR158	A350	19D	\N
CR158	A350	19E	\N
CR158	A350	19F	\N
CR158	A350	19G	\N
CR158	A350	19H	\N
CR158	A350	19K	\N
CR158	A350	2A	\N
CR158	A350	2C	\N
CR158	A350	2D	\N
CR158	A350	2G	\N
CR158	A350	2H	\N
CR158	A350	2K	\N
CR158	A350	27A	\N
CR158	A350	27B	\N
CR158	A350	27C	\N
CR158	A350	27D	\N
CR158	A350	27E	\N
CR158	A350	27G	\N
CR158	A350	27H	\N
CR158	A350	27J	\N
CR158	A350	27K	\N
CR158	A350	28A	\N
CR158	A350	28B	\N
CR158	A350	28C	\N
CR158	A350	28D	\N
CR158	A350	28E	\N
CR158	A350	28G	\N
CR158	A350	28H	\N
CR158	A350	28J	\N
CR158	A350	28K	\N
CR158	A350	29A	\N
CR158	A350	29B	\N
CR158	A350	29C	\N
CR158	A350	29D	\N
CR158	A350	29E	\N
CR158	A350	29G	\N
CR158	A350	29H	\N
CR158	A350	29J	\N
CR158	A350	29K	\N
CR158	A350	30A	\N
CR158	A350	30B	\N
CR158	A350	30C	\N
CR158	A350	30D	\N
CR158	A350	30E	\N
CR158	A350	30G	\N
CR158	A350	30H	\N
CR158	A350	30J	\N
CR158	A350	30K	\N
CR158	A350	31A	\N
CR158	A350	31B	\N
CR158	A350	31C	\N
CR158	A350	31D	\N
CR158	A350	31E	\N
CR158	A350	31G	\N
CR158	A350	31H	\N
CR158	A350	31J	\N
CR158	A350	31K	\N
CR158	A350	32A	\N
CR158	A350	32B	\N
CR158	A350	32C	\N
CR158	A350	32D	\N
CR158	A350	32E	\N
CR158	A350	32G	\N
CR158	A350	32H	\N
CR158	A350	32J	\N
CR158	A350	32K	\N
CR158	A350	33A	\N
CR158	A350	33B	\N
CR158	A350	33C	\N
CR158	A350	33D	\N
CR158	A350	33E	\N
CR158	A350	33G	\N
CR158	A350	33H	\N
CR158	A350	33J	\N
CR158	A350	33K	\N
CR158	A350	34A	\N
CR158	A350	34B	\N
CR158	A350	34C	\N
CR158	A350	34D	\N
CR158	A350	34E	\N
CR158	A350	34G	\N
CR158	A350	34H	\N
CR158	A350	34J	\N
CR158	A350	34K	\N
CR158	A350	35A	\N
CR158	A350	35B	\N
CR158	A350	35C	\N
CR158	A350	35D	\N
CR158	A350	35E	\N
CR158	A350	35G	\N
CR158	A350	35H	\N
CR158	A350	35J	\N
CR158	A350	35K	\N
CR158	A350	36A	\N
CR158	A350	36B	\N
CR158	A350	36C	\N
CR158	A350	36D	\N
CR158	A350	36E	\N
CR158	A350	36G	\N
CR158	A350	36H	\N
CR158	A350	36J	\N
CR158	A350	36K	\N
CR158	A350	37A	\N
CR158	A350	37B	\N
CR158	A350	37C	\N
CR158	A350	37D	\N
CR158	A350	37E	\N
CR158	A350	37G	\N
CR158	A350	37H	\N
CR158	A350	37J	\N
CR158	A350	37K	\N
CR158	A350	38A	\N
CR158	A350	54A	\N
CR158	A350	38B	\N
CR158	A350	38C	\N
CR158	A350	38D	\N
CR158	A350	38E	\N
CR158	A350	38G	\N
CR158	A350	38H	\N
CR158	A350	38J	\N
CR158	A350	38K	\N
CR158	A350	39A	\N
CR158	A350	39B	\N
CR158	A350	39C	\N
CR158	A350	39D	\N
CR158	A350	39E	\N
CR158	A350	39G	\N
CR158	A350	39H	\N
CR158	A350	39J	\N
CR158	A350	39K	\N
CR158	A350	40D	\N
CR158	A350	40E	\N
CR158	A350	40G	\N
CR158	A350	45A	\N
CR158	A350	45B	\N
CR158	A350	45C	\N
CR158	A350	45D	\N
CR158	A350	45E	\N
CR158	A350	45G	\N
CR158	A350	45H	\N
CR158	A350	45J	\N
CR158	A350	45K	\N
CR158	A350	46A	\N
CR158	A350	46B	\N
CR158	A350	46C	\N
CR158	A350	46D	\N
CR158	A350	46E	\N
CR158	A350	46G	\N
CR158	A350	46H	\N
CR158	A350	46J	\N
CR158	A350	46K	\N
CR158	A350	47A	\N
CR158	A350	47B	\N
CR158	A350	47C	\N
CR158	A350	47D	\N
CR158	A350	47E	\N
CR158	A350	47G	\N
CR158	A350	47H	\N
CR158	A350	47J	\N
CR158	A350	47K	\N
CR158	A350	48A	\N
CR158	A350	48B	\N
CR158	A350	48C	\N
CR158	A350	48D	\N
CR158	A350	48E	\N
CR158	A350	48G	\N
CR158	A350	48H	\N
CR158	A350	48J	\N
CR158	A350	48K	\N
CR158	A350	49A	\N
CR158	A350	49B	\N
CR158	A350	49C	\N
CR158	A350	49D	\N
CR158	A350	49E	\N
CR158	A350	49G	\N
CR158	A350	49H	\N
CR158	A350	49J	\N
CR158	A350	49K	\N
CR158	A350	5A	\N
CR158	A350	5C	\N
CR158	A350	5H	\N
CR158	A350	5K	\N
CR158	A350	50A	\N
CR158	A350	50B	\N
CR158	A350	50C	\N
CR158	A350	50D	\N
CR158	A350	50E	\N
CR158	A350	50G	\N
CR158	A350	50H	\N
CR158	A350	50J	\N
CR158	A350	50K	\N
CR158	A350	51A	\N
CR158	A350	51B	\N
CR158	A350	51C	\N
CR158	A350	51D	\N
CR158	A350	51E	\N
CR158	A350	51G	\N
CR158	A350	51H	\N
CR158	A350	51J	\N
CR158	A350	51K	\N
CR158	A350	52A	\N
CR158	A350	52B	\N
CR158	A350	52C	\N
CR158	A350	52D	\N
CR158	A350	52E	\N
CR158	A350	52G	\N
CR158	A350	52H	\N
CR158	A350	52J	\N
CR158	A350	52K	\N
CR158	A350	53A	\N
CR158	A350	53B	\N
CR158	A350	53C	\N
CR158	A350	53D	\N
CR158	A350	53E	\N
CR158	A350	53G	\N
CR158	A350	53H	\N
CR158	A350	53J	\N
CR158	A350	53K	\N
CR158	A350	54B	\N
CR158	A350	54C	\N
CR158	A350	54D	\N
CR158	A350	54E	\N
CR158	A350	54G	\N
CR158	A350	54H	\N
CR158	A350	54J	\N
CR158	A350	54K	\N
CR158	A350	55A	\N
CR158	A350	55B	\N
CR158	A350	55C	\N
CR158	A350	55D	\N
CR158	A350	55E	\N
CR158	A350	55G	\N
CR158	A350	55H	\N
CR158	A350	55J	\N
CR158	A350	55K	\N
CR158	A350	56A	\N
CR158	A350	56B	\N
CR158	A350	56C	\N
CR158	A350	56D	\N
CR158	A350	56E	\N
CR158	A350	56G	\N
CR158	A350	56H	\N
CR158	A350	56J	\N
CR158	A350	56K	\N
CR158	A350	57A	\N
CR158	A350	57B	\N
CR158	A350	57C	\N
CR158	A350	57D	\N
CR158	A350	57E	\N
CR158	A350	57G	\N
CR158	A350	57H	\N
CR158	A350	57J	\N
CR158	A350	57K	\N
CR158	A350	58A	\N
CR158	A350	58B	\N
CR158	A350	58C	\N
CR158	A350	58D	\N
CR158	A350	58E	\N
CR158	A350	58G	\N
CR158	A350	58H	\N
CR158	A350	58J	\N
CR158	A350	58K	\N
CR158	A350	59A	\N
CR158	A350	59B	\N
CR158	A350	59C	\N
CR158	A350	59D	\N
CR158	A350	59E	\N
CR158	A350	59G	\N
CR158	A350	59H	\N
CR158	A350	59J	\N
CR158	A350	59K	\N
CR158	A350	6A	\N
CR158	A350	6C	\N
CR158	A350	6D	\N
CR158	A350	6E	\N
CR158	A350	6F	\N
CR158	A350	6G	\N
CR158	A350	6H	\N
CR158	A350	6K	\N
CR158	A350	60A	\N
CR158	A350	60C	\N
CR158	A350	60D	\N
CR158	A350	60E	\N
CR158	A350	60G	\N
CR158	A350	61D	\N
CR158	A350	61E	\N
CR158	A350	61G	\N
CR158	A350	7A	\N
CR158	A350	7C	\N
CR158	A350	7D	\N
CR158	A350	7E	\N
CR158	A350	7F	\N
CR158	A350	7G	\N
CR158	A350	7H	\N
CR158	A350	7K	\N
CR158	A350	8A	\N
QU263	A350	10E	T679344
CR158	A350	8C	\N
CR158	A350	8D	\N
CR158	A350	8E	\N
CR158	A350	8F	\N
CR158	A350	8G	\N
CR158	A350	8H	\N
CR158	A350	8K	\N
CR158	A350	9A	\N
CR158	A350	9C	\N
CR158	A350	9D	\N
CR158	A350	9E	\N
CR158	A350	9F	\N
CR158	A350	9G	\N
CR158	A350	9H	\N
CR158	A350	9K	\N
ZE355	A380	1A	\N
ZE355	A380	1E	\N
ZE355	A380	10B	\N
ZE355	A380	10D	\N
ZE355	A380	10G	\N
ZE355	A380	10J	\N
ZE355	A380	11A	\N
ZE355	A380	11E	\N
ZE355	A380	11F	\N
ZE355	A380	11K	\N
ZE355	A380	12B	\N
ZE355	A380	12D	\N
ZE355	A380	12G	\N
ZE355	A380	12J	\N
ZE355	A380	14A	\N
ZE355	A380	14E	\N
ZE355	A380	14F	\N
ZE355	A380	14K	\N
ZE355	A380	15B	\N
ZE355	A380	15D	\N
ZE355	A380	15G	\N
ZE355	A380	15J	\N
ZE355	A380	16A	\N
ZE355	A380	16E	\N
ZE355	A380	16F	\N
ZE355	A380	16K	\N
ZE355	A380	17B	\N
ZE355	A380	17D	\N
ZE355	A380	17G	\N
ZE355	A380	17J	\N
ZE355	A380	18A	\N
ZE355	A380	18E	\N
ZE355	A380	18F	\N
ZE355	A380	19B	\N
ZE355	A380	19D	\N
ZE355	A380	19G	\N
ZE355	A380	19J	\N
ZE355	A380	2A	\N
ZE355	A380	2F	\N
ZE355	A380	2K	\N
ZE355	A380	20A	\N
ZE355	A380	20E	\N
ZE355	A380	20F	\N
ZE355	A380	20K	\N
ZE355	A380	21B	\N
ZE355	A380	21D	\N
ZE355	A380	21G	\N
ZE355	A380	21J	\N
ZE355	A380	22D	\N
ZE355	A380	22G	\N
ZE355	A380	23A	\N
ZE355	A380	23E	\N
ZE355	A380	23F	\N
ZE355	A380	23K	\N
ZE355	A380	24B	\N
ZE355	A380	24D	\N
ZE355	A380	24G	\N
ZE355	A380	25A	\N
ZE355	A380	25E	\N
ZE355	A380	25F	\N
ZE355	A380	25K	\N
ZE355	A380	26B	\N
ZE355	A380	26D	\N
ZE355	A380	26G	\N
ZE355	A380	26J	\N
ZE355	A380	3A	\N
ZE355	A380	3K	\N
ZE355	A380	4A	\N
ZE355	A380	4K	\N
ZE355	A380	43A	\N
ZE355	A380	43B	\N
ZE355	A380	43C	\N
ZE355	A380	43H	\N
ZE355	A380	43J	\N
ZE355	A380	43K	\N
ZE355	A380	44A	\N
ZE355	A380	44B	\N
ZE355	A380	44C	\N
ZE355	A380	44J	\N
ZE355	A380	44K	\N
ZE355	A380	45A	\N
ZE355	A380	45B	\N
ZE355	A380	45C	\N
ZE355	A380	45D	\N
ZE355	A380	45E	\N
ZE355	A380	45F	\N
ZE355	A380	45G	\N
ZE355	A380	45H	\N
ZE355	A380	45J	\N
ZE355	A380	45K	\N
ZE355	A380	46A	\N
ZE355	A380	46B	\N
ZE355	A380	46C	\N
ZE355	A380	46D	\N
ZE355	A380	46E	\N
ZE355	A380	46F	\N
ZE355	A380	46G	\N
ZE355	A380	46H	\N
ZE355	A380	46J	\N
ZE355	A380	46K	\N
ZE355	A380	47A	\N
ZE355	A380	47B	\N
ZE355	A380	47C	\N
ZE355	A380	47D	\N
ZE355	A380	47E	\N
ZE355	A380	47F	\N
ZE355	A380	47G	\N
ZE355	A380	47H	\N
ZE355	A380	47J	\N
ZE355	A380	47K	\N
ZE355	A380	48A	\N
ZE355	A380	48B	\N
ZE355	A380	48C	\N
ZE355	A380	48D	\N
ZE355	A380	48E	\N
ZE355	A380	48F	\N
ZE355	A380	48G	\N
ZE355	A380	48H	\N
ZE355	A380	48J	\N
ZE355	A380	48K	\N
ZE355	A380	49A	\N
ZE355	A380	49B	\N
ZE355	A380	49C	\N
ZE355	A380	49D	\N
ZE355	A380	49E	\N
ZE355	A380	49F	\N
ZE355	A380	49G	\N
ZE355	A380	49H	\N
ZE355	A380	49J	\N
ZE355	A380	49K	\N
ZE355	A380	50A	\N
ZE355	A380	50B	\N
ZE355	A380	50C	\N
ZE355	A380	50D	\N
ZE355	A380	50E	\N
ZE355	A380	50F	\N
ZE355	A380	50G	\N
ZE355	A380	50H	\N
ZE355	A380	50J	\N
ZE355	A380	50K	\N
ZE355	A380	51D	\N
ZE355	A380	51E	\N
ZE355	A380	51F	\N
ZE355	A380	51G	\N
ZE355	A380	52A	\N
ZE355	A380	52B	\N
ZE355	A380	52C	\N
ZE355	A380	52H	\N
ZE355	A380	52J	\N
ZE355	A380	52K	\N
ZE355	A380	53A	\N
ZE355	A380	53B	\N
ZE355	A380	53C	\N
ZE355	A380	53H	\N
ZE355	A380	53J	\N
ZE355	A380	53K	\N
ZE355	A380	54A	\N
ZE355	A380	54B	\N
ZE355	A380	54C	\N
ZE355	A380	54D	\N
ZE355	A380	54E	\N
ZE355	A380	54F	\N
ZE355	A380	54G	\N
ZE355	A380	3F	T275950
ZE355	A380	54H	\N
ZE355	A380	54J	\N
ZE355	A380	54K	\N
ZE355	A380	55A	\N
ZE355	A380	55B	\N
ZE355	A380	55C	\N
ZE355	A380	55D	\N
ZE355	A380	55E	\N
ZE355	A380	55F	\N
ZE355	A380	55G	\N
ZE355	A380	55H	\N
ZE355	A380	55J	\N
ZE355	A380	55K	\N
ZE355	A380	56A	\N
ZE355	A380	56B	\N
ZE355	A380	56C	\N
ZE355	A380	56D	\N
ZE355	A380	56E	\N
ZE355	A380	56F	\N
ZE355	A380	56G	\N
ZE355	A380	56H	\N
ZE355	A380	56J	\N
ZE355	A380	56K	\N
ZE355	A380	57A	\N
ZE355	A380	57B	\N
ZE355	A380	57C	\N
ZE355	A380	57D	\N
ZE355	A380	57E	\N
ZE355	A380	57F	\N
ZE355	A380	57G	\N
ZE355	A380	57H	\N
ZE355	A380	57J	\N
ZE355	A380	57K	\N
ZE355	A380	58A	\N
ZE355	A380	58B	\N
ZE355	A380	58C	\N
ZE355	A380	58D	\N
ZE355	A380	58E	\N
ZE355	A380	58F	\N
ZE355	A380	58G	\N
ZE355	A380	58H	\N
ZE355	A380	58J	\N
ZE355	A380	58K	\N
ZE355	A380	59A	\N
ZE355	A380	59B	\N
ZE355	A380	59C	\N
ZE355	A380	18K	T880586
ZE355	A380	59D	\N
ZE355	A380	59E	\N
ZE355	A380	59F	\N
ZE355	A380	59G	\N
ZE355	A380	59H	\N
ZE355	A380	59J	\N
ZE355	A380	59K	\N
ZE355	A380	6D	\N
ZE355	A380	6G	\N
ZE355	A380	60A	\N
ZE355	A380	60B	\N
ZE355	A380	60C	\N
ZE355	A380	60D	\N
ZE355	A380	60E	\N
ZE355	A380	60F	\N
ZE355	A380	60G	\N
ZE355	A380	60H	\N
ZE355	A380	60J	\N
ZE355	A380	60K	\N
ZE355	A380	61A	\N
ZE355	A380	61B	\N
ZE355	A380	61C	\N
ZE355	A380	61D	\N
ZE355	A380	61E	\N
ZE355	A380	61F	\N
ZE355	A380	61G	\N
ZE355	A380	61H	\N
ZE355	A380	61J	\N
ZE355	A380	61K	\N
ZE355	A380	62A	\N
ZE355	A380	62B	\N
ZE355	A380	62C	\N
ZE355	A380	62D	\N
ZE355	A380	62E	\N
ZE355	A380	62F	\N
ZE355	A380	62G	\N
ZE355	A380	62H	\N
ZE355	A380	62J	\N
ZE355	A380	62K	\N
ZE355	A380	63A	\N
ZE355	A380	63B	\N
ZE355	A380	63C	\N
ZE355	A380	63D	\N
ZE355	A380	63E	\N
ZE355	A380	63F	\N
ZE355	A380	63G	\N
ZE355	A380	63H	\N
ZE355	A380	63J	\N
ZE355	A380	63K	\N
ZE355	A380	64A	\N
ZE355	A380	64B	\N
ZE355	A380	64C	\N
ZE355	A380	64D	\N
ZE355	A380	64E	\N
ZE355	A380	64F	\N
ZE355	A380	64G	\N
ZE355	A380	64H	\N
ZE355	A380	64J	\N
ZE355	A380	64K	\N
ZE355	A380	65A	\N
ZE355	A380	65B	\N
ZE355	A380	65C	\N
ZE355	A380	65D	\N
ZE355	A380	65E	\N
ZE355	A380	65F	\N
ZE355	A380	65G	\N
ZE355	A380	65H	\N
ZE355	A380	65J	\N
ZE355	A380	65K	\N
ZE355	A380	66H	\N
ZE355	A380	66J	\N
ZE355	A380	66K	\N
ZE355	A380	67B	\N
ZE355	A380	67C	\N
ZE355	A380	67D	\N
ZE355	A380	67E	\N
ZE355	A380	67F	\N
ZE355	A380	67G	\N
ZE355	A380	67H	\N
ZE355	A380	67J	\N
ZE355	A380	68A	\N
ZE355	A380	68B	\N
ZE355	A380	68C	\N
ZE355	A380	68D	\N
ZE355	A380	68E	\N
ZE355	A380	68F	\N
ZE355	A380	68G	\N
ZE355	A380	68H	\N
ZE355	A380	68J	\N
ZE355	A380	68K	\N
ZE355	A380	69A	\N
ZE355	A380	69B	\N
ZE355	A380	69C	\N
ZE355	A380	69D	\N
ZE355	A380	69E	\N
ZE355	A380	69F	\N
ZE355	A380	69G	\N
ZE355	A380	69H	\N
ZE355	A380	69J	\N
ZE355	A380	69K	\N
ZE355	A380	7A	\N
ZE355	A380	7E	\N
ZE355	A380	7F	\N
ZE355	A380	7K	\N
ZE355	A380	70A	\N
ZE355	A380	70B	\N
ZE355	A380	70C	\N
ZE355	A380	70D	\N
ZE355	A380	70E	\N
ZE355	A380	70F	\N
ZE355	A380	70G	\N
ZE355	A380	70H	\N
ZE355	A380	70J	\N
ZE355	A380	70K	\N
ZE355	A380	71A	\N
ZE355	A380	71B	\N
ZE355	A380	71C	\N
ZE355	A380	71D	\N
ZE355	A380	71E	\N
ZE355	A380	71F	\N
ZE355	A380	71G	\N
ZE355	A380	71H	\N
ZE355	A380	71J	\N
ZE355	A380	71K	\N
ZE355	A380	72A	\N
ZE355	A380	72B	\N
ZE355	A380	72C	\N
ZE355	A380	72D	\N
ZE355	A380	72E	\N
ZE355	A380	72F	\N
ZE355	A380	72G	\N
ZE355	A380	72H	\N
ZE355	A380	72J	\N
ZE355	A380	72K	\N
ZE355	A380	73A	\N
ZE355	A380	73B	\N
ZE355	A380	73C	\N
ZE355	A380	73D	\N
ZE355	A380	73E	\N
ZE355	A380	73F	\N
ZE355	A380	73G	\N
ZE355	A380	73H	\N
ZE355	A380	73J	\N
ZE355	A380	73K	\N
ZE355	A380	74A	\N
ZE355	A380	74B	\N
ZE355	A380	74C	\N
ZE355	A380	74D	\N
ZE355	A380	74E	\N
ZE355	A380	74F	\N
ZE355	A380	74G	\N
ZE355	A380	74H	\N
ZE355	A380	74J	\N
ZE355	A380	74K	\N
ZE355	A380	75A	\N
ZE355	A380	75B	\N
ZE355	A380	75C	\N
ZE355	A380	75D	\N
ZE355	A380	75E	\N
ZE355	A380	75F	\N
ZE355	A380	75G	\N
ZE355	A380	75H	\N
ZE355	A380	75J	\N
ZE355	A380	75K	\N
ZE355	A380	76A	\N
ZE355	A380	76B	\N
ZE355	A380	76C	\N
ZE355	A380	76D	\N
ZE355	A380	76E	\N
ZE355	A380	76F	\N
ZE355	A380	76G	\N
ZE355	A380	76H	\N
ZE355	A380	76J	\N
ZE355	A380	76K	\N
ZE355	A380	77A	\N
ZE355	A380	77B	\N
ZE355	A380	77C	\N
ZE355	A380	77D	\N
ZE355	A380	77E	\N
ZE355	A380	77F	\N
ZE355	A380	77G	\N
ZE355	A380	77H	\N
ZE355	A380	77J	\N
ZE355	A380	77K	\N
ZE355	A380	78A	\N
ZE355	A380	78B	\N
ZE355	A380	78C	\N
ZE355	A380	78D	\N
ZE355	A380	78E	\N
ZE355	A380	78F	\N
ZE355	A380	78G	\N
ZE355	A380	78H	\N
ZE355	A380	78J	\N
ZE355	A380	78K	\N
ZE355	A380	79A	\N
ZE355	A380	79B	\N
ZE355	A380	79C	\N
ZE355	A380	79H	\N
ZE355	A380	79J	\N
ZE355	A380	79K	\N
ZE355	A380	8B	\N
ZE355	A380	8D	\N
ZE355	A380	8G	\N
ZE355	A380	8J	\N
ZE355	A380	80B	\N
ZE355	A380	80C	\N
ZE355	A380	80H	\N
ZE355	A380	80J	\N
ZE355	A380	81A	\N
ZE355	A380	81B	\N
ZE355	A380	81C	\N
ZE355	A380	81H	\N
ZE355	A380	81J	\N
ZE355	A380	81K	\N
ZE355	A380	82A	\N
ZE355	A380	82B	\N
ZE355	A380	82C	\N
ZE355	A380	82D	\N
ZE355	A380	82E	\N
ZE355	A380	82F	\N
ZE355	A380	82G	\N
ZE355	A380	82H	\N
ZE355	A380	82J	\N
ZE355	A380	82K	\N
ZE355	A380	83A	\N
ZE355	A380	83B	\N
ZE355	A380	83C	\N
ZE355	A380	83D	\N
ZE355	A380	83E	\N
ZE355	A380	83F	\N
ZE355	A380	83G	\N
ZE355	A380	83H	\N
ZE355	A380	83J	\N
ZE355	A380	83K	\N
ZE355	A380	84A	\N
ZE355	A380	84B	\N
ZE355	A380	84C	\N
ZE355	A380	84D	\N
ZE355	A380	84E	\N
ZE355	A380	84F	\N
ZE355	A380	84G	\N
ZE355	A380	84H	\N
ZE355	A380	84J	\N
ZE355	A380	84K	\N
ZE355	A380	85A	\N
ZE355	A380	85B	\N
ZE355	A380	85C	\N
ZE355	A380	85H	\N
ZE355	A380	85J	\N
ZE355	A380	85K	\N
ZE355	A380	86A	\N
ZE355	A380	86B	\N
ZE355	A380	86C	\N
ZE355	A380	86H	\N
ZE355	A380	86J	\N
ZE355	A380	86K	\N
ZE355	A380	87A	\N
ZE355	A380	87B	\N
ZE355	A380	87C	\N
ZE355	A380	87H	\N
ZE355	A380	87J	\N
ZE355	A380	87K	\N
ZE355	A380	88A	\N
ZE355	A380	88B	\N
ZE355	A380	88C	\N
ZE355	A380	88H	\N
ZE355	A380	88J	\N
ZE355	A380	88K	\N
ZE355	A380	9A	\N
ZE355	A380	9E	\N
ZE355	A380	9F	\N
ZE355	A380	9K	\N
OQ831	A350	1D	\N
OQ831	A350	1G	\N
OQ831	A350	1H	\N
OQ831	A350	10A	\N
OQ831	A350	10C	\N
OQ831	A350	10D	\N
OQ831	A350	10E	\N
OQ831	A350	10G	\N
OQ831	A350	10H	\N
OQ831	A350	11A	\N
OQ831	A350	11C	\N
OQ831	A350	11D	\N
OQ831	A350	11E	\N
OQ831	A350	11F	\N
OQ831	A350	11G	\N
OQ831	A350	11H	\N
OQ831	A350	11K	\N
OQ831	A350	12D	\N
OQ831	A350	12E	\N
OQ831	A350	12F	\N
OQ831	A350	12G	\N
OQ831	A350	15D	\N
OQ831	A350	15E	\N
OQ831	A350	15F	\N
OQ831	A350	15G	\N
OQ831	A350	15H	\N
OQ831	A350	15K	\N
OQ831	A350	16A	\N
OQ831	A350	16C	\N
OQ831	A350	16D	\N
OQ831	A350	16E	\N
OQ831	A350	16F	\N
OQ831	A350	16G	\N
OQ831	A350	16H	\N
OQ831	A350	16K	\N
OQ831	A350	17A	\N
OQ831	A350	17C	\N
OQ831	A350	17D	\N
OQ831	A350	17E	\N
OQ831	A350	17F	\N
OQ831	A350	17G	\N
OQ831	A350	17H	\N
OQ831	A350	17K	\N
OQ831	A350	18A	\N
OQ831	A350	18C	\N
OQ831	A350	18D	\N
OQ831	A350	18E	\N
OQ831	A350	1K	T739694
OQ831	A350	10K	T465739
OQ831	A350	1C	T579275
OQ831	A350	18F	\N
OQ831	A350	18G	\N
OQ831	A350	18H	\N
OQ831	A350	18K	\N
OQ831	A350	19A	\N
OQ831	A350	19C	\N
OQ831	A350	19D	\N
OQ831	A350	19E	\N
OQ831	A350	19F	\N
OQ831	A350	19G	\N
OQ831	A350	19H	\N
OQ831	A350	19K	\N
OQ831	A350	2A	\N
OQ831	A350	2C	\N
OQ831	A350	2D	\N
OQ831	A350	2G	\N
OQ831	A350	2H	\N
OQ831	A350	2K	\N
OQ831	A350	27A	\N
OQ831	A350	27B	\N
OQ831	A350	27C	\N
OQ831	A350	27D	\N
OQ831	A350	27E	\N
OQ831	A350	27G	\N
OQ831	A350	27H	\N
OQ831	A350	27J	\N
OQ831	A350	27K	\N
OQ831	A350	28A	\N
OQ831	A350	28B	\N
OQ831	A350	28C	\N
OQ831	A350	28E	\N
OQ831	A350	28G	\N
OQ831	A350	28H	\N
OQ831	A350	28J	\N
OQ831	A350	28K	\N
OQ831	A350	29A	\N
OQ831	A350	29B	\N
OQ831	A350	29C	\N
OQ831	A350	29D	\N
OQ831	A350	29E	\N
OQ831	A350	29G	\N
OQ831	A350	29H	\N
OQ831	A350	29J	\N
OQ831	A350	29K	\N
OQ831	A350	30A	\N
OQ831	A350	30B	\N
OQ831	A350	30C	\N
OQ831	A350	30D	\N
OQ831	A350	30E	\N
OQ831	A350	30G	\N
OQ831	A350	30H	\N
OQ831	A350	30J	\N
OQ831	A350	30K	\N
OQ831	A350	31A	\N
OQ831	A350	31B	\N
OQ831	A350	31C	\N
OQ831	A350	31D	\N
OQ831	A350	31E	\N
OQ831	A350	31G	\N
OQ831	A350	31H	\N
OQ831	A350	31J	\N
OQ831	A350	31K	\N
OQ831	A350	32A	\N
OQ831	A350	32B	\N
OQ831	A350	32C	\N
OQ831	A350	32D	\N
OQ831	A350	32E	\N
OQ831	A350	32G	\N
OQ831	A350	32H	\N
OQ831	A350	32J	\N
OQ831	A350	32K	\N
OQ831	A350	33A	\N
OQ831	A350	33B	\N
OQ831	A350	33C	\N
OQ831	A350	33D	\N
OQ831	A350	33E	\N
OQ831	A350	33G	\N
OQ831	A350	33H	\N
OQ831	A350	33J	\N
OQ831	A350	33K	\N
OQ831	A350	34A	\N
OQ831	A350	34B	\N
OQ831	A350	34C	\N
OQ831	A350	34D	\N
OQ831	A350	34E	\N
OQ831	A350	34G	\N
OQ831	A350	34H	\N
OQ831	A350	34J	\N
OQ831	A350	34K	\N
OQ831	A350	35A	\N
OQ831	A350	35B	\N
OQ831	A350	35C	\N
OQ831	A350	35D	\N
OQ831	A350	35E	\N
OQ831	A350	35G	\N
OQ831	A350	35H	\N
OQ831	A350	35J	\N
OQ831	A350	35K	\N
OQ831	A350	36A	\N
OQ831	A350	36B	\N
OQ831	A350	36C	\N
OQ831	A350	36D	\N
OQ831	A350	36E	\N
OQ831	A350	36G	\N
OQ831	A350	36H	\N
OQ831	A350	36J	\N
OQ831	A350	36K	\N
OQ831	A350	37A	\N
OQ831	A350	37B	\N
OQ831	A350	37C	\N
OQ831	A350	37D	\N
OQ831	A350	37E	\N
OQ831	A350	37G	\N
OQ831	A350	37H	\N
OQ831	A350	37J	\N
OQ831	A350	37K	\N
OQ831	A350	38A	\N
OQ831	A350	38B	\N
OQ831	A350	38C	\N
OQ831	A350	38D	\N
OQ831	A350	38E	\N
OQ831	A350	38G	\N
OQ831	A350	38H	\N
OQ831	A350	38J	\N
OQ831	A350	38K	\N
OQ831	A350	39A	\N
OQ831	A350	39B	\N
OQ831	A350	39C	\N
OQ831	A350	39D	\N
OQ831	A350	39E	\N
OQ831	A350	39G	\N
OQ831	A350	39H	\N
OQ831	A350	39J	\N
OQ831	A350	39K	\N
OQ831	A350	40D	\N
OQ831	A350	40E	\N
OQ831	A350	40G	\N
OQ831	A350	45A	\N
OQ831	A350	45B	\N
OQ831	A350	45C	\N
OQ831	A350	45D	\N
OQ831	A350	45E	\N
OQ831	A350	45G	\N
OQ831	A350	45H	\N
OQ831	A350	45J	\N
OQ831	A350	45K	\N
OQ831	A350	46A	\N
OQ831	A350	46B	\N
OQ831	A350	46C	\N
OQ831	A350	46D	\N
OQ831	A350	46E	\N
OQ831	A350	46G	\N
OQ831	A350	46H	\N
OQ831	A350	46J	\N
OQ831	A350	46K	\N
OQ831	A350	47A	\N
OQ831	A350	47B	\N
OQ831	A350	47C	\N
OQ831	A350	47D	\N
OQ831	A350	47E	\N
OQ831	A350	47G	\N
OQ831	A350	47H	\N
OQ831	A350	47J	\N
OQ831	A350	47K	\N
OQ831	A350	48A	\N
OQ831	A350	48B	\N
OQ831	A350	48C	\N
OQ831	A350	48D	\N
OQ831	A350	48E	\N
OQ831	A350	48G	\N
OQ831	A350	48H	\N
OQ831	A350	48J	\N
OQ831	A350	48K	\N
OQ831	A350	49A	\N
OQ831	A350	49B	\N
OQ831	A350	49C	\N
OQ831	A350	49D	\N
OQ831	A350	49E	\N
OQ831	A350	49G	\N
OQ831	A350	49H	\N
OQ831	A350	49J	\N
OQ831	A350	49K	\N
OQ831	A350	5A	\N
OQ831	A350	5C	\N
OQ831	A350	61D	\N
OQ831	A350	5H	\N
OQ831	A350	5K	\N
OQ831	A350	50A	\N
OQ831	A350	50B	\N
OQ831	A350	50C	\N
OQ831	A350	50D	\N
OQ831	A350	50E	\N
OQ831	A350	50G	\N
OQ831	A350	50H	\N
OQ831	A350	50J	\N
OQ831	A350	50K	\N
OQ831	A350	51A	\N
OQ831	A350	51B	\N
OQ831	A350	51C	\N
OQ831	A350	51D	\N
OQ831	A350	51E	\N
OQ831	A350	51G	\N
OQ831	A350	51H	\N
OQ831	A350	51J	\N
OQ831	A350	51K	\N
OQ831	A350	52A	\N
OQ831	A350	52B	\N
OQ831	A350	52C	\N
OQ831	A350	52D	\N
OQ831	A350	52E	\N
OQ831	A350	52G	\N
OQ831	A350	52H	\N
OQ831	A350	52J	\N
OQ831	A350	52K	\N
OQ831	A350	53A	\N
OQ831	A350	53B	\N
OQ831	A350	53C	\N
OQ831	A350	53D	\N
OQ831	A350	53E	\N
OQ831	A350	53G	\N
OQ831	A350	53H	\N
OQ831	A350	53J	\N
OQ831	A350	53K	\N
OQ831	A350	54A	\N
OQ831	A350	54B	\N
OQ831	A350	54C	\N
OQ831	A350	54D	\N
OQ831	A350	54E	\N
OQ831	A350	54G	\N
OQ831	A350	54H	\N
OQ831	A350	54J	\N
OQ831	A350	54K	\N
OQ831	A350	55A	\N
OQ831	A350	55B	\N
OQ831	A350	55C	\N
OQ831	A350	55D	\N
OQ831	A350	55E	\N
OQ831	A350	55G	\N
OQ831	A350	55H	\N
OQ831	A350	55J	\N
OQ831	A350	55K	\N
OQ831	A350	56A	\N
OQ831	A350	56B	\N
OQ831	A350	56C	\N
OQ831	A350	56D	\N
OQ831	A350	56E	\N
OQ831	A350	56G	\N
OQ831	A350	56H	\N
OQ831	A350	56J	\N
OQ831	A350	56K	\N
OQ831	A350	57A	\N
OQ831	A350	57B	\N
OQ831	A350	57C	\N
OQ831	A350	57D	\N
OQ831	A350	57E	\N
OQ831	A350	57G	\N
OQ831	A350	57H	\N
OQ831	A350	57J	\N
OQ831	A350	57K	\N
OQ831	A350	58A	\N
OQ831	A350	58B	\N
OQ831	A350	58C	\N
OQ831	A350	58D	\N
OQ831	A350	58E	\N
OQ831	A350	58G	\N
OQ831	A350	58H	\N
OQ831	A350	58J	\N
OQ831	A350	58K	\N
OQ831	A350	59A	\N
OQ831	A350	59B	\N
OQ831	A350	59C	\N
OQ831	A350	59D	\N
OQ831	A350	59E	\N
OQ831	A350	59G	\N
OQ831	A350	59H	\N
OQ831	A350	59J	\N
OQ831	A350	59K	\N
OQ831	A350	6A	\N
OQ831	A350	6C	\N
OQ831	A350	6D	\N
OQ831	A350	6E	\N
OQ831	A350	6F	\N
OQ831	A350	6G	\N
OQ831	A350	6H	\N
OQ831	A350	6K	\N
OQ831	A350	60A	\N
OQ831	A350	60C	\N
OQ831	A350	60D	\N
OQ831	A350	60E	\N
OQ831	A350	60G	\N
OQ831	A350	61E	\N
OQ831	A350	61G	\N
OQ831	A350	7A	\N
OQ831	A350	7C	\N
OQ831	A350	7D	\N
OQ831	A350	7E	\N
OQ831	A350	7F	\N
OQ831	A350	7G	\N
OQ831	A350	7H	\N
OQ831	A350	7K	\N
OQ831	A350	8A	\N
OQ831	A350	8C	\N
OQ831	A350	8D	\N
OQ831	A350	8E	\N
OQ831	A350	8F	\N
OQ831	A350	8G	\N
OQ831	A350	8H	\N
OQ831	A350	8K	\N
OQ831	A350	9A	\N
OQ831	A350	9C	\N
OQ831	A350	9D	\N
OQ831	A350	9E	\N
OQ831	A350	9F	\N
OQ831	A350	9G	\N
OQ831	A350	9H	\N
OQ831	A350	9K	\N
SU399	A380	1A	\N
SU399	A380	1E	\N
SU399	A380	1F	\N
SU399	A380	1K	\N
SU399	A380	10B	\N
SU399	A380	10D	\N
SU399	A380	10G	\N
SU399	A380	10J	\N
SU399	A380	11A	\N
SU399	A380	11E	\N
SU399	A380	11F	\N
SU399	A380	11K	\N
SU399	A380	12B	\N
SU399	A380	12D	\N
SU399	A380	12G	\N
SU399	A380	12J	\N
SU399	A380	14A	\N
SU399	A380	14E	\N
SU399	A380	14F	\N
SU399	A380	14K	\N
SU399	A380	15B	\N
SU399	A380	15D	\N
SU399	A380	15G	\N
SU399	A380	15J	\N
SU399	A380	16A	\N
SU399	A380	16E	\N
SU399	A380	16F	\N
SU399	A380	16K	\N
SU399	A380	17B	\N
SU399	A380	17D	\N
SU399	A380	17G	\N
SU399	A380	17J	\N
SU399	A380	18A	\N
SU399	A380	18E	\N
SU399	A380	18F	\N
SU399	A380	18K	\N
SU399	A380	19B	\N
SU399	A380	19D	\N
SU399	A380	19G	\N
SU399	A380	19J	\N
SU399	A380	2A	\N
SU399	A380	2E	\N
SU399	A380	2F	\N
SU399	A380	2K	\N
SU399	A380	20E	\N
SU399	A380	20F	\N
SU399	A380	20K	\N
SU399	A380	21B	\N
SU399	A380	21G	\N
SU399	A380	21J	\N
SU399	A380	22D	\N
SU399	A380	22G	\N
QU263	A350	1D	T453812
SU399	A380	23A	\N
SU399	A380	23E	\N
SU399	A380	23F	\N
SU399	A380	23K	\N
SU399	A380	24B	\N
SU399	A380	24D	\N
SU399	A380	24G	\N
SU399	A380	24J	\N
SU399	A380	25A	\N
SU399	A380	25E	\N
SU399	A380	25F	\N
SU399	A380	25K	\N
SU399	A380	26B	\N
SU399	A380	26D	\N
SU399	A380	26G	\N
SU399	A380	26J	\N
SU399	A380	3A	\N
SU399	A380	3E	\N
SU399	A380	3F	\N
SU399	A380	3K	\N
SU399	A380	4A	\N
SU399	A380	4K	\N
SU399	A380	43B	\N
SU399	A380	43C	\N
SU399	A380	43H	\N
SU399	A380	43J	\N
SU399	A380	43K	\N
SU399	A380	44A	\N
SU399	A380	44B	\N
SU399	A380	44H	\N
SU399	A380	44J	\N
SU399	A380	44K	\N
SU399	A380	45A	\N
SU399	A380	45D	\N
SU399	A380	45E	\N
SU399	A380	45F	\N
SU399	A380	45G	\N
SU399	A380	45H	\N
SU399	A380	45J	\N
SU399	A380	45K	\N
SU399	A380	46B	\N
SU399	A380	46C	\N
SU399	A380	46D	\N
SU399	A380	46E	\N
SU399	A380	46F	\N
SU399	A380	46G	\N
SU399	A380	46H	\N
SU399	A380	46J	\N
SU399	A380	46K	\N
SU399	A380	47A	\N
SU399	A380	47B	\N
SU399	A380	47C	\N
SU399	A380	47D	\N
SU399	A380	47E	\N
SU399	A380	47F	\N
SU399	A380	47G	\N
SU399	A380	47H	\N
SU399	A380	47J	\N
SU399	A380	47K	\N
SU399	A380	48A	\N
SU399	A380	48B	\N
SU399	A380	48C	\N
SU399	A380	48D	\N
SU399	A380	48E	\N
SU399	A380	48F	\N
SU399	A380	48G	\N
SU399	A380	48H	\N
SU399	A380	48J	\N
SU399	A380	48K	\N
SU399	A380	49A	\N
SU399	A380	49B	\N
SU399	A380	49C	\N
SU399	A380	49D	\N
SU399	A380	49E	\N
SU399	A380	49F	\N
SU399	A380	49G	\N
SU399	A380	49H	\N
SU399	A380	49J	\N
SU399	A380	49K	\N
SU399	A380	50A	\N
SU399	A380	50B	\N
SU399	A380	50C	\N
SU399	A380	50D	\N
SU399	A380	50E	\N
SU399	A380	50F	\N
SU399	A380	50G	\N
SU399	A380	50H	\N
SU399	A380	50J	\N
SU399	A380	50K	\N
SU399	A380	51D	\N
SU399	A380	51E	\N
SU399	A380	51F	\N
SU399	A380	51G	\N
SU399	A380	52A	\N
SU399	A380	52B	\N
SU399	A380	52C	\N
SU399	A380	52H	\N
SU399	A380	52J	\N
SU399	A380	52K	\N
SU399	A380	21D	\N
SU399	A380	53A	\N
SU399	A380	53B	\N
SU399	A380	53C	\N
SU399	A380	53H	\N
SU399	A380	53J	\N
SU399	A380	53K	\N
SU399	A380	54A	\N
SU399	A380	54B	\N
SU399	A380	54C	\N
SU399	A380	54D	\N
SU399	A380	54E	\N
SU399	A380	54F	\N
SU399	A380	54G	\N
SU399	A380	54H	\N
SU399	A380	54J	\N
SU399	A380	54K	\N
SU399	A380	55A	\N
SU399	A380	55B	\N
SU399	A380	55C	\N
SU399	A380	55D	\N
SU399	A380	55E	\N
SU399	A380	55F	\N
SU399	A380	55G	\N
SU399	A380	55H	\N
SU399	A380	55J	\N
SU399	A380	55K	\N
SU399	A380	56A	\N
SU399	A380	56B	\N
SU399	A380	56C	\N
SU399	A380	56D	\N
SU399	A380	56E	\N
SU399	A380	56F	\N
SU399	A380	56G	\N
SU399	A380	56H	\N
SU399	A380	56J	\N
SU399	A380	56K	\N
SU399	A380	57A	\N
SU399	A380	57B	\N
SU399	A380	57C	\N
SU399	A380	57D	\N
SU399	A380	57E	\N
SU399	A380	57F	\N
SU399	A380	57G	\N
SU399	A380	57H	\N
SU399	A380	57J	\N
SU399	A380	57K	\N
SU399	A380	58A	\N
SU399	A380	58B	\N
SU399	A380	58C	\N
SU399	A380	58D	\N
SU399	A380	58E	\N
SU399	A380	58F	\N
SU399	A380	58G	\N
SU399	A380	58H	\N
SU399	A380	58J	\N
SU399	A380	58K	\N
SU399	A380	59A	\N
SU399	A380	59B	\N
SU399	A380	59C	\N
SU399	A380	59D	\N
SU399	A380	59E	\N
SU399	A380	59F	\N
SU399	A380	59G	\N
SU399	A380	59H	\N
SU399	A380	59J	\N
SU399	A380	59K	\N
SU399	A380	6D	\N
SU399	A380	6G	\N
SU399	A380	60A	\N
SU399	A380	60B	\N
SU399	A380	60C	\N
SU399	A380	60D	\N
SU399	A380	60E	\N
SU399	A380	60F	\N
SU399	A380	60G	\N
SU399	A380	60H	\N
SU399	A380	60J	\N
SU399	A380	60K	\N
SU399	A380	61A	\N
SU399	A380	61B	\N
SU399	A380	44C	T522586
SU399	A380	46A	T534520
SU399	A380	43A	T424677
SU399	A380	61C	\N
SU399	A380	61D	\N
SU399	A380	61E	\N
SU399	A380	61F	\N
SU399	A380	61G	\N
SU399	A380	61H	\N
SU399	A380	61J	\N
SU399	A380	61K	\N
SU399	A380	62A	\N
SU399	A380	62B	\N
SU399	A380	62C	\N
SU399	A380	62D	\N
SU399	A380	62E	\N
SU399	A380	62F	\N
SU399	A380	62G	\N
SU399	A380	62H	\N
SU399	A380	62J	\N
SU399	A380	62K	\N
SU399	A380	63A	\N
SU399	A380	63B	\N
SU399	A380	63C	\N
SU399	A380	63D	\N
SU399	A380	63E	\N
SU399	A380	63F	\N
SU399	A380	63G	\N
SU399	A380	63H	\N
SU399	A380	63J	\N
SU399	A380	63K	\N
SU399	A380	64A	\N
SU399	A380	64B	\N
SU399	A380	64C	\N
SU399	A380	64D	\N
SU399	A380	64E	\N
SU399	A380	64F	\N
SU399	A380	64G	\N
SU399	A380	64H	\N
SU399	A380	64J	\N
SU399	A380	64K	\N
SU399	A380	65A	\N
SU399	A380	65B	\N
SU399	A380	65C	\N
SU399	A380	65D	\N
SU399	A380	65E	\N
SU399	A380	65F	\N
SU399	A380	65G	\N
SU399	A380	65H	\N
SU399	A380	65J	\N
SU399	A380	65K	\N
SU399	A380	66H	\N
SU399	A380	66J	\N
SU399	A380	66K	\N
SU399	A380	67B	\N
SU399	A380	67C	\N
SU399	A380	67D	\N
SU399	A380	67E	\N
SU399	A380	67F	\N
SU399	A380	67G	\N
SU399	A380	67H	\N
SU399	A380	67J	\N
SU399	A380	68A	\N
SU399	A380	68B	\N
SU399	A380	68C	\N
SU399	A380	68D	\N
SU399	A380	68E	\N
SU399	A380	68F	\N
SU399	A380	68G	\N
SU399	A380	68H	\N
SU399	A380	68J	\N
SU399	A380	68K	\N
SU399	A380	69A	\N
SU399	A380	69B	\N
SU399	A380	69C	\N
SU399	A380	69D	\N
SU399	A380	69E	\N
SU399	A380	69F	\N
SU399	A380	69G	\N
SU399	A380	69H	\N
SU399	A380	69J	\N
SU399	A380	69K	\N
SU399	A380	7A	\N
SU399	A380	7E	\N
SU399	A380	7F	\N
SU399	A380	7K	\N
SU399	A380	70A	\N
SU399	A380	70B	\N
SU399	A380	70C	\N
SU399	A380	70D	\N
SU399	A380	70E	\N
SU399	A380	70F	\N
SU399	A380	70G	\N
SU399	A380	70H	\N
SU399	A380	70J	\N
SU399	A380	70K	\N
SU399	A380	71A	\N
SU399	A380	71B	\N
SU399	A380	71C	\N
SU399	A380	71D	\N
SU399	A380	71E	\N
SU399	A380	71F	\N
SU399	A380	71G	\N
SU399	A380	71H	\N
SU399	A380	71J	\N
SU399	A380	71K	\N
SU399	A380	72A	\N
SU399	A380	72B	\N
SU399	A380	72C	\N
SU399	A380	72D	\N
SU399	A380	72E	\N
SU399	A380	72F	\N
SU399	A380	72G	\N
SU399	A380	72H	\N
SU399	A380	72J	\N
SU399	A380	72K	\N
SU399	A380	73A	\N
SU399	A380	73B	\N
SU399	A380	73C	\N
SU399	A380	73D	\N
SU399	A380	73E	\N
SU399	A380	73F	\N
SU399	A380	73G	\N
SU399	A380	73H	\N
SU399	A380	73J	\N
SU399	A380	73K	\N
SU399	A380	74A	\N
SU399	A380	74B	\N
SU399	A380	74C	\N
SU399	A380	74D	\N
SU399	A380	74E	\N
SU399	A380	74F	\N
SU399	A380	74G	\N
SU399	A380	74H	\N
SU399	A380	74J	\N
SU399	A380	74K	\N
SU399	A380	75A	\N
SU399	A380	75B	\N
SU399	A380	75C	\N
SU399	A380	75D	\N
SU399	A380	75E	\N
SU399	A380	75F	\N
SU399	A380	75G	\N
SU399	A380	75H	\N
SU399	A380	75J	\N
SU399	A380	75K	\N
SU399	A380	76A	\N
SU399	A380	76B	\N
SU399	A380	76C	\N
SU399	A380	76D	\N
SU399	A380	76E	\N
SU399	A380	76F	\N
SU399	A380	76G	\N
SU399	A380	76H	\N
SU399	A380	76J	\N
SU399	A380	76K	\N
SU399	A380	77A	\N
SU399	A380	77B	\N
SU399	A380	77C	\N
SU399	A380	77D	\N
SU399	A380	77E	\N
SU399	A380	77F	\N
SU399	A380	77G	\N
SU399	A380	77H	\N
SU399	A380	77J	\N
SU399	A380	77K	\N
SU399	A380	78A	\N
SU399	A380	78B	\N
SU399	A380	78C	\N
SU399	A380	78D	\N
SU399	A380	78E	\N
SU399	A380	78F	\N
SU399	A380	78G	\N
SU399	A380	78H	\N
SU399	A380	78J	\N
SU399	A380	78K	\N
SU399	A380	79A	\N
SU399	A380	79B	\N
SU399	A380	79C	\N
SU399	A380	79H	\N
SU399	A380	79J	\N
SU399	A380	79K	\N
SU399	A380	8B	\N
SU399	A380	8D	\N
SU399	A380	8G	\N
SU399	A380	8J	\N
SU399	A380	80B	\N
SU399	A380	80C	\N
SU399	A380	80H	\N
SU399	A380	80J	\N
SU399	A380	81A	\N
SU399	A380	81B	\N
SU399	A380	81C	\N
SU399	A380	81H	\N
SU399	A380	81J	\N
SU399	A380	81K	\N
SU399	A380	82A	\N
SU399	A380	82B	\N
SU399	A380	82C	\N
SU399	A380	82D	\N
SU399	A380	82E	\N
SU399	A380	82F	\N
SU399	A380	82G	\N
SU399	A380	82H	\N
SU399	A380	82J	\N
SU399	A380	82K	\N
SU399	A380	83A	\N
SU399	A380	83B	\N
SU399	A380	83C	\N
SU399	A380	83D	\N
SU399	A380	83E	\N
SU399	A380	83F	\N
SU399	A380	83G	\N
SU399	A380	83H	\N
SU399	A380	83J	\N
SU399	A380	83K	\N
SU399	A380	84A	\N
SU399	A380	84B	\N
SU399	A380	84C	\N
SU399	A380	84D	\N
SU399	A380	84E	\N
SU399	A380	84F	\N
SU399	A380	84G	\N
SU399	A380	84H	\N
SU399	A380	84J	\N
SU399	A380	84K	\N
SU399	A380	85A	\N
SU399	A380	85B	\N
SU399	A380	85C	\N
SU399	A380	85H	\N
SU399	A380	85J	\N
SU399	A380	85K	\N
SU399	A380	86A	\N
SU399	A380	86B	\N
SU399	A380	86C	\N
SU399	A380	86H	\N
SU399	A380	86J	\N
SU399	A380	86K	\N
SU399	A380	87A	\N
SU399	A380	87B	\N
SU399	A380	87C	\N
SU399	A380	87H	\N
SU399	A380	87J	\N
SU399	A380	87K	\N
SU399	A380	88A	\N
SU399	A380	88B	\N
SU399	A380	88C	\N
SU399	A380	88H	\N
SU399	A380	88J	\N
SU399	A380	88K	\N
SU399	A380	9A	\N
SU399	A380	9E	\N
SU399	A380	9F	\N
SU399	A380	9K	\N
XJ392	A350	1A	\N
XJ392	A350	1C	\N
XJ392	A350	1D	\N
XJ392	A350	1G	\N
XJ392	A350	1H	\N
XJ392	A350	1K	\N
XJ392	A350	10A	\N
XJ392	A350	10C	\N
XJ392	A350	10D	\N
XJ392	A350	10E	\N
XJ392	A350	10F	\N
XJ392	A350	10G	\N
XJ392	A350	10H	\N
XJ392	A350	10K	\N
XJ392	A350	11A	\N
XJ392	A350	11C	\N
XJ392	A350	11D	\N
XJ392	A350	11E	\N
XJ392	A350	11F	\N
XJ392	A350	11G	\N
XJ392	A350	11H	\N
XJ392	A350	11K	\N
XJ392	A350	12D	\N
XJ392	A350	12E	\N
XJ392	A350	12F	\N
XJ392	A350	12G	\N
XJ392	A350	15D	\N
XJ392	A350	15E	\N
XJ392	A350	15F	\N
XJ392	A350	15G	\N
XJ392	A350	15H	\N
XJ392	A350	15K	\N
XJ392	A350	16A	\N
XJ392	A350	16C	\N
XJ392	A350	16D	\N
XJ392	A350	16E	\N
XJ392	A350	16F	\N
XJ392	A350	16G	\N
XJ392	A350	16H	\N
XJ392	A350	16K	\N
XJ392	A350	17A	\N
XJ392	A350	17C	\N
XJ392	A350	17D	\N
XJ392	A350	17E	\N
XJ392	A350	17F	\N
XJ392	A350	17G	\N
XJ392	A350	17H	\N
XJ392	A350	17K	\N
XJ392	A350	18A	\N
XJ392	A350	18C	\N
XJ392	A350	18D	\N
XJ392	A350	18E	\N
XJ392	A350	18F	\N
XJ392	A350	18G	\N
XJ392	A350	18H	\N
XJ392	A350	18K	\N
XJ392	A350	19A	\N
XJ392	A350	19C	\N
XJ392	A350	19D	\N
XJ392	A350	19E	\N
XJ392	A350	19F	\N
XJ392	A350	19G	\N
XJ392	A350	19H	\N
XJ392	A350	19K	\N
XJ392	A350	2A	\N
XJ392	A350	2C	\N
XJ392	A350	2D	\N
XJ392	A350	2G	\N
XJ392	A350	2H	\N
XJ392	A350	2K	\N
XJ392	A350	27A	\N
XJ392	A350	27D	\N
XJ392	A350	27E	\N
XJ392	A350	27G	\N
XJ392	A350	27H	\N
XJ392	A350	27J	\N
XJ392	A350	27K	\N
XJ392	A350	28A	\N
XJ392	A350	28B	\N
XJ392	A350	28G	\N
XJ392	A350	28H	\N
XJ392	A350	28J	\N
XJ392	A350	28K	\N
XJ392	A350	29A	\N
XJ392	A350	29D	\N
XJ392	A350	29E	\N
XJ392	A350	29G	\N
XJ392	A350	29H	\N
XJ392	A350	29J	\N
XJ392	A350	29K	\N
XJ392	A350	30A	\N
XJ392	A350	30B	\N
XJ392	A350	30D	\N
XJ392	A350	30E	\N
XJ392	A350	30G	\N
XJ392	A350	30H	\N
XJ392	A350	30J	\N
XJ392	A350	30K	\N
XJ392	A350	31A	\N
XJ392	A350	31B	\N
XJ392	A350	31C	\N
XJ392	A350	31D	\N
XJ392	A350	31E	\N
XJ392	A350	31G	\N
XJ392	A350	31H	\N
XJ392	A350	31J	\N
XJ392	A350	31K	\N
XJ392	A350	32A	\N
XJ392	A350	32B	\N
XJ392	A350	32C	\N
XJ392	A350	32D	\N
XJ392	A350	29B	T156484
XJ392	A350	29C	T988936
XJ392	A350	32E	\N
XJ392	A350	32G	\N
XJ392	A350	32H	\N
XJ392	A350	32J	\N
XJ392	A350	32K	\N
XJ392	A350	33A	\N
XJ392	A350	33B	\N
XJ392	A350	33C	\N
XJ392	A350	33D	\N
XJ392	A350	33E	\N
XJ392	A350	33G	\N
XJ392	A350	33H	\N
XJ392	A350	33J	\N
XJ392	A350	33K	\N
XJ392	A350	34A	\N
XJ392	A350	34B	\N
XJ392	A350	34C	\N
XJ392	A350	34D	\N
XJ392	A350	34E	\N
XJ392	A350	34G	\N
XJ392	A350	34H	\N
XJ392	A350	34J	\N
XJ392	A350	34K	\N
XJ392	A350	35A	\N
XJ392	A350	35B	\N
XJ392	A350	35C	\N
XJ392	A350	35D	\N
XJ392	A350	35E	\N
XJ392	A350	35G	\N
XJ392	A350	35H	\N
XJ392	A350	35J	\N
XJ392	A350	35K	\N
XJ392	A350	36A	\N
XJ392	A350	36B	\N
XJ392	A350	36C	\N
XJ392	A350	36D	\N
XJ392	A350	36E	\N
XJ392	A350	36G	\N
XJ392	A350	36H	\N
XJ392	A350	36J	\N
XJ392	A350	36K	\N
XJ392	A350	37A	\N
XJ392	A350	37B	\N
XJ392	A350	37C	\N
XJ392	A350	37D	\N
XJ392	A350	37E	\N
XJ392	A350	37G	\N
XJ392	A350	37H	\N
XJ392	A350	37J	\N
XJ392	A350	37K	\N
XJ392	A350	38A	\N
XJ392	A350	38B	\N
XJ392	A350	38C	\N
XJ392	A350	28D	T302080
XJ392	A350	38D	\N
XJ392	A350	38E	\N
XJ392	A350	38G	\N
XJ392	A350	38H	\N
XJ392	A350	38J	\N
XJ392	A350	38K	\N
XJ392	A350	39A	\N
XJ392	A350	39B	\N
XJ392	A350	39C	\N
XJ392	A350	39D	\N
XJ392	A350	39E	\N
XJ392	A350	39G	\N
XJ392	A350	39H	\N
XJ392	A350	39J	\N
XJ392	A350	39K	\N
XJ392	A350	40D	\N
XJ392	A350	40E	\N
XJ392	A350	40G	\N
XJ392	A350	45A	\N
XJ392	A350	45B	\N
XJ392	A350	45C	\N
XJ392	A350	45D	\N
XJ392	A350	45E	\N
XJ392	A350	45G	\N
XJ392	A350	45H	\N
XJ392	A350	45J	\N
XJ392	A350	45K	\N
XJ392	A350	46A	\N
XJ392	A350	46B	\N
XJ392	A350	46C	\N
XJ392	A350	46D	\N
XJ392	A350	46E	\N
XJ392	A350	46G	\N
XJ392	A350	46H	\N
XJ392	A350	46J	\N
XJ392	A350	46K	\N
XJ392	A350	47A	\N
XJ392	A350	47B	\N
XJ392	A350	47C	\N
XJ392	A350	47D	\N
XJ392	A350	47E	\N
XJ392	A350	47G	\N
XJ392	A350	47H	\N
XJ392	A350	47J	\N
XJ392	A350	47K	\N
XJ392	A350	48A	\N
XJ392	A350	48B	\N
XJ392	A350	48C	\N
XJ392	A350	48D	\N
XJ392	A350	48E	\N
XJ392	A350	48G	\N
XJ392	A350	48H	\N
XJ392	A350	48J	\N
XJ392	A350	48K	\N
XJ392	A350	49A	\N
XJ392	A350	49B	\N
XJ392	A350	49C	\N
XJ392	A350	49D	\N
XJ392	A350	49E	\N
XJ392	A350	49G	\N
XJ392	A350	49H	\N
XJ392	A350	49J	\N
XJ392	A350	49K	\N
XJ392	A350	5A	\N
XJ392	A350	5C	\N
XJ392	A350	5H	\N
XJ392	A350	5K	\N
XJ392	A350	50A	\N
XJ392	A350	50B	\N
XJ392	A350	50C	\N
XJ392	A350	50D	\N
XJ392	A350	50E	\N
XJ392	A350	50G	\N
XJ392	A350	50H	\N
XJ392	A350	50J	\N
XJ392	A350	50K	\N
XJ392	A350	51A	\N
XJ392	A350	51B	\N
XJ392	A350	51C	\N
XJ392	A350	51D	\N
XJ392	A350	51E	\N
XJ392	A350	51G	\N
XJ392	A350	51H	\N
XJ392	A350	51J	\N
XJ392	A350	51K	\N
XJ392	A350	52A	\N
XJ392	A350	52B	\N
XJ392	A350	52C	\N
XJ392	A350	52D	\N
XJ392	A350	52E	\N
XJ392	A350	52G	\N
XJ392	A350	52H	\N
XJ392	A350	52J	\N
XJ392	A350	52K	\N
XJ392	A350	53A	\N
XJ392	A350	53B	\N
XJ392	A350	53C	\N
XJ392	A350	53D	\N
XJ392	A350	53E	\N
XJ392	A350	53G	\N
XJ392	A350	53H	\N
XJ392	A350	53J	\N
XJ392	A350	53K	\N
XJ392	A350	54A	\N
XJ392	A350	54B	\N
XJ392	A350	54C	\N
XJ392	A350	54D	\N
XJ392	A350	54E	\N
XJ392	A350	54G	\N
XJ392	A350	54H	\N
XJ392	A350	54J	\N
XJ392	A350	54K	\N
XJ392	A350	55A	\N
XJ392	A350	55B	\N
XJ392	A350	55C	\N
XJ392	A350	55D	\N
XJ392	A350	55E	\N
XJ392	A350	55G	\N
XJ392	A350	55H	\N
XJ392	A350	55J	\N
XJ392	A350	55K	\N
XJ392	A350	56A	\N
XJ392	A350	56B	\N
XJ392	A350	56C	\N
XJ392	A350	56D	\N
XJ392	A350	56E	\N
XJ392	A350	56G	\N
XJ392	A350	56H	\N
XJ392	A350	56J	\N
XJ392	A350	56K	\N
XJ392	A350	57A	\N
XJ392	A350	57B	\N
SS216	A380	2A	\N
XJ392	A350	57C	\N
XJ392	A350	57D	\N
XJ392	A350	57E	\N
XJ392	A350	57G	\N
XJ392	A350	57H	\N
XJ392	A350	57J	\N
XJ392	A350	57K	\N
XJ392	A350	58A	\N
XJ392	A350	58B	\N
XJ392	A350	58C	\N
XJ392	A350	58D	\N
XJ392	A350	58E	\N
XJ392	A350	58G	\N
XJ392	A350	58H	\N
XJ392	A350	58J	\N
XJ392	A350	58K	\N
XJ392	A350	59A	\N
XJ392	A350	59B	\N
XJ392	A350	59C	\N
XJ392	A350	59D	\N
XJ392	A350	59E	\N
XJ392	A350	59G	\N
XJ392	A350	59H	\N
XJ392	A350	59J	\N
XJ392	A350	59K	\N
XJ392	A350	6A	\N
XJ392	A350	6C	\N
XJ392	A350	6D	\N
XJ392	A350	6E	\N
XJ392	A350	6F	\N
XJ392	A350	6G	\N
XJ392	A350	6H	\N
XJ392	A350	6K	\N
XJ392	A350	60A	\N
XJ392	A350	60C	\N
XJ392	A350	60D	\N
XJ392	A350	60E	\N
XJ392	A350	60G	\N
XJ392	A350	61D	\N
XJ392	A350	61E	\N
XJ392	A350	61G	\N
XJ392	A350	7A	\N
XJ392	A350	7C	\N
XJ392	A350	7D	\N
XJ392	A350	7E	\N
XJ392	A350	7F	\N
XJ392	A350	7G	\N
XJ392	A350	7H	\N
XJ392	A350	7K	\N
XJ392	A350	8A	\N
XJ392	A350	8C	\N
XJ392	A350	8D	\N
XJ392	A350	8E	\N
XJ392	A350	8F	\N
XJ392	A350	8G	\N
XJ392	A350	8H	\N
XJ392	A350	8K	\N
XJ392	A350	9A	\N
XJ392	A350	9C	\N
XJ392	A350	9D	\N
XJ392	A350	9E	\N
XJ392	A350	9F	\N
XJ392	A350	9G	\N
XJ392	A350	9H	\N
XJ392	A350	9K	\N
SS216	A380	1A	\N
SS216	A380	1E	\N
SS216	A380	1F	\N
SS216	A380	1K	\N
SS216	A380	10B	\N
SS216	A380	10D	\N
SS216	A380	10G	\N
SS216	A380	10J	\N
SS216	A380	11A	\N
SS216	A380	11E	\N
SS216	A380	11F	\N
SS216	A380	11K	\N
SS216	A380	12B	\N
SS216	A380	12D	\N
SS216	A380	12G	\N
SS216	A380	12J	\N
SS216	A380	14A	\N
SS216	A380	14E	\N
SS216	A380	14F	\N
SS216	A380	14K	\N
SS216	A380	15B	\N
SS216	A380	15D	\N
SS216	A380	15G	\N
SS216	A380	15J	\N
SS216	A380	16A	\N
SS216	A380	16E	\N
SS216	A380	16F	\N
SS216	A380	16K	\N
SS216	A380	17B	\N
SS216	A380	17D	\N
SS216	A380	17G	\N
SS216	A380	17J	\N
SS216	A380	18A	\N
SS216	A380	18E	\N
SS216	A380	18F	\N
SS216	A380	18K	\N
SS216	A380	19B	\N
SS216	A380	19D	\N
SS216	A380	19G	\N
SS216	A380	19J	\N
SS216	A380	2E	\N
SS216	A380	2F	\N
SS216	A380	2K	\N
SS216	A380	20E	\N
SS216	A380	20F	\N
SS216	A380	20K	\N
SS216	A380	21B	\N
SS216	A380	21G	\N
SS216	A380	21J	\N
SS216	A380	22D	\N
SS216	A380	22G	\N
SS216	A380	23A	\N
SS216	A380	23E	\N
SS216	A380	23F	\N
SS216	A380	23K	\N
SS216	A380	24B	\N
SS216	A380	24D	\N
SS216	A380	24G	\N
SS216	A380	24J	\N
SS216	A380	25A	\N
SS216	A380	25E	\N
SS216	A380	25F	\N
SS216	A380	25K	\N
SS216	A380	26B	\N
SS216	A380	26D	\N
SS216	A380	26G	\N
SS216	A380	26J	\N
SS216	A380	3A	\N
SS216	A380	3E	\N
SS216	A380	3F	\N
SS216	A380	3K	\N
SS216	A380	4A	\N
SS216	A380	4K	\N
SS216	A380	43A	\N
SS216	A380	43H	\N
SS216	A380	43J	\N
SS216	A380	43K	\N
SS216	A380	44A	\N
SS216	A380	44C	\N
SS216	A380	44H	\N
SS216	A380	44J	\N
SS216	A380	44K	\N
SS216	A380	45A	\N
SS216	A380	45B	\N
SS216	A380	45D	\N
SS216	A380	45E	\N
SS216	A380	45F	\N
SS216	A380	45G	\N
SS216	A380	45H	\N
SS216	A380	45J	\N
SS216	A380	45K	\N
SS216	A380	46B	\N
SS216	A380	46C	\N
SS216	A380	46D	\N
SS216	A380	46E	\N
SS216	A380	46F	\N
SS216	A380	46G	\N
SS216	A380	46H	\N
SS216	A380	46J	\N
SS216	A380	46K	\N
SS216	A380	47A	\N
SS216	A380	47B	\N
SS216	A380	47C	\N
SS216	A380	47D	\N
SS216	A380	47E	\N
SS216	A380	47F	\N
SS216	A380	47G	\N
SS216	A380	47H	\N
SS216	A380	47J	\N
SS216	A380	47K	\N
SS216	A380	48A	\N
SS216	A380	48B	\N
SS216	A380	48C	\N
QU263	A350	1A	T270491
SS216	A380	43B	T853119
SS216	A380	44B	T304104
SS216	A380	46A	T175905
SS216	A380	48D	\N
SS216	A380	48E	\N
SS216	A380	48F	\N
SS216	A380	48G	\N
SS216	A380	48H	\N
SS216	A380	48J	\N
SS216	A380	48K	\N
SS216	A380	49A	\N
SS216	A380	49B	\N
SS216	A380	49C	\N
SS216	A380	49D	\N
SS216	A380	49E	\N
SS216	A380	49F	\N
SS216	A380	49G	\N
SS216	A380	49H	\N
SS216	A380	49J	\N
SS216	A380	49K	\N
SS216	A380	50A	\N
SS216	A380	50B	\N
SS216	A380	50C	\N
SS216	A380	50D	\N
SS216	A380	50E	\N
SS216	A380	50F	\N
SS216	A380	50G	\N
SS216	A380	50H	\N
SS216	A380	50J	\N
SS216	A380	50K	\N
SS216	A380	51D	\N
SS216	A380	51E	\N
SS216	A380	51F	\N
SS216	A380	51G	\N
SS216	A380	52A	\N
SS216	A380	52B	\N
SS216	A380	52C	\N
SS216	A380	52H	\N
SS216	A380	52J	\N
SS216	A380	52K	\N
SS216	A380	53A	\N
SS216	A380	53B	\N
SS216	A380	53C	\N
SS216	A380	53H	\N
SS216	A380	53J	\N
SS216	A380	53K	\N
SS216	A380	54A	\N
SS216	A380	54B	\N
SS216	A380	54C	\N
SS216	A380	54D	\N
SS216	A380	54E	\N
SS216	A380	54F	\N
SS216	A380	54G	\N
SS216	A380	54H	\N
SS216	A380	54J	\N
SS216	A380	54K	\N
SS216	A380	55A	\N
SS216	A380	55B	\N
SS216	A380	55C	\N
SS216	A380	55D	\N
SS216	A380	55E	\N
SS216	A380	55F	\N
SS216	A380	55G	\N
SS216	A380	55H	\N
SS216	A380	55J	\N
SS216	A380	55K	\N
SS216	A380	56A	\N
SS216	A380	56B	\N
SS216	A380	56C	\N
SS216	A380	56D	\N
SS216	A380	56E	\N
SS216	A380	56F	\N
SS216	A380	56G	\N
SS216	A380	56H	\N
SS216	A380	56J	\N
SS216	A380	56K	\N
SS216	A380	57A	\N
SS216	A380	57B	\N
SS216	A380	57C	\N
SS216	A380	57D	\N
SS216	A380	57E	\N
SS216	A380	57F	\N
SS216	A380	57G	\N
SS216	A380	57H	\N
SS216	A380	57J	\N
SS216	A380	57K	\N
SS216	A380	58A	\N
SS216	A380	58B	\N
SS216	A380	58C	\N
SS216	A380	58D	\N
SS216	A380	58E	\N
SS216	A380	58F	\N
SS216	A380	58G	\N
SS216	A380	58H	\N
SS216	A380	58J	\N
SS216	A380	58K	\N
SS216	A380	59A	\N
SS216	A380	59B	\N
SS216	A380	59C	\N
SS216	A380	59D	\N
SS216	A380	59E	\N
SS216	A380	59F	\N
SS216	A380	59G	\N
SS216	A380	59H	\N
SS216	A380	59J	\N
SS216	A380	59K	\N
SS216	A380	6D	\N
SS216	A380	21D	\N
SS216	A380	6G	\N
SS216	A380	60A	\N
SS216	A380	60B	\N
SS216	A380	60C	\N
SS216	A380	60D	\N
SS216	A380	60E	\N
SS216	A380	60F	\N
SS216	A380	60G	\N
SS216	A380	60H	\N
SS216	A380	60J	\N
SS216	A380	60K	\N
SS216	A380	61A	\N
SS216	A380	61B	\N
SS216	A380	61C	\N
SS216	A380	61D	\N
SS216	A380	61E	\N
SS216	A380	61F	\N
SS216	A380	61G	\N
SS216	A380	61H	\N
SS216	A380	61J	\N
SS216	A380	61K	\N
SS216	A380	62A	\N
SS216	A380	62B	\N
SS216	A380	62C	\N
SS216	A380	62D	\N
SS216	A380	62E	\N
SS216	A380	62F	\N
SS216	A380	62G	\N
SS216	A380	62H	\N
SS216	A380	62J	\N
SS216	A380	62K	\N
SS216	A380	63A	\N
SS216	A380	63B	\N
SS216	A380	63C	\N
SS216	A380	63D	\N
SS216	A380	63E	\N
SS216	A380	63F	\N
SS216	A380	63G	\N
SS216	A380	63H	\N
SS216	A380	63J	\N
SS216	A380	63K	\N
SS216	A380	64A	\N
SS216	A380	64B	\N
SS216	A380	64C	\N
SS216	A380	64D	\N
SS216	A380	64E	\N
SS216	A380	64F	\N
SS216	A380	64G	\N
SS216	A380	64H	\N
SS216	A380	64J	\N
SS216	A380	64K	\N
SS216	A380	65A	\N
SS216	A380	65B	\N
SS216	A380	65C	\N
SS216	A380	65D	\N
SS216	A380	65E	\N
SS216	A380	65F	\N
SS216	A380	65G	\N
SS216	A380	65H	\N
SS216	A380	65J	\N
SS216	A380	65K	\N
SS216	A380	66H	\N
SS216	A380	66J	\N
SS216	A380	66K	\N
SS216	A380	67B	\N
SS216	A380	67C	\N
SS216	A380	67D	\N
SS216	A380	67E	\N
SS216	A380	67F	\N
SS216	A380	67G	\N
SS216	A380	67H	\N
SS216	A380	67J	\N
SS216	A380	68A	\N
SS216	A380	68B	\N
SS216	A380	68C	\N
SS216	A380	68D	\N
SS216	A380	68E	\N
SS216	A380	68F	\N
SS216	A380	68G	\N
SS216	A380	68H	\N
SS216	A380	68J	\N
SS216	A380	68K	\N
SS216	A380	69A	\N
SS216	A380	69B	\N
SS216	A380	69C	\N
SS216	A380	69D	\N
SS216	A380	69E	\N
SS216	A380	69F	\N
SS216	A380	69G	\N
SS216	A380	69H	\N
SS216	A380	69J	\N
SS216	A380	69K	\N
SS216	A380	7A	\N
SS216	A380	7E	\N
SS216	A380	7F	\N
SS216	A380	7K	\N
SS216	A380	70A	\N
SS216	A380	70B	\N
SS216	A380	70C	\N
SS216	A380	70D	\N
SS216	A380	70E	\N
SS216	A380	70F	\N
SS216	A380	70G	\N
SS216	A380	70H	\N
SS216	A380	70J	\N
SS216	A380	70K	\N
SS216	A380	71A	\N
SS216	A380	71B	\N
SS216	A380	71C	\N
SS216	A380	71D	\N
SS216	A380	71E	\N
SS216	A380	71F	\N
SS216	A380	71G	\N
SS216	A380	71H	\N
SS216	A380	71J	\N
SS216	A380	71K	\N
SS216	A380	72A	\N
SS216	A380	72B	\N
SS216	A380	72C	\N
SS216	A380	72D	\N
SS216	A380	72E	\N
SS216	A380	72F	\N
SS216	A380	72G	\N
SS216	A380	72H	\N
SS216	A380	72J	\N
SS216	A380	72K	\N
SS216	A380	73A	\N
SS216	A380	73B	\N
SS216	A380	73C	\N
SS216	A380	73D	\N
SS216	A380	73E	\N
SS216	A380	73F	\N
SS216	A380	73G	\N
SS216	A380	73H	\N
SS216	A380	73J	\N
SS216	A380	73K	\N
SS216	A380	74A	\N
SS216	A380	74B	\N
SS216	A380	74C	\N
SS216	A380	74D	\N
SS216	A380	74E	\N
SS216	A380	74F	\N
SS216	A380	74G	\N
SS216	A380	74H	\N
SS216	A380	74J	\N
SS216	A380	74K	\N
SS216	A380	75A	\N
SS216	A380	75B	\N
SS216	A380	75C	\N
SS216	A380	75D	\N
SS216	A380	75E	\N
SS216	A380	75F	\N
SS216	A380	75G	\N
SS216	A380	75H	\N
SS216	A380	75J	\N
SS216	A380	75K	\N
SS216	A380	76A	\N
SS216	A380	76B	\N
SS216	A380	76C	\N
SS216	A380	76D	\N
SS216	A380	76E	\N
SS216	A380	76F	\N
SS216	A380	76G	\N
SS216	A380	76H	\N
SS216	A380	76J	\N
SS216	A380	76K	\N
SS216	A380	77A	\N
SS216	A380	77B	\N
SS216	A380	77C	\N
SS216	A380	77D	\N
SS216	A380	77E	\N
SS216	A380	77F	\N
SS216	A380	77G	\N
SS216	A380	77H	\N
SS216	A380	77J	\N
SS216	A380	77K	\N
SS216	A380	78A	\N
SS216	A380	78B	\N
SS216	A380	78C	\N
SS216	A380	78D	\N
SS216	A380	78E	\N
SS216	A380	78F	\N
SS216	A380	78G	\N
SS216	A380	78H	\N
SS216	A380	78J	\N
SS216	A380	78K	\N
SS216	A380	79A	\N
SS216	A380	79B	\N
SS216	A380	79C	\N
SS216	A380	79H	\N
SS216	A380	79J	\N
SS216	A380	79K	\N
SS216	A380	8B	\N
SS216	A380	8D	\N
SS216	A380	8G	\N
SS216	A380	8J	\N
SS216	A380	80B	\N
SS216	A380	80C	\N
SS216	A380	80H	\N
SS216	A380	80J	\N
SS216	A380	81A	\N
SS216	A380	81B	\N
SS216	A380	81C	\N
SS216	A380	81H	\N
SS216	A380	81J	\N
SS216	A380	81K	\N
SS216	A380	82A	\N
SS216	A380	82B	\N
SS216	A380	82C	\N
SS216	A380	82D	\N
SS216	A380	82E	\N
SS216	A380	82F	\N
SS216	A380	82G	\N
SS216	A380	82H	\N
SS216	A380	82J	\N
SS216	A380	82K	\N
SS216	A380	83A	\N
SS216	A380	83B	\N
SS216	A380	83C	\N
SS216	A380	83D	\N
SS216	A380	83E	\N
SS216	A380	83F	\N
SS216	A380	83G	\N
SS216	A380	83H	\N
SS216	A380	83J	\N
SS216	A380	83K	\N
SS216	A380	84A	\N
SS216	A380	84B	\N
SS216	A380	84C	\N
SS216	A380	84D	\N
SS216	A380	84E	\N
SS216	A380	84F	\N
SS216	A380	84G	\N
SS216	A380	84H	\N
SS216	A380	84J	\N
SS216	A380	84K	\N
SS216	A380	85A	\N
SS216	A380	85B	\N
SS216	A380	85C	\N
SS216	A380	85H	\N
SS216	A380	85J	\N
SS216	A380	85K	\N
SS216	A380	86A	\N
SS216	A380	86B	\N
SS216	A380	86C	\N
SS216	A380	86H	\N
SS216	A380	86J	\N
SS216	A380	86K	\N
SS216	A380	87A	\N
SS216	A380	87B	\N
SS216	A380	87C	\N
SS216	A380	87H	\N
SS216	A380	87J	\N
SS216	A380	87K	\N
SS216	A380	88A	\N
SS216	A380	88B	\N
SS216	A380	88C	\N
SS216	A380	88H	\N
SS216	A380	88J	\N
SS216	A380	88K	\N
SS216	A380	9A	\N
SS216	A380	9E	\N
SS216	A380	9F	\N
SS216	A380	9K	\N
AY611	A350	1A	\N
AY611	A350	1C	\N
AY611	A350	1D	\N
AY611	A350	1G	\N
AY611	A350	1H	\N
AY611	A350	1K	\N
AY611	A350	10D	\N
AY611	A350	10E	\N
AY611	A350	10G	\N
AY611	A350	11A	\N
AY611	A350	11C	\N
AY611	A350	11D	\N
AY611	A350	11E	\N
AY611	A350	11F	\N
AY611	A350	11G	\N
AY611	A350	11H	\N
AY611	A350	11K	\N
AY611	A350	12D	\N
AY611	A350	12E	\N
AY611	A350	12F	\N
AY611	A350	12G	\N
AY611	A350	15D	\N
AY611	A350	15E	\N
AY611	A350	15F	\N
AY611	A350	15G	\N
AY611	A350	15H	\N
AY611	A350	15K	\N
AY611	A350	16A	\N
AY611	A350	16C	\N
AY611	A350	16D	\N
AY611	A350	16E	\N
AY611	A350	16F	\N
AY611	A350	16G	\N
AY611	A350	16H	\N
AY611	A350	16K	\N
AY611	A350	17A	\N
AY611	A350	17C	\N
AY611	A350	17D	\N
AY611	A350	17E	\N
AY611	A350	17F	\N
AY611	A350	17G	\N
AY611	A350	17H	\N
AY611	A350	17K	\N
AY611	A350	18A	\N
AY611	A350	18C	\N
AY611	A350	18D	\N
AY611	A350	18E	\N
AY611	A350	18F	\N
AY611	A350	18G	\N
AY611	A350	18H	\N
AY611	A350	18K	\N
AY611	A350	19A	\N
AY611	A350	19C	\N
AY611	A350	19D	\N
AY611	A350	19E	\N
AY611	A350	19F	\N
AY611	A350	19G	\N
AY611	A350	19H	\N
AY611	A350	19K	\N
AY611	A350	2A	\N
AY611	A350	2C	\N
AY611	A350	2D	\N
AY611	A350	2G	\N
AY611	A350	2H	\N
AY611	A350	2K	\N
AY611	A350	27A	\N
AY611	A350	27B	\N
AY611	A350	27C	\N
AY611	A350	27D	\N
AY611	A350	27E	\N
AY611	A350	27G	\N
AY611	A350	27H	\N
AY611	A350	27J	\N
AY611	A350	27K	\N
AY611	A350	28A	\N
AY611	A350	28B	\N
AY611	A350	28C	\N
AY611	A350	28D	\N
AY611	A350	28E	\N
AY611	A350	28G	\N
AY611	A350	28H	\N
AY611	A350	28J	\N
AY611	A350	28K	\N
AY611	A350	29A	\N
AY611	A350	29B	\N
AY611	A350	29C	\N
AY611	A350	29D	\N
AY611	A350	29E	\N
AY611	A350	29G	\N
AY611	A350	29H	\N
AY611	A350	29J	\N
AY611	A350	29K	\N
AY611	A350	30A	\N
AY611	A350	30B	\N
AY611	A350	30C	\N
AY611	A350	30D	\N
AY611	A350	30E	\N
AY611	A350	30G	\N
AY611	A350	30H	\N
AY611	A350	30J	\N
AY611	A350	30K	\N
AY611	A350	31A	\N
AY611	A350	31B	\N
AY611	A350	31C	\N
AY611	A350	31D	\N
AY611	A350	31E	\N
AY611	A350	31G	\N
AY611	A350	31H	\N
AY611	A350	31J	\N
AY611	A350	31K	\N
AY611	A350	32A	\N
AY611	A350	32B	\N
AY611	A350	32C	\N
AY611	A350	32D	\N
AY611	A350	32E	\N
AY611	A350	32G	\N
AY611	A350	32H	\N
AY611	A350	32J	\N
AY611	A350	32K	\N
AY611	A350	33A	\N
AY611	A350	33B	\N
AY611	A350	33C	\N
AY611	A350	33D	\N
AY611	A350	33E	\N
AY611	A350	33G	\N
AY611	A350	33H	\N
AY611	A350	33J	\N
AY611	A350	33K	\N
AY611	A350	34A	\N
AY611	A350	34B	\N
AY611	A350	34C	\N
AY611	A350	34D	\N
AY611	A350	34E	\N
AY611	A350	34G	\N
AY611	A350	34H	\N
AY611	A350	34J	\N
AY611	A350	34K	\N
AY611	A350	35A	\N
AY611	A350	35B	\N
AY611	A350	35C	\N
AY611	A350	35D	\N
AY611	A350	35E	\N
AY611	A350	35G	\N
AY611	A350	35H	\N
AY611	A350	35J	\N
AY611	A350	35K	\N
AY611	A350	36A	\N
AY611	A350	36B	\N
AY611	A350	36C	\N
AY611	A350	36D	\N
AY611	A350	36E	\N
AY611	A350	36G	\N
AY611	A350	36H	\N
AY611	A350	36J	\N
AY611	A350	36K	\N
AY611	A350	37A	\N
AY611	A350	37B	\N
AY611	A350	37C	\N
AY611	A350	37D	\N
AY611	A350	37E	\N
AY611	A350	37G	\N
AY611	A350	37H	\N
AY611	A350	37J	\N
AY611	A350	37K	\N
AY611	A350	38A	\N
AY611	A350	38B	\N
AY611	A350	38C	\N
AY611	A350	38D	\N
AY611	A350	38E	\N
AY611	A350	38G	\N
AY611	A350	38H	\N
AY611	A350	38J	\N
AY611	A350	38K	\N
AY611	A350	39A	\N
AY611	A350	39B	\N
AY611	A350	39C	\N
AY611	A350	39D	\N
AY611	A350	39E	\N
AY611	A350	39G	\N
AY611	A350	39H	\N
AY611	A350	39J	\N
CR158	A350	10A	T984917
OH179	A350	1A	\N
OH179	A350	1C	\N
OH179	A350	1D	\N
OH179	A350	1G	\N
OH179	A350	1H	\N
OH179	A350	1K	\N
OH179	A350	10A	\N
OH179	A350	10C	\N
OH179	A350	10D	\N
OH179	A350	10E	\N
OH179	A350	10F	\N
OH179	A350	10G	\N
OH179	A350	10H	\N
OH179	A350	10K	\N
OH179	A350	11A	\N
OH179	A350	11C	\N
OH179	A350	11D	\N
OH179	A350	11E	\N
OH179	A350	11F	\N
OH179	A350	11G	\N
OH179	A350	11H	\N
OH179	A350	11K	\N
OH179	A350	12D	\N
OH179	A350	12E	\N
OH179	A350	12F	\N
OH179	A350	12G	\N
OH179	A350	15D	\N
OH179	A350	15E	\N
OH179	A350	15F	\N
OH179	A350	15G	\N
OH179	A350	15H	\N
OH179	A350	15K	\N
OH179	A350	16A	\N
OH179	A350	16C	\N
OH179	A350	16D	\N
OH179	A350	16E	\N
OH179	A350	16F	\N
OH179	A350	16G	\N
OH179	A350	16H	\N
OH179	A350	16K	\N
OH179	A350	17A	\N
OH179	A350	17C	\N
OH179	A350	17D	\N
OH179	A350	17E	\N
OH179	A350	17F	\N
OH179	A350	17G	\N
OH179	A350	17H	\N
OH179	A350	17K	\N
OH179	A350	18A	\N
OH179	A350	18C	\N
OH179	A350	18D	\N
OH179	A350	18E	\N
OH179	A350	18F	\N
OH179	A350	18G	\N
OH179	A350	18H	\N
OH179	A350	18K	\N
OH179	A350	19A	\N
OH179	A350	19C	\N
OH179	A350	19D	\N
OH179	A350	19E	\N
OH179	A350	19F	\N
OH179	A350	19G	\N
OH179	A350	19H	\N
OH179	A350	19K	\N
OH179	A350	2A	\N
OH179	A350	2C	\N
OH179	A350	2D	\N
OH179	A350	2G	\N
OH179	A350	2H	\N
OH179	A350	2K	\N
OH179	A350	27A	\N
OH179	A350	27B	\N
OH179	A350	27C	\N
OH179	A350	27D	\N
OH179	A350	27E	\N
OH179	A350	27G	\N
OH179	A350	27H	\N
OH179	A350	27J	\N
OH179	A350	27K	\N
OH179	A350	28A	\N
OH179	A350	28B	\N
OH179	A350	28C	\N
OH179	A350	28D	\N
OH179	A350	28E	\N
OH179	A350	28G	\N
OH179	A350	28H	\N
CR158	A350	1G	T318118
CR158	A350	1D	T778205
CR158	A350	10F	T955117
ZE355	A380	1K	T941985
ZE355	A380	1F	T682199
ZE355	A380	3E	T539990
ZE355	A380	2E	T924508
OQ831	A350	1A	T798011
SU399	A380	45B	T166019
SS216	A380	45C	T875668
OQ831	A350	10F	T171862
SU399	A380	45C	T386035
XJ392	A350	27B	T630799
XJ392	A350	27C	T843803
SS216	A380	43C	T228572
AY611	A350	10H	T965146
AY611	A350	10A	T521867
AY611	A350	10F	T828308
AY611	A350	10K	T856742
AY611	A350	10C	T305740
XJ392	A350	30C	\N
LP699	A350	1A	\N
LP699	A350	1C	\N
LP699	A350	1D	\N
LP699	A350	1G	\N
LP699	A350	1H	\N
LP699	A350	1K	\N
LP699	A350	10A	\N
LP699	A350	10C	\N
LP699	A350	10D	\N
LP699	A350	10E	\N
LP699	A350	10F	\N
LP699	A350	10G	\N
LP699	A350	10H	\N
LP699	A350	10K	\N
LP699	A350	11A	\N
LP699	A350	11C	\N
LP699	A350	11D	\N
LP699	A350	11E	\N
LP699	A350	11F	\N
LP699	A350	11G	\N
LP699	A350	11H	\N
LP699	A350	11K	\N
LP699	A350	12D	\N
LP699	A350	12E	\N
LP699	A350	12F	\N
LP699	A350	12G	\N
LP699	A350	15D	\N
LP699	A350	15E	\N
LP699	A350	15F	\N
LP699	A350	15G	\N
LP699	A350	15H	\N
LP699	A350	15K	\N
LP699	A350	16A	\N
LP699	A350	16C	\N
LP699	A350	16D	\N
LP699	A350	16E	\N
LP699	A350	16F	\N
LP699	A350	16G	\N
LP699	A350	16H	\N
LP699	A350	16K	\N
LP699	A350	17A	\N
LP699	A350	17C	\N
LP699	A350	17D	\N
LP699	A350	17E	\N
LP699	A350	17F	\N
LP699	A350	17G	\N
LP699	A350	17H	\N
LP699	A350	17K	\N
LP699	A350	18A	\N
LP699	A350	18C	\N
LP699	A350	18D	\N
LP699	A350	18E	\N
LP699	A350	18F	\N
LP699	A350	18G	\N
LP699	A350	18H	\N
LP699	A350	18K	\N
LP699	A350	19A	\N
LP699	A350	19C	\N
LP699	A350	19D	\N
LP699	A350	19E	\N
LP699	A350	19F	\N
LP699	A350	19G	\N
LP699	A350	19H	\N
LP699	A350	19K	\N
LP699	A350	2A	\N
LP699	A350	2C	\N
LP699	A350	2D	\N
LP699	A350	2G	\N
LP699	A350	2H	\N
LP699	A350	2K	\N
LP699	A350	27A	\N
LP699	A350	27B	\N
LP699	A350	27C	\N
LP699	A350	27D	\N
LP699	A350	27E	\N
LP699	A350	27G	\N
LP699	A350	27H	\N
LP699	A350	27J	\N
LP699	A350	27K	\N
LP699	A350	28A	\N
LP699	A350	28B	\N
LP699	A350	28C	\N
LP699	A350	28D	\N
LP699	A350	28E	\N
LP699	A350	28G	\N
LP699	A350	28H	\N
LP699	A350	28J	\N
LP699	A350	28K	\N
LP699	A350	29A	\N
LP699	A350	29B	\N
LP699	A350	29C	\N
LP699	A350	29D	\N
LP699	A350	29E	\N
LP699	A350	29G	\N
LP699	A350	29H	\N
LP699	A350	29J	\N
LP699	A350	29K	\N
LP699	A350	30A	\N
LP699	A350	30B	\N
LP699	A350	30C	\N
LP699	A350	30D	\N
LP699	A350	30E	\N
LP699	A350	30G	\N
LP699	A350	30H	\N
LP699	A350	30J	\N
LP699	A350	30K	\N
LP699	A350	31A	\N
LP699	A350	31B	\N
LP699	A350	31C	\N
LP699	A350	31D	\N
LP699	A350	31E	\N
LP699	A350	31G	\N
LP699	A350	31H	\N
LP699	A350	31J	\N
LP699	A350	31K	\N
LP699	A350	32A	\N
LP699	A350	32B	\N
LP699	A350	32C	\N
LP699	A350	32D	\N
LP699	A350	32E	\N
LP699	A350	32G	\N
LP699	A350	32H	\N
LP699	A350	32J	\N
LP699	A350	32K	\N
LP699	A350	33A	\N
LP699	A350	33B	\N
LP699	A350	33C	\N
LP699	A350	33D	\N
LP699	A350	33E	\N
LP699	A350	33G	\N
LP699	A350	33H	\N
LP699	A350	33J	\N
LP699	A350	33K	\N
LP699	A350	34A	\N
LP699	A350	34B	\N
LP699	A350	34C	\N
LP699	A350	34D	\N
LP699	A350	34E	\N
LP699	A350	34G	\N
LP699	A350	34H	\N
LP699	A350	34J	\N
LP699	A350	34K	\N
LP699	A350	35A	\N
LP699	A350	35B	\N
LP699	A350	35C	\N
LP699	A350	35D	\N
LP699	A350	35E	\N
LP699	A350	35G	\N
LP699	A350	35H	\N
LP699	A350	35J	\N
LP699	A350	35K	\N
LP699	A350	36A	\N
LP699	A350	36B	\N
LP699	A350	36C	\N
LP699	A350	36D	\N
LP699	A350	36E	\N
LP699	A350	36G	\N
LP699	A350	36H	\N
LP699	A350	36J	\N
LP699	A350	36K	\N
LP699	A350	37A	\N
LP699	A350	37B	\N
LP699	A350	37C	\N
LP699	A350	37D	\N
LP699	A350	37E	\N
LP699	A350	37G	\N
LP699	A350	37H	\N
LP699	A350	37J	\N
LP699	A350	37K	\N
LP699	A350	38A	\N
LP699	A350	38B	\N
LP699	A350	38C	\N
LP699	A350	38D	\N
LP699	A350	38E	\N
LP699	A350	38G	\N
LP699	A350	38H	\N
LP699	A350	38J	\N
LP699	A350	38K	\N
LP699	A350	39A	\N
LP699	A350	39B	\N
LP699	A350	39C	\N
LP699	A350	39D	\N
LP699	A350	39E	\N
LP699	A350	39G	\N
LP699	A350	39H	\N
LP699	A350	39J	\N
LP699	A350	39K	\N
LP699	A350	40D	\N
LP699	A350	40E	\N
LP699	A350	40G	\N
LP699	A350	45A	\N
LP699	A350	45B	\N
LP699	A350	45C	\N
LP699	A350	45D	\N
LP699	A350	45E	\N
LP699	A350	45G	\N
LP699	A350	45H	\N
LP699	A350	45J	\N
LP699	A350	45K	\N
LP699	A350	46A	\N
LP699	A350	46B	\N
LP699	A350	46C	\N
LP699	A350	46D	\N
LP699	A350	46E	\N
LP699	A350	46G	\N
LP699	A350	46H	\N
LP699	A350	46J	\N
LP699	A350	46K	\N
LP699	A350	47A	\N
LP699	A350	47B	\N
LP699	A350	47C	\N
LP699	A350	47D	\N
LP699	A350	47E	\N
LP699	A350	47G	\N
LP699	A350	47H	\N
LP699	A350	47J	\N
LP699	A350	47K	\N
LP699	A350	48A	\N
LP699	A350	48B	\N
LP699	A350	48C	\N
LP699	A350	48D	\N
LP699	A350	48E	\N
LP699	A350	48G	\N
LP699	A350	48H	\N
LP699	A350	48J	\N
LP699	A350	48K	\N
LP699	A350	49A	\N
LP699	A350	49B	\N
LP699	A350	49C	\N
LP699	A350	49D	\N
LP699	A350	49E	\N
LP699	A350	49G	\N
LP699	A350	49H	\N
LP699	A350	49J	\N
LP699	A350	49K	\N
LP699	A350	5A	\N
LP699	A350	5C	\N
LP699	A350	5H	\N
LP699	A350	5K	\N
LP699	A350	50A	\N
LP699	A350	50B	\N
LP699	A350	50C	\N
LP699	A350	50D	\N
LP699	A350	50E	\N
LP699	A350	50G	\N
LP699	A350	50H	\N
LP699	A350	50J	\N
LP699	A350	50K	\N
LP699	A350	51A	\N
LP699	A350	51B	\N
LP699	A350	51C	\N
LP699	A350	51D	\N
LP699	A350	51E	\N
LP699	A350	51G	\N
LP699	A350	51H	\N
LP699	A350	51J	\N
LP699	A350	51K	\N
LP699	A350	52A	\N
LP699	A350	52B	\N
LP699	A350	52C	\N
LP699	A350	52D	\N
LP699	A350	52E	\N
LP699	A350	52G	\N
LP699	A350	52H	\N
LP699	A350	52J	\N
LP699	A350	52K	\N
LP699	A350	53A	\N
LP699	A350	53B	\N
LP699	A350	53C	\N
LP699	A350	53D	\N
LP699	A350	53E	\N
LP699	A350	53G	\N
LP699	A350	53H	\N
LP699	A350	53J	\N
LP699	A350	53K	\N
LP699	A350	54A	\N
LP699	A350	54B	\N
LP699	A350	54C	\N
LP699	A350	54D	\N
LP699	A350	54E	\N
LP699	A350	54G	\N
LP699	A350	54H	\N
LP699	A350	54J	\N
LP699	A350	54K	\N
LP699	A350	55A	\N
LP699	A350	55B	\N
LP699	A350	55C	\N
LP699	A350	55D	\N
LP699	A350	55E	\N
LP699	A350	55G	\N
LP699	A350	55H	\N
LP699	A350	55J	\N
LP699	A350	55K	\N
LP699	A350	56A	\N
LP699	A350	56B	\N
LP699	A350	56C	\N
LP699	A350	56D	\N
LP699	A350	56E	\N
LP699	A350	56G	\N
LP699	A350	56H	\N
LP699	A350	56J	\N
LP699	A350	56K	\N
LP699	A350	57A	\N
LP699	A350	57B	\N
LP699	A350	57C	\N
LP699	A350	57D	\N
LP699	A350	57E	\N
LP699	A350	57G	\N
LP699	A350	57H	\N
LP699	A350	57J	\N
LP699	A350	57K	\N
LP699	A350	58A	\N
LP699	A350	58B	\N
LP699	A350	58C	\N
LP699	A350	58D	\N
LP699	A350	58E	\N
LP699	A350	58G	\N
LP699	A350	58H	\N
LP699	A350	58J	\N
LP699	A350	58K	\N
LP699	A350	59A	\N
LP699	A350	59B	\N
LP699	A350	59C	\N
LP699	A350	59D	\N
LP699	A350	59E	\N
LP699	A350	59G	\N
LP699	A350	59H	\N
LP699	A350	59J	\N
LP699	A350	59K	\N
LP699	A350	6A	\N
LP699	A350	6C	\N
LP699	A350	6D	\N
LP699	A350	6E	\N
LP699	A350	6F	\N
LP699	A350	6G	\N
LP699	A350	6H	\N
LP699	A350	6K	\N
LP699	A350	60A	\N
LP699	A350	60C	\N
LP699	A350	60D	\N
LP699	A350	60E	\N
LP699	A350	60G	\N
LP699	A350	61D	\N
LP699	A350	61E	\N
LP699	A350	61G	\N
LP699	A350	7A	\N
LP699	A350	7C	\N
LP699	A350	7D	\N
LP699	A350	7E	\N
LP699	A350	7F	\N
LP699	A350	7G	\N
LP699	A350	7H	\N
LP699	A350	7K	\N
LP699	A350	8A	\N
LP699	A350	8C	\N
LP699	A350	8D	\N
LP699	A350	8E	\N
LP699	A350	8F	\N
LP699	A350	8G	\N
LP699	A350	8H	\N
LP699	A350	8K	\N
LP699	A350	9A	\N
LP699	A350	9C	\N
LP699	A350	9D	\N
LP699	A350	9E	\N
LP699	A350	9F	\N
LP699	A350	9G	\N
LP699	A350	9H	\N
LP699	A350	9K	\N
UG650	A380	1A	\N
UG650	A380	1E	\N
UG650	A380	1F	\N
UG650	A380	1K	\N
UG650	A380	10B	\N
UG650	A380	10D	\N
UG650	A380	10G	\N
UG650	A380	10J	\N
UG650	A380	11A	\N
UG650	A380	11E	\N
UG650	A380	11F	\N
UG650	A380	11K	\N
UG650	A380	12B	\N
UG650	A380	12D	\N
UG650	A380	12G	\N
UG650	A380	12J	\N
UG650	A380	14A	\N
UG650	A380	14E	\N
UG650	A380	14F	\N
UG650	A380	14K	\N
UG650	A380	15B	\N
UG650	A380	15D	\N
UG650	A380	15G	\N
UG650	A380	15J	\N
UG650	A380	16A	\N
UG650	A380	16E	\N
UG650	A380	16F	\N
UG650	A380	16K	\N
UG650	A380	17B	\N
UG650	A380	17D	\N
UG650	A380	17G	\N
UG650	A380	17J	\N
UG650	A380	18A	\N
UG650	A380	18E	\N
UG650	A380	18F	\N
UG650	A380	18K	\N
UG650	A380	19B	\N
UG650	A380	19D	\N
UG650	A380	19G	\N
UG650	A380	19J	\N
UG650	A380	2A	\N
UG650	A380	2E	\N
UG650	A380	2F	\N
UG650	A380	2K	\N
UG650	A380	20A	\N
UG650	A380	20E	\N
UG650	A380	20F	\N
UG650	A380	20K	\N
UG650	A380	21B	\N
UG650	A380	21D	\N
UG650	A380	21G	\N
UG650	A380	21J	\N
UG650	A380	22D	\N
UG650	A380	22G	\N
UG650	A380	23A	\N
UG650	A380	23E	\N
UG650	A380	23F	\N
UG650	A380	23K	\N
UG650	A380	24B	\N
UG650	A380	24D	\N
UG650	A380	24G	\N
UG650	A380	24J	\N
UG650	A380	25A	\N
UG650	A380	25E	\N
UG650	A380	25F	\N
UG650	A380	25K	\N
UG650	A380	26B	\N
UG650	A380	26D	\N
UG650	A380	26G	\N
UG650	A380	26J	\N
UG650	A380	3A	\N
UG650	A380	3E	\N
UG650	A380	3F	\N
UG650	A380	3K	\N
UG650	A380	4A	\N
UG650	A380	4K	\N
UG650	A380	43A	\N
UG650	A380	43B	\N
UG650	A380	43C	\N
UG650	A380	43H	\N
UG650	A380	43J	\N
UG650	A380	43K	\N
UG650	A380	44A	\N
UG650	A380	44B	\N
UG650	A380	44C	\N
UG650	A380	44H	\N
UG650	A380	44J	\N
UG650	A380	44K	\N
UG650	A380	45A	\N
UG650	A380	45B	\N
UG650	A380	45C	\N
UG650	A380	45D	\N
UG650	A380	45E	\N
UG650	A380	45F	\N
UG650	A380	45G	\N
UG650	A380	45H	\N
UG650	A380	45J	\N
UG650	A380	45K	\N
UG650	A380	46A	\N
UG650	A380	46B	\N
UG650	A380	46C	\N
UG650	A380	46D	\N
UG650	A380	46E	\N
UG650	A380	46F	\N
UG650	A380	46G	\N
UG650	A380	46H	\N
UG650	A380	46J	\N
UG650	A380	46K	\N
UG650	A380	47A	\N
UG650	A380	47B	\N
UG650	A380	47C	\N
UG650	A380	47D	\N
UG650	A380	47E	\N
UG650	A380	47F	\N
UG650	A380	47G	\N
UG650	A380	47H	\N
UG650	A380	47J	\N
UG650	A380	47K	\N
UG650	A380	48A	\N
UG650	A380	48B	\N
UG650	A380	48C	\N
UG650	A380	48D	\N
UG650	A380	48E	\N
UG650	A380	48F	\N
UG650	A380	48G	\N
UG650	A380	48H	\N
UG650	A380	48J	\N
UG650	A380	48K	\N
UG650	A380	49A	\N
UG650	A380	49B	\N
UG650	A380	49C	\N
UG650	A380	49D	\N
UG650	A380	49E	\N
UG650	A380	49F	\N
UG650	A380	49G	\N
UG650	A380	49H	\N
UG650	A380	49J	\N
UG650	A380	49K	\N
UG650	A380	50A	\N
UG650	A380	50B	\N
UG650	A380	50C	\N
UG650	A380	50D	\N
UG650	A380	50E	\N
UG650	A380	50F	\N
UG650	A380	50G	\N
UG650	A380	50H	\N
UG650	A380	50J	\N
UG650	A380	50K	\N
UG650	A380	51D	\N
UG650	A380	51E	\N
UG650	A380	51F	\N
UG650	A380	51G	\N
UG650	A380	52A	\N
UG650	A380	52B	\N
UG650	A380	52C	\N
UG650	A380	52H	\N
UG650	A380	52J	\N
UG650	A380	52K	\N
UG650	A380	53A	\N
UG650	A380	53B	\N
UG650	A380	53C	\N
UG650	A380	53H	\N
UG650	A380	53J	\N
UG650	A380	53K	\N
UG650	A380	54A	\N
UG650	A380	54B	\N
UG650	A380	54C	\N
UG650	A380	54D	\N
UG650	A380	54E	\N
UG650	A380	54F	\N
UG650	A380	54G	\N
UG650	A380	54H	\N
UG650	A380	54J	\N
UG650	A380	54K	\N
UG650	A380	55A	\N
UG650	A380	55B	\N
UG650	A380	55C	\N
UG650	A380	55D	\N
UG650	A380	55E	\N
UG650	A380	55F	\N
UG650	A380	55G	\N
UG650	A380	55H	\N
UG650	A380	55J	\N
UG650	A380	55K	\N
UG650	A380	56A	\N
UG650	A380	56B	\N
UG650	A380	56C	\N
UG650	A380	56D	\N
UG650	A380	56E	\N
UG650	A380	56F	\N
UG650	A380	56G	\N
UG650	A380	56H	\N
UG650	A380	56J	\N
UG650	A380	56K	\N
UG650	A380	57A	\N
UG650	A380	57B	\N
UG650	A380	57C	\N
UG650	A380	57D	\N
UG650	A380	57E	\N
UG650	A380	57F	\N
UG650	A380	57G	\N
UG650	A380	57H	\N
UG650	A380	57J	\N
UG650	A380	57K	\N
UG650	A380	58A	\N
UG650	A380	58B	\N
UG650	A380	58C	\N
UG650	A380	58D	\N
UG650	A380	58E	\N
UG650	A380	58F	\N
UG650	A380	58G	\N
UG650	A380	58H	\N
UG650	A380	58J	\N
UG650	A380	58K	\N
UG650	A380	59A	\N
UG650	A380	59B	\N
UG650	A380	59C	\N
UG650	A380	59D	\N
UG650	A380	59E	\N
UG650	A380	59F	\N
UG650	A380	59G	\N
UG650	A380	59H	\N
UG650	A380	59J	\N
UG650	A380	59K	\N
UG650	A380	6D	\N
UG650	A380	6G	\N
UG650	A380	60A	\N
UG650	A380	60B	\N
UG650	A380	60C	\N
UG650	A380	60D	\N
UG650	A380	60E	\N
UG650	A380	60F	\N
UG650	A380	60G	\N
UG650	A380	60H	\N
UG650	A380	60J	\N
UG650	A380	60K	\N
UG650	A380	61A	\N
UG650	A380	61B	\N
UG650	A380	61C	\N
UG650	A380	61D	\N
UG650	A380	61E	\N
UG650	A380	61F	\N
UG650	A380	61G	\N
UG650	A380	61H	\N
UG650	A380	61J	\N
UG650	A380	61K	\N
UG650	A380	62A	\N
UG650	A380	62B	\N
UG650	A380	62C	\N
UG650	A380	62D	\N
UG650	A380	62E	\N
UG650	A380	62F	\N
UG650	A380	62G	\N
UG650	A380	62H	\N
UG650	A380	62J	\N
UG650	A380	62K	\N
UG650	A380	63A	\N
UG650	A380	63B	\N
UG650	A380	63C	\N
UG650	A380	63D	\N
UG650	A380	63E	\N
UG650	A380	63F	\N
UG650	A380	63G	\N
UG650	A380	63H	\N
UG650	A380	63J	\N
UG650	A380	63K	\N
UG650	A380	64A	\N
UG650	A380	64B	\N
UG650	A380	64C	\N
UG650	A380	64D	\N
UG650	A380	64E	\N
UG650	A380	64F	\N
UG650	A380	64G	\N
UG650	A380	64H	\N
UG650	A380	64J	\N
UG650	A380	64K	\N
UG650	A380	65A	\N
UG650	A380	65B	\N
UG650	A380	65C	\N
UG650	A380	65D	\N
UG650	A380	65E	\N
UG650	A380	65F	\N
UG650	A380	65G	\N
UG650	A380	65H	\N
UG650	A380	65J	\N
UG650	A380	65K	\N
UG650	A380	66H	\N
UG650	A380	66J	\N
UG650	A380	66K	\N
UG650	A380	67B	\N
UG650	A380	67C	\N
UG650	A380	67D	\N
UG650	A380	67E	\N
UG650	A380	67F	\N
UG650	A380	67G	\N
UG650	A380	67H	\N
UG650	A380	67J	\N
UG650	A380	68A	\N
UG650	A380	68B	\N
UG650	A380	68C	\N
UG650	A380	68D	\N
UG650	A380	68E	\N
UG650	A380	68F	\N
UG650	A380	68G	\N
UG650	A380	68H	\N
UG650	A380	68J	\N
UG650	A380	68K	\N
UG650	A380	69A	\N
UG650	A380	69B	\N
UG650	A380	69C	\N
UG650	A380	69D	\N
UG650	A380	69E	\N
UG650	A380	69F	\N
UG650	A380	69G	\N
UG650	A380	69H	\N
UG650	A380	69J	\N
UG650	A380	69K	\N
UG650	A380	7A	\N
UG650	A380	7E	\N
UG650	A380	7F	\N
UG650	A380	7K	\N
UG650	A380	70A	\N
UG650	A380	70B	\N
UG650	A380	70C	\N
UG650	A380	70D	\N
UG650	A380	70E	\N
UG650	A380	70F	\N
UG650	A380	70G	\N
UG650	A380	70H	\N
UG650	A380	70J	\N
UG650	A380	70K	\N
UG650	A380	71A	\N
UG650	A380	71B	\N
UG650	A380	71C	\N
UG650	A380	71D	\N
UG650	A380	71E	\N
UG650	A380	71F	\N
UG650	A380	71G	\N
UG650	A380	71H	\N
UG650	A380	71J	\N
UG650	A380	71K	\N
UG650	A380	72A	\N
UG650	A380	72B	\N
UG650	A380	72C	\N
UG650	A380	72D	\N
UG650	A380	72E	\N
UG650	A380	72F	\N
UG650	A380	72G	\N
UG650	A380	72H	\N
UG650	A380	72J	\N
UG650	A380	72K	\N
UG650	A380	73A	\N
UG650	A380	73B	\N
UG650	A380	73C	\N
UG650	A380	73D	\N
UG650	A380	73E	\N
UG650	A380	73F	\N
UG650	A380	73G	\N
UG650	A380	73H	\N
UG650	A380	73J	\N
UG650	A380	73K	\N
UG650	A380	74A	\N
UG650	A380	74B	\N
UG650	A380	74C	\N
UG650	A380	74D	\N
UG650	A380	74E	\N
UG650	A380	74F	\N
UG650	A380	74G	\N
UG650	A380	74H	\N
UG650	A380	74J	\N
UG650	A380	74K	\N
UG650	A380	75A	\N
UG650	A380	75B	\N
UG650	A380	75C	\N
UG650	A380	75D	\N
UG650	A380	75E	\N
UG650	A380	75F	\N
UG650	A380	75G	\N
UG650	A380	75H	\N
UG650	A380	75J	\N
UG650	A380	75K	\N
UG650	A380	76A	\N
UG650	A380	76B	\N
UG650	A380	76C	\N
UG650	A380	76D	\N
UG650	A380	76E	\N
UG650	A380	76F	\N
UG650	A380	76G	\N
UG650	A380	76H	\N
UG650	A380	76J	\N
UG650	A380	76K	\N
UG650	A380	77A	\N
UG650	A380	77B	\N
UG650	A380	77C	\N
UG650	A380	77D	\N
UG650	A380	77E	\N
UG650	A380	77F	\N
UG650	A380	77G	\N
UG650	A380	77H	\N
UG650	A380	77J	\N
UG650	A380	77K	\N
UG650	A380	78A	\N
UG650	A380	78B	\N
UG650	A380	78C	\N
UG650	A380	78D	\N
UG650	A380	78E	\N
UG650	A380	78F	\N
UG650	A380	78G	\N
UG650	A380	78H	\N
UG650	A380	78J	\N
UG650	A380	78K	\N
UG650	A380	79A	\N
UG650	A380	79B	\N
UG650	A380	79C	\N
UG650	A380	79H	\N
UG650	A380	79J	\N
UG650	A380	79K	\N
UG650	A380	8B	\N
UG650	A380	8D	\N
UG650	A380	8G	\N
UG650	A380	8J	\N
UG650	A380	80B	\N
UG650	A380	80C	\N
UG650	A380	80H	\N
UG650	A380	80J	\N
UG650	A380	81A	\N
UG650	A380	81B	\N
UG650	A380	81C	\N
UG650	A380	81H	\N
UG650	A380	81J	\N
UG650	A380	81K	\N
UG650	A380	82A	\N
UG650	A380	82B	\N
UG650	A380	82C	\N
UG650	A380	82D	\N
UG650	A380	82E	\N
UG650	A380	82F	\N
UG650	A380	82G	\N
UG650	A380	82H	\N
UG650	A380	82J	\N
UG650	A380	82K	\N
UG650	A380	83A	\N
UG650	A380	83B	\N
UG650	A380	83C	\N
UG650	A380	83D	\N
UG650	A380	83E	\N
UG650	A380	83F	\N
UG650	A380	83G	\N
UG650	A380	83H	\N
UG650	A380	83J	\N
UG650	A380	83K	\N
UG650	A380	84A	\N
UG650	A380	84B	\N
UG650	A380	84C	\N
UG650	A380	84D	\N
UG650	A380	84E	\N
UG650	A380	84F	\N
UG650	A380	84G	\N
UG650	A380	84H	\N
UG650	A380	84J	\N
UG650	A380	84K	\N
UG650	A380	85A	\N
UG650	A380	85B	\N
UG650	A380	85C	\N
UG650	A380	85H	\N
UG650	A380	85J	\N
UG650	A380	85K	\N
UG650	A380	86A	\N
UG650	A380	86B	\N
UG650	A380	86C	\N
UG650	A380	86H	\N
UG650	A380	86J	\N
UG650	A380	86K	\N
UG650	A380	87A	\N
UG650	A380	87B	\N
UG650	A380	87C	\N
UG650	A380	87H	\N
UG650	A380	87J	\N
UG650	A380	87K	\N
UG650	A380	88A	\N
UG650	A380	88B	\N
UG650	A380	88C	\N
UG650	A380	88H	\N
UG650	A380	88J	\N
UG650	A380	88K	\N
UG650	A380	9A	\N
UG650	A380	9E	\N
UG650	A380	9F	\N
UG650	A380	9K	\N
AX776	A380	1A	\N
AX776	A380	1E	\N
AX776	A380	1F	\N
AX776	A380	1K	\N
AX776	A380	10B	\N
AX776	A380	10D	\N
AX776	A380	10G	\N
AX776	A380	10J	\N
AX776	A380	11A	\N
AX776	A380	11E	\N
AX776	A380	11F	\N
AX776	A380	11K	\N
AX776	A380	12B	\N
AX776	A380	12D	\N
AX776	A380	12G	\N
AX776	A380	12J	\N
AX776	A380	14A	\N
AX776	A380	14E	\N
AX776	A380	14F	\N
AX776	A380	14K	\N
AX776	A380	15B	\N
AX776	A380	15D	\N
AX776	A380	15G	\N
AX776	A380	15J	\N
AX776	A380	16A	\N
AX776	A380	16E	\N
AX776	A380	16F	\N
AX776	A380	16K	\N
AX776	A380	17B	\N
AX776	A380	17D	\N
AX776	A380	17G	\N
AX776	A380	17J	\N
AX776	A380	18A	\N
AX776	A380	18E	\N
AX776	A380	18F	\N
AX776	A380	18K	\N
AX776	A380	19B	\N
AX776	A380	19D	\N
AX776	A380	19G	\N
AX776	A380	19J	\N
AX776	A380	2A	\N
AX776	A380	2E	\N
AX776	A380	2F	\N
AX776	A380	2K	\N
AX776	A380	20A	\N
AX776	A380	20E	\N
AX776	A380	20F	\N
AX776	A380	20K	\N
AX776	A380	21B	\N
AX776	A380	21D	\N
AX776	A380	21G	\N
AX776	A380	21J	\N
AX776	A380	22D	\N
AX776	A380	22G	\N
AX776	A380	23A	\N
AX776	A380	23E	\N
AX776	A380	23F	\N
AX776	A380	23K	\N
AX776	A380	24B	\N
AX776	A380	24D	\N
AX776	A380	24G	\N
AX776	A380	24J	\N
AX776	A380	25A	\N
AX776	A380	25E	\N
AX776	A380	25F	\N
AX776	A380	25K	\N
AX776	A380	26B	\N
AX776	A380	26D	\N
AX776	A380	26G	\N
AX776	A380	26J	\N
AX776	A380	3A	\N
AX776	A380	3E	\N
AX776	A380	3F	\N
AX776	A380	3K	\N
AX776	A380	4A	\N
AX776	A380	4K	\N
AX776	A380	43A	\N
AX776	A380	43B	\N
AX776	A380	43C	\N
AX776	A380	43H	\N
AX776	A380	43J	\N
AX776	A380	43K	\N
AX776	A380	44A	\N
AX776	A380	44B	\N
AX776	A380	44C	\N
AX776	A380	44H	\N
AX776	A380	44J	\N
AX776	A380	44K	\N
AX776	A380	45A	\N
AX776	A380	45B	\N
AX776	A380	45C	\N
AX776	A380	45D	\N
AX776	A380	45E	\N
AX776	A380	45F	\N
AX776	A380	45G	\N
AX776	A380	45H	\N
AX776	A380	45J	\N
AX776	A380	45K	\N
AX776	A380	46A	\N
AX776	A380	46B	\N
AX776	A380	46C	\N
AX776	A380	46D	\N
AX776	A380	46E	\N
AX776	A380	46F	\N
AX776	A380	46G	\N
AX776	A380	46H	\N
AX776	A380	46J	\N
AX776	A380	46K	\N
AX776	A380	47A	\N
AX776	A380	47B	\N
AX776	A380	47C	\N
AX776	A380	47D	\N
AX776	A380	47E	\N
AX776	A380	47F	\N
AX776	A380	47G	\N
AX776	A380	47H	\N
AX776	A380	47J	\N
AX776	A380	47K	\N
AX776	A380	48A	\N
AX776	A380	48B	\N
AX776	A380	48C	\N
AX776	A380	48D	\N
AX776	A380	48E	\N
AX776	A380	48F	\N
AX776	A380	48G	\N
AX776	A380	48H	\N
AX776	A380	48J	\N
AX776	A380	48K	\N
AX776	A380	49A	\N
AX776	A380	49B	\N
AX776	A380	49C	\N
AX776	A380	49D	\N
AX776	A380	49E	\N
AX776	A380	49F	\N
AX776	A380	49G	\N
AX776	A380	49H	\N
AX776	A380	49J	\N
AX776	A380	49K	\N
AX776	A380	50A	\N
AX776	A380	50B	\N
AX776	A380	50C	\N
AX776	A380	50D	\N
AX776	A380	50E	\N
AX776	A380	50F	\N
AX776	A380	50G	\N
AX776	A380	50H	\N
AX776	A380	50J	\N
AX776	A380	50K	\N
AX776	A380	51D	\N
AX776	A380	51E	\N
AX776	A380	51F	\N
AX776	A380	51G	\N
AX776	A380	52A	\N
AX776	A380	52B	\N
AX776	A380	52C	\N
AX776	A380	52H	\N
AX776	A380	52J	\N
AX776	A380	52K	\N
AX776	A380	53A	\N
AX776	A380	53B	\N
AX776	A380	53C	\N
AX776	A380	53H	\N
AX776	A380	53J	\N
AX776	A380	53K	\N
AX776	A380	54A	\N
AX776	A380	54B	\N
AX776	A380	54C	\N
AX776	A380	54D	\N
AX776	A380	54E	\N
AX776	A380	54F	\N
AX776	A380	54G	\N
AX776	A380	54H	\N
AX776	A380	54J	\N
AX776	A380	54K	\N
AX776	A380	55A	\N
AX776	A380	55B	\N
AX776	A380	55C	\N
AX776	A380	55D	\N
AX776	A380	55E	\N
AX776	A380	55F	\N
AX776	A380	55G	\N
AX776	A380	55H	\N
AX776	A380	55J	\N
AX776	A380	55K	\N
AX776	A380	56A	\N
AX776	A380	56B	\N
AX776	A380	56C	\N
AX776	A380	56D	\N
AX776	A380	56E	\N
AX776	A380	56F	\N
AX776	A380	56G	\N
AX776	A380	56H	\N
AX776	A380	56J	\N
AX776	A380	56K	\N
AX776	A380	57A	\N
AX776	A380	57B	\N
AX776	A380	57C	\N
AX776	A380	57D	\N
AX776	A380	57E	\N
AX776	A380	57F	\N
AX776	A380	57G	\N
AX776	A380	57H	\N
AX776	A380	57J	\N
AX776	A380	57K	\N
AX776	A380	58A	\N
AX776	A380	58B	\N
AX776	A380	58C	\N
AX776	A380	58D	\N
AX776	A380	58E	\N
AX776	A380	58F	\N
AX776	A380	58G	\N
AX776	A380	58H	\N
AX776	A380	58J	\N
AX776	A380	58K	\N
AX776	A380	59A	\N
AX776	A380	59B	\N
AX776	A380	59C	\N
AX776	A380	59D	\N
AX776	A380	59E	\N
AX776	A380	59F	\N
AX776	A380	59G	\N
AX776	A380	59H	\N
AX776	A380	59J	\N
AX776	A380	59K	\N
AX776	A380	6D	\N
AX776	A380	6G	\N
AX776	A380	60A	\N
AX776	A380	60B	\N
AX776	A380	60C	\N
AX776	A380	60D	\N
AX776	A380	60E	\N
AX776	A380	60F	\N
AX776	A380	60G	\N
AX776	A380	60H	\N
AX776	A380	60J	\N
AX776	A380	60K	\N
AX776	A380	61A	\N
AX776	A380	61B	\N
AX776	A380	61C	\N
AX776	A380	61D	\N
AX776	A380	61E	\N
AX776	A380	61F	\N
AX776	A380	61G	\N
AX776	A380	61H	\N
AX776	A380	61J	\N
AX776	A380	61K	\N
AX776	A380	62A	\N
AX776	A380	62B	\N
AX776	A380	62C	\N
AX776	A380	62D	\N
AX776	A380	62E	\N
AX776	A380	62F	\N
AX776	A380	62G	\N
AX776	A380	62H	\N
AX776	A380	62J	\N
AX776	A380	62K	\N
AX776	A380	63A	\N
AX776	A380	63B	\N
AX776	A380	63C	\N
AX776	A380	63D	\N
AX776	A380	63E	\N
AX776	A380	63F	\N
AX776	A380	63G	\N
AX776	A380	63H	\N
AX776	A380	63J	\N
AX776	A380	63K	\N
AX776	A380	64A	\N
AX776	A380	64B	\N
AX776	A380	64C	\N
AX776	A380	64D	\N
AX776	A380	64E	\N
AX776	A380	64F	\N
AX776	A380	64G	\N
AX776	A380	64H	\N
AX776	A380	64J	\N
AX776	A380	64K	\N
AX776	A380	65A	\N
AX776	A380	65B	\N
AX776	A380	65C	\N
AX776	A380	65D	\N
AX776	A380	65E	\N
AX776	A380	65F	\N
AX776	A380	65G	\N
AX776	A380	65H	\N
AX776	A380	65J	\N
AX776	A380	65K	\N
AX776	A380	66H	\N
AX776	A380	66J	\N
AX776	A380	66K	\N
AX776	A380	67B	\N
AX776	A380	67C	\N
AX776	A380	67D	\N
AX776	A380	67E	\N
AX776	A380	67F	\N
AX776	A380	67G	\N
AX776	A380	67H	\N
AX776	A380	67J	\N
AX776	A380	68A	\N
AX776	A380	68B	\N
AX776	A380	68C	\N
AX776	A380	68D	\N
AX776	A380	68E	\N
AX776	A380	68F	\N
AX776	A380	68G	\N
AX776	A380	68H	\N
AX776	A380	68J	\N
AX776	A380	68K	\N
AX776	A380	69A	\N
AX776	A380	69B	\N
AX776	A380	69C	\N
AX776	A380	69D	\N
AX776	A380	69E	\N
AX776	A380	69F	\N
AX776	A380	69G	\N
AX776	A380	69H	\N
AX776	A380	69J	\N
AX776	A380	69K	\N
AX776	A380	7A	\N
AX776	A380	7E	\N
AX776	A380	7F	\N
AX776	A380	7K	\N
AX776	A380	70A	\N
AX776	A380	70B	\N
AX776	A380	70C	\N
AX776	A380	70D	\N
AX776	A380	70E	\N
AX776	A380	70F	\N
AX776	A380	70G	\N
AX776	A380	70H	\N
AX776	A380	70J	\N
AX776	A380	70K	\N
AX776	A380	71A	\N
AX776	A380	71B	\N
AX776	A380	71C	\N
AX776	A380	71D	\N
AX776	A380	71E	\N
AX776	A380	71F	\N
AX776	A380	71G	\N
AX776	A380	71H	\N
AX776	A380	71J	\N
AX776	A380	71K	\N
AX776	A380	72A	\N
AX776	A380	72B	\N
AX776	A380	72C	\N
AX776	A380	72D	\N
AX776	A380	72E	\N
AX776	A380	72F	\N
AX776	A380	72G	\N
AX776	A380	72H	\N
AX776	A380	72J	\N
AX776	A380	72K	\N
AX776	A380	73A	\N
AX776	A380	73B	\N
AX776	A380	73C	\N
AX776	A380	73D	\N
AX776	A380	73E	\N
AX776	A380	73F	\N
AX776	A380	73G	\N
AX776	A380	73H	\N
AX776	A380	73J	\N
AX776	A380	73K	\N
AX776	A380	74A	\N
AX776	A380	74B	\N
AX776	A380	74C	\N
AX776	A380	74D	\N
AX776	A380	74E	\N
AX776	A380	74F	\N
AX776	A380	74G	\N
AX776	A380	74H	\N
AX776	A380	74J	\N
AX776	A380	74K	\N
AX776	A380	75A	\N
AX776	A380	75B	\N
AX776	A380	75C	\N
AX776	A380	75D	\N
AX776	A380	75E	\N
AX776	A380	75F	\N
AX776	A380	75G	\N
AX776	A380	75H	\N
AX776	A380	75J	\N
AX776	A380	75K	\N
AX776	A380	76A	\N
AX776	A380	76B	\N
AX776	A380	76C	\N
AX776	A380	76D	\N
AX776	A380	76E	\N
AX776	A380	76F	\N
AX776	A380	76G	\N
AX776	A380	76H	\N
AX776	A380	76J	\N
AX776	A380	76K	\N
AX776	A380	77A	\N
AX776	A380	77B	\N
AX776	A380	77C	\N
AX776	A380	77D	\N
AX776	A380	77E	\N
AX776	A380	77F	\N
AX776	A380	77G	\N
AX776	A380	77H	\N
AX776	A380	77J	\N
AX776	A380	77K	\N
AX776	A380	78A	\N
AX776	A380	78B	\N
AX776	A380	78C	\N
AX776	A380	78D	\N
AX776	A380	78E	\N
AX776	A380	78F	\N
AX776	A380	78G	\N
AX776	A380	78H	\N
AX776	A380	78J	\N
AX776	A380	78K	\N
AX776	A380	79A	\N
AX776	A380	79B	\N
AX776	A380	79C	\N
AX776	A380	79H	\N
AX776	A380	79J	\N
AX776	A380	79K	\N
AX776	A380	8B	\N
AX776	A380	8D	\N
AX776	A380	8G	\N
AX776	A380	8J	\N
AX776	A380	80B	\N
AX776	A380	80C	\N
AX776	A380	80H	\N
AX776	A380	80J	\N
AX776	A380	81A	\N
AX776	A380	81B	\N
AX776	A380	81C	\N
AX776	A380	81H	\N
AX776	A380	81J	\N
AX776	A380	81K	\N
AX776	A380	82A	\N
AX776	A380	82B	\N
AX776	A380	82C	\N
AX776	A380	82D	\N
AX776	A380	82E	\N
AX776	A380	82F	\N
AX776	A380	82G	\N
AX776	A380	82H	\N
AX776	A380	82J	\N
AX776	A380	82K	\N
AX776	A380	83A	\N
AX776	A380	83B	\N
AX776	A380	83C	\N
AX776	A380	83D	\N
AX776	A380	83E	\N
AX776	A380	83F	\N
AX776	A380	83G	\N
AX776	A380	83H	\N
AX776	A380	83J	\N
AX776	A380	83K	\N
AX776	A380	84A	\N
AX776	A380	84B	\N
AX776	A380	84C	\N
AX776	A380	84D	\N
AX776	A380	84E	\N
AX776	A380	84F	\N
AX776	A380	84G	\N
AX776	A380	84H	\N
AX776	A380	84J	\N
AX776	A380	84K	\N
AX776	A380	85A	\N
AX776	A380	85B	\N
AX776	A380	85C	\N
AX776	A380	85H	\N
AX776	A380	85J	\N
AX776	A380	85K	\N
AX776	A380	86A	\N
AX776	A380	86B	\N
AX776	A380	86C	\N
AX776	A380	86H	\N
AX776	A380	86J	\N
AX776	A380	86K	\N
AX776	A380	87A	\N
AX776	A380	87B	\N
AX776	A380	87C	\N
AX776	A380	87H	\N
AX776	A380	87J	\N
AX776	A380	87K	\N
AX776	A380	88A	\N
AX776	A380	88B	\N
AX776	A380	88C	\N
AX776	A380	88H	\N
AX776	A380	88J	\N
AX776	A380	88K	\N
AX776	A380	9A	\N
AX776	A380	9E	\N
AX776	A380	9F	\N
AX776	A380	9K	\N
ZD340	A350	1A	\N
ZD340	A350	1C	\N
ZD340	A350	1D	\N
ZD340	A350	1G	\N
ZD340	A350	1H	\N
ZD340	A350	1K	\N
ZD340	A350	10A	\N
ZD340	A350	10C	\N
ZD340	A350	10D	\N
ZD340	A350	10E	\N
ZD340	A350	10F	\N
ZD340	A350	10G	\N
ZD340	A350	10H	\N
ZD340	A350	10K	\N
ZD340	A350	11A	\N
ZD340	A350	11C	\N
ZD340	A350	11D	\N
ZD340	A350	11E	\N
ZD340	A350	11F	\N
ZD340	A350	11G	\N
ZD340	A350	11H	\N
ZD340	A350	11K	\N
ZD340	A350	12D	\N
ZD340	A350	12E	\N
ZD340	A350	12F	\N
ZD340	A350	12G	\N
ZD340	A350	15D	\N
ZD340	A350	15E	\N
ZD340	A350	15F	\N
ZD340	A350	15G	\N
ZD340	A350	15H	\N
ZD340	A350	15K	\N
ZD340	A350	16A	\N
ZD340	A350	16C	\N
ZD340	A350	16D	\N
ZD340	A350	16E	\N
ZD340	A350	16F	\N
ZD340	A350	16G	\N
ZD340	A350	16H	\N
ZD340	A350	16K	\N
ZD340	A350	17A	\N
ZD340	A350	17C	\N
ZD340	A350	17D	\N
ZD340	A350	17E	\N
ZD340	A350	17F	\N
ZD340	A350	17G	\N
ZD340	A350	17H	\N
ZD340	A350	17K	\N
ZD340	A350	18A	\N
ZD340	A350	18C	\N
ZD340	A350	18D	\N
ZD340	A350	18E	\N
ZD340	A350	18F	\N
ZD340	A350	18G	\N
ZD340	A350	18H	\N
ZD340	A350	18K	\N
ZD340	A350	19A	\N
ZD340	A350	19C	\N
ZD340	A350	19D	\N
ZD340	A350	19E	\N
ZD340	A350	19F	\N
ZD340	A350	19G	\N
ZD340	A350	19H	\N
ZD340	A350	19K	\N
ZD340	A350	2A	\N
ZD340	A350	2C	\N
ZD340	A350	2D	\N
ZD340	A350	2G	\N
ZD340	A350	2H	\N
ZD340	A350	2K	\N
ZD340	A350	27A	\N
ZD340	A350	27B	\N
ZD340	A350	27C	\N
ZD340	A350	27D	\N
ZD340	A350	27E	\N
ZD340	A350	27G	\N
ZD340	A350	27H	\N
ZD340	A350	27J	\N
ZD340	A350	27K	\N
ZD340	A350	28A	\N
ZD340	A350	28B	\N
ZD340	A350	28C	\N
ZD340	A350	28D	\N
ZD340	A350	28E	\N
ZD340	A350	28G	\N
ZD340	A350	28H	\N
ZD340	A350	28J	\N
ZD340	A350	28K	\N
ZD340	A350	29A	\N
ZD340	A350	29B	\N
ZD340	A350	29C	\N
ZD340	A350	29D	\N
ZD340	A350	29E	\N
ZD340	A350	29G	\N
ZD340	A350	29H	\N
ZD340	A350	29J	\N
ZD340	A350	29K	\N
ZD340	A350	30A	\N
ZD340	A350	30B	\N
ZD340	A350	30C	\N
ZD340	A350	30D	\N
ZD340	A350	30E	\N
ZD340	A350	30G	\N
ZD340	A350	30H	\N
ZD340	A350	30J	\N
ZD340	A350	30K	\N
ZD340	A350	31A	\N
ZD340	A350	31B	\N
ZD340	A350	31C	\N
ZD340	A350	31D	\N
ZD340	A350	31E	\N
ZD340	A350	31G	\N
ZD340	A350	31H	\N
ZD340	A350	31J	\N
ZD340	A350	31K	\N
ZD340	A350	32A	\N
ZD340	A350	32B	\N
ZD340	A350	32C	\N
ZD340	A350	32D	\N
ZD340	A350	32E	\N
ZD340	A350	32G	\N
ZD340	A350	32H	\N
ZD340	A350	32J	\N
ZD340	A350	32K	\N
ZD340	A350	33A	\N
ZD340	A350	33B	\N
ZD340	A350	33C	\N
ZD340	A350	33D	\N
ZD340	A350	33E	\N
ZD340	A350	33G	\N
ZD340	A350	33H	\N
ZD340	A350	33J	\N
ZD340	A350	33K	\N
ZD340	A350	34A	\N
ZD340	A350	34B	\N
ZD340	A350	34C	\N
ZD340	A350	34D	\N
ZD340	A350	34E	\N
ZD340	A350	34G	\N
ZD340	A350	34H	\N
ZD340	A350	34J	\N
ZD340	A350	34K	\N
ZD340	A350	35A	\N
ZD340	A350	35B	\N
ZD340	A350	35C	\N
ZD340	A350	35D	\N
ZD340	A350	35E	\N
ZD340	A350	35G	\N
ZD340	A350	35H	\N
ZD340	A350	35J	\N
ZD340	A350	35K	\N
ZD340	A350	36A	\N
ZD340	A350	36B	\N
ZD340	A350	36C	\N
ZD340	A350	36D	\N
ZD340	A350	36E	\N
ZD340	A350	36G	\N
ZD340	A350	36H	\N
ZD340	A350	36J	\N
ZD340	A350	36K	\N
ZD340	A350	37A	\N
ZD340	A350	37B	\N
ZD340	A350	37C	\N
ZD340	A350	37D	\N
ZD340	A350	37E	\N
ZD340	A350	37G	\N
ZD340	A350	37H	\N
ZD340	A350	37J	\N
ZD340	A350	37K	\N
ZD340	A350	38A	\N
ZD340	A350	38B	\N
ZD340	A350	38C	\N
ZD340	A350	38D	\N
ZD340	A350	38E	\N
ZD340	A350	38G	\N
ZD340	A350	38H	\N
ZD340	A350	38J	\N
ZD340	A350	38K	\N
ZD340	A350	39A	\N
ZD340	A350	39B	\N
ZD340	A350	39C	\N
ZD340	A350	39D	\N
ZD340	A350	39E	\N
ZD340	A350	39G	\N
ZD340	A350	39H	\N
ZD340	A350	39J	\N
ZD340	A350	39K	\N
ZD340	A350	40D	\N
ZD340	A350	40E	\N
ZD340	A350	40G	\N
ZD340	A350	45A	\N
ZD340	A350	45B	\N
ZD340	A350	45C	\N
ZD340	A350	45D	\N
ZD340	A350	45E	\N
ZD340	A350	45G	\N
ZD340	A350	45H	\N
ZD340	A350	45J	\N
ZD340	A350	45K	\N
ZD340	A350	46A	\N
ZD340	A350	46B	\N
ZD340	A350	46C	\N
ZD340	A350	46D	\N
ZD340	A350	46E	\N
ZD340	A350	46G	\N
ZD340	A350	46H	\N
ZD340	A350	46J	\N
ZD340	A350	46K	\N
ZD340	A350	47A	\N
ZD340	A350	47B	\N
ZD340	A350	47C	\N
ZD340	A350	47D	\N
ZD340	A350	47E	\N
ZD340	A350	47G	\N
ZD340	A350	47H	\N
ZD340	A350	47J	\N
ZD340	A350	47K	\N
ZD340	A350	48A	\N
ZD340	A350	48B	\N
ZD340	A350	48C	\N
ZD340	A350	48D	\N
ZD340	A350	48E	\N
ZD340	A350	48G	\N
ZD340	A350	48H	\N
ZD340	A350	48J	\N
ZD340	A350	48K	\N
ZD340	A350	49A	\N
ZD340	A350	49B	\N
ZD340	A350	49C	\N
ZD340	A350	49D	\N
ZD340	A350	49E	\N
ZD340	A350	49G	\N
ZD340	A350	49H	\N
ZD340	A350	49J	\N
ZD340	A350	49K	\N
ZD340	A350	5A	\N
ZD340	A350	5C	\N
ZD340	A350	5H	\N
ZD340	A350	5K	\N
ZD340	A350	50A	\N
ZD340	A350	50B	\N
ZD340	A350	50C	\N
ZD340	A350	50D	\N
ZD340	A350	50E	\N
ZD340	A350	50G	\N
ZD340	A350	50H	\N
ZD340	A350	50J	\N
ZD340	A350	50K	\N
ZD340	A350	51A	\N
ZD340	A350	51B	\N
ZD340	A350	51C	\N
ZD340	A350	51D	\N
ZD340	A350	51E	\N
ZD340	A350	51G	\N
ZD340	A350	51H	\N
ZD340	A350	51J	\N
ZD340	A350	51K	\N
ZD340	A350	52A	\N
ZD340	A350	52B	\N
ZD340	A350	52C	\N
ZD340	A350	52D	\N
ZD340	A350	52E	\N
ZD340	A350	52G	\N
ZD340	A350	52H	\N
ZD340	A350	52J	\N
ZD340	A350	52K	\N
ZD340	A350	53A	\N
ZD340	A350	53B	\N
ZD340	A350	53C	\N
ZD340	A350	53D	\N
ZD340	A350	53E	\N
ZD340	A350	53G	\N
ZD340	A350	53H	\N
ZD340	A350	53J	\N
ZD340	A350	53K	\N
ZD340	A350	54A	\N
ZD340	A350	54B	\N
ZD340	A350	54C	\N
ZD340	A350	54D	\N
ZD340	A350	54E	\N
ZD340	A350	54G	\N
ZD340	A350	54H	\N
ZD340	A350	54J	\N
ZD340	A350	54K	\N
ZD340	A350	55A	\N
ZD340	A350	55B	\N
ZD340	A350	55C	\N
ZD340	A350	55D	\N
ZD340	A350	55E	\N
ZD340	A350	55G	\N
ZD340	A350	55H	\N
ZD340	A350	55J	\N
ZD340	A350	55K	\N
ZD340	A350	56A	\N
ZD340	A350	56B	\N
ZD340	A350	56C	\N
ZD340	A350	56D	\N
ZD340	A350	56E	\N
ZD340	A350	56G	\N
ZD340	A350	56H	\N
ZD340	A350	56J	\N
ZD340	A350	56K	\N
ZD340	A350	57A	\N
ZD340	A350	57B	\N
ZD340	A350	57C	\N
ZD340	A350	57D	\N
ZD340	A350	57E	\N
ZD340	A350	57G	\N
ZD340	A350	57H	\N
ZD340	A350	57J	\N
ZD340	A350	57K	\N
ZD340	A350	58A	\N
ZD340	A350	58B	\N
ZD340	A350	58C	\N
ZD340	A350	58D	\N
ZD340	A350	58E	\N
ZD340	A350	58G	\N
ZD340	A350	58H	\N
ZD340	A350	58J	\N
ZD340	A350	58K	\N
ZD340	A350	59A	\N
ZD340	A350	59B	\N
ZD340	A350	59C	\N
ZD340	A350	59D	\N
ZD340	A350	59E	\N
ZD340	A350	59G	\N
ZD340	A350	59H	\N
ZD340	A350	59J	\N
ZD340	A350	59K	\N
ZD340	A350	6A	\N
ZD340	A350	6C	\N
ZD340	A350	6D	\N
ZD340	A350	6E	\N
ZD340	A350	6F	\N
ZD340	A350	6G	\N
ZD340	A350	6H	\N
ZD340	A350	6K	\N
ZD340	A350	60A	\N
ZD340	A350	60C	\N
ZD340	A350	60D	\N
ZD340	A350	60E	\N
ZD340	A350	60G	\N
ZD340	A350	61D	\N
ZD340	A350	61E	\N
ZD340	A350	61G	\N
ZD340	A350	7A	\N
ZD340	A350	7C	\N
ZD340	A350	7D	\N
ZD340	A350	7E	\N
ZD340	A350	7F	\N
ZD340	A350	7G	\N
ZD340	A350	7H	\N
ZD340	A350	7K	\N
ZD340	A350	8A	\N
ZD340	A350	8C	\N
ZD340	A350	8D	\N
ZD340	A350	8E	\N
ZD340	A350	8F	\N
ZD340	A350	8G	\N
ZD340	A350	8H	\N
ZD340	A350	8K	\N
ZD340	A350	9A	\N
ZD340	A350	9C	\N
ZD340	A350	9D	\N
ZD340	A350	9E	\N
ZD340	A350	9F	\N
ZD340	A350	9G	\N
ZD340	A350	9H	\N
ZD340	A350	9K	\N
BK248	A350	1A	\N
BK248	A350	1C	\N
BK248	A350	1D	\N
BK248	A350	1G	\N
BK248	A350	1H	\N
BK248	A350	1K	\N
BK248	A350	10A	\N
BK248	A350	10C	\N
BK248	A350	10D	\N
BK248	A350	10E	\N
BK248	A350	10F	\N
BK248	A350	10G	\N
BK248	A350	10H	\N
BK248	A350	10K	\N
BK248	A350	11A	\N
BK248	A350	11C	\N
BK248	A350	11D	\N
BK248	A350	11E	\N
BK248	A350	11F	\N
BK248	A350	11G	\N
BK248	A350	11H	\N
BK248	A350	11K	\N
BK248	A350	12D	\N
BK248	A350	12E	\N
BK248	A350	12F	\N
BK248	A350	12G	\N
BK248	A350	15D	\N
BK248	A350	15E	\N
BK248	A350	15F	\N
BK248	A350	15G	\N
BK248	A350	15H	\N
BK248	A350	15K	\N
BK248	A350	16A	\N
BK248	A350	16C	\N
BK248	A350	16D	\N
BK248	A350	16E	\N
BK248	A350	16F	\N
BK248	A350	16G	\N
BK248	A350	16H	\N
BK248	A350	16K	\N
BK248	A350	17A	\N
BK248	A350	17C	\N
BK248	A350	17D	\N
BK248	A350	17E	\N
BK248	A350	17F	\N
BK248	A350	17G	\N
BK248	A350	17H	\N
BK248	A350	17K	\N
BK248	A350	18A	\N
BK248	A350	18C	\N
BK248	A350	18D	\N
BK248	A350	18E	\N
BK248	A350	18F	\N
BK248	A350	18G	\N
BK248	A350	18H	\N
BK248	A350	18K	\N
BK248	A350	19A	\N
BK248	A350	19C	\N
BK248	A350	19D	\N
BK248	A350	19E	\N
BK248	A350	19F	\N
BK248	A350	19G	\N
BK248	A350	19H	\N
BK248	A350	19K	\N
BK248	A350	2A	\N
BK248	A350	2C	\N
BK248	A350	2D	\N
BK248	A350	2G	\N
BK248	A350	2H	\N
BK248	A350	2K	\N
BK248	A350	27A	\N
BK248	A350	27B	\N
BK248	A350	27C	\N
BK248	A350	27D	\N
BK248	A350	27E	\N
BK248	A350	27G	\N
BK248	A350	27H	\N
BK248	A350	27J	\N
BK248	A350	27K	\N
BK248	A350	28A	\N
BK248	A350	28B	\N
BK248	A350	28C	\N
BK248	A350	28D	\N
BK248	A350	28E	\N
BK248	A350	28G	\N
BK248	A350	28H	\N
BK248	A350	28J	\N
BK248	A350	28K	\N
BK248	A350	29A	\N
BK248	A350	29C	\N
BK248	A350	29D	\N
BK248	A350	29E	\N
BK248	A350	29G	\N
BK248	A350	29H	\N
BK248	A350	29J	\N
BK248	A350	29K	\N
BK248	A350	30A	\N
BK248	A350	30B	\N
BK248	A350	30C	\N
BK248	A350	30D	\N
BK248	A350	30E	\N
BK248	A350	30G	\N
BK248	A350	30H	\N
BK248	A350	30J	\N
BK248	A350	30K	\N
BK248	A350	31A	\N
BK248	A350	31B	\N
BK248	A350	31C	\N
BK248	A350	31D	\N
BK248	A350	31E	\N
BK248	A350	31G	\N
BK248	A350	31H	\N
BK248	A350	31J	\N
BK248	A350	31K	\N
BK248	A350	32A	\N
BK248	A350	32B	\N
BK248	A350	32C	\N
BK248	A350	32D	\N
BK248	A350	32E	\N
BK248	A350	32G	\N
BK248	A350	32H	\N
BK248	A350	32J	\N
BK248	A350	32K	\N
BK248	A350	33A	\N
BK248	A350	33B	\N
BK248	A350	33C	\N
BK248	A350	33D	\N
BK248	A350	33E	\N
BK248	A350	33G	\N
BK248	A350	33H	\N
BK248	A350	33J	\N
BK248	A350	33K	\N
BK248	A350	34A	\N
BK248	A350	34B	\N
BK248	A350	34C	\N
BK248	A350	34D	\N
BK248	A350	34E	\N
BK248	A350	34G	\N
BK248	A350	34H	\N
BK248	A350	34J	\N
BK248	A350	34K	\N
BK248	A350	35A	\N
BK248	A350	35B	\N
BK248	A350	35C	\N
BK248	A350	35D	\N
BK248	A350	35E	\N
BK248	A350	35G	\N
BK248	A350	35H	\N
BK248	A350	35J	\N
BK248	A350	35K	\N
BK248	A350	36A	\N
BK248	A350	36B	\N
BK248	A350	36C	\N
BK248	A350	36D	\N
BK248	A350	36E	\N
BK248	A350	36G	\N
BK248	A350	36H	\N
BK248	A350	36J	\N
BK248	A350	36K	\N
BK248	A350	37A	\N
BK248	A350	37B	\N
BK248	A350	37C	\N
BK248	A350	37D	\N
BK248	A350	37E	\N
BK248	A350	37G	\N
BK248	A350	37H	\N
BK248	A350	37J	\N
BK248	A350	37K	\N
BK248	A350	38A	\N
BK248	A350	38B	\N
BK248	A350	38C	\N
BK248	A350	38D	\N
BK248	A350	38E	\N
BK248	A350	38G	\N
BK248	A350	38H	\N
BK248	A350	38J	\N
BK248	A350	38K	\N
BK248	A350	39A	\N
BK248	A350	39B	\N
BK248	A350	39C	\N
BK248	A350	39D	\N
BK248	A350	39E	\N
BK248	A350	39G	\N
BK248	A350	39H	\N
BK248	A350	39J	\N
BK248	A350	39K	\N
BK248	A350	40D	\N
BK248	A350	40E	\N
BK248	A350	40G	\N
BK248	A350	45A	\N
BK248	A350	45B	\N
BK248	A350	45C	\N
BK248	A350	45D	\N
BK248	A350	45E	\N
BK248	A350	45G	\N
BK248	A350	45H	\N
BK248	A350	45J	\N
BK248	A350	45K	\N
BK248	A350	46A	\N
BK248	A350	46B	\N
BK248	A350	46C	\N
BK248	A350	46D	\N
BK248	A350	46E	\N
BK248	A350	46H	\N
BK248	A350	46J	\N
BK248	A350	46K	\N
BK248	A350	47A	\N
BK248	A350	47B	\N
BK248	A350	47C	\N
BK248	A350	47D	\N
BK248	A350	47E	\N
BK248	A350	47G	\N
BK248	A350	47H	\N
BK248	A350	47J	\N
BK248	A350	47K	\N
BK248	A350	48A	\N
BK248	A350	48B	\N
BK248	A350	48C	\N
BK248	A350	48D	\N
BK248	A350	48E	\N
BK248	A350	48G	\N
BK248	A350	48H	\N
BK248	A350	48J	\N
BK248	A350	48K	\N
BK248	A350	49A	\N
BK248	A350	49B	\N
BK248	A350	49C	\N
BK248	A350	49D	\N
BK248	A350	49E	\N
BK248	A350	49G	\N
BK248	A350	49H	\N
BK248	A350	49J	\N
BK248	A350	49K	\N
BK248	A350	5A	\N
BK248	A350	5C	\N
BK248	A350	5H	\N
BK248	A350	5K	\N
BK248	A350	50A	\N
BK248	A350	50B	\N
BK248	A350	50C	\N
BK248	A350	50D	\N
BK248	A350	50E	\N
BK248	A350	50G	\N
BK248	A350	50H	\N
BK248	A350	50J	\N
BK248	A350	50K	\N
BK248	A350	51A	\N
BK248	A350	51B	\N
BK248	A350	51C	\N
BK248	A350	51D	\N
BK248	A350	51E	\N
BK248	A350	51G	\N
BK248	A350	51H	\N
BK248	A350	51J	\N
BK248	A350	51K	\N
BK248	A350	52A	\N
BK248	A350	52B	\N
BK248	A350	52C	\N
BK248	A350	52D	\N
BK248	A350	52E	\N
BK248	A350	52G	\N
BK248	A350	52H	\N
BK248	A350	52J	\N
BK248	A350	52K	\N
BK248	A350	46G	\N
BK248	A350	53A	\N
BK248	A350	53B	\N
BK248	A350	53C	\N
BK248	A350	53D	\N
BK248	A350	53E	\N
BK248	A350	53G	\N
BK248	A350	53H	\N
BK248	A350	53J	\N
BK248	A350	53K	\N
BK248	A350	54A	\N
BK248	A350	54B	\N
BK248	A350	54C	\N
BK248	A350	54D	\N
BK248	A350	54E	\N
BK248	A350	54G	\N
BK248	A350	54H	\N
BK248	A350	54J	\N
BK248	A350	54K	\N
BK248	A350	55A	\N
BK248	A350	55B	\N
BK248	A350	55C	\N
BK248	A350	55D	\N
BK248	A350	55E	\N
BK248	A350	55G	\N
BK248	A350	55H	\N
BK248	A350	55J	\N
BK248	A350	55K	\N
BK248	A350	56A	\N
BK248	A350	56B	\N
BK248	A350	56C	\N
BK248	A350	56D	\N
BK248	A350	56E	\N
BK248	A350	56G	\N
BK248	A350	56H	\N
BK248	A350	56J	\N
BK248	A350	56K	\N
BK248	A350	57A	\N
BK248	A350	57B	\N
BK248	A350	57C	\N
BK248	A350	57D	\N
BK248	A350	57E	\N
BK248	A350	57G	\N
BK248	A350	57H	\N
BK248	A350	57J	\N
BK248	A350	57K	\N
BK248	A350	58A	\N
BK248	A350	58B	\N
BK248	A350	58C	\N
BK248	A350	58D	\N
BK248	A350	58E	\N
BK248	A350	58G	\N
BK248	A350	58H	\N
BK248	A350	58J	\N
BK248	A350	58K	\N
BK248	A350	59A	\N
BK248	A350	59B	\N
BK248	A350	59C	\N
BK248	A350	59D	\N
BK248	A350	59E	\N
BK248	A350	59G	\N
BK248	A350	59H	\N
BK248	A350	59J	\N
BK248	A350	59K	\N
BK248	A350	6A	\N
BK248	A350	6C	\N
BK248	A350	6D	\N
BK248	A350	6E	\N
BK248	A350	6F	\N
BK248	A350	6G	\N
BK248	A350	6H	\N
BK248	A350	6K	\N
BK248	A350	60A	\N
BK248	A350	60C	\N
BK248	A350	60D	\N
BK248	A350	60E	\N
BK248	A350	60G	\N
BK248	A350	61D	\N
BK248	A350	61E	\N
BK248	A350	61G	\N
BK248	A350	7A	\N
BK248	A350	7C	\N
BK248	A350	7D	\N
BK248	A350	7E	\N
BK248	A350	7F	\N
BK248	A350	7G	\N
BK248	A350	7H	\N
BK248	A350	7K	\N
BK248	A350	8A	\N
BK248	A350	8C	\N
BK248	A350	8D	\N
BK248	A350	8E	\N
BK248	A350	8F	\N
BK248	A350	8G	\N
BK248	A350	8H	\N
BK248	A350	8K	\N
BK248	A350	9A	\N
BK248	A350	9C	\N
BK248	A350	9D	\N
BK248	A350	9E	\N
BK248	A350	9F	\N
BK248	A350	9G	\N
BK248	A350	9H	\N
BK248	A350	9K	\N
VJ796	A350	40E	\N
AY611	A350	39K	\N
AY611	A350	40D	\N
AY611	A350	40E	\N
AY611	A350	40G	\N
AY611	A350	45A	\N
AY611	A350	45B	\N
AY611	A350	45C	\N
AY611	A350	45D	\N
AY611	A350	45E	\N
AY611	A350	45G	\N
AY611	A350	45H	\N
AY611	A350	45J	\N
AY611	A350	45K	\N
AY611	A350	46A	\N
AY611	A350	46B	\N
AY611	A350	46C	\N
AY611	A350	46D	\N
AY611	A350	46E	\N
AY611	A350	46G	\N
AY611	A350	46H	\N
AY611	A350	46J	\N
AY611	A350	46K	\N
AY611	A350	47A	\N
AY611	A350	47B	\N
AY611	A350	47C	\N
AY611	A350	47D	\N
AY611	A350	47E	\N
AY611	A350	47G	\N
VJ796	A350	10A	\N
CR158	A350	10C	\N
QU263	A350	27H	\N
ZE355	A380	44H	T812235
XJ392	A350	28C	T910288
BK248	A350	29B	\N
XJ392	A350	28E	T168151
OQ831	A350	28D	T168321
WI105	A350	10A	\N
WI105	A350	10C	\N
WI105	A350	10D	\N
WI105	A350	10E	\N
WI105	A350	10F	\N
WI105	A350	10G	\N
WI105	A350	10H	\N
WI105	A350	10K	\N
WI105	A350	11A	\N
WI105	A350	11C	\N
WI105	A350	11D	\N
WI105	A350	11E	\N
WI105	A350	11F	\N
WI105	A350	11G	\N
WI105	A350	11H	\N
WI105	A350	11K	\N
WI105	A350	12D	\N
WI105	A350	12E	\N
WI105	A350	12F	\N
WI105	A350	12G	\N
WI105	A350	15D	\N
WI105	A350	15E	\N
WI105	A350	15F	\N
WI105	A350	15G	\N
WI105	A350	15H	\N
WI105	A350	15K	\N
WI105	A350	16A	\N
WI105	A350	16C	\N
WI105	A350	16D	\N
WI105	A350	16E	\N
WI105	A350	16F	\N
WI105	A350	16G	\N
WI105	A350	16H	\N
WI105	A350	16K	\N
WI105	A350	17A	\N
WI105	A350	17C	\N
WI105	A350	17D	\N
WI105	A350	17E	\N
WI105	A350	17F	\N
WI105	A350	17G	\N
WI105	A350	17H	\N
WI105	A350	17K	\N
WI105	A350	18A	\N
WI105	A350	18C	\N
WI105	A350	18D	\N
WI105	A350	18E	\N
WI105	A350	18F	\N
WI105	A350	18G	\N
WI105	A350	18H	\N
WI105	A350	18K	\N
WI105	A350	19A	\N
WI105	A350	19C	\N
WI105	A350	19D	\N
WI105	A350	19E	\N
WI105	A350	19F	\N
WI105	A350	19G	\N
WI105	A350	19H	\N
WI105	A350	19K	\N
WI105	A350	1A	\N
WI105	A350	1C	\N
WI105	A350	1D	\N
WI105	A350	1G	\N
WI105	A350	1H	\N
WI105	A350	1K	\N
WI105	A350	27A	\N
WI105	A350	27B	\N
WI105	A350	27C	\N
WI105	A350	27D	\N
WI105	A350	27E	\N
WI105	A350	27G	\N
WI105	A350	27H	\N
WI105	A350	27J	\N
WI105	A350	27K	\N
WI105	A350	28A	\N
WI105	A350	28B	\N
WI105	A350	28C	\N
WI105	A350	28D	\N
WI105	A350	28E	\N
WI105	A350	28G	\N
WI105	A350	28H	\N
WI105	A350	28J	\N
WI105	A350	28K	\N
WI105	A350	29A	\N
WI105	A350	29B	\N
WI105	A350	29C	\N
WI105	A350	29D	\N
WI105	A350	29E	\N
WI105	A350	29G	\N
WI105	A350	29H	\N
WI105	A350	29J	\N
WI105	A350	29K	\N
WI105	A350	2A	\N
WI105	A350	2C	\N
WI105	A350	2D	\N
WI105	A350	2G	\N
WI105	A350	2H	\N
WI105	A350	2K	\N
WI105	A350	30A	\N
WI105	A350	30B	\N
WI105	A350	30C	\N
WI105	A350	30D	\N
WI105	A350	30E	\N
WI105	A350	30G	\N
WI105	A350	30H	\N
WI105	A350	30J	\N
WI105	A350	30K	\N
WI105	A350	31A	\N
WI105	A350	31B	\N
WI105	A350	31C	\N
WI105	A350	31D	\N
WI105	A350	31E	\N
WI105	A350	31G	\N
WI105	A350	31H	\N
WI105	A350	31J	\N
WI105	A350	31K	\N
WI105	A350	32A	\N
WI105	A350	32B	\N
WI105	A350	32C	\N
WI105	A350	32D	\N
WI105	A350	32E	\N
WI105	A350	32G	\N
WI105	A350	32H	\N
WI105	A350	32J	\N
WI105	A350	32K	\N
WI105	A350	33A	\N
WI105	A350	33B	\N
WI105	A350	33C	\N
WI105	A350	33D	\N
WI105	A350	33E	\N
WI105	A350	33G	\N
WI105	A350	33H	\N
WI105	A350	33J	\N
WI105	A350	33K	\N
WI105	A350	34A	\N
WI105	A350	34B	\N
WI105	A350	34C	\N
WI105	A350	34D	\N
WI105	A350	34E	\N
WI105	A350	34G	\N
WI105	A350	34H	\N
WI105	A350	34J	\N
WI105	A350	34K	\N
WI105	A350	35A	\N
WI105	A350	35B	\N
WI105	A350	35C	\N
WI105	A350	35D	\N
WI105	A350	35E	\N
WI105	A350	35G	\N
WI105	A350	35H	\N
WI105	A350	35J	\N
WI105	A350	35K	\N
WI105	A350	36A	\N
WI105	A350	36B	\N
WI105	A350	36C	\N
WI105	A350	36D	\N
WI105	A350	36E	\N
WI105	A350	36G	\N
WI105	A350	36H	\N
WI105	A350	36J	\N
WI105	A350	36K	\N
WI105	A350	37A	\N
WI105	A350	37B	\N
WI105	A350	37C	\N
WI105	A350	37D	\N
WI105	A350	37E	\N
WI105	A350	37G	\N
WI105	A350	37H	\N
WI105	A350	37J	\N
WI105	A350	37K	\N
WI105	A350	38A	\N
WI105	A350	38B	\N
WI105	A350	38C	\N
WI105	A350	38D	\N
WI105	A350	38E	\N
WI105	A350	38G	\N
WI105	A350	38H	\N
WI105	A350	38J	\N
WI105	A350	38K	\N
WI105	A350	39A	\N
WI105	A350	39B	\N
WI105	A350	39C	\N
WI105	A350	39D	\N
WI105	A350	39E	\N
WI105	A350	39G	\N
WI105	A350	39H	\N
WI105	A350	39J	\N
WI105	A350	39K	\N
WI105	A350	40D	\N
WI105	A350	40E	\N
WI105	A350	40G	\N
WI105	A350	45A	\N
WI105	A350	45B	\N
WI105	A350	45C	\N
WI105	A350	45D	\N
WI105	A350	45E	\N
WI105	A350	45G	\N
WI105	A350	45H	\N
WI105	A350	45J	\N
WI105	A350	45K	\N
WI105	A350	46A	\N
WI105	A350	46B	\N
WI105	A350	46C	\N
WI105	A350	46D	\N
WI105	A350	46E	\N
WI105	A350	46G	\N
WI105	A350	46H	\N
WI105	A350	46J	\N
WI105	A350	46K	\N
WI105	A350	47A	\N
WI105	A350	47B	\N
WI105	A350	47C	\N
WI105	A350	47D	\N
WI105	A350	47E	\N
WI105	A350	47G	\N
WI105	A350	47H	\N
WI105	A350	47J	\N
WI105	A350	47K	\N
WI105	A350	48A	\N
WI105	A350	48B	\N
WI105	A350	48C	\N
WI105	A350	48D	\N
WI105	A350	48E	\N
WI105	A350	48G	\N
WI105	A350	48H	\N
WI105	A350	48J	\N
WI105	A350	48K	\N
WI105	A350	49A	\N
WI105	A350	49B	\N
WI105	A350	49C	\N
WI105	A350	49D	\N
WI105	A350	49E	\N
WI105	A350	49G	\N
WI105	A350	49H	\N
WI105	A350	49J	\N
WI105	A350	49K	\N
WI105	A350	50A	\N
WI105	A350	50B	\N
WI105	A350	50C	\N
WI105	A350	50D	\N
WI105	A350	50E	\N
WI105	A350	50G	\N
WI105	A350	50H	\N
WI105	A350	50J	\N
WI105	A350	50K	\N
WI105	A350	51A	\N
WI105	A350	51B	\N
WI105	A350	51C	\N
WI105	A350	51D	\N
WI105	A350	51E	\N
WI105	A350	51G	\N
WI105	A350	51H	\N
WI105	A350	51J	\N
WI105	A350	51K	\N
WI105	A350	52A	\N
WI105	A350	52B	\N
WI105	A350	52C	\N
WI105	A350	52D	\N
WI105	A350	52E	\N
WI105	A350	52G	\N
WI105	A350	52H	\N
WI105	A350	52J	\N
WI105	A350	52K	\N
WI105	A350	53A	\N
WI105	A350	53B	\N
WI105	A350	53C	\N
WI105	A350	53D	\N
WI105	A350	53E	\N
WI105	A350	53G	\N
WI105	A350	53H	\N
WI105	A350	53J	\N
WI105	A350	53K	\N
WI105	A350	54A	\N
WI105	A350	54B	\N
WI105	A350	54C	\N
WI105	A350	54D	\N
WI105	A350	54E	\N
WI105	A350	54G	\N
WI105	A350	54H	\N
WI105	A350	54J	\N
WI105	A350	54K	\N
WI105	A350	55A	\N
WI105	A350	55B	\N
WI105	A350	55C	\N
WI105	A350	55D	\N
WI105	A350	55E	\N
WI105	A350	55G	\N
WI105	A350	55H	\N
WI105	A350	55J	\N
WI105	A350	55K	\N
WI105	A350	56A	\N
WI105	A350	56B	\N
WI105	A350	56C	\N
WI105	A350	56D	\N
WI105	A350	56E	\N
WI105	A350	56G	\N
WI105	A350	56H	\N
WI105	A350	56J	\N
WI105	A350	56K	\N
WI105	A350	57A	\N
WI105	A350	57B	\N
WI105	A350	57C	\N
WI105	A350	57D	\N
WI105	A350	57E	\N
WI105	A350	57G	\N
WI105	A350	57H	\N
WI105	A350	57J	\N
WI105	A350	57K	\N
WI105	A350	58A	\N
WI105	A350	58B	\N
WI105	A350	58C	\N
WI105	A350	58D	\N
WI105	A350	58E	\N
WI105	A350	58G	\N
WI105	A350	58H	\N
WI105	A350	58J	\N
WI105	A350	58K	\N
WI105	A350	59A	\N
WI105	A350	59B	\N
WI105	A350	59C	\N
WI105	A350	59D	\N
WI105	A350	59E	\N
WI105	A350	59G	\N
WI105	A350	59H	\N
WI105	A350	59J	\N
WI105	A350	59K	\N
WI105	A350	5A	\N
WI105	A350	5C	\N
WI105	A350	5H	\N
WI105	A350	5K	\N
WI105	A350	60A	\N
WI105	A350	60C	\N
WI105	A350	60D	\N
WI105	A350	60E	\N
WI105	A350	60G	\N
WI105	A350	61D	\N
WI105	A350	61E	\N
WI105	A350	61G	\N
WI105	A350	6A	\N
WI105	A350	6C	\N
WI105	A350	6D	\N
WI105	A350	6E	\N
WI105	A350	6F	\N
WI105	A350	6G	\N
WI105	A350	6H	\N
WI105	A350	6K	\N
WI105	A350	7A	\N
WI105	A350	7C	\N
WI105	A350	7D	\N
WI105	A350	7E	\N
WI105	A350	7F	\N
WI105	A350	7G	\N
WI105	A350	7H	\N
WI105	A350	7K	\N
WI105	A350	8A	\N
WI105	A350	8C	\N
WI105	A350	8D	\N
WI105	A350	8E	\N
WI105	A350	8F	\N
WI105	A350	8G	\N
WI105	A350	8H	\N
WI105	A350	8K	\N
WI105	A350	9A	\N
WI105	A350	9C	\N
WI105	A350	9D	\N
WI105	A350	9E	\N
WI105	A350	9F	\N
WI105	A350	9G	\N
WI105	A350	9H	\N
WI105	A350	9K	\N
VB710	A350	10A	\N
VB710	A350	10C	\N
VB710	A350	10D	\N
VB710	A350	10E	\N
VB710	A350	10F	\N
VB710	A350	10G	\N
VB710	A350	10H	\N
VB710	A350	10K	\N
VB710	A350	11A	\N
VB710	A350	11C	\N
VB710	A350	11D	\N
VB710	A350	11E	\N
VB710	A350	11F	\N
VB710	A350	11G	\N
VB710	A350	11H	\N
VB710	A350	11K	\N
VB710	A350	12D	\N
VB710	A350	12E	\N
VB710	A350	12F	\N
VB710	A350	12G	\N
VB710	A350	15D	\N
VB710	A350	15E	\N
VB710	A350	15F	\N
VB710	A350	15G	\N
VB710	A350	15H	\N
VB710	A350	15K	\N
VB710	A350	16A	\N
VB710	A350	16C	\N
VB710	A350	16D	\N
VB710	A350	16E	\N
VB710	A350	16F	\N
VB710	A350	16G	\N
VB710	A350	16H	\N
VB710	A350	16K	\N
VB710	A350	17A	\N
VB710	A350	17C	\N
VB710	A350	17D	\N
VB710	A350	17E	\N
VB710	A350	17F	\N
VB710	A350	17G	\N
VB710	A350	17H	\N
VB710	A350	17K	\N
VB710	A350	18A	\N
VB710	A350	18C	\N
VB710	A350	18D	\N
VB710	A350	18E	\N
VB710	A350	18F	\N
VB710	A350	18G	\N
VB710	A350	18H	\N
VB710	A350	18K	\N
VB710	A350	19A	\N
VB710	A350	19C	\N
VB710	A350	19D	\N
VB710	A350	19E	\N
VB710	A350	19F	\N
VB710	A350	19G	\N
VB710	A350	19H	\N
VB710	A350	19K	\N
VB710	A350	1A	\N
VB710	A350	1C	\N
VB710	A350	1D	\N
VB710	A350	1G	\N
VB710	A350	1H	\N
VB710	A350	1K	\N
VB710	A350	27A	\N
VB710	A350	27B	\N
VB710	A350	27C	\N
VB710	A350	27D	\N
VB710	A350	27E	\N
VB710	A350	27G	\N
VB710	A350	27H	\N
VB710	A350	27J	\N
VB710	A350	27K	\N
VB710	A350	28A	\N
VB710	A350	28B	\N
VB710	A350	28C	\N
VB710	A350	28D	\N
VB710	A350	28E	\N
VB710	A350	28G	\N
VB710	A350	28H	\N
VB710	A350	28J	\N
VB710	A350	28K	\N
VB710	A350	29A	\N
VB710	A350	29B	\N
VB710	A350	29C	\N
VB710	A350	29D	\N
VB710	A350	29E	\N
VB710	A350	29G	\N
VB710	A350	29H	\N
VB710	A350	29J	\N
VB710	A350	29K	\N
VB710	A350	2A	\N
VB710	A350	2C	\N
VB710	A350	2D	\N
VB710	A350	2G	\N
VB710	A350	2H	\N
VB710	A350	2K	\N
VB710	A350	30A	\N
VB710	A350	30B	\N
VB710	A350	30C	\N
VB710	A350	30D	\N
VB710	A350	30E	\N
VB710	A350	30G	\N
VB710	A350	30H	\N
VB710	A350	30J	\N
VB710	A350	30K	\N
VB710	A350	31A	\N
VB710	A350	31B	\N
VB710	A350	31C	\N
VB710	A350	31D	\N
VB710	A350	31E	\N
VB710	A350	31G	\N
VB710	A350	31H	\N
VB710	A350	31J	\N
VB710	A350	31K	\N
VB710	A350	32A	\N
VB710	A350	32B	\N
VB710	A350	32C	\N
VB710	A350	32D	\N
VB710	A350	32E	\N
VB710	A350	32G	\N
VB710	A350	32H	\N
VB710	A350	32J	\N
VB710	A350	32K	\N
VB710	A350	33A	\N
VB710	A350	33B	\N
VB710	A350	33C	\N
VB710	A350	33D	\N
VB710	A350	33E	\N
VB710	A350	33G	\N
VB710	A350	33H	\N
VB710	A350	33J	\N
VB710	A350	33K	\N
VB710	A350	34A	\N
VB710	A350	34B	\N
VB710	A350	34C	\N
VB710	A350	34D	\N
VB710	A350	34E	\N
VB710	A350	34G	\N
VB710	A350	34H	\N
VB710	A350	34J	\N
VB710	A350	34K	\N
VB710	A350	35A	\N
VB710	A350	35B	\N
VB710	A350	35C	\N
VB710	A350	35D	\N
VB710	A350	35E	\N
VB710	A350	35G	\N
VB710	A350	35H	\N
VB710	A350	35J	\N
VB710	A350	35K	\N
VB710	A350	36A	\N
VB710	A350	36B	\N
VB710	A350	36C	\N
VB710	A350	36D	\N
VB710	A350	36E	\N
VB710	A350	36G	\N
VB710	A350	36H	\N
VB710	A350	36J	\N
VB710	A350	36K	\N
VB710	A350	37A	\N
VB710	A350	37B	\N
VB710	A350	37C	\N
VB710	A350	37D	\N
VB710	A350	37E	\N
VB710	A350	37G	\N
VB710	A350	37H	\N
VB710	A350	37J	\N
VB710	A350	37K	\N
VB710	A350	38A	\N
VB710	A350	38B	\N
VB710	A350	38C	\N
VB710	A350	38D	\N
VB710	A350	38E	\N
VB710	A350	38G	\N
VB710	A350	38H	\N
VB710	A350	38J	\N
VB710	A350	38K	\N
VB710	A350	39A	\N
VB710	A350	39B	\N
VB710	A350	39C	\N
VB710	A350	39D	\N
VB710	A350	39E	\N
VB710	A350	39G	\N
VB710	A350	39H	\N
VB710	A350	39J	\N
VB710	A350	39K	\N
VB710	A350	40D	\N
VB710	A350	40E	\N
VB710	A350	40G	\N
VB710	A350	45A	\N
VB710	A350	45B	\N
VB710	A350	45C	\N
VB710	A350	45D	\N
VB710	A350	45E	\N
VB710	A350	45G	\N
VB710	A350	45H	\N
VB710	A350	45J	\N
VB710	A350	45K	\N
VB710	A350	46A	\N
VB710	A350	46B	\N
VB710	A350	46C	\N
VB710	A350	46D	\N
VB710	A350	46E	\N
VB710	A350	46G	\N
VB710	A350	46H	\N
VB710	A350	46J	\N
VB710	A350	46K	\N
VB710	A350	47A	\N
VB710	A350	47B	\N
VB710	A350	47C	\N
VB710	A350	47D	\N
VB710	A350	47E	\N
VB710	A350	47G	\N
VB710	A350	47H	\N
VB710	A350	47J	\N
VB710	A350	47K	\N
VB710	A350	48A	\N
VB710	A350	48B	\N
VB710	A350	48C	\N
VB710	A350	48D	\N
VB710	A350	48E	\N
VB710	A350	48G	\N
VB710	A350	48H	\N
VB710	A350	48J	\N
VB710	A350	48K	\N
VB710	A350	49A	\N
VB710	A350	49B	\N
VB710	A350	49C	\N
VB710	A350	49D	\N
VB710	A350	49E	\N
VB710	A350	49G	\N
VB710	A350	49H	\N
VB710	A350	49J	\N
VB710	A350	49K	\N
VB710	A350	50A	\N
VB710	A350	50B	\N
VB710	A350	50C	\N
VB710	A350	50D	\N
VB710	A350	50E	\N
VB710	A350	50G	\N
VB710	A350	50H	\N
VB710	A350	50J	\N
VB710	A350	50K	\N
VB710	A350	51A	\N
VB710	A350	51B	\N
VB710	A350	51C	\N
VB710	A350	51D	\N
VB710	A350	51E	\N
VB710	A350	51G	\N
VB710	A350	51H	\N
VB710	A350	51J	\N
VB710	A350	51K	\N
VB710	A350	52A	\N
VB710	A350	52B	\N
VB710	A350	52C	\N
VB710	A350	52D	\N
VB710	A350	52E	\N
VB710	A350	52G	\N
VB710	A350	52H	\N
VB710	A350	52J	\N
VB710	A350	52K	\N
VB710	A350	53A	\N
VB710	A350	53B	\N
VB710	A350	53C	\N
VB710	A350	53D	\N
VB710	A350	53E	\N
VB710	A350	53G	\N
VB710	A350	53H	\N
VB710	A350	53J	\N
VB710	A350	53K	\N
VB710	A350	54A	\N
VB710	A350	54B	\N
VB710	A350	54C	\N
VB710	A350	54D	\N
VB710	A350	54E	\N
VB710	A350	54G	\N
VB710	A350	54H	\N
VB710	A350	54J	\N
VB710	A350	54K	\N
VB710	A350	55A	\N
VB710	A350	55B	\N
VB710	A350	55C	\N
VB710	A350	55D	\N
VB710	A350	55E	\N
VB710	A350	55G	\N
VB710	A350	55H	\N
VB710	A350	55J	\N
VB710	A350	55K	\N
VB710	A350	56A	\N
VB710	A350	56B	\N
VB710	A350	56C	\N
VB710	A350	56D	\N
VB710	A350	56E	\N
VB710	A350	56G	\N
VB710	A350	56H	\N
VB710	A350	56J	\N
VB710	A350	56K	\N
VB710	A350	57A	\N
VB710	A350	57B	\N
VB710	A350	57C	\N
VB710	A350	57D	\N
VB710	A350	57E	\N
VB710	A350	57G	\N
VB710	A350	57H	\N
VB710	A350	57J	\N
VB710	A350	57K	\N
VB710	A350	58A	\N
VB710	A350	58B	\N
VB710	A350	58C	\N
VB710	A350	58D	\N
VB710	A350	58E	\N
VB710	A350	58G	\N
VB710	A350	58H	\N
VB710	A350	58J	\N
VB710	A350	58K	\N
VB710	A350	59A	\N
VB710	A350	59B	\N
VB710	A350	59C	\N
VB710	A350	59D	\N
VB710	A350	59E	\N
VB710	A350	59G	\N
VB710	A350	59H	\N
VB710	A350	59J	\N
VB710	A350	59K	\N
VB710	A350	5A	\N
VB710	A350	5C	\N
VB710	A350	5H	\N
VB710	A350	5K	\N
VB710	A350	60A	\N
VB710	A350	60C	\N
VB710	A350	60D	\N
VB710	A350	60E	\N
VB710	A350	60G	\N
VB710	A350	61D	\N
VB710	A350	61E	\N
VB710	A350	61G	\N
VB710	A350	6A	\N
VB710	A350	6C	\N
VB710	A350	6D	\N
VB710	A350	6E	\N
VB710	A350	6F	\N
VB710	A350	6G	\N
VB710	A350	6H	\N
VB710	A350	6K	\N
VB710	A350	7A	\N
VB710	A350	7C	\N
VB710	A350	7D	\N
VB710	A350	7E	\N
VB710	A350	7F	\N
VB710	A350	7G	\N
VB710	A350	7H	\N
VB710	A350	7K	\N
VB710	A350	8A	\N
VB710	A350	8C	\N
VB710	A350	8D	\N
VB710	A350	8E	\N
VB710	A350	8F	\N
VB710	A350	8G	\N
VB710	A350	8H	\N
VB710	A350	8K	\N
VB710	A350	9A	\N
VB710	A350	9C	\N
VB710	A350	9D	\N
VB710	A350	9E	\N
VB710	A350	9F	\N
VB710	A350	9G	\N
VB710	A350	9H	\N
VB710	A350	9K	\N
BQ968	A380	1A	\N
BQ968	A380	1E	\N
BQ968	A380	1F	\N
BQ968	A380	1K	\N
BQ968	A380	10B	\N
BQ968	A380	10D	\N
BQ968	A380	10G	\N
BQ968	A380	10J	\N
BQ968	A380	11A	\N
BQ968	A380	11E	\N
BQ968	A380	11F	\N
BQ968	A380	11K	\N
BQ968	A380	12B	\N
BQ968	A380	12D	\N
BQ968	A380	12G	\N
BQ968	A380	12J	\N
BQ968	A380	14A	\N
BQ968	A380	14E	\N
BQ968	A380	14F	\N
BQ968	A380	14K	\N
BQ968	A380	15B	\N
BQ968	A380	15D	\N
BQ968	A380	15G	\N
BQ968	A380	15J	\N
BQ968	A380	16A	\N
BQ968	A380	16E	\N
BQ968	A380	16F	\N
BQ968	A380	16K	\N
BQ968	A380	17B	\N
BQ968	A380	17D	\N
BQ968	A380	17G	\N
BQ968	A380	17J	\N
BQ968	A380	18A	\N
BQ968	A380	18E	\N
BQ968	A380	18F	\N
BQ968	A380	18K	\N
BQ968	A380	19B	\N
BQ968	A380	19D	\N
BQ968	A380	19G	\N
BQ968	A380	19J	\N
BQ968	A380	2A	\N
BQ968	A380	2E	\N
BQ968	A380	2F	\N
BQ968	A380	2K	\N
BQ968	A380	20A	\N
BQ968	A380	20E	\N
BQ968	A380	20F	\N
BQ968	A380	20K	\N
BQ968	A380	21B	\N
BQ968	A380	21D	\N
BQ968	A380	21G	\N
BQ968	A380	21J	\N
BQ968	A380	22D	\N
BQ968	A380	22G	\N
BQ968	A380	23A	\N
BQ968	A380	23E	\N
BQ968	A380	23F	\N
BQ968	A380	23K	\N
BQ968	A380	24B	\N
BQ968	A380	24D	\N
BQ968	A380	24G	\N
BQ968	A380	24J	\N
BQ968	A380	25A	\N
BQ968	A380	25E	\N
BQ968	A380	25F	\N
BQ968	A380	25K	\N
BQ968	A380	26B	\N
BQ968	A380	26D	\N
BQ968	A380	26G	\N
BQ968	A380	26J	\N
BQ968	A380	3A	\N
BQ968	A380	3E	\N
BQ968	A380	3F	\N
BQ968	A380	3K	\N
BQ968	A380	4A	\N
BQ968	A380	4K	\N
BQ968	A380	43A	\N
BQ968	A380	43B	\N
BQ968	A380	43C	\N
BQ968	A380	43H	\N
BQ968	A380	43J	\N
BQ968	A380	43K	\N
BQ968	A380	44A	\N
BQ968	A380	44B	\N
BQ968	A380	44C	\N
BQ968	A380	44H	\N
BQ968	A380	44J	\N
BQ968	A380	44K	\N
BQ968	A380	45A	\N
BQ968	A380	45B	\N
BQ968	A380	45C	\N
BQ968	A380	45D	\N
BQ968	A380	45E	\N
BQ968	A380	45F	\N
BQ968	A380	45G	\N
BQ968	A380	45H	\N
BQ968	A380	45J	\N
BQ968	A380	45K	\N
BQ968	A380	46A	\N
BQ968	A380	46B	\N
BQ968	A380	46C	\N
BQ968	A380	46D	\N
BQ968	A380	46E	\N
BQ968	A380	46F	\N
BQ968	A380	46G	\N
BQ968	A380	46H	\N
BQ968	A380	46J	\N
BQ968	A380	46K	\N
BQ968	A380	47A	\N
BQ968	A380	47B	\N
BQ968	A380	47C	\N
BQ968	A380	47D	\N
BQ968	A380	47E	\N
BQ968	A380	47F	\N
BQ968	A380	47G	\N
BQ968	A380	47H	\N
BQ968	A380	47J	\N
BQ968	A380	47K	\N
BQ968	A380	48A	\N
BQ968	A380	48B	\N
BQ968	A380	48C	\N
BQ968	A380	48D	\N
BQ968	A380	48E	\N
BQ968	A380	48F	\N
BQ968	A380	48G	\N
BQ968	A380	48H	\N
BQ968	A380	48J	\N
BQ968	A380	48K	\N
BQ968	A380	49A	\N
BQ968	A380	49B	\N
BQ968	A380	49C	\N
BQ968	A380	49D	\N
BQ968	A380	49E	\N
BQ968	A380	49F	\N
BQ968	A380	49G	\N
BQ968	A380	49H	\N
BQ968	A380	49J	\N
BQ968	A380	49K	\N
BQ968	A380	50A	\N
BQ968	A380	50B	\N
BQ968	A380	50C	\N
BQ968	A380	50D	\N
BQ968	A380	50E	\N
BQ968	A380	50F	\N
BQ968	A380	50G	\N
BQ968	A380	50H	\N
BQ968	A380	50J	\N
BQ968	A380	50K	\N
BQ968	A380	51D	\N
BQ968	A380	51E	\N
BQ968	A380	51F	\N
BQ968	A380	51G	\N
BQ968	A380	52A	\N
BQ968	A380	52B	\N
BQ968	A380	52C	\N
BQ968	A380	52H	\N
BQ968	A380	52J	\N
BQ968	A380	52K	\N
BQ968	A380	53A	\N
BQ968	A380	53B	\N
BQ968	A380	53C	\N
BQ968	A380	53H	\N
BQ968	A380	53J	\N
BQ968	A380	53K	\N
BQ968	A380	54A	\N
BQ968	A380	54B	\N
BQ968	A380	54C	\N
BQ968	A380	54D	\N
BQ968	A380	54E	\N
BQ968	A380	54F	\N
BQ968	A380	54G	\N
BQ968	A380	54H	\N
BQ968	A380	54J	\N
BQ968	A380	54K	\N
BQ968	A380	55A	\N
BQ968	A380	55B	\N
BQ968	A380	55C	\N
BQ968	A380	55D	\N
BQ968	A380	55E	\N
BQ968	A380	55F	\N
BQ968	A380	55G	\N
BQ968	A380	55H	\N
BQ968	A380	55J	\N
BQ968	A380	55K	\N
BQ968	A380	56A	\N
BQ968	A380	56B	\N
BQ968	A380	56C	\N
BQ968	A380	56D	\N
BQ968	A380	56E	\N
BQ968	A380	56F	\N
BQ968	A380	56G	\N
BQ968	A380	56H	\N
BQ968	A380	56J	\N
BQ968	A380	56K	\N
BQ968	A380	57A	\N
BQ968	A380	57B	\N
BQ968	A380	57C	\N
BQ968	A380	57D	\N
BQ968	A380	57E	\N
BQ968	A380	57F	\N
BQ968	A380	57G	\N
BQ968	A380	57H	\N
BQ968	A380	57J	\N
BQ968	A380	57K	\N
BQ968	A380	58A	\N
BQ968	A380	58B	\N
BQ968	A380	58C	\N
BQ968	A380	58D	\N
BQ968	A380	58E	\N
BQ968	A380	58F	\N
BQ968	A380	58G	\N
BQ968	A380	58H	\N
BQ968	A380	58J	\N
BQ968	A380	58K	\N
BQ968	A380	59A	\N
BQ968	A380	59B	\N
BQ968	A380	59C	\N
BQ968	A380	59D	\N
BQ968	A380	59E	\N
BQ968	A380	59F	\N
BQ968	A380	59G	\N
BQ968	A380	59H	\N
BQ968	A380	59J	\N
BQ968	A380	59K	\N
BQ968	A380	6D	\N
BQ968	A380	6G	\N
BQ968	A380	60A	\N
BQ968	A380	60B	\N
BQ968	A380	60C	\N
BQ968	A380	60D	\N
BQ968	A380	60E	\N
BQ968	A380	60F	\N
BQ968	A380	60G	\N
BQ968	A380	60H	\N
BQ968	A380	60J	\N
BQ968	A380	60K	\N
BQ968	A380	61A	\N
BQ968	A380	61B	\N
BQ968	A380	61C	\N
BQ968	A380	61D	\N
BQ968	A380	61E	\N
BQ968	A380	61F	\N
BQ968	A380	61G	\N
BQ968	A380	61H	\N
BQ968	A380	61J	\N
BQ968	A380	61K	\N
BQ968	A380	62A	\N
BQ968	A380	62B	\N
BQ968	A380	62C	\N
BQ968	A380	62D	\N
BQ968	A380	62E	\N
BQ968	A380	62F	\N
BQ968	A380	62G	\N
BQ968	A380	62H	\N
BQ968	A380	62J	\N
BQ968	A380	62K	\N
BQ968	A380	63A	\N
BQ968	A380	63B	\N
BQ968	A380	63C	\N
BQ968	A380	63D	\N
BQ968	A380	63E	\N
BQ968	A380	63F	\N
BQ968	A380	63G	\N
BQ968	A380	63H	\N
BQ968	A380	63J	\N
BQ968	A380	63K	\N
BQ968	A380	64A	\N
BQ968	A380	64B	\N
BQ968	A380	64C	\N
BQ968	A380	64D	\N
BQ968	A380	64E	\N
BQ968	A380	64F	\N
BQ968	A380	64G	\N
BQ968	A380	64H	\N
BQ968	A380	64J	\N
BQ968	A380	64K	\N
BQ968	A380	65A	\N
BQ968	A380	65B	\N
BQ968	A380	65C	\N
BQ968	A380	65D	\N
BQ968	A380	65E	\N
BQ968	A380	65F	\N
BQ968	A380	65G	\N
BQ968	A380	65H	\N
BQ968	A380	65J	\N
BQ968	A380	65K	\N
BQ968	A380	66H	\N
BQ968	A380	66J	\N
BQ968	A380	66K	\N
BQ968	A380	67B	\N
BQ968	A380	67C	\N
BQ968	A380	67D	\N
BQ968	A380	67E	\N
BQ968	A380	67F	\N
BQ968	A380	67G	\N
BQ968	A380	67H	\N
BQ968	A380	67J	\N
BQ968	A380	68A	\N
BQ968	A380	68B	\N
BQ968	A380	68C	\N
BQ968	A380	68D	\N
BQ968	A380	68E	\N
BQ968	A380	68F	\N
BQ968	A380	68G	\N
BQ968	A380	68H	\N
BQ968	A380	68J	\N
BQ968	A380	68K	\N
BQ968	A380	69A	\N
BQ968	A380	69B	\N
BQ968	A380	69C	\N
BQ968	A380	69D	\N
BQ968	A380	69E	\N
BQ968	A380	69F	\N
BQ968	A380	69G	\N
BQ968	A380	69H	\N
BQ968	A380	69J	\N
BQ968	A380	69K	\N
BQ968	A380	7A	\N
BQ968	A380	7E	\N
BQ968	A380	7F	\N
BQ968	A380	7K	\N
BQ968	A380	70A	\N
BQ968	A380	70B	\N
BQ968	A380	70C	\N
BQ968	A380	70D	\N
BQ968	A380	70E	\N
BQ968	A380	70F	\N
BQ968	A380	70G	\N
BQ968	A380	70H	\N
BQ968	A380	70J	\N
BQ968	A380	70K	\N
BQ968	A380	71A	\N
BQ968	A380	71B	\N
BQ968	A380	71C	\N
BQ968	A380	71D	\N
BQ968	A380	71E	\N
BQ968	A380	71F	\N
BQ968	A380	71G	\N
BQ968	A380	71H	\N
BQ968	A380	71J	\N
BQ968	A380	71K	\N
BQ968	A380	72A	\N
BQ968	A380	72B	\N
BQ968	A380	72C	\N
BQ968	A380	72D	\N
BQ968	A380	72E	\N
BQ968	A380	72F	\N
BQ968	A380	72G	\N
BQ968	A380	72H	\N
BQ968	A380	72J	\N
BQ968	A380	72K	\N
BQ968	A380	73A	\N
BQ968	A380	73B	\N
BQ968	A380	73C	\N
BQ968	A380	73D	\N
BQ968	A380	73E	\N
BQ968	A380	73F	\N
BQ968	A380	73G	\N
BQ968	A380	73H	\N
BQ968	A380	73J	\N
BQ968	A380	73K	\N
BQ968	A380	74A	\N
BQ968	A380	74B	\N
BQ968	A380	74C	\N
BQ968	A380	74D	\N
BQ968	A380	74E	\N
BQ968	A380	74F	\N
BQ968	A380	74G	\N
BQ968	A380	74H	\N
BQ968	A380	74J	\N
BQ968	A380	74K	\N
BQ968	A380	75A	\N
BQ968	A380	75B	\N
BQ968	A380	75C	\N
BQ968	A380	75D	\N
BQ968	A380	75E	\N
BQ968	A380	75F	\N
BQ968	A380	75G	\N
BQ968	A380	75H	\N
BQ968	A380	75J	\N
BQ968	A380	75K	\N
BQ968	A380	76A	\N
BQ968	A380	76B	\N
BQ968	A380	76C	\N
BQ968	A380	76D	\N
BQ968	A380	76E	\N
BQ968	A380	76F	\N
BQ968	A380	76G	\N
BQ968	A380	76H	\N
BQ968	A380	76J	\N
BQ968	A380	76K	\N
BQ968	A380	77A	\N
BQ968	A380	77B	\N
BQ968	A380	77C	\N
BQ968	A380	77D	\N
BQ968	A380	77E	\N
BQ968	A380	77F	\N
BQ968	A380	77G	\N
BQ968	A380	77H	\N
BQ968	A380	77J	\N
BQ968	A380	77K	\N
BQ968	A380	78A	\N
BQ968	A380	78B	\N
BQ968	A380	78C	\N
BQ968	A380	78D	\N
BQ968	A380	78E	\N
BQ968	A380	78F	\N
BQ968	A380	78G	\N
BQ968	A380	78H	\N
BQ968	A380	78J	\N
BQ968	A380	78K	\N
BQ968	A380	79A	\N
BQ968	A380	79B	\N
BQ968	A380	79C	\N
BQ968	A380	79H	\N
BQ968	A380	79J	\N
BQ968	A380	79K	\N
BQ968	A380	8B	\N
BQ968	A380	8D	\N
BQ968	A380	8G	\N
BQ968	A380	8J	\N
BQ968	A380	80B	\N
BQ968	A380	80C	\N
BQ968	A380	80H	\N
BQ968	A380	80J	\N
BQ968	A380	81A	\N
BQ968	A380	81B	\N
BQ968	A380	81C	\N
BQ968	A380	81H	\N
BQ968	A380	81J	\N
BQ968	A380	81K	\N
BQ968	A380	82A	\N
BQ968	A380	82B	\N
BQ968	A380	82C	\N
BQ968	A380	82D	\N
BQ968	A380	82E	\N
BQ968	A380	82F	\N
BQ968	A380	82G	\N
BQ968	A380	82H	\N
BQ968	A380	82J	\N
BQ968	A380	82K	\N
BQ968	A380	83A	\N
BQ968	A380	83B	\N
BQ968	A380	83C	\N
BQ968	A380	83D	\N
BQ968	A380	83E	\N
BQ968	A380	83F	\N
BQ968	A380	83G	\N
BQ968	A380	83H	\N
BQ968	A380	83J	\N
BQ968	A380	83K	\N
BQ968	A380	84A	\N
BQ968	A380	84B	\N
BQ968	A380	84C	\N
BQ968	A380	84D	\N
BQ968	A380	84E	\N
BQ968	A380	84F	\N
BQ968	A380	84G	\N
BQ968	A380	84H	\N
BQ968	A380	84J	\N
BQ968	A380	84K	\N
BQ968	A380	85A	\N
BQ968	A380	85B	\N
BQ968	A380	85C	\N
BQ968	A380	85H	\N
BQ968	A380	85J	\N
BQ968	A380	85K	\N
BQ968	A380	86A	\N
BQ968	A380	86B	\N
BQ968	A380	86C	\N
BQ968	A380	86H	\N
BQ968	A380	86J	\N
BQ968	A380	86K	\N
BQ968	A380	87A	\N
BQ968	A380	87B	\N
BQ968	A380	87C	\N
BQ968	A380	87H	\N
BQ968	A380	87J	\N
BQ968	A380	87K	\N
BQ968	A380	88A	\N
BQ968	A380	88B	\N
BQ968	A380	88C	\N
BQ968	A380	88H	\N
BQ968	A380	88J	\N
BQ968	A380	88K	\N
BQ968	A380	9A	\N
BQ968	A380	9E	\N
BQ968	A380	9F	\N
BQ968	A380	9K	\N
OW423	A350	10A	\N
OW423	A350	10C	\N
OW423	A350	10D	\N
OW423	A350	10E	\N
OW423	A350	10F	\N
OW423	A350	10G	\N
OW423	A350	10H	\N
OW423	A350	10K	\N
OW423	A350	11A	\N
OW423	A350	11C	\N
OW423	A350	11D	\N
OW423	A350	11E	\N
OW423	A350	11F	\N
OW423	A350	11G	\N
OW423	A350	11H	\N
OW423	A350	11K	\N
OW423	A350	12D	\N
OW423	A350	12E	\N
OW423	A350	12F	\N
OW423	A350	12G	\N
OW423	A350	15D	\N
OW423	A350	15E	\N
OW423	A350	15F	\N
OW423	A350	15G	\N
OW423	A350	15H	\N
OW423	A350	15K	\N
OW423	A350	16A	\N
OW423	A350	16C	\N
OW423	A350	16D	\N
OW423	A350	16E	\N
OW423	A350	16F	\N
OW423	A350	16G	\N
OW423	A350	16H	\N
OW423	A350	16K	\N
OW423	A350	17A	\N
OW423	A350	17C	\N
OW423	A350	17D	\N
OW423	A350	17E	\N
OW423	A350	17F	\N
OW423	A350	17G	\N
OW423	A350	17H	\N
OW423	A350	17K	\N
OW423	A350	18A	\N
OW423	A350	18C	\N
OW423	A350	18D	\N
OW423	A350	18E	\N
OW423	A350	18F	\N
OW423	A350	18G	\N
OW423	A350	18H	\N
OW423	A350	18K	\N
OW423	A350	19A	\N
OW423	A350	19C	\N
OW423	A350	19D	\N
OW423	A350	19E	\N
OW423	A350	19F	\N
OW423	A350	19G	\N
OW423	A350	19H	\N
OW423	A350	19K	\N
OW423	A350	1A	\N
OW423	A350	1C	\N
OW423	A350	1D	\N
OW423	A350	1G	\N
OW423	A350	1H	\N
OW423	A350	1K	\N
OW423	A350	27A	\N
OW423	A350	27B	\N
OW423	A350	27C	\N
OW423	A350	27D	\N
OW423	A350	27E	\N
OW423	A350	27G	\N
OW423	A350	27H	\N
OW423	A350	27J	\N
OW423	A350	27K	\N
OW423	A350	28A	\N
OW423	A350	28B	\N
OW423	A350	28C	\N
OW423	A350	28D	\N
OW423	A350	28E	\N
OW423	A350	28G	\N
OW423	A350	28H	\N
OW423	A350	28J	\N
OW423	A350	28K	\N
OW423	A350	29A	\N
OW423	A350	29B	\N
OW423	A350	29C	\N
OW423	A350	29D	\N
OW423	A350	29E	\N
OW423	A350	29G	\N
OW423	A350	29H	\N
OW423	A350	29J	\N
OW423	A350	29K	\N
OW423	A350	2A	\N
OW423	A350	2C	\N
OW423	A350	2D	\N
OW423	A350	2G	\N
OW423	A350	2H	\N
OW423	A350	2K	\N
OW423	A350	30A	\N
OW423	A350	30B	\N
OW423	A350	30C	\N
OW423	A350	30D	\N
OW423	A350	30E	\N
OW423	A350	30G	\N
OW423	A350	30H	\N
OW423	A350	30J	\N
OW423	A350	30K	\N
OW423	A350	31A	\N
OW423	A350	31B	\N
OW423	A350	31C	\N
OW423	A350	31D	\N
OW423	A350	31E	\N
OW423	A350	31G	\N
OW423	A350	31H	\N
OW423	A350	31J	\N
OW423	A350	31K	\N
OW423	A350	32A	\N
OW423	A350	32B	\N
OW423	A350	32C	\N
OW423	A350	32D	\N
OW423	A350	32E	\N
OW423	A350	32G	\N
OW423	A350	32H	\N
OW423	A350	32J	\N
OW423	A350	32K	\N
OW423	A350	33A	\N
OW423	A350	33B	\N
OW423	A350	33C	\N
OW423	A350	33D	\N
OW423	A350	33E	\N
OW423	A350	33G	\N
OW423	A350	33H	\N
OW423	A350	33J	\N
OW423	A350	33K	\N
OW423	A350	34A	\N
OW423	A350	34B	\N
OW423	A350	34C	\N
OW423	A350	34D	\N
OW423	A350	34E	\N
OW423	A350	34G	\N
OW423	A350	34H	\N
OW423	A350	34J	\N
OW423	A350	34K	\N
OW423	A350	35A	\N
OW423	A350	35B	\N
OW423	A350	35C	\N
OW423	A350	35D	\N
OW423	A350	35E	\N
OW423	A350	35G	\N
OW423	A350	35H	\N
OW423	A350	35J	\N
OW423	A350	35K	\N
OW423	A350	36A	\N
OW423	A350	36B	\N
OW423	A350	36C	\N
OW423	A350	36D	\N
OW423	A350	36E	\N
OW423	A350	36G	\N
OW423	A350	36H	\N
OW423	A350	36J	\N
OW423	A350	36K	\N
OW423	A350	37A	\N
OW423	A350	37B	\N
OW423	A350	37C	\N
OW423	A350	37D	\N
OW423	A350	37E	\N
OW423	A350	37G	\N
OW423	A350	37H	\N
OW423	A350	37J	\N
OW423	A350	37K	\N
OW423	A350	38A	\N
OW423	A350	38B	\N
OW423	A350	38C	\N
OW423	A350	38D	\N
OW423	A350	38E	\N
OW423	A350	38G	\N
OW423	A350	38H	\N
OW423	A350	38J	\N
OW423	A350	38K	\N
OW423	A350	39A	\N
OW423	A350	39B	\N
OW423	A350	39C	\N
OW423	A350	39D	\N
OW423	A350	39E	\N
OW423	A350	39G	\N
OW423	A350	39H	\N
OW423	A350	39J	\N
OW423	A350	39K	\N
OW423	A350	40D	\N
OW423	A350	40E	\N
OW423	A350	40G	\N
OW423	A350	45A	\N
OW423	A350	45B	\N
OW423	A350	45C	\N
OW423	A350	45D	\N
OW423	A350	45E	\N
OW423	A350	45G	\N
OW423	A350	45H	\N
OW423	A350	45J	\N
OW423	A350	45K	\N
OW423	A350	46A	\N
OW423	A350	46B	\N
OW423	A350	46C	\N
OW423	A350	46D	\N
OW423	A350	46E	\N
OW423	A350	46G	\N
OW423	A350	46H	\N
OW423	A350	46J	\N
OW423	A350	46K	\N
OW423	A350	47A	\N
OW423	A350	47B	\N
OW423	A350	47C	\N
OW423	A350	47D	\N
OW423	A350	47E	\N
OW423	A350	47G	\N
OW423	A350	47H	\N
OW423	A350	47J	\N
OW423	A350	47K	\N
OW423	A350	48A	\N
OW423	A350	48B	\N
OW423	A350	48C	\N
OW423	A350	48D	\N
OW423	A350	48E	\N
OW423	A350	48G	\N
OW423	A350	48H	\N
OW423	A350	48J	\N
OW423	A350	48K	\N
OW423	A350	49A	\N
OW423	A350	49B	\N
OW423	A350	49C	\N
OW423	A350	49D	\N
OW423	A350	49E	\N
OW423	A350	49G	\N
OW423	A350	49H	\N
OW423	A350	49J	\N
OW423	A350	49K	\N
OW423	A350	50A	\N
OW423	A350	50B	\N
OW423	A350	50C	\N
OW423	A350	50D	\N
OW423	A350	50E	\N
OW423	A350	50G	\N
OW423	A350	50H	\N
OW423	A350	50J	\N
OW423	A350	50K	\N
OW423	A350	51A	\N
OW423	A350	51B	\N
OW423	A350	51C	\N
OW423	A350	51D	\N
OW423	A350	51E	\N
OW423	A350	51G	\N
OW423	A350	51H	\N
OW423	A350	51J	\N
OW423	A350	51K	\N
OW423	A350	52A	\N
OW423	A350	52B	\N
OW423	A350	52C	\N
OW423	A350	52D	\N
OW423	A350	52E	\N
OW423	A350	52G	\N
OW423	A350	52H	\N
OW423	A350	52J	\N
OW423	A350	52K	\N
OW423	A350	53A	\N
OW423	A350	53B	\N
OW423	A350	53C	\N
OW423	A350	53D	\N
OW423	A350	53E	\N
OW423	A350	53G	\N
OW423	A350	53H	\N
OW423	A350	53J	\N
OW423	A350	53K	\N
OW423	A350	54A	\N
OW423	A350	54B	\N
OW423	A350	54C	\N
OW423	A350	54D	\N
OW423	A350	54E	\N
OW423	A350	54G	\N
OW423	A350	54H	\N
OW423	A350	54J	\N
OW423	A350	54K	\N
OW423	A350	55A	\N
OW423	A350	55B	\N
OW423	A350	55C	\N
OW423	A350	55D	\N
OW423	A350	55E	\N
OW423	A350	55G	\N
OW423	A350	55H	\N
OW423	A350	55J	\N
OW423	A350	55K	\N
OW423	A350	56A	\N
OW423	A350	56B	\N
OW423	A350	56C	\N
OW423	A350	56D	\N
OW423	A350	56E	\N
OW423	A350	56G	\N
OW423	A350	56H	\N
OW423	A350	56J	\N
OW423	A350	56K	\N
OW423	A350	57A	\N
OW423	A350	57B	\N
OW423	A350	57C	\N
OW423	A350	57D	\N
OW423	A350	57E	\N
OW423	A350	57G	\N
OW423	A350	57H	\N
OW423	A350	57J	\N
OW423	A350	57K	\N
OW423	A350	58A	\N
OW423	A350	58B	\N
OW423	A350	58C	\N
OW423	A350	58D	\N
OW423	A350	58E	\N
OW423	A350	58G	\N
OW423	A350	58H	\N
OW423	A350	58J	\N
OW423	A350	58K	\N
OW423	A350	59A	\N
OW423	A350	59B	\N
OW423	A350	59C	\N
OW423	A350	59D	\N
OW423	A350	59E	\N
OW423	A350	59G	\N
OW423	A350	59H	\N
OW423	A350	59J	\N
OW423	A350	59K	\N
OW423	A350	5A	\N
OW423	A350	5C	\N
OW423	A350	5H	\N
OW423	A350	5K	\N
OW423	A350	60A	\N
OW423	A350	60C	\N
OW423	A350	60D	\N
OW423	A350	60E	\N
OW423	A350	60G	\N
OW423	A350	61D	\N
OW423	A350	61E	\N
OW423	A350	61G	\N
OW423	A350	6A	\N
OW423	A350	6C	\N
OW423	A350	6D	\N
OW423	A350	6E	\N
OW423	A350	6F	\N
OW423	A350	6G	\N
OW423	A350	6H	\N
OW423	A350	6K	\N
OW423	A350	7A	\N
OW423	A350	7C	\N
OW423	A350	7D	\N
OW423	A350	7E	\N
OW423	A350	7F	\N
OW423	A350	7G	\N
OW423	A350	7H	\N
OW423	A350	7K	\N
OW423	A350	8A	\N
OW423	A350	8C	\N
OW423	A350	8D	\N
OW423	A350	8E	\N
OW423	A350	8F	\N
OW423	A350	8G	\N
OW423	A350	8H	\N
OW423	A350	8K	\N
OW423	A350	9A	\N
OW423	A350	9C	\N
OW423	A350	9D	\N
OW423	A350	9E	\N
OW423	A350	9F	\N
OW423	A350	9G	\N
OW423	A350	9H	\N
OW423	A350	9K	\N
\.


--
-- Data for Name: Passenger; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Passenger" ("PassID", "FirstName", "LastName", "DOB", "Gender", "Email", "PhoneNumber", "Passport", "SSN", "GuardianID") FROM stdin;
P226910	Joseph	Sims	2003-01-25	F	robert54@mcintosh.net	76035631868	TTN23715701	933612508072	\N
P626255	Catherine	Evans	1951-05-14	M	rjohnson@thompson-alvarez.com	68717993195	qQX76376405	594717025188	\N
P459825	Corey	Frost	1959-02-15	F	ericapowell@yahoo.com	13295651565	PLN25774461	237432521875	\N
P424984	John	Gonzalez	1962-04-23	M	benjamin76@hotmail.com	39102599743	grU35297380	174076137477	\N
P786810	Joshua	Small	1982-09-13	F	sanchezdiane@rivera.com	7712196556	PsE52144059	830806061166	\N
P328150	Caleb	Leach	2001-07-25	F	xle@yahoo.com	534631698	tzj06697556	446320965827	\N
P36366	Amy	Taylor	1956-12-15	M	wcannon@lutz-reyes.com	3852524537	Fhe69901160	332333302347	\N
P730518	Kimberly	Warner	2017-12-16	M	martinezderek@hotmail.com	06388538851	xdb61146201	129910881834	\N
P301776	Crystal	Ball	1990-01-09	F	lperez@hawkins.org	99221246491	xCw73522111	410878253190	\N
P995898	Daniel	Mitchell	1965-01-02	F	marcuslewis@yahoo.com	24594725271	eyU89416952	506497400492	\N
P907705	Taylor	Colon	1974-07-26	M	julia67@butler.com	08838794191	Vmq94247071	744834350957	\N
P219502	Emily	Barnes	1964-10-03	M	cdickson@hotmail.com	0851849180	jhG67113887	900409687215	\N
P532366	Morgan	Luna	1989-12-09	F	travisamber@harris.com	0267388758	sGy72419543	470504233854	\N
P444151	Amy	Byrd	2009-06-11	M	williamsonerin@bautista-baldwin.com	768261435	vfc35838708	418457845354	\N
P777851	Lisa	Gibson	1994-11-27	M	bmoore@hotmail.com	65688565411	qXz88839713	320929379975	\N
P90006	James	Houston	1953-02-27	F	cynthiagordon@garcia.net	0322542280	OOs67111246	667339306352	\N
P131179	Debbie	Foster	1949-06-03	F	mary43@hotmail.com	77841878636	CSQ23774031	150360656816	\N
P623002	Alexander	Smith	1992-03-29	F	anthony24@hendricks.net	98386212760	mpi78311924	362925073889	\N
P988190	Ronald	Barker	1969-05-17	F	bobharris@howard.com	06304598429	Wjt34664635	639653955658	\N
P228672	Matthew	Ferguson	1985-09-22	F	allenhannah@hotmail.com	12240945247	fcz49916066	388977618700	\N
P585133	Sherry	Parker	1998-09-21	F	contrerasjulie@maynard-strong.com	36628009832	Apk35244989	880206607981	\N
P188918	Katherine	Mccarthy	1958-07-12	M	lucasbailey@yahoo.com	72307495998	DqP57054787	064396564704	\N
P304750	Russell	Murray	1977-12-21	F	ajohnson@hotmail.com	8160225843	Zug41946203	517221103257	\N
P383839	Dwayne	Vasquez	2008-09-26	M	millerbradley@miller.com	91632352679	Oqw32841996	198539212479	\N
P985196	Jack	Roth	1975-06-07	F	marcsmith@spencer-marsh.org	39915625721	zda26892187	582007533908	\N
P690648	Eric	Thompson	2003-01-10	F	qcook@velazquez.com	84147593651	dDb12226484	890726416225	\N
P891428	Craig	Payne	2017-04-12	F	donald57@hotmail.com	47525751371	FlO23672616	830491823501	\N
P836604	Pamela	Garcia	2004-03-14	M	khall@collins-williams.com	68931457822	JAQ26904382	650625554216	\N
P474810	Elizabeth	Perez	1968-08-23	M	rangelkevin@hernandez.com	2357154224	vat35145137	546296009787	\N
P517637	Amanda	Rubio	1955-11-03	M	nbutler@yahoo.com	53118392286	RMw62105384	404928197473	\N
P405059	Jennifer	Burns	1975-04-18	F	lesliebean@hotmail.com	50645712531	Mkf21061009	155682348719	\N
P74226	Ian	Holland	1986-03-17	F	fgiles@gmail.com	17333052782	rOd20023993	799845305447	\N
P192124	Jennifer	Bauer	1965-04-28	M	donald59@yahoo.com	97619956579	BqC18456964	486999595669	\N
P634234	Peggy	Oneal	1988-08-16	M	uwalter@hotmail.com	12824903308	Mhv08404550	472884880905	\N
P41552	Jessica	Wagner	1950-07-03	M	brownryan@moore-miller.biz	87445559234	Ogp51513836	139814994842	\N
P156749	Rodney	Nichols	1989-01-31	F	zacharymartinez@gmail.com	36299385042	XYS61679785	554220207083	\N
P966954	Joseph	Watson	2019-01-11	M	emilymorris@gmail.com	52026882259	yNC89231666	121983572982	\N
P967314	David	Fuentes	2017-05-11	F	rhodesjohnny@gmail.com	993655554	iOS69908983	918929054688	\N
P991447	Ryan	Nelson	1955-05-03	F	benjamin57@gmail.com	275096214	URt43968794	596288935033	\N
P834635	Kimberly	Duran	1975-10-07	F	gibsontiffany@farrell.com	17795952320	eCp31324624	954090347067	\N
P820991	Ashley	Jackson	2003-08-18	F	pcole@turner.org	11412763369	ShP04135224	696016125964	\N
P68040	Steven	Ramirez	1957-04-30	M	adam46@hotmail.com	21945781655	Dsi09086714	999908584840	\N
P618712	Cristian	Haney	2003-11-05	F	kaylalane@henderson.com	08313799938	BOL44986728	763332874019	\N
P229537	Denise	Mckenzie	1965-01-24	F	timothy57@gmail.com	55717529006	PTf74091638	048490101013	\N
P160699	Ann	Martin	1969-11-29	M	kevindrake@gmail.com	0989993534	rUZ67529618	464426079637	\N
P741449	Minh	Hoang Anh	2004-11-29	M	hoanganhminh2004@gmail.com	0387183229	11223344556677	123456987000	\N
P914443	Lan	Le	2003-12-20	F	lanlehoang8124@gmail.com	0896900104	11223344557766	001304017630	\N
P908385	Hoang Lan	Le	2000-11-08	F	lanlehoang8124@gmail.com	0896900104	 11223344556677	123456789001	\N
P134756	Lan	Le	2007-12-20	M	lanlehoang8124@gmail.com	0896900104	112233445566	012345678909	\N
P873632	Quang	Chu	2004-11-14	M	quang@gmail.com	0987654321	14112004141120041411	141120041411	\N
P671609	Phuc	Pham	2004-11-12	M	phuc@gmail.com	0987654322	12112004121120041211	121120041211	\N
P912206	Minh	Hoang	2022-10-10	M	\N	\N	\N	\N	\N
\.


--
-- Data for Name: Promotion; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Promotion" ("PromotionID", "Content", "Title", "Amount") FROM stdin;
\.


--
-- Data for Name: Seat; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Seat" ("AircraftID", "SeatNo", "Class") FROM stdin;
A350	1A	Business
A350	1C	Business
A350	1D	Business
A350	1G	Business
A350	1H	Business
A350	1K	Business
A350	10A	Business
A350	10C	Business
A350	10D	Business
A350	10E	Business
A350	10F	Business
A350	10G	Business
A350	10H	Business
A350	10K	Business
A350	11A	Business
A350	11C	Business
A350	11D	Business
A350	11E	Business
A350	11F	Business
A350	11G	Business
A350	11H	Business
A350	11K	Business
A350	12D	Business
A350	12E	Business
A350	12F	Business
A350	12G	Business
A350	15D	Business
A350	15E	Business
A350	15F	Business
A350	15G	Business
A350	15H	Business
A350	15K	Business
A350	16A	Business
A350	16C	Business
A350	16D	Business
A350	16E	Business
A350	16F	Business
A350	16G	Business
A350	16H	Business
A350	16K	Business
A350	17A	Business
A350	17C	Business
A350	17D	Business
A350	17E	Business
A350	17F	Business
A350	17G	Business
A350	17H	Business
A350	17K	Business
A350	18A	Business
A350	18C	Business
A350	18D	Business
A350	18E	Business
A350	18F	Business
A350	18G	Business
A350	18H	Business
A350	18K	Business
A350	19A	Business
A350	19C	Business
A350	19D	Business
A350	19E	Business
A350	19F	Business
A350	19G	Business
A350	19H	Business
A350	19K	Business
A350	2A	Business
A350	2C	Business
A350	2D	Business
A350	2G	Business
A350	2H	Business
A350	2K	Business
A350	27A	Economy
A350	27B	Economy
A350	27C	Economy
A350	27D	Economy
A350	27E	Economy
A350	27G	Economy
A350	27H	Economy
A350	27J	Economy
A350	27K	Economy
A350	28A	Economy
A350	28B	Economy
A350	28C	Economy
A350	28D	Economy
A350	28E	Economy
A350	28G	Economy
A350	28H	Economy
A350	28J	Economy
A350	28K	Economy
A350	29A	Economy
A350	29B	Economy
A350	29C	Economy
A350	29D	Economy
A350	29E	Economy
A350	29G	Economy
A350	29H	Economy
A350	29J	Economy
A350	29K	Economy
A350	30A	Economy
A350	30B	Economy
A350	30C	Economy
A350	30D	Economy
A350	30E	Economy
A350	30G	Economy
A350	30H	Economy
A350	30J	Economy
A350	30K	Economy
A350	31A	Economy
A350	31B	Economy
A350	31C	Economy
A350	31D	Economy
A350	31E	Economy
A350	31G	Economy
A350	31H	Economy
A350	31J	Economy
A350	31K	Economy
A350	32A	Economy
A350	32B	Economy
A350	32C	Economy
A350	32D	Economy
A350	32E	Economy
A350	32G	Economy
A350	32H	Economy
A350	32J	Economy
A350	32K	Economy
A350	33A	Economy
A350	33B	Economy
A350	33C	Economy
A350	33D	Economy
A350	33E	Economy
A350	33G	Economy
A350	33H	Economy
A350	33J	Economy
A350	33K	Economy
A350	34A	Economy
A350	34B	Economy
A350	34C	Economy
A350	34D	Economy
A350	34E	Economy
A350	34G	Economy
A350	34H	Economy
A350	34J	Economy
A350	34K	Economy
A350	35A	Economy
A350	35B	Economy
A350	35C	Economy
A350	35D	Economy
A350	35E	Economy
A350	35G	Economy
A350	35H	Economy
A350	35J	Economy
A350	35K	Economy
A350	36A	Economy
A350	36B	Economy
A350	36C	Economy
A350	36D	Economy
A350	36E	Economy
A350	36G	Economy
A350	36H	Economy
A350	36J	Economy
A350	36K	Economy
A350	37A	Economy
A350	37B	Economy
A350	37C	Economy
A350	37D	Economy
A350	37E	Economy
A350	37G	Economy
A350	37H	Economy
A350	37J	Economy
A350	37K	Economy
A350	38A	Economy
A350	38B	Economy
A350	38C	Economy
A350	38D	Economy
A350	38E	Economy
A350	38G	Economy
A350	38H	Economy
A350	38J	Economy
A350	38K	Economy
A350	39A	Economy
A350	39B	Economy
A350	39C	Economy
A350	39D	Economy
A350	39E	Economy
A350	39G	Economy
A350	39H	Economy
A350	39J	Economy
A350	39K	Economy
A350	40D	Economy
A350	40E	Economy
A350	40G	Economy
A350	45A	Economy
A350	45B	Economy
A350	45C	Economy
A350	45D	Economy
A350	45E	Economy
A350	45G	Economy
A350	45H	Economy
A350	45J	Economy
A350	45K	Economy
A350	46A	Economy
A350	46B	Economy
A350	46C	Economy
A350	46D	Economy
A350	46E	Economy
A350	46G	Economy
A350	46H	Economy
A350	46J	Economy
A350	46K	Economy
A350	47A	Economy
A350	47B	Economy
A350	47C	Economy
A350	47D	Economy
A350	47E	Economy
A350	47G	Economy
A350	47H	Economy
A350	47J	Economy
A350	47K	Economy
A350	48A	Economy
A350	48B	Economy
A350	48C	Economy
A350	48D	Economy
A350	48E	Economy
A350	48G	Economy
A350	48H	Economy
A350	48J	Economy
A350	48K	Economy
A350	49A	Economy
A350	49B	Economy
A350	49C	Economy
A350	49D	Economy
A350	49E	Economy
A350	49G	Economy
A350	49H	Economy
A350	49J	Economy
A350	49K	Economy
A350	5A	Business
A350	5C	Business
A350	5H	Business
A350	5K	Business
A350	50A	Economy
A350	50B	Economy
A350	50C	Economy
A350	50D	Economy
A350	50E	Economy
A350	50G	Economy
A350	50H	Economy
A350	50J	Economy
A350	50K	Economy
A350	51A	Economy
A350	51B	Economy
A350	51C	Economy
A350	51D	Economy
A350	51E	Economy
A350	51G	Economy
A350	51H	Economy
A350	51J	Economy
A350	51K	Economy
A350	52A	Economy
A350	52B	Economy
A350	52C	Economy
A350	52D	Economy
A350	52E	Economy
A350	52G	Economy
A350	52H	Economy
A350	52J	Economy
A350	52K	Economy
A350	53A	Economy
A350	53B	Economy
A350	53C	Economy
A350	53D	Economy
A350	53E	Economy
A350	53G	Economy
A350	53H	Economy
A350	53J	Economy
A350	53K	Economy
A350	54A	Economy
A350	54B	Economy
A350	54C	Economy
A350	54D	Economy
A350	54E	Economy
A350	54G	Economy
A350	54H	Economy
A350	54J	Economy
A350	54K	Economy
A350	55A	Economy
A350	55B	Economy
A350	55C	Economy
A350	55D	Economy
A350	55E	Economy
A350	55G	Economy
A350	55H	Economy
A350	55J	Economy
A350	55K	Economy
A350	56A	Economy
A350	56B	Economy
A350	56C	Economy
A350	56D	Economy
A350	56E	Economy
A350	56G	Economy
A350	56H	Economy
A350	56J	Economy
A350	56K	Economy
A350	57A	Economy
A350	57B	Economy
A350	57C	Economy
A350	57D	Economy
A350	57E	Economy
A350	57G	Economy
A350	57H	Economy
A350	57J	Economy
A350	57K	Economy
A350	58A	Economy
A350	58B	Economy
A350	58C	Economy
A350	58D	Economy
A350	58E	Economy
A350	58G	Economy
A350	58H	Economy
A350	58J	Economy
A350	58K	Economy
A350	59A	Economy
A350	59B	Economy
A350	59C	Economy
A350	59D	Economy
A350	59E	Economy
A350	59G	Economy
A350	59H	Economy
A350	59J	Economy
A350	59K	Economy
A350	6A	Business
A350	6C	Business
A350	6D	Business
A350	6E	Business
A350	6F	Business
A350	6G	Business
A350	6H	Business
A350	6K	Business
A350	60A	Economy
A350	60C	Economy
A350	60D	Economy
A350	60E	Economy
A350	60G	Economy
A350	61D	Economy
A350	61E	Economy
A350	61G	Economy
A350	7A	Business
A350	7C	Business
A350	7D	Business
A350	7E	Business
A350	7F	Business
A350	7G	Business
A350	7H	Business
A350	7K	Business
A350	8A	Business
A350	8C	Business
A350	8D	Business
A350	8E	Business
A350	8F	Business
A350	8G	Business
A350	8H	Business
A350	8K	Business
A350	9A	Business
A350	9C	Business
A350	9D	Business
A350	9E	Business
A350	9F	Business
A350	9G	Business
A350	9H	Business
A350	9K	Business
A380	1A	First
A380	1E	First
A380	1F	First
A380	1K	First
A380	10B	Business
A380	10D	Business
A380	10G	Business
A380	10J	Business
A380	11A	Business
A380	11E	Business
A380	11F	Business
A380	11K	Business
A380	12B	Business
A380	12D	Business
A380	12G	Business
A380	12J	Business
A380	14A	Business
A380	14E	Business
A380	14F	Business
A380	14K	Business
A380	15B	Business
A380	15D	Business
A380	15G	Business
A380	15J	Business
A380	16A	Business
A380	16E	Business
A380	16F	Business
A380	16K	Business
A380	17B	Business
A380	17D	Business
A380	17G	Business
A380	17J	Business
A380	18A	Business
A380	18E	Business
A380	18F	Business
A380	18K	Business
A380	19B	Business
A380	19D	Business
A380	19G	Business
A380	19J	Business
A380	2A	First
A380	2E	First
A380	2F	First
A380	2K	First
A380	20A	Business
A380	20E	Business
A380	20F	Business
A380	20K	Business
A380	21B	Business
A380	21D	Business
A380	21G	Business
A380	21J	Business
A380	22D	Business
A380	22G	Business
A380	23A	Business
A380	23E	Business
A380	23F	Business
A380	23K	Business
A380	24B	Business
A380	24D	Business
A380	24G	Business
A380	24J	Business
A380	25A	Business
A380	25E	Business
A380	25F	Business
A380	25K	Business
A380	26B	Business
A380	26D	Business
A380	26G	Business
A380	26J	Business
A380	3A	First
A380	3E	First
A380	3F	First
A380	3K	First
A380	4A	First
A380	4K	First
A380	43A	Economy
A380	43B	Economy
A380	43C	Economy
A380	43H	Economy
A380	43J	Economy
A380	43K	Economy
A380	44A	Economy
A380	44B	Economy
A380	44C	Economy
A380	44H	Economy
A380	44J	Economy
A380	44K	Economy
A380	45A	Economy
A380	45B	Economy
A380	45C	Economy
A380	45D	Economy
A380	45E	Economy
A380	45F	Economy
A380	45G	Economy
A380	45H	Economy
A380	45J	Economy
A380	45K	Economy
A380	46A	Economy
A380	46B	Economy
A380	46C	Economy
A380	46D	Economy
A380	46E	Economy
A380	46F	Economy
A380	46G	Economy
A380	46H	Economy
A380	46J	Economy
A380	46K	Economy
A380	47A	Economy
A380	47B	Economy
A380	47C	Economy
A380	47D	Economy
A380	47E	Economy
A380	47F	Economy
A380	47G	Economy
A380	47H	Economy
A380	47J	Economy
A380	47K	Economy
A380	48A	Economy
A380	48B	Economy
A380	48C	Economy
A380	48D	Economy
A380	48E	Economy
A380	48F	Economy
A380	48G	Economy
A380	48H	Economy
A380	48J	Economy
A380	48K	Economy
A380	49A	Economy
A380	49B	Economy
A380	49C	Economy
A380	49D	Economy
A380	49E	Economy
A380	49F	Economy
A380	49G	Economy
A380	49H	Economy
A380	49J	Economy
A380	49K	Economy
A380	50A	Economy
A380	50B	Economy
A380	50C	Economy
A380	50D	Economy
A380	50E	Economy
A380	50F	Economy
A380	50G	Economy
A380	50H	Economy
A380	50J	Economy
A380	50K	Economy
A380	51D	Economy
A380	51E	Economy
A380	51F	Economy
A380	51G	Economy
A380	52A	Economy
A380	52B	Economy
A380	52C	Economy
A380	52H	Economy
A380	52J	Economy
A380	52K	Economy
A380	53A	Economy
A380	53B	Economy
A380	53C	Economy
A380	53H	Economy
A380	53J	Economy
A380	53K	Economy
A380	54A	Economy
A380	54B	Economy
A380	54C	Economy
A380	54D	Economy
A380	54E	Economy
A380	54F	Economy
A380	54G	Economy
A380	54H	Economy
A380	54J	Economy
A380	54K	Economy
A380	55A	Economy
A380	55B	Economy
A380	55C	Economy
A380	55D	Economy
A380	55E	Economy
A380	55F	Economy
A380	55G	Economy
A380	55H	Economy
A380	55J	Economy
A380	55K	Economy
A380	56A	Economy
A380	56B	Economy
A380	56C	Economy
A380	56D	Economy
A380	56E	Economy
A380	56F	Economy
A380	56G	Economy
A380	56H	Economy
A380	56J	Economy
A380	56K	Economy
A380	57A	Economy
A380	57B	Economy
A380	57C	Economy
A380	57D	Economy
A380	57E	Economy
A380	57F	Economy
A380	57G	Economy
A380	57H	Economy
A380	57J	Economy
A380	57K	Economy
A380	58A	Economy
A380	58B	Economy
A380	58C	Economy
A380	58D	Economy
A380	58E	Economy
A380	58F	Economy
A380	58G	Economy
A380	58H	Economy
A380	58J	Economy
A380	58K	Economy
A380	59A	Economy
A380	59B	Economy
A380	59C	Economy
A380	59D	Economy
A380	59E	Economy
A380	59F	Economy
A380	59G	Economy
A380	59H	Economy
A380	59J	Economy
A380	59K	Economy
A380	6D	Business
A380	6G	Business
A380	60A	Economy
A380	60B	Economy
A380	60C	Economy
A380	60D	Economy
A380	60E	Economy
A380	60F	Economy
A380	60G	Economy
A380	60H	Economy
A380	60J	Economy
A380	60K	Economy
A380	61A	Economy
A380	61B	Economy
A380	61C	Economy
A380	61D	Economy
A380	61E	Economy
A380	61F	Economy
A380	61G	Economy
A380	61H	Economy
A380	61J	Economy
A380	61K	Economy
A380	62A	Economy
A380	62B	Economy
A380	62C	Economy
A380	62D	Economy
A380	62E	Economy
A380	62F	Economy
A380	62G	Economy
A380	62H	Economy
A380	62J	Economy
A380	62K	Economy
A380	63A	Economy
A380	63B	Economy
A380	63C	Economy
A380	63D	Economy
A380	63E	Economy
A380	63F	Economy
A380	63G	Economy
A380	63H	Economy
A380	63J	Economy
A380	63K	Economy
A380	64A	Economy
A380	64B	Economy
A380	64C	Economy
A380	64D	Economy
A380	64E	Economy
A380	64F	Economy
A380	64G	Economy
A380	64H	Economy
A380	64J	Economy
A380	64K	Economy
A380	65A	Economy
A380	65B	Economy
A380	65C	Economy
A380	65D	Economy
A380	65E	Economy
A380	65F	Economy
A380	65G	Economy
A380	65H	Economy
A380	65J	Economy
A380	65K	Economy
A380	66H	Economy
A380	66J	Economy
A380	66K	Economy
A380	67B	Economy
A380	67C	Economy
A380	67D	Economy
A380	67E	Economy
A380	67F	Economy
A380	67G	Economy
A380	67H	Economy
A380	67J	Economy
A380	68A	Economy
A380	68B	Economy
A380	68C	Economy
A380	68D	Economy
A380	68E	Economy
A380	68F	Economy
A380	68G	Economy
A380	68H	Economy
A380	68J	Economy
A380	68K	Economy
A380	69A	Economy
A380	69B	Economy
A380	69C	Economy
A380	69D	Economy
A380	69E	Economy
A380	69F	Economy
A380	69G	Economy
A380	69H	Economy
A380	69J	Economy
A380	69K	Economy
A380	7A	Business
A380	7E	Business
A380	7F	Business
A380	7K	Business
A380	70A	Economy
A380	70B	Economy
A380	70C	Economy
A380	70D	Economy
A380	70E	Economy
A380	70F	Economy
A380	70G	Economy
A380	70H	Economy
A380	70J	Economy
A380	70K	Economy
A380	71A	Economy
A380	71B	Economy
A380	71C	Economy
A380	71D	Economy
A380	71E	Economy
A380	71F	Economy
A380	71G	Economy
A380	71H	Economy
A380	71J	Economy
A380	71K	Economy
A380	72A	Economy
A380	72B	Economy
A380	72C	Economy
A380	72D	Economy
A380	72E	Economy
A380	72F	Economy
A380	72G	Economy
A380	72H	Economy
A380	72J	Economy
A380	72K	Economy
A380	73A	Economy
A380	73B	Economy
A380	73C	Economy
A380	73D	Economy
A380	73E	Economy
A380	73F	Economy
A380	73G	Economy
A380	73H	Economy
A380	73J	Economy
A380	73K	Economy
A380	74A	Economy
A380	74B	Economy
A380	74C	Economy
A380	74D	Economy
A380	74E	Economy
A380	74F	Economy
A380	74G	Economy
A380	74H	Economy
A380	74J	Economy
A380	74K	Economy
A380	75A	Economy
A380	75B	Economy
A380	75C	Economy
A380	75D	Economy
A380	75E	Economy
A380	75F	Economy
A380	75G	Economy
A380	75H	Economy
A380	75J	Economy
A380	75K	Economy
A380	76A	Economy
A380	76B	Economy
A380	76C	Economy
A380	76D	Economy
A380	76E	Economy
A380	76F	Economy
A380	76G	Economy
A380	76H	Economy
A380	76J	Economy
A380	76K	Economy
A380	77A	Economy
A380	77B	Economy
A380	77C	Economy
A380	77D	Economy
A380	77E	Economy
A380	77F	Economy
A380	77G	Economy
A380	77H	Economy
A380	77J	Economy
A380	77K	Economy
A380	78A	Economy
A380	78B	Economy
A380	78C	Economy
A380	78D	Economy
A380	78E	Economy
A380	78F	Economy
A380	78G	Economy
A380	78H	Economy
A380	78J	Economy
A380	78K	Economy
A380	79A	Economy
A380	79B	Economy
A380	79C	Economy
A380	79H	Economy
A380	79J	Economy
A380	79K	Economy
A380	8B	Business
A380	8D	Business
A380	8G	Business
A380	8J	Business
A380	80B	Economy
A380	80C	Economy
A380	80H	Economy
A380	80J	Economy
A380	81A	Economy
A380	81B	Economy
A380	81C	Economy
A380	81H	Economy
A380	81J	Economy
A380	81K	Economy
A380	82A	Economy
A380	82B	Economy
A380	82C	Economy
A380	82D	Economy
A380	82E	Economy
A380	82F	Economy
A380	82G	Economy
A380	82H	Economy
A380	82J	Economy
A380	82K	Economy
A380	83A	Economy
A380	83B	Economy
A380	83C	Economy
A380	83D	Economy
A380	83E	Economy
A380	83F	Economy
A380	83G	Economy
A380	83H	Economy
A380	83J	Economy
A380	83K	Economy
A380	84A	Economy
A380	84B	Economy
A380	84C	Economy
A380	84D	Economy
A380	84E	Economy
A380	84F	Economy
A380	84G	Economy
A380	84H	Economy
A380	84J	Economy
A380	84K	Economy
A380	85A	Economy
A380	85B	Economy
A380	85C	Economy
A380	85H	Economy
A380	85J	Economy
A380	85K	Economy
A380	86A	Economy
A380	86B	Economy
A380	86C	Economy
A380	86H	Economy
A380	86J	Economy
A380	86K	Economy
A380	87A	Economy
A380	87B	Economy
A380	87C	Economy
A380	87H	Economy
A380	87J	Economy
A380	87K	Economy
A380	88A	Economy
A380	88B	Economy
A380	88C	Economy
A380	88H	Economy
A380	88J	Economy
A380	88K	Economy
A380	9A	Business
A380	9E	Business
A380	9F	Business
A380	9K	Business
\.


--
-- Data for Name: Ticket; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Ticket" ("TicketID", "FlightID", "AircraftID", "SeatNo", "PassID", "CancellationDeadline") FROM stdin;
T855556	VJ796	A350	10F	P424984	2024-12-16 03:00:00+00
T768650	VJ796	A350	10D	P626255	2024-12-16 03:00:00+00
T736218	VJ796	A350	1A	P459825	2024-12-16 03:00:00+00
T668011	VJ796	A350	10E	P786810	2024-12-16 03:00:00+00
T659609	QU263	A350	1K	P328150	2024-12-16 07:00:00+00
T679344	QU263	A350	10E	P36366	2024-12-16 07:00:00+00
T453812	QU263	A350	1D	P995898	2024-12-16 07:00:00+00
T270491	QU263	A350	1A	P730518	2024-12-16 07:00:00+00
T800786	QU263	A350	10G	P301776	2024-12-16 07:00:00+00
T984917	CR158	A350	10A	P907705	2024-12-16 11:00:00+00
T318118	CR158	A350	1G	P532366	2024-12-16 11:00:00+00
T778205	CR158	A350	1D	P777851	2024-12-16 11:00:00+00
T955117	CR158	A350	10F	P219502	2024-12-16 11:00:00+00
T941985	ZE355	A380	1K	P90006	2024-12-17 03:00:00+00
T682199	ZE355	A380	1F	P228672	2024-12-17 03:00:00+00
T539990	ZE355	A380	3E	P623002	2024-12-17 03:00:00+00
T924508	ZE355	A380	2E	P131179	2024-12-17 03:00:00+00
T275950	ZE355	A380	3F	P988190	2024-12-17 03:00:00+00
T798011	OQ831	A350	1A	P585133	2024-12-17 07:00:00+00
T739694	OQ831	A350	1K	P383839	2024-12-17 07:00:00+00
T171862	OQ831	A350	10F	P188918	2024-12-17 07:00:00+00
T579275	OQ831	A350	1C	P985196	2024-12-17 07:00:00+00
T465739	OQ831	A350	10K	P304750	2024-12-17 07:00:00+00
T166019	SU399	A380	45B	P891428	2024-12-17 11:00:00+00
T522586	SU399	A380	44C	P836604	2024-12-17 11:00:00+00
T534520	SU399	A380	46A	P690648	2024-12-17 11:00:00+00
T386035	SU399	A380	45C	P474810	2024-12-17 11:00:00+00
T424677	SU399	A380	43A	P517637	2024-12-17 11:00:00+00
T156484	XJ392	A350	29B	P634234	2024-12-18 03:00:00+00
T988936	XJ392	A350	29C	P41552	2024-12-18 03:00:00+00
T843803	XJ392	A350	27C	P192124	2024-12-18 03:00:00+00
T630799	XJ392	A350	27B	P74226	2024-12-18 03:00:00+00
T228572	SS216	A380	43C	P966954	2024-12-18 07:00:00+00
T853119	SS216	A380	43B	P156749	2024-12-18 07:00:00+00
T875668	SS216	A380	45C	P967314	2024-12-18 07:00:00+00
T175905	SS216	A380	46A	P991447	2024-12-18 07:00:00+00
T304104	SS216	A380	44B	P834635	2024-12-18 07:00:00+00
T965146	AY611	A350	10H	P820991	2024-12-18 11:00:00+00
T828308	AY611	A350	10F	P618712	2024-12-18 11:00:00+00
T305740	AY611	A350	10C	P229537	2024-12-18 11:00:00+00
T856742	AY611	A350	10K	P160699	2024-12-18 11:00:00+00
T521867	AY611	A350	10A	P68040	2024-12-18 11:00:00+00
T812235	ZE355	A380	44H	P741449	2024-12-17 03:00:00+00
T880586	ZE355	A380	18K	P914443	2024-12-17 03:00:00+00
T910288	XJ392	A350	28C	P908385	2024-12-18 03:00:00+00
T302080	XJ392	A350	28D	P873632	2024-12-18 03:00:00+00
T909233	XJ392	A350	28E	P671609	2024-12-18 03:00:00+00
T168151	XJ392	A350	28E	P912206	2024-12-18 03:00:00+00
T168321	OQ831	A350	28D	P873632	2024-12-17 14:30:00+00
\.


--
-- Data for Name: TicketClass; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."TicketClass" ("ClassName", "FlightID", "Price") FROM stdin;
Economy	OH179	100.00
Business	OH179	200.00
First	OH179	500.00
Economy	WV763	114.00
Business	WV763	779.00
First	WV763	1478.00
Economy	WW137	131.00
Business	WW137	681.00
First	WW137	1368.00
Economy	PA645	131.00
Business	PA645	486.00
First	PA645	1012.00
Economy	IT851	80.00
Business	IT851	512.00
First	IT851	1109.00
Economy	XK135	186.00
Business	XK135	794.00
First	XK135	1023.00
Economy	YY762	98.00
Business	YY762	750.00
First	YY762	1053.00
Economy	VP730	191.00
Business	VP730	444.00
First	VP730	1052.00
Economy	ZI116	112.00
Business	ZI116	421.00
First	ZI116	1254.00
Economy	PM765	146.00
Business	PM765	653.00
First	PM765	1162.00
Economy	WW790	98.00
Business	WW790	695.00
First	WW790	1017.00
Economy	RN302	175.00
Business	RN302	698.00
First	RN302	944.00
Economy	HR357	168.00
Business	HR357	766.00
First	HR357	1427.00
Economy	VJ796	158.00
Business	VJ796	782.00
First	VJ796	1093.00
Economy	QU263	131.00
Business	QU263	426.00
First	QU263	1017.00
Economy	CR158	151.00
Business	CR158	756.00
First	CR158	1486.00
Economy	ZE355	106.00
Business	ZE355	767.00
First	ZE355	1103.00
Economy	OQ831	94.00
Business	OQ831	728.00
First	OQ831	1116.00
Economy	SU399	193.00
Business	SU399	743.00
First	SU399	1401.00
Economy	XJ392	170.00
Business	XJ392	679.00
First	XJ392	959.00
Economy	SS216	195.00
Business	SS216	749.00
First	SS216	1133.00
Economy	AY611	150.00
Business	AY611	539.00
First	AY611	1147.00
Economy	LP699	100.00
Business	LP699	200.00
First	LP699	500.00
Economy	UG650	110.00
Business	UG650	210.00
First	UG650	510.00
Economy	AX776	120.00
Business	AX776	220.00
First	AX776	520.00
Economy	ZD340	150.00
Business	ZD340	250.00
First	ZD340	550.00
Economy	BK248	100.00
Business	BK248	200.00
First	BK248	500.00
Economy	WI105	100.00
Business	WI105	200.00
First	WI105	300.00
Economy	VB710	100.00
Business	VB710	200.00
First	VB710	300.00
Economy	BQ968	100.00
Business	BQ968	200.00
First	BQ968	300.00
Economy	OW423	100.00
Business	OW423	200.00
First	OW423	400.00
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: qairline
--

COPY public."Users" ("UserID", "Username", "Password", "Role") FROM stdin;
UWXV18946	admin	$2b$10$bEuWOizrEX3Ex5xTqDWdVueXrvrkZuFIA6jPMKeunAIgbybNpwBxK	admin
UOKXH7744	bott	$2b$10$n.MyNhk.OMYBUmHd0T5Z1OPBWEnZa/Us5iAG2mZFiiheZrqQLQjum	User
UYFBD2326	lanlehoang	$2b$10$l5gKoFrYastgbJAnIRQAZOdlpw3vLh/6avBxtlrN5K1vrUHn16DSC	User
UK4A51019	lanlehoang1	$2b$10$AyIhXoKYi2mgRjztvD7cselg/12LM1hc2LvxM/6X2dPBqPEbFrIHC	User
UHIFT4197	hoanglan123	$2b$10$laYbebSFloCklA2/WkzyIO89WAaexxVtd2d63CnDlLFERz39/fEWe	User
UFUDM7208	user	$2b$10$8zTrRXPi2iTWQSYvsrst6OdrmNUfZABpPJ.VQgLNVa5qGPZkP3hj6	User
\.


--
-- Name: Aircraft Aircraft_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Aircraft"
    ADD CONSTRAINT "Aircraft_pkey" PRIMARY KEY ("AircraftID");


--
-- Name: Airport Airport_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Airport"
    ADD CONSTRAINT "Airport_pkey" PRIMARY KEY ("AirportID");


--
-- Name: Banner Banner_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Banner"
    ADD CONSTRAINT "Banner_pkey" PRIMARY KEY ("BannerID");


--
-- Name: FlightSeat FlightSeat_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."FlightSeat"
    ADD CONSTRAINT "FlightSeat_pkey" PRIMARY KEY ("FlightID", "SeatNo");


--
-- Name: Flight Flight_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Flight"
    ADD CONSTRAINT "Flight_pkey" PRIMARY KEY ("FlightID");


--
-- Name: Passenger Passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Passenger"
    ADD CONSTRAINT "Passenger_pkey" PRIMARY KEY ("PassID");


--
-- Name: Promotion Promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Promotion"
    ADD CONSTRAINT "Promotion_pkey" PRIMARY KEY ("PromotionID");


--
-- Name: Seat Seat_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_pkey" PRIMARY KEY ("AircraftID", "SeatNo");


--
-- Name: TicketClass TicketClass_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."TicketClass"
    ADD CONSTRAINT "TicketClass_pkey" PRIMARY KEY ("ClassName", "FlightID");


--
-- Name: Ticket Ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Ticket"
    ADD CONSTRAINT "Ticket_pkey" PRIMARY KEY ("TicketID");


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("UserID");


--
-- Name: FlightSeat FlightSeat_FlightID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."FlightSeat"
    ADD CONSTRAINT "FlightSeat_FlightID_fkey" FOREIGN KEY ("FlightID") REFERENCES public."Flight"("FlightID") ON UPDATE CASCADE;


--
-- Name: FlightSeat FlightSeat_TicketID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."FlightSeat"
    ADD CONSTRAINT "FlightSeat_TicketID_fkey" FOREIGN KEY ("TicketID") REFERENCES public."Ticket"("TicketID") ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Flight Flight_AircraftID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Flight"
    ADD CONSTRAINT "Flight_AircraftID_fkey" FOREIGN KEY ("AircraftID") REFERENCES public."Aircraft"("AircraftID") ON UPDATE CASCADE;


--
-- Name: Flight Flight_DepID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Flight"
    ADD CONSTRAINT "Flight_DepID_fkey" FOREIGN KEY ("DepID") REFERENCES public."Airport"("AirportID") ON UPDATE CASCADE;


--
-- Name: Flight Flight_DestID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Flight"
    ADD CONSTRAINT "Flight_DestID_fkey" FOREIGN KEY ("DestID") REFERENCES public."Airport"("AirportID") ON UPDATE CASCADE;


--
-- Name: Passenger Passenger_GuardianID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Passenger"
    ADD CONSTRAINT "Passenger_GuardianID_fkey" FOREIGN KEY ("GuardianID") REFERENCES public."Passenger"("PassID") ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Seat Seat_AircraftID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_AircraftID_fkey" FOREIGN KEY ("AircraftID") REFERENCES public."Aircraft"("AircraftID") ON UPDATE CASCADE;


--
-- Name: TicketClass TicketClass_FlightID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."TicketClass"
    ADD CONSTRAINT "TicketClass_FlightID_fkey" FOREIGN KEY ("FlightID") REFERENCES public."Flight"("FlightID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Ticket Ticket_FlightID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Ticket"
    ADD CONSTRAINT "Ticket_FlightID_fkey" FOREIGN KEY ("FlightID") REFERENCES public."Flight"("FlightID") ON UPDATE CASCADE;


--
-- Name: Ticket Ticket_PassID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: qairline
--

ALTER TABLE ONLY public."Ticket"
    ADD CONSTRAINT "Ticket_PassID_fkey" FOREIGN KEY ("PassID") REFERENCES public."Passenger"("PassID") ON UPDATE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: qairline
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO qairline;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO qairline;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO qairline;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO qairline;


--
-- PostgreSQL database dump complete
--

