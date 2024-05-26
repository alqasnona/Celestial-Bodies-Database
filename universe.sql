psql --username=freecodecamp --dbname=postgres
CREATE DATABASE universe;
\c universe
-- Create galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    distance_from_earth NUMERIC
);

-- Create star table
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id),
    age_in_millions_of_years INT NOT NULL,
    type TEXT NOT NULL,
    has_planets BOOLEAN NOT NULL
);

-- Create planet table
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    star_id INT REFERENCES star(star_id),
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    age_in_millions_of_years INT,
    type TEXT NOT NULL
);

-- Create moon table
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    planet_id INT REFERENCES planet(planet_id),
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    distance_from_planet NUMERIC
);
-- Insert data into galaxy table
INSERT INTO galaxy (name, description, has_life, is_spherical, distance_from_earth) VALUES
('Milky Way', 'Our home galaxy', TRUE, TRUE, 0),
('Andromeda', 'Nearest spiral galaxy', TRUE, TRUE, 2537000),
('Triangulum', 'Third largest galaxy in Local Group', FALSE, TRUE, 3000000),
('Whirlpool', 'Face-on spiral galaxy', FALSE, TRUE, 23000000),
('Sombrero', 'Bright galaxy with a large bulge', FALSE, TRUE, 29000000),
('Messier 87', 'Giant elliptical galaxy', FALSE, TRUE, 53000000);

-- Insert data into star table
INSERT INTO star (name, galaxy_id, age_in_millions_of_years, type, has_planets) VALUES
('Sun', 1, 4600, 'G-type', TRUE),
('Alpha Centauri', 1, 5500, 'G-type', TRUE),
('Betelgeuse', 1, 8500, 'Red supergiant', FALSE),
('Sirius', 2, 300, 'A-type', TRUE),
('Vega', 2, 455, 'A-type', TRUE),
('Rigel', 2, 800, 'Blue supergiant', FALSE);

-- Insert data into planet table
INSERT INTO planet (name, star_id, has_life, is_spherical, age_in_millions_of_years, type) VALUES
('Earth', 1, TRUE, TRUE, 4500, 'Terrestrial'),
('Mars', 1, FALSE, TRUE, 4500, 'Terrestrial'),
('Venus', 1, FALSE, TRUE, 4500, 'Terrestrial'),
('Jupiter', 1, FALSE, TRUE, 4500, 'Gas giant'),
('Saturn', 1, FALSE, TRUE, 4500, 'Gas giant'),
('Uranus', 1, FALSE, TRUE, 4500, 'Ice giant'),
('Neptune', 1, FALSE, TRUE, 4500, 'Ice giant'),
('Proxima b', 2, FALSE, TRUE, 0, 'Terrestrial'),
('Sirius B', 4, FALSE, TRUE, 300, 'White dwarf'),
('Vega B', 5, FALSE, TRUE, 455, 'Terrestrial'),
('Betelgeuse I', 3, FALSE, TRUE, 8500, 'Terrestrial'),
('Rigel B', 6, FALSE, TRUE, 800, 'Gas giant'),
('Kepler-22b', 1, FALSE, TRUE, 4500, 'Super-Earth'),
('Gliese 581g', 2, FALSE, TRUE, 4500, 'Super-Earth');

-- Insert data into moon table
INSERT INTO moon (name, planet_id, has_life, is_spherical, distance_from_planet) VALUES
('Moon', 1, FALSE, TRUE, 0.384),
('Phobos', 2, FALSE, TRUE, 0.0009),
('Deimos', 2, FALSE, TRUE, 0.0023),
('Io', 4, FALSE, TRUE, 0.4217),
('Europa', 4, FALSE, TRUE, 0.671),
('Ganymede', 4, FALSE, TRUE, 1.07),
('Callisto', 4, FALSE, TRUE, 1.88),
('Titan', 5, FALSE, TRUE, 1.222),
('Enceladus', 5, FALSE, TRUE, 0.238),
('Mimas', 5, FALSE, TRUE, 0.185),
('Triton', 7, FALSE, TRU E, 0.355),
('Nereid', 7, FALSE, TRUE, 5.51),
('Charon', 8, FALSE, TRUE, 0.0186),
('Proxima B I', 8, FALSE, TRUE, 0.02),
('Betelgeuse I', 11, FALSE, TRUE, 0.04),
('Betelgeuse II', 11, FALSE, TRUE, 0.05),
('Rigel B I', 12, FALSE, TRUE, 0.06),
('Rigel B II', 12, FALSE, TRUE, 0.07),
('Rigel B III', 12, FALSE, TRUE, 0.08),
('Vega B I', 10, FALSE, TRUE, 0.09),
('Kepler-22b I', 13, FALSE, TRUE, 0.10),
('Gliese 581g I', 14, FALSE, TRUE, 0.11);

-- Create a comet table
CREATE TABLE comet (
    comet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id),
    period INT NOT NULL,
    has_tail BOOLEAN NOT NULL,
    size NUMERIC
);

-- Insert data into comet table
INSERT INTO comet (name, galaxy_id, period, has_tail, size) VALUES
('Halley', 1, 76, TRUE, 11),
('Hale-Bopp', 1, 2533, TRUE, 40),
('Encke', 1, 3, TRUE, 4.8);

pg_dump -cC --inserts -U freecodecamp universe > universe.sql
