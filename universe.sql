-- Create database
CREATE DATABASE universe;

-- Connect to database
\c universe

-- Create galaxy_types table (fifth table requirement)
CREATE TABLE galaxy_types (
    galaxy_types_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    age_in_billions_of_years NUMERIC(5,1)
);

-- Create galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(40) UNIQUE NOT NULL,
    galaxy_types_id INT NOT NULL REFERENCES galaxy_types(galaxy_types_id),
    distance_from_earth_in_ly NUMERIC(10,2) NOT NULL,
    size_in_ly INT,
    has_black_hole BOOLEAN NOT NULL,
    is_visible_to_naked_eye BOOLEAN
);

-- Create star table
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(40) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    temperature_kelvin INT NOT NULL,
    mass_solar_masses NUMERIC(8,2),
    is_binary BOOLEAN NOT NULL,
    age_in_millions_of_years INT
);

-- Create planet table
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(40) UNIQUE NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id),
    orbital_period_days NUMERIC(10,2),
    mass_earth_masses NUMERIC(10,2),
    has_atmosphere BOOLEAN NOT NULL,
    is_potentially_habitable BOOLEAN NOT NULL,
    mean_temperature_celsius INT
);

-- Create moon table
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(40) UNIQUE NOT NULL,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    orbital_period_days NUMERIC(10,2),
    diameter_km INT,
    has_atmosphere BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL
);

-- Insert data into galaxy_types
INSERT INTO galaxy_types (name, description, age_in_billions_of_years) VALUES
('Spiral', 'Characterized by a central bulge surrounded by a disk of stars, gas and dust in a spiral pattern', 13.6),
('Elliptical', 'Characterized by smooth, featureless light distribution and appear as ellipses in images', 13.0),
('Irregular', 'Galaxy that does not have a distinct regular shape', 13.2),
('Lenticular', 'Intermediate between spiral and elliptical galaxies', 12.5);

-- Insert data into galaxy
INSERT INTO galaxy (name, galaxy_types_id, distance_from_earth_in_ly, size_in_ly, has_black_hole, is_visible_to_naked_eye) VALUES
('Milky Way', 1, 0.00, 100000, TRUE, TRUE),
('Andromeda', 1, 2537000.00, 220000, TRUE, TRUE),
('Triangulum', 1, 2730000.00, 60000, FALSE, TRUE),
('Large Magellanic Cloud', 3, 163000.00, 14000, FALSE, TRUE),
('Small Magellanic Cloud', 3, 200000.00, 7000, FALSE, TRUE),
('Centaurus A', 2, 13050000.00, 60000, TRUE, FALSE);

-- Insert data into star
INSERT INTO star (name, galaxy_id, temperature_kelvin, mass_solar_masses, is_binary, age_in_millions_of_years) VALUES
('Sun', 1, 5778, 1.00, FALSE, 4600),
('Proxima Centauri', 1, 3042, 0.12, TRUE, 4850),
('Alpha Centauri A', 1, 5790, 1.10, TRUE, 4850),
('Sirius A', 1, 9940, 2.02, TRUE, 242),
('Betelgeuse', 1, 3600, 16.50, FALSE, 8),
('Vega', 1, 9602, 2.10, FALSE, 455);

-- Insert data into planet
INSERT INTO planet (name, star_id, orbital_period_days, mass_earth_masses, has_atmosphere, is_potentially_habitable, mean_temperature_celsius) VALUES
('Mercury', 1, 87.97, 0.055, FALSE, FALSE, 167),
('Venus', 1, 224.70, 0.815, TRUE, FALSE, 464),
('Earth', 1, 365.26, 1.000, TRUE, TRUE, 15),
('Mars', 1, 686.98, 0.107, TRUE, FALSE, -63),
('Jupiter', 1, 4332.59, 317.800, TRUE, FALSE, -110),
('Saturn', 1, 10759.22, 95.159, TRUE, FALSE, -140),
('Uranus', 1, 30688.50, 14.536, TRUE, FALSE, -195),
('Neptune', 1, 60195.00, 17.147, TRUE, FALSE, -200),
('Proxima Centauri b', 2, 11.20, 1.070, TRUE, TRUE, -39),
('Proxima Centauri c', 2, 1928.00, 7.000, FALSE, FALSE, -234),
('Alpha Centauri Bb', 3, 3.24, 1.130, TRUE, FALSE, 1500),
('Sirius b companion', 4, 50.13, 0.980, TRUE, FALSE, 150);

-- Insert data into moon
INSERT INTO moon (name, planet_id, orbital_period_days, diameter_km, has_atmosphere, is_spherical) VALUES
('Moon', 3, 27.32, 3475, FALSE, TRUE),
('Phobos', 4, 0.32, 22, FALSE, FALSE),
('Deimos', 4, 1.26, 12, FALSE, FALSE),
('Io', 5, 1.77, 3642, TRUE, TRUE),
('Europa', 5, 3.55, 3122, FALSE, TRUE),
('Ganymede', 5, 7.15, 5268, FALSE, TRUE),
('Callisto', 5, 16.69, 4821, FALSE, TRUE),
('Titan', 6, 15.95, 5150, TRUE, TRUE),
('Enceladus', 6, 1.37, 504, FALSE, TRUE),
('Mimas', 6, 0.94, 396, FALSE, TRUE),
('Triton', 8, 5.88, 2707, TRUE, TRUE),
('Naiad', 8, 0.29, 58, FALSE, TRUE),
('Thalassa', 8, 0.31, 81, FALSE, TRUE),
('Despina', 8, 0.33, 150, FALSE, TRUE),
('Galatea', 8, 0.43, 174, FALSE, TRUE),
('Larissa', 8, 0.55, 194, FALSE, TRUE),
('Proteus', 8, 1.12, 420, FALSE, TRUE),
('Nereid', 8, 360.13, 340, FALSE, TRUE),
('Halimede', 8, 1879.08, 62, FALSE, TRUE),
('Sao', 8, 2914.07, 44, FALSE, TRUE);
