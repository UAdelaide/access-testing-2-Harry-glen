USE textbook_marketplace;

CREATE TABLE Users (
  user_id       INT         NOT NULL AUTO_INCREMENT,
  username      VARCHAR(255) NOT NULL,
  email         VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name    VARCHAR(255),
  last_name     VARCHAR(255),
  PRIMARY KEY (user_id)
);

CREATE TABLE Addresses (
  address_id   INT         NOT NULL AUTO_INCREMENT,
  user_id      INT         NOT NULL,
  street       VARCHAR(255),
  city         VARCHAR(100) NOT NULL,
  state        VARCHAR(100),
  postal_code  VARCHAR(20),
  country      VARCHAR(100) NOT NULL,
  PRIMARY KEY (address_id),
  INDEX (user_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Books (
  book_id   INT         NOT NULL AUTO_INCREMENT,
  isbn      VARCHAR(20)  NOT NULL,
  title     VARCHAR(255) NOT NULL,
  author    VARCHAR(255) NOT NULL,
  publisher VARCHAR(255),
  year      INT,
  PRIMARY KEY (book_id)
);

CREATE TABLE Listings (
  listing_id     INT           NOT NULL AUTO_INCREMENT,
  book_id        INT           NOT NULL,
  seller_id      INT           NOT NULL,
  price          DECIMAL(10,2) NOT NULL,
  book_condition VARCHAR(50),
  created_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status         VARCHAR(20)   NOT NULL DEFAULT 'available',
  PRIMARY KEY (listing_id),
  INDEX (book_id),
  INDEX (seller_id),
  FOREIGN KEY (book_id)   REFERENCES Books(book_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (seller_id) REFERENCES Users(user_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE Purchases (
  purchase_id   INT       NOT NULL AUTO_INCREMENT,
  listing_id    INT       NOT NULL,
  buyer_id      INT       NOT NULL,
  purchase_date DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (purchase_id),
  INDEX (listing_id),
  INDEX (buyer_id),
  FOREIGN KEY (listing_id) REFERENCES Listings(listing_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (buyer_id)   REFERENCES Users(user_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE Messages (
  message_id   INT       NOT NULL AUTO_INCREMENT,
  listing_id   INT       NOT NULL,
  sender_id    INT       NOT NULL,
  receiver_id  INT       NOT NULL,
  message_text TEXT      NOT NULL,
  sent_at      DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (message_id),
  INDEX (listing_id),
  INDEX (sender_id),
  INDEX (receiver_id),
  FOREIGN KEY (listing_id)  REFERENCES Listings(listing_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (sender_id)   REFERENCES Users(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
