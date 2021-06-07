
--
-- aspnet
--
CREATE TABLE users (
    id serial NOT NULL,
    password varchar(128) NOT NULL,
    username varchar(30) NOT NULL,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    email varchar(75) NOT NULL,
    CONSTRAINT "PK_users" PRIMARY KEY (id)
)

INSERT INTO users (id, email, first_name, last_name, password, username) VALUES ($1, $2, $3, $4, $5, $6)
parameters: $1 = '1', $2 = 'First0@Last0.com', $3 = 'First0', $4 = 'Last0', $5 = 'Pass0!', $6 = 'First0Last0'
INSERT INTO users (id, email, first_name, last_name, password, username) VALUES ($1, $2, $3, $4, $5, $6)
parameters: $1 = '2', $2 = 'First1@Last1.com', $3 = 'First1', $4 = 'Last1', $5 = 'Pass1!', $6 = 'First1Last1'

INSERT INTO users (id, email, first_name, last_name, password, username) VALUES ($1, $2, $3, $4, $5, $6)
parameters: $1 = '502', $2 = 'First501@Last501.com', $3 = 'First501', $4 = 'Last501', $5 = 'Pass501!', $6 = 'First501Last501'
INSERT INTO users (id, email, first_name, last_name, password, username) VALUES ($1, $2, $3, $4, $5, $6)
parameters: $1 = '503', $2 = 'First502@Last502.com', $3 = 'First502', $4 = 'Last502', $5 = 'Pass502!', $6 = 'First502Last502'

SELECT b.id, b.email, b.first_name, b.last_name, b.password, b.username FROM users AS b WHERE b.id = $1 LIMIT 2
parameters: $1 = '501'
SELECT b.id, b.email, b.first_name, b.last_name, b.password, b.username FROM users AS b WHERE b.id = $1 LIMIT 2
parameters: $1 = '502'

SELECT a.id, a.email, a.first_name, a.last_name, a.password, a.username FROM users AS a WHERE a.id = $1 LIMIT 1
DETAIL:  parameters: $1 = '502'
UPDATE users SET username = $1 WHERE id = $2
DETAIL:  parameters: $1 = 'Changed501', $2 = '502'
SELECT a.id, a.email, a.first_name, a.last_name, a.password, a.username FROM users AS a WHERE a.id = $1 LIMIT 1
DETAIL:  parameters: $1 = '503'
UPDATE users SET username = $1 WHERE id = $2
DETAIL:  parameters: $1 = 'Changed502', $2 = '503'

SELECT a.id, a.email, a.first_name, a.last_name, a.password, a.username FROM users AS a WHERE a.id = $1 LIMIT 1
parameters: $1 = '501'
DELETE FROM users WHERE id = $1
parameters: $1 = '501'

SELECT a.id, a.email, a.first_name, a.last_name, a.password, a.username FROM users AS a WHERE a.id = $1 LIMIT 1
parameters: $1 = '502'
DELETE FROM users WHERE id = $1
parameters: $1 = '502'

SELECT u.id, u.email, u.first_name, u.last_name, u.password, u.username FROM users AS u ORDER BY u.id LIMIT $1 OFFSET $2
parameters: $1 = '100', $2 = '0'
SELECT u.id, u.email, u.first_name, u.last_name, u.password, u.username FROM users AS u ORDER BY u.id LIMIT $1 OFFSET $2
parameters: $1 = '100', $2 = '100'

--
-- express
--
CREATE TABLE IF NOT EXISTS "users" (
    "id" serial NOT NULL PRIMARY KEY,
    "password" varchar(128) NOT NULL,
    "username" varchar(30) NOT NULL,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL
);
insert into "public"."users"("id","password","username","first_name","last_name","email") values('1','Pass0!','First0Last0','First0','Last0','First0@Last0.com'),('2','Pass1!','First1Last1','First1','Last1','First1@Last1.com')

INSERT INTO users ("id", "password", "username", "first_name", "last_name", "email") VALUES(502, 'Pass501!', 'First501Last501', 'First501', 'Last501', 'First501@Last501.com') RETURNING *
INSERT INTO users ("id", "password", "username", "first_name", "last_name", "email") VALUES(503, 'Pass502!', 'First502Last502', 'First502', 'Last502', 'First502@Last502.com') RETURNING *

SELECT * FROM users WHERE id = 502
UPDATE users SET (username) = ROW('Changed501') WHERE id = 502 RETURNING *
SELECT * FROM users WHERE id = 503
UPDATE users SET (username) = ROW('Changed502') WHERE id = 503 RETURNING *

SELECT * FROM users WHERE id = 501
SELECT * FROM users WHERE id = 502

UPDATE users SET (id,password,username,first_name,last_name,email) = ROW('502','Pass501!','Changed501','First501','Last501','First501@Last501.com') WHERE id = 502 RETURNING *
UPDATE users SET (id,password,username,first_name,last_name,email) = ROW('503','Pass502!','Changed502','First502','Last502','First502@Last502.com') WHERE id = 503 RETURNING *

DELETE FROM users WHERE id = 501
DELETE FROM users WHERE id = 502

SELECT * FROM users LIMIT 100 OFFSET 0
SELECT * FROM users LIMIT 100 OFFSET 100

--
-- django
--
CREATE TABLE "app_myuser" (
    "id" serial NOT NULL PRIMARY KEY,
    "password" varchar(128) NOT NULL,
    "username" varchar(30) NOT NULL,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL
)

BEGIN
INSERT INTO "app_myuser" ("id", "password", "username", "first_name", "last_name", "email") VALUES (1, 'Pass0!', 'First0Last0', 'First0', 'Last0', 'First0@Last0.com'), (2, 'Pass1!', 'First1Last1', 'First1', 'Last1', 'First1@Last1.com') RETURNING "app_myuser"."id"
COMMIT

INSERT INTO "app_myuser" ("password", "username", "first_name", "last_name", "email") VALUES ('', 'First501Last501', 'First501', 'Last501', 'First501@Last501.com') RETURNING "app_myuser"."id"
INSERT INTO "app_myuser" ("password", "username", "first_name", "last_name", "email") VALUES ('', 'First502Last502', 'First502', 'Last502', 'First502@Last502.com') RETURNING "app_myuser"."id"

SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" WHERE "app_myuser"."id" = 502 LIMIT 21
SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" WHERE "app_myuser"."id" = 503 LIMIT 21

SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" WHERE "app_myuser"."id" = 502 LIMIT 21
UPDATE "app_myuser" SET "password" = 'Pass501!', "username" = 'Changed501', "first_name" = 'First501', "last_name" = 'Last501', "email" = 'First501@Last501.com' WHERE "app_myuser"."id" = 502
SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" WHERE "app_myuser"."id" = 503 LIMIT 21
UPDATE "app_myuser" SET "password" = 'Pass502!', "username" = 'Changed502', "first_name" = 'First502', "last_name" = 'Last502', "email" = 'First502@Last502.com' WHERE "app_myuser"."id" = 503

SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" WHERE "app_myuser"."id" = 501 LIMIT 21
DELETE FROM "app_myuser" WHERE "app_myuser"."id" IN (501)
SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" WHERE "app_myuser"."id" = 502 LIMIT 21
DELETE FROM "app_myuser" WHERE "app_myuser"."id" IN (502)

SELECT COUNT(*) AS "__count" FROM "app_myuser"
SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" LIMIT 100
SELECT COUNT(*) AS "__count" FROM "app_myuser"
SELECT "app_myuser"."id", "app_myuser"."password", "app_myuser"."username", "app_myuser"."first_name", "app_myuser"."last_name", "app_myuser"."email" FROM "app_myuser" LIMIT 100 OFFSET 100
