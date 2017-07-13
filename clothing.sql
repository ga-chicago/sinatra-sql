-- psql -a -f clothing.sql

CREATE DATABASE clothing;

\c clothing;

CREATE TABLE ascots (id SERIAL PRIMARY KEY, brand VARCHAR(255), pattern VARCHAR(255), image_url VARCHAR(255), price DECIMAL);

INSERT INTO ascots (brand, pattern, image_url, price) VALUES ('Gucci', 'Tiny Anchors', 'http://ep.yimg.com/ay/yhst-73404718658914/day-ascot-cravat-tie-100-nauticalblue-3.gif', 200.00);
