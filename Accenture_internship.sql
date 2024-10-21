-- Create a database named Accenture
CREATE DATABASE Accenture;

-- Use the Accenture database
USE Accenture;

-- Explore the Content dataset
SELECT * FROM Content;

-- Drop column URL as it is irrelevant
ALTER TABLE Content
DROP COLUMN URL;

-- Create a new column named ContentType and populate it with Content column values. This is to ensure the column names is changed
ALTER TABLE Content
ADD ContentType  VARCHAR (MAX);

-- Populate it
UPDATE Content
SET ContentType = Type;

---Drop the old column; Type
ALTER TABLE Content
DROP COLUMN Type;

-- Explore the Content_ID column
SELECT Content_ID,
		COUNT(*) AS CNT
FROM Reactions
GROUP BY Content_ID
ORDER BY CNT DESC; -- There are no NULL values detected

-- Explore the Content_ID column
SELECT DISTINCT ContentType FROM Content;

-- In the Category column, replace Animals with animals to ensure consistency
UPDATE Content
SET Category = REPLACE(Category, 'Animals', 'animals' );

-- Explore the Reaction column
SELECT * FROM Reactions;

-- Change the datatype of Datetime column 
ALTER TABLE Reactions
ALTER COLUMN Datetime Date;

-- Create a new column named ReactionType and populate it with type column values. This is to ensure that the column names is changed
		--Create column
ALTER TABLE Reactions
ADD ReactionType VARCHAR (MAX);
		-- Populate column
UPDATE Reactions
SET ReactionType = Type;
		-- Drop the Type column
ALTER TABLE Reactions
DROP COLUMN Type;

				--USE THE DATA MODEL TO OBTAIN RELEVANT DATA FROM THE THREE DATASETS
-- Content: contentID & UserID
-- Reaction: contentID, UserID & ReactionType
-- ReactionTypes: Type(ReactionType)

SELECT * FROM Content;

SELECT * FROM Reactions;

SELECT * FROM ReactionTypes;

-- Columns that are relevant to our analysis
SELECT C.column1, C.Content_ID, C.User_ID, C.Category, C.ContentType, R.Datetime, R.ReactionType, RT.Sentiment, RT.Score  
FROM Reactions AS R
JOIN Content AS C ON R.Content_ID = C.Content_ID
JOIN ReactionTypes AS RT ON R.ReactionType = RT.Type;


-- Create a VIEW for this new table
CREATE VIEW ContentData AS
SELECT C.column1, C.Content_ID, C.User_ID, C.Category, C.ContentType, R.Datetime, R.ReactionType, RT.Sentiment, RT.Score  
FROM Reactions AS R
JOIN Content AS C ON R.Content_ID = C.Content_ID
JOIN ReactionTypes AS RT ON R.ReactionType = RT.Type;

-- Retrieve the new table
SELECT * 
FROM ContentData
ORDER BY Content_ID;
