--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-02 11:24:38

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
-- TOC entry 222 (class 1259 OID 33136)
-- Name: conversaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversaciones (
    id_conversacion integer NOT NULL,
    id_materia integer,
    id_usuario_remitente integer,
    id_usuario_destinatario integer,
    asunto character varying(255),
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conversaciones OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33135)
-- Name: conversaciones_id_conversacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversaciones_id_conversacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversaciones_id_conversacion_seq OWNER TO postgres;

--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 221
-- Name: conversaciones_id_conversacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversaciones_id_conversacion_seq OWNED BY public.conversaciones.id_conversacion;


--
-- TOC entry 226 (class 1259 OID 33181)
-- Name: etiquetas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etiquetas (
    id_etiqueta integer NOT NULL,
    nombre_etiqueta character varying(50) NOT NULL
);


ALTER TABLE public.etiquetas OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33180)
-- Name: etiquetas_id_etiqueta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etiquetas_id_etiqueta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etiquetas_id_etiqueta_seq OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 225
-- Name: etiquetas_id_etiqueta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etiquetas_id_etiqueta_seq OWNED BY public.etiquetas.id_etiqueta;


--
-- TOC entry 232 (class 1259 OID 33227)
-- Name: historial_estados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_estados (
    id_historial integer NOT NULL,
    id_mensaje integer,
    estado character varying(50) NOT NULL,
    fecha_cambio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT historial_estados_estado_check CHECK (((estado)::text = ANY ((ARRAY['visto'::character varying, 'no_le¡do'::character varying, 'respondido'::character varying, 'en_espera'::character varying])::text[])))
);


ALTER TABLE public.historial_estados OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 33226)
-- Name: historial_estados_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_estados_id_historial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_estados_id_historial_seq OWNER TO postgres;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 231
-- Name: historial_estados_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_estados_id_historial_seq OWNED BY public.historial_estados.id_historial;


--
-- TOC entry 220 (class 1259 OID 33124)
-- Name: materias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materias (
    id_materia integer NOT NULL,
    nombre_materia character varying(100) NOT NULL,
    id_docente integer
);


ALTER TABLE public.materias OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33123)
-- Name: materias_id_materia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.materias_id_materia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materias_id_materia_seq OWNER TO postgres;

--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 219
-- Name: materias_id_materia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.materias_id_materia_seq OWNED BY public.materias.id_materia;


--
-- TOC entry 224 (class 1259 OID 33159)
-- Name: mensajes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensajes (
    id_mensaje integer NOT NULL,
    id_conversacion integer,
    id_usuario_remitente integer,
    contenido text NOT NULL,
    fecha_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(50) DEFAULT 'no_le¡do'::character varying,
    CONSTRAINT mensajes_estado_check CHECK (((estado)::text = ANY ((ARRAY['visto'::character varying, 'no_le¡do'::character varying, 'respondido'::character varying, 'en_espera'::character varying])::text[])))
);


ALTER TABLE public.mensajes OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 33187)
-- Name: mensajes_etiquetas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensajes_etiquetas (
    id_mensaje integer NOT NULL,
    id_etiqueta integer NOT NULL
);


ALTER TABLE public.mensajes_etiquetas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 33158)
-- Name: mensajes_id_mensaje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mensajes_id_mensaje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mensajes_id_mensaje_seq OWNER TO postgres;

--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 223
-- Name: mensajes_id_mensaje_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mensajes_id_mensaje_seq OWNED BY public.mensajes.id_mensaje;


--
-- TOC entry 230 (class 1259 OID 33211)
-- Name: mensajes_prioridades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensajes_prioridades (
    id_mensaje integer NOT NULL,
    id_prioridad integer NOT NULL
);


ALTER TABLE public.mensajes_prioridades OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 33203)
-- Name: prioridades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prioridades (
    id_prioridad integer NOT NULL,
    nivel_prioridad character varying(50) DEFAULT 'normal'::character varying,
    CONSTRAINT prioridades_nivel_prioridad_check CHECK (((nivel_prioridad)::text = ANY ((ARRAY['urgente'::character varying, 'normal'::character varying])::text[])))
);


ALTER TABLE public.prioridades OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 33202)
-- Name: prioridades_id_prioridad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prioridades_id_prioridad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prioridades_id_prioridad_seq OWNER TO postgres;

--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 228
-- Name: prioridades_id_prioridad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prioridades_id_prioridad_seq OWNED BY public.prioridades.id_prioridad;


--
-- TOC entry 218 (class 1259 OID 33114)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    tipo character varying(50),
    password character varying(100) NOT NULL,
    CONSTRAINT usuarios_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['docente'::character varying, 'estudiante'::character varying, 'administrador'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 33113)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 4681 (class 2604 OID 33139)
-- Name: conversaciones id_conversacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversaciones ALTER COLUMN id_conversacion SET DEFAULT nextval('public.conversaciones_id_conversacion_seq'::regclass);


--
-- TOC entry 4686 (class 2604 OID 33184)
-- Name: etiquetas id_etiqueta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetas ALTER COLUMN id_etiqueta SET DEFAULT nextval('public.etiquetas_id_etiqueta_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 33230)
-- Name: historial_estados id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados ALTER COLUMN id_historial SET DEFAULT nextval('public.historial_estados_id_historial_seq'::regclass);


--
-- TOC entry 4680 (class 2604 OID 33127)
-- Name: materias id_materia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materias ALTER COLUMN id_materia SET DEFAULT nextval('public.materias_id_materia_seq'::regclass);


--
-- TOC entry 4683 (class 2604 OID 33162)
-- Name: mensajes id_mensaje; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes ALTER COLUMN id_mensaje SET DEFAULT nextval('public.mensajes_id_mensaje_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 33206)
-- Name: prioridades id_prioridad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prioridades ALTER COLUMN id_prioridad SET DEFAULT nextval('public.prioridades_id_prioridad_seq'::regclass);


--
-- TOC entry 4679 (class 2604 OID 33117)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 4876 (class 0 OID 33136)
-- Dependencies: 222
-- Data for Name: conversaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversaciones (id_conversacion, id_materia, id_usuario_remitente, id_usuario_destinatario, asunto, fecha_creacion) FROM stdin;
1	1	2	1	Duda sobre el examen de Matem ticas	2025-03-01 15:18:49.283345
2	2	2	1	Consulta sobre la tarea de Historia	2025-03-01 15:18:49.283345
3	3	1	3	Reuni¢n para planificar el curso de Programaci¢n	2025-03-01 15:18:49.283345
\.


--
-- TOC entry 4880 (class 0 OID 33181)
-- Dependencies: 226
-- Data for Name: etiquetas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etiquetas (id_etiqueta, nombre_etiqueta) FROM stdin;
1	urgente
2	tarea
3	examen
\.


--
-- TOC entry 4886 (class 0 OID 33227)
-- Dependencies: 232
-- Data for Name: historial_estados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_estados (id_historial, id_mensaje, estado, fecha_cambio) FROM stdin;
1	1	no_le¡do	2025-03-01 15:18:56.547952
2	1	visto	2025-03-01 15:18:56.547952
3	2	no_le¡do	2025-03-01 15:18:56.547952
4	3	visto	2025-03-01 15:18:56.547952
\.


--
-- TOC entry 4874 (class 0 OID 33124)
-- Dependencies: 220
-- Data for Name: materias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.materias (id_materia, nombre_materia, id_docente) FROM stdin;
1	Matem ticas	1
2	Historia	1
3	Programaci¢n	3
\.


--
-- TOC entry 4878 (class 0 OID 33159)
-- Dependencies: 224
-- Data for Name: mensajes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensajes (id_mensaje, id_conversacion, id_usuario_remitente, contenido, fecha_envio, estado) FROM stdin;
1	1	2	Hola, ¨cu ndo es el examen de Matem ticas?	2025-03-01 15:18:49.301205	visto
2	1	1	El examen es el pr¢ximo lunes.	2025-03-01 15:18:49.301205	no_le¡do
3	2	2	¨Qu‚ temas entran en la tarea de Historia?	2025-03-01 15:18:49.301205	visto
4	3	1	¨Podemos reunirnos el viernes?	2025-03-01 15:18:49.301205	en_espera
\.


--
-- TOC entry 4881 (class 0 OID 33187)
-- Dependencies: 227
-- Data for Name: mensajes_etiquetas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensajes_etiquetas (id_mensaje, id_etiqueta) FROM stdin;
1	3
2	3
3	2
\.


--
-- TOC entry 4884 (class 0 OID 33211)
-- Dependencies: 230
-- Data for Name: mensajes_prioridades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensajes_prioridades (id_mensaje, id_prioridad) FROM stdin;
1	1
2	2
3	2
\.


--
-- TOC entry 4883 (class 0 OID 33203)
-- Dependencies: 229
-- Data for Name: prioridades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prioridades (id_prioridad, nivel_prioridad) FROM stdin;
1	urgente
2	normal
\.


--
-- TOC entry 4872 (class 0 OID 33114)
-- Dependencies: 218
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nombre, email, tipo, password) FROM stdin;
1	Juan P‚rez	juan@example.com	docente	hash1
2	Mar¡a G¢mez	maria@example.com	estudiante	hash2
3	Carlos L¢pez	carlos@example.com	administrador	hash3
5	Estela Concha Seca	estelita@example.com	estudiante	$2b$10$n8849Afkharnblpq2ajddOF6wRUoB2kf5Gdp4CbZN3EyY1/Ic1aCa
7	Fulano de Tal	fulano@example.com	docente	$2b$10$EjAULZduKk3e8wU1XVjxSuBmldHt3tslTBUUYvzljv8Tu8cY2kz8e
8	Fulano de Tal Tal	fulano2@example.com	docente	$2b$10$cWi6LI.Bj2WOLvXQQGgKQuQIM2vUjMxuLPQt6zyu0TUu46RK7tw/K
\.


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 221
-- Name: conversaciones_id_conversacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversaciones_id_conversacion_seq', 3, true);


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 225
-- Name: etiquetas_id_etiqueta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etiquetas_id_etiqueta_seq', 3, true);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 231
-- Name: historial_estados_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_estados_id_historial_seq', 4, true);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 219
-- Name: materias_id_materia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.materias_id_materia_seq', 3, true);


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 223
-- Name: mensajes_id_mensaje_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mensajes_id_mensaje_seq', 4, true);


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 228
-- Name: prioridades_id_prioridad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prioridades_id_prioridad_seq', 2, true);


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 8, true);


--
-- TOC entry 4702 (class 2606 OID 33142)
-- Name: conversaciones conversaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversaciones
    ADD CONSTRAINT conversaciones_pkey PRIMARY KEY (id_conversacion);


--
-- TOC entry 4706 (class 2606 OID 33186)
-- Name: etiquetas etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetas
    ADD CONSTRAINT etiquetas_pkey PRIMARY KEY (id_etiqueta);


--
-- TOC entry 4714 (class 2606 OID 33234)
-- Name: historial_estados historial_estados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados
    ADD CONSTRAINT historial_estados_pkey PRIMARY KEY (id_historial);


--
-- TOC entry 4700 (class 2606 OID 33129)
-- Name: materias materias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materias
    ADD CONSTRAINT materias_pkey PRIMARY KEY (id_materia);


--
-- TOC entry 4708 (class 2606 OID 33191)
-- Name: mensajes_etiquetas mensajes_etiquetas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_etiquetas
    ADD CONSTRAINT mensajes_etiquetas_pkey PRIMARY KEY (id_mensaje, id_etiqueta);


--
-- TOC entry 4704 (class 2606 OID 33169)
-- Name: mensajes mensajes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_pkey PRIMARY KEY (id_mensaje);


--
-- TOC entry 4712 (class 2606 OID 33215)
-- Name: mensajes_prioridades mensajes_prioridades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_prioridades
    ADD CONSTRAINT mensajes_prioridades_pkey PRIMARY KEY (id_mensaje, id_prioridad);


--
-- TOC entry 4710 (class 2606 OID 33210)
-- Name: prioridades prioridades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prioridades
    ADD CONSTRAINT prioridades_pkey PRIMARY KEY (id_prioridad);


--
-- TOC entry 4696 (class 2606 OID 33122)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4698 (class 2606 OID 33120)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4716 (class 2606 OID 33143)
-- Name: conversaciones conversaciones_id_materia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversaciones
    ADD CONSTRAINT conversaciones_id_materia_fkey FOREIGN KEY (id_materia) REFERENCES public.materias(id_materia);


--
-- TOC entry 4717 (class 2606 OID 33153)
-- Name: conversaciones conversaciones_id_usuario_destinatario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversaciones
    ADD CONSTRAINT conversaciones_id_usuario_destinatario_fkey FOREIGN KEY (id_usuario_destinatario) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4718 (class 2606 OID 33148)
-- Name: conversaciones conversaciones_id_usuario_remitente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversaciones
    ADD CONSTRAINT conversaciones_id_usuario_remitente_fkey FOREIGN KEY (id_usuario_remitente) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4725 (class 2606 OID 33235)
-- Name: historial_estados historial_estados_id_mensaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados
    ADD CONSTRAINT historial_estados_id_mensaje_fkey FOREIGN KEY (id_mensaje) REFERENCES public.mensajes(id_mensaje);


--
-- TOC entry 4715 (class 2606 OID 33130)
-- Name: materias materias_id_docente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materias
    ADD CONSTRAINT materias_id_docente_fkey FOREIGN KEY (id_docente) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4721 (class 2606 OID 33197)
-- Name: mensajes_etiquetas mensajes_etiquetas_id_etiqueta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_etiquetas
    ADD CONSTRAINT mensajes_etiquetas_id_etiqueta_fkey FOREIGN KEY (id_etiqueta) REFERENCES public.etiquetas(id_etiqueta);


--
-- TOC entry 4722 (class 2606 OID 33192)
-- Name: mensajes_etiquetas mensajes_etiquetas_id_mensaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_etiquetas
    ADD CONSTRAINT mensajes_etiquetas_id_mensaje_fkey FOREIGN KEY (id_mensaje) REFERENCES public.mensajes(id_mensaje);


--
-- TOC entry 4719 (class 2606 OID 33170)
-- Name: mensajes mensajes_id_conversacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_id_conversacion_fkey FOREIGN KEY (id_conversacion) REFERENCES public.conversaciones(id_conversacion);


--
-- TOC entry 4720 (class 2606 OID 33175)
-- Name: mensajes mensajes_id_usuario_remitente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes
    ADD CONSTRAINT mensajes_id_usuario_remitente_fkey FOREIGN KEY (id_usuario_remitente) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4723 (class 2606 OID 33216)
-- Name: mensajes_prioridades mensajes_prioridades_id_mensaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_prioridades
    ADD CONSTRAINT mensajes_prioridades_id_mensaje_fkey FOREIGN KEY (id_mensaje) REFERENCES public.mensajes(id_mensaje);


--
-- TOC entry 4724 (class 2606 OID 33221)
-- Name: mensajes_prioridades mensajes_prioridades_id_prioridad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_prioridades
    ADD CONSTRAINT mensajes_prioridades_id_prioridad_fkey FOREIGN KEY (id_prioridad) REFERENCES public.prioridades(id_prioridad);


-- Completed on 2025-03-02 11:24:39

--
-- PostgreSQL database dump complete
--

