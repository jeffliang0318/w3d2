DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id integer primary key,
  fname  VARCHAR(255) not null,
  lname  VARCHAR(255) not null
);

INSERT INTO
users(fname,lname)
VALUES
('Jeff','Liang'),
('TingTing','Jiang');

DROP TABLE IF EXISTS questions;
CREATE TABLE questions(
  id integer primary key,
  title VARCHAR(255) not null,
  body text not null,
  author_id integer not null,

  FOREIGN KEY(author_id) REFERENCES users(id)
);

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Jeff question', 'Jeff JEFF JEff', (
    SELECT id FROM users
    WHERE fname = 'Jeff'
      AND lname = 'Liang'));

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows(
  id integer primary key,
  author_id integer,
  question_id integer,

  FOREIGN KEY(author_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows(author_id, question_id)
VALUES
  ((SELECT id FROM users
  WHERE fname = 'Jeff'
    AND lname = 'Liang'), (SELECT id FROM questions WHERE title = 'Jeff question') )
;
-- (SELECT id FROM questions WHERE title = 'Jeff question')

DROP TABLE IF EXISTS replies;
CREATE TABLE replies(
  id integer primary key,
  question_id integer not null,
  author_id integer not null,
  body text not null,
  top_reply_id integer,

  FOREIGN KEY(author_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(top_reply_id) REFERENCES replies(id)
);

INSERT INTO
  replies (question_id, author_id, body, top_reply_id)
VALUES
  ((SELECT id FROM questions WHERE title = "Jeff question"),
  (SELECT id FROM users WHERE fname = "Jeff" AND lname = "Liang"),
  "I think he said MEOW MEOW MEOW.",
  null
);



DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes(
  id integer primary key,
  question_id integer not null,
  author_id integer not null,
  body text not null,

  FOREIGN KEY(author_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);
