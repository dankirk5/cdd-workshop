CREATE TABLE titles (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO titles (title) VALUES ('Underling');
INSERT INTO titles (title) VALUES ('Evil Overlord');
INSERT INTO titles (title) VALUES ('Benevolent Dictator');
