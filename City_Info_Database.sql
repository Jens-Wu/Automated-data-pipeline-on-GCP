-- Create the database
CREATE DATABASE cities_info;

-- Use the database
USE cities_info;

-- Create the 'city_names' table
CREATE TABLE city_names (
    city_id INT AUTO_INCREMENT, -- Automatically generated ID for each city
    City VARCHAR(255) NOT NULL, -- Name of the city
    PRIMARY KEY (city_id) -- Primary key to uniquely identify each city
);

-- Create the 'population' table
CREATE TABLE population (
    pop_id INT AUTO_INCREMENT, -- Automatically generated ID for each population
    Population INT , -- population of city
    Date_Data_retrieved DATETIME, -- Timestamp when data last retieved
    city_id INT, -- ID of the related city
    PRIMARY KEY (pop_id), -- Primary key to uniquely identify each population
    FOREIGN KEY (city_id) REFERENCES city_names(city_id) -- Foreign key to connect each population to its city
);

-- Create the 'geo' table
CREATE TABLE geo (
    geo_id INT AUTO_INCREMENT, -- Automatically generated ID for each geo
    Latitude FLOAT , -- latitude of city
    Longitude FLOAT , -- longitude of city
    city_id INT, -- ID of the related city
    PRIMARY KEY (geo_id), -- Primary key to uniquely identify each geo
    FOREIGN KEY (city_id) REFERENCES city_names(city_id) -- Foreign key to connect each geo to its city
);

-- Create the 'weather' table
CREATE TABLE weather (
    temperature_deg_C FLOAT , -- temperature of city
    temp_min_deg_C FLOAT , 
    temp_max_deg_C FLOAT ,
    pressure_in_hPa INT ,
    humidity_in_percent INT ,
    weather_info VARCHAR(120) ,
    weather_desc VARCHAR(255) ,
    wind_speed_in_m_per_sec FLOAT ,
    wind_direction_in_deg INT ,
    rain_probability FLOAT ,
    rain_last_3h_in_mm FLOAT ,
    dt_txt DATETIME ,
    city_id INT, -- ID of the related city
    timestamp_data_retrieved DATETIME ,
    PRIMARY KEY (city_id, dt_txt, timestamp_data_retrieved), 
    FOREIGN KEY (city_id) REFERENCES city_names(city_id) -- Foreign key to connect each population to its city
);

-- Create the 'flight' table
CREATE TABLE flight (
    origin VARCHAR(120) ,
    expected_arrival_time DATETIME ,
    flight_status VARCHAR(120) ,
    icao VARCHAR(120) ,
    flight_number VARCHAR(120) ,
    city_id INT, -- ID of the related city
    PRIMARY KEY (flight_number, expected_arrival_time),
    FOREIGN KEY (city_id) REFERENCES city_names(city_id) -- Foreign key to connect each population to its city
);

-- Create the 'airport' table
CREATE TABLE airport (
    icao VARCHAR(10) , -- ICAO code for each city
    city_id INT, -- ID of the related city
    PRIMARY KEY (icao),
    FOREIGN KEY (city_id) REFERENCES city_names(city_id) -- Foreign key to connect each population to its city
);