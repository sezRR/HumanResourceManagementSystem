-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.candidate_users
(
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    identity_number character varying(11) NOT NULL,
    date_of_birth date NOT NULL,
    PRIMARY KEY (id),
	UNIQUE(identity_number)
);

CREATE TABLE public.candidate_users_verify
(
    id integer NOT NULL,
    candidate_id integer NOT NULL,
    status boolean,
    PRIMARY KEY (id)
);

CREATE TABLE public.cities
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    city_name character varying(25) NOT NULL,
    PRIMARY KEY (id),
	UNIQUE(city_name)
);

CREATE TABLE public.employer_user_staff_verify
(
    id integer NOT NULL,
    employer_id integer NOT NULL,
    confirm_staff integer,
    confirm_date date,
    status boolean,
    PRIMARY KEY (id)
);

CREATE TABLE public.employer_users
(
    id integer NOT NULL,
    company_name character varying(100) NOT NULL,
    web_address character varying(50) NOT NULL,
    phone_number character varying(17) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employer_users_verify
(
    id integer NOT NULL,
    employer_id integer NOT NULL,
    status boolean,
    PRIMARY KEY (id)
);

CREATE TABLE public.job_adverts
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    employer_id integer NOT NULL,
    position_id integer NOT NULL,
    city_id integer NOT NULL,
    advert_description character varying(250) NOT NULL,
    min_salary integer,
    max_salary integer,
    open_position smallint NOT NULL,
    deadline date,
    created_date date NOT NULL,
    is_active boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.job_positions
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "position" character varying(50) NOT NULL,
    PRIMARY KEY (id),
	UNIQUE("position")
);

CREATE TABLE public.staff_users
(
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.users
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    email character varying(50) NOT NULL,
    password character varying(32) NOT NULL,
    PRIMARY KEY (id),
	UNIQUE(email)
);

CREATE TABLE public.verify_code
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    verify_code character varying(10) NOT NULL,
    is_confirmed boolean,
    created_date date NOT NULL,
    confirmed_date date,
    PRIMARY KEY (id),
	UNIQUE(verify_code)
);

ALTER TABLE public.candidate_users
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.candidate_users_verify
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidate_users (id)
    NOT VALID;


ALTER TABLE public.candidate_users_verify
    ADD FOREIGN KEY (id)
    REFERENCES public.verify_code (id)
    NOT VALID;


ALTER TABLE public.employer_user_staff_verify
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employer_users (id)
    NOT VALID;


ALTER TABLE public.employer_user_staff_verify
    ADD FOREIGN KEY (confirm_staff)
    REFERENCES public.staff_users (id)
    NOT VALID;


ALTER TABLE public.employer_user_staff_verify
    ADD FOREIGN KEY (id)
    REFERENCES public.verify_code (id)
    NOT VALID;


ALTER TABLE public.employer_users
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employer_users_verify
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employer_users (id)
    NOT VALID;


ALTER TABLE public.employer_users_verify
    ADD FOREIGN KEY (id)
    REFERENCES public.verify_code (id)
    NOT VALID;


ALTER TABLE public.job_adverts
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employer_users (id)
    NOT VALID;


ALTER TABLE public.staff_users
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;

END;