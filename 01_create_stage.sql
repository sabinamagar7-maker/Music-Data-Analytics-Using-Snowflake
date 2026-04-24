--PART 1 : Creating warehouse, database, schema, stage, tables and loading the tables with the datasets .


-- Use warehouse
USE WAREHOUSE WAREHOUSE_MUSIC;

-- Create and use a database
CREATE DATABASE IF NOT EXISTS MUSIC_DB;
USE DATABASE MUSIC_DB;
USE SCHEMA PUBLIC;

-- Stage creation for S3 music dataset
CREATE STAGE s3_music
URL= 's3://course-snowflakes/sample/music/';

LIST @s3_music

--create a csv formt for schema inference 
CREATE OR REPLACE FILE FORMAT infer_csv_format
  TYPE = 'CSV'
  PARSE_HEADER = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY = '"';
-- check columns in s3_music datasets  
SELECT * FROM TABLE(
  INFER_SCHEMA(
    LOCATION => '@s3_music/Track.csv',
    FILE_FORMAT => 'infer_csv_format',
    IGNORE_CASE => TRUE
  )
);

--Create table Track
CREATE OR REPLACE TABLE Track(
     "TrackId" number, 
     "Name" varchar,
     "MediaTypeId" number,
     "GenreId" number,
     "AlbumId" number,
     "Composer" varchar,
     "Milliseconds" number,
     "Bytes" number,
     "UnitPrice" number
); 

--Create table Album
CREATE OR REPLACE TABLE Album(
    "AlbumId" number , 
    "Title" varchar ,
    "ArtistId" number ,
    "Prod year" number ,
    "Cd year" number 
);

--Create table Artist
CREATE OR REPLACE TABLE Artist(
    "ArtistId" number,
    "Name" varchar ,
    "Birthyear" number ,
    "Country" varchar 
);

--Create table MediaType
CREATE OR REPLACE TABLE MediaType(
    "MediaTypeId" number ,
    "Name" varchar 
);

--Create table Genre
CREATE OR REPLACE TABLE Genre(
    "GenreId" number ,
    "Name" varchar 
);

--Create table Playlist
CREATE OR REPLACE TABLE Playlist(
    "PlaylistId" number,
    "Name" varchar 
);

--Create table PlaylistTrack
CREATE OR REPLACE TABLE PlaylistTrack(
    "PlaylistId" number,
    "TrackId" number  
);
--Creating a file format for copy into 
CREATE OR REPLACE FILE FORMAT CLASSIC_CSV
  TYPE = 'CSV'
  COMPRESSION = 'AUTO'
  RECORD_DELIMITER = '\n'
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  DATE_FORMAT = 'AUTO'
  TIMESTAMP_FORMAT = 'AUTO'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  TRIM_SPACE = FALSE
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
  ESCAPE = 'NONE'
  ESCAPE_UNENCLOSED_FIELD = '\134'
  NULL_IF = ('\\N');

--Data ingestion: load the table using COPY INTO
--load all tables 
COPY INTO Album FROM @s3_music/Album.csv FILE_FORMAT = 'CLASSIC_CSV';
COPY INTO Artist FROM @s3_music/Artist.csv FILE_FORMAT = 'CLASSIC_CSV';
COPY INTO Genre FROM @s3_music/Genre.csv FILE_FORMAT = 'CLASSIC_CSV';
COPY INTO MediaType FROM @s3_music/MediaType.csv FILE_FORMAT = 'CLASSIC_CSV';
COPY INTO Playlist FROM @s3_music/Playlist.csv FILE_FORMAT = 'CLASSIC_CSV';
COPY INTO PlaylistTrack FROM @s3_music/PlaylistTrack.csv FILE_FORMAT = 'CLASSIC_CSV';
COPY INTO Track FROM @s3_music/Track.csv FILE_FORMAT = 'CLASSIC_CSV';

select * from Track;