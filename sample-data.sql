CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE dogs
(
    id uuid primary key,
    name varchar(256) NOT NULL,
    breed varchar(256) NOT NULL,
    category varchar(256) NOT NULL,
    active boolean NOT NULL,
    updated_by varchar(256) NOT NULL ,
    updated_at timestamptz DEFAULT now(),
    created_by varchar(256) NOT NULL ,
    created_at timestamptz DEFAULT now()
);

insert into dogs (id, name, breed, category, active, updated_by, updated_at, created_by, created_at)
values (uuid_generate_v4(), 'Siba', 'Poodle', 'Non-Sporting', true, '0001', now(), '0001', now());