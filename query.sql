create extension if not exists citext;
create type role_enum as enum('Admin','Ticket Manager','Football Fan','Finance Manager','Stadium Manager','Support Staff');
create table users(
  user_id serial primary key,
  full_name text not null,
  email citext unique not null,
  role role_enum not null,
  phone_number varchar(20),
  created_at timestamp default current_timestamp
);


create type match_status_enum as enum('Available', 'Selling Fast', 'Sold Out', 'Postponed');
create table matches(
  match_id serial primary key,
  fixture text not null,
  tournament_category varchar(50) not null check(
    tournament_category in (
      'Champions League', 'Premier League'
    )
  ), 
  base_ticket_price int not null check(base_ticket_price>0),
  match_status match_status_enum not null default 'Available'
  );

create type payment_status_enum as enum ('Pending', 'Confirmed', 'Cancelled', 'Refunded');
create table bookings(
  booking_id serial primary key,
  user_id int not null references users(user_id),
  match_id int not null references matches(match_id),
  seat_number varchar(10) not null,
  payment_status payment_status_enum not null,
  total_cost int not null,
  unique(match_id, seat_number)
);
