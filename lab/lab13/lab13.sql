.read data.sql
CREATE TABLE bluedog AS
SELECT color,
       pet
FROM students
WHERE color="blue"
    AND pet="dog";


CREATE TABLE bluedog_songs AS
SELECT color,
       pet,
       song
FROM students
WHERE color="blue"
    AND pet="dog";


CREATE TABLE matchmaker AS
SELECT s1.pet,
       s1.song,
       s1.color,
       s2.color
FROM students AS s1,
     students AS s2
WHERE s1.pet = s2.pet
    AND s1.song = s2.song
    AND s1.time < s2.time;


CREATE TABLE sevens AS
SELECT stu.seven
FROM students AS stu,
     numbers AS num
WHERE stu.time = num.time
    AND stu.number = 7
    AND num."7"="True";


CREATE TABLE favpets AS
SELECT pet,
       count(*) AS number
FROM students
GROUP BY pet
ORDER BY number DESC
LIMIT 10;


CREATE TABLE dog AS
SELECT pet,
       count(*) AS number
FROM students
WHERE pet='dog';


CREATE TABLE bluedog_agg AS
SELECT song,
       count(*) AS number
FROM bluedog_songs
GROUP BY song
ORDER BY number DESC;


CREATE TABLE instructor_obedience AS
SELECT seven,
       instructor,
       count(*)
FROM students
WHERE seven="7"
GROUP BY instructor;
