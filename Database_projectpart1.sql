-- Entity Tables

CREATE TABLE Travelers (
    Traveler_ID INT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Phone_Number VARCHAR(20),
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    Country VARCHAR(50),
    Zipcode VARCHAR(10)
    PRIMARY KEY (Traveler_ID)
);

CREATE TABLE Itinerary (
    Itinerary_ID INT,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Budget DECIMAL(10,2),
    PRIMARY KEY (Itinerary_ID),
    CHECK (Start_Date < End_Date)
    CHECK (Budget > 0)
);

CREATE TABLE Agency (
    Agency_ID INT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(20),
    PRIMARY KEY (Agency_ID),
    UNIQUE (Email),
    UNIQUE (Phone_Number)
);

CREATE TABLE Accommodation (
    Accommodation_ID INT,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(50),
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    Country VARCHAR(50),
    Zipcode VARCHAR(10),
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Accomondation_ID),
    UNIQUE (Name),
    CHECK (Price > 0)
);

CREATE TABLE Destination (
    Destination_ID INT,
    Name VARCHAR(255) NOT NULL,
    Airport VARCHAR(255),
    State VARCHAR(50),
    Country VARCHAR(50),
    Description TEXT,
    PRIMARY KEY (Destination_ID)
);

CREATE TABLE Flight (
    Flight_ID VARCHAR(255),
    Airline VARCHAR(255) NOT NULL,
    Origin VARCHAR(255) NOT NULL,
    Destination VARCHAR(255) NOT NULL,
    Price DECIMAL(10,2),
    Arrival_Time TIMESTAMP,
    Departure_Time TIMESTAMP,
    PRIMARY KEY (Flight_ID),
    CHECK (Price > 0),
    CHECK (Arrival_Time > Departure_Time)
);

CREATE TABLE Activity (
    Activity_ID INT,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(50),
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    Country VARCHAR(50),
    Zipcode VARCHAR(10),
    Price DECIMAL(10,2)
    PRIMARY KEY (Activity_ID),
    CHECK (Price > 0)
);

-- Relationship Tables

CREATE TABLE Books (
    Traveler_ID INT,
    Itinerary_ID INT,
    Booking_Date DATE NOT NULL,
    PRIMARY KEY (Traveler_ID, Itinerary_ID),
    FOREIGN KEY (Traveler_ID) REFERENCES Travelers(Traveler_ID),
    FOREIGN KEY (Itinerary_ID) REFERENCES Itinerary(Itinerary_ID) 
);


CREATE TABLE Manage (
    Itinerary_ID INT,
    Agency_ID INT,
    PRIMARY KEY (Itinerary_ID, Agency_ID),
    FOREIGN KEY (Itinerary_ID) REFERENCES Itinerary(Itinerary_ID),
    FOREIGN KEY (Agency_ID) REFERENCES Agency(Agency_ID)
);

CREATE TABLE Includes_Accomodation (
    Itinerary_ID INT,
    Accommodation_ID INT,
    Destination_ID INT,
    Checkin_Date DATE NOT NULL,
    Checkout_Date DATE NOT NULL,
    PRIMARY KEY (Itinerary_ID, Accommodation_ID, Destination_ID),
    FOREIGN KEY (Itinerary_ID) REFERENCES Itinerary(Itinerary_ID),
    FOREIGN KEY (Accommodation_ID) REFERENCES Accommodation(Accommodation_ID),
    FOREIGN KEY (Destination_ID) REFERENCES Destination(Destination_ID),
    CHECK (Checkout_Date > Checkin_Date)
);

CREATE TABLE Includes_Flight (
    Itinerary_ID INT,
    Flight_ID VARCHAR(255),
    Destination_ID INT,
    PRIMARY KEY (Itinerary_ID, Flight_ID, Destination_ID),
    FOREIGN KEY (Itinerary_ID) REFERENCES Itinerary(Itinerary_ID),
    FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID),
    FOREIGN KEY (Destination_ID) REFERENCES Destination(Destination_ID)
);

CREATE TABLE Includes_Activities (
    Itinerary_ID INT,
    Activity_ID INT,
    Scheduled_Time TIMESTAMP NOT NULL,
    PRIMARY KEY (Itinerary_ID, Activity_ID),
    FOREIGN KEY (Itinerary_ID) REFERENCES Itinerary(Itinerary_ID),
    FOREIGN KEY (Activity_ID) REFERENCES Activity(Activity_ID) 
);