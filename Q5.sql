-- Create extension for postgis
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create the placemark table
CREATE TABLE my_placemarks
    (id serial primary key,
     name text,
     long real,
     lat real);

-- Insert all placemarks
INSERT INTO my_placemarks (name, lat, long)
VALUES ('Tutor Hall Cafe','34.019907','-118.289830'),
       ('Cafe Feat Illy','34.020991','-118.287241'),
       ('Law School Cafe','34.018755','-118.284529'),
       ('Literatea','34.020104','-118.283325'),
       ('Starbucks','34.021690','-118.282256'),
       ('Cromwell Field','34.022559','-118.288512'),
       ('Uytengsu Center','34.023917','-118.288427'),
       ('Lyon Center','34.024391','-118.288349'),
       ('Village Center','34.024823','-118.285939'),
       ('Merle Stadium','34.020185','-118.281463'),
       ('Doheny Library','34.020021','-118.283749'),
       ('VKC Library','34.021257','-118.284002'),
       ('Leavey Library','34.021708','-118.282788'),
       ('Hoose Library','34.018686','-118.286608'),
       ('Science Library','34.019598','-118.288794');


-- add a point column to my_placemarks table
SELECT AddGeometryColumn('my_placemarks', 'placemarks_geom', 4326, 'POINT', 2);

-- update point for tutor hall cafe
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.289830 34.019907)', 4326) 
WHERE id=1;

-- update point for cafe feat illy
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.287241 34.020991)', 4326) 
WHERE id=2;

-- update point for law school cafe
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.284529 34.018755)', 4326) 
WHERE id=3;

-- update point for literatea
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.283325 34.020104)', 4326) 
WHERE id=4;

-- update point for Starbucks
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.282256 34.021690)', 4326) 
WHERE id=5;

-- update point for Cromwell Field
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.288512 34.022559)', 4326)
WHERE id=6;

-- update point for Uytengsu Center
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.288427 34.023917)', 4326)
WHERE id=7;

-- update point for Lyon Center
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.288349 34.024391)', 4326)
WHERE id=8;

-- update point for Village Center
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.285939 34.024823)', 4326)
WHERE id=9;

-- update point for Merle Stadium
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.281463 34.020185)', 4326)
WHERE id=10;

-- update point for Doheny Library
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.283749 34.020021)', 4326)
WHERE id=11;

-- update point for VKC Library
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.284002 34.021257)', 4326)
WHERE id=12;

-- update point for Leavey Library
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.282788 34.021708)', 4326)
WHERE id=13;

-- update point for Hoose Library
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.286608 34.018686)', 4326)
WHERE id=14;

-- update point for Science Library
UPDATE my_placemarks SET placemarks_geom=ST_GeomFromText('POINT(-118.288794 34.019598)', 4326)
WHERE id=15;

-- Compute Convex Hull
SELECT ST_AsText(ST_ConvexHull(ST_COLLECT(d.placemarks_geom)))
FROM my_placemarks AS d;

-- POLYGON((-118.286608 34.018686,-118.28983 34.019907,-118.288349 34.024391,-118.285939 34.024823,-118.282256 34.02169,-118.281463 34.020185,-118.284529 34.018755,-118.286608 34.018686))

-- Select 4 nearest to Cafe Feat Illy
SELECT name, placemarks_geom
FROM my_placemarks
WHERE id <> 2
ORDER BY placemarks_geom <-> st_setsrid(st_makepoint(-118.28724,34.020992),4326)
LIMIT 4;

-- Cromwell Field, Science Library, Hoose Library, Tutor Hall Cafe



