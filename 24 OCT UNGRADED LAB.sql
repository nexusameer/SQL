-- Create the database
CREATE DATABASE twitter;
USE twitter;

-- Create the Users table
CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    UserName VARCHAR(20) UNIQUE,  -- UNIQUE constraint to ensure no duplicate usernames
    Age INT,
    Country VARCHAR(20),
    privacy INT
);

-- Insert data into the Users table
INSERT INTO Users (User_ID, UserName, Age, Country, privacy) VALUES
(1, 'Ali123', 18, 'Pakistan', 1),
(2, 'Aliza', 40, 'USA', 1),
(3, 'Aysha', 19, 'Iran', 0),
(4, 'DonaldTrump', 60, 'USA', 0),
(5, 'ImranKhan', 55, 'Pakistan', 0),
(6, 'Natasha', 28, 'USA', 0),
(7, 'Samuel', 37, 'Australia', 0),
(8, 'Sara', 30, 'Iran', 1);

INSERT INTO USERS 
VALUES
(9, "AMEER", 23, 'PAKISTAN', 1);

-- Create the Following table
CREATE TABLE Following (
    FollowerUserName VARCHAR(20),
    FollowedUserName VARCHAR(20),
    PRIMARY KEY (FollowerUserName, FollowedUserName),
    FOREIGN KEY (FollowerUserName) REFERENCES Users(UserName),
    FOREIGN KEY (FollowedUserName) REFERENCES Users(UserName)
);

-- Insert data into the Following table
INSERT INTO Following (FollowerUserName, FollowedUserName) VALUES
('Ali123', 'DonaldTrump'),
('Aliza', 'Ali123'),
('Aliza', 'DonaldTrump'),
('Aliza', 'ImranKhan'),
('Aysha', 'ImranKhan'),
('DonaldTrump', 'ImranKhan'),
('ImranKhan', 'DonaldTrump'),
('Natasha', 'ImranKhan'),
('Samuel', 'DonaldTrump'),
('Samuel', 'ImranKhan'),
('Sara', 'DonaldTrump');

-- Create the Tweets table
CREATE TABLE Tweets (
    TweetID INT PRIMARY KEY,
    UserName VARCHAR(20),
    Text VARCHAR(140),
    FOREIGN KEY (UserName) REFERENCES Users(UserName)
);

-- Insert data into the Tweets table
INSERT INTO Tweets (TweetID, UserName, Text) VALUES
(1, 'Ali123', 'Pakistanís largest-ever population #Census starts today in 63 districts after 19 years.'),
(2, 'ImranKhan', 'Pakistanís largest-ever population #Census starts today in 63 districts after 19 years.'),
(3, 'Sara', 'Take the soldier who come to our door for #Census as A ThankYou from Pakistan Army for our devotion. #CensusWithSupportOfArmy'),
(4, 'ImranKhan', 'Pakistan is going to experience 6th #Census 2017.'),
(5, 'Sara', 'Only #census can reveal where this aunty lives'),
(6, 'ImranKhan', 'Quand tu te lËves 3h en avance (littÈralement) pour la #massecritique'),
(7, 'Sara', 'Over 1 million decrypted Gmail and Yahoo accounts allegedly up for sale on the Dark Web #piratage'),
(8, 'Sara', 'Harry pot-head and the Sorcerer''s stoned'),
(9, 'DonaldTrump', 'LSDespicable Me #DrugMovies'),
(10, 'ImranKhan', 'Forrest Bump #DrugMovies @midnight'),
(12, 'DonaldTrump', 'Quand tu te lËves 3h en avance (littÈralement) pour la #massecritique'),
(13, 'Sara', '#DrugMovies'),
(14, 'DonaldTrump', 'Quand tu te lËves 3h en avance (littÈralement) pour la #massecritique'),
(15, 'Aliza', 'Quand tu te lËves 3h en avance (littÈralement) pour la #massecritique');

-- Create the Likes table
CREATE TABLE Likes (
    TweetID INT,
    LikeByUserName VARCHAR(20),
    LikeOnDate DATE,
    PRIMARY KEY (TweetID, LikeByUserName),
    FOREIGN KEY (TweetID) REFERENCES Tweets(TweetID),
    FOREIGN KEY (LikeByUserName) REFERENCES Users(UserName)
);

-- Insert data into the Likes table
INSERT INTO Likes (TweetID, LikeByUserName, LikeOnDate) VALUES
(1, 'Aliza', '2023-10-20'),
(2, 'Aliza', '2023-10-20');

-- Create the Interests table
CREATE TABLE Interests (
    InterestID INT PRIMARY KEY,
    Description VARCHAR(30)
);

-- Insert data into the Interests table
INSERT INTO Interests (InterestID, Description) VALUES
(10, 'Politics'),
(11, 'Sports'),
(12, 'Movies'),
(13, 'Education'),
(14, 'Video Games');

-- Create the UserInterests table
CREATE TABLE UserInterests (
    UserName VARCHAR(20),
    InterestID INT,
    PRIMARY KEY (UserName, InterestID),
    FOREIGN KEY (UserName) REFERENCES Users(UserName),
    FOREIGN KEY (InterestID) REFERENCES Interests(InterestID)
);

-- Insert data into the UserInterests table
INSERT INTO UserInterests (UserName, InterestID) VALUES
('Ali123', 10),
('Ali123', 11),
('Ali123', 13),
('Ali123', 14),
('Aliza', 10),
('Aliza', 11),
('Aliza', 13),
('Aliza', 14),
('ImranKhan', 10);

-- Create the Hashtags table
CREATE TABLE Hashtags (
    HashtagID INT PRIMARY KEY,
    Hashtag VARCHAR(30)
);

-- Insert data into the Hashtags table
INSERT INTO Hashtags (HashtagID, Hashtag) VALUES
(1, '#Census'),
(2, '#ClassiqueMatin'),
(3, '#MasseCritique'),
(4, '#piratage'),
(5, '#DrugMovies');

-- Query to verify the data
SELECT * FROM Following;
SELECT * FROM Hashtags;
SELECT * FROM Interests;
SELECT * FROM Tweets;
SELECT * FROM UserInterests;
SELECT * FROM Users;



-- 1. What is maximum, minimum, average and standard deviation of ages
-- of the users? (Search Standard Dev function)

SELECT MAX(AGE), MIN(AGE), AVG(AGE), STDDEV(AGE) FROM USERS;

-- 2. Give name of the user who has the highest number of followers.

SELECT U.UserName, COUNT(F.FollowedUserName) AS FOLLOWERCOUNT FROM USERS AS U
JOIN FOLLOWING AS F ON U.USERNAME = F.FollowerUserName
GROUP BY U.USERNAME
ORDER BY FOLLOWERCOUNT DESC
LIMIT 1;

SELECT FOLLOWERUSERNAME , COUNT(FOLLOWEDUSERNAME) AS COUNTNAME FROM FOLLOWING 
GROUP BY FOLLOWERUSERNAME
ORDER BY COUNTNAME DESC LIMIT 1;
-- 3. Give name of the user who has second highest followers.

SELECT FOLLOWERUSERNAME , COUNT(FOLLOWEDUSERNAME) AS COUNTNAME FROM FOLLOWING 
GROUP BY FOLLOWERUSERNAME
ORDER BY COUNTNAME DESC LIMIT 1 OFFSET 1;


-- 4. List names of all the users who have never tweeted.

SELECT U.USERNAME FROM USERS AS U
LEFT JOIN 
TWEETS AS T ON T.USERNAME = U.USERNAME
WHERE T.USERNAME IS NULL;

-- 5. List all the hashtags and usernames and number of times that user
-- used that hashtag.
-- 6. Find the users who have never used the hashtag #Census.
-- THERE IS NOT ANY CONNECTION OF USER AND HASTAGS

-- 7. List all the usernames that have never been followed. Using Set
-- operation.

SELECT U.USERNAME FROM USERS AS U
LEFT JOIN 
FOLLOWING AS F ON F.FOLLOWERUSERNAME=U.USERNAME
WHERE F.FOLLOWEDUSERNAME IS NULL;

-- 8. List all the usernames that have never been followed. Using Exist
-- Clause.

SELECT U.USERNAME FROM USERS AS U
WHERE NOT EXISTS (SELECT 1 FROM FOLLOWING AS F WHERE U.USERNAME = F.FOLLOWERUSERNAME);

-- 9. Find the most common interest of users. (The interest with largest
-- number of users). Also find the least common interest.

SELECT USERNAME, MAX(INTERESTID) FROM USERINTERESTS
GROUP BY USERNAME
ORDER BY MAX(INTERESTID) DESC
LIMIT 1;

-- 10. Show total tweets per country. The result should be in order of country
-- name.

SELECT U.COUNTRY, COUNT(T.TWEETID) AS TOTALTWEETS FROM USERS AS U
LEFT JOIN
TWEETS AS T ON (T.USERNAME = U.USERNAME)
GROUP BY U.COUNTRY
ORDER BY U.COUNTRY;

-- 11. List names of all the users whose number of tweets is more than
-- average number of tweets per user.
SELECT U.COUNTRY, COUNT(T.TWEETID) AS TOTALTWEETS FROM USERS AS U
LEFT JOIN
TWEETS AS T ON (T.USERNAME = U.USERNAME)
WHERE AVG(TOTALTWEETS)>TOTALTWEETS
GROUP BY U.COUNTRY
ORDER BY U.COUNTRY;


-- 12. Give the name of the users who have at least one follower from
-- Pakistan.

SELECT FOLLOWEDUSERNAME, COUNT(FOLLOWEDUSERNAME) FROM FOLLOWING AS F
LEFT JOIN 
USERS AS U ON U.USERNAME = F.FOLLOWERUSERNAME
WHERE U.COUNTRY = 'PAKISTAN'
GROUP BY FOLLOWEDUSERNAME;

-- 13. Show the interest ID and description of interest with the most number
-- of users.

SELECT I.INTERESTID, I.Description, COUNT(UI.INTERESTID) AS USERCOUNT FROM INTERESTS AS I
LEFT JOIN USERINTERESTS AS UI ON I.INTERESTID = UI.InterestID
GROUP BY INTERESTID, DESCRIPTION
ORDER BY USERCOUNT DESC
LIMIT 1;




