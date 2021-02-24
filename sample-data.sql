CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE programs
(
    program_id uuid primary key,
    name varchar(100) NOT NULL,
    code varchar(15) NOT NULL,
    active boolean NOT NULL,
    updated_by varchar(256) NOT NULL ,
    updated_at timestamptz DEFAULT now(),
    created_by varchar(256) NOT NULL ,
    created_at timestamptz DEFAULT now()
);

CREATE TABLE students
(
    student_uuid uuid primary key,
    student_id SERIAL,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    status varchar(30),
    program_id uuid,
    active boolean NOT NULL,
    updated_by varchar(256) NOT NULL ,
    updated_at timestamptz DEFAULT now(),
    created_by varchar(256) NOT NULL ,
    created_at timestamptz DEFAULT now(),
    CONSTRAINT fk_program FOREIGN KEY(program_id) REFERENCES programs(program_id)
);

-- Programs
INSERT INTO programs (program_id, name, code, active, updated_by, created_by)
values ('81541c1a-7ec1-44c2-aa33-385812a8fbcc', 'Physics', 'PHYS', true, '00001', '00001');

INSERT INTO programs (program_id, name, code, active, updated_by, created_by)
values ('c69ce217-c08d-4e50-bdda-4dfe4f9a9a3c', 'Math', 'MATH', true, '00001', '00001');

INSERT INTO programs (program_id, name, code, active, updated_by, created_by)
values ('d958c587-db7b-41f9-9954-c33dc56e08f5', 'Theater', 'THTR', true, '00001', '00001');

INSERT INTO programs (program_id, name, code, active, updated_by, created_by)
values ('c8cc00be-be31-445c-b0cd-4fd7c519f1fe', 'Business', 'BUSN', true, '00001', '00001');

INSERT INTO programs (program_id, name, code, active, updated_by, created_by)
values ('dd961f3d-ae35-4a0b-863a-eaff31e4efc8', 'Biology', 'BIOG', true, '00001', '00001');

INSERT INTO programs (program_id, name, code, active, updated_by, created_by)
values ('faf0108a-352c-4a2e-ab98-956adf5d1ef8', 'Nursing', 'NURS', true, '00001', '00001');

INSERT INTO programs (program_id, name, code, active, updated_by, created_by)
values ('b836af54-4d51-4b8b-8494-43a3ec29f031', 'History', 'HIST', true, '00001', '00001');

-- Students
INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('78f7424c-b4c0-4196-af42-9a4a32c6f26a', 'Martha', 'Jones', 'ENROLLED', 'dd961f3d-ae35-4a0b-863a-eaff31e4efc8', true, '00001', '00001' )

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('87917a4e-9fd0-4207-87da-a7bfb0144d84', 'Amy', 'Pond', 'ENROLLED', 'faf0108a-352c-4a2e-ab98-956adf5d1ef8', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('1c60dd8a-9a65-48c0-991c-65c369ec0244', 'Rose', 'Tyler', 'ENROLLED', '81541c1a-7ec1-44c2-aa33-385812a8fbcc', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('1e3a6d05-ef78-4470-b96f-5d1a7653d950', 'Rory', 'Williams', 'ENROLLED', 'b836af54-4d51-4b8b-8494-43a3ec29f031', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('7812233d-9289-4442-8cbb-92535124e9a7', 'Jack ', 'Harkness', 'ENROLLED', 'd958c587-db7b-41f9-9954-c33dc56e08f5', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('30cd5215-76aa-4e5e-b8c6-4ff0e90a21b5', 'Clara', 'Oswald', 'ENROLLED', 'd958c587-db7b-41f9-9954-c33dc56e08f5', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('6131a73c-604f-4e39-9bd4-eab5d8b39161', 'Mickey', 'Smith', 'ENROLLED', '81541c1a-7ec1-44c2-aa33-385812a8fbcc', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('d49b744d-56cb-4254-a46d-30b77a0c9f21', 'Bill', 'Potts', 'ENROLLED', 'c69ce217-c08d-4e50-bdda-4dfe4f9a9a3c', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('70b2e61e-313d-4d04-9adc-23eb91e576f6', 'Sarah', 'Jane', 'ENROLLED', 'faf0108a-352c-4a2e-ab98-956adf5d1ef8', true, '00001', '00001' );

INSERT INTO students (student_uuid, first_name, last_name, status, program_id, active, updated_by, created_by)
VALUES ('5cfb70cd-9ab1-4b26-83c9-f24884ca4d65', 'Sally', 'Sparrow', 'ENROLLED', 'c8cc00be-be31-445c-b0cd-4fd7c519f1fe', true, '00001', '00001' );

