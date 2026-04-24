--Create the different table dimenssion tables, fact table and bridge table .
USE DATABASE MUSIC_DB;

CREATE SCHEMA IF NOT EXISTS star_schema;
USE SCHEMA star_schema;

CREATE OR REPLACE TABLE dim_track (
    track_id NUMBER PRIMARY KEY,
    track_name VARCHAR,
    composer VARCHAR
);

CREATE OR REPLACE TABLE dim_artist (
    artist_id NUMBER PRIMARY KEY,
    artist_name VARCHAR,
    birth_year NUMBER,
    country VARCHAR
);

CREATE OR REPLACE TABLE dim_album (
    album_id NUMBER PRIMARY KEY,
    album_title VARCHAR,
    artist_id NUMBER,
    prod_year NUMBER,
    cd_year NUMBER
);

CREATE OR REPLACE TABLE dim_genre (
    genre_id NUMBER PRIMARY KEY,
    genre_name VARCHAR
);

CREATE OR REPLACE TABLE dim_media_type (
    media_type_id NUMBER PRIMARY KEY,
    media_type_name VARCHAR
);

CREATE OR REPLACE TABLE dim_playlist (
    playlist_id NUMBER PRIMARY KEY,
    playlist_name VARCHAR
);

CREATE OR REPLACE TABLE fact_music (
    music_id NUMBER IDENTITY (1,1),
    track_id NUMBER,
    album_id NUMBER,
    artist_id NUMBER,
    genre_id NUMBER,
    media_type_id NUMBER,
    milliseconds NUMBER,
    bytes NUMBER,
    unit_price NUMBER
);

CREATE OR REPLACE TABLE bridge_playlist_track (
    playlist_id NUMBER,
    track_id NUMBER,
    PRIMARY KEY (playlist_id, track_id)
);

-- Populate dimension tables
INSERT INTO dim_track (track_id, track_name, composer)
SELECT "TrackId", "Name", "Composer"
FROM MUSIC_DB.PUBLIC.TRACK;

INSERT INTO dim_artist (artist_id, artist_name, birth_year, country)
SELECT "ArtistId", "Name", "Birthyear", "Country"
FROM MUSIC_DB.PUBLIC.ARTIST;

INSERT INTO dim_album (album_id, album_title, artist_id, prod_year, cd_year)
SELECT "AlbumId", "Title", "ArtistId", "Prod year", "Cd year"
FROM MUSIC_DB.PUBLIC.ALBUM;

INSERT INTO dim_genre (genre_id, genre_name)
SELECT "GenreId", "Name"
FROM MUSIC_DB.PUBLIC.GENRE;

INSERT INTO dim_media_type (media_type_id, media_type_name)
SELECT "MediaTypeId", "Name"
FROM MUSIC_DB.PUBLIC.MEDIATYPE;

INSERT INTO dim_playlist (playlist_id, playlist_name)
SELECT "PlaylistId", "Name"
FROM MUSIC_DB.PUBLIC.PLAYLIST;

-- Populate fact table
INSERT INTO fact_music (track_id, album_id, artist_id, genre_id, media_type_id, milliseconds, bytes, unit_price)
SELECT
    t."TrackId",
    t."AlbumId",
    a."ArtistId",
    t."GenreId",
    t."MediaTypeId",
    t."Milliseconds",
    t."Bytes",
    t."UnitPrice"
FROM MUSIC_DB.PUBLIC.TRACK t
JOIN MUSIC_DB.PUBLIC.ALBUM a ON t."AlbumId" = a."AlbumId";

-- Populate bridge table
INSERT INTO bridge_playlist_track (playlist_id, track_id)
SELECT "PlaylistId", "TrackId"
FROM MUSIC_DB.PUBLIC.PLAYLISTTRACK;

