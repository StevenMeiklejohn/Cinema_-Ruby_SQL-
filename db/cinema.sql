DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;


CREATE TABLE customers (
  id SERIAL4 primary key,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE films (
  id SERIAL4 primary key,
  title VARCHAR(255),
  price INT4,
  empty_seats INT4
);

CREATE TABLE tickets (
  id SERIAL4 primary key,
  customer_id SERIAL4 references customers(id) ON DELETE CASCADE,
  film_id SERIAL4 references films(id) ON DELETE CASCADE,
  time INT4
);