

CREATE DATABASE MyDatabase;
USE MyDatabase;

#таблица1
CREATE TABLE Users (
 UserID INT AUTO_INCREMENT PRIMARY KEY,
 Username VARCHAR(50) NOT NULL UNIQUE,
 Email VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO Users (Username, Password, Email) VALUES 
('user1', 'hashed_password1', 'user1@example.com'),
('user2', 'hashed_password2', 'user2@example.com'),
('user3', 'hashed_password3', 'user3@example.com');

#таблица2
CREATE TABLE Posts (
 PostID INT AUTO_INCREMENT PRIMARY KEY,
 UserID INT,
 Title VARCHAR(255), 
 Content TEXT,
 CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (UserID) REFERENCES Users(UserID)
 
);

INSERT INTO Posts (UserID, Title, Content) VALUES 
(1, 'First Post by User1', 'Hello World from User1!'),
(1, 'Second Post by User1', 'Another post by User1.'),
(2, 'First Post by User2', 'Hello from User2!'),
(3, 'First Post by User3', 'Hello from User3!'),
(2, 'Second Post by User2', 'User2 is here!');

#таблица3
CREATE TABLE Comments (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    PostID INT,
    UserID INT,
    Content TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PostID) REFERENCES Posts(PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
  
);

INSERT INTO Comments (PostID, UserID, Content) VALUES
(1, 2, 'Great post!'),
(1, 3, 'Thanks for sharing!'),
(2, 1, 'Nice to see another post!'),
(3, 1, 'Interesting thoughts!'),
(4, 2, 'Welcome to the platform!'),
(5, 3, 'User2, great to see you here!');



SELECT * FROM Users;
SELECT * FROM  Posts;
SELECT * FROM Comments;

SELECT * FROM Posts WHERE UserID = 1 ORDER BY CreatedAt DESC LIMIT 10;

#выборка данных из нескольких таблиц, которая покажет все посты вместе с комментариями, автором поста и автором комментария

SELECT 
    p.PostID,
    p.Title,
    p.Content AS PostContent,
    p.CreatedAt AS PostCreatedAt,
    u1.Username AS PostAuthor,
    c.Content AS CommentContent,
    c.CreatedAt AS CommentCreatedAt,
    u2.Username AS CommentAuthor
FROM 
    Posts p
LEFT JOIN 
    Users u1 ON p.UserID = u1.UserID
LEFT JOIN 
    Comments c ON p.PostID = c.PostID
LEFT JOIN 
    Users u2 ON c.UserID = u2.UserID
ORDER BY 
    p.CreatedAt DESC, c.CreatedAt ASC;
    
SELECT UPPER(Username) FROM Users;
SELECT SUBSTRING( 'Great post' ,8);
 SELECT LENGTH( 'Nice to see another post!');
 SELECT COUNT(*) FROM Posts;
SELECT SUM('Second Post by User2');
 SELECT DATE_FORMAT(CreatedAt, '%Y-%m-%d') FROM Posts;
 
#количество постов от каждого пользователя 
SELECT UserID, COUNT(*) AS PostCount 
FROM Posts 
GROUP BY UserID;

# посты, отсортированные по дате создания
SELECT * FROM Posts ORDER BY CreatedAt DESC;



