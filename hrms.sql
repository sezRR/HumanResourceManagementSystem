-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.activation_code_for_employers
(
    activation_code_id integer NOT NULL,
    employer_id integer NOT NULL,
    PRIMARY KEY (activation_code_id)
);

CREATE TABLE public.activation_code_for_job_seekers
(
    activation_code_id integer NOT NULL,
    job_seeker_id integer NOT NULL,
    PRIMARY KEY (activation_code_id)
);

CREATE TABLE public.activation_codes
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    activation_code character varying(40) NOT NULL,
    is_confirmed boolean NOT NULL,
    confirmed_date date,
    PRIMARY KEY (id),
    UNIQUE(activation_code)
);

CREATE TABLE public.employees
(
    user_id integer NOT NULL,
    first_name character varying(32) NOT NULL,
    last_name character varying(32) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.employer_activation_by_employees
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    employer_id integer NOT NULL,
    confirmed_employee_id integer NOT NULL,
    is_confirmed boolean NOT NULL,
    confirmed_date date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers
(
    user_id integer NOT NULL,
    company_name character varying(50) NOT NULL,
    web_site character varying(50) NOT NULL,
    phone_number character varying(12) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.job_seekers
(
    user_id integer NOT NULL,
    first_name character varying(32) NOT NULL,
    last_name character varying(32) NOT NULL,
    national_identity character varying(11) NOT NULL,
    date_of_birth date NOT NULL,
    PRIMARY KEY (user_id),
	UNIQUE(national_identity)
);

CREATE TABLE public.job_titles
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    title character varying(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE(title)
);

CREATE TABLE public.users
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    email character varying(50) NOT NULL,
    password character varying(32) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE(email)
);

ALTER TABLE public.activation_code_for_employers
    ADD FOREIGN KEY (activation_code_id)
    REFERENCES public.activation_codes (id)
    NOT VALID;


ALTER TABLE public.activation_code_for_employers
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (user_id)
    NOT VALID;


ALTER TABLE public.activation_code_for_job_seekers
    ADD FOREIGN KEY (activation_code_id)
    REFERENCES public.activation_codes (id)
    NOT VALID;


ALTER TABLE public.activation_code_for_job_seekers
    ADD FOREIGN KEY (job_seeker_id)
    REFERENCES public.job_seekers (user_id)
    NOT VALID;


ALTER TABLE public.activation_codes
    ADD FOREIGN KEY (id)
    REFERENCES public.activation_code_for_employers (activation_code_id)
    NOT VALID;


ALTER TABLE public.activation_codes
    ADD FOREIGN KEY (id)
    REFERENCES public.activation_code_for_job_seekers (activation_code_id)
    NOT VALID;


ALTER TABLE public.employees
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employer_activation_by_employees
    ADD FOREIGN KEY (confirmed_employee_id)
    REFERENCES public.employees (user_id)
    NOT VALID;


ALTER TABLE public.employer_activation_by_employees
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (user_id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.job_seekers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;

END;