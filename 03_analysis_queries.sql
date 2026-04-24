USE DATABASE MUSIC_DB;
USE SCHEMA star_schema;

--1. Give the titles of the albums that have more than 1 CD.
SELECT album_title
FROM dim_album
WHERE cd_year > 1;

--2. Give the pieces produced in 2000 or in 2002.
SELECT t.track_name, a.prod_year
FROM fact_music f
JOIN dim_track t on t.track_id = f.track_id
JOIN dim_album a on a.album_id = f.album_id
WHERE prod_year IN (2000, 2002);

--3. Give the name and the composer of Rock and Jazz pieces.
SELECT t.track_name, t.Composer, g.genre_name
FROM fact_music f 
JOIN dim_track t ON t.track_id = f.track_id
JOIN dim_genre g ON g.genre_id = f.genre_id
WHERE g.genre_name = 'Rock' OR g.genre_name = 'Jazz'
ORDER BY genre_name, track_name;

--4. Give the 10 longest albums.
SELECT 
    a.album_id, a.album_title, 
    SUM(f.milliseconds) AS total_duration
FROM fact_music f
JOIN dim_album a ON a.album_id = f.album_id
GROUP BY a.album_id, a.album_title
ORDER BY total_duration DESC
LIMIT 10;

--5. Provide the number of albums produced for each artist.
SELECT 
    ar.artist_id, ar.artist_name, 
    COUNT(a.album_id) AS number_of_albums
FROM dim_album a 
JOIN dim_artist ar ON ar.artist_id = a.artist_id
GROUP BY ar.artist_id, ar.artist_name
ORDER BY number_of_albums DESC;

--6. Give the number of pieces produced by each artist.
SELECT ar.artist_name, COUNT(f.track_id) AS number_of_tracks
FROM fact_music f 
JOIN dim_album a ON a.album_id = f.album_id
JOIN dim_artist ar ON ar.artist_id = a.artist_id
GROUP BY ar.artist_name
ORDER BY number_of_tracks DESC;

--7. Give the most listened to music genre in the 2000s.
SELECT 
    g.genre_name,
    COUNT(f.track_id) AS number_of_tracks
FROM fact_music f 
JOIN dim_genre g ON g.genre_id = f.genre_id
JOIN dim_album a ON a.album_id = f.album_id
WHERE a.prod_year BETWEEN 2000 AND 2009
GROUP BY g.genre_name
ORDER BY number_of_tracks DESC
LIMIT 1;

--8. Give the names of all the playlists that contain tracks longer than 4 minutes.
SELECT DISTINCT p.playlist_name
FROM fact_music f 
JOIN bridge_playlist_track b ON b.track_id = f.track_id
JOIN dim_playlist p ON p.playlist_id = b.playlist_id
WHERE f.milliseconds > 240000;

--9. Give the Rock pieces whose artists are in France.
SELECT t.track_name, g.genre_name, ar.artist_name, ar.country
FROM fact_music f
JOIN dim_track t ON t.track_id = f.track_id
JOIN dim_genre g ON g.genre_id = f.genre_id
JOIN dim_album a ON a.album_id = f.album_id
JOIN dim_artist ar ON ar.artist_id = a.artist_id
WHERE ar.country = 'France' AND g.genre_name LIKE 'Rock%'
ORDER BY t.track_name;

--10 Give the average size of the pieces by musical genre
SELECT 
    g.genre_name,
    AVG(f.bytes) AS average_size_tracks
FROM fact_music f
JOIN dim_genre g ON g.genre_id = f.genre_id
GROUP BY g.genre_name
ORDER BY average_size_tracks DESC;

--11. Give the playlists that include tracks from artists born before 1990.
SELECT DISTINCT p.playlist_name
FROM fact_music f 
JOIN dim_album a ON a.album_id = f.album_id
JOIN dim_artist ar ON ar.artist_id = a.artist_id
JOIN bridge_playlist_track b ON b.track_id = f.track_id
JOIN dim_playlist p ON p.playlist_id = b.playlist_id
WHERE ar.birth_year < 1990
ORDER BY p.playlist_name;

