--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acts_as_metatags_meta_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE acts_as_metatags_meta_tags (
    id integer NOT NULL,
    prefix character varying(255),
    separator character varying(255),
    suffix character varying(255),
    keywords text,
    description character varying(255),
    properties hstore,
    custom hstore,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: acts_as_metatags_meta_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE acts_as_metatags_meta_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: acts_as_metatags_meta_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE acts_as_metatags_meta_tags_id_seq OWNED BY acts_as_metatags_meta_tags.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    title character varying(255),
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    meta_tag_id integer
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY acts_as_metatags_meta_tags ALTER COLUMN id SET DEFAULT nextval('acts_as_metatags_meta_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: acts_as_metatags_meta_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY acts_as_metatags_meta_tags
    ADD CONSTRAINT acts_as_metatags_meta_tags_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: index_acts_as_metatags_meta_tags_on_custom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_acts_as_metatags_meta_tags_on_custom ON acts_as_metatags_meta_tags USING gist (custom);


--
-- Name: index_acts_as_metatags_meta_tags_on_properties; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_acts_as_metatags_meta_tags_on_properties ON acts_as_metatags_meta_tags USING gist (properties);


--
-- Name: index_pages_on_metatag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pages_on_metatag_id ON pages USING btree (meta_tag_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130906231315');

INSERT INTO schema_migrations (version) VALUES ('20130906233429');

INSERT INTO schema_migrations (version) VALUES ('20130907040011');

INSERT INTO schema_migrations (version) VALUES ('20130907045404');

INSERT INTO schema_migrations (version) VALUES ('20130907054511');