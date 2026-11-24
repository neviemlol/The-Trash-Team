--
-- PostgreSQL database dump
--

\restrict x0dgYkvybgp67tAgeIsrQenFygigaTdcNze5RBxgY5ACFXITmZBemLBFde347kE

-- Dumped from database version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)
-- Dumped by pg_dump version 18.7 (Postgres.app)

-- Started on 2026-11-23 16:41:18 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16418)
-- Name: bins; Type: TABLE; Schema: public; Owner: user123
--

CREATE TABLE public.bins (
    bin_id bigint NOT NULL,
    location_id bigint NOT NULL,
    capacity integer NOT NULL,
    status character varying(20) NOT NULL,
    CONSTRAINT bins_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying, 'maintenance'::character varying])::text[])))
);


ALTER TABLE public.bins OWNER TO user123;

--
-- TOC entry 223 (class 1259 OID 16417)
-- Name: bins_bin_id_seq; Type: SEQUENCE; Schema: public; Owner: user123
--

ALTER TABLE public.bins ALTER COLUMN bin_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bins_bin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16451)
-- Name: collections; Type: TABLE; Schema: public; Owner: user123
--

CREATE TABLE public.collections (
    collection_id bigint NOT NULL,
    bin_id bigint NOT NULL,
    collector_id bigint NOT NULL,
    collected_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fill_before integer NOT NULL,
    fill_after integer NOT NULL,
    CONSTRAINT collections_fill_after_check CHECK (((fill_after >= 0) AND (fill_after <= 100))),
    CONSTRAINT collections_fill_before_check CHECK (((fill_before >= 0) AND (fill_before <= 100)))
);


ALTER TABLE public.collections OWNER TO user123;

--
-- TOC entry 227 (class 1259 OID 16450)
-- Name: collections_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: user123
--

ALTER TABLE public.collections ALTER COLUMN collection_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.collections_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16391)
-- Name: locations; Type: TABLE; Schema: public; Owner: user123
--

CREATE TABLE public.locations (
    location_id integer NOT NULL,
    location_name character varying(150) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE public.locations OWNER TO user123;

--
-- TOC entry 219 (class 1259 OID 16390)
-- Name: locations_location_id_seq; Type: SEQUENCE; Schema: public; Owner: user123
--

ALTER TABLE public.locations ALTER COLUMN location_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.locations_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16434)
-- Name: measurements; Type: TABLE; Schema: public; Owner: user123
--

CREATE TABLE public.measurements (
    measurement_id bigint NOT NULL,
    bin_id bigint NOT NULL,
    fill_level integer NOT NULL,
    measured_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT measurements_fill_level_check CHECK (((fill_level >= 0) AND (fill_level <= 100)))
);


ALTER TABLE public.measurements OWNER TO user123;

--
-- TOC entry 225 (class 1259 OID 16433)
-- Name: measurements_measurement_id_seq; Type: SEQUENCE; Schema: public; Owner: user123
--

ALTER TABLE public.measurements ALTER COLUMN measurement_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.measurements_measurement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16402)
-- Name: users; Type: TABLE; Schema: public; Owner: user123
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    role character varying(20) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['resident'::character varying, 'collector'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO user123;

--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: user123
--

ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3521 (class 0 OID 16418)
-- Dependencies: 224
-- Data for Name: bins; Type: TABLE DATA; Schema: public; Owner: user123
--

COPY public.bins (bin_id, location_id, capacity, status) FROM stdin;
\.


--
-- TOC entry 3525 (class 0 OID 16451)
-- Dependencies: 228
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: user123
--

COPY public.collections (collection_id, bin_id, collector_id, collected_at, fill_before, fill_after) FROM stdin;
\.


--
-- TOC entry 3517 (class 0 OID 16391)
-- Dependencies: 220
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: user123
--

COPY public.locations (location_id, location_name, latitude, longitude) FROM stdin;
\.


--
-- TOC entry 3523 (class 0 OID 16434)
-- Dependencies: 226
-- Data for Name: measurements; Type: TABLE DATA; Schema: public; Owner: user123
--

COPY public.measurements (measurement_id, bin_id, fill_level, measured_at) FROM stdin;
\.


--
-- TOC entry 3519 (class 0 OID 16402)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user123
--

COPY public.users (user_id, name, email, password_hash, role) FROM stdin;
\.


--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 223
-- Name: bins_bin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user123
--

SELECT pg_catalog.setval('public.bins_bin_id_seq', 1, false);


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 227
-- Name: collections_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user123
--

SELECT pg_catalog.setval('public.collections_collection_id_seq', 1, false);


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 219
-- Name: locations_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user123
--

SELECT pg_catalog.setval('public.locations_location_id_seq', 1, false);


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 225
-- Name: measurements_measurement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user123
--

SELECT pg_catalog.setval('public.measurements_measurement_id_seq', 1, false);


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user123
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- TOC entry 3360 (class 2606 OID 16427)
-- Name: bins bins_pkey; Type: CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.bins
    ADD CONSTRAINT bins_pkey PRIMARY KEY (bin_id);


--
-- TOC entry 3364 (class 2606 OID 16464)
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (collection_id);


--
-- TOC entry 3354 (class 2606 OID 16399)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (location_id);


--
-- TOC entry 3362 (class 2606 OID 16444)
-- Name: measurements measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (measurement_id);


--
-- TOC entry 3356 (class 2606 OID 16416)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3358 (class 2606 OID 16414)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3365 (class 2606 OID 16428)
-- Name: bins bins_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.bins
    ADD CONSTRAINT bins_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(location_id);


--
-- TOC entry 3367 (class 2606 OID 16465)
-- Name: collections collections_bin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_bin_id_fkey FOREIGN KEY (bin_id) REFERENCES public.bins(bin_id);


--
-- TOC entry 3368 (class 2606 OID 16470)
-- Name: collections collections_collector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_collector_id_fkey FOREIGN KEY (collector_id) REFERENCES public.users(user_id);


--
-- TOC entry 3366 (class 2606 OID 16445)
-- Name: measurements measurements_bin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user123
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_bin_id_fkey FOREIGN KEY (bin_id) REFERENCES public.bins(bin_id);


-- Completed on 2026-11-23 16:41:19 CET

--
-- PostgreSQL database dump complete
--

\unrestrict x0dgYkvybgp67tAgeIsrQenFygigaTdcNze5RBxgY5ACFXITmZBemLBFde347kE

