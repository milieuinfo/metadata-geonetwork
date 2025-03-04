--liquibase formatted sql
--changeset joachim:00000

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0 (Debian 15.0-1.pgdg110+1)
-- Dumped by pg_dump version 15.1

-- Started on 2023-02-15 10:17:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- Assume this schema is already there - postgresql automatically creates it when generating the database
--CREATE SCHEMA public;

--
-- TOC entry 3917 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16389)
-- Name: address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.address (
    id integer NOT NULL,
    address character varying(255),
    city character varying(255),
    country character varying(255),
    state character varying(255),
    zip character varying(16)
);


--
-- TOC entry 280 (class 1259 OID 16823)
-- Name: address_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.address_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 215 (class 1259 OID 16396)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16401)
-- Name: categoriesdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoriesdes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 281 (class 1259 OID 16824)
-- Name: csw_server_capabilities_info_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.csw_server_capabilities_info_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 217 (class 1259 OID 16406)
-- Name: customelementset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customelementset (
    xpathhashcode integer NOT NULL,
    xpath character varying(1000) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16413)
-- Name: email; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email (
    user_id integer NOT NULL,
    email character varying(255)
);


--
-- TOC entry 219 (class 1259 OID 16416)
-- Name: files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files (
    id integer NOT NULL,
    content oid NOT NULL,
    mimetype character varying(255) NOT NULL
);


--
-- TOC entry 282 (class 1259 OID 16825)
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 220 (class 1259 OID 16421)
-- Name: group_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_category (
    group_id integer NOT NULL,
    category_id integer NOT NULL
);


--
-- TOC entry 283 (class 1259 OID 16826)
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 221 (class 1259 OID 16424)
-- Name: groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    description character varying(255),
    email character varying(128),
    enablecategoriesrestriction character(1) DEFAULT 'n'::bpchar,
    logo character varying(255),
    name character varying(32) NOT NULL,
    referrer integer,
    website character varying(255),
    defaultcategory_id integer
);


--
-- TOC entry 222 (class 1259 OID 16432)
-- Name: groupsdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groupsdes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16437)
-- Name: guf_keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guf_keywords (
    id bigint NOT NULL,
    value character varying(255)
);


--
-- TOC entry 224 (class 1259 OID 16442)
-- Name: guf_rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guf_rating (
    id bigint NOT NULL,
    rating integer,
    criteria_id integer,
    userfeedback_id character varying(255)
);


--
-- TOC entry 225 (class 1259 OID 16447)
-- Name: guf_ratingcriteria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guf_ratingcriteria (
    id integer NOT NULL,
    isinternal character(1) DEFAULT 'y'::bpchar NOT NULL,
    name character varying(32) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16453)
-- Name: guf_ratingcriteriades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guf_ratingcriteriades (
    iddes integer NOT NULL,
    label character varying(2000) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16460)
-- Name: guf_userfeedback_keyword; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guf_userfeedback_keyword (
    userfeedback_uuid character varying(255) NOT NULL,
    keyword_id bigint NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 16465)
-- Name: guf_userfeedbacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guf_userfeedbacks (
    uuid character varying(255) NOT NULL,
    authoremail character varying(255),
    authorname character varying(255),
    authororganization character varying(255),
    authorprivacy integer,
    commenttext character varying(255),
    creationdate timestamp without time zone,
    status character varying(255) NOT NULL,
    approver_id integer,
    author_id integer,
    metadata_uuid character varying(255),
    parent_uuid character varying(255)
);


--
-- TOC entry 229 (class 1259 OID 16472)
-- Name: guf_userfeedbacks_guf_rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guf_userfeedbacks_guf_rating (
    guf_userfeedback_uuid character varying(255) NOT NULL,
    detailedratinglist_id bigint NOT NULL
);


--
-- TOC entry 284 (class 1259 OID 16827)
-- Name: gufkey_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gufkey_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 285 (class 1259 OID 16828)
-- Name: gufrat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gufrat_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 286 (class 1259 OID 16829)
-- Name: harvest_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.harvest_history_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 287 (class 1259 OID 16830)
-- Name: harvester_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.harvester_setting_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 230 (class 1259 OID 16475)
-- Name: harvesterdata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.harvesterdata (
    harvesteruuid character varying(255) NOT NULL,
    keyvalue character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 16482)
-- Name: harvestersettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.harvestersettings (
    id integer NOT NULL,
    encrypted character(1) DEFAULT 'n'::bpchar NOT NULL,
    name character varying(255) NOT NULL,
    value text,
    parentid integer
);


--
-- TOC entry 232 (class 1259 OID 16490)
-- Name: harvesthistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.harvesthistory (
    id integer NOT NULL,
    deleted character(1) NOT NULL,
    elapsedtime integer,
    harvestdate character varying(30),
    harvestername character varying(255),
    harvestertype character varying(255),
    harvesteruuid character varying(255),
    info text,
    params text
);


--
-- TOC entry 288 (class 1259 OID 16831)
-- Name: inspire_atom_feed_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inspire_atom_feed_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 233 (class 1259 OID 16497)
-- Name: inspireatomfeed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inspireatomfeed (
    id integer NOT NULL,
    atom text,
    atomdatasetid character varying(255),
    atomdatasetns character varying(255),
    atomurl character varying(255),
    authoremail character varying(255),
    authorname character varying(255),
    lang character varying(3),
    metadataid integer NOT NULL,
    rights character varying(255),
    subtitle character varying(255),
    title character varying(255)
);


--
-- TOC entry 234 (class 1259 OID 16504)
-- Name: inspireatomfeed_entrylist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inspireatomfeed_entrylist (
    inspireatomfeed_id integer NOT NULL,
    crs character varying(255),
    id integer NOT NULL,
    lang character varying(3),
    title character varying(255),
    type character varying(255),
    url character varying(255)
);


--
-- TOC entry 289 (class 1259 OID 16832)
-- Name: iso_language_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.iso_language_id_seq
    START WITH 10000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 235 (class 1259 OID 16509)
-- Name: isolanguages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.isolanguages (
    id integer NOT NULL,
    code character varying(3) NOT NULL,
    shortcode character varying(2)
);


--
-- TOC entry 236 (class 1259 OID 16514)
-- Name: isolanguagesdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.isolanguagesdes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 16519)
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    id character varying(5) NOT NULL,
    isdefault character(1),
    isinspire character(1),
    name character varying(255) NOT NULL
);


--
-- TOC entry 290 (class 1259 OID 16833)
-- Name: link_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 238 (class 1259 OID 16524)
-- Name: links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.links (
    id integer NOT NULL,
    dateandtime character varying(30),
    laststate integer,
    linktype character varying(255) NOT NULL,
    protocol character varying(255),
    url text
);


--
-- TOC entry 239 (class 1259 OID 16531)
-- Name: linkstatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.linkstatus (
    id integer NOT NULL,
    batchkey character varying(255),
    checkdate character varying(30),
    failing character(1) DEFAULT 'y'::bpchar NOT NULL,
    statusinfo text,
    statusvalue character varying(255) NOT NULL,
    link integer NOT NULL
);


--
-- TOC entry 291 (class 1259 OID 16834)
-- Name: linkstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.linkstatus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 292 (class 1259 OID 16835)
-- Name: mapserver_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mapserver_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 240 (class 1259 OID 16539)
-- Name: mapservers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mapservers (
    id integer NOT NULL,
    configurl character varying(255) NOT NULL,
    description character varying(255),
    name character varying(32) NOT NULL,
    namespace character varying(255),
    namespaceprefix character varying(255),
    password character varying(128),
    pushstyleinworkspace character(1),
    stylerurl character varying(255),
    username character varying(128),
    wcsurl character varying(255),
    wfsurl character varying(255),
    wmsurl character varying(255)
);


--
-- TOC entry 293 (class 1259 OID 16836)
-- Name: message_producer_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.message_producer_entity_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 241 (class 1259 OID 16546)
-- Name: messageproducerentity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messageproducerentity (
    id bigint NOT NULL,
    cronexpression character varying(255),
    metadatauuid character varying(255),
    strategy character varying(255),
    typename character varying(255),
    url character varying(255)
);


--
-- TOC entry 242 (class 1259 OID 16553)
-- Name: metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadata (
    id integer NOT NULL,
    data text NOT NULL,
    changedate character varying(30) NOT NULL,
    createdate character varying(30) NOT NULL,
    displayorder integer,
    doctype character varying(255),
    extra character varying(255),
    popularity integer NOT NULL,
    rating integer NOT NULL,
    root character varying(255),
    schemaid character varying(32) NOT NULL,
    title character varying(255),
    istemplate character(1) NOT NULL,
    isharvested character(1) NOT NULL,
    harvesturi character varying(512),
    harvestuuid character varying(255),
    groupowner integer,
    owner integer NOT NULL,
    source character varying(255) NOT NULL,
    uuid character varying(255) NOT NULL
);


--
-- TOC entry 294 (class 1259 OID 16837)
-- Name: metadata_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metadata_category_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 295 (class 1259 OID 16838)
-- Name: metadata_filedownload_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metadata_filedownload_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 296 (class 1259 OID 16839)
-- Name: metadata_fileupload_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metadata_fileupload_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 297 (class 1259 OID 16840)
-- Name: metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metadata_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 298 (class 1259 OID 16841)
-- Name: metadata_identifier_template_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metadata_identifier_template_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 243 (class 1259 OID 16560)
-- Name: metadatacateg; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadatacateg (
    metadataid integer NOT NULL,
    categoryid integer NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 16565)
-- Name: metadatadraft; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadatadraft (
    id integer NOT NULL,
    data text NOT NULL,
    changedate character varying(30) NOT NULL,
    createdate character varying(30) NOT NULL,
    displayorder integer,
    doctype character varying(255),
    extra character varying(255),
    popularity integer NOT NULL,
    rating integer NOT NULL,
    root character varying(255),
    schemaid character varying(32) NOT NULL,
    title character varying(255),
    istemplate character(1) NOT NULL,
    isharvested character(1) NOT NULL,
    harvesturi character varying(512),
    harvestuuid character varying(255),
    groupowner integer,
    owner integer NOT NULL,
    source character varying(255) NOT NULL,
    uuid character varying(255) NOT NULL,
    approvedversion_id integer NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 16572)
-- Name: metadatafiledownloads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadatafiledownloads (
    id integer NOT NULL,
    downloaddate character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    fileuploadid integer NOT NULL,
    metadataid integer NOT NULL,
    requestercomments character varying(255),
    requestermail character varying(255),
    requestername character varying(255),
    requesterorg character varying(255),
    username character varying(255)
);


--
-- TOC entry 246 (class 1259 OID 16579)
-- Name: metadatafileuploads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadatafileuploads (
    id integer NOT NULL,
    deleteddate character varying(255),
    filename character varying(255) NOT NULL,
    filesize double precision NOT NULL,
    metadataid integer NOT NULL,
    uploaddate character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 16586)
-- Name: metadataidentifiertemplate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadataidentifiertemplate (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    isprovided character(1) DEFAULT 'n'::bpchar NOT NULL,
    template character varying(255) NOT NULL
);


--
-- TOC entry 248 (class 1259 OID 16592)
-- Name: metadatalink; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadatalink (
    linkid integer NOT NULL,
    metadataid integer NOT NULL,
    metadatauuid character varying(255)
);


--
-- TOC entry 249 (class 1259 OID 16597)
-- Name: metadatarating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadatarating (
    ipaddress character varying(45) NOT NULL,
    metadataid integer NOT NULL,
    rating integer NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 16602)
-- Name: metadatastatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metadatastatus (
    id integer NOT NULL,
    changedate character varying(30) NOT NULL,
    changemessage character varying(2048) NOT NULL,
    closedate character varying(30),
    currentstate text,
    duedate character varying(30),
    metadataid integer NOT NULL,
    owner integer NOT NULL,
    previousstate text,
    titles text,
    userid integer NOT NULL,
    uuid character varying(255) NOT NULL,
    relatedmetadatastatusid integer,
    statusid integer NOT NULL
);


--
-- TOC entry 299 (class 1259 OID 16842)
-- Name: metadatastatus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metadatastatus_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 300 (class 1259 OID 16843)
-- Name: operation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.operation_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 251 (class 1259 OID 16609)
-- Name: operationallowed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.operationallowed (
    groupid integer NOT NULL,
    metadataid integer NOT NULL,
    operationid integer NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 16614)
-- Name: operations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.operations (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 16619)
-- Name: operationsdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.operationsdes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 301 (class 1259 OID 16844)
-- Name: rating_criteria_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rating_criteria_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 254 (class 1259 OID 16624)
-- Name: relations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relations (
    id integer NOT NULL,
    relatedid integer NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 16629)
-- Name: schematron; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schematron (
    id integer NOT NULL,
    displaypriority integer NOT NULL,
    filename character varying(255) NOT NULL,
    schemaname character varying(255) NOT NULL
);


--
-- TOC entry 302 (class 1259 OID 16845)
-- Name: schematron_criteria_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schematron_criteria_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 303 (class 1259 OID 16846)
-- Name: schematron_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schematron_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 256 (class 1259 OID 16636)
-- Name: schematroncriteria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schematroncriteria (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    uitype character varying(255),
    uivalue character varying(255),
    value character varying(255) NOT NULL,
    group_name character varying(255) NOT NULL,
    group_schematronid integer NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 16643)
-- Name: schematroncriteriagroup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schematroncriteriagroup (
    name character varying(255) NOT NULL,
    schematronid integer NOT NULL,
    requirement character varying(255) NOT NULL
);


--
-- TOC entry 258 (class 1259 OID 16650)
-- Name: schematrondes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schematrondes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 304 (class 1259 OID 16847)
-- Name: selection_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.selection_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 259 (class 1259 OID 16655)
-- Name: selections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.selections (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    iswatchable character(1) NOT NULL
);


--
-- TOC entry 260 (class 1259 OID 16660)
-- Name: selectionsdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.selectionsdes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 261 (class 1259 OID 16665)
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    name character varying(255) NOT NULL,
    datatype integer,
    editable character(1) DEFAULT 'y'::bpchar NOT NULL,
    encrypted character(1) DEFAULT 'n'::bpchar NOT NULL,
    internal character(1) DEFAULT 'y'::bpchar NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    value text
);


--
-- TOC entry 262 (class 1259 OID 16676)
-- Name: settings_cssstyle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings_cssstyle (
    variable character varying(255) NOT NULL,
    value character varying(255)
);


--
-- TOC entry 263 (class 1259 OID 16683)
-- Name: settings_ui; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings_ui (
    id character varying(255) NOT NULL,
    configuration text
);


--
-- TOC entry 264 (class 1259 OID 16690)
-- Name: sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sources (
    uuid character varying(255) NOT NULL,
    creationdate character varying(30),
    filter character varying(255),
    groupowner integer,
    islistableinheaderselector character(1) DEFAULT 'y'::bpchar NOT NULL,
    logo character varying(255),
    name character varying(255),
    servicerecord character varying(255),
    type character varying(255),
    uiconfig character varying(255)
);


--
-- TOC entry 265 (class 1259 OID 16698)
-- Name: sourcesdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sourcesdes (
    iddes character varying(255) NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 266 (class 1259 OID 16705)
-- Name: spg_page; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spg_page (
    language character varying(255) NOT NULL,
    linktext character varying(255) NOT NULL,
    data oid,
    format character varying(255) NOT NULL,
    link character varying(255),
    status character varying(255) NOT NULL
);


--
-- TOC entry 267 (class 1259 OID 16712)
-- Name: spg_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spg_sections (
    spg_page_language character varying(255) NOT NULL,
    spg_page_linktext character varying(255) NOT NULL,
    section character varying(255)
);


--
-- TOC entry 305 (class 1259 OID 16848)
-- Name: status_value_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.status_value_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 268 (class 1259 OID 16717)
-- Name: statusvalues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statusvalues (
    id integer NOT NULL,
    displayorder integer,
    name character varying(255) NOT NULL,
    notificationlevel character varying(255),
    reserved character(1) NOT NULL,
    type character varying(255)
);


--
-- TOC entry 269 (class 1259 OID 16724)
-- Name: statusvaluesdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statusvaluesdes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 270 (class 1259 OID 16729)
-- Name: thesaurus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.thesaurus (
    id character varying(255) NOT NULL,
    activated character(1) NOT NULL
);


--
-- TOC entry 271 (class 1259 OID 16734)
-- Name: translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.translations (
    idfield integer NOT NULL,
    field character varying(255) NOT NULL,
    langid character varying(5) NOT NULL,
    label text
);


--
-- TOC entry 306 (class 1259 OID 16849)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 307 (class 1259 OID 16850)
-- Name: user_search_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_search_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 272 (class 1259 OID 16741)
-- Name: useraddress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.useraddress (
    userid integer NOT NULL,
    addressid integer NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 16746)
-- Name: usergroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usergroups (
    groupid integer NOT NULL,
    profile integer NOT NULL,
    userid integer NOT NULL
);


--
-- TOC entry 274 (class 1259 OID 16751)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    isenabled character(1) DEFAULT 'y'::bpchar NOT NULL,
    kind character varying(16),
    lastlogindate character varying(255),
    name character varying(255),
    organisation character varying(255),
    profile integer NOT NULL,
    authtype character varying(32),
    nodeid character varying(255),
    password character varying(120) NOT NULL,
    security character varying(128),
    surname character varying(255),
    username character varying(255) NOT NULL
);


--
-- TOC entry 275 (class 1259 OID 16759)
-- Name: usersavedselections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usersavedselections (
    metadatauuid character varying(255) NOT NULL,
    selectionid integer NOT NULL,
    userid integer NOT NULL
);


--
-- TOC entry 276 (class 1259 OID 16764)
-- Name: usersearch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usersearch (
    id integer NOT NULL,
    creationdate timestamp without time zone,
    featuredtype character(1),
    logo character varying(255),
    url text,
    creator_id integer
);


--
-- TOC entry 277 (class 1259 OID 16771)
-- Name: usersearch_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usersearch_group (
    usersearch_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- TOC entry 278 (class 1259 OID 16776)
-- Name: usersearchdes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usersearchdes (
    iddes integer NOT NULL,
    label character varying(255) NOT NULL,
    langid character varying(5) NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 16781)
-- Name: validation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.validation (
    metadataid integer NOT NULL,
    valtype character varying(128) NOT NULL,
    failed integer,
    tested integer,
    reportcontent text,
    reporturl character varying(255),
    required boolean,
    status integer NOT NULL,
    valdate character varying(30)
);


--
-- TOC entry 3818 (class 0 OID 16389)
-- Dependencies: 214
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.address VALUES
	(0, '', '', '', '', ''),
	(1, '', '', '', '', '');


--
-- TOC entry 3819 (class 0 OID 16396)
-- Dependencies: 215
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories VALUES
	(1, 'maps'),
	(2, 'datasets'),
	(3, 'interactiveResources'),
	(4, 'applications'),
	(5, 'caseStudies'),
	(6, 'proceedings'),
	(7, 'photo'),
	(8, 'audioVideo'),
	(9, 'directories'),
	(10, 'otherResources'),
	(12, 'registers'),
	(13, 'physicalSamples');


--
-- TOC entry 3820 (class 0 OID 16401)
-- Dependencies: 216
-- Data for Name: categoriesdes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categoriesdes VALUES
	(1, 'Maps & graphics', 'eng'),
	(2, 'Datasets', 'eng'),
	(3, 'Interactive resources', 'eng'),
	(4, 'Applications', 'eng'),
	(5, 'Case studies, best practices', 'eng'),
	(6, 'Conference proceedings', 'eng'),
	(7, 'Photo', 'eng'),
	(8, 'Audio/Video', 'eng'),
	(9, 'Directories', 'eng'),
	(10, 'Other information resources', 'eng'),
	(12, 'Registers', 'eng'),
	(13, 'Physical Samples', 'eng'),
	(2, 'Jeux de données', 'fre'),
	(1, 'Cartes & graphiques', 'fre'),
	(7, 'Photographies', 'fre'),
	(10, 'Autres ressources', 'fre'),
	(5, 'Etude de cas, meilleures pratiques', 'fre'),
	(8, 'Vidéo/Audio', 'fre'),
	(9, 'Répertoires', 'fre'),
	(4, 'Applications', 'fre'),
	(3, 'Ressources interactives', 'fre'),
	(6, 'Conférences', 'fre'),
	(12, 'Annuaires', 'fre'),
	(13, 'Echantillons physiques', 'fre'),
	(1, 'Karten & Grafiken', 'ger'),
	(2, 'Datensets', 'ger'),
	(3, 'Interaktive Resourcen', 'ger'),
	(4, 'Applikationen', 'ger'),
	(5, 'Fallstudien', 'ger'),
	(6, 'Konferenz Ergebnisse', 'ger'),
	(7, 'Photo', 'ger'),
	(8, 'Audio/Video', 'ger'),
	(9, 'Verzeichnisse', 'ger'),
	(10, 'Andere Resourcen', 'ger'),
	(12, 'Registers', 'ger'),
	(13, 'Physischen Proben', 'ger'),
	(2, 'Conjuntos de datos', 'spa'),
	(3, 'Recursos interactivos', 'spa'),
	(5, 'Casos de Uso, buenas prácticas', 'spa'),
	(4, 'Aplicaciones', 'spa'),
	(6, 'Resúmenes de conferencias', 'spa'),
	(7, 'Fotografías', 'spa'),
	(9, 'Directorios', 'spa'),
	(8, 'Audio/Vídeo', 'spa'),
	(10, 'Otros recursos de información', 'spa'),
	(1, 'Mapas & gráficos', 'spa'),
	(12, 'Registers', 'spa'),
	(13, 'Muestras físicas', 'spa'),
	(1, 'Mapes i gràfics', 'cat'),
	(2, 'Conjunts de dades', 'cat');
INSERT INTO public.categoriesdes VALUES
	(3, 'Recursos interactius', 'cat'),
	(4, 'Aplicacions', 'cat'),
	(5, 'Casos d''ús, bones pràctiques', 'cat'),
	(6, 'Actes de conferències', 'cat'),
	(7, 'Foto', 'cat'),
	(8, 'Àudio/Vídeo', 'cat'),
	(9, 'Directoris', 'cat'),
	(10, 'Altres recursos d''informació', 'cat'),
	(12, 'Registers', 'cat'),
	(13, 'Physical Samples', 'cat'),
	(1, 'Карты и графика', 'rus'),
	(2, 'Наборы данных', 'rus'),
	(3, 'Интерактивные ресурсы', 'rus'),
	(4, 'Компьютерные программы', 'rus'),
	(5, 'Практические ситуации', 'rus'),
	(6, 'Материалы конференций', 'rus'),
	(7, 'Фотографии', 'rus'),
	(8, 'Аудио/Видео', 'rus'),
	(9, 'Каталоги/справочники', 'rus'),
	(10, 'Другие ресурсы', 'rus'),
	(12, 'Registers', 'rus'),
	(13, 'Физические образцы', 'rus'),
	(1, 'Mapas & Graficos', 'por'),
	(2, 'Datasets', 'por'),
	(3, 'Fontes Interactivas', 'por'),
	(4, 'Aplicações', 'por'),
	(5, 'Estudos de Caso, Boas Praticas', 'por'),
	(6, 'Procedimentos de Validação', 'por'),
	(7, 'Foto', 'por'),
	(8, 'Audio/Video', 'por'),
	(9, 'Directorios', 'por'),
	(10, 'Outra Informação sobre Fontes', 'por'),
	(12, 'Registers', 'por'),
	(13, 'Amostras físicas', 'por'),
	(1, 'Maps & graphics', 'chi'),
	(2, 'Datasets', 'chi'),
	(3, 'Interactive resources', 'chi'),
	(4, 'Applications', 'chi'),
	(5, 'Case studies, best practices', 'chi'),
	(6, 'Conference proceedings', 'chi'),
	(7, 'Photo', 'chi'),
	(8, 'Audio/Video', 'chi'),
	(9, 'Directories', 'chi'),
	(10, 'Other information resources', 'chi'),
	(12, 'Registers', 'chi'),
	(13, 'Physical Samples', 'chi'),
	(1, 'Kaarten & afbeeldingen', 'dut'),
	(2, 'Datasets', 'dut'),
	(3, 'Interactieve kaarten', 'dut'),
	(4, 'Toepassingen', 'dut');
INSERT INTO public.categoriesdes VALUES
	(5, 'Case studies, best practices', 'dut'),
	(6, 'Conferentie handelingen', 'dut'),
	(7, 'Fotos', 'dut'),
	(8, 'Audio/Video', 'dut'),
	(9, 'Catalogi', 'dut'),
	(10, 'Andere informatie bronnen', 'dut'),
	(12, 'Registers', 'dut'),
	(13, 'Fysieke monsters', 'dut'),
	(1, 'Kart og grafikk', 'nor'),
	(2, 'Datasett', 'nor'),
	(3, 'Interakive ressurser', 'nor'),
	(4, 'Applikasjoner', 'nor'),
	(5, 'Studier og anbefalinger', 'nor'),
	(6, 'Konferanseresultater', 'nor'),
	(7, 'Fotografier', 'nor'),
	(8, 'Audio/Video', 'nor'),
	(9, 'Kataloger', 'nor'),
	(10, 'Andre ressurser', 'nor'),
	(12, 'Registers', 'nor'),
	(13, 'Physical Samples', 'nor'),
	(1, 'Kartat & kuvat', 'fin'),
	(2, 'Tietoaineistot', 'fin'),
	(3, 'Vuorovaikutteiset resurssit', 'fin'),
	(4, 'Sovellukset', 'fin'),
	(5, 'Esimerkkitapaukset, parhaat käytännöt', 'fin'),
	(6, 'Konferenssijulkaisut', 'fin'),
	(7, 'Valokuvat', 'fin'),
	(8, 'Äänitteet / Videot', 'fin'),
	(9, 'Hakemistot', 'fin'),
	(10, 'Other information resources', 'fin'),
	(12, 'Registers', 'fin'),
	(13, 'Fyysisiä näytteitä', 'fin'),
	(1, 'Maps & graphics', 'ara'),
	(2, 'Datasets', 'ara'),
	(3, 'Interactive resources', 'ara'),
	(4, 'Applications', 'ara'),
	(5, 'Case studies, best practices', 'ara'),
	(6, 'Conference proceedings', 'ara'),
	(7, 'Photo', 'ara'),
	(8, 'Audio/Video', 'ara'),
	(9, 'Directories', 'ara'),
	(10, 'Other information resources', 'ara'),
	(12, 'Registers', 'ara'),
	(13, 'Physical Samples', 'ara'),
	(1, 'Mappe e grafici', 'ita'),
	(2, 'Datasets', 'ita'),
	(3, 'Risorse interattive', 'ita'),
	(4, 'Applicazioni', 'ita'),
	(5, 'Casi di studio', 'ita'),
	(6, 'Atti di conferenze', 'ita');
INSERT INTO public.categoriesdes VALUES
	(7, 'Fotografie', 'ita'),
	(8, 'Audio/Video', 'ita'),
	(9, 'Archivi', 'ita'),
	(10, 'Altre risorse di informazione', 'ita'),
	(12, 'Registri', 'ita'),
	(13, 'campioni fisici', 'ita'),
	(1, 'Haritalar & grafikler', 'tur'),
	(2, 'Verisetleri', 'tur'),
	(3, 'Interaktif kaynaklar', 'tur'),
	(4, 'Uygulamalar', 'tur'),
	(5, 'Örnek çalışmalar, başarılı uygulamalar', 'tur'),
	(6, 'Konferans bildirileri', 'tur'),
	(7, 'Fotoğraf', 'tur'),
	(8, 'Ses/Video', 'tur'),
	(9, 'Dizinler', 'tur'),
	(10, 'Diğer bilgi kaynakları', 'tur'),
	(12, 'Kayıtlar', 'tur'),
	(13, 'Fiziksel Örnekleri', 'tur'),
	(1, 'Maps & graphics', 'vie'),
	(2, 'Datasets', 'vie'),
	(3, 'Interactive resources', 'vie'),
	(4, 'Applications', 'vie'),
	(5, 'Case studies, best practices', 'vie'),
	(6, 'Conference proceedings', 'vie'),
	(7, 'Photo', 'vie'),
	(8, 'Audio/Video', 'vie'),
	(9, 'Directories', 'vie'),
	(10, 'Other information resources', 'vie'),
	(12, 'Registers', 'vie'),
	(13, 'Physical Samples', 'vie'),
	(1, 'Mapy i grafika', 'pol'),
	(2, 'Zbiory danych', 'pol'),
	(3, 'Źródła interaktywne', 'pol'),
	(4, 'Aplikacje', 'pol'),
	(5, 'Badania, najlepsze praktyki', 'pol'),
	(6, 'Materiały konferencyjne', 'pol'),
	(7, 'Zdjęcia', 'pol'),
	(8, 'Audio/Wideo', 'pol'),
	(9, 'Katalogi', 'pol'),
	(10, 'Inne źródła informacji', 'pol'),
	(12, 'Rejestry', 'pol'),
	(13, 'Physical Samples', 'pol'),
	(1, 'Maps & graphics [SK]', 'slo'),
	(2, 'Datasets [SK]', 'slo'),
	(3, 'Interactive resources [SK]', 'slo'),
	(4, 'Applications [SK]', 'slo'),
	(5, 'Case studies, best practices [SK]', 'slo'),
	(6, 'Conference proceedings [SK]', 'slo'),
	(7, 'Photo [SK]', 'slo'),
	(8, 'Audio/Video [SK]', 'slo');
INSERT INTO public.categoriesdes VALUES
	(9, 'Directories [SK]', 'slo'),
	(10, 'Other information resources [SK]', 'slo'),
	(12, 'Registers [SK]', 'slo'),
	(13, 'Physical Samples [SK]', 'slo'),
	(1, 'Kartor och grafik', 'swe'),
	(2, 'Datamängder', 'swe'),
	(3, 'Interaktiva resurser', 'swe'),
	(4, 'Applikationer', 'swe'),
	(5, 'Typfall, god praxis', 'swe'),
	(6, 'Konferensmaterial', 'swe'),
	(7, 'Foto', 'swe'),
	(8, 'Ljud/Film', 'swe'),
	(9, 'Kataloger', 'swe'),
	(10, 'Andra källor', 'swe'),
	(12, 'Register', 'swe'),
	(13, 'Fysiska exemplar', 'swe');


--
-- TOC entry 3821 (class 0 OID 16406)
-- Dependencies: 217
-- Data for Name: customelementset; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3822 (class 0 OID 16413)
-- Dependencies: 218
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3823 (class 0 OID 16416)
-- Dependencies: 219
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3824 (class 0 OID 16421)
-- Dependencies: 220
-- Data for Name: group_category; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3825 (class 0 OID 16424)
-- Dependencies: 221
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.groups VALUES
	(-1, 'self-registered users', NULL, 'n', NULL, 'GUEST', NULL, NULL, NULL),
	(0, NULL, NULL, 'n', NULL, 'intranet', NULL, NULL, NULL),
	(1, NULL, NULL, 'n', NULL, 'all', NULL, NULL, NULL),
	(2, NULL, NULL, 'n', NULL, 'sample', NULL, NULL, NULL);


--
-- TOC entry 3826 (class 0 OID 16432)
-- Dependencies: 222
-- Data for Name: groupsdes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.groupsdes VALUES
	(-1, 'Guest', 'eng'),
	(0, 'Intranet', 'eng'),
	(1, 'All', 'eng'),
	(2, 'Sample group', 'eng'),
	(-1, 'Invité', 'fre'),
	(0, 'Intranet', 'fre'),
	(1, 'Tous', 'fre'),
	(2, 'Groupe exemple', 'fre'),
	(-1, 'Gast', 'ger'),
	(0, 'Intranet', 'ger'),
	(1, 'Alle', 'ger'),
	(2, 'Beispielgruppe', 'ger'),
	(-1, 'Guest', 'spa'),
	(0, 'Intranet', 'spa'),
	(1, 'Todos', 'spa'),
	(2, 'Grupo de ejemplo', 'spa'),
	(-1, 'Guest', 'cat'),
	(0, 'Intranet', 'cat'),
	(1, 'All', 'cat'),
	(2, 'Sample group', 'cat'),
	(-1, 'Guest', 'rus'),
	(0, 'Пример группы', 'rus'),
	(1, 'Все', 'rus'),
	(2, 'Пример группы', 'rus'),
	(-1, 'Convidado', 'por'),
	(0, 'Intranet', 'por'),
	(1, 'Todos', 'por'),
	(2, 'Grupo de Amostra', 'por'),
	(-1, 'Guest', 'chi'),
	(0, 'Intranet', 'chi'),
	(1, 'All', 'chi'),
	(2, 'Sample group', 'chi'),
	(-1, 'Gast', 'dut'),
	(0, 'Intranet', 'dut'),
	(1, 'Iedereen', 'dut'),
	(2, 'Voorbeeldgroep', 'dut'),
	(-1, 'Gjest', 'nor'),
	(0, 'Intranett', 'nor'),
	(1, 'Alle', 'nor'),
	(2, 'Eksempelgruppe', 'nor'),
	(-1, 'Vierailija', 'fin'),
	(0, 'Intranet', 'fin'),
	(1, 'Kaikki', 'fin'),
	(2, 'Ryhmä', 'fin'),
	(-1, 'Guest', 'ara'),
	(0, 'Intranet', 'ara'),
	(1, 'All', 'ara'),
	(2, 'Sample group', 'ara'),
	(-1, 'Visitatore', 'ita'),
	(0, 'Intranet', 'ita');
INSERT INTO public.groupsdes VALUES
	(1, 'Tutti', 'ita'),
	(2, 'Gruppo di esempio', 'ita'),
	(-1, 'Misafir', 'tur'),
	(0, 'Çevrimiçi', 'tur'),
	(1, 'Tüm', 'tur'),
	(2, 'Örnek Grup', 'tur'),
	(-1, 'Guest', 'vie'),
	(0, 'Intranet', 'vie'),
	(1, 'All', 'vie'),
	(2, 'Sample group', 'vie'),
	(-1, 'Gość', 'pol'),
	(0, 'Intranet', 'pol'),
	(1, 'Wszyscy', 'pol'),
	(2, 'Przykładowa grupa', 'pol'),
	(-1, 'Guest [SK]', 'slo'),
	(0, 'Intranet [SK]', 'slo'),
	(1, 'All [SK]', 'slo'),
	(2, 'Sample group [SK]', 'slo'),
	(-1, 'Gäst', 'swe'),
	(0, 'Intranät', 'swe'),
	(1, 'All', 'swe'),
	(2, 'Exempelgrupp', 'swe');


--
-- TOC entry 3827 (class 0 OID 16437)
-- Dependencies: 223
-- Data for Name: guf_keywords; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3828 (class 0 OID 16442)
-- Dependencies: 224
-- Data for Name: guf_rating; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3829 (class 0 OID 16447)
-- Dependencies: 225
-- Data for Name: guf_ratingcriteria; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.guf_ratingcriteria VALUES
	(-1, 'y', 'Average'),
	(0, 'n', 'Completeness'),
	(1, 'n', 'Discoverability'),
	(2, 'n', 'Readability'),
	(3, 'n', 'DataQuality'),
	(4, 'n', 'ServiceQuality');


--
-- TOC entry 3830 (class 0 OID 16453)
-- Dependencies: 226
-- Data for Name: guf_ratingcriteriades; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.guf_ratingcriteriades VALUES
	(-1, 'Average', 'eng'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'eng'),
	(1, 'Discoverability#Was it easy to find this information page?', 'eng'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'eng'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'eng'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'eng'),
	(-1, 'Moyenne', 'fre'),
	(0, 'Complétude#Est-ce que les informations sur cette page sont suffisamment précises pour savoir ce que vous pouvez attendre de cette ressource ?', 'fre'),
	(1, 'Découvrabilité#Était-il facile de trouver cette page ?', 'fre'),
	(2, 'Lisibilité#Était-il facile de comprendre le contenu de cette page ?', 'fre'),
	(3, 'Qualité des données#Est-ce que cette ressource contient les informations attendues ? Les données sont-elles assez précises ? assez récentes ?', 'fre'),
	(4, 'Cette données est elle accessible dans un format ou via un service simple à utiliser ?', 'fre'),
	(-1, 'Average', 'ger'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'ger'),
	(1, 'Discoverability#Was it easy to find this information page?', 'ger'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'ger'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'ger'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'ger'),
	(-1, 'Average', 'spa'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'spa'),
	(1, 'Discoverability#Was it easy to find this information page?', 'spa'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'spa'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'spa'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'spa'),
	(-1, 'Average', 'cat'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'cat'),
	(1, 'Discoverability#Was it easy to find this information page?', 'cat'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'cat'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'cat'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'cat'),
	(-1, 'Average', 'rus'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'rus'),
	(1, 'Discoverability#Was it easy to find this information page?', 'rus'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'rus'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'rus'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'rus'),
	(-1, 'Average', 'por'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'por'),
	(1, 'Discoverability#Was it easy to find this information page?', 'por'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'por'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'por'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'por'),
	(-1, 'Average', 'chi'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'chi'),
	(1, 'Discoverability#Was it easy to find this information page?', 'chi'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'chi'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'chi'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'chi'),
	(-1, 'Gemiddeld', 'dut'),
	(0, 'Volledigheid#Is de informatie op deze pagina volledig genoeg om te weten wat u van deze dataset kunt verwachten?', 'dut');
INSERT INTO public.guf_ratingcriteriades VALUES
	(1, 'Vindbaarheid#Was het gemakkelijk om deze informatiepagina te vinden?', 'dut'),
	(2, 'Leesbaarheid#Was het gemakkelijk om de inhoud van deze pagina te lezen en te begrijpen?', 'dut'),
	(3, 'Data kwaliteit#Bevat de dataset de informatie die je verwachtte, is de dataset voldoende nauwkeurig, zijn de data valide/up-to-date?', 'dut'),
	(4, 'Service kwaliteit#Wordt de dataset geleverd als een service of mediatype waar makkelijk mee te werken is?', 'dut'),
	(-1, 'Average', 'nor'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'nor'),
	(1, 'Discoverability#Was it easy to find this information page?', 'nor'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'nor'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'nor'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'nor'),
	(-1, 'Average', 'fin'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'fin'),
	(1, 'Discoverability#Was it easy to find this information page?', 'fin'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'fin'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'fin'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'fin'),
	(-1, 'Average', 'ara'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'ara'),
	(1, 'Discoverability#Was it easy to find this information page?', 'ara'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'ara'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'ara'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'ara'),
	(-1, 'Average', 'ita'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'ita'),
	(1, 'Discoverability#Was it easy to find this information page?', 'ita'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'ita'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'ita'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'ita'),
	(-1, 'Average', 'tur'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'tur'),
	(1, 'Discoverability#Was it easy to find this information page?', 'tur'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'tur'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'tur'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'tur'),
	(-1, 'Average', 'vie'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'vie'),
	(1, 'Discoverability#Was it easy to find this information page?', 'vie'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'vie'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'vie'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'vie'),
	(-1, 'Average', 'pol'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset?', 'pol'),
	(1, 'Discoverability#Was it easy to find this information page?', 'pol'),
	(2, 'Readability#Was it easy to read and understand the contents of this page?', 'pol'),
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date?', 'pol'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with?', 'pol'),
	(-1, 'Average [SK]', 'slo'),
	(0, 'Completeness#Is the information on this page complete enough to know what you can expect from this dataset? [SK]', 'slo'),
	(1, 'Discoverability#Was it easy to find this information page? [SK]', 'slo'),
	(2, 'Readability#Was it easy to read and understand the contents of this page? [SK]', 'slo');
INSERT INTO public.guf_ratingcriteriades VALUES
	(3, 'Data quality#Does the dataset contain the information you expected, the dataset has enough accuracy, the data is valid/up-to-date? [SK]', 'slo'),
	(4, 'Service quality#The dataset is provided as a service or mediatype that is easy to work with? [SK]', 'slo'),
	(-1, 'Medeltal', 'swe'),
	(0, 'Fullständighet#Är informationen på denna sida tillräcklig för att visa vad du kan vänta dig i denna datamängd?', 'swe'),
	(1, 'Upptäckbarhet#Var det lätt att hitta denna informationssida?', 'swe'),
	(2, 'Läsbarhet#Var det lätt att läsa ich förstå innehållet på denna sida?', 'swe'),
	(3, 'Datakvalitety#Innehåller data den information du väntade, är den korrekt och aktuell?', 'swe'),
	(4, 'Kvalite på tjänst#Tillhandahålls datamängden som en tjänst eller mediatyp som är lätt att arbeta med?', 'swe');


--
-- TOC entry 3831 (class 0 OID 16460)
-- Dependencies: 227
-- Data for Name: guf_userfeedback_keyword; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3832 (class 0 OID 16465)
-- Dependencies: 228
-- Data for Name: guf_userfeedbacks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3833 (class 0 OID 16472)
-- Dependencies: 229
-- Data for Name: guf_userfeedbacks_guf_rating; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3834 (class 0 OID 16475)
-- Dependencies: 230
-- Data for Name: harvesterdata; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3835 (class 0 OID 16482)
-- Dependencies: 231
-- Data for Name: harvestersettings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.harvestersettings VALUES
	(1, 'n', 'harvesting', NULL, NULL);


--
-- TOC entry 3836 (class 0 OID 16490)
-- Dependencies: 232
-- Data for Name: harvesthistory; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3837 (class 0 OID 16497)
-- Dependencies: 233
-- Data for Name: inspireatomfeed; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3838 (class 0 OID 16504)
-- Dependencies: 234
-- Data for Name: inspireatomfeed_entrylist; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3839 (class 0 OID 16509)
-- Dependencies: 235
-- Data for Name: isolanguages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.isolanguages VALUES
	(1, 'aar', 'aa'),
	(2, 'abk', 'ab'),
	(3, 'ace', NULL),
	(4, 'ach', NULL),
	(5, 'ada', NULL),
	(6, 'ady', NULL),
	(7, 'afa', NULL),
	(8, 'afh', NULL),
	(9, 'afr', 'af'),
	(10, 'ain', NULL),
	(11, 'aka', 'ak'),
	(12, 'akk', NULL),
	(13, 'alb', 'sq'),
	(14, 'ale', NULL),
	(15, 'alg', NULL),
	(16, 'alt', NULL),
	(17, 'amh', 'am'),
	(18, 'ang', NULL),
	(19, 'anp', NULL),
	(20, 'apa', NULL),
	(21, 'ara', 'ar'),
	(22, 'arc', NULL),
	(23, 'arg', 'an'),
	(24, 'arm', 'hy'),
	(25, 'arn', NULL),
	(26, 'arp', NULL),
	(27, 'art', NULL),
	(28, 'arw', NULL),
	(29, 'asm', 'as'),
	(30, 'ast', NULL),
	(31, 'ath', NULL),
	(32, 'aus', NULL),
	(33, 'ava', 'av'),
	(34, 'ave', 'ae'),
	(35, 'awa', NULL),
	(36, 'aym', 'ay'),
	(37, 'aze', 'az'),
	(38, 'bad', NULL),
	(39, 'bai', NULL),
	(40, 'bak', 'ba'),
	(41, 'bal', NULL),
	(42, 'bam', 'bm'),
	(43, 'ban', NULL),
	(44, 'baq', 'eu'),
	(45, 'bas', NULL),
	(46, 'bat', NULL),
	(47, 'bej', NULL),
	(48, 'bel', 'be'),
	(49, 'bem', NULL),
	(50, 'ben', 'bn');
INSERT INTO public.isolanguages VALUES
	(51, 'ber', NULL),
	(52, 'bho', NULL),
	(53, 'bih', 'bh'),
	(54, 'bik', NULL),
	(55, 'bin', NULL),
	(56, 'bis', 'bi'),
	(57, 'bla', NULL),
	(58, 'bnt', NULL),
	(59, 'bos', 'bs'),
	(60, 'bra', NULL),
	(61, 'bre', 'br'),
	(62, 'btk', NULL),
	(63, 'bua', NULL),
	(64, 'bug', NULL),
	(65, 'bul', 'bg'),
	(66, 'bur', 'my'),
	(67, 'byn', NULL),
	(68, 'cad', NULL),
	(69, 'cai', NULL),
	(70, 'car', NULL),
	(71, 'cat', 'ca'),
	(72, 'cau', NULL),
	(73, 'ceb', NULL),
	(74, 'cel', NULL),
	(75, 'cha', 'ch'),
	(76, 'chb', NULL),
	(77, 'che', 'ce'),
	(78, 'chg', NULL),
	(79, 'chi', 'zh'),
	(80, 'chk', NULL),
	(81, 'chm', NULL),
	(82, 'chn', NULL),
	(83, 'cho', NULL),
	(84, 'chp', NULL),
	(85, 'chr', NULL),
	(86, 'chu', 'cu'),
	(87, 'chv', 'cv'),
	(88, 'chy', NULL),
	(89, 'cmc', NULL),
	(90, 'cop', NULL),
	(91, 'cor', 'kw'),
	(92, 'cos', 'co'),
	(93, 'cpe', NULL),
	(94, 'cpf', NULL),
	(95, 'cpp', NULL),
	(96, 'cre', 'cr'),
	(97, 'crh', NULL),
	(98, 'crp', NULL),
	(99, 'csb', NULL),
	(100, 'cus', NULL);
INSERT INTO public.isolanguages VALUES
	(101, 'cze', 'cs'),
	(102, 'dak', NULL),
	(103, 'dan', 'da'),
	(104, 'dar', NULL),
	(105, 'day', NULL),
	(106, 'del', NULL),
	(107, 'den', NULL),
	(108, 'dgr', NULL),
	(109, 'din', NULL),
	(110, 'div', 'dv'),
	(111, 'doi', NULL),
	(112, 'dra', NULL),
	(113, 'dsb', NULL),
	(114, 'dua', NULL),
	(115, 'dum', NULL),
	(116, 'dut', 'nl'),
	(117, 'dyu', NULL),
	(118, 'dzo', 'dz'),
	(119, 'efi', NULL),
	(120, 'egy', NULL),
	(121, 'eka', NULL),
	(122, 'elx', NULL),
	(123, 'eng', 'en'),
	(124, 'enm', NULL),
	(125, 'epo', 'eo'),
	(126, 'est', 'et'),
	(127, 'ewe', 'ee'),
	(128, 'ewo', NULL),
	(129, 'fan', NULL),
	(130, 'fao', 'fo'),
	(131, 'fat', NULL),
	(132, 'fij', 'fj'),
	(133, 'fil', NULL),
	(134, 'fin', 'fi'),
	(135, 'fiu', NULL),
	(136, 'fon', NULL),
	(137, 'fre', 'fr'),
	(138, 'frm', NULL),
	(139, 'fro', NULL),
	(140, 'frr', NULL),
	(141, 'frs', NULL),
	(142, 'fry', 'fy'),
	(143, 'ful', 'ff'),
	(144, 'fur', NULL),
	(145, 'gaa', NULL),
	(146, 'gay', NULL),
	(147, 'gba', NULL),
	(148, 'gem', NULL),
	(149, 'geo', 'ka'),
	(150, 'ger', 'de');
INSERT INTO public.isolanguages VALUES
	(151, 'gez', NULL),
	(152, 'gil', NULL),
	(153, 'gla', 'gd'),
	(154, 'gle', 'ga'),
	(155, 'glg', 'gl'),
	(156, 'glv', 'gv'),
	(157, 'gmh', NULL),
	(158, 'goh', NULL),
	(159, 'gon', NULL),
	(160, 'gor', NULL),
	(161, 'got', NULL),
	(162, 'grb', NULL),
	(163, 'grc', NULL),
	(164, 'gre', 'el'),
	(165, 'grn', 'gn'),
	(166, 'gsw', NULL),
	(167, 'guj', 'gu'),
	(168, 'gwi', NULL),
	(169, 'hai', NULL),
	(170, 'hat', 'ht'),
	(171, 'hau', 'ha'),
	(172, 'haw', NULL),
	(173, 'heb', 'he'),
	(174, 'her', 'hz'),
	(175, 'hil', NULL),
	(176, 'him', NULL),
	(177, 'hin', 'hi'),
	(178, 'hit', NULL),
	(179, 'hmn', NULL),
	(180, 'hmo', 'ho'),
	(181, 'hsb', NULL),
	(182, 'hun', 'hu'),
	(183, 'hup', NULL),
	(184, 'iba', NULL),
	(185, 'ibo', 'ig'),
	(186, 'ice', 'is'),
	(187, 'ido', 'io'),
	(188, 'iii', 'ii'),
	(189, 'ijo', NULL),
	(190, 'iku', 'iu'),
	(191, 'ile', 'ie'),
	(192, 'ilo', NULL),
	(193, 'ina', 'ia'),
	(194, 'inc', NULL),
	(195, 'ind', 'id'),
	(196, 'ine', NULL),
	(197, 'inh', NULL),
	(198, 'ipk', 'ik'),
	(199, 'ira', NULL),
	(200, 'iro', NULL);
INSERT INTO public.isolanguages VALUES
	(201, 'ita', 'it'),
	(202, 'jav', 'jv'),
	(203, 'jbo', NULL),
	(204, 'jpn', 'ja'),
	(205, 'jpr', NULL),
	(206, 'jrb', NULL),
	(207, 'kaa', NULL),
	(208, 'kab', NULL),
	(209, 'kac', NULL),
	(210, 'kal', 'kl'),
	(211, 'kam', NULL),
	(212, 'kan', 'kn'),
	(213, 'kar', NULL),
	(214, 'kas', 'ks'),
	(215, 'kau', 'kr'),
	(216, 'kaw', NULL),
	(217, 'kaz', 'kk'),
	(218, 'kbd', NULL),
	(219, 'kha', NULL),
	(220, 'khi', NULL),
	(221, 'khm', 'km'),
	(222, 'kho', NULL),
	(223, 'kik', 'ki'),
	(224, 'kin', 'rw'),
	(225, 'kir', 'ky'),
	(226, 'kmb', NULL),
	(227, 'kok', NULL),
	(228, 'kom', 'kv'),
	(229, 'kon', 'kg'),
	(230, 'kor', 'ko'),
	(231, 'kos', NULL),
	(232, 'kpe', NULL),
	(233, 'krc', NULL),
	(234, 'krl', NULL),
	(235, 'kro', NULL),
	(236, 'kru', NULL),
	(237, 'kua', 'kj'),
	(238, 'kum', NULL),
	(239, 'kur', 'ku'),
	(240, 'kut', NULL),
	(241, 'lad', NULL),
	(242, 'lah', NULL),
	(243, 'lam', NULL),
	(244, 'lao', 'lo'),
	(245, 'lat', 'la'),
	(246, 'lav', 'lv'),
	(247, 'lez', NULL),
	(248, 'lim', 'li'),
	(249, 'lin', 'ln'),
	(250, 'lit', 'lt');
INSERT INTO public.isolanguages VALUES
	(251, 'lol', NULL),
	(252, 'loz', NULL),
	(253, 'ltz', 'lb'),
	(254, 'lua', NULL),
	(255, 'lub', 'lu'),
	(256, 'lug', 'lg'),
	(257, 'lui', NULL),
	(258, 'lun', NULL),
	(259, 'luo', NULL),
	(260, 'lus', NULL),
	(261, 'mac', 'mk'),
	(262, 'mad', NULL),
	(263, 'mag', NULL),
	(264, 'mah', 'mh'),
	(265, 'mai', NULL),
	(266, 'mak', NULL),
	(267, 'mal', 'ml'),
	(268, 'man', NULL),
	(269, 'mao', 'mi'),
	(270, 'map', NULL),
	(271, 'mar', 'mr'),
	(272, 'mas', NULL),
	(273, 'may', 'ms'),
	(274, 'mdf', NULL),
	(275, 'mdr', NULL),
	(276, 'men', NULL),
	(277, 'mga', NULL),
	(278, 'mic', NULL),
	(279, 'min', NULL),
	(280, 'mis', NULL),
	(281, 'mkh', NULL),
	(282, 'mlg', 'mg'),
	(283, 'mlt', 'mt'),
	(284, 'mnc', NULL),
	(285, 'mni', NULL),
	(286, 'mno', NULL),
	(287, 'moh', NULL),
	(288, 'mol', 'ml'),
	(289, 'mon', 'mn'),
	(290, 'mos', NULL),
	(291, 'mul', NULL),
	(292, 'mun', NULL),
	(293, 'mus', NULL),
	(294, 'mwl', NULL),
	(295, 'mwr', NULL),
	(296, 'myn', NULL),
	(297, 'myv', NULL),
	(298, 'nah', NULL),
	(299, 'nai', NULL),
	(300, 'nap', NULL);
INSERT INTO public.isolanguages VALUES
	(301, 'nau', 'na'),
	(302, 'nav', 'nv'),
	(303, 'nbl', 'nr'),
	(304, 'nde', 'nd'),
	(305, 'ndo', 'ng'),
	(306, 'nds', NULL),
	(307, 'nep', 'ne'),
	(308, 'new', NULL),
	(309, 'nia', NULL),
	(310, 'nic', NULL),
	(311, 'niu', NULL),
	(312, 'nno', 'nn'),
	(313, 'nob', 'nb'),
	(314, 'nog', NULL),
	(315, 'non', NULL),
	(316, 'nor', 'no'),
	(317, 'nso', NULL),
	(318, 'nub', NULL),
	(319, 'nwc', NULL),
	(320, 'nya', 'ny'),
	(321, 'nym', NULL),
	(322, 'nyn', NULL),
	(323, 'nyo', NULL),
	(324, 'nzi', NULL),
	(325, 'oci', 'oc'),
	(326, 'oji', 'oj'),
	(327, 'ori', 'or'),
	(328, 'orm', 'om'),
	(329, 'osa', NULL),
	(330, 'oss', 'os'),
	(331, 'ota', NULL),
	(332, 'oto', NULL),
	(333, 'paa', NULL),
	(334, 'pag', NULL),
	(335, 'pal', NULL),
	(336, 'pam', NULL),
	(337, 'pan', 'pa'),
	(338, 'pap', NULL),
	(339, 'pau', NULL),
	(340, 'peo', NULL),
	(341, 'per', 'fa'),
	(342, 'phi', NULL),
	(343, 'phn', NULL),
	(344, 'pli', 'pi'),
	(345, 'pol', 'pl'),
	(346, 'pon', NULL),
	(347, 'por', 'pt'),
	(348, 'pra', NULL),
	(349, 'pro', NULL),
	(350, 'pus', 'ps');
INSERT INTO public.isolanguages VALUES
	(351, 'qaa', NULL),
	(352, 'que', 'qu'),
	(353, 'raj', NULL),
	(354, 'rap', NULL),
	(355, 'rar', NULL),
	(356, 'roa', NULL),
	(357, 'roh', 'rm'),
	(358, 'rom', NULL),
	(359, 'rum', 'ro'),
	(360, 'run', 'rn'),
	(361, 'rup', NULL),
	(362, 'rus', 'ru'),
	(363, 'sad', NULL),
	(364, 'sag', 'sg'),
	(365, 'sah', NULL),
	(366, 'sai', NULL),
	(367, 'sal', NULL),
	(368, 'sam', NULL),
	(369, 'san', 'sa'),
	(370, 'sas', NULL),
	(371, 'sat', NULL),
	(372, 'srp', 'sr'),
	(373, 'scn', NULL),
	(374, 'sco', NULL),
	(375, 'hrv', 'hr'),
	(376, 'sel', NULL),
	(377, 'sem', NULL),
	(378, 'sga', NULL),
	(379, 'sgn', NULL),
	(380, 'shn', NULL),
	(381, 'sid', NULL),
	(382, 'sin', 'si'),
	(383, 'sio', NULL),
	(384, 'sit', NULL),
	(385, 'sla', NULL),
	(386, 'slo', 'sk'),
	(387, 'slv', 'sl'),
	(388, 'sma', NULL),
	(389, 'sme', 'se'),
	(390, 'smi', NULL),
	(391, 'smj', NULL),
	(392, 'smn', NULL),
	(393, 'smo', 'sm'),
	(394, 'sms', NULL),
	(395, 'sna', 'sn'),
	(396, 'snd', 'sd'),
	(397, 'snk', NULL),
	(398, 'sog', NULL),
	(399, 'som', 'so'),
	(400, 'son', NULL);
INSERT INTO public.isolanguages VALUES
	(401, 'sot', 'st'),
	(402, 'spa', 'es'),
	(403, 'srd', 'sc'),
	(404, 'srn', NULL),
	(405, 'srr', NULL),
	(406, 'ssa', NULL),
	(407, 'ssw', 'ss'),
	(408, 'suk', NULL),
	(409, 'sun', 'su'),
	(410, 'sus', NULL),
	(411, 'sux', NULL),
	(412, 'swa', 'sw'),
	(413, 'swe', 'sv'),
	(414, 'syr', NULL),
	(415, 'tah', 'ty'),
	(416, 'tai', NULL),
	(417, 'tam', 'ta'),
	(418, 'tat', 'tt'),
	(419, 'tel', 'te'),
	(420, 'tem', NULL),
	(421, 'ter', NULL),
	(422, 'tet', NULL),
	(423, 'tgk', 'tg'),
	(424, 'tgl', 'tl'),
	(425, 'tha', 'th'),
	(426, 'tib', 'bo'),
	(427, 'tig', NULL),
	(428, 'tir', 'ti'),
	(429, 'tiv', NULL),
	(430, 'tkl', NULL),
	(431, 'tlh', NULL),
	(432, 'tli', NULL),
	(433, 'tmh', NULL),
	(434, 'tog', NULL),
	(435, 'ton', 'to'),
	(436, 'tpi', NULL),
	(437, 'tsi', NULL),
	(438, 'tsn', 'tn'),
	(439, 'tso', 'ts'),
	(440, 'tuk', 'tk'),
	(441, 'tum', NULL),
	(442, 'tup', NULL),
	(443, 'tur', 'tr'),
	(444, 'tut', NULL),
	(445, 'tvl', NULL),
	(446, 'twi', 'tw'),
	(447, 'tyv', NULL),
	(448, 'udm', NULL),
	(449, 'uga', NULL),
	(450, 'uig', 'ug');
INSERT INTO public.isolanguages VALUES
	(451, 'ukr', 'uk'),
	(452, 'umb', NULL),
	(453, 'und', NULL),
	(454, 'urd', 'ur'),
	(455, 'uzb', 'uz'),
	(456, 'vai', NULL),
	(457, 'ven', 've'),
	(458, 'vie', 'vi'),
	(459, 'vol', 'vo'),
	(460, 'vot', NULL),
	(461, 'wak', NULL),
	(462, 'wal', NULL),
	(463, 'war', NULL),
	(464, 'was', NULL),
	(465, 'wel', 'cy'),
	(466, 'wen', NULL),
	(467, 'wln', 'wa'),
	(468, 'wol', 'wo'),
	(469, 'xal', NULL),
	(470, 'xho', 'xh'),
	(471, 'yao', NULL),
	(472, 'yap', NULL),
	(473, 'yid', 'yi'),
	(474, 'yor', 'yo'),
	(475, 'ypk', NULL),
	(476, 'zap', NULL),
	(477, 'zen', NULL),
	(478, 'zha', 'za'),
	(479, 'znd', NULL),
	(480, 'zul', 'zu'),
	(481, 'zun', NULL),
	(482, 'zxx', NULL),
	(483, 'nqo', NULL),
	(484, 'zza', NULL);


--
-- TOC entry 3840 (class 0 OID 16514)
-- Dependencies: 236
-- Data for Name: isolanguagesdes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.isolanguagesdes VALUES
	(1, 'Afar', 'eng'),
	(2, 'Abkhazian', 'eng'),
	(3, 'Achinese', 'eng'),
	(4, 'Acoli', 'eng'),
	(5, 'Adangme', 'eng'),
	(6, 'Adyghe; Adygei', 'eng'),
	(7, 'Afro-Asiatic (Other)', 'eng'),
	(8, 'Afrihili', 'eng'),
	(9, 'Afrikaans', 'eng'),
	(10, 'Ainu', 'eng'),
	(11, 'Akan', 'eng'),
	(12, 'Akkadian', 'eng'),
	(13, 'Albanian', 'eng'),
	(14, 'Aleut', 'eng'),
	(15, 'Algonquian languages', 'eng'),
	(16, 'Southern Altai', 'eng'),
	(17, 'Amharic', 'eng'),
	(18, 'English, Old (ca.450-1100)', 'eng'),
	(19, 'Angika', 'eng'),
	(20, 'Apache languages', 'eng'),
	(21, 'Arabic', 'eng'),
	(22, 'Aramaic', 'eng'),
	(23, 'Aragonese', 'eng'),
	(24, 'Armenian', 'eng'),
	(25, 'Mapudungun; Mapuche', 'eng'),
	(26, 'Arapaho', 'eng'),
	(27, 'Artificial (Other)', 'eng'),
	(28, 'Arawak', 'eng'),
	(29, 'Assamese', 'eng'),
	(30, 'Asturian; Bable', 'eng'),
	(31, 'Athapascan languages', 'eng'),
	(32, 'Australian languages', 'eng'),
	(33, 'Avaric', 'eng'),
	(34, 'Avestan', 'eng'),
	(35, 'Awadhi', 'eng'),
	(36, 'Aymara', 'eng'),
	(37, 'Azerbaijani', 'eng'),
	(38, 'Banda languages', 'eng'),
	(39, 'Bamileke languages', 'eng'),
	(40, 'Bashkir', 'eng'),
	(41, 'Baluchi', 'eng'),
	(42, 'Bambara', 'eng'),
	(43, 'Balinese', 'eng'),
	(44, 'Basque', 'eng'),
	(45, 'Basa', 'eng'),
	(46, 'Baltic (Other)', 'eng'),
	(47, 'Beja', 'eng'),
	(48, 'Belarusian', 'eng'),
	(49, 'Bemba', 'eng'),
	(50, 'Bengali', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(51, 'Berber (Other)', 'eng'),
	(52, 'Bhojpuri', 'eng'),
	(53, 'Bihari', 'eng'),
	(54, 'Bikol', 'eng'),
	(55, 'Bini; Edo', 'eng'),
	(56, 'Bislama', 'eng'),
	(57, 'Siksika', 'eng'),
	(58, 'Bantu (Other)', 'eng'),
	(59, 'Bosnian', 'eng'),
	(60, 'Braj', 'eng'),
	(61, 'Breton', 'eng'),
	(62, 'Batak languages', 'eng'),
	(63, 'Buriat', 'eng'),
	(64, 'Buginese', 'eng'),
	(65, 'Bulgarian', 'eng'),
	(66, 'Burmese', 'eng'),
	(67, 'Blin; Bilin', 'eng'),
	(68, 'Caddo', 'eng'),
	(69, 'Central American Indian (Other)', 'eng'),
	(70, 'Galibi Carib', 'eng'),
	(71, 'Catalan; Valencian', 'eng'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'eng'),
	(73, 'Cebuano', 'eng'),
	(74, 'Celtic (Other)', 'eng'),
	(75, 'Chamorro', 'eng'),
	(76, 'Chibcha', 'eng'),
	(77, 'Chechen', 'eng'),
	(78, 'Chagataier)', 'eng'),
	(79, 'Chinese(Other)', 'eng'),
	(80, 'Chuukese', 'eng'),
	(81, 'Mari', 'eng'),
	(82, 'Chinook jargon', 'eng'),
	(83, 'Choctaw', 'eng'),
	(84, 'Chipewyan', 'eng'),
	(85, 'Cherokee', 'eng'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'eng'),
	(87, 'Chuvash', 'eng'),
	(88, 'Cheyenne', 'eng'),
	(89, 'Chamic languages', 'eng'),
	(90, 'Coptic', 'eng'),
	(91, 'Cornish', 'eng'),
	(92, 'Corsican', 'eng'),
	(93, 'Creoles and pidgins, English based (Ot', 'eng'),
	(94, 'Creoles and pidgins, French-based (Oth', 'eng'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'eng'),
	(96, 'Cree', 'eng'),
	(97, 'Crimean Tatar; Crimean Turkish', 'eng'),
	(98, 'Creoles and pidgins (Other)', 'eng'),
	(99, 'Kashubian', 'eng'),
	(100, 'Cushitic (Other)', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(101, 'Czech', 'eng'),
	(102, 'Dakota', 'eng'),
	(103, 'Danish', 'eng'),
	(104, 'Dargwa', 'eng'),
	(105, 'Land Dayak languages', 'eng'),
	(106, 'Delaware', 'eng'),
	(107, 'Slave (Athapascan)', 'eng'),
	(108, 'Dogrib', 'eng'),
	(109, 'Dinka', 'eng'),
	(110, 'Divehi; Dhivehi; Maldivian', 'eng'),
	(111, 'Dogri', 'eng'),
	(112, 'Dravidian (Other)', 'eng'),
	(113, 'Lower Sorbian', 'eng'),
	(114, 'Duala', 'eng'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'eng'),
	(116, 'Dutch; Flemish', 'eng'),
	(117, 'Dyula', 'eng'),
	(118, 'Dzongkha', 'eng'),
	(119, 'Efik', 'eng'),
	(120, 'Egyptian (Ancient)', 'eng'),
	(121, 'Ekajuk', 'eng'),
	(122, 'Elamite', 'eng'),
	(123, 'English', 'eng'),
	(124, 'English, Middle (1100-1500)', 'eng'),
	(125, 'Esperanto', 'eng'),
	(126, 'Estonian', 'eng'),
	(127, 'Ewe', 'eng'),
	(128, 'Ewondo', 'eng'),
	(129, 'Fang', 'eng'),
	(130, 'Faroese', 'eng'),
	(131, 'Fanti', 'eng'),
	(132, 'Fijian', 'eng'),
	(133, 'Filipino; Pilipino', 'eng'),
	(134, 'Finnish', 'eng'),
	(135, 'Finno-Ugrian (Other)', 'eng'),
	(136, 'Fon', 'eng'),
	(137, 'French', 'eng'),
	(138, 'French, Middle (ca.1400-1600)', 'eng'),
	(139, 'French, Old (842-ca.1400)', 'eng'),
	(140, 'Northern Frisian', 'eng'),
	(141, 'Eastern Frisian', 'eng'),
	(142, 'Western Frisian', 'eng'),
	(143, 'Fulah', 'eng'),
	(144, 'Friulian', 'eng'),
	(145, 'Ga', 'eng'),
	(146, 'Gayo', 'eng'),
	(147, 'Gbaya', 'eng'),
	(148, 'Germanic (Other)', 'eng'),
	(149, 'Georgian', 'eng'),
	(150, 'German', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(151, 'Geez', 'eng'),
	(152, 'Gilbertese', 'eng'),
	(153, 'Gaelic; Scottish Gaelic', 'eng'),
	(154, 'Irish', 'eng'),
	(155, 'Galician', 'eng'),
	(156, 'Manx', 'eng'),
	(157, 'German, Middle High (ca.1050-1500)', 'eng'),
	(158, 'German, Old High (ca.750-1050)', 'eng'),
	(159, 'Gondi', 'eng'),
	(160, 'Gorontalo', 'eng'),
	(161, 'Gothicanguage Association)', 'eng'),
	(162, 'Grebo', 'eng'),
	(163, 'Greek, Ancient (to 1453)', 'eng'),
	(164, 'Greek, Modern (1453-)', 'eng'),
	(165, 'Guarani', 'eng'),
	(166, 'Swiss German; Alemannic', 'eng'),
	(167, 'Gujarati', 'eng'),
	(168, 'Gwich''in', 'eng'),
	(169, 'Haida', 'eng'),
	(170, 'Haitian; Haitian Creole', 'eng'),
	(171, 'Hausa', 'eng'),
	(172, 'Hawaiian', 'eng'),
	(173, 'Hebrew', 'eng'),
	(174, 'Herero', 'eng'),
	(175, 'Hiligaynon', 'eng'),
	(176, 'Himachali', 'eng'),
	(177, 'Hindi', 'eng'),
	(178, 'Hittite', 'eng'),
	(179, 'Hmong', 'eng'),
	(180, 'Hiri Motu', 'eng'),
	(181, 'Upper Sorbian', 'eng'),
	(182, 'Hungarian', 'eng'),
	(183, 'Hupa', 'eng'),
	(184, 'Iban', 'eng'),
	(185, 'Igbo', 'eng'),
	(186, 'Icelandic', 'eng'),
	(187, 'Ido', 'eng'),
	(188, 'Sichuan Yi', 'eng'),
	(189, 'Ijo languages', 'eng'),
	(190, 'Inuktitut', 'eng'),
	(191, 'Interlingue', 'eng'),
	(192, 'Iloko', 'eng'),
	(193, 'Interlingua (International Auxiliary L', 'eng'),
	(194, 'Indic (Other)', 'eng'),
	(195, 'Indonesian', 'eng'),
	(196, 'Indo-European (Other)', 'eng'),
	(197, 'Ingush', 'eng'),
	(198, 'Inupiaq', 'eng'),
	(199, 'Iranian (Other)', 'eng'),
	(200, 'Iroquoian languages', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(201, 'Italian', 'eng'),
	(202, 'Javanese', 'eng'),
	(203, 'Lojban', 'eng'),
	(204, 'Japanese', 'eng'),
	(205, 'Judeo-Persian', 'eng'),
	(206, 'Judeo-Arabic', 'eng'),
	(207, 'Kara-Kalpak', 'eng'),
	(208, 'Kabyle', 'eng'),
	(209, 'Kachin; Jingpho', 'eng'),
	(210, 'Kalaallisut; Greenlandic', 'eng'),
	(211, 'Kamba', 'eng'),
	(212, 'Kannada', 'eng'),
	(213, 'Karen languages', 'eng'),
	(214, 'Kashmiri', 'eng'),
	(215, 'Kanuri', 'eng'),
	(216, 'Kawi', 'eng'),
	(217, 'Kazakh', 'eng'),
	(218, 'Kabardian', 'eng'),
	(219, 'Khasi', 'eng'),
	(220, 'Khoisan (Other)', 'eng'),
	(221, 'Central Khmer', 'eng'),
	(222, 'Khotanese', 'eng'),
	(223, 'Kikuyu; Gikuyu', 'eng'),
	(224, 'Kinyarwanda', 'eng'),
	(225, 'Kirghiz; Kyrgyz', 'eng'),
	(226, 'Kimbundu', 'eng'),
	(227, 'Konkani', 'eng'),
	(228, 'Komi', 'eng'),
	(229, 'Kongo', 'eng'),
	(230, 'Korean', 'eng'),
	(231, 'Kosraean', 'eng'),
	(232, 'Kpelle', 'eng'),
	(233, 'Karachay-Balkar', 'eng'),
	(234, 'Karelian', 'eng'),
	(235, 'Kru languages', 'eng'),
	(236, 'Kurukh', 'eng'),
	(237, 'Kuanyama; Kwanyama', 'eng'),
	(238, 'Kumyk', 'eng'),
	(239, 'Kurdish', 'eng'),
	(240, 'Kutenai', 'eng'),
	(241, 'Ladino', 'eng'),
	(242, 'Lahnda', 'eng'),
	(243, 'Lamba', 'eng'),
	(244, 'Lao', 'eng'),
	(245, 'Latin', 'eng'),
	(246, 'Latvian', 'eng'),
	(247, 'Lezghian', 'eng'),
	(248, 'Limburgan; Limburger; Limburgish', 'eng'),
	(249, 'Lingala', 'eng'),
	(250, 'Lithuanian', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(251, 'Mongo', 'eng'),
	(252, 'Lozi', 'eng'),
	(253, 'Luxembourgish; Letzeburgesch', 'eng'),
	(254, 'Luba-Lulua', 'eng'),
	(255, 'Luba-Katangaxon, Low', 'eng'),
	(256, 'Ganda', 'eng'),
	(257, 'Luiseno', 'eng'),
	(258, 'Lunda', 'eng'),
	(259, 'Luo (Kenya and Tanzania)', 'eng'),
	(260, 'Lushai', 'eng'),
	(261, 'Macedonian00E5l', 'eng'),
	(262, 'Madurese', 'eng'),
	(263, 'Magahi', 'eng'),
	(264, 'Marshallese', 'eng'),
	(265, 'Maithili', 'eng'),
	(266, 'Makasarl Nepal Bhasa', 'eng'),
	(267, 'Malayalam', 'eng'),
	(268, 'Mandingo', 'eng'),
	(269, 'Maori', 'eng'),
	(270, 'Austronesian (Other)', 'eng'),
	(271, 'Marathi', 'eng'),
	(272, 'Masai', 'eng'),
	(273, 'Malay', 'eng'),
	(274, 'Moksha', 'eng'),
	(275, 'Mandar', 'eng'),
	(276, 'Mende', 'eng'),
	(277, 'Irish, Middle (900-1200)', 'eng'),
	(278, 'Mi''kmaq; Micmac', 'eng'),
	(279, 'Minangkabau', 'eng'),
	(280, 'Miscellaneous languages', 'eng'),
	(281, 'Mon-Khmer (Other)', 'eng'),
	(282, 'Malagasy', 'eng'),
	(283, 'Maltese', 'eng'),
	(284, 'Manchu', 'eng'),
	(285, 'Manipuri', 'eng'),
	(286, 'Manobo languages', 'eng'),
	(287, 'Mohawk', 'eng'),
	(288, 'Moldavian', 'eng'),
	(289, 'Mongolian', 'eng'),
	(290, 'Mossi', 'eng'),
	(291, 'Multiple languages', 'eng'),
	(292, 'Munda languages', 'eng'),
	(293, 'Creek', 'eng'),
	(294, 'Mirandese', 'eng'),
	(295, 'Marwari', 'eng'),
	(296, 'Mayan languages', 'eng'),
	(297, 'Erzya', 'eng'),
	(298, 'Nahuatl languages', 'eng'),
	(299, 'North American Indian', 'eng'),
	(300, 'Neapolitan', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(301, 'Nauru', 'eng'),
	(302, 'Navajo; Navaho', 'eng'),
	(303, 'Ndebele, South; South Ndebele', 'eng'),
	(304, 'Ndebele, North; North Ndebele', 'eng'),
	(305, 'Ndonga', 'eng'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'eng'),
	(307, 'Nepali', 'eng'),
	(308, 'Nepal Bhasa; Newari', 'eng'),
	(309, 'Nias', 'eng'),
	(310, 'Niger-Kordofanian (Other)', 'eng'),
	(311, 'Niuean', 'eng'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'eng'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'eng'),
	(314, 'Nogai', 'eng'),
	(315, 'Norse, Old', 'eng'),
	(316, 'Norwegian', 'eng'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'eng'),
	(318, 'Nubian languages', 'eng'),
	(319, 'Classical Newari; Old Newari; Classica', 'eng'),
	(320, 'Chichewa; Chewa; Nyanja', 'eng'),
	(321, 'Nyamwezi', 'eng'),
	(322, 'Nyankole', 'eng'),
	(323, 'Nyoro', 'eng'),
	(324, 'Nzima', 'eng'),
	(325, 'Occitan (post 1500); Provençal', 'eng'),
	(326, 'Ojibwa', 'eng'),
	(327, 'Oriya', 'eng'),
	(328, 'Oromo', 'eng'),
	(329, 'Osage', 'eng'),
	(330, 'Ossetian; Ossetic', 'eng'),
	(331, 'Turkish, Ottoman (1500-1928)', 'eng'),
	(332, 'Otomian languages', 'eng'),
	(333, 'Papuan (Other)', 'eng'),
	(334, 'Pangasinan', 'eng'),
	(335, 'Pahlavi', 'eng'),
	(336, 'Pampanga', 'eng'),
	(337, 'Panjabi; Punjabi', 'eng'),
	(338, 'Papiamento', 'eng'),
	(339, 'Palauan', 'eng'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'eng'),
	(341, 'Persian', 'eng'),
	(342, 'Philippine (Other)', 'eng'),
	(343, 'Phoenician', 'eng'),
	(344, 'Pali', 'eng'),
	(345, 'Polish', 'eng'),
	(346, 'Pohnpeian', 'eng'),
	(347, 'Portuguese', 'eng'),
	(348, 'Prakrit languages', 'eng'),
	(349, 'Provençal, Old (to 1500)', 'eng'),
	(350, 'Pushto', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(351, 'Reserved for local use', 'eng'),
	(352, 'Quechua', 'eng'),
	(353, 'Rajasthani', 'eng'),
	(354, 'Rapanui', 'eng'),
	(355, 'Rarotongan; Cook Islands Maori', 'eng'),
	(356, 'Romance (Other)', 'eng'),
	(357, 'Romansh', 'eng'),
	(358, 'Romany', 'eng'),
	(359, 'Romanian', 'eng'),
	(360, 'Rundi', 'eng'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'eng'),
	(362, 'Russian', 'eng'),
	(363, 'Sandawe', 'eng'),
	(364, 'Sango', 'eng'),
	(365, 'Yakut', 'eng'),
	(366, 'South American Indian (Other)', 'eng'),
	(367, 'Salishan languages', 'eng'),
	(368, 'Samaritan Aramaic', 'eng'),
	(369, 'Sanskrit', 'eng'),
	(370, 'Sasak', 'eng'),
	(371, 'Santali', 'eng'),
	(372, 'Serbian', 'eng'),
	(373, 'Sicilian', 'eng'),
	(374, 'Scots', 'eng'),
	(375, 'Croatian', 'eng'),
	(376, 'Selkup', 'eng'),
	(377, 'Semitic (Other)', 'eng'),
	(378, 'Irish, Old (to 900)', 'eng'),
	(379, 'Sign Languages', 'eng'),
	(380, 'Shan', 'eng'),
	(381, 'Sidamo', 'eng'),
	(382, 'Sinhala; Sinhalese', 'eng'),
	(383, 'Siouan languages', 'eng'),
	(384, 'Sino-Tibetan (Other)', 'eng'),
	(385, 'Slavic (Other)', 'eng'),
	(386, 'Slovak', 'eng'),
	(387, 'Slovenian', 'eng'),
	(388, 'Southern Sami', 'eng'),
	(389, 'Northern Sami', 'eng'),
	(390, 'Sami languages (Other)', 'eng'),
	(391, 'Lule Sami', 'eng'),
	(392, 'Inari Sami', 'eng'),
	(393, 'Samoan', 'eng'),
	(394, 'Skolt Sami', 'eng'),
	(395, 'Shona', 'eng'),
	(396, 'Sindhi', 'eng'),
	(397, 'Soninke', 'eng'),
	(398, 'Sogdian', 'eng'),
	(399, 'Somali', 'eng'),
	(400, 'Songhai languages', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(401, 'Sotho, Southern', 'eng'),
	(402, 'Spanish; Castilian', 'eng'),
	(403, 'Sardinian; Zazaki', 'eng'),
	(404, 'Sranan Tongo', 'eng'),
	(405, 'Serer', 'eng'),
	(406, 'Nilo-Saharan (Other)', 'eng'),
	(407, 'Swati', 'eng'),
	(408, 'Sukuma', 'eng'),
	(409, 'Sundanese', 'eng'),
	(410, 'Susu', 'eng'),
	(411, 'Sumerian', 'eng'),
	(412, 'Swahili', 'eng'),
	(413, 'Swedish', 'eng'),
	(414, 'Syriac', 'eng'),
	(415, 'Tahitian', 'eng'),
	(416, 'Tai (Other)', 'eng'),
	(417, 'Tamil', 'eng'),
	(418, 'Tatar', 'eng'),
	(419, 'Telugu', 'eng'),
	(420, 'Timnendere)', 'eng'),
	(421, 'Tereno', 'eng'),
	(422, 'Tetum', 'eng'),
	(423, 'Tajik', 'eng'),
	(424, 'Tagalog', 'eng'),
	(425, 'Thai', 'eng'),
	(426, 'Tibetan', 'eng'),
	(427, 'Tigre', 'eng'),
	(428, 'Tigrinya', 'eng'),
	(429, 'Tiv', 'eng'),
	(430, 'Tokelau', 'eng'),
	(431, 'Klingon; tlhIngan-Hol', 'eng'),
	(432, 'Tlingit', 'eng'),
	(433, 'Tamashek', 'eng'),
	(434, 'Tonga (Nyasa)', 'eng'),
	(435, 'Tonga (Tonga Islands)', 'eng'),
	(436, 'Tok Pisin', 'eng'),
	(437, 'Tsimshian', 'eng'),
	(438, 'Tswana', 'eng'),
	(439, 'Tsonga', 'eng'),
	(440, 'Turkmen', 'eng'),
	(441, 'Tumbuka', 'eng'),
	(442, 'Tupi languages', 'eng'),
	(443, 'Turkish', 'eng'),
	(444, 'Altaic (Other)', 'eng'),
	(445, 'Tuvalu', 'eng'),
	(446, 'Twi', 'eng'),
	(447, 'Tuvinian', 'eng'),
	(448, 'Udmurt', 'eng'),
	(449, 'Ugaritic', 'eng'),
	(450, 'Uighur; Uyghur', 'eng');
INSERT INTO public.isolanguagesdes VALUES
	(451, 'Ukrainian', 'eng'),
	(452, 'Umbundu', 'eng'),
	(453, 'Undetermined', 'eng'),
	(454, 'Urdu', 'eng'),
	(455, 'Uzbek', 'eng'),
	(456, 'Vai', 'eng'),
	(457, 'Venda', 'eng'),
	(458, 'Vietnamese', 'eng'),
	(459, 'Volapük', 'eng'),
	(460, 'Votic', 'eng'),
	(461, 'Wakashan languages', 'eng'),
	(462, 'Walamo', 'eng'),
	(463, 'Waray', 'eng'),
	(464, 'Washo', 'eng'),
	(465, 'Welsh', 'eng'),
	(466, 'Sorbian languages', 'eng'),
	(467, 'Walloon', 'eng'),
	(468, 'Wolof', 'eng'),
	(469, 'Kalmyk; Oirat', 'eng'),
	(470, 'Xhosa', 'eng'),
	(471, 'Yao', 'eng'),
	(472, 'Yapese', 'eng'),
	(473, 'Yiddish', 'eng'),
	(474, 'Yoruba', 'eng'),
	(475, 'Yupik languages', 'eng'),
	(476, 'Zapotec', 'eng'),
	(477, 'Zenaga', 'eng'),
	(478, 'Zhuang; Chuang', 'eng'),
	(479, 'Zande languages', 'eng'),
	(480, 'Zulu', 'eng'),
	(481, 'Zuni', 'eng'),
	(482, 'No linguistic content', 'eng'),
	(483, 'N''Ko', 'eng'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'eng'),
	(1, 'Afar', 'fre'),
	(2, 'Abkhaze', 'fre'),
	(3, 'Aceh', 'fre'),
	(4, 'Acoli', 'fre'),
	(5, 'Adangme', 'fre'),
	(6, 'Adyghé', 'fre'),
	(7, 'Afro-asiatiques, autres langues', 'fre'),
	(8, 'Afrihili', 'fre'),
	(9, 'Afrikaans', 'fre'),
	(10, 'Aïnou', 'fre'),
	(11, 'Akan', 'fre'),
	(12, 'Akkadien', 'fre'),
	(13, 'Albanais', 'fre'),
	(14, 'Aléoute', 'fre'),
	(15, 'Algonquines, langues', 'fre'),
	(16, 'Altai du Sud', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(17, 'Amharique', 'fre'),
	(18, 'Anglo-saxon (ca.450-1100)', 'fre'),
	(19, 'Angika', 'fre'),
	(20, 'Apache', 'fre'),
	(21, 'Arabe', 'fre'),
	(22, 'Araméen', 'fre'),
	(23, 'Aragonais', 'fre'),
	(24, 'Arménien', 'fre'),
	(25, 'Mapudungun; mapuche; mapuce', 'fre'),
	(26, 'Arapaho', 'fre'),
	(27, 'Artificielles, autres langues', 'fre'),
	(28, 'Arawak', 'fre'),
	(29, 'Assamais', 'fre'),
	(30, 'Asturien; bable', 'fre'),
	(31, 'Athapascanes, langues', 'fre'),
	(32, 'Australiennes, langues', 'fre'),
	(33, 'Avar', 'fre'),
	(34, 'Avestique', 'fre'),
	(35, 'Awadhi', 'fre'),
	(36, 'Aymara', 'fre'),
	(37, 'Azéri', 'fre'),
	(38, 'Banda, langues', 'fre'),
	(39, 'Bamilékés, langues', 'fre'),
	(40, 'Bachkir', 'fre'),
	(41, 'Baloutchi', 'fre'),
	(42, 'Bambara', 'fre'),
	(43, 'Balinais', 'fre'),
	(44, 'Basque', 'fre'),
	(45, 'Basa', 'fre'),
	(46, 'Baltiques, autres langues', 'fre'),
	(47, 'Bedja', 'fre'),
	(48, 'Biélorusse', 'fre'),
	(49, 'Bemba', 'fre'),
	(50, 'Bengali', 'fre'),
	(51, 'Berbères, autres langues', 'fre'),
	(52, 'Bhojpuri', 'fre'),
	(53, 'Bihari', 'fre'),
	(54, 'Bikol', 'fre'),
	(55, 'Bini; edo', 'fre'),
	(56, 'Bichlamar', 'fre'),
	(57, 'Blackfoot', 'fre'),
	(58, 'Bantoues, autres langues', 'fre'),
	(59, 'Bosniaque', 'fre'),
	(60, 'Braj', 'fre'),
	(61, 'Breton', 'fre'),
	(62, 'Batak, langues', 'fre'),
	(63, 'Bouriate', 'fre'),
	(64, 'Bugi', 'fre'),
	(65, 'Bulgare', 'fre'),
	(66, 'Birman', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(67, 'Blin; bilen', 'fre'),
	(68, 'Caddo', 'fre'),
	(69, 'Indiennes d''Amérique centrale, aut', 'fre'),
	(70, 'Karib; galibi; carib', 'fre'),
	(71, 'Catalan; valencienavonic; Old Bulgarian; Old Church Slavonic', 'fre'),
	(72, 'Caucasiennes, autres langues', 'fre'),
	(73, 'Cebuano', 'fre'),
	(74, 'Celtiques, autres langues', 'fre'),
	(75, 'Chamorro', 'fre'),
	(76, 'Chibcha', 'fre'),
	(77, 'Tchétchèneher)', 'fre'),
	(78, 'Djaghataïer)', 'fre'),
	(79, 'Chinois(Other)', 'fre'),
	(80, 'Chuuk', 'fre'),
	(81, 'Mari', 'fre'),
	(82, 'Chinook, jargon', 'fre'),
	(83, 'Choctaw', 'fre'),
	(84, 'Chipewyan', 'fre'),
	(85, 'Cherokee', 'fre'),
	(86, 'Slavon d''église; vieux slave; slav', 'fre'),
	(87, 'Tchouvache', 'fre'),
	(88, 'Cheyenne', 'fre'),
	(89, 'Chames, langues', 'fre'),
	(90, 'Copte', 'fre'),
	(91, 'Cornique', 'fre'),
	(92, 'Corse', 'fre'),
	(93, 'Créoles et pidgins anglais, autres', 'fre'),
	(94, 'Créoles et pidgins français, a', 'fre'),
	(95, 'Créoles et pidgins portugais, autr', 'fre'),
	(96, 'Cree', 'fre'),
	(97, 'Tatar de Crimé', 'fre'),
	(98, 'Créoles et pidgins divers', 'fre'),
	(99, 'Kachoube', 'fre'),
	(100, 'Couchitiques, autres langues', 'fre'),
	(101, 'Tchèque', 'fre'),
	(102, 'Dakota', 'fre'),
	(103, 'Danois', 'fre'),
	(104, 'Dargwa', 'fre'),
	(105, 'Dayak, langues', 'fre'),
	(106, 'Delaware', 'fre'),
	(107, 'Esclave (athapascan)', 'fre'),
	(108, 'Dogrib', 'fre'),
	(109, 'Dinka', 'fre'),
	(110, 'Maldivien', 'fre'),
	(111, 'Dogri', 'fre'),
	(112, 'Dravidiennes, autres langues', 'fre'),
	(113, 'Bas-sorabe', 'fre'),
	(114, 'Douala', 'fre'),
	(115, 'Néerlandais moyen (ca. 1050-1350)', 'fre'),
	(116, 'Néerlandais; flamand', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(117, 'Dioula', 'fre'),
	(118, 'Dzongkha', 'fre'),
	(119, 'Efik', 'fre'),
	(120, 'Égyptien', 'fre'),
	(121, 'Ekajuk', 'fre'),
	(122, 'Élamite', 'fre'),
	(123, 'Anglais', 'fre'),
	(124, 'Anglais moyen (1100-1500)', 'fre'),
	(125, 'Espéranto', 'fre'),
	(126, 'Estonien', 'fre'),
	(127, 'Éwé', 'fre'),
	(128, 'Éwondo', 'fre'),
	(129, 'Fang', 'fre'),
	(130, 'Féroïen', 'fre'),
	(131, 'Fanti', 'fre'),
	(132, 'Fidjien', 'fre'),
	(133, 'Filipino; pilipino', 'fre'),
	(134, 'Finnois', 'fre'),
	(135, 'Finno-ougriennes, autres langues', 'fre'),
	(136, 'Fon', 'fre'),
	(137, 'Français', 'fre'),
	(138, 'Français moyen (1400-1600)', 'fre'),
	(139, 'Français ancien (842-ca.1400)', 'fre'),
	(140, 'Frison septentrional', 'fre'),
	(141, 'Frison oriental', 'fre'),
	(142, 'Frison occidental', 'fre'),
	(143, 'Peul', 'fre'),
	(144, 'Frioulan', 'fre'),
	(145, 'Ga', 'fre'),
	(146, 'Gayo', 'fre'),
	(147, 'Gbaya', 'fre'),
	(148, 'Germaniques, autres langues', 'fre'),
	(149, 'Géorgien', 'fre'),
	(150, 'Allemand', 'fre'),
	(151, 'Guèze', 'fre'),
	(152, 'Kiribati', 'fre'),
	(153, 'Gaélique; gaélique écossai', 'fre'),
	(154, 'Irlandais', 'fre'),
	(155, 'Galicien', 'fre'),
	(156, 'Manx; mannois', 'fre'),
	(157, 'Allemand, moyen haut (ca. 1050-1500)', 'fre'),
	(158, 'Allemand, vieux haut (ca. 750-1050)', 'fre'),
	(159, 'Gond', 'fre'),
	(160, 'Gorontalo', 'fre'),
	(161, 'Gothique', 'fre'),
	(162, 'Grebo', 'fre'),
	(163, 'Grec ancien (jusqu''à 1453)', 'fre'),
	(164, 'Grec moderne (après 1453)', 'fre'),
	(165, 'Guarani', 'fre'),
	(166, 'Alémanique', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(167, 'Goudjrati', 'fre'),
	(168, 'Gwich''in', 'fre'),
	(169, 'Haida', 'fre'),
	(170, 'Haïtien; créole haïtien', 'fre'),
	(171, 'Haoussa', 'fre'),
	(172, 'Hawaïen', 'fre'),
	(173, 'Hébreu', 'fre'),
	(174, 'Herero', 'fre'),
	(175, 'Hiligaynon', 'fre'),
	(176, 'Himachali', 'fre'),
	(177, 'Hindi', 'fre'),
	(178, 'Hittite', 'fre'),
	(179, 'Hmong', 'fre'),
	(180, 'Hiri motu', 'fre'),
	(181, 'Haut-sorabe', 'fre'),
	(182, 'Hongrois', 'fre'),
	(183, 'Hupa', 'fre'),
	(184, 'Iban', 'fre'),
	(185, 'Igbo', 'fre'),
	(186, 'Islandais', 'fre'),
	(187, 'Ido', 'fre'),
	(188, 'Yi de Sichuan', 'fre'),
	(189, 'Ijo, langues', 'fre'),
	(190, 'Inuktitut', 'fre'),
	(191, 'Interlingue', 'fre'),
	(192, 'Ilocano', 'fre'),
	(193, 'Interlingua (langue auxiliaire interna', 'fre'),
	(194, 'Indo-aryennes, autres langues', 'fre'),
	(195, 'Indonésien', 'fre'),
	(196, 'Indo-européennes, autres langues', 'fre'),
	(197, 'Ingouche', 'fre'),
	(198, 'Inupiaq', 'fre'),
	(199, 'Iraniennes, autres langues', 'fre'),
	(200, 'Iroquoises, langues (famille)', 'fre'),
	(201, 'Italien', 'fre'),
	(202, 'Javanais', 'fre'),
	(203, 'Lojban', 'fre'),
	(204, 'Japonais', 'fre'),
	(205, 'Judéo-persan', 'fre'),
	(206, 'Judéo-arabe', 'fre'),
	(207, 'Karakalpak', 'fre'),
	(208, 'Kabyle', 'fre'),
	(209, 'Kachin; jingpho', 'fre'),
	(210, 'Groenlandais', 'fre'),
	(211, 'Kamba', 'fre'),
	(212, 'Kannada', 'fre'),
	(213, 'Karen, langues', 'fre'),
	(214, 'Kashmiri', 'fre'),
	(215, 'Kanouri', 'fre'),
	(216, 'Kawi', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(217, 'Kazakh', 'fre'),
	(218, 'Kabardien', 'fre'),
	(219, 'Khasi', 'fre'),
	(220, 'Khoisan, autres langues', 'fre'),
	(221, 'Khmer central', 'fre'),
	(222, 'Khotanais', 'fre'),
	(223, 'Kikuyu', 'fre'),
	(224, 'Rwanda', 'fre'),
	(225, 'Kirghizes', 'fre'),
	(226, 'Kimbundu', 'fre'),
	(227, 'Konkani', 'fre'),
	(228, 'Kom', 'fre'),
	(229, 'Kongo', 'fre'),
	(230, 'Coréen', 'fre'),
	(231, 'Kosrae', 'fre'),
	(232, 'Kpellé', 'fre'),
	(233, 'Karatchai balkar', 'fre'),
	(234, 'Carélien', 'fre'),
	(235, 'Krou, langues', 'fre'),
	(236, 'Kurukh', 'fre'),
	(237, 'Kuanyama; kwanyama', 'fre'),
	(238, 'Koumyk', 'fre'),
	(239, 'Kurde', 'fre'),
	(240, 'Kutenai', 'fre'),
	(241, 'Judéo-espagnol', 'fre'),
	(242, 'Lahnda', 'fre'),
	(243, 'Lamba', 'fre'),
	(244, 'Lao', 'fre'),
	(245, 'Latin', 'fre'),
	(246, 'Letton', 'fre'),
	(247, 'Lezghien', 'fre'),
	(248, 'Limbourgeois', 'fre'),
	(249, 'Lingala', 'fre'),
	(250, 'Lituanien', 'fre'),
	(251, 'Mongo', 'fre'),
	(252, 'Lozi', 'fre'),
	(253, 'Luxembourgeois', 'fre'),
	(254, 'Luba-lulua', 'fre'),
	(255, 'Luba-katanga; saxon, bas', 'fre'),
	(256, 'Ganda', 'fre'),
	(257, 'Luiseno', 'fre'),
	(258, 'Lunda', 'fre'),
	(259, 'Luo (Kenya et Tanzanie)', 'fre'),
	(260, 'Lushai0E9gien', 'fre'),
	(261, 'Macédonien', 'fre'),
	(262, 'Madourais', 'fre'),
	(263, 'Magahi', 'fre'),
	(264, 'Marshall', 'fre'),
	(265, 'Maithili', 'fre'),
	(266, 'Makassar', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(267, 'Malayalam', 'fre'),
	(268, 'Mandingue', 'fre'),
	(269, 'Maori', 'fre'),
	(270, 'Malayo-polynésiennes, autres langu', 'fre'),
	(271, 'Marathe', 'fre'),
	(272, 'Massaï', 'fre'),
	(273, 'Malais', 'fre'),
	(274, 'Moksa', 'fre'),
	(275, 'Mandar', 'fre'),
	(276, 'Mendé', 'fre'),
	(277, 'Irlandais moyen (900-1200)', 'fre'),
	(278, 'Mi''kmaq; micmac', 'fre'),
	(279, 'Minangkabau', 'fre'),
	(280, 'Diverses, langues', 'fre'),
	(281, 'Môn-khmer, autres langues', 'fre'),
	(282, 'Malgache', 'fre'),
	(283, 'Maltais', 'fre'),
	(284, 'Mandchou', 'fre'),
	(285, 'Manipuri', 'fre'),
	(286, 'Manobo, langues', 'fre'),
	(287, 'Mohawk', 'fre'),
	(288, 'Moldave', 'fre'),
	(289, 'Mongol', 'fre'),
	(290, 'Moré', 'fre'),
	(291, 'Multilingue', 'fre'),
	(292, 'Mounda, langues', 'fre'),
	(293, 'Muskogee', 'fre'),
	(294, 'Mirandais', 'fre'),
	(295, 'Marvari', 'fre'),
	(296, 'Maya, langues', 'fre'),
	(297, 'Erza', 'fre'),
	(298, 'Nahuatl, langues', 'fre'),
	(299, 'Indiennes d''Amérique du Nord, autr', 'fre'),
	(300, 'Napolitain', 'fre'),
	(301, 'Nauruan', 'fre'),
	(302, 'Navaho', 'fre'),
	(303, 'Ndébélé du Sud', 'fre'),
	(304, 'Ndébélé du Nord', 'fre'),
	(305, 'Ndongas langues', 'fre'),
	(306, 'Bas allemand; bas saxon; allemand, bas', 'fre'),
	(307, 'Népalais', 'fre'),
	(308, 'Nepal bhasa; newari', 'fre'),
	(309, 'Nias', 'fre'),
	(310, 'Nigéro-congolaises, autres langues', 'fre'),
	(311, 'Niué', 'fre'),
	(312, 'Norvégien nynorsk; nynorsk, norvégien', 'fre'),
	(313, 'Norvégien bokmål', 'fre'),
	(314, 'Nogaï; nogay', 'fre'),
	(315, 'Norrois, vieux', 'fre'),
	(316, 'Norvégien', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(317, 'Pedi; sepedi; sotho du Nord', 'fre'),
	(318, 'Nubiennes, langues', 'fre'),
	(319, 'Newari classique', 'fre'),
	(320, 'Chichewa; chewa; nyanja', 'fre'),
	(321, 'Nyamwezi', 'fre'),
	(322, 'Nyankolé', 'fre'),
	(323, 'Nyoro', 'fre'),
	(324, 'Nzema', 'fre'),
	(325, 'Occitan (après 1500); provença', 'fre'),
	(326, 'Ojibwa', 'fre'),
	(327, 'Oriya', 'fre'),
	(328, 'Galla', 'fre'),
	(329, 'Osage', 'fre'),
	(330, 'Ossète', 'fre'),
	(331, 'Turc ottoman (1500-1928)', 'fre'),
	(332, 'Otomangue, langues', 'fre'),
	(333, 'Papoues, autres langues', 'fre'),
	(334, 'Pangasinan', 'fre'),
	(335, 'Pahlavi', 'fre'),
	(336, 'Pampangan', 'fre'),
	(337, 'Pendjabi', 'fre'),
	(338, 'Papiamento', 'fre'),
	(339, 'Palau', 'fre'),
	(340, 'Perse, vieux (ca. 600-400 av. J.-C.)', 'fre'),
	(341, 'Persan', 'fre'),
	(342, 'Philippines, autres langues', 'fre'),
	(343, 'Phénicien', 'fre'),
	(344, 'Pali', 'fre'),
	(345, 'Polonais', 'fre'),
	(346, 'Pohnpei', 'fre'),
	(347, 'Portugais', 'fre'),
	(348, 'Prâkrit', 'fre'),
	(349, 'Provençal ancien (jusqu''à 1500', 'fre'),
	(350, 'Pachto', 'fre'),
	(351, 'Réservée à l''usage local', 'fre'),
	(352, 'Quechua', 'fre'),
	(353, 'Rajasthani', 'fre'),
	(354, 'Rapanui', 'fre'),
	(355, 'Rarotonga; maori des îles Cook', 'fre'),
	(356, 'Romanes, autres langues', 'fre'),
	(357, 'Romanche', 'fre'),
	(358, 'Tsigane', 'fre'),
	(359, 'Roumain', 'fre'),
	(360, 'Rundi', 'fre'),
	(361, 'Aroumain; macédo-roumain', 'fre'),
	(362, 'Russe', 'fre'),
	(363, 'Sandawe', 'fre'),
	(364, 'Sango', 'fre'),
	(365, 'Iakoute', 'fre'),
	(366, 'Indiennes d''Amérique du Sud, autre', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(367, 'Salish, langues', 'fre'),
	(368, 'Samaritain', 'fre'),
	(369, 'Sanskrit', 'fre'),
	(370, 'Sasak', 'fre'),
	(371, 'Santal', 'fre'),
	(372, 'Serbe', 'fre'),
	(373, 'Sicilien', 'fre'),
	(374, 'Écossais', 'fre'),
	(375, 'Croate', 'fre'),
	(376, 'Selkoupe', 'fre'),
	(377, 'Sémitiques, autres langues', 'fre'),
	(378, 'Irlandais ancien (jusqu''à 900)', 'fre'),
	(379, 'Langues des signes', 'fre'),
	(380, 'Chan', 'fre'),
	(381, 'Sidamo', 'fre'),
	(382, 'Singhalais', 'fre'),
	(383, 'Sioux, langues', 'fre'),
	(384, 'Sino-tibétaines, autres langues', 'fre'),
	(385, 'Slaves, autres langues', 'fre'),
	(386, 'Slovaque', 'fre'),
	(387, 'Slovène', 'fre'),
	(388, 'Sami du Sud', 'fre'),
	(389, 'Sami du Nord', 'fre'),
	(390, 'Sami, autres langues', 'fre'),
	(391, 'Sami de Lule', 'fre'),
	(392, 'Sami d''Inari', 'fre'),
	(393, 'Samoan', 'fre'),
	(394, 'Sami skolt', 'fre'),
	(395, 'Shona', 'fre'),
	(396, 'Sindhi', 'fre'),
	(397, 'Soninké', 'fre'),
	(398, 'Sogdien', 'fre'),
	(399, 'Somali', 'fre'),
	(400, 'Songhai, langues', 'fre'),
	(401, 'Sotho du Sud', 'fre'),
	(402, 'Espagnol; castillan', 'fre'),
	(403, 'Sarde; Zazaki', 'fre'),
	(404, 'Sranan tongo', 'fre'),
	(405, 'Sérère', 'fre'),
	(406, 'Nilo-sahariennes, autres langues', 'fre'),
	(407, 'Swati', 'fre'),
	(408, 'Sukuma', 'fre'),
	(409, 'Soundanais', 'fre'),
	(410, 'Soussou', 'fre'),
	(411, 'Sumérien', 'fre'),
	(412, 'Swahili', 'fre'),
	(413, 'Suédois', 'fre'),
	(414, 'Syriaque', 'fre'),
	(415, 'Tahitien', 'fre'),
	(416, 'Thaïes, autres langues', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(417, 'Tamoul', 'fre'),
	(418, 'Tatar', 'fre'),
	(419, 'Télougou', 'fre'),
	(420, 'Temne', 'fre'),
	(421, 'Tereno', 'fre'),
	(422, 'Tetum', 'fre'),
	(423, 'Tadjik', 'fre'),
	(424, 'Tagalog', 'fre'),
	(425, 'Thaï', 'fre'),
	(426, 'Tibétain', 'fre'),
	(427, 'Tigré', 'fre'),
	(428, 'Tigrigna', 'fre'),
	(429, 'Tiv', 'fre'),
	(430, 'Tokelau', 'fre'),
	(431, 'Klingon', 'fre'),
	(432, 'Tlingit', 'fre'),
	(433, 'Tamacheq', 'fre'),
	(434, 'Tonga (Nyasa)', 'fre'),
	(435, 'Tongan (Îles Tonga)', 'fre'),
	(436, 'Tok pisin', 'fre'),
	(437, 'Tsimshian', 'fre'),
	(438, 'Tswana', 'fre'),
	(439, 'Tsonga', 'fre'),
	(440, 'Turkmène', 'fre'),
	(441, 'Tumbuka', 'fre'),
	(442, 'Tupi, langues', 'fre'),
	(443, 'Turc', 'fre'),
	(444, 'Altaïques, autres langues', 'fre'),
	(445, 'Tuvalu', 'fre'),
	(446, 'Twi', 'fre'),
	(447, 'Touva', 'fre'),
	(448, 'Oudmourte', 'fre'),
	(449, 'Ougaritique', 'fre'),
	(450, 'Ouïgour', 'fre'),
	(451, 'Ukrainien', 'fre'),
	(452, 'Umbundu', 'fre'),
	(453, 'Indéterminée', 'fre'),
	(454, 'Ourdou', 'fre'),
	(455, 'Ouszbek', 'fre'),
	(456, 'Vaï', 'fre'),
	(457, 'Venda', 'fre'),
	(458, 'Vietnamien', 'fre'),
	(459, 'Volapük', 'fre'),
	(460, 'Vote', 'fre'),
	(461, 'Wakashennes, langues', 'fre'),
	(462, 'Walamo', 'fre'),
	(463, 'Waray', 'fre'),
	(464, 'Washo', 'fre'),
	(465, 'Gallois', 'fre'),
	(466, 'Sorabes, langues', 'fre');
INSERT INTO public.isolanguagesdes VALUES
	(467, 'Wallon', 'fre'),
	(468, 'Wolof', 'fre'),
	(469, 'Kalmouk; oïrat', 'fre'),
	(470, 'Xhosa', 'fre'),
	(471, 'Yao', 'fre'),
	(472, 'Yapois', 'fre'),
	(473, 'Yiddish', 'fre'),
	(474, 'Yoruba', 'fre'),
	(475, 'Yupik, langues', 'fre'),
	(476, 'Zapotèque', 'fre'),
	(477, 'Zenaga', 'fre'),
	(478, 'Zhuang; chuang', 'fre'),
	(479, 'Zandé, langues', 'fre'),
	(480, 'Zoulou', 'fre'),
	(481, 'Zuni', 'fre'),
	(482, 'Pas de contenu linguistique', 'fre'),
	(483, 'N''ko', 'fre'),
	(484, 'Zaza; dimili; dimli; kirdki; kirmanjki', 'fre'),
	(1, 'Danakil-Sprache', 'ger'),
	(2, 'Abchasisch', 'ger'),
	(3, 'Aceh-Sprache', 'ger'),
	(4, 'Acholi-Sprache', 'ger'),
	(5, 'Adangme-Sprache', 'ger'),
	(6, 'Adygisch', 'ger'),
	(7, 'Hamitosemitische Sprachen (Andere)', 'ger'),
	(8, 'Afrihili', 'ger'),
	(9, 'Afrikaans', 'ger'),
	(10, 'Ainu-Sprache', 'ger'),
	(11, 'Akan-Sprache', 'ger'),
	(12, 'Akkadisch', 'ger'),
	(13, 'Albanisch', 'ger'),
	(14, 'Aleutisch', 'ger'),
	(15, 'Algonkin-Sprachen (Andere)', 'ger'),
	(16, 'Südaltaisch', 'ger'),
	(17, 'Amharisch', 'ger'),
	(18, 'Altenglisch', 'ger'),
	(19, 'Anga-Sprache', 'ger'),
	(20, 'Apachen-Sprache', 'ger'),
	(21, 'Arabisch', 'ger'),
	(22, 'Aramäisch', 'ger'),
	(23, 'Aragonesisch', 'ger'),
	(24, 'Armenisch', 'ger'),
	(25, 'Arauka-Sprachen', 'ger'),
	(26, 'Arapaho-Sprache', 'ger'),
	(27, 'Kunstsprachen (Andere)', 'ger'),
	(28, 'Arawak-Sprachen', 'ger'),
	(29, 'Assamesisch', 'ger'),
	(30, 'Asturisch', 'ger'),
	(31, 'Athapaskische Sprachen', 'ger'),
	(32, 'Australische Sprachen', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(33, 'Awarisch', 'ger'),
	(34, 'Avestisch', 'ger'),
	(35, 'Awadhi', 'ger'),
	(36, 'Aymar?°-Sprache', 'ger'),
	(37, 'Aserbaidschanisch', 'ger'),
	(38, 'Banda-Sprachen', 'ger'),
	(39, 'Bamileke-Sprache', 'ger'),
	(40, 'Baschkirisch', 'ger'),
	(41, 'Belutschisch', 'ger'),
	(42, 'Bambara-Sprache', 'ger'),
	(43, 'Balinesisch', 'ger'),
	(44, 'Baskisch', 'ger'),
	(45, 'Basaa-Sprache', 'ger'),
	(46, 'Baltische Sprachen (Andere)', 'ger'),
	(47, 'Bedauye', 'ger'),
	(48, 'Wei?ürussisch', 'ger'),
	(49, 'Bemba-Sprache', 'ger'),
	(50, 'Bengali', 'ger'),
	(51, 'Berbersprachen (Andere)', 'ger'),
	(52, 'Bhojpuri', 'ger'),
	(53, 'Bihari', 'ger'),
	(54, 'Bikol', 'ger'),
	(55, 'Edo-Sprache', 'ger'),
	(56, 'Beach-la-mar', 'ger'),
	(57, 'Blackfoot-Sprache', 'ger'),
	(58, 'Bantusprachen (Andere)res langues', 'ger'),
	(59, 'Bosnisch', 'ger'),
	(60, 'Braj-Bhakha', 'ger'),
	(61, 'Bretonisch', 'ger'),
	(62, 'Batak-Sprache', 'ger'),
	(63, 'Burjatisch', 'ger'),
	(64, 'Bugi-Sprache', 'ger'),
	(65, 'Bulgarisch', 'ger'),
	(66, 'Birmanisch', 'ger'),
	(67, 'Biliin-Sprache', 'ger'),
	(68, 'Caddo-Sprachen', 'ger'),
	(69, 'Indianersprachen. Zentralamerika (Ande', 'ger'),
	(70, 'Karibische Sprachen', 'ger'),
	(71, 'Katalanisch', 'ger'),
	(72, 'Kaukasische Sprachen (Andere)avonic; Old Bulgarian; Old Church Slavonic', 'ger'),
	(73, 'Cebuano', 'ger'),
	(74, 'Keltische Sprachen (Andere)', 'ger'),
	(75, 'Chamorro-Sprache', 'ger'),
	(76, 'Chibcha-Sprachen', 'ger'),
	(77, 'Tschetschenisch', 'ger'),
	(78, 'Chagatai', 'ger'),
	(79, 'Chinesisch(Other)', 'ger'),
	(80, 'Trukesisch', 'ger'),
	(81, 'Tscheremissisch', 'ger'),
	(82, 'Chinook Jargon', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(83, 'Choctaw-Sprache', 'ger'),
	(84, 'Chipewyan-Sprache', 'ger'),
	(85, 'Cherokee-Sprache', 'ger'),
	(86, 'Kirchenslawisch', 'ger'),
	(87, 'Tschuwaschisch', 'ger'),
	(88, 'Cheyenne-Sprache', 'ger'),
	(89, 'Cham-Sprachen', 'ger'),
	(90, 'Koptisch', 'ger'),
	(91, 'Kornisch', 'ger'),
	(92, 'Korsisch', 'ger'),
	(93, 'Kreolisch-Englisch (Andere)', 'ger'),
	(94, 'Kreolisch-Französisch (Andere)', 'ger'),
	(95, 'Kreolisch-Portugiesisch (Andere)', 'ger'),
	(96, 'Cree-Sprache', 'ger'),
	(97, 'Krimtatarisch', 'ger'),
	(98, 'Kreolische Sprachen; Pidginsprachen (A', 'ger'),
	(99, 'Kaschubisch', 'ger'),
	(100, 'Kuschitische Sprachen (Andere)', 'ger'),
	(101, 'Tschechisch', 'ger'),
	(102, 'Dakota-Sprache', 'ger'),
	(103, 'Dänisch', 'ger'),
	(104, 'Darginisch', 'ger'),
	(105, 'Dajakisch', 'ger'),
	(106, 'Delaware-Sprache', 'ger'),
	(107, 'Slave-Sprache', 'ger'),
	(108, 'Dogrib-Sprache', 'ger'),
	(109, 'Dinka-Sprache', 'ger'),
	(110, 'Maledivisch', 'ger'),
	(111, 'Dogri', 'ger'),
	(112, 'Drawidische Sprachen (Andere)', 'ger'),
	(113, 'Niedersorbisch', 'ger'),
	(114, 'Duala-Sprachen', 'ger'),
	(115, 'Mittelniederländisch', 'ger'),
	(116, 'Niederländisch', 'ger'),
	(117, 'Dyula-Sprache', 'ger'),
	(118, 'Dzongkha', 'ger'),
	(119, 'Efik', 'ger'),
	(120, 'Ägyptisch', 'ger'),
	(121, 'Ekajuk', 'ger'),
	(122, 'Elamisch', 'ger'),
	(123, 'Englisch', 'ger'),
	(124, 'Mittelenglisch', 'ger'),
	(125, 'Esperanto', 'ger'),
	(126, 'Estnisch', 'ger'),
	(127, 'Ewe-Sprache', 'ger'),
	(128, 'Ewondos', 'ger'),
	(129, 'Pangwe-Sprache', 'ger'),
	(130, 'Färöisch', 'ger'),
	(131, 'Fante-Sprache', 'ger'),
	(132, 'Fidschi-Sprache', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(133, 'Pilipino', 'ger'),
	(134, 'Finnisch', 'ger'),
	(135, 'Finnougrische Sprache (Andere)', 'ger'),
	(136, 'Fon-Sprache', 'ger'),
	(137, 'Französisch', 'ger'),
	(138, 'Mittelfranzösisch', 'ger'),
	(139, 'Altfranzösisch', 'ger'),
	(140, 'Nordfriesisch', 'ger'),
	(141, 'Ostfriesisch', 'ger'),
	(142, 'Friesisch', 'ger'),
	(143, 'Ful', 'ger'),
	(144, 'Friulisch', 'ger'),
	(145, 'Ga-Sprache', 'ger'),
	(146, 'Gayo-Sprache', 'ger'),
	(147, 'Gbaya-Sprache', 'ger'),
	(148, 'Germanische Sprachen (Andere)', 'ger'),
	(149, 'Georgisch', 'ger'),
	(150, 'Deutsch', 'ger'),
	(151, 'Altäthiopisch', 'ger'),
	(152, 'Gilbertesisch', 'ger'),
	(153, 'Gälisch-Schottisch', 'ger'),
	(154, 'Irisch', 'ger'),
	(155, 'Galicisch', 'ger'),
	(156, 'Manx', 'ger'),
	(157, 'Mittelhochdeutsch', 'ger'),
	(158, 'Althochdeutsch', 'ger'),
	(159, 'Gondi-Sprache', 'ger'),
	(160, 'Gorontalesisch', 'ger'),
	(161, 'Gotischanguage Association)', 'ger'),
	(162, 'Grebo-Sprache', 'ger'),
	(163, 'Griechisch', 'ger'),
	(164, 'Neugriechisch', 'ger'),
	(165, 'Guaranö-Sprache', 'ger'),
	(166, 'Schweizerdeutsch', 'ger'),
	(167, 'Gujarati-Sprache', 'ger'),
	(168, 'Kutchin-Sprache', 'ger'),
	(169, 'Haida-Sprache', 'ger'),
	(170, 'Haitien', 'ger'),
	(171, 'Haussa-Sprache', 'ger'),
	(172, 'Hawaiisch', 'ger'),
	(173, 'Hebräisch', 'ger'),
	(174, 'Herero-Sprache', 'ger'),
	(175, 'Hiligaynon-Sprache', 'ger'),
	(176, 'Himachali', 'ger'),
	(177, 'Hindi', 'ger'),
	(178, 'Hethitisch', 'ger'),
	(179, 'Miao-Sprachen', 'ger'),
	(180, 'Hiri Motu', 'ger'),
	(181, 'Obersorbisch', 'ger'),
	(182, 'Ungarisch', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(183, 'Hupa-Sprache', 'ger'),
	(184, 'Iban-Sprache', 'ger'),
	(185, 'Ibo-Sprache', 'ger'),
	(186, 'Isländisch', 'ger'),
	(187, 'Ido', 'ger'),
	(188, 'Lalo-Sprache', 'ger'),
	(189, 'Ijo-Sprache', 'ger'),
	(190, 'Inuktitut', 'ger'),
	(191, 'Interlingue', 'ger'),
	(192, 'Ilokano-Sprache', 'ger'),
	(193, 'Interlingua (International Auxiliary L', 'ger'),
	(194, 'Indoarische Sprqachen (Andere)', 'ger'),
	(195, 'Bahasa Indonesia', 'ger'),
	(196, 'Indogermanische Sprachen (Andere)', 'ger'),
	(197, 'Inguschisch', 'ger'),
	(198, 'Inupik', 'ger'),
	(199, 'Iranische Sprachen (Andere)', 'ger'),
	(200, 'Irokesische Sprachen (Andere)', 'ger'),
	(201, 'Italienisch', 'ger'),
	(202, 'Javanisch', 'ger'),
	(203, 'Lojban', 'ger'),
	(204, 'Japanisch', 'ger'),
	(205, 'Jüdisch-Persisch', 'ger'),
	(206, 'Jüdisch Arabisch', 'ger'),
	(207, 'Karakalpakisch', 'ger'),
	(208, 'Kabylisch', 'ger'),
	(209, 'Kachin-Sprache', 'ger'),
	(210, 'Grönländisch', 'ger'),
	(211, 'Kamba-Sprache', 'ger'),
	(212, 'Kannada', 'ger'),
	(213, 'Karenisch', 'ger'),
	(214, 'Kaschmiri', 'ger'),
	(215, 'Kanuri-Sprache', 'ger'),
	(216, 'Kawi', 'ger'),
	(217, 'Kasachisch', 'ger'),
	(218, 'Kabardinisch', 'ger'),
	(219, 'Khasi-Sprache', 'ger'),
	(220, 'Khoisan-Sprache (Andere)', 'ger'),
	(221, 'Kambodschanisch', 'ger'),
	(222, 'Sakisch', 'ger'),
	(223, 'Kikuyu-Sprache', 'ger'),
	(224, 'Rwanda-Sprache', 'ger'),
	(225, 'Kirgisisch', 'ger'),
	(226, 'Kimbundu-Sprache', 'ger'),
	(227, 'Konkani', 'ger'),
	(228, 'Komi-Sprache', 'ger'),
	(229, 'Kongo-Sprache', 'ger'),
	(230, 'Koreanisch', 'ger'),
	(231, 'Kosraeanisch', 'ger'),
	(232, 'Kpelle-Sprache', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(233, 'Karatschaiisch-Balkarisch', 'ger'),
	(234, 'Karelisch', 'ger'),
	(235, 'Kru-Sprachen', 'ger'),
	(236, 'Oraon-Sprache', 'ger'),
	(237, 'Kwanyama-Sprache', 'ger'),
	(238, 'Kumükisch', 'ger'),
	(239, 'Kurdisch', 'ger'),
	(240, 'Kutenai-Sprache', 'ger'),
	(241, 'Judenspanisch', 'ger'),
	(242, 'Lahnda', 'ger'),
	(243, 'Lamba-Sprache <Bantusprache>', 'ger'),
	(244, 'Laotisch', 'ger'),
	(245, 'Latein', 'ger'),
	(246, 'Lettisch', 'ger'),
	(247, 'Lesgisch', 'ger'),
	(248, 'Limburgisch', 'ger'),
	(249, 'Lingala', 'ger'),
	(250, 'Litauisch', 'ger'),
	(251, 'Mongo-Sprache', 'ger'),
	(252, 'Rotse-Spache', 'ger'),
	(253, 'Luxemburgisch', 'ger'),
	(254, 'Lulua-Sprache', 'ger'),
	(255, 'Luba-Katanga-Sprachexon, Low', 'ger'),
	(256, 'Ganda-Sprache', 'ger'),
	(257, 'Luise?±o-Sprache', 'ger'),
	(258, 'Lunda-Sprache', 'ger'),
	(259, 'Luo-Sprache', 'ger'),
	(260, 'Lushai-Sprache', 'ger'),
	(261, 'Makedonisch00E5l', 'ger'),
	(262, 'Maduresisch', 'ger'),
	(263, 'Khotta', 'ger'),
	(264, 'Marschallesisch', 'ger'),
	(265, 'Maithili', 'ger'),
	(266, 'Makassarischl Nepal Bhasa', 'ger'),
	(267, 'Malayalam', 'ger'),
	(268, 'Malinke Sprache', 'ger'),
	(269, 'Maori-Sprache', 'ger'),
	(270, 'Austronesische Sprachen (Andere)', 'ger'),
	(271, 'Marathi', 'ger'),
	(272, 'Massai-Sprache', 'ger'),
	(273, 'Malaiisch', 'ger'),
	(274, 'Mokscha-Sprache', 'ger'),
	(275, 'Mandaresisch', 'ger'),
	(276, 'Mende-Sprache', 'ger'),
	(277, 'Mittelirisch', 'ger'),
	(278, 'Micmac-Sprache', 'ger'),
	(279, 'Minangkabau-Sprache', 'ger'),
	(280, 'Einzelne andere Sprachen', 'ger'),
	(281, 'Mon-Khmer-Sprachen (Andere)', 'ger'),
	(282, 'Malagassi-Sprache', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(283, 'Maltesisch', 'ger'),
	(284, 'Mandschurisch', 'ger'),
	(285, 'Meithei-Sprache', 'ger'),
	(286, 'Manobo-Sprache', 'ger'),
	(287, 'Mohawk-Sprache', 'ger'),
	(288, 'Moldauisch', 'ger'),
	(289, 'Mongolisch', 'ger'),
	(290, 'Mossi-Sprache', 'ger'),
	(291, 'Mehrere Sprachen', 'ger'),
	(292, 'Mundasprachen (Andere)', 'ger'),
	(293, 'Muskogisch', 'ger'),
	(294, 'Mirandesisch', 'ger'),
	(295, 'Marwari', 'ger'),
	(296, 'Maya-Sprachen', 'ger'),
	(297, 'Erza-Mordwinisch', 'ger'),
	(298, 'Nahuatl', 'ger'),
	(299, 'Indianersprachen, Nordamerika (Andere)', 'ger'),
	(300, 'Neapel, Mundart', 'ger'),
	(301, 'Nauranisch', 'ger'),
	(302, 'Navajo-Sprache', 'ger'),
	(303, 'Ndebele-Sprache (Transvaaal)', 'ger'),
	(304, 'Ndebele-Sprache (Simbabwe)', 'ger'),
	(305, 'Ndonga', 'ger'),
	(306, 'Niederdeutsch', 'ger'),
	(307, 'Nepali', 'ger'),
	(308, 'Newari', 'ger'),
	(309, 'Nias-Sprache', 'ger'),
	(310, 'Nigerkordofanische Sprache (Andere)', 'ger'),
	(311, 'Niue-Sprache', 'ger'),
	(312, 'Nynorsk', 'ger'),
	(313, 'Bokmal', 'ger'),
	(314, 'Nogaisch', 'ger'),
	(315, 'Altnorwegisch', 'ger'),
	(316, 'Norwegisch', 'ger'),
	(317, 'Pedi-Sprache', 'ger'),
	(318, 'Nubische Sprachen', 'ger'),
	(319, 'Alt-Newari', 'ger'),
	(320, 'Nyanja-Sprache', 'ger'),
	(321, 'Nyamwezi-Sprache', 'ger'),
	(322, 'Nkole-Sprache', 'ger'),
	(323, 'Nyoro-Sprache', 'ger'),
	(324, 'Nzima-Sprache', 'ger'),
	(325, 'Okzitanisch', 'ger'),
	(326, 'Ojibwa-Sprache', 'ger'),
	(327, 'Oriya-Sprache', 'ger'),
	(328, 'Galla-Sprache', 'ger'),
	(329, 'Osage-Sprache', 'ger'),
	(330, 'Ossetisch', 'ger'),
	(331, 'Osmanisch', 'ger'),
	(332, 'Otomangue-Sprachen', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(333, 'Papuasprachen (Andere)', 'ger'),
	(334, 'Pangasinan-Sprache', 'ger'),
	(335, 'Mittelpersisch', 'ger'),
	(336, 'Pampanggan-Sprache', 'ger'),
	(337, 'Pandschabi-Sprache', 'ger'),
	(338, 'Papiamento', 'ger'),
	(339, 'Palau-Sprache', 'ger'),
	(340, 'Altpersisch', 'ger'),
	(341, 'Persisch', 'ger'),
	(342, 'Philippinen-Austronesisch (Andere)', 'ger'),
	(343, 'Phönikisch', 'ger'),
	(344, 'Pali', 'ger'),
	(345, 'Polnisch', 'ger'),
	(346, 'Ponapeanisch', 'ger'),
	(347, 'Portugiesisch', 'ger'),
	(348, 'Prakrit', 'ger'),
	(349, 'Altokzitanisch', 'ger'),
	(350, 'Paschtu', 'ger'),
	(351, 'Reserviert für den lokalen Gebrauch', 'ger'),
	(352, 'Quechua-Sprache', 'ger'),
	(353, 'Rajasthani', 'ger'),
	(354, 'Osterinsel-Sprache', 'ger'),
	(355, 'Rarotonganisch', 'ger'),
	(356, 'Romanische Sprachen (Andere)', 'ger'),
	(357, 'Rätoromanisch', 'ger'),
	(358, 'Romani Sprache', 'ger'),
	(359, 'Rumänisch', 'ger'),
	(360, 'Rundi-Sprache', 'ger'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'ger'),
	(362, 'Russisch', 'ger'),
	(363, 'Sandawe-Sprache', 'ger'),
	(364, 'Sango-Sprache', 'ger'),
	(365, 'Jakutisch', 'ger'),
	(366, 'Indianersprachen, Südamerika (Andere)', 'ger'),
	(367, 'Salish-Sprache', 'ger'),
	(368, 'Samaritanisch', 'ger'),
	(369, 'Sanskrit', 'ger'),
	(370, 'Sasak', 'ger'),
	(371, 'Santali', 'ger'),
	(372, 'Serbisch', 'ger'),
	(373, 'Sizilianisch', 'ger'),
	(374, 'Schottisch', 'ger'),
	(375, 'Kroatisch', 'ger'),
	(376, 'Selkupisch', 'ger'),
	(377, 'Semitische Sprachen (Andere)', 'ger'),
	(378, 'Altirisch', 'ger'),
	(379, 'Zeichensprache', 'ger'),
	(380, 'Schan-Sprache', 'ger'),
	(381, 'Sidamo-Sprache', 'ger'),
	(382, 'Singhalesisch', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(383, 'Sioux-Sprachen', 'ger'),
	(384, 'Sinotibetische Sprachen (Andere)', 'ger'),
	(385, 'Slawische Sprachen (Andere)', 'ger'),
	(386, 'Slowakisch', 'ger'),
	(387, 'Slowenisch', 'ger'),
	(388, 'Südsaamisch', 'ger'),
	(389, 'Nordsaamisch', 'ger'),
	(390, 'Saamisch (Andere)', 'ger'),
	(391, 'Lulesaamisch', 'ger'),
	(392, 'Inarisaamisch', 'ger'),
	(393, 'Samoanisch', 'ger'),
	(394, 'Skoltsaamisch', 'ger'),
	(395, 'Schona-Sprache', 'ger'),
	(396, 'Sindhi-Sprache', 'ger'),
	(397, 'Soninke-Sprache', 'ger'),
	(398, 'Sogdisch', 'ger'),
	(399, 'Somali', 'ger'),
	(400, 'Songhai-Sprache', 'ger'),
	(401, 'Süd-Sotho-Sprache', 'ger'),
	(402, 'Spanisch', 'ger'),
	(403, 'Sardisch', 'ger'),
	(404, 'Sranantongo', 'ger'),
	(405, 'Serer-Sprache', 'ger'),
	(406, 'Nilosaharanische Sprachen (Andere)', 'ger'),
	(407, 'Swasi-Sprache', 'ger'),
	(408, 'Sukuma-Sprache', 'ger'),
	(409, 'Sundanesisch', 'ger'),
	(410, 'Susu', 'ger'),
	(411, 'Sumerisch', 'ger'),
	(412, 'Swahili', 'ger'),
	(413, 'Schwedisch', 'ger'),
	(414, 'Syrisch', 'ger'),
	(415, 'Tahitisch', 'ger'),
	(416, 'Thaisprachen (Andere)', 'ger'),
	(417, 'Tamil', 'ger'),
	(418, 'Tatarisch', 'ger'),
	(419, 'Telugu-Sprache', 'ger'),
	(420, 'Temne-Sprache', 'ger'),
	(421, 'Tereno-Sprache', 'ger'),
	(422, 'Tetum-Sprache', 'ger'),
	(423, 'Tadschikisch', 'ger'),
	(424, 'Tagalog', 'ger'),
	(425, 'Thailändisch', 'ger'),
	(426, 'Tibetisch', 'ger'),
	(427, 'Tigre-Sprachen', 'ger'),
	(428, 'Tigrinja-Sprache', 'ger'),
	(429, 'Tiv-Sprache', 'ger'),
	(430, 'Tokelauanisch', 'ger'),
	(431, 'Klingonisch', 'ger'),
	(432, 'Tlingit-Sprache', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(433, 'Tamaseq', 'ger'),
	(434, 'Tonga (Bantusprache,Malawi)', 'ger'),
	(435, 'Tongaisch', 'ger'),
	(436, 'Neumelanesischanguage Association)', 'ger'),
	(437, 'Tsimshian-Sprache', 'ger'),
	(438, 'Tswana-Sprache', 'ger'),
	(439, 'Tsonga-Sprache', 'ger'),
	(440, 'Turkmenisch', 'ger'),
	(441, 'Tumbuka-Sprache', 'ger'),
	(442, 'Tupi-Sprache', 'ger'),
	(443, 'Türkisch', 'ger'),
	(444, 'Altaische Sprachen (Andere)', 'ger'),
	(445, 'Elliceanisch', 'ger'),
	(446, 'Twi-Sprache', 'ger'),
	(447, 'Tuwinisch', 'ger'),
	(448, 'Udumurtisch', 'ger'),
	(449, 'Ugaritisch', 'ger'),
	(450, 'Uigurisch', 'ger'),
	(451, 'Ukrainisch', 'ger'),
	(452, 'Mbundu-Sprache', 'ger'),
	(453, 'Nicht zu entscheiden', 'ger'),
	(454, 'Urdu', 'ger'),
	(455, 'Usbekisch', 'ger'),
	(456, 'Vai-Sprache', 'ger'),
	(457, 'Venda-Sprache', 'ger'),
	(458, 'Vietnamesisch', 'ger'),
	(459, 'Volapük', 'ger'),
	(460, 'Wotisch', 'ger'),
	(461, 'Wakash-Sprachen', 'ger'),
	(462, 'Walamo-Sprache', 'ger'),
	(463, 'Waray', 'ger'),
	(464, 'Washo-Sprache', 'ger'),
	(465, 'Kymrisch', 'ger'),
	(466, 'Sorbisch', 'ger'),
	(467, 'Wallonisch', 'ger'),
	(468, 'Wolof-Sprache', 'ger'),
	(469, 'Kalmükisch', 'ger'),
	(470, 'Xhosa-Sprache', 'ger'),
	(471, 'Yao-Sprache (Bantusprache)', 'ger'),
	(472, 'Yapesisch', 'ger'),
	(473, 'Jiddisch', 'ger'),
	(474, 'Yoruba-Sprache', 'ger'),
	(475, 'Yupik-Sprache', 'ger'),
	(476, 'Zapotekisch', 'ger'),
	(477, 'Zenaga', 'ger'),
	(478, 'Zhuang', 'ger'),
	(479, 'Zande-Sprachen', 'ger'),
	(480, 'Zulu-Sprache', 'ger'),
	(481, 'Zu?±i-Sprache', 'ger'),
	(482, 'Kein linguistischer Inhalt', 'ger');
INSERT INTO public.isolanguagesdes VALUES
	(483, 'Nkole-Sprache', 'ger'),
	(484, 'Zazaki', 'ger'),
	(1, 'Afar', 'spa'),
	(2, 'Abkhazian', 'spa'),
	(3, 'Achinese', 'spa'),
	(4, 'Acoli', 'spa'),
	(5, 'Adangme', 'spa'),
	(6, 'Adyghe; Adygei', 'spa'),
	(7, 'Afro-Asiatic (Other)', 'spa'),
	(8, 'Afrihili', 'spa'),
	(9, 'Afrikaans', 'spa'),
	(10, 'Ainu', 'spa'),
	(11, 'Akan', 'spa'),
	(12, 'Akkadian', 'spa'),
	(13, 'Albanian', 'spa'),
	(14, 'Aleut', 'spa'),
	(15, 'Algonquian languages', 'spa'),
	(16, 'Southern Altai', 'spa'),
	(17, 'Amharic', 'spa'),
	(18, 'English, Old (ca.450-1100)', 'spa'),
	(19, 'Angika', 'spa'),
	(20, 'Apache languages', 'spa'),
	(21, 'Arabic', 'spa'),
	(22, 'Aramaic', 'spa'),
	(23, 'Aragonese', 'spa'),
	(24, 'Armenian', 'spa'),
	(25, 'Mapudungun; Mapuche', 'spa'),
	(26, 'Arapaho', 'spa'),
	(27, 'Artificial (Other)', 'spa'),
	(28, 'Arawak', 'spa'),
	(29, 'Assamese', 'spa'),
	(30, 'Asturian; Bable', 'spa'),
	(31, 'Athapascan languages', 'spa'),
	(32, 'Australian languages', 'spa'),
	(33, 'Avaric', 'spa'),
	(34, 'Avestan', 'spa'),
	(35, 'Awadhi', 'spa'),
	(36, 'Aymara', 'spa'),
	(37, 'Azerbaijani', 'spa'),
	(38, 'Banda languages', 'spa'),
	(39, 'Bamileke languages', 'spa'),
	(40, 'Bashkir', 'spa'),
	(41, 'Baluchi', 'spa'),
	(42, 'Bambara', 'spa'),
	(43, 'Balinese', 'spa'),
	(44, 'Basque', 'spa'),
	(45, 'Basa', 'spa'),
	(46, 'Baltic (Other)', 'spa'),
	(47, 'Beja', 'spa'),
	(48, 'Belarusian', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(49, 'Bemba', 'spa'),
	(50, 'Bengali', 'spa'),
	(51, 'Berber (Other)', 'spa'),
	(52, 'Bhojpuri', 'spa'),
	(53, 'Bihari', 'spa'),
	(54, 'Bikol', 'spa'),
	(55, 'Bini; Edo', 'spa'),
	(56, 'Bislama', 'spa'),
	(57, 'Siksika', 'spa'),
	(58, 'Bantu (Other)', 'spa'),
	(59, 'Bosnian', 'spa'),
	(60, 'Braj', 'spa'),
	(61, 'Breton', 'spa'),
	(62, 'Batak languages', 'spa'),
	(63, 'Buriat', 'spa'),
	(64, 'Buginese', 'spa'),
	(65, 'Bulgarian', 'spa'),
	(66, 'Burmese', 'spa'),
	(67, 'Blin; Bilin', 'spa'),
	(68, 'Caddo', 'spa'),
	(69, 'Central American Indian (Other)', 'spa'),
	(70, 'Galibi Carib', 'spa'),
	(71, 'Catalan; Valencian', 'spa'),
	(72, 'Caucasian (Other)', 'spa'),
	(73, 'Cebuano', 'spa'),
	(74, 'Celtic (Other)', 'spa'),
	(75, 'Chamorro', 'spa'),
	(76, 'Chibcha', 'spa'),
	(77, 'Chechenher)', 'spa'),
	(78, 'Chagataier)', 'spa'),
	(79, 'Chinese(Other)', 'spa'),
	(80, 'Chuukese', 'spa'),
	(81, 'Mari', 'spa'),
	(82, 'Chinook jargon', 'spa'),
	(83, 'Choctaw', 'spa'),
	(84, 'Chipewyan', 'spa'),
	(85, 'Cherokee', 'spa'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'spa'),
	(87, 'Chuvash', 'spa'),
	(88, 'Cheyenne', 'spa'),
	(89, 'Chamic languages', 'spa'),
	(90, 'Coptic', 'spa'),
	(91, 'Cornish', 'spa'),
	(92, 'Corsican', 'spa'),
	(93, 'Creoles and pidgins, English based (Ot', 'spa'),
	(94, 'Creoles and pidgins, French-based (Oth', 'spa'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'spa'),
	(96, 'Cree', 'spa'),
	(97, 'Crimean Tatar; Crimean Turkish', 'spa'),
	(98, 'Creoles and pidgins (Other)', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(99, 'Kashubian', 'spa'),
	(100, 'Cushitic (Other)', 'spa'),
	(101, 'Czech', 'spa'),
	(102, 'Dakota', 'spa'),
	(103, 'Danish', 'spa'),
	(104, 'Dargwa', 'spa'),
	(105, 'Land Dayak languages', 'spa'),
	(106, 'Delaware', 'spa'),
	(107, 'Slave (Athapascan)', 'spa'),
	(108, 'Dogrib', 'spa'),
	(109, 'Dinka', 'spa'),
	(110, 'Divehi; Dhivehi; Maldivian', 'spa'),
	(111, 'Dogri', 'spa'),
	(112, 'Dravidian (Other)', 'spa'),
	(113, 'Lower Sorbian', 'spa'),
	(114, 'Duala', 'spa'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'spa'),
	(116, 'Dutch; Flemish', 'spa'),
	(117, 'Dyula', 'spa'),
	(118, 'Dzongkha', 'spa'),
	(119, 'Efik', 'spa'),
	(120, 'Egyptian (Ancient)', 'spa'),
	(121, 'Ekajuk', 'spa'),
	(122, 'Elamite', 'spa'),
	(123, 'English', 'spa'),
	(124, 'English, Middle (1100-1500)', 'spa'),
	(125, 'Esperanto', 'spa'),
	(126, 'Estonian', 'spa'),
	(127, 'Ewe', 'spa'),
	(128, 'Ewondo', 'spa'),
	(129, 'Fang', 'spa'),
	(130, 'Faroese', 'spa'),
	(131, 'Fanti', 'spa'),
	(132, 'Fijian', 'spa'),
	(133, 'Filipino; Pilipino', 'spa'),
	(134, 'Finnish', 'spa'),
	(135, 'Finno-Ugrian (Other)', 'spa'),
	(136, 'Fon', 'spa'),
	(137, 'French', 'spa'),
	(138, 'French, Middle (ca.1400-1600)', 'spa'),
	(139, 'French, Old (842-ca.1400)', 'spa'),
	(140, 'Northern Frisian', 'spa'),
	(141, 'Eastern Frisian', 'spa'),
	(142, 'Western Frisian', 'spa'),
	(143, 'Fulah', 'spa'),
	(144, 'Friulian', 'spa'),
	(145, 'Ga', 'spa'),
	(146, 'Gayo', 'spa'),
	(147, 'Gbaya', 'spa'),
	(148, 'Germanic (Other)', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(149, 'Georgian', 'spa'),
	(150, 'German', 'spa'),
	(151, 'Geez', 'spa'),
	(152, 'Gilbertese', 'spa'),
	(153, 'Gaelic; Scottish Gaelic', 'spa'),
	(154, 'Irish', 'spa'),
	(155, 'Galician', 'spa'),
	(156, 'Manx', 'spa'),
	(157, 'German, Middle High (ca.1050-1500)', 'spa'),
	(158, 'German, Old High (ca.750-1050)', 'spa'),
	(159, 'Gondi', 'spa'),
	(160, 'Gorontalo', 'spa'),
	(161, 'Gothictionale)', 'spa'),
	(162, 'Grebo', 'spa'),
	(163, 'Greek, Ancient (to 1453)', 'spa'),
	(164, 'Greek, Modern (1453-)', 'spa'),
	(165, 'Guarani', 'spa'),
	(166, 'Swiss German; Alemannic', 'spa'),
	(167, 'Gujarati', 'spa'),
	(168, 'Gwich''in', 'spa'),
	(169, 'Haida', 'spa'),
	(170, 'Haitian; Haitian Creole', 'spa'),
	(171, 'Hausa', 'spa'),
	(172, 'Hawaiian', 'spa'),
	(173, 'Hebrew', 'spa'),
	(174, 'Herero', 'spa'),
	(175, 'Hiligaynon', 'spa'),
	(176, 'Himachali', 'spa'),
	(177, 'Hindi', 'spa'),
	(178, 'Hittite', 'spa'),
	(179, 'Hmong', 'spa'),
	(180, 'Hiri Motu', 'spa'),
	(181, 'Upper Sorbian', 'spa'),
	(182, 'Hungarian', 'spa'),
	(183, 'Hupa', 'spa'),
	(184, 'Iban', 'spa'),
	(185, 'Igbo', 'spa'),
	(186, 'Icelandic', 'spa'),
	(187, 'Ido', 'spa'),
	(188, 'Sichuan Yi', 'spa'),
	(189, 'Ijo languages', 'spa'),
	(190, 'Inuktitut', 'spa'),
	(191, 'Interlingue', 'spa'),
	(192, 'Iloko', 'spa'),
	(193, 'Interlingua (International Auxiliary L', 'spa'),
	(194, 'Indic (Other)', 'spa'),
	(195, 'Indonesian', 'spa'),
	(196, 'Indo-European (Other)', 'spa'),
	(197, 'Ingush', 'spa'),
	(198, 'Inupiaq', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(199, 'Iranian (Other)', 'spa'),
	(200, 'Iroquoian languages', 'spa'),
	(201, 'Italian', 'spa'),
	(202, 'Javanese', 'spa'),
	(203, 'Lojban', 'spa'),
	(204, 'Japanese', 'spa'),
	(205, 'Judeo-Persian', 'spa'),
	(206, 'Judeo-Arabic', 'spa'),
	(207, 'Kara-Kalpak', 'spa'),
	(208, 'Kabyle', 'spa'),
	(209, 'Kachin; Jingpho', 'spa'),
	(210, 'Kalaallisut; Greenlandic', 'spa'),
	(211, 'Kamba', 'spa'),
	(212, 'Kannada', 'spa'),
	(213, 'Karen languages', 'spa'),
	(214, 'Kashmiri', 'spa'),
	(215, 'Kanuri', 'spa'),
	(216, 'Kawi', 'spa'),
	(217, 'Kazakh', 'spa'),
	(218, 'Kabardian', 'spa'),
	(219, 'Khasi', 'spa'),
	(220, 'Khoisan (Other)', 'spa'),
	(221, 'Central Khmer', 'spa'),
	(222, 'Khotanese', 'spa'),
	(223, 'Kikuyu; Gikuyu', 'spa'),
	(224, 'Kinyarwanda', 'spa'),
	(225, 'Kirghiz; Kyrgyz', 'spa'),
	(226, 'Kimbundu', 'spa'),
	(227, 'Konkani', 'spa'),
	(228, 'Komi', 'spa'),
	(229, 'Kongo', 'spa'),
	(230, 'Korean', 'spa'),
	(231, 'Kosraean', 'spa'),
	(232, 'Kpelle', 'spa'),
	(233, 'Karachay-Balkar', 'spa'),
	(234, 'Karelian', 'spa'),
	(235, 'Kru languages', 'spa'),
	(236, 'Kurukh', 'spa'),
	(237, 'Kuanyama; Kwanyama', 'spa'),
	(238, 'Kumyk', 'spa'),
	(239, 'Kurdish', 'spa'),
	(240, 'Kutenai', 'spa'),
	(241, 'Ladino', 'spa'),
	(242, 'Lahnda', 'spa'),
	(243, 'Lamba', 'spa'),
	(244, 'Lao', 'spa'),
	(245, 'Latin', 'spa'),
	(246, 'Latvian', 'spa'),
	(247, 'Lezghian', 'spa'),
	(248, 'Limburgan; Limburger; Limburgish', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(249, 'Lingala', 'spa'),
	(250, 'Lithuanian', 'spa'),
	(251, 'Mongo', 'spa'),
	(252, 'Lozi', 'spa'),
	(253, 'Luxembourgish; Letzeburgesch', 'spa'),
	(254, 'Luba-Lulua', 'spa'),
	(255, 'Luba-Katangaxon, Low', 'spa'),
	(256, 'Ganda', 'spa'),
	(257, 'Luiseno', 'spa'),
	(258, 'Lunda', 'spa'),
	(259, 'Luo (Kenya and Tanzania)', 'spa'),
	(260, 'Lushai', 'spa'),
	(261, 'Macedonian', 'spa'),
	(262, 'Madurese', 'spa'),
	(263, 'Magahi', 'spa'),
	(264, 'Marshallese', 'spa'),
	(265, 'Maithili', 'spa'),
	(266, 'Makasar', 'spa'),
	(267, 'Malayalam', 'spa'),
	(268, 'Mandingo', 'spa'),
	(269, 'Maori', 'spa'),
	(270, 'Austronesian (Other)', 'spa'),
	(271, 'Marathil', 'spa'),
	(272, 'Masai', 'spa'),
	(273, 'Malay', 'spa'),
	(274, 'Moksha', 'spa'),
	(275, 'Mandar', 'spa'),
	(276, 'Mende', 'spa'),
	(277, 'Irish, Middle (900-1200)', 'spa'),
	(278, 'Mi''kmaq; Micmac', 'spa'),
	(279, 'Minangkabau', 'spa'),
	(280, 'Miscellaneous languages', 'spa'),
	(281, 'Mon-Khmer (Other)', 'spa'),
	(282, 'Malagasy', 'spa'),
	(283, 'Maltese', 'spa'),
	(284, 'Manchu', 'spa'),
	(285, 'Manipuri', 'spa'),
	(286, 'Manobo languages', 'spa'),
	(287, 'Mohawk', 'spa'),
	(288, 'Moldavian', 'spa'),
	(289, 'Mongolian', 'spa'),
	(290, 'Mossi', 'spa'),
	(291, 'Multiple languages)', 'spa'),
	(292, 'Munda languages', 'spa'),
	(293, 'Creek', 'spa'),
	(294, 'Mirandese', 'spa'),
	(295, 'Marwari', 'spa'),
	(296, 'Mayan languages', 'spa'),
	(297, 'Erzya', 'spa'),
	(298, 'Nahuatl languages', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(299, 'North American Indian', 'spa'),
	(300, 'Neapolitan', 'spa'),
	(301, 'Nauru', 'spa'),
	(302, 'Navajo; Navaho', 'spa'),
	(303, 'Ndebele, South; South Ndebele', 'spa'),
	(304, 'Ndebele, North; North Ndebele', 'spa'),
	(305, 'Ndonga', 'spa'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'spa'),
	(307, 'Nepali', 'spa'),
	(308, 'Nepal Bhasa; Newari', 'spa'),
	(309, 'Nias', 'spa'),
	(310, 'Niger-Kordofanian (Other)', 'spa'),
	(311, 'Niuean', 'spa'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'spa'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'spa'),
	(314, 'Nogai', 'spa'),
	(315, 'Norse, Old', 'spa'),
	(316, 'Norwegian', 'spa'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'spa'),
	(318, 'Nubian languages', 'spa'),
	(319, 'Classical Newari; Old Newari; Classica', 'spa'),
	(320, 'Chichewa; Chewa; Nyanja', 'spa'),
	(321, 'Nyamwezi', 'spa'),
	(322, 'Nyankole', 'spa'),
	(323, 'Nyoro', 'spa'),
	(324, 'Nzima', 'spa'),
	(325, 'Occitan (post 1500); Provençal', 'spa'),
	(326, 'Ojibwa', 'spa'),
	(327, 'Oriya', 'spa'),
	(328, 'Oromo', 'spa'),
	(329, 'Osage', 'spa'),
	(330, 'Ossetian; Ossetic', 'spa'),
	(331, 'Turkish, Ottoman (1500-1928)', 'spa'),
	(332, 'Otomian languages', 'spa'),
	(333, 'Papuan (Other)', 'spa'),
	(334, 'Pangasinan', 'spa'),
	(335, 'Pahlavi', 'spa'),
	(336, 'Pampanga', 'spa'),
	(337, 'Panjabi; Punjabi', 'spa'),
	(338, 'Papiamento', 'spa'),
	(339, 'Palauan', 'spa'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'spa'),
	(341, 'Persian', 'spa'),
	(342, 'Philippine (Other)', 'spa'),
	(343, 'Phoenician', 'spa'),
	(344, 'Pali', 'spa'),
	(345, 'Polish', 'spa'),
	(346, 'Pohnpeian', 'spa'),
	(347, 'Portuguese', 'spa'),
	(348, 'Prakrit languages', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(349, 'Provençal, Old (to 1500)', 'spa'),
	(350, 'Pushto', 'spa'),
	(351, 'Reserved for local use', 'spa'),
	(352, 'Quechua', 'spa'),
	(353, 'Rajasthani', 'spa'),
	(354, 'Rapanui', 'spa'),
	(355, 'Rarotongan; Cook Islands Maori', 'spa'),
	(356, 'Romance (Other)', 'spa'),
	(357, 'Romansh', 'spa'),
	(358, 'Romany', 'spa'),
	(359, 'Romanian', 'spa'),
	(360, 'Rundi', 'spa'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'spa'),
	(362, 'Russian', 'spa'),
	(363, 'Sandawe', 'spa'),
	(364, 'Sango', 'spa'),
	(365, 'Yakut', 'spa'),
	(366, 'South American Indian (Other)', 'spa'),
	(367, 'Salishan languages', 'spa'),
	(368, 'Samaritan Aramaic', 'spa'),
	(369, 'Sanskrit', 'spa'),
	(370, 'Sasak', 'spa'),
	(371, 'Santali', 'spa'),
	(372, 'Serbian', 'spa'),
	(373, 'Sicilian', 'spa'),
	(374, 'Scots', 'spa'),
	(375, 'Croatian', 'spa'),
	(376, 'Selkup', 'spa'),
	(377, 'Semitic (Other)', 'spa'),
	(378, 'Irish, Old (to 900)', 'spa'),
	(379, 'Sign Languages', 'spa'),
	(380, 'Shan', 'spa'),
	(381, 'Sidamo', 'spa'),
	(382, 'Sinhala; Sinhalese', 'spa'),
	(383, 'Siouan languages', 'spa'),
	(384, 'Sino-Tibetan (Other)', 'spa'),
	(385, 'Slavic (Other)', 'spa'),
	(386, 'Slovak', 'spa'),
	(387, 'Slovenian', 'spa'),
	(388, 'Southern Sami', 'spa'),
	(389, 'Northern Sami', 'spa'),
	(390, 'Sami languages (Other)', 'spa'),
	(391, 'Lule Sami', 'spa'),
	(392, 'Inari Sami', 'spa'),
	(393, 'Samoan', 'spa'),
	(394, 'Skolt Sami', 'spa'),
	(395, 'Shona', 'spa'),
	(396, 'Sindhi', 'spa'),
	(397, 'Soninke', 'spa'),
	(398, 'Sogdian', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(399, 'Somali', 'spa'),
	(400, 'Songhai languages', 'spa'),
	(401, 'Sotho, Southern', 'spa'),
	(402, 'Spanish; Castilian', 'spa'),
	(403, 'Sardinian; Zazaki', 'spa'),
	(404, 'Sranan Tongo', 'spa'),
	(405, 'Serer', 'spa'),
	(406, 'Nilo-Saharan (Other)', 'spa'),
	(407, 'Swati', 'spa'),
	(408, 'Sukuma', 'spa'),
	(409, 'Sundanese', 'spa'),
	(410, 'Susu', 'spa'),
	(411, 'Sumerian', 'spa'),
	(412, 'Swahili', 'spa'),
	(413, 'Swedish', 'spa'),
	(414, 'Syriac', 'spa'),
	(415, 'Tahitianre)', 'spa'),
	(416, 'Tai (Other)', 'spa'),
	(417, 'Tamil', 'spa'),
	(418, 'Tatar', 'spa'),
	(419, 'Telugu', 'spa'),
	(420, 'Timne', 'spa'),
	(421, 'Tereno', 'spa'),
	(422, 'Tetum', 'spa'),
	(423, 'Tajik', 'spa'),
	(424, 'Tagalog', 'spa'),
	(425, 'Thai', 'spa'),
	(426, 'Tibetan', 'spa'),
	(427, 'Tigre', 'spa'),
	(428, 'Tigrinya', 'spa'),
	(429, 'Tiv', 'spa'),
	(430, 'Tokelau', 'spa'),
	(431, 'Klingon; tlhIngan-Hol', 'spa'),
	(432, 'Tlingit', 'spa'),
	(433, 'Tamashek', 'spa'),
	(434, 'Tonga (Nyasa)', 'spa'),
	(435, 'Tonga (Tonga Islands)', 'spa'),
	(436, 'Tok Pisin', 'spa'),
	(437, 'Tsimshian', 'spa'),
	(438, 'Tswana', 'spa'),
	(439, 'Tsonga', 'spa'),
	(440, 'Turkmen', 'spa'),
	(441, 'Tumbuka', 'spa'),
	(442, 'Tupi languages', 'spa'),
	(443, 'Turkish', 'spa'),
	(444, 'Altaic (Other)', 'spa'),
	(445, 'Tuvalu', 'spa'),
	(446, 'Twi', 'spa'),
	(447, 'Tuvinian', 'spa'),
	(448, 'Udmurt', 'spa');
INSERT INTO public.isolanguagesdes VALUES
	(449, 'Ugaritic', 'spa'),
	(450, 'Uighur; Uyghur', 'spa'),
	(451, 'Ukrainian', 'spa'),
	(452, 'Umbundu', 'spa'),
	(453, 'Undetermined', 'spa'),
	(454, 'Urdu', 'spa'),
	(455, 'Uzbek', 'spa'),
	(456, 'Vai', 'spa'),
	(457, 'Venda', 'spa'),
	(458, 'Vietnamese', 'spa'),
	(459, 'Volapük', 'spa'),
	(460, 'Votic', 'spa'),
	(461, 'Wakashan languages', 'spa'),
	(462, 'Walamo', 'spa'),
	(463, 'Waray', 'spa'),
	(464, 'Washo', 'spa'),
	(465, 'Welsh', 'spa'),
	(466, 'Sorbian languages', 'spa'),
	(467, 'Walloon', 'spa'),
	(468, 'Wolof', 'spa'),
	(469, 'Kalmyk; Oirat', 'spa'),
	(470, 'Xhosa', 'spa'),
	(471, 'Yao', 'spa'),
	(472, 'Yapese', 'spa'),
	(473, 'Yiddish', 'spa'),
	(474, 'Yoruba', 'spa'),
	(475, 'Yupik languages', 'spa'),
	(476, 'Zapotec', 'spa'),
	(477, 'Zenaga', 'spa'),
	(478, 'Zhuang; Chuang', 'spa'),
	(479, 'Zande languages', 'spa'),
	(480, 'Zulu', 'spa'),
	(481, 'Zuni', 'spa'),
	(482, 'No linguistic content', 'spa'),
	(483, 'N''Ko', 'spa'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'spa'),
	(1, 'Afar', 'cat'),
	(2, 'Abkhazian', 'cat'),
	(3, 'Achinese', 'cat'),
	(4, 'Acoli', 'cat'),
	(5, 'Adangme', 'cat'),
	(6, 'Adyghe; Adygei', 'cat'),
	(7, 'Afro-Asiatic (Other)', 'cat'),
	(8, 'Afrihili', 'cat'),
	(9, 'Afrikaans', 'cat'),
	(10, 'Ainu', 'cat'),
	(11, 'Akan', 'cat'),
	(12, 'Akkadian', 'cat'),
	(13, 'Albanian', 'cat'),
	(14, 'Aleut', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(15, 'Algonquian languages', 'cat'),
	(16, 'Southern Altai', 'cat'),
	(17, 'Amharic', 'cat'),
	(18, 'English, Old (ca.450-1100)', 'cat'),
	(19, 'Angika', 'cat'),
	(20, 'Apache languages', 'cat'),
	(21, 'Arabic', 'cat'),
	(22, 'Aramaic', 'cat'),
	(23, 'Aragonese', 'cat'),
	(24, 'Armenian', 'cat'),
	(25, 'Mapudungun; Mapuche', 'cat'),
	(26, 'Arapaho', 'cat'),
	(27, 'Artificial (Other)', 'cat'),
	(28, 'Arawak', 'cat'),
	(29, 'Assamese', 'cat'),
	(30, 'Asturian; Bable', 'cat'),
	(31, 'Athapascan languages', 'cat'),
	(32, 'Australian languages', 'cat'),
	(33, 'Avaric', 'cat'),
	(34, 'Avestan', 'cat'),
	(35, 'Awadhi', 'cat'),
	(36, 'Aymara', 'cat'),
	(37, 'Azerbaijani', 'cat'),
	(38, 'Banda languages', 'cat'),
	(39, 'Bamileke languages', 'cat'),
	(40, 'Bashkir', 'cat'),
	(41, 'Baluchi', 'cat'),
	(42, 'Bambara', 'cat'),
	(43, 'Balinese', 'cat'),
	(44, 'Basque', 'cat'),
	(45, 'Basa', 'cat'),
	(46, 'Baltic (Other)', 'cat'),
	(47, 'Beja', 'cat'),
	(48, 'Belarusian', 'cat'),
	(49, 'Bemba', 'cat'),
	(50, 'Bengali', 'cat'),
	(51, 'Berber (Other)', 'cat'),
	(52, 'Bhojpuri', 'cat'),
	(53, 'Bihari', 'cat'),
	(54, 'Bikol', 'cat'),
	(55, 'Bini; Edo', 'cat'),
	(56, 'Bislama', 'cat'),
	(57, 'Siksika', 'cat'),
	(58, 'Bantu (Other)', 'cat'),
	(59, 'Bosnian', 'cat'),
	(60, 'Braj', 'cat'),
	(61, 'Breton', 'cat'),
	(62, 'Batak languages', 'cat'),
	(63, 'Buriat', 'cat'),
	(64, 'Buginese', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(65, 'Bulgarian', 'cat'),
	(66, 'Burmese', 'cat'),
	(67, 'Blin; Bilin', 'cat'),
	(68, 'Caddo', 'cat'),
	(69, 'Central American Indian (Other)', 'cat'),
	(70, 'Galibi Carib', 'cat'),
	(71, 'Catalan; Valencian', 'cat'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'cat'),
	(73, 'Cebuano', 'cat'),
	(74, 'Celtic (Other)', 'cat'),
	(75, 'Chamorro', 'cat'),
	(76, 'Chibcha', 'cat'),
	(77, 'Chechen', 'cat'),
	(78, 'Chagataier)', 'cat'),
	(79, 'Chinese(Other)', 'cat'),
	(80, 'Chuukese', 'cat'),
	(81, 'Mari', 'cat'),
	(82, 'Chinook jargon', 'cat'),
	(83, 'Choctaw', 'cat'),
	(84, 'Chipewyan', 'cat'),
	(85, 'Cherokee', 'cat'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'cat'),
	(87, 'Chuvash', 'cat'),
	(88, 'Cheyenne', 'cat'),
	(89, 'Chamic languages', 'cat'),
	(90, 'Coptic', 'cat'),
	(91, 'Cornish', 'cat'),
	(92, 'Corsican', 'cat'),
	(93, 'Creoles and pidgins, English based (Ot', 'cat'),
	(94, 'Creoles and pidgins, French-based (Oth', 'cat'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'cat'),
	(96, 'Cree', 'cat'),
	(97, 'Crimean Tatar; Crimean Turkish', 'cat'),
	(98, 'Creoles and pidgins (Other)', 'cat'),
	(99, 'Kashubian', 'cat'),
	(100, 'Cushitic (Other)', 'cat'),
	(101, 'Czech', 'cat'),
	(102, 'Dakota', 'cat'),
	(103, 'Danish', 'cat'),
	(104, 'Dargwa', 'cat'),
	(105, 'Land Dayak languages', 'cat'),
	(106, 'Delaware', 'cat'),
	(107, 'Slave (Athapascan)', 'cat'),
	(108, 'Dogrib', 'cat'),
	(109, 'Dinka', 'cat'),
	(110, 'Divehi; Dhivehi; Maldivian', 'cat'),
	(111, 'Dogri', 'cat'),
	(112, 'Dravidian (Other)', 'cat'),
	(113, 'Lower Sorbian', 'cat'),
	(114, 'Duala', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(115, 'Dutch, Middle (ca.1050-1350)', 'cat'),
	(116, 'Dutch; Flemish', 'cat'),
	(117, 'Dyula', 'cat'),
	(118, 'Dzongkha', 'cat'),
	(119, 'Efik', 'cat'),
	(120, 'Egyptian (Ancient)', 'cat'),
	(121, 'Ekajuk', 'cat'),
	(122, 'Elamite', 'cat'),
	(123, 'English', 'cat'),
	(124, 'English, Middle (1100-1500)', 'cat'),
	(125, 'Esperanto', 'cat'),
	(126, 'Estonian', 'cat'),
	(127, 'Ewe', 'cat'),
	(128, 'Ewondo', 'cat'),
	(129, 'Fang', 'cat'),
	(130, 'Faroese', 'cat'),
	(131, 'Fanti', 'cat'),
	(132, 'Fijian', 'cat'),
	(133, 'Filipino; Pilipino', 'cat'),
	(134, 'Finnish', 'cat'),
	(135, 'Finno-Ugrian (Other)', 'cat'),
	(136, 'Fon', 'cat'),
	(137, 'French', 'cat'),
	(138, 'French, Middle (ca.1400-1600)', 'cat'),
	(139, 'French, Old (842-ca.1400)', 'cat'),
	(140, 'Northern Frisian', 'cat'),
	(141, 'Eastern Frisian', 'cat'),
	(142, 'Western Frisian', 'cat'),
	(143, 'Fulah', 'cat'),
	(144, 'Friulian', 'cat'),
	(145, 'Ga', 'cat'),
	(146, 'Gayo', 'cat'),
	(147, 'Gbaya', 'cat'),
	(148, 'Germanic (Other)', 'cat'),
	(149, 'Georgian', 'cat'),
	(150, 'German', 'cat'),
	(151, 'Geez', 'cat'),
	(152, 'Gilbertese', 'cat'),
	(153, 'Gaelic; Scottish Gaelic', 'cat'),
	(154, 'Irish', 'cat'),
	(155, 'Galician', 'cat'),
	(156, 'Manx', 'cat'),
	(157, 'German, Middle High (ca.1050-1500)', 'cat'),
	(158, 'German, Old High (ca.750-1050)', 'cat'),
	(159, 'Gondi', 'cat'),
	(160, 'Gorontalo', 'cat'),
	(161, 'Gothicanguage Association)', 'cat'),
	(162, 'Grebo', 'cat'),
	(163, 'Greek, Ancient (to 1453)', 'cat'),
	(164, 'Greek, Modern (1453-)', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(165, 'Guarani', 'cat'),
	(166, 'Swiss German; Alemannic', 'cat'),
	(167, 'Gujarati', 'cat'),
	(168, 'Gwich''in', 'cat'),
	(169, 'Haida', 'cat'),
	(170, 'Haitian; Haitian Creole', 'cat'),
	(171, 'Hausa', 'cat'),
	(172, 'Hawaiian', 'cat'),
	(173, 'Hebrew', 'cat'),
	(174, 'Herero', 'cat'),
	(175, 'Hiligaynon', 'cat'),
	(176, 'Himachali', 'cat'),
	(177, 'Hindi', 'cat'),
	(178, 'Hittite', 'cat'),
	(179, 'Hmong', 'cat'),
	(180, 'Hiri Motu', 'cat'),
	(181, 'Upper Sorbian', 'cat'),
	(182, 'Hungarian', 'cat'),
	(183, 'Hupa', 'cat'),
	(184, 'Iban', 'cat'),
	(185, 'Igbo', 'cat'),
	(186, 'Icelandic', 'cat'),
	(187, 'Ido', 'cat'),
	(188, 'Sichuan Yi', 'cat'),
	(189, 'Ijo languages', 'cat'),
	(190, 'Inuktitut', 'cat'),
	(191, 'Interlingue', 'cat'),
	(192, 'Iloko', 'cat'),
	(193, 'Interlingua (International Auxiliary L', 'cat'),
	(194, 'Indic (Other)', 'cat'),
	(195, 'Indonesian', 'cat'),
	(196, 'Indo-European (Other)', 'cat'),
	(197, 'Ingush', 'cat'),
	(198, 'Inupiaq', 'cat'),
	(199, 'Iranian (Other)', 'cat'),
	(200, 'Iroquoian languages', 'cat'),
	(201, 'Italian', 'cat'),
	(202, 'Javanese', 'cat'),
	(203, 'Lojban', 'cat'),
	(204, 'Japanese', 'cat'),
	(205, 'Judeo-Persian', 'cat'),
	(206, 'Judeo-Arabic', 'cat'),
	(207, 'Kara-Kalpak', 'cat'),
	(208, 'Kabyle', 'cat'),
	(209, 'Kachin; Jingpho', 'cat'),
	(210, 'Kalaallisut; Greenlandic', 'cat'),
	(211, 'Kamba', 'cat'),
	(212, 'Kannada', 'cat'),
	(213, 'Karen languages', 'cat'),
	(214, 'Kashmiri', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(215, 'Kanuri', 'cat'),
	(216, 'Kawi', 'cat'),
	(217, 'Kazakh', 'cat'),
	(218, 'Kabardian', 'cat'),
	(219, 'Khasi', 'cat'),
	(220, 'Khoisan (Other)', 'cat'),
	(221, 'Central Khmer', 'cat'),
	(222, 'Khotanese', 'cat'),
	(223, 'Kikuyu; Gikuyu', 'cat'),
	(224, 'Kinyarwanda', 'cat'),
	(225, 'Kirghiz; Kyrgyz', 'cat'),
	(226, 'Kimbundu', 'cat'),
	(227, 'Konkani', 'cat'),
	(228, 'Komi', 'cat'),
	(229, 'Kongo', 'cat'),
	(230, 'Korean', 'cat'),
	(231, 'Kosraean', 'cat'),
	(232, 'Kpelle', 'cat'),
	(233, 'Karachay-Balkar', 'cat'),
	(234, 'Karelian', 'cat'),
	(235, 'Kru languages', 'cat'),
	(236, 'Kurukh', 'cat'),
	(237, 'Kuanyama; Kwanyama', 'cat'),
	(238, 'Kumyk', 'cat'),
	(239, 'Kurdish', 'cat'),
	(240, 'Kutenai', 'cat'),
	(241, 'Ladino', 'cat'),
	(242, 'Lahnda', 'cat'),
	(243, 'Lamba', 'cat'),
	(244, 'Lao', 'cat'),
	(245, 'Latin', 'cat'),
	(246, 'Latvian', 'cat'),
	(247, 'Lezghian', 'cat'),
	(248, 'Limburgan; Limburger; Limburgish', 'cat'),
	(249, 'Lingala', 'cat'),
	(250, 'Lithuanian', 'cat'),
	(251, 'Mongo', 'cat'),
	(252, 'Lozi', 'cat'),
	(253, 'Luxembourgish; Letzeburgesch', 'cat'),
	(254, 'Luba-Lulua', 'cat'),
	(255, 'Luba-Katangaxon, Low', 'cat'),
	(256, 'Ganda', 'cat'),
	(257, 'Luiseno', 'cat'),
	(258, 'Lunda', 'cat'),
	(259, 'Luo (Kenya and Tanzania)', 'cat'),
	(260, 'Lushai', 'cat'),
	(261, 'Macedonian00E5l', 'cat'),
	(262, 'Madurese', 'cat'),
	(263, 'Magahi', 'cat'),
	(264, 'Marshallese', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(265, 'Maithili', 'cat'),
	(266, 'Makasarl Nepal Bhasa', 'cat'),
	(267, 'Malayalam', 'cat'),
	(268, 'Mandingo', 'cat'),
	(269, 'Maori', 'cat'),
	(270, 'Austronesian (Other)', 'cat'),
	(271, 'Marathi', 'cat'),
	(272, 'Masai', 'cat'),
	(273, 'Malay', 'cat'),
	(274, 'Moksha', 'cat'),
	(275, 'Mandar', 'cat'),
	(276, 'Mende', 'cat'),
	(277, 'Irish, Middle (900-1200)', 'cat'),
	(278, 'Mi''kmaq; Micmac', 'cat'),
	(279, 'Minangkabau', 'cat'),
	(280, 'Miscellaneous languages', 'cat'),
	(281, 'Mon-Khmer (Other)', 'cat'),
	(282, 'Malagasy', 'cat'),
	(283, 'Maltese', 'cat'),
	(284, 'Manchu', 'cat'),
	(285, 'Manipuri', 'cat'),
	(286, 'Manobo languages', 'cat'),
	(287, 'Mohawk', 'cat'),
	(288, 'Moldavian', 'cat'),
	(289, 'Mongolian', 'cat'),
	(290, 'Mossi', 'cat'),
	(291, 'Multiple languages', 'cat'),
	(292, 'Munda languages', 'cat'),
	(293, 'Creek', 'cat'),
	(294, 'Mirandese', 'cat'),
	(295, 'Marwari', 'cat'),
	(296, 'Mayan languages', 'cat'),
	(297, 'Erzya', 'cat'),
	(298, 'Nahuatl languages', 'cat'),
	(299, 'North American Indian', 'cat'),
	(300, 'Neapolitan', 'cat'),
	(301, 'Nauru', 'cat'),
	(302, 'Navajo; Navaho', 'cat'),
	(303, 'Ndebele, South; South Ndebele', 'cat'),
	(304, 'Ndebele, North; North Ndebele', 'cat'),
	(305, 'Ndonga', 'cat'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'cat'),
	(307, 'Nepali', 'cat'),
	(308, 'Nepal Bhasa; Newari', 'cat'),
	(309, 'Nias', 'cat'),
	(310, 'Niger-Kordofanian (Other)', 'cat'),
	(311, 'Niuean', 'cat'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'cat'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'cat'),
	(314, 'Nogai', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(315, 'Norse, Old', 'cat'),
	(316, 'Norwegian', 'cat'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'cat'),
	(318, 'Nubian languages', 'cat'),
	(319, 'Classical Newari; Old Newari; Classica', 'cat'),
	(320, 'Chichewa; Chewa; Nyanja', 'cat'),
	(321, 'Nyamwezi', 'cat'),
	(322, 'Nyankole', 'cat'),
	(323, 'Nyoro', 'cat'),
	(324, 'Nzima', 'cat'),
	(325, 'Occitan (post 1500); Provençal', 'cat'),
	(326, 'Ojibwa', 'cat'),
	(327, 'Oriya', 'cat'),
	(328, 'Oromo', 'cat'),
	(329, 'Osage', 'cat'),
	(330, 'Ossetian; Ossetic', 'cat'),
	(331, 'Turkish, Ottoman (1500-1928)', 'cat'),
	(332, 'Otomian languages', 'cat'),
	(333, 'Papuan (Other)', 'cat'),
	(334, 'Pangasinan', 'cat'),
	(335, 'Pahlavi', 'cat'),
	(336, 'Pampanga', 'cat'),
	(337, 'Panjabi; Punjabi', 'cat'),
	(338, 'Papiamento', 'cat'),
	(339, 'Palauan', 'cat'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'cat'),
	(341, 'Persian', 'cat'),
	(342, 'Philippine (Other)', 'cat'),
	(343, 'Phoenician', 'cat'),
	(344, 'Pali', 'cat'),
	(345, 'Polish', 'cat'),
	(346, 'Pohnpeian', 'cat'),
	(347, 'Portuguese', 'cat'),
	(348, 'Prakrit languages', 'cat'),
	(349, 'Provençal, Old (to 1500)', 'cat'),
	(350, 'Pushto', 'cat'),
	(351, 'Reserved for local use', 'cat'),
	(352, 'Quechua', 'cat'),
	(353, 'Rajasthani', 'cat'),
	(354, 'Rapanui', 'cat'),
	(355, 'Rarotongan; Cook Islands Maori', 'cat'),
	(356, 'Romance (Other)', 'cat'),
	(357, 'Romansh', 'cat'),
	(358, 'Romany', 'cat'),
	(359, 'Romanian', 'cat'),
	(360, 'Rundi', 'cat'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'cat'),
	(362, 'Russian', 'cat'),
	(363, 'Sandawe', 'cat'),
	(364, 'Sango', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(365, 'Yakut', 'cat'),
	(366, 'South American Indian (Other)', 'cat'),
	(367, 'Salishan languages', 'cat'),
	(368, 'Samaritan Aramaic', 'cat'),
	(369, 'Sanskrit', 'cat'),
	(370, 'Sasak', 'cat'),
	(371, 'Santali', 'cat'),
	(372, 'Serbian', 'cat'),
	(373, 'Sicilian', 'cat'),
	(374, 'Scots', 'cat'),
	(375, 'Croatian', 'cat'),
	(376, 'Selkup', 'cat'),
	(377, 'Semitic (Other)', 'cat'),
	(378, 'Irish, Old (to 900)', 'cat'),
	(379, 'Sign Languages', 'cat'),
	(380, 'Shan', 'cat'),
	(381, 'Sidamo', 'cat'),
	(382, 'Sinhala; Sinhalese', 'cat'),
	(383, 'Siouan languages', 'cat'),
	(384, 'Sino-Tibetan (Other)', 'cat'),
	(385, 'Slavic (Other)', 'cat'),
	(386, 'Slovak', 'cat'),
	(387, 'Slovenian', 'cat'),
	(388, 'Southern Sami', 'cat'),
	(389, 'Northern Sami', 'cat'),
	(390, 'Sami languages (Other)', 'cat'),
	(391, 'Lule Sami', 'cat'),
	(392, 'Inari Sami', 'cat'),
	(393, 'Samoan', 'cat'),
	(394, 'Skolt Sami', 'cat'),
	(395, 'Shona', 'cat'),
	(396, 'Sindhi', 'cat'),
	(397, 'Soninke', 'cat'),
	(398, 'Sogdian', 'cat'),
	(399, 'Somali', 'cat'),
	(400, 'Songhai languages', 'cat'),
	(401, 'Sotho, Southern', 'cat'),
	(402, 'Spanish; Castilian', 'cat'),
	(403, 'Sardinian; Zazaki', 'cat'),
	(404, 'Sranan Tongo', 'cat'),
	(405, 'Serer', 'cat'),
	(406, 'Nilo-Saharan (Other)', 'cat'),
	(407, 'Swati', 'cat'),
	(408, 'Sukuma', 'cat'),
	(409, 'Sundanese', 'cat'),
	(410, 'Susu', 'cat'),
	(411, 'Sumerian', 'cat'),
	(412, 'Swahili', 'cat'),
	(413, 'Swedish', 'cat'),
	(414, 'Syriac', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(415, 'Tahitian', 'cat'),
	(416, 'Tai (Other)', 'cat'),
	(417, 'Tamil', 'cat'),
	(418, 'Tatar', 'cat'),
	(419, 'Telugu', 'cat'),
	(420, 'Timnendere)', 'cat'),
	(421, 'Tereno', 'cat'),
	(422, 'Tetum', 'cat'),
	(423, 'Tajik', 'cat'),
	(424, 'Tagalog', 'cat'),
	(425, 'Thai', 'cat'),
	(426, 'Tibetan', 'cat'),
	(427, 'Tigre', 'cat'),
	(428, 'Tigrinya', 'cat'),
	(429, 'Tiv', 'cat'),
	(430, 'Tokelau', 'cat'),
	(431, 'Klingon; tlhIngan-Hol', 'cat'),
	(432, 'Tlingit', 'cat'),
	(433, 'Tamashek', 'cat'),
	(434, 'Tonga (Nyasa)', 'cat'),
	(435, 'Tonga (Tonga Islands)', 'cat'),
	(436, 'Tok Pisin', 'cat'),
	(437, 'Tsimshian', 'cat'),
	(438, 'Tswana', 'cat'),
	(439, 'Tsonga', 'cat'),
	(440, 'Turkmen', 'cat'),
	(441, 'Tumbuka', 'cat'),
	(442, 'Tupi languages', 'cat'),
	(443, 'Turkish', 'cat'),
	(444, 'Altaic (Other)', 'cat'),
	(445, 'Tuvalu', 'cat'),
	(446, 'Twi', 'cat'),
	(447, 'Tuvinian', 'cat'),
	(448, 'Udmurt', 'cat'),
	(449, 'Ugaritic', 'cat'),
	(450, 'Uighur; Uyghur', 'cat'),
	(451, 'Ukrainian', 'cat'),
	(452, 'Umbundu', 'cat'),
	(453, 'Undetermined', 'cat'),
	(454, 'Urdu', 'cat'),
	(455, 'Uzbek', 'cat'),
	(456, 'Vai', 'cat'),
	(457, 'Venda', 'cat'),
	(458, 'Vietnamese', 'cat'),
	(459, 'Volapük', 'cat'),
	(460, 'Votic', 'cat'),
	(461, 'Wakashan languages', 'cat'),
	(462, 'Walamo', 'cat'),
	(463, 'Waray', 'cat'),
	(464, 'Washo', 'cat');
INSERT INTO public.isolanguagesdes VALUES
	(465, 'Welsh', 'cat'),
	(466, 'Sorbian languages', 'cat'),
	(467, 'Walloon', 'cat'),
	(468, 'Wolof', 'cat'),
	(469, 'Kalmyk; Oirat', 'cat'),
	(470, 'Xhosa', 'cat'),
	(471, 'Yao', 'cat'),
	(472, 'Yapese', 'cat'),
	(473, 'Yiddish', 'cat'),
	(474, 'Yoruba', 'cat'),
	(475, 'Yupik languages', 'cat'),
	(476, 'Zapotec', 'cat'),
	(477, 'Zenaga', 'cat'),
	(478, 'Zhuang; Chuang', 'cat'),
	(479, 'Zande languages', 'cat'),
	(480, 'Zulu', 'cat'),
	(481, 'Zuni', 'cat'),
	(482, 'No linguistic content', 'cat'),
	(483, 'N''Ko', 'cat'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'cat'),
	(1, 'Afar', 'rus'),
	(2, 'Abkhazian', 'rus'),
	(3, 'Achinese', 'rus'),
	(4, 'Acoli', 'rus'),
	(5, 'Adangme', 'rus'),
	(6, 'Adyghe; Adygei', 'rus'),
	(7, 'Afro-Asiatic (Other)', 'rus'),
	(8, 'Afrihili', 'rus'),
	(9, 'Afrikaans', 'rus'),
	(10, 'Ainu', 'rus'),
	(11, 'Akan', 'rus'),
	(12, 'Akkadian', 'rus'),
	(13, 'Albanian', 'rus'),
	(14, 'Aleut', 'rus'),
	(15, 'Algonquian languages', 'rus'),
	(16, 'Southern Altai', 'rus'),
	(17, 'Amharic', 'rus'),
	(18, 'English, Old (ca.450-1100)', 'rus'),
	(19, 'Angika', 'rus'),
	(20, 'Apache languages', 'rus'),
	(21, 'Arabic', 'rus'),
	(22, 'Aramaic', 'rus'),
	(23, 'Aragonese', 'rus'),
	(24, 'Armenian', 'rus'),
	(25, 'Mapudungun; Mapuche', 'rus'),
	(26, 'Arapaho', 'rus'),
	(27, 'Artificial (Other)', 'rus'),
	(28, 'Arawak', 'rus'),
	(29, 'Assamese', 'rus'),
	(30, 'Asturian; Bable', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(31, 'Athapascan languages', 'rus'),
	(32, 'Australian languages', 'rus'),
	(33, 'Avaric', 'rus'),
	(34, 'Avestan', 'rus'),
	(35, 'Awadhi', 'rus'),
	(36, 'Aymara', 'rus'),
	(37, 'Azerbaijani', 'rus'),
	(38, 'Banda languages', 'rus'),
	(39, 'Bamileke languages', 'rus'),
	(40, 'Bashkir', 'rus'),
	(41, 'Baluchi', 'rus'),
	(42, 'Bambara', 'rus'),
	(43, 'Balinese', 'rus'),
	(44, 'Basque', 'rus'),
	(45, 'Basa', 'rus'),
	(46, 'Baltic (Other)', 'rus'),
	(47, 'Beja', 'rus'),
	(48, 'Belarusian', 'rus'),
	(49, 'Bemba', 'rus'),
	(50, 'Bengali', 'rus'),
	(51, 'Berber (Other)', 'rus'),
	(52, 'Bhojpuri', 'rus'),
	(53, 'Bihari', 'rus'),
	(54, 'Bikol', 'rus'),
	(55, 'Bini; Edo', 'rus'),
	(56, 'Bislama', 'rus'),
	(57, 'Siksika', 'rus'),
	(58, 'Bantu (Other)', 'rus'),
	(59, 'Bosnian', 'rus'),
	(60, 'Braj', 'rus'),
	(61, 'Breton', 'rus'),
	(62, 'Batak languages', 'rus'),
	(63, 'Buriat', 'rus'),
	(64, 'Buginese', 'rus'),
	(65, 'Bulgarian', 'rus'),
	(66, 'Burmese', 'rus'),
	(67, 'Blin; Bilin', 'rus'),
	(68, 'Caddo', 'rus'),
	(69, 'Central American Indian (Other)', 'rus'),
	(70, 'Galibi Carib', 'rus'),
	(71, 'Catalan; Valencianavonic; Old Bulgarian; Old Church Slavonic', 'rus'),
	(72, 'Caucasian (Other)', 'rus'),
	(73, 'Cebuano', 'rus'),
	(74, 'Celtic (Other)', 'rus'),
	(75, 'Chamorro', 'rus'),
	(76, 'Chibcha', 'rus'),
	(77, 'Chechenher)', 'rus'),
	(78, 'Chagataier)', 'rus'),
	(79, 'Chinesees', 'rus'),
	(80, 'Chuukese', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(81, 'Mari', 'rus'),
	(82, 'Chinook jargon', 'rus'),
	(83, 'Choctaw', 'rus'),
	(84, 'Chipewyan', 'rus'),
	(85, 'Cherokee', 'rus'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'rus'),
	(87, 'Chuvash', 'rus'),
	(88, 'Cheyenne', 'rus'),
	(89, 'Chamic languages', 'rus'),
	(90, 'Coptic', 'rus'),
	(91, 'Cornish', 'rus'),
	(92, 'Corsican', 'rus'),
	(93, 'Creoles and pidgins, English based (Ot', 'rus'),
	(94, 'Creoles and pidgins, French-based (Oth', 'rus'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'rus'),
	(96, 'Cree', 'rus'),
	(97, 'Crimean Tatar; Crimean Turkish', 'rus'),
	(98, 'Creoles and pidgins (Other)', 'rus'),
	(99, 'Kashubian', 'rus'),
	(100, 'Cushitic (Other)', 'rus'),
	(101, 'Czech', 'rus'),
	(102, 'Dakota', 'rus'),
	(103, 'Danish', 'rus'),
	(104, 'Dargwa', 'rus'),
	(105, 'Land Dayak languages', 'rus'),
	(106, 'Delaware', 'rus'),
	(107, 'Slave (Athapascan)', 'rus'),
	(108, 'Dogrib', 'rus'),
	(109, 'Dinka', 'rus'),
	(110, 'Divehi; Dhivehi; Maldivian', 'rus'),
	(111, 'Dogri', 'rus'),
	(112, 'Dravidian (Other)', 'rus'),
	(113, 'Lower Sorbian', 'rus'),
	(114, 'Duala', 'rus'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'rus'),
	(116, 'Dutch; Flemish', 'rus'),
	(117, 'Dyula', 'rus'),
	(118, 'Dzongkha', 'rus'),
	(119, 'Efik', 'rus'),
	(120, 'Egyptian (Ancient)', 'rus'),
	(121, 'Ekajuk', 'rus'),
	(122, 'Elamite', 'rus'),
	(123, 'English', 'rus'),
	(124, 'English, Middle (1100-1500)', 'rus'),
	(125, 'Esperanto', 'rus'),
	(126, 'Estonian', 'rus'),
	(127, 'Ewe', 'rus'),
	(128, 'Ewondo', 'rus'),
	(129, 'Fang', 'rus'),
	(130, 'Faroese', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(131, 'Fanti', 'rus'),
	(132, 'Fijian', 'rus'),
	(133, 'Filipino; Pilipino', 'rus'),
	(134, 'Finnish', 'rus'),
	(135, 'Finno-Ugrian (Other)', 'rus'),
	(136, 'Fon', 'rus'),
	(137, 'French', 'rus'),
	(138, 'French, Middle (ca.1400-1600)', 'rus'),
	(139, 'French, Old (842-ca.1400)', 'rus'),
	(140, 'Northern Frisian', 'rus'),
	(141, 'Eastern Frisian', 'rus'),
	(142, 'Western Frisian', 'rus'),
	(143, 'Fulah', 'rus'),
	(144, 'Friulian', 'rus'),
	(145, 'Ga', 'rus'),
	(146, 'Gayo', 'rus'),
	(147, 'Gbaya', 'rus'),
	(148, 'Germanic (Other)', 'rus'),
	(149, 'Georgian', 'rus'),
	(150, 'German', 'rus'),
	(151, 'Geez', 'rus'),
	(152, 'Gilbertese', 'rus'),
	(153, 'Gaelic; Scottish Gaelic', 'rus'),
	(154, 'Irish', 'rus'),
	(155, 'Galician', 'rus'),
	(156, 'Manx', 'rus'),
	(157, 'German, Middle High (ca.1050-1500)', 'rus'),
	(158, 'German, Old High (ca.750-1050)', 'rus'),
	(159, 'Gondi', 'rus'),
	(160, 'Gorontaloanguage Association)', 'rus'),
	(161, 'Gothic', 'rus'),
	(162, 'Grebo', 'rus'),
	(163, 'Greek, Ancient (to 1453)', 'rus'),
	(164, 'Greek, Modern (1453-)', 'rus'),
	(165, 'Guarani', 'rus'),
	(166, 'Swiss German; Alemannic', 'rus'),
	(167, 'Gujarati', 'rus'),
	(168, 'Gwich''in', 'rus'),
	(169, 'Haida', 'rus'),
	(170, 'Haitian; Haitian Creole', 'rus'),
	(171, 'Hausa', 'rus'),
	(172, 'Hawaiian', 'rus'),
	(173, 'Hebrew', 'rus'),
	(174, 'Herero', 'rus'),
	(175, 'Hiligaynon', 'rus'),
	(176, 'Himachali', 'rus'),
	(177, 'Hindi', 'rus'),
	(178, 'Hittite', 'rus'),
	(179, 'Hmong', 'rus'),
	(180, 'Hiri Motu', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(181, 'Upper Sorbian', 'rus'),
	(182, 'Hungarian', 'rus'),
	(183, 'Hupa', 'rus'),
	(184, 'Iban', 'rus'),
	(185, 'Igbo', 'rus'),
	(186, 'Icelandic', 'rus'),
	(187, 'Ido', 'rus'),
	(188, 'Sichuan Yi', 'rus'),
	(189, 'Ijo languages', 'rus'),
	(190, 'Inuktitut', 'rus'),
	(191, 'Interlingue', 'rus'),
	(192, 'Iloko', 'rus'),
	(193, 'Interlingua (International Auxiliary L', 'rus'),
	(194, 'Indic (Other)', 'rus'),
	(195, 'Indonesian', 'rus'),
	(196, 'Indo-European (Other)', 'rus'),
	(197, 'Ingush', 'rus'),
	(198, 'Inupiaq', 'rus'),
	(199, 'Iranian (Other)', 'rus'),
	(200, 'Iroquoian languages', 'rus'),
	(201, 'Italian', 'rus'),
	(202, 'Javanese', 'rus'),
	(203, 'Lojban', 'rus'),
	(204, 'Japanese', 'rus'),
	(205, 'Judeo-Persian', 'rus'),
	(206, 'Judeo-Arabic', 'rus'),
	(207, 'Kara-Kalpak', 'rus'),
	(208, 'Kabyle', 'rus'),
	(209, 'Kachin; Jingpho', 'rus'),
	(210, 'Kalaallisut; Greenlandic', 'rus'),
	(211, 'Kamba', 'rus'),
	(212, 'Kannada', 'rus'),
	(213, 'Karen languages', 'rus'),
	(214, 'Kashmiri', 'rus'),
	(215, 'Kanuri', 'rus'),
	(216, 'Kawi', 'rus'),
	(217, 'Kazakh', 'rus'),
	(218, 'Kabardian', 'rus'),
	(219, 'Khasi', 'rus'),
	(220, 'Khoisan (Other)', 'rus'),
	(221, 'Central Khmer', 'rus'),
	(222, 'Khotanese', 'rus'),
	(223, 'Kikuyu; Gikuyu', 'rus'),
	(224, 'Kinyarwanda', 'rus'),
	(225, 'Kirghiz; Kyrgyz', 'rus'),
	(226, 'Kimbundu', 'rus'),
	(227, 'Konkani', 'rus'),
	(228, 'Komi', 'rus'),
	(229, 'Kongo', 'rus'),
	(230, 'Korean', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(231, 'Kosraean', 'rus'),
	(232, 'Kpelle', 'rus'),
	(233, 'Karachay-Balkar', 'rus'),
	(234, 'Karelian', 'rus'),
	(235, 'Kru languages', 'rus'),
	(236, 'Kurukh', 'rus'),
	(237, 'Kuanyama; Kwanyama', 'rus'),
	(238, 'Kumyk', 'rus'),
	(239, 'Kurdish', 'rus'),
	(240, 'Kutenai', 'rus'),
	(241, 'Ladino', 'rus'),
	(242, 'Lahnda', 'rus'),
	(243, 'Lamba', 'rus'),
	(244, 'Lao', 'rus'),
	(245, 'Latin', 'rus'),
	(246, 'Latvian', 'rus'),
	(247, 'Lezghian', 'rus'),
	(248, 'Limburgan; Limburger; Limburgish', 'rus'),
	(249, 'Lingalaes langues', 'rus'),
	(250, 'Lithuanian', 'rus'),
	(251, 'Mongo', 'rus'),
	(252, 'Lozi', 'rus'),
	(253, 'Luxembourgish; Letzeburgesch', 'rus'),
	(254, 'Luba-Lulua', 'rus'),
	(255, 'Luba-Katanga', 'rus'),
	(256, 'Ganda', 'rus'),
	(257, 'Luiseno', 'rus'),
	(258, 'Lunda', 'rus'),
	(259, 'Luo (Kenya and Tanzania)', 'rus'),
	(260, 'Lushai00E5l', 'rus'),
	(261, 'Macedonian', 'rus'),
	(262, 'Madurese', 'rus'),
	(263, 'Magahi', 'rus'),
	(264, 'Marshallese', 'rus'),
	(265, 'Maithilil Nepal Bhasa', 'rus'),
	(266, 'Makasar', 'rus'),
	(267, 'Malayalam', 'rus'),
	(268, 'Mandingo', 'rus'),
	(269, 'Maori', 'rus'),
	(270, 'Austronesian (Other)', 'rus'),
	(271, 'Marathi', 'rus'),
	(272, 'Masai', 'rus'),
	(273, 'Malay', 'rus'),
	(274, 'Moksha', 'rus'),
	(275, 'Mandar', 'rus'),
	(276, 'Mende', 'rus'),
	(277, 'Irish, Middle (900-1200)', 'rus'),
	(278, 'Mi''kmaq; Micmac', 'rus'),
	(279, 'Minangkabau', 'rus'),
	(280, 'Miscellaneous languages', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(281, 'Mon-Khmer (Other)', 'rus'),
	(282, 'Malagasy', 'rus'),
	(283, 'Maltese', 'rus'),
	(284, 'Manchu', 'rus'),
	(285, 'Manipuri', 'rus'),
	(286, 'Manobo languages', 'rus'),
	(287, 'Mohawk', 'rus'),
	(288, 'Moldavian', 'rus'),
	(289, 'Mongolian', 'rus'),
	(290, 'Mossi', 'rus'),
	(291, 'Multiple languages', 'rus'),
	(292, 'Munda languages', 'rus'),
	(293, 'Creek', 'rus'),
	(294, 'Mirandese', 'rus'),
	(295, 'Marwari', 'rus'),
	(296, 'Mayan languages', 'rus'),
	(297, 'Erzya', 'rus'),
	(298, 'Nahuatl languages', 'rus'),
	(299, 'North American Indian', 'rus'),
	(300, 'Neapolitan', 'rus'),
	(301, 'Nauru', 'rus'),
	(302, 'Navajo; Navaho', 'rus'),
	(303, 'Ndebele, South; South Ndebele', 'rus'),
	(304, 'Ndebele, North; North Ndebele', 'rus'),
	(305, 'Ndonga', 'rus'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'rus'),
	(307, 'Nepali', 'rus'),
	(308, 'Nepal Bhasa; Newari', 'rus'),
	(309, 'Nias', 'rus'),
	(310, 'Niger-Kordofanian (Other)', 'rus'),
	(311, 'Niuean', 'rus'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'rus'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'rus'),
	(314, 'Nogai', 'rus'),
	(315, 'Norse, Old', 'rus'),
	(316, 'Norwegian', 'rus'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'rus'),
	(318, 'Nubian languages', 'rus'),
	(319, 'Classical Newari; Old Newari; Classica', 'rus'),
	(320, 'Chichewa; Chewa; Nyanja', 'rus'),
	(321, 'Nyamwezi', 'rus'),
	(322, 'Nyankole', 'rus'),
	(323, 'Nyoro', 'rus'),
	(324, 'Nzima', 'rus'),
	(325, 'Occitan (post 1500); Provençal', 'rus'),
	(326, 'Ojibwa', 'rus'),
	(327, 'Oriya', 'rus'),
	(328, 'Oromo', 'rus'),
	(329, 'Osage', 'rus'),
	(330, 'Ossetian; Ossetic', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(331, 'Turkish, Ottoman (1500-1928)', 'rus'),
	(332, 'Otomian languages', 'rus'),
	(333, 'Papuan (Other)', 'rus'),
	(334, 'Pangasinan', 'rus'),
	(335, 'Pahlavi', 'rus'),
	(336, 'Pampanga', 'rus'),
	(337, 'Panjabi; Punjabi', 'rus'),
	(338, 'Papiamento', 'rus'),
	(339, 'Palauan', 'rus'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'rus'),
	(341, 'Persian', 'rus'),
	(342, 'Philippine (Other)', 'rus'),
	(343, 'Phoenician', 'rus'),
	(344, 'Pali', 'rus'),
	(345, 'Polish', 'rus'),
	(346, 'Pohnpeian', 'rus'),
	(347, 'Portuguese', 'rus'),
	(348, 'Prakrit languages', 'rus'),
	(349, 'Provençal, Old (to 1500)', 'rus'),
	(350, 'Pushto', 'rus'),
	(351, 'Reserved for local use', 'rus'),
	(352, 'Quechua', 'rus'),
	(353, 'Rajasthani', 'rus'),
	(354, 'Rapanui', 'rus'),
	(355, 'Rarotongan; Cook Islands Maori', 'rus'),
	(356, 'Romance (Other)', 'rus'),
	(357, 'Romansh', 'rus'),
	(358, 'Romany', 'rus'),
	(359, 'Romanian', 'rus'),
	(360, 'Rundi', 'rus'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'rus'),
	(362, 'Russian', 'rus'),
	(363, 'Sandawe', 'rus'),
	(364, 'Sango', 'rus'),
	(365, 'Yakut', 'rus'),
	(366, 'South American Indian (Other)', 'rus'),
	(367, 'Salishan languages', 'rus'),
	(368, 'Samaritan Aramaic', 'rus'),
	(369, 'Sanskrit', 'rus'),
	(370, 'Sasak', 'rus'),
	(371, 'Santali', 'rus'),
	(372, 'Serbian', 'rus'),
	(373, 'Sicilian', 'rus'),
	(374, 'Scots', 'rus'),
	(375, 'Croatian', 'rus'),
	(376, 'Selkup', 'rus'),
	(377, 'Semitic (Other)', 'rus'),
	(378, 'Irish, Old (to 900)', 'rus'),
	(379, 'Sign Languages', 'rus'),
	(380, 'Shan', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(381, 'Sidamo', 'rus'),
	(382, 'Sinhala; Sinhalese', 'rus'),
	(383, 'Siouan languages', 'rus'),
	(384, 'Sino-Tibetan (Other)', 'rus'),
	(385, 'Slavic (Other)', 'rus'),
	(386, 'Slovak', 'rus'),
	(387, 'Slovenian', 'rus'),
	(388, 'Southern Sami', 'rus'),
	(389, 'Northern Sami', 'rus'),
	(390, 'Sami languages (Other)', 'rus'),
	(391, 'Lule Sami', 'rus'),
	(392, 'Inari Sami', 'rus'),
	(393, 'Samoan', 'rus'),
	(394, 'Skolt Sami', 'rus'),
	(395, 'Shona', 'rus'),
	(396, 'Sindhi', 'rus'),
	(397, 'Soninke', 'rus'),
	(398, 'Sogdian', 'rus'),
	(399, 'Somali', 'rus'),
	(400, 'Songhai languages', 'rus'),
	(401, 'Sotho, Southern', 'rus'),
	(402, 'Spanish; Castilian', 'rus'),
	(403, 'Sardinian; Zazaki', 'rus'),
	(404, 'Sranan Tongo', 'rus'),
	(405, 'Serer', 'rus'),
	(406, 'Nilo-Saharan (Other)', 'rus'),
	(407, 'Swati', 'rus'),
	(408, 'Sukuma', 'rus'),
	(409, 'Sundanese', 'rus'),
	(410, 'Susu', 'rus'),
	(411, 'Sumerian', 'rus'),
	(412, 'Swahili', 'rus'),
	(413, 'Swedish', 'rus'),
	(414, 'Syriac', 'rus'),
	(415, 'Tahitian', 'rus'),
	(416, 'Tai (Other)', 'rus'),
	(417, 'Tamil', 'rus'),
	(418, 'Tatar', 'rus'),
	(419, 'Telugu', 'rus'),
	(420, 'Timne', 'rus'),
	(421, 'Tereno', 'rus'),
	(422, 'Tetum', 'rus'),
	(423, 'Tajik', 'rus'),
	(424, 'Tagalog', 'rus'),
	(425, 'Thai', 'rus'),
	(426, 'Tibetan', 'rus'),
	(427, 'Tigre', 'rus'),
	(428, 'Tigrinya', 'rus'),
	(429, 'Tiv', 'rus'),
	(430, 'Tokelau', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(431, 'Klingon; tlhIngan-Hol', 'rus'),
	(432, 'Tlingit', 'rus'),
	(433, 'Tamashek', 'rus'),
	(434, 'Tonga (Nyasa)', 'rus'),
	(435, 'Tonga (Tonga Islands)', 'rus'),
	(436, 'Tok Pisin', 'rus'),
	(437, 'Tsimshian', 'rus'),
	(438, 'Tswana', 'rus'),
	(439, 'Tsonga', 'rus'),
	(440, 'Turkmen', 'rus'),
	(441, 'Tumbuka', 'rus'),
	(442, 'Tupi languages', 'rus'),
	(443, 'Turkish', 'rus'),
	(444, 'Altaic (Other)', 'rus'),
	(445, 'Tuvalu', 'rus'),
	(446, 'Twi', 'rus'),
	(447, 'Tuvinian', 'rus'),
	(448, 'Udmurt', 'rus'),
	(449, 'Ugaritic', 'rus'),
	(450, 'Uighur; Uyghur', 'rus'),
	(451, 'Ukrainian', 'rus'),
	(452, 'Umbundu', 'rus'),
	(453, 'Undetermined', 'rus'),
	(454, 'Urdu', 'rus'),
	(455, 'Uzbek', 'rus'),
	(456, 'Vai', 'rus'),
	(457, 'Venda', 'rus'),
	(458, 'Vietnamese', 'rus'),
	(459, 'Volapük', 'rus'),
	(460, 'Votic', 'rus'),
	(461, 'Wakashan languages', 'rus'),
	(462, 'Walamo', 'rus'),
	(463, 'Waray', 'rus'),
	(464, 'Washo', 'rus'),
	(465, 'Welsh', 'rus'),
	(466, 'Sorbian languages', 'rus'),
	(467, 'Walloon', 'rus'),
	(468, 'Wolof', 'rus'),
	(469, 'Kalmyk; Oirat', 'rus'),
	(470, 'Xhosa', 'rus'),
	(471, 'Yao', 'rus'),
	(472, 'Yapese', 'rus'),
	(473, 'Yiddish', 'rus'),
	(474, 'Yoruba', 'rus'),
	(475, 'Yupik languages', 'rus'),
	(476, 'Zapotec', 'rus'),
	(477, 'Zenaga', 'rus'),
	(478, 'Zhuang; Chuang', 'rus'),
	(479, 'Zande languages', 'rus'),
	(480, 'Zulu', 'rus');
INSERT INTO public.isolanguagesdes VALUES
	(481, 'Zuni', 'rus'),
	(482, 'No linguistic content', 'rus'),
	(483, 'N''Ko', 'rus'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'rus'),
	(1, 'Afar', 'por'),
	(2, 'Abkhazian', 'por'),
	(3, 'Achinese', 'por'),
	(4, 'Acoli', 'por'),
	(5, 'Adangme', 'por'),
	(6, 'Adyghe; Adygei', 'por'),
	(7, 'Afro-Asiatic (Other)', 'por'),
	(8, 'Afrihili', 'por'),
	(9, 'Afrikaans', 'por'),
	(10, 'Ainu', 'por'),
	(11, 'Akan', 'por'),
	(12, 'Akkadian', 'por'),
	(13, 'Albanian', 'por'),
	(14, 'Aleut', 'por'),
	(15, 'Algonquian languages', 'por'),
	(16, 'Southern Altai', 'por'),
	(17, 'Amharic', 'por'),
	(18, 'English, Old (ca.450-1100)', 'por'),
	(19, 'Angika', 'por'),
	(20, 'Apache languages', 'por'),
	(21, 'Arabic', 'por'),
	(22, 'Aramaic', 'por'),
	(23, 'Aragonese', 'por'),
	(24, 'Armenian', 'por'),
	(25, 'Mapudungun; Mapuche', 'por'),
	(26, 'Arapaho', 'por'),
	(27, 'Artificial (Other)', 'por'),
	(28, 'Arawak', 'por'),
	(29, 'Assamese', 'por'),
	(30, 'Asturian; Bable', 'por'),
	(31, 'Athapascan languages', 'por'),
	(32, 'Australian languages', 'por'),
	(33, 'Avaric', 'por'),
	(34, 'Avestan', 'por'),
	(35, 'Awadhi', 'por'),
	(36, 'Aymara', 'por'),
	(37, 'Azerbaijani', 'por'),
	(38, 'Banda languages', 'por'),
	(39, 'Bamileke languages', 'por'),
	(40, 'Bashkir', 'por'),
	(41, 'Baluchi', 'por'),
	(42, 'Bambara', 'por'),
	(43, 'Balinese', 'por'),
	(44, 'Basque', 'por'),
	(45, 'Basa', 'por'),
	(46, 'Baltic (Other)', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(47, 'Beja', 'por'),
	(48, 'Belarusian', 'por'),
	(49, 'Bemba', 'por'),
	(50, 'Bengali', 'por'),
	(51, 'Berber (Other)', 'por'),
	(52, 'Bhojpuri', 'por'),
	(53, 'Bihari', 'por'),
	(54, 'Bikol', 'por'),
	(55, 'Bini; Edo', 'por'),
	(56, 'Bislama', 'por'),
	(57, 'Siksika', 'por'),
	(58, 'Bantu (Other)', 'por'),
	(59, 'Bosnian', 'por'),
	(60, 'Braj', 'por'),
	(61, 'Breton', 'por'),
	(62, 'Batak languages', 'por'),
	(63, 'Buriat', 'por'),
	(64, 'Buginese', 'por'),
	(65, 'Bulgarian', 'por'),
	(66, 'Burmese', 'por'),
	(67, 'Blin; Bilin', 'por'),
	(68, 'Caddo', 'por'),
	(69, 'Central American Indian (Other)', 'por'),
	(70, 'Galibi Carib', 'por'),
	(71, 'Catalan; Valencian', 'por'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'por'),
	(73, 'Cebuano', 'por'),
	(74, 'Celtic (Other)', 'por'),
	(75, 'Chamorro', 'por'),
	(76, 'Chibcha', 'por'),
	(77, 'Chechen', 'por'),
	(78, 'Chagataier)', 'por'),
	(79, 'Chinese(Other)', 'por'),
	(80, 'Chuukese', 'por'),
	(81, 'Mari', 'por'),
	(82, 'Chinook jargon', 'por'),
	(83, 'Choctaw', 'por'),
	(84, 'Chipewyan', 'por'),
	(85, 'Cherokee', 'por'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'por'),
	(87, 'Chuvash', 'por'),
	(88, 'Cheyenne', 'por'),
	(89, 'Chamic languages', 'por'),
	(90, 'Coptic', 'por'),
	(91, 'Cornish', 'por'),
	(92, 'Corsican', 'por'),
	(93, 'Creoles and pidgins, English based (Ot', 'por'),
	(94, 'Creoles and pidgins, French-based (Oth', 'por'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'por'),
	(96, 'Cree', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(97, 'Crimean Tatar; Crimean Turkish', 'por'),
	(98, 'Creoles and pidgins (Other)', 'por'),
	(99, 'Kashubian', 'por'),
	(100, 'Cushitic (Other)', 'por'),
	(101, 'Czech', 'por'),
	(102, 'Dakota', 'por'),
	(103, 'Danish', 'por'),
	(104, 'Dargwa', 'por'),
	(105, 'Land Dayak languages', 'por'),
	(106, 'Delaware', 'por'),
	(107, 'Slave (Athapascan)', 'por'),
	(108, 'Dogrib', 'por'),
	(109, 'Dinka', 'por'),
	(110, 'Divehi; Dhivehi; Maldivian', 'por'),
	(111, 'Dogri', 'por'),
	(112, 'Dravidian (Other)', 'por'),
	(113, 'Lower Sorbian', 'por'),
	(114, 'Duala', 'por'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'por'),
	(116, 'Dutch; Flemish', 'por'),
	(117, 'Dyula', 'por'),
	(118, 'Dzongkha', 'por'),
	(119, 'Efik', 'por'),
	(120, 'Egyptian (Ancient)', 'por'),
	(121, 'Ekajuk', 'por'),
	(122, 'Elamite', 'por'),
	(123, 'English', 'por'),
	(124, 'English, Middle (1100-1500)', 'por'),
	(125, 'Esperanto', 'por'),
	(126, 'Estonian', 'por'),
	(127, 'Ewe', 'por'),
	(128, 'Ewondo', 'por'),
	(129, 'Fang', 'por'),
	(130, 'Faroese', 'por'),
	(131, 'Fanti', 'por'),
	(132, 'Fijian', 'por'),
	(133, 'Filipino; Pilipino', 'por'),
	(134, 'Finnish', 'por'),
	(135, 'Finno-Ugrian (Other)', 'por'),
	(136, 'Fon', 'por'),
	(137, 'French', 'por'),
	(138, 'French, Middle (ca.1400-1600)', 'por'),
	(139, 'French, Old (842-ca.1400)', 'por'),
	(140, 'Northern Frisian', 'por'),
	(141, 'Eastern Frisian', 'por'),
	(142, 'Western Frisian', 'por'),
	(143, 'Fulah', 'por'),
	(144, 'Friulian', 'por'),
	(145, 'Ga', 'por'),
	(146, 'Gayo', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(147, 'Gbaya', 'por'),
	(148, 'Germanic (Other)', 'por'),
	(149, 'Georgian', 'por'),
	(150, 'German', 'por'),
	(151, 'Geez', 'por'),
	(152, 'Gilbertese', 'por'),
	(153, 'Gaelic; Scottish Gaelic', 'por'),
	(154, 'Irish', 'por'),
	(155, 'Galician', 'por'),
	(156, 'Manx', 'por'),
	(157, 'German, Middle High (ca.1050-1500)', 'por'),
	(158, 'German, Old High (ca.750-1050)', 'por'),
	(159, 'Gondi', 'por'),
	(160, 'Gorontalo', 'por'),
	(161, 'Gothicanguage Association)', 'por'),
	(162, 'Grebo', 'por'),
	(163, 'Greek, Ancient (to 1453)', 'por'),
	(164, 'Greek, Modern (1453-)', 'por'),
	(165, 'Guarani', 'por'),
	(166, 'Swiss German; Alemannic', 'por'),
	(167, 'Gujarati', 'por'),
	(168, 'Gwich''in', 'por'),
	(169, 'Haida', 'por'),
	(170, 'Haitian; Haitian Creole', 'por'),
	(171, 'Hausa', 'por'),
	(172, 'Hawaiian', 'por'),
	(173, 'Hebrew', 'por'),
	(174, 'Herero', 'por'),
	(175, 'Hiligaynon', 'por'),
	(176, 'Himachali', 'por'),
	(177, 'Hindi', 'por'),
	(178, 'Hittite', 'por'),
	(179, 'Hmong', 'por'),
	(180, 'Hiri Motu', 'por'),
	(181, 'Upper Sorbian', 'por'),
	(182, 'Hungarian', 'por'),
	(183, 'Hupa', 'por'),
	(184, 'Iban', 'por'),
	(185, 'Igbo', 'por'),
	(186, 'Icelandic', 'por'),
	(187, 'Ido', 'por'),
	(188, 'Sichuan Yi', 'por'),
	(189, 'Ijo languages', 'por'),
	(190, 'Inuktitut', 'por'),
	(191, 'Interlingue', 'por'),
	(192, 'Iloko', 'por'),
	(193, 'Interlingua (International Auxiliary L', 'por'),
	(194, 'Indic (Other)', 'por'),
	(195, 'Indonesian', 'por'),
	(196, 'Indo-European (Other)', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(197, 'Ingush', 'por'),
	(198, 'Inupiaq', 'por'),
	(199, 'Iranian (Other)', 'por'),
	(200, 'Iroquoian languages', 'por'),
	(201, 'Italian', 'por'),
	(202, 'Javanese', 'por'),
	(203, 'Lojban', 'por'),
	(204, 'Japanese', 'por'),
	(205, 'Judeo-Persian', 'por'),
	(206, 'Judeo-Arabic', 'por'),
	(207, 'Kara-Kalpak', 'por'),
	(208, 'Kabyle', 'por'),
	(209, 'Kachin; Jingpho', 'por'),
	(210, 'Kalaallisut; Greenlandic', 'por'),
	(211, 'Kamba', 'por'),
	(212, 'Kannada', 'por'),
	(213, 'Karen languages', 'por'),
	(214, 'Kashmiri', 'por'),
	(215, 'Kanuri', 'por'),
	(216, 'Kawi', 'por'),
	(217, 'Kazakh', 'por'),
	(218, 'Kabardian', 'por'),
	(219, 'Khasi', 'por'),
	(220, 'Khoisan (Other)', 'por'),
	(221, 'Central Khmer', 'por'),
	(222, 'Khotanese', 'por'),
	(223, 'Kikuyu; Gikuyu', 'por'),
	(224, 'Kinyarwanda', 'por'),
	(225, 'Kirghiz; Kyrgyz', 'por'),
	(226, 'Kimbundu', 'por'),
	(227, 'Konkani', 'por'),
	(228, 'Komi', 'por'),
	(229, 'Kongo', 'por'),
	(230, 'Korean', 'por'),
	(231, 'Kosraean', 'por'),
	(232, 'Kpelle', 'por'),
	(233, 'Karachay-Balkar', 'por'),
	(234, 'Karelian', 'por'),
	(235, 'Kru languages', 'por'),
	(236, 'Kurukh', 'por'),
	(237, 'Kuanyama; Kwanyama', 'por'),
	(238, 'Kumyk', 'por'),
	(239, 'Kurdish', 'por'),
	(240, 'Kutenai', 'por'),
	(241, 'Ladino', 'por'),
	(242, 'Lahnda', 'por'),
	(243, 'Lamba', 'por'),
	(244, 'Lao', 'por'),
	(245, 'Latin', 'por'),
	(246, 'Latvian', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(247, 'Lezghian', 'por'),
	(248, 'Limburgan; Limburger; Limburgish', 'por'),
	(249, 'Lingala', 'por'),
	(250, 'Lithuanian', 'por'),
	(251, 'Mongo', 'por'),
	(252, 'Lozi', 'por'),
	(253, 'Luxembourgish; Letzeburgesch', 'por'),
	(254, 'Luba-Lulua', 'por'),
	(255, 'Luba-Katangaxon, Low', 'por'),
	(256, 'Ganda', 'por'),
	(257, 'Luiseno', 'por'),
	(258, 'Lunda', 'por'),
	(259, 'Luo (Kenya and Tanzania)', 'por'),
	(260, 'Lushai', 'por'),
	(261, 'Macedonian00E5l', 'por'),
	(262, 'Madurese', 'por'),
	(263, 'Magahi', 'por'),
	(264, 'Marshallese', 'por'),
	(265, 'Maithili', 'por'),
	(266, 'Makasarl Nepal Bhasa', 'por'),
	(267, 'Malayalam', 'por'),
	(268, 'Mandingo', 'por'),
	(269, 'Maori', 'por'),
	(270, 'Austronesian (Other)', 'por'),
	(271, 'Marathi', 'por'),
	(272, 'Masai', 'por'),
	(273, 'Malay', 'por'),
	(274, 'Moksha', 'por'),
	(275, 'Mandar', 'por'),
	(276, 'Mende', 'por'),
	(277, 'Irish, Middle (900-1200)', 'por'),
	(278, 'Mi''kmaq; Micmac', 'por'),
	(279, 'Minangkabau', 'por'),
	(280, 'Miscellaneous languages', 'por'),
	(281, 'Mon-Khmer (Other)', 'por'),
	(282, 'Malagasy', 'por'),
	(283, 'Maltese', 'por'),
	(284, 'Manchu', 'por'),
	(285, 'Manipuri', 'por'),
	(286, 'Manobo languages', 'por'),
	(287, 'Mohawk', 'por'),
	(288, 'Moldavian', 'por'),
	(289, 'Mongolian', 'por'),
	(290, 'Mossi', 'por'),
	(291, 'Multiple languages', 'por'),
	(292, 'Munda languages', 'por'),
	(293, 'Creek', 'por'),
	(294, 'Mirandese', 'por'),
	(295, 'Marwari', 'por'),
	(296, 'Mayan languages', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(297, 'Erzya', 'por'),
	(298, 'Nahuatl languages', 'por'),
	(299, 'North American Indian', 'por'),
	(300, 'Neapolitan', 'por'),
	(301, 'Nauru', 'por'),
	(302, 'Navajo; Navaho', 'por'),
	(303, 'Ndebele, South; South Ndebele', 'por'),
	(304, 'Ndebele, North; North Ndebele', 'por'),
	(305, 'Ndonga', 'por'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'por'),
	(307, 'Nepali', 'por'),
	(308, 'Nepal Bhasa; Newari', 'por'),
	(309, 'Nias', 'por'),
	(310, 'Niger-Kordofanian (Other)', 'por'),
	(311, 'Niuean', 'por'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'por'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'por'),
	(314, 'Nogai', 'por'),
	(315, 'Norse, Old', 'por'),
	(316, 'Norwegian', 'por'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'por'),
	(318, 'Nubian languages', 'por'),
	(319, 'Classical Newari; Old Newari; Classica', 'por'),
	(320, 'Chichewa; Chewa; Nyanja', 'por'),
	(321, 'Nyamwezi', 'por'),
	(322, 'Nyankole', 'por'),
	(323, 'Nyoro', 'por'),
	(324, 'Nzima', 'por'),
	(325, 'Occitan (post 1500); Provençal', 'por'),
	(326, 'Ojibwa', 'por'),
	(327, 'Oriya', 'por'),
	(328, 'Oromo', 'por'),
	(329, 'Osage', 'por'),
	(330, 'Ossetian; Ossetic', 'por'),
	(331, 'Turkish, Ottoman (1500-1928)', 'por'),
	(332, 'Otomian languages', 'por'),
	(333, 'Papuan (Other)', 'por'),
	(334, 'Pangasinan', 'por'),
	(335, 'Pahlavi', 'por'),
	(336, 'Pampanga', 'por'),
	(337, 'Panjabi; Punjabi', 'por'),
	(338, 'Papiamento', 'por'),
	(339, 'Palauan', 'por'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'por'),
	(341, 'Persian', 'por'),
	(342, 'Philippine (Other)', 'por'),
	(343, 'Phoenician', 'por'),
	(344, 'Pali', 'por'),
	(345, 'Polish', 'por'),
	(346, 'Pohnpeian', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(347, 'Portuguese', 'por'),
	(348, 'Prakrit languages', 'por'),
	(349, 'Provençal, Old (to 1500)', 'por'),
	(350, 'Pushto', 'por'),
	(351, 'Reserved for local use', 'por'),
	(352, 'Quechua', 'por'),
	(353, 'Rajasthani', 'por'),
	(354, 'Rapanui', 'por'),
	(355, 'Rarotongan; Cook Islands Maori', 'por'),
	(356, 'Romance (Other)', 'por'),
	(357, 'Romansh', 'por'),
	(358, 'Romany', 'por'),
	(359, 'Romanian', 'por'),
	(360, 'Rundi', 'por'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'por'),
	(362, 'Russian', 'por'),
	(363, 'Sandawe', 'por'),
	(364, 'Sango', 'por'),
	(365, 'Yakut', 'por'),
	(366, 'South American Indian (Other)', 'por'),
	(367, 'Salishan languages', 'por'),
	(368, 'Samaritan Aramaic', 'por'),
	(369, 'Sanskrit', 'por'),
	(370, 'Sasak', 'por'),
	(371, 'Santali', 'por'),
	(372, 'Serbian', 'por'),
	(373, 'Sicilian', 'por'),
	(374, 'Scots', 'por'),
	(375, 'Croatian', 'por'),
	(376, 'Selkup', 'por'),
	(377, 'Semitic (Other)', 'por'),
	(378, 'Irish, Old (to 900)', 'por'),
	(379, 'Sign Languages', 'por'),
	(380, 'Shan', 'por'),
	(381, 'Sidamo', 'por'),
	(382, 'Sinhala; Sinhalese', 'por'),
	(383, 'Siouan languages', 'por'),
	(384, 'Sino-Tibetan (Other)', 'por'),
	(385, 'Slavic (Other)', 'por'),
	(386, 'Slovak', 'por'),
	(387, 'Slovenian', 'por'),
	(388, 'Southern Sami', 'por'),
	(389, 'Northern Sami', 'por'),
	(390, 'Sami languages (Other)', 'por'),
	(391, 'Lule Sami', 'por'),
	(392, 'Inari Sami', 'por'),
	(393, 'Samoan', 'por'),
	(394, 'Skolt Sami', 'por'),
	(395, 'Shona', 'por'),
	(396, 'Sindhi', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(397, 'Soninke', 'por'),
	(398, 'Sogdian', 'por'),
	(399, 'Somali', 'por'),
	(400, 'Songhai languages', 'por'),
	(401, 'Sotho, Southern', 'por'),
	(402, 'Spanish; Castilian', 'por'),
	(403, 'Sardinian; Zazaki', 'por'),
	(404, 'Sranan Tongo', 'por'),
	(405, 'Serer', 'por'),
	(406, 'Nilo-Saharan (Other)', 'por'),
	(407, 'Swati', 'por'),
	(408, 'Sukuma', 'por'),
	(409, 'Sundanese', 'por'),
	(410, 'Susu', 'por'),
	(411, 'Sumerian', 'por'),
	(412, 'Swahili', 'por'),
	(413, 'Swedish', 'por'),
	(414, 'Syriac', 'por'),
	(415, 'Tahitian', 'por'),
	(416, 'Tai (Other)', 'por'),
	(417, 'Tamil', 'por'),
	(418, 'Tatar', 'por'),
	(419, 'Telugu', 'por'),
	(420, 'Timnendere)', 'por'),
	(421, 'Tereno', 'por'),
	(422, 'Tetum', 'por'),
	(423, 'Tajik', 'por'),
	(424, 'Tagalog', 'por'),
	(425, 'Thai', 'por'),
	(426, 'Tibetan', 'por'),
	(427, 'Tigre', 'por'),
	(428, 'Tigrinya', 'por'),
	(429, 'Tiv', 'por'),
	(430, 'Tokelau', 'por'),
	(431, 'Klingon; tlhIngan-Hol', 'por'),
	(432, 'Tlingit', 'por'),
	(433, 'Tamashek', 'por'),
	(434, 'Tonga (Nyasa)', 'por'),
	(435, 'Tonga (Tonga Islands)', 'por'),
	(436, 'Tok Pisin', 'por'),
	(437, 'Tsimshian', 'por'),
	(438, 'Tswana', 'por'),
	(439, 'Tsonga', 'por'),
	(440, 'Turkmen', 'por'),
	(441, 'Tumbuka', 'por'),
	(442, 'Tupi languages', 'por'),
	(443, 'Turkish', 'por'),
	(444, 'Altaic (Other)', 'por'),
	(445, 'Tuvalu', 'por'),
	(446, 'Twi', 'por');
INSERT INTO public.isolanguagesdes VALUES
	(447, 'Tuvinian', 'por'),
	(448, 'Udmurt', 'por'),
	(449, 'Ugaritic', 'por'),
	(450, 'Uighur; Uyghur', 'por'),
	(451, 'Ukrainian', 'por'),
	(452, 'Umbundu', 'por'),
	(453, 'Undetermined', 'por'),
	(454, 'Urdu', 'por'),
	(455, 'Uzbek', 'por'),
	(456, 'Vai', 'por'),
	(457, 'Venda', 'por'),
	(458, 'Vietnamese', 'por'),
	(459, 'Volapük', 'por'),
	(460, 'Votic', 'por'),
	(461, 'Wakashan languages', 'por'),
	(462, 'Walamo', 'por'),
	(463, 'Waray', 'por'),
	(464, 'Washo', 'por'),
	(465, 'Welsh', 'por'),
	(466, 'Sorbian languages', 'por'),
	(467, 'Walloon', 'por'),
	(468, 'Wolof', 'por'),
	(469, 'Kalmyk; Oirat', 'por'),
	(470, 'Xhosa', 'por'),
	(471, 'Yao', 'por'),
	(472, 'Yapese', 'por'),
	(473, 'Yiddish', 'por'),
	(474, 'Yoruba', 'por'),
	(475, 'Yupik languages', 'por'),
	(476, 'Zapotec', 'por'),
	(477, 'Zenaga', 'por'),
	(478, 'Zhuang; Chuang', 'por'),
	(479, 'Zande languages', 'por'),
	(480, 'Zulu', 'por'),
	(481, 'Zuni', 'por'),
	(482, 'No linguistic content', 'por'),
	(483, 'N''Ko', 'por'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'por'),
	(1, 'Afar', 'chi'),
	(2, 'Abkhazian', 'chi'),
	(3, 'Achinese', 'chi'),
	(4, 'Acoli', 'chi'),
	(5, 'Adangme', 'chi'),
	(6, 'Adyghe; Adygei', 'chi'),
	(7, 'Afro-Asiatic (Other)', 'chi'),
	(8, 'Afrihili', 'chi'),
	(9, 'Afrikaans', 'chi'),
	(10, 'Ainu', 'chi'),
	(11, 'Akan', 'chi'),
	(12, 'Akkadian', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(13, 'Albanian', 'chi'),
	(14, 'Aleut', 'chi'),
	(15, 'Algonquian languages', 'chi'),
	(16, 'Southern Altai', 'chi'),
	(17, 'Amharic', 'chi'),
	(18, 'English, Old (ca.450-1100)', 'chi'),
	(19, 'Angika', 'chi'),
	(20, 'Apache languages', 'chi'),
	(21, 'Arabic', 'chi'),
	(22, 'Aramaic', 'chi'),
	(23, 'Aragonese', 'chi'),
	(24, 'Armenian', 'chi'),
	(25, 'Mapudungun; Mapuche', 'chi'),
	(26, 'Arapaho', 'chi'),
	(27, 'Artificial (Other)', 'chi'),
	(28, 'Arawak', 'chi'),
	(29, 'Assamese', 'chi'),
	(30, 'Asturian; Bable', 'chi'),
	(31, 'Athapascan languages', 'chi'),
	(32, 'Australian languages', 'chi'),
	(33, 'Avaric', 'chi'),
	(34, 'Avestan', 'chi'),
	(35, 'Awadhi', 'chi'),
	(36, 'Aymara', 'chi'),
	(37, 'Azerbaijani', 'chi'),
	(38, 'Banda languages', 'chi'),
	(39, 'Bamileke languages', 'chi'),
	(40, 'Bashkir', 'chi'),
	(41, 'Baluchi', 'chi'),
	(42, 'Bambara', 'chi'),
	(43, 'Balinese', 'chi'),
	(44, 'Basque', 'chi'),
	(45, 'Basa', 'chi'),
	(46, 'Baltic (Other)', 'chi'),
	(47, 'Beja', 'chi'),
	(48, 'Belarusian', 'chi'),
	(49, 'Bemba', 'chi'),
	(50, 'Bengali', 'chi'),
	(51, 'Berber (Other)', 'chi'),
	(52, 'Bhojpuri', 'chi'),
	(53, 'Bihari', 'chi'),
	(54, 'Bikol', 'chi'),
	(55, 'Bini; Edo', 'chi'),
	(56, 'Bislama', 'chi'),
	(57, 'Siksika', 'chi'),
	(58, 'Bantu (Other)', 'chi'),
	(59, 'Bosnian', 'chi'),
	(60, 'Braj', 'chi'),
	(61, 'Breton', 'chi'),
	(62, 'Batak languages', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(63, 'Buriat', 'chi'),
	(64, 'Buginese', 'chi'),
	(65, 'Bulgarian', 'chi'),
	(66, 'Burmese', 'chi'),
	(67, 'Blin; Bilin', 'chi'),
	(68, 'Caddo', 'chi'),
	(69, 'Central American Indian (Other)', 'chi'),
	(70, 'Galibi Carib', 'chi'),
	(71, 'Catalan; Valencian', 'chi'),
	(72, 'Caucasian (Other)avonic; Old Bulgarian; Old Church Slavonic', 'chi'),
	(73, 'Cebuano', 'chi'),
	(74, 'Celtic (Other)', 'chi'),
	(75, 'Chamorro', 'chi'),
	(76, 'Chibcha', 'chi'),
	(77, 'Chechen', 'chi'),
	(78, 'Chagataiher)', 'chi'),
	(79, 'Chineseutres', 'chi'),
	(80, 'Chuukese', 'chi'),
	(81, 'Mari', 'chi'),
	(82, 'Chinook jargon', 'chi'),
	(83, 'Choctaw', 'chi'),
	(84, 'Chipewyan', 'chi'),
	(85, 'Cherokee', 'chi'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'chi'),
	(87, 'Chuvash', 'chi'),
	(88, 'Cheyenne', 'chi'),
	(89, 'Chamic languages', 'chi'),
	(90, 'Coptic', 'chi'),
	(91, 'Cornish', 'chi'),
	(92, 'Corsican', 'chi'),
	(93, 'Creoles and pidgins, English based (Ot', 'chi'),
	(94, 'Creoles and pidgins, French-based (Oth', 'chi'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'chi'),
	(96, 'Cree', 'chi'),
	(97, 'Crimean Tatar; Crimean Turkish', 'chi'),
	(98, 'Creoles and pidgins (Other)', 'chi'),
	(99, 'Kashubian', 'chi'),
	(100, 'Cushitic (Other)', 'chi'),
	(101, 'Czech', 'chi'),
	(102, 'Dakota', 'chi'),
	(103, 'Danish', 'chi'),
	(104, 'Dargwa', 'chi'),
	(105, 'Land Dayak languages', 'chi'),
	(106, 'Delaware', 'chi'),
	(107, 'Slave (Athapascan)', 'chi'),
	(108, 'Dogrib', 'chi'),
	(109, 'Dinka', 'chi'),
	(110, 'Divehi; Dhivehi; Maldivian', 'chi'),
	(111, 'Dogri', 'chi'),
	(112, 'Dravidian (Other)', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(113, 'Lower Sorbian', 'chi'),
	(114, 'Duala', 'chi'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'chi'),
	(116, 'Dutch; Flemish', 'chi'),
	(117, 'Dyula', 'chi'),
	(118, 'Dzongkha', 'chi'),
	(119, 'Efik', 'chi'),
	(120, 'Egyptian (Ancient)', 'chi'),
	(121, 'Ekajuk', 'chi'),
	(122, 'Elamite', 'chi'),
	(123, 'English', 'chi'),
	(124, 'English, Middle (1100-1500)', 'chi'),
	(125, 'Esperanto', 'chi'),
	(126, 'Estonian', 'chi'),
	(127, 'Ewe', 'chi'),
	(128, 'Ewondo', 'chi'),
	(129, 'Fang', 'chi'),
	(130, 'Faroese', 'chi'),
	(131, 'Fanti', 'chi'),
	(132, 'Fijian', 'chi'),
	(133, 'Filipino; Pilipino', 'chi'),
	(134, 'Finnish', 'chi'),
	(135, 'Finno-Ugrian (Other)', 'chi'),
	(136, 'Fon', 'chi'),
	(137, 'French', 'chi'),
	(138, 'French, Middle (ca.1400-1600)', 'chi'),
	(139, 'French, Old (842-ca.1400)', 'chi'),
	(140, 'Northern Frisian', 'chi'),
	(141, 'Eastern Frisian', 'chi'),
	(142, 'Western Frisian', 'chi'),
	(143, 'Fulah', 'chi'),
	(144, 'Friulian', 'chi'),
	(145, 'Ga', 'chi'),
	(146, 'Gayo', 'chi'),
	(147, 'Gbaya', 'chi'),
	(148, 'Germanic (Other)', 'chi'),
	(149, 'Georgian', 'chi'),
	(150, 'German', 'chi'),
	(151, 'Geez', 'chi'),
	(152, 'Gilbertese', 'chi'),
	(153, 'Gaelic; Scottish Gaelic', 'chi'),
	(154, 'Irish', 'chi'),
	(155, 'Galician', 'chi'),
	(156, 'Manx', 'chi'),
	(157, 'German, Middle High (ca.1050-1500)', 'chi'),
	(158, 'German, Old High (ca.750-1050)', 'chi'),
	(159, 'Gondi', 'chi'),
	(160, 'Gorontalo', 'chi'),
	(161, 'Gothicanguage Association)', 'chi'),
	(162, 'Grebo', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(163, 'Greek, Ancient (to 1453)', 'chi'),
	(164, 'Greek, Modern (1453-)', 'chi'),
	(165, 'Guarani', 'chi'),
	(166, 'Swiss German; Alemannic', 'chi'),
	(167, 'Gujarati', 'chi'),
	(168, 'Gwich''in', 'chi'),
	(169, 'Haida', 'chi'),
	(170, 'Haitian; Haitian Creole', 'chi'),
	(171, 'Hausa', 'chi'),
	(172, 'Hawaiian', 'chi'),
	(173, 'Hebrew', 'chi'),
	(174, 'Herero', 'chi'),
	(175, 'Hiligaynon', 'chi'),
	(176, 'Himachali', 'chi'),
	(177, 'Hindi', 'chi'),
	(178, 'Hittite', 'chi'),
	(179, 'Hmong', 'chi'),
	(180, 'Hiri Motu', 'chi'),
	(181, 'Upper Sorbian', 'chi'),
	(182, 'Hungarian', 'chi'),
	(183, 'Hupa', 'chi'),
	(184, 'Iban', 'chi'),
	(185, 'Igbo', 'chi'),
	(186, 'Icelandic', 'chi'),
	(187, 'Ido', 'chi'),
	(188, 'Sichuan Yi', 'chi'),
	(189, 'Ijo languages', 'chi'),
	(190, 'Inuktitut', 'chi'),
	(191, 'Interlingue', 'chi'),
	(192, 'Iloko', 'chi'),
	(193, 'Interlingua (International Auxiliary L', 'chi'),
	(194, 'Indic (Other)', 'chi'),
	(195, 'Indonesian', 'chi'),
	(196, 'Indo-European (Other)', 'chi'),
	(197, 'Ingush', 'chi'),
	(198, 'Inupiaq', 'chi'),
	(199, 'Iranian (Other)', 'chi'),
	(200, 'Iroquoian languages', 'chi'),
	(201, 'Italian', 'chi'),
	(202, 'Javanese', 'chi'),
	(203, 'Lojban', 'chi'),
	(204, 'Japanese', 'chi'),
	(205, 'Judeo-Persian', 'chi'),
	(206, 'Judeo-Arabic', 'chi'),
	(207, 'Kara-Kalpak', 'chi'),
	(208, 'Kabyle', 'chi'),
	(209, 'Kachin; Jingpho', 'chi'),
	(210, 'Kalaallisut; Greenlandic', 'chi'),
	(211, 'Kamba', 'chi'),
	(212, 'Kannada', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(213, 'Karen languages', 'chi'),
	(214, 'Kashmiri', 'chi'),
	(215, 'Kanuri', 'chi'),
	(216, 'Kawi', 'chi'),
	(217, 'Kazakh', 'chi'),
	(218, 'Kabardian', 'chi'),
	(219, 'Khasi', 'chi'),
	(220, 'Khoisan (Other)', 'chi'),
	(221, 'Central Khmer', 'chi'),
	(222, 'Khotanese', 'chi'),
	(223, 'Kikuyu; Gikuyu', 'chi'),
	(224, 'Kinyarwanda', 'chi'),
	(225, 'Kirghiz; Kyrgyz', 'chi'),
	(226, 'Kimbundu', 'chi'),
	(227, 'Konkani', 'chi'),
	(228, 'Komi', 'chi'),
	(229, 'Kongo', 'chi'),
	(230, 'Korean', 'chi'),
	(231, 'Kosraean', 'chi'),
	(232, 'Kpelle', 'chi'),
	(233, 'Karachay-Balkar', 'chi'),
	(234, 'Karelian', 'chi'),
	(235, 'Kru languages', 'chi'),
	(236, 'Kurukh', 'chi'),
	(237, 'Kuanyama; Kwanyama', 'chi'),
	(238, 'Kumyk', 'chi'),
	(239, 'Kurdish', 'chi'),
	(240, 'Kutenai', 'chi'),
	(241, 'Ladino', 'chi'),
	(242, 'Lahnda', 'chi'),
	(243, 'Lamba', 'chi'),
	(244, 'Lao', 'chi'),
	(245, 'Latin', 'chi'),
	(246, 'Latvian', 'chi'),
	(247, 'Lezghian', 'chi'),
	(248, 'Limburgan; Limburger; Limburgish', 'chi'),
	(249, 'Lingala', 'chi'),
	(250, 'Lithuanian', 'chi'),
	(251, 'Mongo', 'chi'),
	(252, 'Lozi', 'chi'),
	(253, 'Luxembourgish; Letzeburgesch', 'chi'),
	(254, 'Luba-Lulua', 'chi'),
	(255, 'Luba-Katangaxon, Low', 'chi'),
	(256, 'Ganda', 'chi'),
	(257, 'Luiseno', 'chi'),
	(258, 'Lunda', 'chi'),
	(259, 'Luo (Kenya and Tanzania)', 'chi'),
	(260, 'Lushai', 'chi'),
	(261, 'Macedonian00E5l', 'chi'),
	(262, 'Madurese', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(263, 'Magahi', 'chi'),
	(264, 'Marshallese', 'chi'),
	(265, 'Maithili', 'chi'),
	(266, 'Makasarl Nepal Bhasa', 'chi'),
	(267, 'Malayalam', 'chi'),
	(268, 'Mandingo', 'chi'),
	(269, 'Maori', 'chi'),
	(270, 'Austronesian (Other)', 'chi'),
	(271, 'Marathi', 'chi'),
	(272, 'Masai', 'chi'),
	(273, 'Malay', 'chi'),
	(274, 'Moksha', 'chi'),
	(275, 'Mandar', 'chi'),
	(276, 'Mende', 'chi'),
	(277, 'Irish, Middle (900-1200)', 'chi'),
	(278, 'Mi''kmaq; Micmac', 'chi'),
	(279, 'Minangkabau', 'chi'),
	(280, 'Miscellaneous languages', 'chi'),
	(281, 'Mon-Khmer (Other)', 'chi'),
	(282, 'Malagasy', 'chi'),
	(283, 'Maltese', 'chi'),
	(284, 'Manchu', 'chi'),
	(285, 'Manipuri', 'chi'),
	(286, 'Manobo languages', 'chi'),
	(287, 'Mohawk', 'chi'),
	(288, 'Moldavian', 'chi'),
	(289, 'Mongolian', 'chi'),
	(290, 'Mossi', 'chi'),
	(291, 'Multiple languages', 'chi'),
	(292, 'Munda languages', 'chi'),
	(293, 'Creek', 'chi'),
	(294, 'Mirandese', 'chi'),
	(295, 'Marwari', 'chi'),
	(296, 'Mayan languages', 'chi'),
	(297, 'Erzya', 'chi'),
	(298, 'Nahuatl languages', 'chi'),
	(299, 'North American Indian', 'chi'),
	(300, 'Neapolitan', 'chi'),
	(301, 'Nauru', 'chi'),
	(302, 'Navajo; Navaho', 'chi'),
	(303, 'Ndebele, South; South Ndebele', 'chi'),
	(304, 'Ndebele, North; North Ndebele', 'chi'),
	(305, 'Ndonga', 'chi'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'chi'),
	(307, 'Nepali', 'chi'),
	(308, 'Nepal Bhasa; Newari', 'chi'),
	(309, 'Nias', 'chi'),
	(310, 'Niger-Kordofanian (Other)', 'chi'),
	(311, 'Niuean', 'chi'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'chi'),
	(314, 'Nogai', 'chi'),
	(315, 'Norse, Old', 'chi'),
	(316, 'Norwegian', 'chi'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'chi'),
	(318, 'Nubian languages', 'chi'),
	(319, 'Classical Newari; Old Newari; Classica', 'chi'),
	(320, 'Chichewa; Chewa; Nyanja', 'chi'),
	(321, 'Nyamwezi', 'chi'),
	(322, 'Nyankole', 'chi'),
	(323, 'Nyoro', 'chi'),
	(324, 'Nzima', 'chi'),
	(325, 'Occitan (post 1500); Provençal', 'chi'),
	(326, 'Ojibwa', 'chi'),
	(327, 'Oriya', 'chi'),
	(328, 'Oromo', 'chi'),
	(329, 'Osage', 'chi'),
	(330, 'Ossetian; Ossetic', 'chi'),
	(331, 'Turkish, Ottoman (1500-1928)', 'chi'),
	(332, 'Otomian languages', 'chi'),
	(333, 'Papuan (Other)', 'chi'),
	(334, 'Pangasinan', 'chi'),
	(335, 'Pahlavi', 'chi'),
	(336, 'Pampanga', 'chi'),
	(337, 'Panjabi; Punjabi', 'chi'),
	(338, 'Papiamento', 'chi'),
	(339, 'Palauan', 'chi'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'chi'),
	(341, 'Persian', 'chi'),
	(342, 'Philippine (Other)', 'chi'),
	(343, 'Phoenician', 'chi'),
	(344, 'Pali', 'chi'),
	(345, 'Polish', 'chi'),
	(346, 'Pohnpeian', 'chi'),
	(347, 'Portuguese', 'chi'),
	(348, 'Prakrit languages', 'chi'),
	(349, 'Provençal, Old (to 1500)', 'chi'),
	(350, 'Pushto', 'chi'),
	(351, 'Reserved for local use', 'chi'),
	(352, 'Quechua', 'chi'),
	(353, 'Rajasthani', 'chi'),
	(354, 'Rapanui', 'chi'),
	(355, 'Rarotongan; Cook Islands Maori', 'chi'),
	(356, 'Romance (Other)', 'chi'),
	(357, 'Romansh', 'chi'),
	(358, 'Romany', 'chi'),
	(359, 'Romanian', 'chi'),
	(360, 'Rundi', 'chi'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'chi'),
	(362, 'Russian', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(363, 'Sandawe', 'chi'),
	(364, 'Sango', 'chi'),
	(365, 'Yakut', 'chi'),
	(366, 'South American Indian (Other)', 'chi'),
	(367, 'Salishan languages', 'chi'),
	(368, 'Samaritan Aramaic', 'chi'),
	(369, 'Sanskrit', 'chi'),
	(370, 'Sasak', 'chi'),
	(371, 'Santali', 'chi'),
	(372, 'Serbian', 'chi'),
	(373, 'Sicilian', 'chi'),
	(374, 'Scots', 'chi'),
	(375, 'Croatian', 'chi'),
	(376, 'Selkup', 'chi'),
	(377, 'Semitic (Other)', 'chi'),
	(378, 'Irish, Old (to 900)', 'chi'),
	(379, 'Sign Languages', 'chi'),
	(380, 'Shan', 'chi'),
	(381, 'Sidamo', 'chi'),
	(382, 'Sinhala; Sinhalese', 'chi'),
	(383, 'Siouan languages', 'chi'),
	(384, 'Sino-Tibetan (Other)', 'chi'),
	(385, 'Slavic (Other)', 'chi'),
	(386, 'Slovak', 'chi'),
	(387, 'Slovenian', 'chi'),
	(388, 'Southern Sami', 'chi'),
	(389, 'Northern Sami', 'chi'),
	(390, 'Sami languages (Other)', 'chi'),
	(391, 'Lule Sami', 'chi'),
	(392, 'Inari Sami', 'chi'),
	(393, 'Samoan', 'chi'),
	(394, 'Skolt Sami', 'chi'),
	(395, 'Shona', 'chi'),
	(396, 'Sindhi', 'chi'),
	(397, 'Soninke', 'chi'),
	(398, 'Sogdian', 'chi'),
	(399, 'Somali', 'chi'),
	(400, 'Songhai languages', 'chi'),
	(401, 'Sotho, Southern', 'chi'),
	(402, 'Spanish; Castilian', 'chi'),
	(403, 'Sardinian', 'chi'),
	(404, 'Sranan Tongo; zazaki', 'chi'),
	(405, 'Serer', 'chi'),
	(406, 'Nilo-Saharan (Other)', 'chi'),
	(407, 'Swati', 'chi'),
	(408, 'Sukuma', 'chi'),
	(409, 'Sundanese', 'chi'),
	(410, 'Susu', 'chi'),
	(411, 'Sumerian', 'chi'),
	(412, 'Swahili', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(413, 'Swedish', 'chi'),
	(414, 'Syriac', 'chi'),
	(415, 'Tahitian', 'chi'),
	(416, 'Tai (Other)', 'chi'),
	(417, 'Tamil', 'chi'),
	(418, 'Tatar', 'chi'),
	(419, 'Telugu', 'chi'),
	(420, 'Timne', 'chi'),
	(421, 'Tereno', 'chi'),
	(422, 'Tetum', 'chi'),
	(423, 'Tajik', 'chi'),
	(424, 'Tagalog', 'chi'),
	(425, 'Thai', 'chi'),
	(426, 'Tibetan', 'chi'),
	(427, 'Tigre', 'chi'),
	(428, 'Tigrinya', 'chi'),
	(429, 'Tiv', 'chi'),
	(430, 'Tokelau', 'chi'),
	(431, 'Klingon; tlhIngan-Hol', 'chi'),
	(432, 'Tlingit', 'chi'),
	(433, 'Tamashek', 'chi'),
	(434, 'Tonga (Nyasa)', 'chi'),
	(435, 'Tonga (Tonga Islands)', 'chi'),
	(436, 'Tok Pisin', 'chi'),
	(437, 'Tsimshian', 'chi'),
	(438, 'Tswana', 'chi'),
	(439, 'Tsonga', 'chi'),
	(440, 'Turkmen', 'chi'),
	(441, 'Tumbuka', 'chi'),
	(442, 'Tupi languages', 'chi'),
	(443, 'Turkish', 'chi'),
	(444, 'Altaic (Other)', 'chi'),
	(445, 'Tuvalu', 'chi'),
	(446, 'Twi', 'chi'),
	(447, 'Tuvinian', 'chi'),
	(448, 'Udmurt', 'chi'),
	(449, 'Ugaritic', 'chi'),
	(450, 'Uighur; Uyghur', 'chi'),
	(451, 'Ukrainian', 'chi'),
	(452, 'Umbundu', 'chi'),
	(453, 'Undetermined', 'chi'),
	(454, 'Urdu', 'chi'),
	(455, 'Uzbek', 'chi'),
	(456, 'Vai', 'chi'),
	(457, 'Venda', 'chi'),
	(458, 'Vietnamese', 'chi'),
	(459, 'Volapük', 'chi'),
	(460, 'Votic', 'chi'),
	(461, 'Wakashan languages', 'chi'),
	(462, 'Walamo', 'chi');
INSERT INTO public.isolanguagesdes VALUES
	(463, 'Waray', 'chi'),
	(464, 'Washo', 'chi'),
	(465, 'Welsh', 'chi'),
	(466, 'Sorbian languages', 'chi'),
	(467, 'Walloon', 'chi'),
	(468, 'Wolof', 'chi'),
	(469, 'Kalmyk; Oirat', 'chi'),
	(470, 'Xhosa', 'chi'),
	(471, 'Yao', 'chi'),
	(472, 'Yapese', 'chi'),
	(473, 'Yiddish', 'chi'),
	(474, 'Yoruba', 'chi'),
	(475, 'Yupik languages', 'chi'),
	(476, 'Zapotec', 'chi'),
	(477, 'Zenaga', 'chi'),
	(478, 'Zhuang; Chuang', 'chi'),
	(479, 'Zande languages', 'chi'),
	(480, 'Zulu', 'chi'),
	(481, 'Zuni', 'chi'),
	(482, 'No linguistic content', 'chi'),
	(483, 'N''Ko', 'chi'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'chi'),
	(1, 'Afar', 'dut'),
	(2, 'Abchazisch', 'dut'),
	(3, 'Achinese', 'dut'),
	(4, 'Akoli', 'dut'),
	(5, 'Adangme', 'dut'),
	(6, 'Adygees', 'dut'),
	(7, 'Afro-Aziatisch (Overig)', 'dut'),
	(8, 'Afrihili', 'dut'),
	(9, 'Afrikaans', 'dut'),
	(10, 'Ainu', 'dut'),
	(11, 'Akan', 'dut'),
	(12, 'Akkadisch', 'dut'),
	(13, 'Albanees', 'dut'),
	(14, 'Aleut', 'dut'),
	(15, 'Algonquiaanse talen', 'dut'),
	(16, 'Zuid-Altai', 'dut'),
	(17, 'Amhaars', 'dut'),
	(18, 'Engels, Oud (ca.450-1100)', 'dut'),
	(19, 'Angika', 'dut'),
	(20, 'Apachetalen', 'dut'),
	(21, 'Arabisch', 'dut'),
	(22, 'Aramees', 'dut'),
	(23, 'Aragonees', 'dut'),
	(24, 'Armeens', 'dut'),
	(25, 'Mapudungun; Mapuche', 'dut'),
	(26, 'Arapaho', 'dut'),
	(27, 'Kunsttalen (Overig)', 'dut'),
	(28, 'Arawak', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(29, 'Assamees', 'dut'),
	(30, 'Asturisch', 'dut'),
	(31, 'Athabaskische talen', 'dut'),
	(32, 'Australische talen', 'dut'),
	(33, 'Avaars', 'dut'),
	(34, 'Avestisch', 'dut'),
	(35, 'Awadhi', 'dut'),
	(36, 'Aymara', 'dut'),
	(37, 'Azerbeidzjaans', 'dut'),
	(38, 'Banda talen', 'dut'),
	(39, 'Bamileke talen', 'dut'),
	(40, 'Bashkir', 'dut'),
	(41, 'Baluchi', 'dut'),
	(42, 'Bambara', 'dut'),
	(43, 'Balinees', 'dut'),
	(44, 'Baskisch', 'dut'),
	(45, 'Basa', 'dut'),
	(46, 'Baltic (Overig)', 'dut'),
	(47, 'Beja', 'dut'),
	(48, 'Wit-Russisch', 'dut'),
	(49, 'Bemba', 'dut'),
	(50, 'Bengaals', 'dut'),
	(51, 'Berber (Overig)', 'dut'),
	(52, 'Bhojpuri', 'dut'),
	(53, 'Bihari', 'dut'),
	(54, 'Bikol', 'dut'),
	(55, 'Bini; Edo', 'dut'),
	(56, 'Bislama', 'dut'),
	(57, 'Siksika', 'dut'),
	(58, 'Bantu (Overig)', 'dut'),
	(59, 'Bosnisch', 'dut'),
	(60, 'Braj', 'dut'),
	(61, 'Bretons', 'dut'),
	(62, 'Bataktalen', 'dut'),
	(63, 'Buriat', 'dut'),
	(64, 'Buginees', 'dut'),
	(65, 'Bulgaars', 'dut'),
	(66, 'Birmees', 'dut'),
	(67, 'Blin; Bilin', 'dut'),
	(68, 'Caddo', 'dut'),
	(69, 'Midden-Amerikaanse Indiaanse talen (Overig)', 'dut'),
	(70, 'Caribische talen', 'dut'),
	(71, 'Catalaans; Valenciaans', 'dut'),
	(72, 'Kaukasische talen; Oud Bulgaars', 'dut'),
	(73, 'Cebuano', 'dut'),
	(74, 'Keltisch (Overig)', 'dut'),
	(75, 'Chamorro', 'dut'),
	(76, 'Chibcha', 'dut'),
	(77, 'Tsjetsjeens', 'dut'),
	(78, 'Chagataier)', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(79, 'Chinees(Overig)', 'dut'),
	(80, 'Chuukees', 'dut'),
	(81, 'Mari', 'dut'),
	(82, 'Chinook-jargon', 'dut'),
	(83, 'Choctaw', 'dut'),
	(84, 'Chipewyan', 'dut'),
	(85, 'Cherokee', 'dut'),
	(86, 'Kerkslavisch; Oudslavisch; Kerk Sl', 'dut'),
	(87, 'Chuvash', 'dut'),
	(88, 'Cheyenne', 'dut'),
	(89, 'Chamic talen', 'dut'),
	(90, 'Koptisch', 'dut'),
	(91, 'Cornish', 'dut'),
	(92, 'Corsicaans', 'dut'),
	(93, 'Creools en Pidgin, Engels gebaseerd (Overige)', 'dut'),
	(94, 'Creools en Pidgin, in Frankrijk gevestigd (Overige)', 'dut'),
	(95, 'Creools en Pidgin, Portugees gebaseerde', 'dut'),
	(96, 'Creools', 'dut'),
	(97, 'Krim-Tataars; Krim-Turks', 'dut'),
	(98, 'Creools en Pidgin (Overig)', 'dut'),
	(99, 'Kasjoebisch', 'dut'),
	(100, 'Cushitisch (Overig)', 'dut'),
	(101, 'Tsjech', 'dut'),
	(102, 'Dakota', 'dut'),
	(103, 'Deens', 'dut'),
	(104, 'Dargwa', 'dut'),
	(105, 'Land Dayak talen', 'dut'),
	(106, 'Delaware', 'dut'),
	(107, 'Slaaf (Athapascan)', 'dut'),
	(108, 'Dogrib', 'dut'),
	(109, 'Dinka', 'dut'),
	(110, 'Divehi; Dhivehi; Maldivisch', 'dut'),
	(111, 'Dogri', 'dut'),
	(112, 'Dravidian (Overig)', 'dut'),
	(113, 'Nedersorbisch', 'dut'),
	(114, 'Duala', 'dut'),
	(115, 'Nederlands, Midden (ca.1050-1350)', 'dut'),
	(116, 'Nederlands; Vlaams', 'dut'),
	(117, 'Dioula', 'dut'),
	(118, 'Dzongkha', 'dut'),
	(119, 'Efik', 'dut'),
	(120, 'Egyptisch (oud)', 'dut'),
	(121, 'Ekajuk', 'dut'),
	(122, 'Elamitisch', 'dut'),
	(123, 'Engels', 'dut'),
	(124, 'Engels, Midden (1100-1500)', 'dut'),
	(125, 'Esperanto', 'dut'),
	(126, 'Ests', 'dut'),
	(127, 'Ewe', 'dut'),
	(128, 'Ewondo', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(129, 'Fang', 'dut'),
	(130, 'Faeröers', 'dut'),
	(131, 'Fanti', 'dut'),
	(132, 'Fijisch', 'dut'),
	(133, 'Filipijns', 'dut'),
	(134, 'Fins', 'dut'),
	(135, 'Fins-Oegrisch (Overig)', 'dut'),
	(136, 'Fon', 'dut'),
	(137, 'Frans', 'dut'),
	(138, 'Frans, Midden (ca.1400-1600)', 'dut'),
	(139, 'Frans, Oud (842-ca.1400)', 'dut'),
	(140, 'Noord-Fries', 'dut'),
	(141, 'Oost-Fries', 'dut'),
	(142, 'West-Fries', 'dut'),
	(143, 'Fula', 'dut'),
	(144, 'Friulisch', 'dut'),
	(145, 'Ga', 'dut'),
	(146, 'Gayo', 'dut'),
	(147, 'Gbaya', 'dut'),
	(148, 'Germaans (Overige)', 'dut'),
	(149, 'Georgisch', 'dut'),
	(150, 'Duits', 'dut'),
	(151, 'Geez', 'dut'),
	(152, 'Gilbertees', 'dut'),
	(153, 'Gaelisch; Schots-Gaelisch', 'dut'),
	(154, 'Iers', 'dut'),
	(155, 'Galicisch', 'dut'),
	(156, 'Manx', 'dut'),
	(157, 'Duits, Middelhoog (ca.1050-1500)', 'dut'),
	(158, 'Duits, Oud Hoog (ca.750-1050)', 'dut'),
	(159, 'Gondi', 'dut'),
	(160, 'Gorontalo', 'dut'),
	(161, 'Gothicaanse Vereniging)', 'dut'),
	(162, 'Grebo', 'dut'),
	(163, 'Grieks, Oud (tot 1453)', 'dut'),
	(164, 'Grieks, Modern (1453-)', 'dut'),
	(165, 'Guarani', 'dut'),
	(166, 'Zwitsers-Duits; Alemannisch', 'dut'),
	(167, 'Gujarati', 'dut'),
	(168, 'Gwich''in', 'dut'),
	(169, 'Haida', 'dut'),
	(170, 'Haïtiaans; Haïtiaans Creools', 'dut'),
	(171, 'Hausa', 'dut'),
	(172, 'Hawaiiaans', 'dut'),
	(173, 'Hebreeuws', 'dut'),
	(174, 'Herero', 'dut'),
	(175, 'Hiligaynon', 'dut'),
	(176, 'Himachali', 'dut'),
	(177, 'Hindi', 'dut'),
	(178, 'Hettitisch', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(179, 'Hmong', 'dut'),
	(180, 'Hiri Motu', 'dut'),
	(181, 'Oppersorbisch', 'dut'),
	(182, 'Hongaars', 'dut'),
	(183, 'Hupa', 'dut'),
	(184, 'Iban', 'dut'),
	(185, 'Igbo', 'dut'),
	(186, 'IJslands', 'dut'),
	(187, 'Ido', 'dut'),
	(188, 'Sichuan Yi', 'dut'),
	(189, 'Ijo talen', 'dut'),
	(190, 'Inuktitut', 'dut'),
	(191, 'Interlingue', 'dut'),
	(192, 'Iloko', 'dut'),
	(193, 'Interlingua (International Auxiliary L', 'dut'),
	(194, 'Indisch (Overig)', 'dut'),
	(195, 'Indonesisch', 'dut'),
	(196, 'Indo-Europees (Overig)', 'dut'),
	(197, 'Ingush', 'dut'),
	(198, 'Inupiaq', 'dut'),
	(199, 'Iraans (Overig)', 'dut'),
	(200, 'Iroquoian talen', 'dut'),
	(201, 'Italianen', 'dut'),
	(202, 'Javaanse', 'dut'),
	(203, 'Lojban', 'dut'),
	(204, 'Japans', 'dut'),
	(205, 'joods-Perzisch', 'dut'),
	(206, 'joods-Arabisch', 'dut'),
	(207, 'Kara-Kalpak', 'dut'),
	(208, 'Kabyle', 'dut'),
	(209, 'Kachin; Jingpho', 'dut'),
	(210, 'Kalaallisut; Groenlands', 'dut'),
	(211, 'Kamba', 'dut'),
	(212, 'Kannada', 'dut'),
	(213, 'Karen talen', 'dut'),
	(214, 'Kashmiri', 'dut'),
	(215, 'Kanuri', 'dut'),
	(216, 'Kawi', 'dut'),
	(217, 'Kazachs', 'dut'),
	(218, 'Kabardiaan', 'dut'),
	(219, 'Khasi', 'dut'),
	(220, 'Khoisan (Overig)', 'dut'),
	(221, 'Central Khmer', 'dut'),
	(222, 'Khotanees', 'dut'),
	(223, 'Kikuyu; Gikuyu', 'dut'),
	(224, 'Kinyarwanda', 'dut'),
	(225, 'Kirgiz; Kirgizisch', 'dut'),
	(226, 'Kimbundu', 'dut'),
	(227, 'Kokani', 'dut'),
	(228, 'Komi', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(229, 'Kongo', 'dut'),
	(230, 'Koreaans', 'dut'),
	(231, 'Kosraean', 'dut'),
	(232, 'Kpelle', 'dut'),
	(233, 'Karachay-Balkar', 'dut'),
	(234, 'Karelisch', 'dut'),
	(235, 'Kru talen', 'dut'),
	(236, 'Kurukh', 'dut'),
	(237, 'Kuanyama; Kwanyama', 'dut'),
	(238, 'Kumyk', 'dut'),
	(239, 'Koerdisch', 'dut'),
	(240, 'Kutenai', 'dut'),
	(241, 'Ladino', 'dut'),
	(242, 'Lahnda', 'dut'),
	(243, 'Lamba', 'dut'),
	(244, 'Lao', 'dut'),
	(245, 'Latijn', 'dut'),
	(246, 'Lets', 'dut'),
	(247, 'Lezghian', 'dut'),
	(248, 'Limburgs; Limburger', 'dut'),
	(249, 'Lingala', 'dut'),
	(250, 'Litouws', 'dut'),
	(251, 'Mongo', 'dut'),
	(252, 'Lozi', 'dut'),
	(253, 'Luxemburgs; Letzeburgesch', 'dut'),
	(254, 'Luba-Lulua', 'dut'),
	(255, 'Luba-Katangaxon, Laag', 'dut'),
	(256, 'Ganda', 'dut'),
	(257, 'Luiseno', 'dut'),
	(258, 'Lunda', 'dut'),
	(259, 'Luo (Kenia en Tanzania)', 'dut'),
	(260, 'Lushai', 'dut'),
	(261, 'Macedonisch', 'dut'),
	(262, 'Madurees', 'dut'),
	(263, 'Magahi', 'dut'),
	(264, 'Marshallese', 'dut'),
	(265, 'Maithili', 'dut'),
	(266, 'Makasarl Nepal Bhasa', 'dut'),
	(267, 'Malayalam', 'dut'),
	(268, 'Mandingo', 'dut'),
	(269, 'Maori', 'dut'),
	(270, 'Austronesisch (Overig)', 'dut'),
	(271, 'Marathi', 'dut'),
	(272, 'Masai', 'dut'),
	(273, 'Maleis', 'dut'),
	(274, 'Moksha', 'dut'),
	(275, 'Mandar', 'dut'),
	(276, 'Mende', 'dut'),
	(277, 'Iers, Midden (900-1200)', 'dut'),
	(278, 'Mi''kmaq; Micmac', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(279, 'Minangkabau', 'dut'),
	(280, 'Diverse talen', 'dut'),
	(281, 'Mon-Khmer (Overig)', 'dut'),
	(282, 'Malagasië', 'dut'),
	(283, 'Maltees', 'dut'),
	(284, 'Manchu', 'dut'),
	(285, 'Manipuri', 'dut'),
	(286, 'Manobo talen', 'dut'),
	(287, 'Mohawk', 'dut'),
	(288, 'Moldavisch', 'dut'),
	(289, 'Mongools', 'dut'),
	(290, 'Mossi', 'dut'),
	(291, 'Meerdere talen', 'dut'),
	(292, 'Munda talen', 'dut'),
	(293, 'Kreek', 'dut'),
	(294, 'Mirandees', 'dut'),
	(295, 'Marwari', 'dut'),
	(296, 'Maya-talen', 'dut'),
	(297, 'Erzya', 'dut'),
	(298, 'Nahuatl talen', 'dut'),
	(299, 'Noord-Amerikaans Indiaans', 'dut'),
	(300, 'Napolitaans', 'dut'),
	(301, 'Nauru', 'dut'),
	(302, 'Navajo; Navaho', 'dut'),
	(303, 'Ndebele, Zuid; Zuid Ndebele', 'dut'),
	(304, 'Ndebele, Noord; Noord Ndebele', 'dut'),
	(305, 'Ndonga', 'dut'),
	(306, 'Nederduits; Nedersaksisch; Duits, Low; Sa', 'dut'),
	(307, 'Nepali', 'dut'),
	(308, 'Nepal Bhasa; Newari', 'dut'),
	(309, 'Nias', 'dut'),
	(310, 'Niger-Kordofaans (Overig)', 'dut'),
	(311, 'Niuean', 'dut'),
	(312, 'Noors Nynorsk; Nynorsk, Norwegian', 'dut'),
	(313, 'Bokmål, Noors; Noors Bokmål', 'dut'),
	(314, 'Nogai', 'dut'),
	(315, 'Noors, Oud', 'dut'),
	(316, 'Noors', 'dut'),
	(317, 'Pedi; Sepedi; Noord-Sotho', 'dut'),
	(318, 'Nubische talen', 'dut'),
	(319, 'Klassiek Newari; Oude Newari; Classica', 'dut'),
	(320, 'Chichewa; Chewa; Nyanja', 'dut'),
	(321, 'Nyamwezi', 'dut'),
	(322, 'Nyankole', 'dut'),
	(323, 'Nyoro', 'dut'),
	(324, 'Nzima', 'dut'),
	(325, 'Occitaans (na 1500); Provençaals', 'dut'),
	(326, 'Ojibwa', 'dut'),
	(327, 'Oriya', 'dut'),
	(328, 'Oromo', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(329, 'Osage', 'dut'),
	(330, 'Ossetisch', 'dut'),
	(331, 'Turks, Ottomaans (1500-1928)', 'dut'),
	(332, 'Otomaans talent', 'dut'),
	(333, 'Papoean (Overig)', 'dut'),
	(334, 'Pangasinan', 'dut'),
	(335, 'Pahlavi', 'dut'),
	(336, 'Pampanga', 'dut'),
	(337, 'Panjabi; Punjabi', 'dut'),
	(338, 'Papiaments', 'dut'),
	(339, 'Palauan', 'dut'),
	(340, 'Perzisch, Oud (ca.600-400 v.Chr.)', 'dut'),
	(341, 'Perzisch', 'dut'),
	(342, 'Filippijnen (Overig)', 'dut'),
	(343, 'Fenicisch', 'dut'),
	(344, 'Pali', 'dut'),
	(345, 'Pools', 'dut'),
	(346, 'Pohnpeian', 'dut'),
	(347, 'Portugees', 'dut'),
	(348, 'Prakrit talen', 'dut'),
	(349, 'Provençaals, Oud (tot 1500)', 'dut'),
	(350, 'Pushto', 'dut'),
	(351, 'Gereserveerd voor lokaal gebruik', 'dut'),
	(352, 'Quechua', 'dut'),
	(353, 'Rajasthani', 'dut'),
	(354, 'Rapanui', 'dut'),
	(355, 'Rarotongan; Cook Eilanden Maori', 'dut'),
	(356, 'Romance (Overig)', 'dut'),
	(357, 'Reto-Romaans', 'dut'),
	(358, 'Romany', 'dut'),
	(359, 'Roemeens', 'dut'),
	(360, 'Rundi', 'dut'),
	(361, 'Armeens; Aroemeens; Macedo-Roemeens', 'dut'),
	(362, 'Russisch', 'dut'),
	(363, 'Sandawe', 'dut'),
	(364, 'Sango', 'dut'),
	(365, 'Yakut', 'dut'),
	(366, 'Zuid-Amerikaanse Indianen (Overig)', 'dut'),
	(367, 'Salishan-talen', 'dut'),
	(368, 'Samaritaans Aramees', 'dut'),
	(369, 'Sanskriet', 'dut'),
	(370, 'Sasak', 'dut'),
	(371, 'Santali', 'dut'),
	(372, 'Servisch', 'dut'),
	(373, 'Siciliaans', 'dut'),
	(374, 'Schots', 'dut'),
	(375, 'Kroatisch', 'dut'),
	(376, 'Selkup', 'dut'),
	(377, 'Semitisch (Overig)', 'dut'),
	(378, 'Iers, Oud (tot 900)', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(379, 'Gebarentalen', 'dut'),
	(380, 'Shan', 'dut'),
	(381, 'Sidamo', 'dut'),
	(382, 'Singalees', 'dut'),
	(383, 'Siouan talen', 'dut'),
	(384, 'Sino-Tibetaans (Overig)', 'dut'),
	(385, 'Slavisch (Overig)', 'dut'),
	(386, 'Slowaaks', 'dut'),
	(387, 'Sloveens', 'dut'),
	(388, 'Zuid-Sami', 'dut'),
	(389, 'Noordelijke Sami', 'dut'),
	(390, 'Sami talen (Overig)', 'dut'),
	(391, 'Lule Sami', 'dut'),
	(392, 'Inari Sami', 'dut'),
	(393, 'Samoaans', 'dut'),
	(394, 'Skolt Sami', 'dut'),
	(395, 'Shona', 'dut'),
	(396, 'Sindhi', 'dut'),
	(397, 'Soninke', 'dut'),
	(398, 'Sogdian', 'dut'),
	(399, 'Somalisch', 'dut'),
	(400, 'Songhai talen', 'dut'),
	(401, 'Sotho, Zuid', 'dut'),
	(402, 'Spaans; Castiliaans', 'dut'),
	(403, 'Sardijns; Zazaki', 'dut'),
	(404, 'Sranan Tongo', 'dut'),
	(405, 'Serer', 'dut'),
	(406, 'Nilo-Sahara (Overig)', 'dut'),
	(407, 'Swati', 'dut'),
	(408, 'Sukuma', 'dut'),
	(409, 'Soendanees', 'dut'),
	(410, 'Susu', 'dut'),
	(411, 'Sumerisch', 'dut'),
	(412, 'Swahili', 'dut'),
	(413, 'Zweeds', 'dut'),
	(414, 'Syrisch', 'dut'),
	(415, 'Tahitiaans', 'dut'),
	(416, 'Tai (Overig)', 'dut'),
	(417, 'Tamil', 'dut'),
	(418, 'Tataars', 'dut'),
	(419, 'Telugu', 'dut'),
	(420, 'Timnendere)', 'dut'),
	(421, 'Tereno', 'dut'),
	(422, 'Tetum', 'dut'),
	(423, 'Tadzjieks', 'dut'),
	(424, 'Tagalog', 'dut'),
	(425, 'Thai', 'dut'),
	(426, 'Tibetaans', 'dut'),
	(427, 'Tigre', 'dut'),
	(428, 'Tigrinya', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(429, 'Tiv', 'dut'),
	(430, 'Tokelau', 'dut'),
	(431, 'Klingon; tlhIngan-Hol', 'dut'),
	(432, 'Tlingit', 'dut'),
	(433, 'Tamashek', 'dut'),
	(434, 'Tonga (Nyasa)', 'dut'),
	(435, 'Tonga (Tonga-eilanden)', 'dut'),
	(436, 'Tok Pisin', 'dut'),
	(437, 'Tsimshian', 'dut'),
	(438, 'Tswana', 'dut'),
	(439, 'Tsonga', 'dut'),
	(440, 'Turkmeens', 'dut'),
	(441, 'Tumbuka', 'dut'),
	(442, 'Tupi talen', 'dut'),
	(443, 'Turks', 'dut'),
	(444, 'Altaïsch (Overig)', 'dut'),
	(445, 'Tuvalu', 'dut'),
	(446, 'Twi', 'dut'),
	(447, 'Tuviniaans', 'dut'),
	(448, 'Oedmoert', 'dut'),
	(449, 'Ugaritisch', 'dut'),
	(450, 'Oeigoers', 'dut'),
	(451, 'Oekraïens', 'dut'),
	(452, 'Umbundu', 'dut'),
	(453, 'Onbepaald', 'dut'),
	(454, 'Urdu', 'dut'),
	(455, 'Oezbeeks', 'dut'),
	(456, 'Vai', 'dut'),
	(457, 'Venda', 'dut'),
	(458, 'Vietnamees', 'dut'),
	(459, 'Volapük', 'dut'),
	(460, 'Votisch', 'dut'),
	(461, 'Wakashan-talen', 'dut'),
	(462, 'Walamo', 'dut'),
	(463, 'Waray', 'dut'),
	(464, 'Washo', 'dut'),
	(465, 'Welsh', 'dut'),
	(466, 'Sorbisch talent', 'dut'),
	(467, 'Waals', 'dut'),
	(468, 'Wolof', 'dut'),
	(469, 'Kalmyk; Oirat', 'dut'),
	(470, 'Xhosa', 'dut'),
	(471, 'Yao', 'dut'),
	(472, 'Yapese', 'dut'),
	(473, 'Jiddisch', 'dut'),
	(474, 'Yoruba', 'dut'),
	(475, 'Yupik talen', 'dut'),
	(476, 'Zapoteken', 'dut'),
	(477, 'Zenaga', 'dut'),
	(478, 'Zhuang; Chuang', 'dut');
INSERT INTO public.isolanguagesdes VALUES
	(479, 'Zande talen', 'dut'),
	(480, 'Zulu', 'dut'),
	(481, 'Zuni', 'dut'),
	(482, 'Geen taalkundige inhoud', 'dut'),
	(483, 'N''Ko', 'dut'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'dut'),
	(1, 'Afar', 'nor'),
	(2, 'Abkhazian', 'nor'),
	(3, 'Achinese', 'nor'),
	(4, 'Acoli', 'nor'),
	(5, 'Adangme', 'nor'),
	(6, 'Adyghe; Adygei', 'nor'),
	(7, 'Afro-Asiatic (Other)', 'nor'),
	(8, 'Afrihili', 'nor'),
	(9, 'Afrikaans', 'nor'),
	(10, 'Ainu', 'nor'),
	(11, 'Akan', 'nor'),
	(12, 'Akkadian', 'nor'),
	(13, 'Albanian', 'nor'),
	(14, 'Aleut', 'nor'),
	(15, 'Algonquian languages', 'nor'),
	(16, 'Southern Altai', 'nor'),
	(17, 'Amharic', 'nor'),
	(18, 'English, Old (ca.450-1100)', 'nor'),
	(19, 'Angika', 'nor'),
	(20, 'Apache languages', 'nor'),
	(21, 'Arabic', 'nor'),
	(22, 'Aramaic', 'nor'),
	(23, 'Aragonese', 'nor'),
	(24, 'Armenian', 'nor'),
	(25, 'Mapudungun; Mapuche', 'nor'),
	(26, 'Arapaho', 'nor'),
	(27, 'Artificial (Other)', 'nor'),
	(28, 'Arawak', 'nor'),
	(29, 'Assamese', 'nor'),
	(30, 'Asturian; Bable', 'nor'),
	(31, 'Athapascan languages', 'nor'),
	(32, 'Australian languages', 'nor'),
	(33, 'Avaric', 'nor'),
	(34, 'Avestan', 'nor'),
	(35, 'Awadhi', 'nor'),
	(36, 'Aymara', 'nor'),
	(37, 'Azerbaijani', 'nor'),
	(38, 'Banda languages', 'nor'),
	(39, 'Bamileke languages', 'nor'),
	(40, 'Bashkir', 'nor'),
	(41, 'Baluchi', 'nor'),
	(42, 'Bambara', 'nor'),
	(43, 'Balinese', 'nor'),
	(44, 'Basque', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(45, 'Basa', 'nor'),
	(46, 'Baltic (Other)', 'nor'),
	(47, 'Beja', 'nor'),
	(48, 'Belarusian', 'nor'),
	(49, 'Bemba', 'nor'),
	(50, 'Bengali', 'nor'),
	(51, 'Berber (Other)', 'nor'),
	(52, 'Bhojpuri', 'nor'),
	(53, 'Bihari', 'nor'),
	(54, 'Bikol', 'nor'),
	(55, 'Bini; Edo', 'nor'),
	(56, 'Bislama', 'nor'),
	(57, 'Siksika', 'nor'),
	(58, 'Bantu (Other)', 'nor'),
	(59, 'Bosnian', 'nor'),
	(60, 'Braj', 'nor'),
	(61, 'Breton', 'nor'),
	(62, 'Batak languages', 'nor'),
	(63, 'Buriat', 'nor'),
	(64, 'Buginese', 'nor'),
	(65, 'Bulgarian', 'nor'),
	(66, 'Burmese', 'nor'),
	(67, 'Blin; Bilin', 'nor'),
	(68, 'Caddo', 'nor'),
	(69, 'Central American Indian (Other)', 'nor'),
	(70, 'Galibi Carib', 'nor'),
	(71, 'Catalan; Valencian', 'nor'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'nor'),
	(73, 'Cebuano', 'nor'),
	(74, 'Celtic (Other)', 'nor'),
	(75, 'Chamorro', 'nor'),
	(76, 'Chibcha', 'nor'),
	(77, 'Chechen', 'nor'),
	(78, 'Chagataier)', 'nor'),
	(79, 'Chinese(Other)', 'nor'),
	(80, 'Chuukese', 'nor'),
	(81, 'Mari', 'nor'),
	(82, 'Chinook jargon', 'nor'),
	(83, 'Choctaw', 'nor'),
	(84, 'Chipewyan', 'nor'),
	(85, 'Cherokee', 'nor'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'nor'),
	(87, 'Chuvash', 'nor'),
	(88, 'Cheyenne', 'nor'),
	(89, 'Chamic languages', 'nor'),
	(90, 'Coptic', 'nor'),
	(91, 'Cornish', 'nor'),
	(92, 'Corsican', 'nor'),
	(93, 'Creoles and pidgins, English based (Ot', 'nor'),
	(94, 'Creoles and pidgins, French-based (Oth', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(95, 'Creoles and pidgins, Portuguese-based ', 'nor'),
	(96, 'Cree', 'nor'),
	(97, 'Crimean Tatar; Crimean Turkish', 'nor'),
	(98, 'Creoles and pidgins (Other)', 'nor'),
	(99, 'Kashubian', 'nor'),
	(100, 'Cushitic (Other)', 'nor'),
	(101, 'Czech', 'nor'),
	(102, 'Dakota', 'nor'),
	(103, 'Danish', 'nor'),
	(104, 'Dargwa', 'nor'),
	(105, 'Land Dayak languages', 'nor'),
	(106, 'Delaware', 'nor'),
	(107, 'Slave (Athapascan)', 'nor'),
	(108, 'Dogrib', 'nor'),
	(109, 'Dinka', 'nor'),
	(110, 'Divehi; Dhivehi; Maldivian', 'nor'),
	(111, 'Dogri', 'nor'),
	(112, 'Dravidian (Other)', 'nor'),
	(113, 'Lower Sorbian', 'nor'),
	(114, 'Duala', 'nor'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'nor'),
	(116, 'Dutch; Flemish', 'nor'),
	(117, 'Dyula', 'nor'),
	(118, 'Dzongkha', 'nor'),
	(119, 'Efik', 'nor'),
	(120, 'Egyptian (Ancient)', 'nor'),
	(121, 'Ekajuk', 'nor'),
	(122, 'Elamite', 'nor'),
	(123, 'English', 'nor'),
	(124, 'English, Middle (1100-1500)', 'nor'),
	(125, 'Esperanto', 'nor'),
	(126, 'Estonian', 'nor'),
	(127, 'Ewe', 'nor'),
	(128, 'Ewondo', 'nor'),
	(129, 'Fang', 'nor'),
	(130, 'Faroese', 'nor'),
	(131, 'Fanti', 'nor'),
	(132, 'Fijian', 'nor'),
	(133, 'Filipino; Pilipino', 'nor'),
	(134, 'Finnish', 'nor'),
	(135, 'Finno-Ugrian (Other)', 'nor'),
	(136, 'Fon', 'nor'),
	(137, 'French', 'nor'),
	(138, 'French, Middle (ca.1400-1600)', 'nor'),
	(139, 'French, Old (842-ca.1400)', 'nor'),
	(140, 'Northern Frisian', 'nor'),
	(141, 'Eastern Frisian', 'nor'),
	(142, 'Western Frisian', 'nor'),
	(143, 'Fulah', 'nor'),
	(144, 'Friulian', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(145, 'Ga', 'nor'),
	(146, 'Gayo', 'nor'),
	(147, 'Gbaya', 'nor'),
	(148, 'Germanic (Other)', 'nor'),
	(149, 'Georgian', 'nor'),
	(150, 'German', 'nor'),
	(151, 'Geez', 'nor'),
	(152, 'Gilbertese', 'nor'),
	(153, 'Gaelic; Scottish Gaelic', 'nor'),
	(154, 'Irish', 'nor'),
	(155, 'Galician', 'nor'),
	(156, 'Manx', 'nor'),
	(157, 'German, Middle High (ca.1050-1500)', 'nor'),
	(158, 'German, Old High (ca.750-1050)', 'nor'),
	(159, 'Gondi', 'nor'),
	(160, 'Gorontalo', 'nor'),
	(161, 'Gothicanguage Association)', 'nor'),
	(162, 'Grebo', 'nor'),
	(163, 'Greek, Ancient (to 1453)', 'nor'),
	(164, 'Greek, Modern (1453-)', 'nor'),
	(165, 'Guarani', 'nor'),
	(166, 'Swiss German; Alemannic', 'nor'),
	(167, 'Gujarati', 'nor'),
	(168, 'Gwich''in', 'nor'),
	(169, 'Haida', 'nor'),
	(170, 'Haitian; Haitian Creole', 'nor'),
	(171, 'Hausa', 'nor'),
	(172, 'Hawaiian', 'nor'),
	(173, 'Hebrew', 'nor'),
	(174, 'Herero', 'nor'),
	(175, 'Hiligaynon', 'nor'),
	(176, 'Himachali', 'nor'),
	(177, 'Hindi', 'nor'),
	(178, 'Hittite', 'nor'),
	(179, 'Hmong', 'nor'),
	(180, 'Hiri Motu', 'nor'),
	(181, 'Upper Sorbian', 'nor'),
	(182, 'Hungarian', 'nor'),
	(183, 'Hupa', 'nor'),
	(184, 'Iban', 'nor'),
	(185, 'Igbo', 'nor'),
	(186, 'Icelandic', 'nor'),
	(187, 'Ido', 'nor'),
	(188, 'Sichuan Yi', 'nor'),
	(189, 'Ijo languages', 'nor'),
	(190, 'Inuktitut', 'nor'),
	(191, 'Interlingue', 'nor'),
	(192, 'Iloko', 'nor'),
	(193, 'Interlingua (International Auxiliary L', 'nor'),
	(194, 'Indic (Other)', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(195, 'Indonesian', 'nor'),
	(196, 'Indo-European (Other)', 'nor'),
	(197, 'Ingush', 'nor'),
	(198, 'Inupiaq', 'nor'),
	(199, 'Iranian (Other)', 'nor'),
	(200, 'Iroquoian languages', 'nor'),
	(201, 'Italian', 'nor'),
	(202, 'Javanese', 'nor'),
	(203, 'Lojban', 'nor'),
	(204, 'Japanese', 'nor'),
	(205, 'Judeo-Persian', 'nor'),
	(206, 'Judeo-Arabic', 'nor'),
	(207, 'Kara-Kalpak', 'nor'),
	(208, 'Kabyle', 'nor'),
	(209, 'Kachin; Jingpho', 'nor'),
	(210, 'Kalaallisut; Greenlandic', 'nor'),
	(211, 'Kamba', 'nor'),
	(212, 'Kannada', 'nor'),
	(213, 'Karen languages', 'nor'),
	(214, 'Kashmiri', 'nor'),
	(215, 'Kanuri', 'nor'),
	(216, 'Kawi', 'nor'),
	(217, 'Kazakh', 'nor'),
	(218, 'Kabardian', 'nor'),
	(219, 'Khasi', 'nor'),
	(220, 'Khoisan (Other)', 'nor'),
	(221, 'Central Khmer', 'nor'),
	(222, 'Khotanese', 'nor'),
	(223, 'Kikuyu; Gikuyu', 'nor'),
	(224, 'Kinyarwanda', 'nor'),
	(225, 'Kirghiz; Kyrgyz', 'nor'),
	(226, 'Kimbundu', 'nor'),
	(227, 'Konkani', 'nor'),
	(228, 'Komi', 'nor'),
	(229, 'Kongo', 'nor'),
	(230, 'Korean', 'nor'),
	(231, 'Kosraean', 'nor'),
	(232, 'Kpelle', 'nor'),
	(233, 'Karachay-Balkar', 'nor'),
	(234, 'Karelian', 'nor'),
	(235, 'Kru languages', 'nor'),
	(236, 'Kurukh', 'nor'),
	(237, 'Kuanyama; Kwanyama', 'nor'),
	(238, 'Kumyk', 'nor'),
	(239, 'Kurdish', 'nor'),
	(240, 'Kutenai', 'nor'),
	(241, 'Ladino', 'nor'),
	(242, 'Lahnda', 'nor'),
	(243, 'Lamba', 'nor'),
	(244, 'Lao', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(245, 'Latin', 'nor'),
	(246, 'Latvian', 'nor'),
	(247, 'Lezghian', 'nor'),
	(248, 'Limburgan; Limburger; Limburgish', 'nor'),
	(249, 'Lingala', 'nor'),
	(250, 'Lithuanian', 'nor'),
	(251, 'Mongo', 'nor'),
	(252, 'Lozi', 'nor'),
	(253, 'Luxembourgish; Letzeburgesch', 'nor'),
	(254, 'Luba-Lulua', 'nor'),
	(255, 'Luba-Katangaxon, Low', 'nor'),
	(256, 'Ganda', 'nor'),
	(257, 'Luiseno', 'nor'),
	(258, 'Lunda', 'nor'),
	(259, 'Luo (Kenya and Tanzania)', 'nor'),
	(260, 'Lushai', 'nor'),
	(261, 'Macedonian00E5l', 'nor'),
	(262, 'Madurese', 'nor'),
	(263, 'Magahi', 'nor'),
	(264, 'Marshallese', 'nor'),
	(265, 'Maithili', 'nor'),
	(266, 'Makasarl Nepal Bhasa', 'nor'),
	(267, 'Malayalam', 'nor'),
	(268, 'Mandingo', 'nor'),
	(269, 'Maori', 'nor'),
	(270, 'Austronesian (Other)', 'nor'),
	(271, 'Marathi', 'nor'),
	(272, 'Masai', 'nor'),
	(273, 'Malay', 'nor'),
	(274, 'Moksha', 'nor'),
	(275, 'Mandar', 'nor'),
	(276, 'Mende', 'nor'),
	(277, 'Irish, Middle (900-1200)', 'nor'),
	(278, 'Mi''kmaq; Micmac', 'nor'),
	(279, 'Minangkabau', 'nor'),
	(280, 'Miscellaneous languages', 'nor'),
	(281, 'Mon-Khmer (Other)', 'nor'),
	(282, 'Malagasy', 'nor'),
	(283, 'Maltese', 'nor'),
	(284, 'Manchu', 'nor'),
	(285, 'Manipuri', 'nor'),
	(286, 'Manobo languages', 'nor'),
	(287, 'Mohawk', 'nor'),
	(288, 'Moldavian', 'nor'),
	(289, 'Mongolian', 'nor'),
	(290, 'Mossi', 'nor'),
	(291, 'Multiple languages', 'nor'),
	(292, 'Munda languages', 'nor'),
	(293, 'Creek', 'nor'),
	(294, 'Mirandese', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(295, 'Marwari', 'nor'),
	(296, 'Mayan languages', 'nor'),
	(297, 'Erzya', 'nor'),
	(298, 'Nahuatl languages', 'nor'),
	(299, 'North American Indian', 'nor'),
	(300, 'Neapolitan', 'nor'),
	(301, 'Nauru', 'nor'),
	(302, 'Navajo; Navaho', 'nor'),
	(303, 'Ndebele, South; South Ndebele', 'nor'),
	(304, 'Ndebele, North; North Ndebele', 'nor'),
	(305, 'Ndonga', 'nor'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'nor'),
	(307, 'Nepali', 'nor'),
	(308, 'Nepal Bhasa; Newari', 'nor'),
	(309, 'Nias', 'nor'),
	(310, 'Niger-Kordofanian (Other)', 'nor'),
	(311, 'Niuean', 'nor'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'nor'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'nor'),
	(314, 'Nogai', 'nor'),
	(315, 'Norse, Old', 'nor'),
	(316, 'Norwegian', 'nor'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'nor'),
	(318, 'Nubian languages', 'nor'),
	(319, 'Classical Newari; Old Newari; Classica', 'nor'),
	(320, 'Chichewa; Chewa; Nyanja', 'nor'),
	(321, 'Nyamwezi', 'nor'),
	(322, 'Nyankole', 'nor'),
	(323, 'Nyoro', 'nor'),
	(324, 'Nzima', 'nor'),
	(325, 'Occitan (post 1500); Provençal', 'nor'),
	(326, 'Ojibwa', 'nor'),
	(327, 'Oriya', 'nor'),
	(328, 'Oromo', 'nor'),
	(329, 'Osage', 'nor'),
	(330, 'Ossetian; Ossetic', 'nor'),
	(331, 'Turkish, Ottoman (1500-1928)', 'nor'),
	(332, 'Otomian languages', 'nor'),
	(333, 'Papuan (Other)', 'nor'),
	(334, 'Pangasinan', 'nor'),
	(335, 'Pahlavi', 'nor'),
	(336, 'Pampanga', 'nor'),
	(337, 'Panjabi; Punjabi', 'nor'),
	(338, 'Papiamento', 'nor'),
	(339, 'Palauan', 'nor'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'nor'),
	(341, 'Persian', 'nor'),
	(342, 'Philippine (Other)', 'nor'),
	(343, 'Phoenician', 'nor'),
	(344, 'Pali', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(345, 'Polish', 'nor'),
	(346, 'Pohnpeian', 'nor'),
	(347, 'Portuguese', 'nor'),
	(348, 'Prakrit languages', 'nor'),
	(349, 'Provençal, Old (to 1500)', 'nor'),
	(350, 'Pushto', 'nor'),
	(351, 'Reserved for local use', 'nor'),
	(352, 'Quechua', 'nor'),
	(353, 'Rajasthani', 'nor'),
	(354, 'Rapanui', 'nor'),
	(355, 'Rarotongan; Cook Islands Maori', 'nor'),
	(356, 'Romance (Other)', 'nor'),
	(357, 'Romansh', 'nor'),
	(358, 'Romany', 'nor'),
	(359, 'Romanian', 'nor'),
	(360, 'Rundi', 'nor'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'nor'),
	(362, 'Russian', 'nor'),
	(363, 'Sandawe', 'nor'),
	(364, 'Sango', 'nor'),
	(365, 'Yakut', 'nor'),
	(366, 'South American Indian (Other)', 'nor'),
	(367, 'Salishan languages', 'nor'),
	(368, 'Samaritan Aramaic', 'nor'),
	(369, 'Sanskrit', 'nor'),
	(370, 'Sasak', 'nor'),
	(371, 'Santali', 'nor'),
	(372, 'Serbian', 'nor'),
	(373, 'Sicilian', 'nor'),
	(374, 'Scots', 'nor'),
	(375, 'Croatian', 'nor'),
	(376, 'Selkup', 'nor'),
	(377, 'Semitic (Other)', 'nor'),
	(378, 'Irish, Old (to 900)', 'nor'),
	(379, 'Sign Languages', 'nor'),
	(380, 'Shan', 'nor'),
	(381, 'Sidamo', 'nor'),
	(382, 'Sinhala; Sinhalese', 'nor'),
	(383, 'Siouan languages', 'nor'),
	(384, 'Sino-Tibetan (Other)', 'nor'),
	(385, 'Slavic (Other)', 'nor'),
	(386, 'Slovak', 'nor'),
	(387, 'Slovenian', 'nor'),
	(388, 'Southern Sami', 'nor'),
	(389, 'Northern Sami', 'nor'),
	(390, 'Sami languages (Other)', 'nor'),
	(391, 'Lule Sami', 'nor'),
	(392, 'Inari Sami', 'nor'),
	(393, 'Samoan', 'nor'),
	(394, 'Skolt Sami', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(395, 'Shona', 'nor'),
	(396, 'Sindhi', 'nor'),
	(397, 'Soninke', 'nor'),
	(398, 'Sogdian', 'nor'),
	(399, 'Somali', 'nor'),
	(400, 'Songhai languages', 'nor'),
	(401, 'Sotho, Southern', 'nor'),
	(402, 'Spanish; Castilian', 'nor'),
	(403, 'Sardinian; Zazaki', 'nor'),
	(404, 'Sranan Tongo', 'nor'),
	(405, 'Serer', 'nor'),
	(406, 'Nilo-Saharan (Other)', 'nor'),
	(407, 'Swati', 'nor'),
	(408, 'Sukuma', 'nor'),
	(409, 'Sundanese', 'nor'),
	(410, 'Susu', 'nor'),
	(411, 'Sumerian', 'nor'),
	(412, 'Swahili', 'nor'),
	(413, 'Swedish', 'nor'),
	(414, 'Syriac', 'nor'),
	(415, 'Tahitian', 'nor'),
	(416, 'Tai (Other)', 'nor'),
	(417, 'Tamil', 'nor'),
	(418, 'Tatar', 'nor'),
	(419, 'Telugu', 'nor'),
	(420, 'Timnendere)', 'nor'),
	(421, 'Tereno', 'nor'),
	(422, 'Tetum', 'nor'),
	(423, 'Tajik', 'nor'),
	(424, 'Tagalog', 'nor'),
	(425, 'Thai', 'nor'),
	(426, 'Tibetan', 'nor'),
	(427, 'Tigre', 'nor'),
	(428, 'Tigrinya', 'nor'),
	(429, 'Tiv', 'nor'),
	(430, 'Tokelau', 'nor'),
	(431, 'Klingon; tlhIngan-Hol', 'nor'),
	(432, 'Tlingit', 'nor'),
	(433, 'Tamashek', 'nor'),
	(434, 'Tonga (Nyasa)', 'nor'),
	(435, 'Tonga (Tonga Islands)', 'nor'),
	(436, 'Tok Pisin', 'nor'),
	(437, 'Tsimshian', 'nor'),
	(438, 'Tswana', 'nor'),
	(439, 'Tsonga', 'nor'),
	(440, 'Turkmen', 'nor'),
	(441, 'Tumbuka', 'nor'),
	(442, 'Tupi languages', 'nor'),
	(443, 'Turkish', 'nor'),
	(444, 'Altaic (Other)', 'nor');
INSERT INTO public.isolanguagesdes VALUES
	(445, 'Tuvalu', 'nor'),
	(446, 'Twi', 'nor'),
	(447, 'Tuvinian', 'nor'),
	(448, 'Udmurt', 'nor'),
	(449, 'Ugaritic', 'nor'),
	(450, 'Uighur; Uyghur', 'nor'),
	(451, 'Ukrainian', 'nor'),
	(452, 'Umbundu', 'nor'),
	(453, 'Undetermined', 'nor'),
	(454, 'Urdu', 'nor'),
	(455, 'Uzbek', 'nor'),
	(456, 'Vai', 'nor'),
	(457, 'Venda', 'nor'),
	(458, 'Vietnamese', 'nor'),
	(459, 'Volapük', 'nor'),
	(460, 'Votic', 'nor'),
	(461, 'Wakashan languages', 'nor'),
	(462, 'Walamo', 'nor'),
	(463, 'Waray', 'nor'),
	(464, 'Washo', 'nor'),
	(465, 'Welsh', 'nor'),
	(466, 'Sorbian languages', 'nor'),
	(467, 'Walloon', 'nor'),
	(468, 'Wolof', 'nor'),
	(469, 'Kalmyk; Oirat', 'nor'),
	(470, 'Xhosa', 'nor'),
	(471, 'Yao', 'nor'),
	(472, 'Yapese', 'nor'),
	(473, 'Yiddish', 'nor'),
	(474, 'Yoruba', 'nor'),
	(475, 'Yupik languages', 'nor'),
	(476, 'Zapotec', 'nor'),
	(477, 'Zenaga', 'nor'),
	(478, 'Zhuang; Chuang', 'nor'),
	(479, 'Zande languages', 'nor'),
	(480, 'Zulu', 'nor'),
	(481, 'Zuni', 'nor'),
	(482, 'No linguistic content', 'nor'),
	(483, 'N''Ko', 'nor'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'nor'),
	(1, 'Afar', 'fin'),
	(2, 'Abkhazian', 'fin'),
	(3, 'Achinese', 'fin'),
	(4, 'Acoli', 'fin'),
	(5, 'Adangme', 'fin'),
	(6, 'Adyghe; Adygei', 'fin'),
	(7, 'Afro-Asiatic (Other)', 'fin'),
	(8, 'Afrihili', 'fin'),
	(9, 'Afrikaans', 'fin'),
	(10, 'Ainu', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(11, 'Akan', 'fin'),
	(12, 'Akkadian', 'fin'),
	(13, 'Albanian', 'fin'),
	(14, 'Aleut', 'fin'),
	(15, 'Algonquian languages', 'fin'),
	(16, 'Southern Altai', 'fin'),
	(17, 'Amharic', 'fin'),
	(18, 'English, Old (ca.450-1100)', 'fin'),
	(19, 'Angika', 'fin'),
	(20, 'Apache languages', 'fin'),
	(21, 'Arabic', 'fin'),
	(22, 'Aramaic', 'fin'),
	(23, 'Aragonese', 'fin'),
	(24, 'Armenian', 'fin'),
	(25, 'Mapudungun; Mapuche', 'fin'),
	(26, 'Arapaho', 'fin'),
	(27, 'Artificial (Other)', 'fin'),
	(28, 'Arawak', 'fin'),
	(29, 'Assamese', 'fin'),
	(30, 'Asturian; Bable', 'fin'),
	(31, 'Athapascan languages', 'fin'),
	(32, 'Australian languages', 'fin'),
	(33, 'Avaric', 'fin'),
	(34, 'Avestan', 'fin'),
	(35, 'Awadhi', 'fin'),
	(36, 'Aymara', 'fin'),
	(37, 'Azerbaijani', 'fin'),
	(38, 'Banda languages', 'fin'),
	(39, 'Bamileke languages', 'fin'),
	(40, 'Bashkir', 'fin'),
	(41, 'Baluchi', 'fin'),
	(42, 'Bambara', 'fin'),
	(43, 'Balinese', 'fin'),
	(44, 'Basque', 'fin'),
	(45, 'Basa', 'fin'),
	(46, 'Baltic (Other)', 'fin'),
	(47, 'Beja', 'fin'),
	(48, 'Belarusian', 'fin'),
	(49, 'Bemba', 'fin'),
	(50, 'Bengali', 'fin'),
	(51, 'Berber (Other)', 'fin'),
	(52, 'Bhojpuri', 'fin'),
	(53, 'Bihari', 'fin'),
	(54, 'Bikol', 'fin'),
	(55, 'Bini; Edo', 'fin'),
	(56, 'Bislama', 'fin'),
	(57, 'Siksika', 'fin'),
	(58, 'Bantu (Other)', 'fin'),
	(59, 'Bosnian', 'fin'),
	(60, 'Braj', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(61, 'Breton', 'fin'),
	(62, 'Batak languages', 'fin'),
	(63, 'Buriat', 'fin'),
	(64, 'Buginese', 'fin'),
	(65, 'Bulgarian', 'fin'),
	(66, 'Burmese', 'fin'),
	(67, 'Blin; Bilin', 'fin'),
	(68, 'Caddo', 'fin'),
	(69, 'Central American Indian (Other)', 'fin'),
	(70, 'Galibi Carib', 'fin'),
	(71, 'Catalan; Valencian', 'fin'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'fin'),
	(73, 'Cebuano', 'fin'),
	(74, 'Celtic (Other)', 'fin'),
	(75, 'Chamorro', 'fin'),
	(76, 'Chibcha', 'fin'),
	(77, 'Chechen', 'fin'),
	(78, 'Chagataier)', 'fin'),
	(79, 'Chinese(Other)', 'fin'),
	(80, 'Chuukese', 'fin'),
	(81, 'Mari', 'fin'),
	(82, 'Chinook jargon', 'fin'),
	(83, 'Choctaw', 'fin'),
	(84, 'Chipewyan', 'fin'),
	(85, 'Cherokee', 'fin'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'fin'),
	(87, 'Chuvash', 'fin'),
	(88, 'Cheyenne', 'fin'),
	(89, 'Chamic languages', 'fin'),
	(90, 'Coptic', 'fin'),
	(91, 'Cornish', 'fin'),
	(92, 'Corsican', 'fin'),
	(93, 'Creoles and pidgins, English based (Ot', 'fin'),
	(94, 'Creoles and pidgins, French-based (Oth', 'fin'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'fin'),
	(96, 'Cree', 'fin'),
	(97, 'Crimean Tatar; Crimean Turkish', 'fin'),
	(98, 'Creoles and pidgins (Other)', 'fin'),
	(99, 'Kashubian', 'fin'),
	(100, 'Cushitic (Other)', 'fin'),
	(101, 'Czech', 'fin'),
	(102, 'Dakota', 'fin'),
	(103, 'Danish', 'fin'),
	(104, 'Dargwa', 'fin'),
	(105, 'Land Dayak languages', 'fin'),
	(106, 'Delaware', 'fin'),
	(107, 'Slave (Athapascan)', 'fin'),
	(108, 'Dogrib', 'fin'),
	(109, 'Dinka', 'fin'),
	(110, 'Divehi; Dhivehi; Maldivian', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(111, 'Dogri', 'fin'),
	(112, 'Dravidian (Other)', 'fin'),
	(113, 'Lower Sorbian', 'fin'),
	(114, 'Duala', 'fin'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'fin'),
	(116, 'Dutch; Flemish', 'fin'),
	(117, 'Dyula', 'fin'),
	(118, 'Dzongkha', 'fin'),
	(119, 'Efik', 'fin'),
	(120, 'Egyptian (Ancient)', 'fin'),
	(121, 'Ekajuk', 'fin'),
	(122, 'Elamite', 'fin'),
	(123, 'English', 'fin'),
	(124, 'English, Middle (1100-1500)', 'fin'),
	(125, 'Esperanto', 'fin'),
	(126, 'Estonian', 'fin'),
	(127, 'Ewe', 'fin'),
	(128, 'Ewondo', 'fin'),
	(129, 'Fang', 'fin'),
	(130, 'Faroese', 'fin'),
	(131, 'Fanti', 'fin'),
	(132, 'Fijian', 'fin'),
	(133, 'Filipino; Pilipino', 'fin'),
	(134, 'Finnish', 'fin'),
	(135, 'Finno-Ugrian (Other)', 'fin'),
	(136, 'Fon', 'fin'),
	(137, 'French', 'fin'),
	(138, 'French, Middle (ca.1400-1600)', 'fin'),
	(139, 'French, Old (842-ca.1400)', 'fin'),
	(140, 'Northern Frisian', 'fin'),
	(141, 'Eastern Frisian', 'fin'),
	(142, 'Western Frisian', 'fin'),
	(143, 'Fulah', 'fin'),
	(144, 'Friulian', 'fin'),
	(145, 'Ga', 'fin'),
	(146, 'Gayo', 'fin'),
	(147, 'Gbaya', 'fin'),
	(148, 'Germanic (Other)', 'fin'),
	(149, 'Georgian', 'fin'),
	(150, 'German', 'fin'),
	(151, 'Geez', 'fin'),
	(152, 'Gilbertese', 'fin'),
	(153, 'Gaelic; Scottish Gaelic', 'fin'),
	(154, 'Irish', 'fin'),
	(155, 'Galician', 'fin'),
	(156, 'Manx', 'fin'),
	(157, 'German, Middle High (ca.1050-1500)', 'fin'),
	(158, 'German, Old High (ca.750-1050)', 'fin'),
	(159, 'Gondi', 'fin'),
	(160, 'Gorontalo', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(161, 'Gothicanguage Association)', 'fin'),
	(162, 'Grebo', 'fin'),
	(163, 'Greek, Ancient (to 1453)', 'fin'),
	(164, 'Greek, Modern (1453-)', 'fin'),
	(165, 'Guarani', 'fin'),
	(166, 'Swiss German; Alemannic', 'fin'),
	(167, 'Gujarati', 'fin'),
	(168, 'Gwich''in', 'fin'),
	(169, 'Haida', 'fin'),
	(170, 'Haitian; Haitian Creole', 'fin'),
	(171, 'Hausa', 'fin'),
	(172, 'Hawaiian', 'fin'),
	(173, 'Hebrew', 'fin'),
	(174, 'Herero', 'fin'),
	(175, 'Hiligaynon', 'fin'),
	(176, 'Himachali', 'fin'),
	(177, 'Hindi', 'fin'),
	(178, 'Hittite', 'fin'),
	(179, 'Hmong', 'fin'),
	(180, 'Hiri Motu', 'fin'),
	(181, 'Upper Sorbian', 'fin'),
	(182, 'Hungarian', 'fin'),
	(183, 'Hupa', 'fin'),
	(184, 'Iban', 'fin'),
	(185, 'Igbo', 'fin'),
	(186, 'Icelandic', 'fin'),
	(187, 'Ido', 'fin'),
	(188, 'Sichuan Yi', 'fin'),
	(189, 'Ijo languages', 'fin'),
	(190, 'Inuktitut', 'fin'),
	(191, 'Interlingue', 'fin'),
	(192, 'Iloko', 'fin'),
	(193, 'Interlingua (International Auxiliary L', 'fin'),
	(194, 'Indic (Other)', 'fin'),
	(195, 'Indonesian', 'fin'),
	(196, 'Indo-European (Other)', 'fin'),
	(197, 'Ingush', 'fin'),
	(198, 'Inupiaq', 'fin'),
	(199, 'Iranian (Other)', 'fin'),
	(200, 'Iroquoian languages', 'fin'),
	(201, 'Italian', 'fin'),
	(202, 'Javanese', 'fin'),
	(203, 'Lojban', 'fin'),
	(204, 'Japanese', 'fin'),
	(205, 'Judeo-Persian', 'fin'),
	(206, 'Judeo-Arabic', 'fin'),
	(207, 'Kara-Kalpak', 'fin'),
	(208, 'Kabyle', 'fin'),
	(209, 'Kachin; Jingpho', 'fin'),
	(210, 'Kalaallisut; Greenlandic', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(211, 'Kamba', 'fin'),
	(212, 'Kannada', 'fin'),
	(213, 'Karen languages', 'fin'),
	(214, 'Kashmiri', 'fin'),
	(215, 'Kanuri', 'fin'),
	(216, 'Kawi', 'fin'),
	(217, 'Kazakh', 'fin'),
	(218, 'Kabardian', 'fin'),
	(219, 'Khasi', 'fin'),
	(220, 'Khoisan (Other)', 'fin'),
	(221, 'Central Khmer', 'fin'),
	(222, 'Khotanese', 'fin'),
	(223, 'Kikuyu; Gikuyu', 'fin'),
	(224, 'Kinyarwanda', 'fin'),
	(225, 'Kirghiz; Kyrgyz', 'fin'),
	(226, 'Kimbundu', 'fin'),
	(227, 'Konkani', 'fin'),
	(228, 'Komi', 'fin'),
	(229, 'Kongo', 'fin'),
	(230, 'Korean', 'fin'),
	(231, 'Kosraean', 'fin'),
	(232, 'Kpelle', 'fin'),
	(233, 'Karachay-Balkar', 'fin'),
	(234, 'Karelian', 'fin'),
	(235, 'Kru languages', 'fin'),
	(236, 'Kurukh', 'fin'),
	(237, 'Kuanyama; Kwanyama', 'fin'),
	(238, 'Kumyk', 'fin'),
	(239, 'Kurdish', 'fin'),
	(240, 'Kutenai', 'fin'),
	(241, 'Ladino', 'fin'),
	(242, 'Lahnda', 'fin'),
	(243, 'Lamba', 'fin'),
	(244, 'Lao', 'fin'),
	(245, 'Latin', 'fin'),
	(246, 'Latvian', 'fin'),
	(247, 'Lezghian', 'fin'),
	(248, 'Limburgan; Limburger; Limburgish', 'fin'),
	(249, 'Lingala', 'fin'),
	(250, 'Lithuanian', 'fin'),
	(251, 'Mongo', 'fin'),
	(252, 'Lozi', 'fin'),
	(253, 'Luxembourgish; Letzeburgesch', 'fin'),
	(254, 'Luba-Lulua', 'fin'),
	(255, 'Luba-Katangaxon, Low', 'fin'),
	(256, 'Ganda', 'fin'),
	(257, 'Luiseno', 'fin'),
	(258, 'Lunda', 'fin'),
	(259, 'Luo (Kenya and Tanzania)', 'fin'),
	(260, 'Lushai', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(261, 'Macedonian00E5l', 'fin'),
	(262, 'Madurese', 'fin'),
	(263, 'Magahi', 'fin'),
	(264, 'Marshallese', 'fin'),
	(265, 'Maithili', 'fin'),
	(266, 'Makasarl Nepal Bhasa', 'fin'),
	(267, 'Malayalam', 'fin'),
	(268, 'Mandingo', 'fin'),
	(269, 'Maori', 'fin'),
	(270, 'Austronesian (Other)', 'fin'),
	(271, 'Marathi', 'fin'),
	(272, 'Masai', 'fin'),
	(273, 'Malay', 'fin'),
	(274, 'Moksha', 'fin'),
	(275, 'Mandar', 'fin'),
	(276, 'Mende', 'fin'),
	(277, 'Irish, Middle (900-1200)', 'fin'),
	(278, 'Mi''kmaq; Micmac', 'fin'),
	(279, 'Minangkabau', 'fin'),
	(280, 'Miscellaneous languages', 'fin'),
	(281, 'Mon-Khmer (Other)', 'fin'),
	(282, 'Malagasy', 'fin'),
	(283, 'Maltese', 'fin'),
	(284, 'Manchu', 'fin'),
	(285, 'Manipuri', 'fin'),
	(286, 'Manobo languages', 'fin'),
	(287, 'Mohawk', 'fin'),
	(288, 'Moldavian', 'fin'),
	(289, 'Mongolian', 'fin'),
	(290, 'Mossi', 'fin'),
	(291, 'Multiple languages', 'fin'),
	(292, 'Munda languages', 'fin'),
	(293, 'Creek', 'fin'),
	(294, 'Mirandese', 'fin'),
	(295, 'Marwari', 'fin'),
	(296, 'Mayan languages', 'fin'),
	(297, 'Erzya', 'fin'),
	(298, 'Nahuatl languages', 'fin'),
	(299, 'North American Indian', 'fin'),
	(300, 'Neapolitan', 'fin'),
	(301, 'Nauru', 'fin'),
	(302, 'Navajo; Navaho', 'fin'),
	(303, 'Ndebele, South; South Ndebele', 'fin'),
	(304, 'Ndebele, North; North Ndebele', 'fin'),
	(305, 'Ndonga', 'fin'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'fin'),
	(307, 'Nepali', 'fin'),
	(308, 'Nepal Bhasa; Newari', 'fin'),
	(309, 'Nias', 'fin'),
	(310, 'Niger-Kordofanian (Other)', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(311, 'Niuean', 'fin'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'fin'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'fin'),
	(314, 'Nogai', 'fin'),
	(315, 'Norse, Old', 'fin'),
	(316, 'Norwegian', 'fin'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'fin'),
	(318, 'Nubian languages', 'fin'),
	(319, 'Classical Newari; Old Newari; Classica', 'fin'),
	(320, 'Chichewa; Chewa; Nyanja', 'fin'),
	(321, 'Nyamwezi', 'fin'),
	(322, 'Nyankole', 'fin'),
	(323, 'Nyoro', 'fin'),
	(324, 'Nzima', 'fin'),
	(325, 'Occitan (post 1500); Provençal', 'fin'),
	(326, 'Ojibwa', 'fin'),
	(327, 'Oriya', 'fin'),
	(328, 'Oromo', 'fin'),
	(329, 'Osage', 'fin'),
	(330, 'Ossetian; Ossetic', 'fin'),
	(331, 'Turkish, Ottoman (1500-1928)', 'fin'),
	(332, 'Otomian languages', 'fin'),
	(333, 'Papuan (Other)', 'fin'),
	(334, 'Pangasinan', 'fin'),
	(335, 'Pahlavi', 'fin'),
	(336, 'Pampanga', 'fin'),
	(337, 'Panjabi; Punjabi', 'fin'),
	(338, 'Papiamento', 'fin'),
	(339, 'Palauan', 'fin'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'fin'),
	(341, 'Persian', 'fin'),
	(342, 'Philippine (Other)', 'fin'),
	(343, 'Phoenician', 'fin'),
	(344, 'Pali', 'fin'),
	(345, 'Polish', 'fin'),
	(346, 'Pohnpeian', 'fin'),
	(347, 'Portuguese', 'fin'),
	(348, 'Prakrit languages', 'fin'),
	(349, 'Provençal, Old (to 1500)', 'fin'),
	(350, 'Pushto', 'fin'),
	(351, 'Reserved for local use', 'fin'),
	(352, 'Quechua', 'fin'),
	(353, 'Rajasthani', 'fin'),
	(354, 'Rapanui', 'fin'),
	(355, 'Rarotongan; Cook Islands Maori', 'fin'),
	(356, 'Romance (Other)', 'fin'),
	(357, 'Romansh', 'fin'),
	(358, 'Romany', 'fin'),
	(359, 'Romanian', 'fin'),
	(360, 'Rundi', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'fin'),
	(362, 'Russian', 'fin'),
	(363, 'Sandawe', 'fin'),
	(364, 'Sango', 'fin'),
	(365, 'Yakut', 'fin'),
	(366, 'South American Indian (Other)', 'fin'),
	(367, 'Salishan languages', 'fin'),
	(368, 'Samaritan Aramaic', 'fin'),
	(369, 'Sanskrit', 'fin'),
	(370, 'Sasak', 'fin'),
	(371, 'Santali', 'fin'),
	(372, 'Serbian', 'fin'),
	(373, 'Sicilian', 'fin'),
	(374, 'Scots', 'fin'),
	(375, 'Croatian', 'fin'),
	(376, 'Selkup', 'fin'),
	(377, 'Semitic (Other)', 'fin'),
	(378, 'Irish, Old (to 900)', 'fin'),
	(379, 'Sign Languages', 'fin'),
	(380, 'Shan', 'fin'),
	(381, 'Sidamo', 'fin'),
	(382, 'Sinhala; Sinhalese', 'fin'),
	(383, 'Siouan languages', 'fin'),
	(384, 'Sino-Tibetan (Other)', 'fin'),
	(385, 'Slavic (Other)', 'fin'),
	(386, 'Slovak', 'fin'),
	(387, 'Slovenian', 'fin'),
	(388, 'Southern Sami', 'fin'),
	(389, 'Northern Sami', 'fin'),
	(390, 'Sami languages (Other)', 'fin'),
	(391, 'Lule Sami', 'fin'),
	(392, 'Inari Sami', 'fin'),
	(393, 'Samoan', 'fin'),
	(394, 'Skolt Sami', 'fin'),
	(395, 'Shona', 'fin'),
	(396, 'Sindhi', 'fin'),
	(397, 'Soninke', 'fin'),
	(398, 'Sogdian', 'fin'),
	(399, 'Somali', 'fin'),
	(400, 'Songhai languages', 'fin'),
	(401, 'Sotho, Southern', 'fin'),
	(402, 'Spanish; Castilian', 'fin'),
	(403, 'Sardinian; Zazaki', 'fin'),
	(404, 'Sranan Tongo', 'fin'),
	(405, 'Serer', 'fin'),
	(406, 'Nilo-Saharan (Other)', 'fin'),
	(407, 'Swati', 'fin'),
	(408, 'Sukuma', 'fin'),
	(409, 'Sundanese', 'fin'),
	(410, 'Susu', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(411, 'Sumerian', 'fin'),
	(412, 'Swahili', 'fin'),
	(413, 'Swedish', 'fin'),
	(414, 'Syriac', 'fin'),
	(415, 'Tahitian', 'fin'),
	(416, 'Tai (Other)', 'fin'),
	(417, 'Tamil', 'fin'),
	(418, 'Tatar', 'fin'),
	(419, 'Telugu', 'fin'),
	(420, 'Timnendere)', 'fin'),
	(421, 'Tereno', 'fin'),
	(422, 'Tetum', 'fin'),
	(423, 'Tajik', 'fin'),
	(424, 'Tagalog', 'fin'),
	(425, 'Thai', 'fin'),
	(426, 'Tibetan', 'fin'),
	(427, 'Tigre', 'fin'),
	(428, 'Tigrinya', 'fin'),
	(429, 'Tiv', 'fin'),
	(430, 'Tokelau', 'fin'),
	(431, 'Klingon; tlhIngan-Hol', 'fin'),
	(432, 'Tlingit', 'fin'),
	(433, 'Tamashek', 'fin'),
	(434, 'Tonga (Nyasa)', 'fin'),
	(435, 'Tonga (Tonga Islands)', 'fin'),
	(436, 'Tok Pisin', 'fin'),
	(437, 'Tsimshian', 'fin'),
	(438, 'Tswana', 'fin'),
	(439, 'Tsonga', 'fin'),
	(440, 'Turkmen', 'fin'),
	(441, 'Tumbuka', 'fin'),
	(442, 'Tupi languages', 'fin'),
	(443, 'Turkish', 'fin'),
	(444, 'Altaic (Other)', 'fin'),
	(445, 'Tuvalu', 'fin'),
	(446, 'Twi', 'fin'),
	(447, 'Tuvinian', 'fin'),
	(448, 'Udmurt', 'fin'),
	(449, 'Ugaritic', 'fin'),
	(450, 'Uighur; Uyghur', 'fin'),
	(451, 'Ukrainian', 'fin'),
	(452, 'Umbundu', 'fin'),
	(453, 'Undetermined', 'fin'),
	(454, 'Urdu', 'fin'),
	(455, 'Uzbek', 'fin'),
	(456, 'Vai', 'fin'),
	(457, 'Venda', 'fin'),
	(458, 'Vietnamese', 'fin'),
	(459, 'Volapük', 'fin'),
	(460, 'Votic', 'fin');
INSERT INTO public.isolanguagesdes VALUES
	(461, 'Wakashan languages', 'fin'),
	(462, 'Walamo', 'fin'),
	(463, 'Waray', 'fin'),
	(464, 'Washo', 'fin'),
	(465, 'Welsh', 'fin'),
	(466, 'Sorbian languages', 'fin'),
	(467, 'Walloon', 'fin'),
	(468, 'Wolof', 'fin'),
	(469, 'Kalmyk; Oirat', 'fin'),
	(470, 'Xhosa', 'fin'),
	(471, 'Yao', 'fin'),
	(472, 'Yapese', 'fin'),
	(473, 'Yiddish', 'fin'),
	(474, 'Yoruba', 'fin'),
	(475, 'Yupik languages', 'fin'),
	(476, 'Zapotec', 'fin'),
	(477, 'Zenaga', 'fin'),
	(478, 'Zhuang; Chuang', 'fin'),
	(479, 'Zande languages', 'fin'),
	(480, 'Zulu', 'fin'),
	(481, 'Zuni', 'fin'),
	(482, 'No linguistic content', 'fin'),
	(483, 'N''Ko', 'fin'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'fin'),
	(1, 'Afar', 'ara'),
	(2, 'Abkhazian', 'ara'),
	(3, 'Achinese', 'ara'),
	(4, 'Acoli', 'ara'),
	(5, 'Adangme', 'ara'),
	(6, 'Adyghe; Adygei', 'ara'),
	(7, 'Afro-Asiatic (Other)', 'ara'),
	(8, 'Afrihili', 'ara'),
	(9, 'Afrikaans', 'ara'),
	(10, 'Ainu', 'ara'),
	(11, 'Akan', 'ara'),
	(12, 'Akkadian', 'ara'),
	(13, 'Albanian', 'ara'),
	(14, 'Aleut', 'ara'),
	(15, 'Algonquian languages', 'ara'),
	(16, 'Southern Altai', 'ara'),
	(17, 'Amharic', 'ara'),
	(18, 'English, Old (ca.450-1100)', 'ara'),
	(19, 'Angika', 'ara'),
	(20, 'Apache languages', 'ara'),
	(21, 'Arabic', 'ara'),
	(22, 'Aramaic', 'ara'),
	(23, 'Aragonese', 'ara'),
	(24, 'Armenian', 'ara'),
	(25, 'Mapudungun; Mapuche', 'ara'),
	(26, 'Arapaho', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(27, 'Artificial (Other)', 'ara'),
	(28, 'Arawak', 'ara'),
	(29, 'Assamese', 'ara'),
	(30, 'Asturian; Bable', 'ara'),
	(31, 'Athapascan languages', 'ara'),
	(32, 'Australian languages', 'ara'),
	(33, 'Avaric', 'ara'),
	(34, 'Avestan', 'ara'),
	(35, 'Awadhi', 'ara'),
	(36, 'Aymara', 'ara'),
	(37, 'Azerbaijani', 'ara'),
	(38, 'Banda languages', 'ara'),
	(39, 'Bamileke languages', 'ara'),
	(40, 'Bashkir', 'ara'),
	(41, 'Baluchi', 'ara'),
	(42, 'Bambara', 'ara'),
	(43, 'Balinese', 'ara'),
	(44, 'Basque', 'ara'),
	(45, 'Basa', 'ara'),
	(46, 'Baltic (Other)', 'ara'),
	(47, 'Beja', 'ara'),
	(48, 'Belarusian', 'ara'),
	(49, 'Bemba', 'ara'),
	(50, 'Bengali', 'ara'),
	(51, 'Berber (Other)', 'ara'),
	(52, 'Bhojpuri', 'ara'),
	(53, 'Bihari', 'ara'),
	(54, 'Bikol', 'ara'),
	(55, 'Bini; Edo', 'ara'),
	(56, 'Bislama', 'ara'),
	(57, 'Siksika', 'ara'),
	(58, 'Bantu (Other)', 'ara'),
	(59, 'Bosnian', 'ara'),
	(60, 'Braj', 'ara'),
	(61, 'Breton', 'ara'),
	(62, 'Batak languages', 'ara'),
	(63, 'Buriat', 'ara'),
	(64, 'Buginese', 'ara'),
	(65, 'Bulgarian', 'ara'),
	(66, 'Burmese', 'ara'),
	(67, 'Blin; Bilin', 'ara'),
	(68, 'Caddo', 'ara'),
	(69, 'Central American Indian (Other)', 'ara'),
	(70, 'Galibi Carib', 'ara'),
	(71, 'Catalan; Valencian', 'ara'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'ara'),
	(73, 'Cebuano', 'ara'),
	(74, 'Celtic (Other)', 'ara'),
	(75, 'Chamorro', 'ara'),
	(76, 'Chibcha', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(77, 'Chechen', 'ara'),
	(78, 'Chagataier)', 'ara'),
	(79, 'Chinese(Other)', 'ara'),
	(80, 'Chuukese', 'ara'),
	(81, 'Mari', 'ara'),
	(82, 'Chinook jargon', 'ara'),
	(83, 'Choctaw', 'ara'),
	(84, 'Chipewyan', 'ara'),
	(85, 'Cherokee', 'ara'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'ara'),
	(87, 'Chuvash', 'ara'),
	(88, 'Cheyenne', 'ara'),
	(89, 'Chamic languages', 'ara'),
	(90, 'Coptic', 'ara'),
	(91, 'Cornish', 'ara'),
	(92, 'Corsican', 'ara'),
	(93, 'Creoles and pidgins, English based (Ot', 'ara'),
	(94, 'Creoles and pidgins, French-based (Oth', 'ara'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'ara'),
	(96, 'Cree', 'ara'),
	(97, 'Crimean Tatar; Crimean Turkish', 'ara'),
	(98, 'Creoles and pidgins (Other)', 'ara'),
	(99, 'Kashubian', 'ara'),
	(100, 'Cushitic (Other)', 'ara'),
	(101, 'Czech', 'ara'),
	(102, 'Dakota', 'ara'),
	(103, 'Danish', 'ara'),
	(104, 'Dargwa', 'ara'),
	(105, 'Land Dayak languages', 'ara'),
	(106, 'Delaware', 'ara'),
	(107, 'Slave (Athapascan)', 'ara'),
	(108, 'Dogrib', 'ara'),
	(109, 'Dinka', 'ara'),
	(110, 'Divehi; Dhivehi; Maldivian', 'ara'),
	(111, 'Dogri', 'ara'),
	(112, 'Dravidian (Other)', 'ara'),
	(113, 'Lower Sorbian', 'ara'),
	(114, 'Duala', 'ara'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'ara'),
	(116, 'Dutch; Flemish', 'ara'),
	(117, 'Dyula', 'ara'),
	(118, 'Dzongkha', 'ara'),
	(119, 'Efik', 'ara'),
	(120, 'Egyptian (Ancient)', 'ara'),
	(121, 'Ekajuk', 'ara'),
	(122, 'Elamite', 'ara'),
	(123, 'English', 'ara'),
	(124, 'English, Middle (1100-1500)', 'ara'),
	(125, 'Esperanto', 'ara'),
	(126, 'Estonian', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(127, 'Ewe', 'ara'),
	(128, 'Ewondo', 'ara'),
	(129, 'Fang', 'ara'),
	(130, 'Faroese', 'ara'),
	(131, 'Fanti', 'ara'),
	(132, 'Fijian', 'ara'),
	(133, 'Filipino; Pilipino', 'ara'),
	(134, 'Finnish', 'ara'),
	(135, 'Finno-Ugrian (Other)', 'ara'),
	(136, 'Fon', 'ara'),
	(137, 'French', 'ara'),
	(138, 'French, Middle (ca.1400-1600)', 'ara'),
	(139, 'French, Old (842-ca.1400)', 'ara'),
	(140, 'Northern Frisian', 'ara'),
	(141, 'Eastern Frisian', 'ara'),
	(142, 'Western Frisian', 'ara'),
	(143, 'Fulah', 'ara'),
	(144, 'Friulian', 'ara'),
	(145, 'Ga', 'ara'),
	(146, 'Gayo', 'ara'),
	(147, 'Gbaya', 'ara'),
	(148, 'Germanic (Other)', 'ara'),
	(149, 'Georgian', 'ara'),
	(150, 'German', 'ara'),
	(151, 'Geez', 'ara'),
	(152, 'Gilbertese', 'ara'),
	(153, 'Gaelic; Scottish Gaelic', 'ara'),
	(154, 'Irish', 'ara'),
	(155, 'Galician', 'ara'),
	(156, 'Manx', 'ara'),
	(157, 'German, Middle High (ca.1050-1500)', 'ara'),
	(158, 'German, Old High (ca.750-1050)', 'ara'),
	(159, 'Gondi', 'ara'),
	(160, 'Gorontalo', 'ara'),
	(161, 'Gothicanguage Association)', 'ara'),
	(162, 'Grebo', 'ara'),
	(163, 'Greek, Ancient (to 1453)', 'ara'),
	(164, 'Greek, Modern (1453-)', 'ara'),
	(165, 'Guarani', 'ara'),
	(166, 'Swiss German; Alemannic', 'ara'),
	(167, 'Gujarati', 'ara'),
	(168, 'Gwich''in', 'ara'),
	(169, 'Haida', 'ara'),
	(170, 'Haitian; Haitian Creole', 'ara'),
	(171, 'Hausa', 'ara'),
	(172, 'Hawaiian', 'ara'),
	(173, 'Hebrew', 'ara'),
	(174, 'Herero', 'ara'),
	(175, 'Hiligaynon', 'ara'),
	(176, 'Himachali', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(177, 'Hindi', 'ara'),
	(178, 'Hittite', 'ara'),
	(179, 'Hmong', 'ara'),
	(180, 'Hiri Motu', 'ara'),
	(181, 'Upper Sorbian', 'ara'),
	(182, 'Hungarian', 'ara'),
	(183, 'Hupa', 'ara'),
	(184, 'Iban', 'ara'),
	(185, 'Igbo', 'ara'),
	(186, 'Icelandic', 'ara'),
	(187, 'Ido', 'ara'),
	(188, 'Sichuan Yi', 'ara'),
	(189, 'Ijo languages', 'ara'),
	(190, 'Inuktitut', 'ara'),
	(191, 'Interlingue', 'ara'),
	(192, 'Iloko', 'ara'),
	(193, 'Interlingua (International Auxiliary L', 'ara'),
	(194, 'Indic (Other)', 'ara'),
	(195, 'Indonesian', 'ara'),
	(196, 'Indo-European (Other)', 'ara'),
	(197, 'Ingush', 'ara'),
	(198, 'Inupiaq', 'ara'),
	(199, 'Iranian (Other)', 'ara'),
	(200, 'Iroquoian languages', 'ara'),
	(201, 'Italian', 'ara'),
	(202, 'Javanese', 'ara'),
	(203, 'Lojban', 'ara'),
	(204, 'Japanese', 'ara'),
	(205, 'Judeo-Persian', 'ara'),
	(206, 'Judeo-Arabic', 'ara'),
	(207, 'Kara-Kalpak', 'ara'),
	(208, 'Kabyle', 'ara'),
	(209, 'Kachin; Jingpho', 'ara'),
	(210, 'Kalaallisut; Greenlandic', 'ara'),
	(211, 'Kamba', 'ara'),
	(212, 'Kannada', 'ara'),
	(213, 'Karen languages', 'ara'),
	(214, 'Kashmiri', 'ara'),
	(215, 'Kanuri', 'ara'),
	(216, 'Kawi', 'ara'),
	(217, 'Kazakh', 'ara'),
	(218, 'Kabardian', 'ara'),
	(219, 'Khasi', 'ara'),
	(220, 'Khoisan (Other)', 'ara'),
	(221, 'Central Khmer', 'ara'),
	(222, 'Khotanese', 'ara'),
	(223, 'Kikuyu; Gikuyu', 'ara'),
	(224, 'Kinyarwanda', 'ara'),
	(225, 'Kirghiz; Kyrgyz', 'ara'),
	(226, 'Kimbundu', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(227, 'Konkani', 'ara'),
	(228, 'Komi', 'ara'),
	(229, 'Kongo', 'ara'),
	(230, 'Korean', 'ara'),
	(231, 'Kosraean', 'ara'),
	(232, 'Kpelle', 'ara'),
	(233, 'Karachay-Balkar', 'ara'),
	(234, 'Karelian', 'ara'),
	(235, 'Kru languages', 'ara'),
	(236, 'Kurukh', 'ara'),
	(237, 'Kuanyama; Kwanyama', 'ara'),
	(238, 'Kumyk', 'ara'),
	(239, 'Kurdish', 'ara'),
	(240, 'Kutenai', 'ara'),
	(241, 'Ladino', 'ara'),
	(242, 'Lahnda', 'ara'),
	(243, 'Lamba', 'ara'),
	(244, 'Lao', 'ara'),
	(245, 'Latin', 'ara'),
	(246, 'Latvian', 'ara'),
	(247, 'Lezghian', 'ara'),
	(248, 'Limburgan; Limburger; Limburgish', 'ara'),
	(249, 'Lingala', 'ara'),
	(250, 'Lithuanian', 'ara'),
	(251, 'Mongo', 'ara'),
	(252, 'Lozi', 'ara'),
	(253, 'Luxembourgish; Letzeburgesch', 'ara'),
	(254, 'Luba-Lulua', 'ara'),
	(255, 'Luba-Katangaxon, Low', 'ara'),
	(256, 'Ganda', 'ara'),
	(257, 'Luiseno', 'ara'),
	(258, 'Lunda', 'ara'),
	(259, 'Luo (Kenya and Tanzania)', 'ara'),
	(260, 'Lushai', 'ara'),
	(261, 'Macedonian00E5l', 'ara'),
	(262, 'Madurese', 'ara'),
	(263, 'Magahi', 'ara'),
	(264, 'Marshallese', 'ara'),
	(265, 'Maithili', 'ara'),
	(266, 'Makasarl Nepal Bhasa', 'ara'),
	(267, 'Malayalam', 'ara'),
	(268, 'Mandingo', 'ara'),
	(269, 'Maori', 'ara'),
	(270, 'Austronesian (Other)', 'ara'),
	(271, 'Marathi', 'ara'),
	(272, 'Masai', 'ara'),
	(273, 'Malay', 'ara'),
	(274, 'Moksha', 'ara'),
	(275, 'Mandar', 'ara'),
	(276, 'Mende', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(277, 'Irish, Middle (900-1200)', 'ara'),
	(278, 'Mi''kmaq; Micmac', 'ara'),
	(279, 'Minangkabau', 'ara'),
	(280, 'Miscellaneous languages', 'ara'),
	(281, 'Mon-Khmer (Other)', 'ara'),
	(282, 'Malagasy', 'ara'),
	(283, 'Maltese', 'ara'),
	(284, 'Manchu', 'ara'),
	(285, 'Manipuri', 'ara'),
	(286, 'Manobo languages', 'ara'),
	(287, 'Mohawk', 'ara'),
	(288, 'Moldavian', 'ara'),
	(289, 'Mongolian', 'ara'),
	(290, 'Mossi', 'ara'),
	(291, 'Multiple languages', 'ara'),
	(292, 'Munda languages', 'ara'),
	(293, 'Creek', 'ara'),
	(294, 'Mirandese', 'ara'),
	(295, 'Marwari', 'ara'),
	(296, 'Mayan languages', 'ara'),
	(297, 'Erzya', 'ara'),
	(298, 'Nahuatl languages', 'ara'),
	(299, 'North American Indian', 'ara'),
	(300, 'Neapolitan', 'ara'),
	(301, 'Nauru', 'ara'),
	(302, 'Navajo; Navaho', 'ara'),
	(303, 'Ndebele, South; South Ndebele', 'ara'),
	(304, 'Ndebele, North; North Ndebele', 'ara'),
	(305, 'Ndonga', 'ara'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'ara'),
	(307, 'Nepali', 'ara'),
	(308, 'Nepal Bhasa; Newari', 'ara'),
	(309, 'Nias', 'ara'),
	(310, 'Niger-Kordofanian (Other)', 'ara'),
	(311, 'Niuean', 'ara'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'ara'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'ara'),
	(314, 'Nogai', 'ara'),
	(315, 'Norse, Old', 'ara'),
	(316, 'Norwegian', 'ara'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'ara'),
	(318, 'Nubian languages', 'ara'),
	(319, 'Classical Newari; Old Newari; Classica', 'ara'),
	(320, 'Chichewa; Chewa; Nyanja', 'ara'),
	(321, 'Nyamwezi', 'ara'),
	(322, 'Nyankole', 'ara'),
	(323, 'Nyoro', 'ara'),
	(324, 'Nzima', 'ara'),
	(325, 'Occitan (post 1500); Provençal', 'ara'),
	(326, 'Ojibwa', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(327, 'Oriya', 'ara'),
	(328, 'Oromo', 'ara'),
	(329, 'Osage', 'ara'),
	(330, 'Ossetian; Ossetic', 'ara'),
	(331, 'Turkish, Ottoman (1500-1928)', 'ara'),
	(332, 'Otomian languages', 'ara'),
	(333, 'Papuan (Other)', 'ara'),
	(334, 'Pangasinan', 'ara'),
	(335, 'Pahlavi', 'ara'),
	(336, 'Pampanga', 'ara'),
	(337, 'Panjabi; Punjabi', 'ara'),
	(338, 'Papiamento', 'ara'),
	(339, 'Palauan', 'ara'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'ara'),
	(341, 'Persian', 'ara'),
	(342, 'Philippine (Other)', 'ara'),
	(343, 'Phoenician', 'ara'),
	(344, 'Pali', 'ara'),
	(345, 'Polish', 'ara'),
	(346, 'Pohnpeian', 'ara'),
	(347, 'Portuguese', 'ara'),
	(348, 'Prakrit languages', 'ara'),
	(349, 'Provençal, Old (to 1500)', 'ara'),
	(350, 'Pushto', 'ara'),
	(351, 'Reserved for local use', 'ara'),
	(352, 'Quechua', 'ara'),
	(353, 'Rajasthani', 'ara'),
	(354, 'Rapanui', 'ara'),
	(355, 'Rarotongan; Cook Islands Maori', 'ara'),
	(356, 'Romance (Other)', 'ara'),
	(357, 'Romansh', 'ara'),
	(358, 'Romany', 'ara'),
	(359, 'Romanian', 'ara'),
	(360, 'Rundi', 'ara'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'ara'),
	(362, 'Russian', 'ara'),
	(363, 'Sandawe', 'ara'),
	(364, 'Sango', 'ara'),
	(365, 'Yakut', 'ara'),
	(366, 'South American Indian (Other)', 'ara'),
	(367, 'Salishan languages', 'ara'),
	(368, 'Samaritan Aramaic', 'ara'),
	(369, 'Sanskrit', 'ara'),
	(370, 'Sasak', 'ara'),
	(371, 'Santali', 'ara'),
	(372, 'Serbian', 'ara'),
	(373, 'Sicilian', 'ara'),
	(374, 'Scots', 'ara'),
	(375, 'Croatian', 'ara'),
	(376, 'Selkup', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(377, 'Semitic (Other)', 'ara'),
	(378, 'Irish, Old (to 900)', 'ara'),
	(379, 'Sign Languages', 'ara'),
	(380, 'Shan', 'ara'),
	(381, 'Sidamo', 'ara'),
	(382, 'Sinhala; Sinhalese', 'ara'),
	(383, 'Siouan languages', 'ara'),
	(384, 'Sino-Tibetan (Other)', 'ara'),
	(385, 'Slavic (Other)', 'ara'),
	(386, 'Slovak', 'ara'),
	(387, 'Slovenian', 'ara'),
	(388, 'Southern Sami', 'ara'),
	(389, 'Northern Sami', 'ara'),
	(390, 'Sami languages (Other)', 'ara'),
	(391, 'Lule Sami', 'ara'),
	(392, 'Inari Sami', 'ara'),
	(393, 'Samoan', 'ara'),
	(394, 'Skolt Sami', 'ara'),
	(395, 'Shona', 'ara'),
	(396, 'Sindhi', 'ara'),
	(397, 'Soninke', 'ara'),
	(398, 'Sogdian', 'ara'),
	(399, 'Somali', 'ara'),
	(400, 'Songhai languages', 'ara'),
	(401, 'Sotho, Southern', 'ara'),
	(402, 'Spanish; Castilian', 'ara'),
	(403, 'Sardinian; Zazaki', 'ara'),
	(404, 'Sranan Tongo', 'ara'),
	(405, 'Serer', 'ara'),
	(406, 'Nilo-Saharan (Other)', 'ara'),
	(407, 'Swati', 'ara'),
	(408, 'Sukuma', 'ara'),
	(409, 'Sundanese', 'ara'),
	(410, 'Susu', 'ara'),
	(411, 'Sumerian', 'ara'),
	(412, 'Swahili', 'ara'),
	(413, 'Swedish', 'ara'),
	(414, 'Syriac', 'ara'),
	(415, 'Tahitian', 'ara'),
	(416, 'Tai (Other)', 'ara'),
	(417, 'Tamil', 'ara'),
	(418, 'Tatar', 'ara'),
	(419, 'Telugu', 'ara'),
	(420, 'Timnendere)', 'ara'),
	(421, 'Tereno', 'ara'),
	(422, 'Tetum', 'ara'),
	(423, 'Tajik', 'ara'),
	(424, 'Tagalog', 'ara'),
	(425, 'Thai', 'ara'),
	(426, 'Tibetan', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(427, 'Tigre', 'ara'),
	(428, 'Tigrinya', 'ara'),
	(429, 'Tiv', 'ara'),
	(430, 'Tokelau', 'ara'),
	(431, 'Klingon; tlhIngan-Hol', 'ara'),
	(432, 'Tlingit', 'ara'),
	(433, 'Tamashek', 'ara'),
	(434, 'Tonga (Nyasa)', 'ara'),
	(435, 'Tonga (Tonga Islands)', 'ara'),
	(436, 'Tok Pisin', 'ara'),
	(437, 'Tsimshian', 'ara'),
	(438, 'Tswana', 'ara'),
	(439, 'Tsonga', 'ara'),
	(440, 'Turkmen', 'ara'),
	(441, 'Tumbuka', 'ara'),
	(442, 'Tupi languages', 'ara'),
	(443, 'Turkish', 'ara'),
	(444, 'Altaic (Other)', 'ara'),
	(445, 'Tuvalu', 'ara'),
	(446, 'Twi', 'ara'),
	(447, 'Tuvinian', 'ara'),
	(448, 'Udmurt', 'ara'),
	(449, 'Ugaritic', 'ara'),
	(450, 'Uighur; Uyghur', 'ara'),
	(451, 'Ukrainian', 'ara'),
	(452, 'Umbundu', 'ara'),
	(453, 'Undetermined', 'ara'),
	(454, 'Urdu', 'ara'),
	(455, 'Uzbek', 'ara'),
	(456, 'Vai', 'ara'),
	(457, 'Venda', 'ara'),
	(458, 'Vietnamese', 'ara'),
	(459, 'Volapük', 'ara'),
	(460, 'Votic', 'ara'),
	(461, 'Wakashan languages', 'ara'),
	(462, 'Walamo', 'ara'),
	(463, 'Waray', 'ara'),
	(464, 'Washo', 'ara'),
	(465, 'Welsh', 'ara'),
	(466, 'Sorbian languages', 'ara'),
	(467, 'Walloon', 'ara'),
	(468, 'Wolof', 'ara'),
	(469, 'Kalmyk; Oirat', 'ara'),
	(470, 'Xhosa', 'ara'),
	(471, 'Yao', 'ara'),
	(472, 'Yapese', 'ara'),
	(473, 'Yiddish', 'ara'),
	(474, 'Yoruba', 'ara'),
	(475, 'Yupik languages', 'ara'),
	(476, 'Zapotec', 'ara');
INSERT INTO public.isolanguagesdes VALUES
	(477, 'Zenaga', 'ara'),
	(478, 'Zhuang; Chuang', 'ara'),
	(479, 'Zande languages', 'ara'),
	(480, 'Zulu', 'ara'),
	(481, 'Zuni', 'ara'),
	(482, 'No linguistic content', 'ara'),
	(483, 'N''Ko', 'ara'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'ara'),
	(1, 'Afar', 'ita'),
	(2, 'Abkhazian', 'ita'),
	(3, 'Achinese', 'ita'),
	(4, 'Acioli', 'ita'),
	(5, 'Adangme', 'ita'),
	(6, 'Adyghe; Adygei', 'ita'),
	(7, 'Afro-asiatiche, Lingue', 'ita'),
	(8, 'Afrihili', 'ita'),
	(9, 'Afrikaans', 'ita'),
	(10, 'Ainu', 'ita'),
	(11, 'Akan', 'ita'),
	(12, 'Accadiano', 'ita'),
	(13, 'Albanese', 'ita'),
	(14, 'Aleut', 'ita'),
	(15, 'Algonchine, Lingue', 'ita'),
	(16, 'Altai del Sud', 'ita'),
	(17, 'Amarico', 'ita'),
	(18, 'Inglese antico (ca.450-1100)', 'ita'),
	(19, 'Angika', 'ita'),
	(20, 'Apache, Lingue', 'ita'),
	(21, 'Arabo', 'ita'),
	(22, 'Aramaico ufficiale (700-300 AC); Aramaico Imperiale (700-300 AC)', 'ita'),
	(23, 'Aragonese', 'ita'),
	(24, 'Armeno', 'ita'),
	(25, 'Mapudungun; Mapuche', 'ita'),
	(26, 'Arapaho', 'ita'),
	(27, 'Lingue artificiali', 'ita'),
	(28, 'Arawak', 'ita'),
	(29, 'Assamese', 'ita'),
	(30, 'Asturiano; Bable; Leonese; Asturiano-Leonese', 'ita'),
	(31, 'Lingue Athapascan', 'ita'),
	(32, 'Australi, Lingue', 'ita'),
	(33, 'Avarico', 'ita'),
	(34, 'Avestan', 'ita'),
	(35, 'Awadhi', 'ita'),
	(36, 'Aymara', 'ita'),
	(37, 'Azero', 'ita'),
	(38, 'Lingue Banda', 'ita'),
	(39, 'Lingue Bamileke', 'ita'),
	(40, 'Baschiro', 'ita'),
	(41, 'Beluci', 'ita'),
	(42, 'Bambara', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(43, 'Balinese', 'ita'),
	(44, 'Basco', 'ita'),
	(45, 'Basa', 'ita'),
	(46, 'Baltiche, Lingue', 'ita'),
	(47, 'Beja', 'ita'),
	(48, 'Bielorusso', 'ita'),
	(49, 'Bemba', 'ita'),
	(50, 'Bengalese', 'ita'),
	(51, 'Berbere, Lingue', 'ita'),
	(52, 'Bhojpuri', 'ita'),
	(53, 'Lingue bihari', 'ita'),
	(54, 'Bikol', 'ita'),
	(55, 'Bini; Edo', 'ita'),
	(56, 'Bislama', 'ita'),
	(57, 'Siksika', 'ita'),
	(58, 'Lingue bantu', 'ita'),
	(59, 'Bosniaco', 'ita'),
	(60, 'Braj', 'ita'),
	(61, 'Bretone', 'ita'),
	(62, 'Lingue Batak', 'ita'),
	(63, 'Buriat', 'ita'),
	(64, 'Buginese', 'ita'),
	(65, 'Bulgaro', 'ita'),
	(66, 'Burmese', 'ita'),
	(67, 'Blin; Bilin', 'ita'),
	(68, 'Caddo', 'ita'),
	(69, 'Lingue indiane dell''America Centrale', 'ita'),
	(70, 'Galibi Carib', 'ita'),
	(71, 'Catalano; Valenciano', 'ita'),
	(72, 'Caucasiche, Lingue', 'ita'),
	(73, 'Cebuano', 'ita'),
	(74, 'Celtiche, Lingue', 'ita'),
	(75, 'Chamorro', 'ita'),
	(76, 'Chibcha', 'ita'),
	(77, 'Ceceno', 'ita'),
	(78, 'Ciagataica', 'ita'),
	(79, 'Cinese (altro)', 'ita'),
	(80, 'Chuukese', 'ita'),
	(81, 'Mari', 'ita'),
	(82, 'Gergo Chinook', 'ita'),
	(83, 'Choctaw', 'ita'),
	(84, 'Chipewyan', 'ita'),
	(85, 'Cherokee', 'ita'),
	(86, 'Slavo antico; Slavonico ecclesiastico; Bulgaro antico; Slavonico ecclesiastico antico', 'ita'),
	(87, 'Chuvash', 'ita'),
	(88, 'Cheyenne', 'ita'),
	(89, 'Lingue chamic', 'ita'),
	(90, 'Copto', 'ita'),
	(91, 'Cornish', 'ita'),
	(92, 'Corso', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(93, 'Creolo e pidgin, basate sull''inglese', 'ita'),
	(94, 'Creolo e pidgin, basate sul francese', 'ita'),
	(95, 'Creolo e pidgin, basate sul portoghese', 'ita'),
	(96, 'Cree', 'ita'),
	(97, 'Tatar crimeo; Turco crimeo', 'ita'),
	(98, 'Creolo e pidgin', 'ita'),
	(99, 'Kashubian', 'ita'),
	(100, 'Cuscitiche, Lingue', 'ita'),
	(101, 'Ceco', 'ita'),
	(102, 'Dakota', 'ita'),
	(103, 'Danese', 'ita'),
	(104, 'Dargwa', 'ita'),
	(105, 'Dayak, Lingue della terra di', 'ita'),
	(106, 'Delaware', 'ita'),
	(107, 'Slave (Athapascano)', 'ita'),
	(108, 'Dogrib', 'ita'),
	(109, 'Dinca', 'ita'),
	(110, 'Divehi; Dhivehi; Maldiviano', 'ita'),
	(111, 'Dogri', 'ita'),
	(112, 'Lingue dravidiane', 'ita'),
	(113, 'Sorabo inferiore', 'ita'),
	(114, 'Duala', 'ita'),
	(115, 'Olandese medio (ca.1050-1350)', 'ita'),
	(116, 'Olandese; Fiammingo', 'ita'),
	(117, 'Diula', 'ita'),
	(118, 'Dzongkha', 'ita'),
	(119, 'Efik', 'ita'),
	(120, 'Egiziano (Antico)', 'ita'),
	(121, 'Ekajuk', 'ita'),
	(122, 'Elamitico', 'ita'),
	(123, 'Inglese', 'ita'),
	(124, 'Inglese medio (1100-1500)', 'ita'),
	(125, 'Esperanto', 'ita'),
	(126, 'Estone', 'ita'),
	(127, 'Ewe', 'ita'),
	(128, 'Ewondo', 'ita'),
	(129, 'Fang', 'ita'),
	(130, 'Faroese', 'ita'),
	(131, 'Fanti', 'ita'),
	(132, 'Figiano', 'ita'),
	(133, 'Filippino', 'ita'),
	(134, 'Finlandese', 'ita'),
	(135, 'Finno-Ugriano, Lingue', 'ita'),
	(136, 'Fon', 'ita'),
	(137, 'Francese', 'ita'),
	(138, 'Francese medio (ca.1400-1600)', 'ita'),
	(139, 'Francese antico (842-ca.1400)', 'ita'),
	(140, 'Frisone del Nord', 'ita'),
	(141, 'Frisone orientale', 'ita'),
	(142, 'Frisone occidentale', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(143, 'Fulah', 'ita'),
	(144, 'Friulano', 'ita'),
	(145, 'Ga', 'ita'),
	(146, 'Gayo', 'ita'),
	(147, 'Gbaya', 'ita'),
	(148, 'Germaniche, Lingue', 'ita'),
	(149, 'Georgiano', 'ita'),
	(150, 'Tedesco', 'ita'),
	(151, 'Geez', 'ita'),
	(152, 'Gilbertese', 'ita'),
	(153, 'Gaelico; Gaelico Scozzese', 'ita'),
	(154, 'Irlandese', 'ita'),
	(155, 'Galiziano', 'ita'),
	(156, 'Manx', 'ita'),
	(157, 'Tedesco medio alto (ca. 1050-1500', 'ita'),
	(158, 'Tedesco antico alto (ca. 750-1050)', 'ita'),
	(159, 'Gondi', 'ita'),
	(160, 'Gorontalo', 'ita'),
	(161, 'Gothico, Lingua associata)', 'ita'),
	(162, 'Grebo', 'ita'),
	(163, 'Greco antico (fino al 1453)', 'ita'),
	(164, 'Greco moderno (1453-)', 'ita'),
	(165, 'Guarani', 'ita'),
	(166, 'Svizzero tedesco; Alemanno; Alsaziano', 'ita'),
	(167, 'Gujarati', 'ita'),
	(168, 'Gwich''in', 'ita'),
	(169, 'Haida', 'ita'),
	(170, 'Haitiano; Haitiano Creolo', 'ita'),
	(171, 'Hausa', 'ita'),
	(172, 'Hawaiano', 'ita'),
	(173, 'Ebraico', 'ita'),
	(174, 'Herero', 'ita'),
	(175, 'Himachali; Pahari occidentali, Lingue', 'ita'),
	(176, 'Himachali', 'ita'),
	(177, 'Hindi', 'ita'),
	(178, 'Ittita', 'ita'),
	(179, 'Hmong', 'ita'),
	(180, 'Hiri Motu', 'ita'),
	(181, 'Sorabo superiore', 'ita'),
	(182, 'Ungherese', 'ita'),
	(183, 'Hupa', 'ita'),
	(184, 'Iban', 'ita'),
	(185, 'Igbo', 'ita'),
	(186, 'Islandese', 'ita'),
	(187, 'Ido', 'ita'),
	(188, 'Sichuan Yi', 'ita'),
	(189, 'Ijo, lingua', 'ita'),
	(190, 'Eschimese', 'ita'),
	(191, 'Interlingue; Occidentale', 'ita'),
	(192, 'Iloko', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(193, 'Interlingua (International Auxiliary Language Association)', 'ita'),
	(194, 'Indic, Lingua', 'ita'),
	(195, 'Indonesiano', 'ita'),
	(196, 'Indo-Europee, Lingue', 'ita'),
	(197, 'Ingush', 'ita'),
	(198, 'Inupiaq', 'ita'),
	(199, 'Iraniano, Lingue', 'ita'),
	(200, 'Irochesi, Lingue', 'ita'),
	(201, 'Italiano', 'ita'),
	(202, 'Javanese', 'ita'),
	(203, 'Lojban', 'ita'),
	(204, 'Giapponese', 'ita'),
	(205, 'Giudeo-Persiano', 'ita'),
	(206, 'Giudeo-Arabo', 'ita'),
	(207, 'Kara-Kalpak', 'ita'),
	(208, 'Kabyle', 'ita'),
	(209, 'Kachin; Jingpho', 'ita'),
	(210, 'Kalaallisut; Groenlandese', 'ita'),
	(211, 'Kamba', 'ita'),
	(212, 'Kannada', 'ita'),
	(213, 'Karen, Lingue', 'ita'),
	(214, 'Kashmiri', 'ita'),
	(215, 'Kanuri', 'ita'),
	(216, 'Kawi', 'ita'),
	(217, 'Kazako', 'ita'),
	(218, 'Kabardian', 'ita'),
	(219, 'Khasi', 'ita'),
	(220, 'Khoisan, lingue', 'ita'),
	(221, 'Khmer Centrale', 'ita'),
	(222, 'Khotanese', 'ita'),
	(223, 'Kikuyu; Gikuyu', 'ita'),
	(224, 'Kinyarwanda', 'ita'),
	(225, 'Kirghizo; Chirghiso', 'ita'),
	(226, 'Kimbundu', 'ita'),
	(227, 'Konkani', 'ita'),
	(228, 'Komi', 'ita'),
	(229, 'Kongo', 'ita'),
	(230, 'Coreano', 'ita'),
	(231, 'Kosraean', 'ita'),
	(232, 'Kpelle', 'ita'),
	(233, 'Karachay-Balkar', 'ita'),
	(234, 'Karelian', 'ita'),
	(235, 'Kru, Lingue', 'ita'),
	(236, 'Kurukh', 'ita'),
	(237, 'Kuanyama; Kwanyama', 'ita'),
	(238, 'Kumyk', 'ita'),
	(239, 'Curdo', 'ita'),
	(240, 'Kutenai', 'ita'),
	(241, 'Ladino', 'ita'),
	(242, 'Lahnda', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(243, 'Lamba', 'ita'),
	(244, 'Lao', 'ita'),
	(245, 'Latino', 'ita'),
	(246, 'Lettone', 'ita'),
	(247, 'Lezghian', 'ita'),
	(248, 'Limburgan; Limburger; Limburgish', 'ita'),
	(249, 'Lingala', 'ita'),
	(250, 'Lituano', 'ita'),
	(251, 'Mongo', 'ita'),
	(252, 'Lozi', 'ita'),
	(253, 'Lussemburghese', 'ita'),
	(254, 'Luba-Lulua', 'ita'),
	(255, 'Luba-Katangaxon, Low', 'ita'),
	(256, 'Ganda', 'ita'),
	(257, 'Luiseno', 'ita'),
	(258, 'Lunda', 'ita'),
	(259, 'Luo (Kenya e Tanzania)', 'ita'),
	(260, 'Lushai', 'ita'),
	(261, 'Macedone', 'ita'),
	(262, 'Madurese', 'ita'),
	(263, 'Magahi', 'ita'),
	(264, 'Marshallese', 'ita'),
	(265, 'Maithili', 'ita'),
	(266, 'Makasarl Nepal Bhasa', 'ita'),
	(267, 'Malayalam', 'ita'),
	(268, 'Mandingo', 'ita'),
	(269, 'Maori', 'ita'),
	(270, 'Austronesiane, Lingue', 'ita'),
	(271, 'Marathi', 'ita'),
	(272, 'Masai', 'ita'),
	(273, 'Malay', 'ita'),
	(274, 'Moksha', 'ita'),
	(275, 'Mandar', 'ita'),
	(276, 'Mende', 'ita'),
	(277, 'Irlandese medio (900-1200)', 'ita'),
	(278, 'Mi''kmaq; Micmac', 'ita'),
	(279, 'Minangkabau', 'ita'),
	(280, 'Lingue non codificate', 'ita'),
	(281, 'Mon-Khmer, Lingue', 'ita'),
	(282, 'Malagasy', 'ita'),
	(283, 'Maltese', 'ita'),
	(284, 'Manchu', 'ita'),
	(285, 'Manipuri', 'ita'),
	(286, 'Manobo, Lingue', 'ita'),
	(287, 'Mohawk', 'ita'),
	(288, 'Moldavo', 'ita'),
	(289, 'Mongolo', 'ita'),
	(290, 'Mossi', 'ita'),
	(291, 'Multiple, Lingue', 'ita'),
	(292, 'Munda, Lingue', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(293, 'Creek', 'ita'),
	(294, 'Mirandese', 'ita'),
	(295, 'Marwari', 'ita'),
	(296, 'Maya, Lingue', 'ita'),
	(297, 'Erzya', 'ita'),
	(298, 'Nahuatl,Lingue', 'ita'),
	(299, 'Nord America, Lingue (indiane)', 'ita'),
	(300, 'Napoletano', 'ita'),
	(301, 'Nauru', 'ita'),
	(302, 'Navajo; Navaho', 'ita'),
	(303, 'Ndebele del Sud', 'ita'),
	(304, 'Ndebele del Nord', 'ita'),
	(305, 'Ndonga', 'ita'),
	(306, 'Tedesco; Basso Sassone', 'ita'),
	(307, 'Nepalese', 'ita'),
	(308, 'Bhasa nepalese, Newari', 'ita'),
	(309, 'Nias', 'ita'),
	(310, 'Niger-Kordofanian, Lingue', 'ita'),
	(311, 'Niuean', 'ita'),
	(312, 'Nynorsk Norvegese', 'ita'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'ita'),
	(314, 'Nogai', 'ita'),
	(315, 'Norse antico', 'ita'),
	(316, 'Norvegese', 'ita'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'ita'),
	(318, 'Nubiane, Lingue', 'ita'),
	(319, 'Newari calssico; Newsari antico; Nepal Bhasa classico', 'ita'),
	(320, 'Chichewa; Chewa; Nyanja', 'ita'),
	(321, 'Nyamwezi', 'ita'),
	(322, 'Nyankole', 'ita'),
	(323, 'Nyoro', 'ita'),
	(324, 'Nzima', 'ita'),
	(325, 'Occitano (dopo 1500); Provenzale', 'ita'),
	(326, 'Ojibwa', 'ita'),
	(327, 'Oriya', 'ita'),
	(328, 'Oromo', 'ita'),
	(329, 'Osage', 'ita'),
	(330, 'Osseto', 'ita'),
	(331, 'Turco Ottomano (1500-1928)', 'ita'),
	(332, 'Ottomane, Lingue', 'ita'),
	(333, 'Papuane, Lingue', 'ita'),
	(334, 'Pangasinan', 'ita'),
	(335, 'Pahlavi', 'ita'),
	(336, 'Pampanga', 'ita'),
	(337, 'Panjabi; Punjabi', 'ita'),
	(338, 'Papiamento', 'ita'),
	(339, 'Palau', 'ita'),
	(340, 'Persiano Antico (ca.600-400 B.C.)', 'ita'),
	(341, 'Persiano', 'ita'),
	(342, 'Filippine, Lingue', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(343, 'Fenicio', 'ita'),
	(344, 'Pali', 'ita'),
	(345, 'Polacco', 'ita'),
	(346, 'Pohnpeian', 'ita'),
	(347, 'Portoghese', 'ita'),
	(348, 'Prakrit, Lingue', 'ita'),
	(349, 'Provenzale Antico (fino al 1500); Occitano Antico (fino al 1500)', 'ita'),
	(350, 'Pasthu; Afgano', 'ita'),
	(351, 'Riservato per uso locale', 'ita'),
	(352, 'Quechua', 'ita'),
	(353, 'Rajasthani', 'ita'),
	(354, 'Rapanui', 'ita'),
	(355, 'Rarotongan; Maori dell''Isola di Cook', 'ita'),
	(356, 'Romanze, Lingue', 'ita'),
	(357, 'Romancio', 'ita'),
	(358, 'Romany', 'ita'),
	(359, 'Rumeno', 'ita'),
	(360, 'Rundi', 'ita'),
	(361, 'Aromeno; Arumeno; Macedone-Romeno', 'ita'),
	(362, 'Russo', 'ita'),
	(363, 'Sandawe', 'ita'),
	(364, 'Sango', 'ita'),
	(365, 'Yakut', 'ita'),
	(366, 'Sud America, Lingue (indiane)', 'ita'),
	(367, 'Salishan, Lingue', 'ita'),
	(368, 'Aramaico Samaritano', 'ita'),
	(369, 'Sanscrito', 'ita'),
	(370, 'Sasak', 'ita'),
	(371, 'Santali', 'ita'),
	(372, 'Serbo', 'ita'),
	(373, 'Siciliano', 'ita'),
	(374, 'Scots', 'ita'),
	(375, 'Croatian', 'ita'),
	(376, 'Selkup', 'ita'),
	(377, 'Semitiche, Lingue', 'ita'),
	(378, 'Irlandese Antico (fino al 900)', 'ita'),
	(379, 'Linguaggi dei Segni', 'ita'),
	(380, 'Shan', 'ita'),
	(381, 'Sidamo', 'ita'),
	(382, 'Sinhala; Sinhalese', 'ita'),
	(383, 'Siouan, Lingue', 'ita'),
	(384, 'Sino-Tibetane, Lingue', 'ita'),
	(385, 'Slave, Lingue', 'ita'),
	(386, 'Slovacco', 'ita'),
	(387, 'Sloveno', 'ita'),
	(388, 'Sami del Sud', 'ita'),
	(389, 'Sami del Nord', 'ita'),
	(390, 'Sami, Lingue', 'ita'),
	(391, 'Sami Lule', 'ita'),
	(392, 'Sami Inari', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(393, 'Samoano', 'ita'),
	(394, 'Sami Skolt', 'ita'),
	(395, 'Shona', 'ita'),
	(396, 'Sindhi', 'ita'),
	(397, 'Soninke', 'ita'),
	(398, 'Sogdian', 'ita'),
	(399, 'Somalo', 'ita'),
	(400, 'Songhai, Lingue', 'ita'),
	(401, 'Sotho del Sud', 'ita'),
	(402, 'Spagnolo; Castigliano', 'ita'),
	(403, 'Sardo; Zazaki', 'ita'),
	(404, 'Sranan Tongo', 'ita'),
	(405, 'Serer', 'ita'),
	(406, 'Nilo-Sahariane, Lingue', 'ita'),
	(407, 'Swati', 'ita'),
	(408, 'Sukuma', 'ita'),
	(409, 'Sundanese', 'ita'),
	(410, 'Susu', 'ita'),
	(411, 'Sumero', 'ita'),
	(412, 'Swahili', 'ita'),
	(413, 'Svedese', 'ita'),
	(414, 'Siriano', 'ita'),
	(415, 'Thaitiano', 'ita'),
	(416, 'Tai, Lingue', 'ita'),
	(417, 'Tamil', 'ita'),
	(418, 'Tatarico', 'ita'),
	(419, 'Telugu', 'ita'),
	(420, 'Timnendere)', 'ita'),
	(421, 'Tereno', 'ita'),
	(422, 'Tetum', 'ita'),
	(423, 'Tajik', 'ita'),
	(424, 'Tagalog', 'ita'),
	(425, 'Thailandese', 'ita'),
	(426, 'Tibetano', 'ita'),
	(427, 'Tigre', 'ita'),
	(428, 'Tigrinya', 'ita'),
	(429, 'Tiv', 'ita'),
	(430, 'Tokelau', 'ita'),
	(431, 'Klingon; tlhIngan-Hol', 'ita'),
	(432, 'Tlingit', 'ita'),
	(433, 'Tamashek', 'ita'),
	(434, 'Tonga (Nyasa)', 'ita'),
	(435, 'Tonga (Isole Tonga)', 'ita'),
	(436, 'Tok Pisin', 'ita'),
	(437, 'Tsimshian', 'ita'),
	(438, 'Tswana', 'ita'),
	(439, 'Tsonga', 'ita'),
	(440, 'Turcmeno', 'ita'),
	(441, 'Tumbuka', 'ita'),
	(442, 'Tupi, Lingue', 'ita');
INSERT INTO public.isolanguagesdes VALUES
	(443, 'Turco', 'ita'),
	(444, 'Altaiche, Lingue', 'ita'),
	(445, 'Tuvalu', 'ita'),
	(446, 'Twi', 'ita'),
	(447, 'Tuvinian', 'ita'),
	(448, 'Udmurt', 'ita'),
	(449, 'Ugaritico', 'ita'),
	(450, 'Uighur; Uyghur', 'ita'),
	(451, 'Ucraino', 'ita'),
	(452, 'Umbundu', 'ita'),
	(453, 'Non determinato', 'ita'),
	(454, 'Urdu', 'ita'),
	(455, 'Uzbeco', 'ita'),
	(456, 'Vai', 'ita'),
	(457, 'Venda', 'ita'),
	(458, 'Vietnamita', 'ita'),
	(459, 'Volapük', 'ita'),
	(460, 'Votic', 'ita'),
	(461, 'Wakashan, Lingue', 'ita'),
	(462, 'Walamo', 'ita'),
	(463, 'Waray', 'ita'),
	(464, 'Washo', 'ita'),
	(465, 'Gallese', 'ita'),
	(466, 'Sorabe, Lingue', 'ita'),
	(467, 'Vallone', 'ita'),
	(468, 'Volof', 'ita'),
	(469, 'Kalmyk; Oirat', 'ita'),
	(470, 'Xhosa', 'ita'),
	(471, 'Yao', 'ita'),
	(472, 'Yapese', 'ita'),
	(473, 'Yiddish', 'ita'),
	(474, 'Yoruba', 'ita'),
	(475, 'Yupik, Lingue', 'ita'),
	(476, 'Zapotec', 'ita'),
	(477, 'Zenaga', 'ita'),
	(478, 'Zhuang; Chuang', 'ita'),
	(479, 'Zande, Lingue', 'ita'),
	(480, 'Zulu', 'ita'),
	(481, 'Zuni', 'ita'),
	(482, 'Nessun contenuto linguistico; non applicabile', 'ita'),
	(483, 'N''Ko', 'ita'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'ita'),
	(1, 'Afar', 'tur'),
	(2, 'Abkhazian', 'tur'),
	(3, 'Achinese', 'tur'),
	(4, 'Acoli', 'tur'),
	(5, 'Adangme', 'tur'),
	(6, 'Adyghe; Adygei', 'tur'),
	(7, 'Afro-Asiatic (Other)', 'tur'),
	(8, 'Afrihili', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(9, 'Afrikaans', 'tur'),
	(10, 'Ainu', 'tur'),
	(11, 'Akan', 'tur'),
	(12, 'Akkadian', 'tur'),
	(13, 'Albanian', 'tur'),
	(14, 'Aleut', 'tur'),
	(15, 'Algonquian languages', 'tur'),
	(16, 'Southern Altai', 'tur'),
	(17, 'Amharic', 'tur'),
	(18, 'English, Old (ca.450-1100)', 'tur'),
	(19, 'Angika', 'tur'),
	(20, 'Apache languages', 'tur'),
	(21, 'Arabic', 'tur'),
	(22, 'Aramaic', 'tur'),
	(23, 'Aragonese', 'tur'),
	(24, 'Armenian', 'tur'),
	(25, 'Mapudungun; Mapuche', 'tur'),
	(26, 'Arapaho', 'tur'),
	(27, 'Artificial (Other)', 'tur'),
	(28, 'Arawak', 'tur'),
	(29, 'Assamese', 'tur'),
	(30, 'Asturian; Bable', 'tur'),
	(31, 'Athapascan languages', 'tur'),
	(32, 'Australian languages', 'tur'),
	(33, 'Avaric', 'tur'),
	(34, 'Avestan', 'tur'),
	(35, 'Awadhi', 'tur'),
	(36, 'Aymara', 'tur'),
	(37, 'Azerbaijani', 'tur'),
	(38, 'Banda languages', 'tur'),
	(39, 'Bamileke languages', 'tur'),
	(40, 'Bashkir', 'tur'),
	(41, 'Baluchi', 'tur'),
	(42, 'Bambara', 'tur'),
	(43, 'Balinese', 'tur'),
	(44, 'Basque', 'tur'),
	(45, 'Basa', 'tur'),
	(46, 'Baltic (Other)', 'tur'),
	(47, 'Beja', 'tur'),
	(48, 'Belarusian', 'tur'),
	(49, 'Bemba', 'tur'),
	(50, 'Bengali', 'tur'),
	(51, 'Berber (Other)', 'tur'),
	(52, 'Bhojpuri', 'tur'),
	(53, 'Bihari', 'tur'),
	(54, 'Bikol', 'tur'),
	(55, 'Bini; Edo', 'tur'),
	(56, 'Bislama', 'tur'),
	(57, 'Siksika', 'tur'),
	(58, 'Bantu (Other)', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(59, 'Bosnian', 'tur'),
	(60, 'Braj', 'tur'),
	(61, 'Breton', 'tur'),
	(62, 'Batak languages', 'tur'),
	(63, 'Buriat', 'tur'),
	(64, 'Buginese', 'tur'),
	(65, 'Bulgarian', 'tur'),
	(66, 'Burmese', 'tur'),
	(67, 'Blin; Bilin', 'tur'),
	(68, 'Caddo', 'tur'),
	(69, 'Central American Indian (Other)', 'tur'),
	(70, 'Galibi Carib', 'tur'),
	(71, 'Catalan; Valencian', 'tur'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'tur'),
	(73, 'Cebuano', 'tur'),
	(74, 'Celtic (Other)', 'tur'),
	(75, 'Chamorro', 'tur'),
	(76, 'Chibcha', 'tur'),
	(77, 'Chechen', 'tur'),
	(78, 'Chagataier)', 'tur'),
	(79, 'Chinese(Other)', 'tur'),
	(80, 'Chuukese', 'tur'),
	(81, 'Mari', 'tur'),
	(82, 'Chinook jargon', 'tur'),
	(83, 'Choctaw', 'tur'),
	(84, 'Chipewyan', 'tur'),
	(85, 'Cherokee', 'tur'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'tur'),
	(87, 'Chuvash', 'tur'),
	(88, 'Cheyenne', 'tur'),
	(89, 'Chamic languages', 'tur'),
	(90, 'Coptic', 'tur'),
	(91, 'Cornish', 'tur'),
	(92, 'Corsican', 'tur'),
	(93, 'Creoles and pidgins, English based (Ot', 'tur'),
	(94, 'Creoles and pidgins, French-based (Oth', 'tur'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'tur'),
	(96, 'Cree', 'tur'),
	(97, 'Crimean Tatar; Crimean Turkish', 'tur'),
	(98, 'Creoles and pidgins (Other)', 'tur'),
	(99, 'Kashubian', 'tur'),
	(100, 'Cushitic (Other)', 'tur'),
	(101, 'Czech', 'tur'),
	(102, 'Dakota', 'tur'),
	(103, 'Danish', 'tur'),
	(104, 'Dargwa', 'tur'),
	(105, 'Land Dayak languages', 'tur'),
	(106, 'Delaware', 'tur'),
	(107, 'Slave (Athapascan)', 'tur'),
	(108, 'Dogrib', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(109, 'Dinka', 'tur'),
	(110, 'Divehi; Dhivehi; Maldivian', 'tur'),
	(111, 'Dogri', 'tur'),
	(112, 'Dravidian (Other)', 'tur'),
	(113, 'Lower Sorbian', 'tur'),
	(114, 'Duala', 'tur'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'tur'),
	(116, 'Dutch; Flemish', 'tur'),
	(117, 'Dyula', 'tur'),
	(118, 'Dzongkha', 'tur'),
	(119, 'Efik', 'tur'),
	(120, 'Egyptian (Ancient)', 'tur'),
	(121, 'Ekajuk', 'tur'),
	(122, 'Elamite', 'tur'),
	(123, 'English', 'tur'),
	(124, 'English, Middle (1100-1500)', 'tur'),
	(125, 'Esperanto', 'tur'),
	(126, 'Estonian', 'tur'),
	(127, 'Ewe', 'tur'),
	(128, 'Ewondo', 'tur'),
	(129, 'Fang', 'tur'),
	(130, 'Faroese', 'tur'),
	(131, 'Fanti', 'tur'),
	(132, 'Fijian', 'tur'),
	(133, 'Filipino; Pilipino', 'tur'),
	(134, 'Finnish', 'tur'),
	(135, 'Finno-Ugrian (Other)', 'tur'),
	(136, 'Fon', 'tur'),
	(137, 'French', 'tur'),
	(138, 'French, Middle (ca.1400-1600)', 'tur'),
	(139, 'French, Old (842-ca.1400)', 'tur'),
	(140, 'Northern Frisian', 'tur'),
	(141, 'Eastern Frisian', 'tur'),
	(142, 'Western Frisian', 'tur'),
	(143, 'Fulah', 'tur'),
	(144, 'Friulian', 'tur'),
	(145, 'Ga', 'tur'),
	(146, 'Gayo', 'tur'),
	(147, 'Gbaya', 'tur'),
	(148, 'Germanic (Other)', 'tur'),
	(149, 'Georgian', 'tur'),
	(150, 'German', 'tur'),
	(151, 'Geez', 'tur'),
	(152, 'Gilbertese', 'tur'),
	(153, 'Gaelic; Scottish Gaelic', 'tur'),
	(154, 'Irish', 'tur'),
	(155, 'Galician', 'tur'),
	(156, 'Manx', 'tur'),
	(157, 'German, Middle High (ca.1050-1500)', 'tur'),
	(158, 'German, Old High (ca.750-1050)', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(159, 'Gondi', 'tur'),
	(160, 'Gorontalo', 'tur'),
	(161, 'Gothicanguage Association)', 'tur'),
	(162, 'Grebo', 'tur'),
	(163, 'Greek, Ancient (to 1453)', 'tur'),
	(164, 'Greek, Modern (1453-)', 'tur'),
	(165, 'Guarani', 'tur'),
	(166, 'Swiss German; Alemannic', 'tur'),
	(167, 'Gujarati', 'tur'),
	(168, 'Gwich''in', 'tur'),
	(169, 'Haida', 'tur'),
	(170, 'Haitian; Haitian Creole', 'tur'),
	(171, 'Hausa', 'tur'),
	(172, 'Hawaiian', 'tur'),
	(173, 'Hebrew', 'tur'),
	(174, 'Herero', 'tur'),
	(175, 'Hiligaynon', 'tur'),
	(176, 'Himachali', 'tur'),
	(177, 'Hindi', 'tur'),
	(178, 'Hittite', 'tur'),
	(179, 'Hmong', 'tur'),
	(180, 'Hiri Motu', 'tur'),
	(181, 'Upper Sorbian', 'tur'),
	(182, 'Hungarian', 'tur'),
	(183, 'Hupa', 'tur'),
	(184, 'Iban', 'tur'),
	(185, 'Igbo', 'tur'),
	(186, 'Icelandic', 'tur'),
	(187, 'Ido', 'tur'),
	(188, 'Sichuan Yi', 'tur'),
	(189, 'Ijo languages', 'tur'),
	(190, 'Inuktitut', 'tur'),
	(191, 'Interlingue', 'tur'),
	(192, 'Iloko', 'tur'),
	(193, 'Interlingua (International Auxiliary L', 'tur'),
	(194, 'Indic (Other)', 'tur'),
	(195, 'Indonesian', 'tur'),
	(196, 'Indo-European (Other)', 'tur'),
	(197, 'Ingush', 'tur'),
	(198, 'Inupiaq', 'tur'),
	(199, 'Iranian (Other)', 'tur'),
	(200, 'Iroquoian languages', 'tur'),
	(201, 'Italian', 'tur'),
	(202, 'Javanese', 'tur'),
	(203, 'Lojban', 'tur'),
	(204, 'Japanese', 'tur'),
	(205, 'Judeo-Persian', 'tur'),
	(206, 'Judeo-Arabic', 'tur'),
	(207, 'Kara-Kalpak', 'tur'),
	(208, 'Kabyle', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(209, 'Kachin; Jingpho', 'tur'),
	(210, 'Kalaallisut; Greenlandic', 'tur'),
	(211, 'Kamba', 'tur'),
	(212, 'Kannada', 'tur'),
	(213, 'Karen languages', 'tur'),
	(214, 'Kashmiri', 'tur'),
	(215, 'Kanuri', 'tur'),
	(216, 'Kawi', 'tur'),
	(217, 'Kazakh', 'tur'),
	(218, 'Kabardian', 'tur'),
	(219, 'Khasi', 'tur'),
	(220, 'Khoisan (Other)', 'tur'),
	(221, 'Central Khmer', 'tur'),
	(222, 'Khotanese', 'tur'),
	(223, 'Kikuyu; Gikuyu', 'tur'),
	(224, 'Kinyarwanda', 'tur'),
	(225, 'Kirghiz; Kyrgyz', 'tur'),
	(226, 'Kimbundu', 'tur'),
	(227, 'Konkani', 'tur'),
	(228, 'Komi', 'tur'),
	(229, 'Kongo', 'tur'),
	(230, 'Korean', 'tur'),
	(231, 'Kosraean', 'tur'),
	(232, 'Kpelle', 'tur'),
	(233, 'Karachay-Balkar', 'tur'),
	(234, 'Karelian', 'tur'),
	(235, 'Kru languages', 'tur'),
	(236, 'Kurukh', 'tur'),
	(237, 'Kuanyama; Kwanyama', 'tur'),
	(238, 'Kumyk', 'tur'),
	(239, 'Kurdish', 'tur'),
	(240, 'Kutenai', 'tur'),
	(241, 'Ladino', 'tur'),
	(242, 'Lahnda', 'tur'),
	(243, 'Lamba', 'tur'),
	(244, 'Lao', 'tur'),
	(245, 'Latin', 'tur'),
	(246, 'Latvian', 'tur'),
	(247, 'Lezghian', 'tur'),
	(248, 'Limburgan; Limburger; Limburgish', 'tur'),
	(249, 'Lingala', 'tur'),
	(250, 'Lithuanian', 'tur'),
	(251, 'Mongo', 'tur'),
	(252, 'Lozi', 'tur'),
	(253, 'Luxembourgish; Letzeburgesch', 'tur'),
	(254, 'Luba-Lulua', 'tur'),
	(255, 'Luba-Katangaxon, Low', 'tur'),
	(256, 'Ganda', 'tur'),
	(257, 'Luiseno', 'tur'),
	(258, 'Lunda', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(259, 'Luo (Kenya and Tanzania)', 'tur'),
	(260, 'Lushai', 'tur'),
	(261, 'Macedonian00E5l', 'tur'),
	(262, 'Madurese', 'tur'),
	(263, 'Magahi', 'tur'),
	(264, 'Marshallese', 'tur'),
	(265, 'Maithili', 'tur'),
	(266, 'Makasarl Nepal Bhasa', 'tur'),
	(267, 'Malayalam', 'tur'),
	(268, 'Mandingo', 'tur'),
	(269, 'Maori', 'tur'),
	(270, 'Austronesian (Other)', 'tur'),
	(271, 'Marathi', 'tur'),
	(272, 'Masai', 'tur'),
	(273, 'Malay', 'tur'),
	(274, 'Moksha', 'tur'),
	(275, 'Mandar', 'tur'),
	(276, 'Mende', 'tur'),
	(277, 'Irish, Middle (900-1200)', 'tur'),
	(278, 'Mi''kmaq; Micmac', 'tur'),
	(279, 'Minangkabau', 'tur'),
	(280, 'Miscellaneous languages', 'tur'),
	(281, 'Mon-Khmer (Other)', 'tur'),
	(282, 'Malagasy', 'tur'),
	(283, 'Maltese', 'tur'),
	(284, 'Manchu', 'tur'),
	(285, 'Manipuri', 'tur'),
	(286, 'Manobo languages', 'tur'),
	(287, 'Mohawk', 'tur'),
	(288, 'Moldavian', 'tur'),
	(289, 'Mongolian', 'tur'),
	(290, 'Mossi', 'tur'),
	(291, 'Multiple languages', 'tur'),
	(292, 'Munda languages', 'tur'),
	(293, 'Creek', 'tur'),
	(294, 'Mirandese', 'tur'),
	(295, 'Marwari', 'tur'),
	(296, 'Mayan languages', 'tur'),
	(297, 'Erzya', 'tur'),
	(298, 'Nahuatl languages', 'tur'),
	(299, 'North American Indian', 'tur'),
	(300, 'Neapolitan', 'tur'),
	(301, 'Nauru', 'tur'),
	(302, 'Navajo; Navaho', 'tur'),
	(303, 'Ndebele, South; South Ndebele', 'tur'),
	(304, 'Ndebele, North; North Ndebele', 'tur'),
	(305, 'Ndonga', 'tur'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'tur'),
	(307, 'Nepali', 'tur'),
	(308, 'Nepal Bhasa; Newari', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(309, 'Nias', 'tur'),
	(310, 'Niger-Kordofanian (Other)', 'tur'),
	(311, 'Niuean', 'tur'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'tur'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'tur'),
	(314, 'Nogai', 'tur'),
	(315, 'Norse, Old', 'tur'),
	(316, 'Norwegian', 'tur'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'tur'),
	(318, 'Nubian languages', 'tur'),
	(319, 'Classical Newari; Old Newari; Classica', 'tur'),
	(320, 'Chichewa; Chewa; Nyanja', 'tur'),
	(321, 'Nyamwezi', 'tur'),
	(322, 'Nyankole', 'tur'),
	(323, 'Nyoro', 'tur'),
	(324, 'Nzima', 'tur'),
	(325, 'Occitan (post 1500); Provençal', 'tur'),
	(326, 'Ojibwa', 'tur'),
	(327, 'Oriya', 'tur'),
	(328, 'Oromo', 'tur'),
	(329, 'Osage', 'tur'),
	(330, 'Ossetian; Ossetic', 'tur'),
	(331, 'Turkish, Ottoman (1500-1928)', 'tur'),
	(332, 'Otomian languages', 'tur'),
	(333, 'Papuan (Other)', 'tur'),
	(334, 'Pangasinan', 'tur'),
	(335, 'Pahlavi', 'tur'),
	(336, 'Pampanga', 'tur'),
	(337, 'Panjabi; Punjabi', 'tur'),
	(338, 'Papiamento', 'tur'),
	(339, 'Palauan', 'tur'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'tur'),
	(341, 'Persian', 'tur'),
	(342, 'Philippine (Other)', 'tur'),
	(343, 'Phoenician', 'tur'),
	(344, 'Pali', 'tur'),
	(345, 'Polish', 'tur'),
	(346, 'Pohnpeian', 'tur'),
	(347, 'Portuguese', 'tur'),
	(348, 'Prakrit languages', 'tur'),
	(349, 'Provençal, Old (to 1500)', 'tur'),
	(350, 'Pushto', 'tur'),
	(351, 'Reserved for local use', 'tur'),
	(352, 'Quechua', 'tur'),
	(353, 'Rajasthani', 'tur'),
	(354, 'Rapanui', 'tur'),
	(355, 'Rarotongan; Cook Islands Maori', 'tur'),
	(356, 'Romance (Other)', 'tur'),
	(357, 'Romansh', 'tur'),
	(358, 'Romany', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(359, 'Romanian', 'tur'),
	(360, 'Rundi', 'tur'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'tur'),
	(362, 'Russian', 'tur'),
	(363, 'Sandawe', 'tur'),
	(364, 'Sango', 'tur'),
	(365, 'Yakut', 'tur'),
	(366, 'South American Indian (Other)', 'tur'),
	(367, 'Salishan languages', 'tur'),
	(368, 'Samaritan Aramaic', 'tur'),
	(369, 'Sanskrit', 'tur'),
	(370, 'Sasak', 'tur'),
	(371, 'Santali', 'tur'),
	(372, 'Serbian', 'tur'),
	(373, 'Sicilian', 'tur'),
	(374, 'Scots', 'tur'),
	(375, 'Croatian', 'tur'),
	(376, 'Selkup', 'tur'),
	(377, 'Semitic (Other)', 'tur'),
	(378, 'Irish, Old (to 900)', 'tur'),
	(379, 'Sign Languages', 'tur'),
	(380, 'Shan', 'tur'),
	(381, 'Sidamo', 'tur'),
	(382, 'Sinhala; Sinhalese', 'tur'),
	(383, 'Siouan languages', 'tur'),
	(384, 'Sino-Tibetan (Other)', 'tur'),
	(385, 'Slavic (Other)', 'tur'),
	(386, 'Slovak', 'tur'),
	(387, 'Slovenian', 'tur'),
	(388, 'Southern Sami', 'tur'),
	(389, 'Northern Sami', 'tur'),
	(390, 'Sami languages (Other)', 'tur'),
	(391, 'Lule Sami', 'tur'),
	(392, 'Inari Sami', 'tur'),
	(393, 'Samoan', 'tur'),
	(394, 'Skolt Sami', 'tur'),
	(395, 'Shona', 'tur'),
	(396, 'Sindhi', 'tur'),
	(397, 'Soninke', 'tur'),
	(398, 'Sogdian', 'tur'),
	(399, 'Somali', 'tur'),
	(400, 'Songhai languages', 'tur'),
	(401, 'Sotho, Southern', 'tur'),
	(402, 'Spanish; Castilian', 'tur'),
	(403, 'Sardinian; Zazaki', 'tur'),
	(404, 'Sranan Tongo', 'tur'),
	(405, 'Serer', 'tur'),
	(406, 'Nilo-Saharan (Other)', 'tur'),
	(407, 'Swati', 'tur'),
	(408, 'Sukuma', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(409, 'Sundanese', 'tur'),
	(410, 'Susu', 'tur'),
	(411, 'Sumerian', 'tur'),
	(412, 'Swahili', 'tur'),
	(413, 'Swedish', 'tur'),
	(414, 'Syriac', 'tur'),
	(415, 'Tahitian', 'tur'),
	(416, 'Tai (Other)', 'tur'),
	(417, 'Tamil', 'tur'),
	(418, 'Tatar', 'tur'),
	(419, 'Telugu', 'tur'),
	(420, 'Timnendere)', 'tur'),
	(421, 'Tereno', 'tur'),
	(422, 'Tetum', 'tur'),
	(423, 'Tajik', 'tur'),
	(424, 'Tagalog', 'tur'),
	(425, 'Thai', 'tur'),
	(426, 'Tibetan', 'tur'),
	(427, 'Tigre', 'tur'),
	(428, 'Tigrinya', 'tur'),
	(429, 'Tiv', 'tur'),
	(430, 'Tokelau', 'tur'),
	(431, 'Klingon; tlhIngan-Hol', 'tur'),
	(432, 'Tlingit', 'tur'),
	(433, 'Tamashek', 'tur'),
	(434, 'Tonga (Nyasa)', 'tur'),
	(435, 'Tonga (Tonga Islands)', 'tur'),
	(436, 'Tok Pisin', 'tur'),
	(437, 'Tsimshian', 'tur'),
	(438, 'Tswana', 'tur'),
	(439, 'Tsonga', 'tur'),
	(440, 'Turkmen', 'tur'),
	(441, 'Tumbuka', 'tur'),
	(442, 'Tupi languages', 'tur'),
	(443, 'Turkish', 'tur'),
	(444, 'Altaic (Other)', 'tur'),
	(445, 'Tuvalu', 'tur'),
	(446, 'Twi', 'tur'),
	(447, 'Tuvinian', 'tur'),
	(448, 'Udmurt', 'tur'),
	(449, 'Ugaritic', 'tur'),
	(450, 'Uighur; Uyghur', 'tur'),
	(451, 'Ukrainian', 'tur'),
	(452, 'Umbundu', 'tur'),
	(453, 'Undetermined', 'tur'),
	(454, 'Urdu', 'tur'),
	(455, 'Uzbek', 'tur'),
	(456, 'Vai', 'tur'),
	(457, 'Venda', 'tur'),
	(458, 'Vietnamese', 'tur');
INSERT INTO public.isolanguagesdes VALUES
	(459, 'Volapük', 'tur'),
	(460, 'Votic', 'tur'),
	(461, 'Wakashan languages', 'tur'),
	(462, 'Walamo', 'tur'),
	(463, 'Waray', 'tur'),
	(464, 'Washo', 'tur'),
	(465, 'Welsh', 'tur'),
	(466, 'Sorbian languages', 'tur'),
	(467, 'Walloon', 'tur'),
	(468, 'Wolof', 'tur'),
	(469, 'Kalmyk; Oirat', 'tur'),
	(470, 'Xhosa', 'tur'),
	(471, 'Yao', 'tur'),
	(472, 'Yapese', 'tur'),
	(473, 'Yiddish', 'tur'),
	(474, 'Yoruba', 'tur'),
	(475, 'Yupik languages', 'tur'),
	(476, 'Zapotec', 'tur'),
	(477, 'Zenaga', 'tur'),
	(478, 'Zhuang; Chuang', 'tur'),
	(479, 'Zande languages', 'tur'),
	(480, 'Zulu', 'tur'),
	(481, 'Zuni', 'tur'),
	(482, 'No linguistic content', 'tur'),
	(483, 'N''Ko', 'tur'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'tur'),
	(1, 'Afar', 'vie'),
	(2, 'Abkhazian', 'vie'),
	(3, 'Achinese', 'vie'),
	(4, 'Acoli', 'vie'),
	(5, 'Adangme', 'vie'),
	(6, 'Adyghe; Adygei', 'vie'),
	(7, 'Afro-Asiatic (Other)', 'vie'),
	(8, 'Afrihili', 'vie'),
	(9, 'Afrikaans', 'vie'),
	(10, 'Ainu', 'vie'),
	(11, 'Akan', 'vie'),
	(12, 'Akkadian', 'vie'),
	(13, 'Albanian', 'vie'),
	(14, 'Aleut', 'vie'),
	(15, 'Algonquian languages', 'vie'),
	(16, 'Southern Altai', 'vie'),
	(17, 'Amharic', 'vie'),
	(18, 'English, Old (ca.450-1100)', 'vie'),
	(19, 'Angika', 'vie'),
	(20, 'Apache languages', 'vie'),
	(21, 'Arabic', 'vie'),
	(22, 'Aramaic', 'vie'),
	(23, 'Aragonese', 'vie'),
	(24, 'Armenian', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(25, 'Mapudungun; Mapuche', 'vie'),
	(26, 'Arapaho', 'vie'),
	(27, 'Artificial (Other)', 'vie'),
	(28, 'Arawak', 'vie'),
	(29, 'Assamese', 'vie'),
	(30, 'Asturian; Bable', 'vie'),
	(31, 'Athapascan languages', 'vie'),
	(32, 'Australian languages', 'vie'),
	(33, 'Avaric', 'vie'),
	(34, 'Avestan', 'vie'),
	(35, 'Awadhi', 'vie'),
	(36, 'Aymara', 'vie'),
	(37, 'Azerbaijani', 'vie'),
	(38, 'Banda languages', 'vie'),
	(39, 'Bamileke languages', 'vie'),
	(40, 'Bashkir', 'vie'),
	(41, 'Baluchi', 'vie'),
	(42, 'Bambara', 'vie'),
	(43, 'Balinese', 'vie'),
	(44, 'Basque', 'vie'),
	(45, 'Basa', 'vie'),
	(46, 'Baltic (Other)', 'vie'),
	(47, 'Beja', 'vie'),
	(48, 'Belarusian', 'vie'),
	(49, 'Bemba', 'vie'),
	(50, 'Bengali', 'vie'),
	(51, 'Berber (Other)', 'vie'),
	(52, 'Bhojpuri', 'vie'),
	(53, 'Bihari', 'vie'),
	(54, 'Bikol', 'vie'),
	(55, 'Bini; Edo', 'vie'),
	(56, 'Bislama', 'vie'),
	(57, 'Siksika', 'vie'),
	(58, 'Bantu (Other)', 'vie'),
	(59, 'Bosnian', 'vie'),
	(60, 'Braj', 'vie'),
	(61, 'Breton', 'vie'),
	(62, 'Batak languages', 'vie'),
	(63, 'Buriat', 'vie'),
	(64, 'Buginese', 'vie'),
	(65, 'Bulgarian', 'vie'),
	(66, 'Burmese', 'vie'),
	(67, 'Blin; Bilin', 'vie'),
	(68, 'Caddo', 'vie'),
	(69, 'Central American Indian (Other)', 'vie'),
	(70, 'Galibi Carib', 'vie'),
	(71, 'Catalan; Valencian', 'vie'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'vie'),
	(73, 'Cebuano', 'vie'),
	(74, 'Celtic (Other)', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(75, 'Chamorro', 'vie'),
	(76, 'Chibcha', 'vie'),
	(77, 'Chechen', 'vie'),
	(78, 'Chagataier)', 'vie'),
	(79, 'Chinese(Other)', 'vie'),
	(80, 'Chuukese', 'vie'),
	(81, 'Mari', 'vie'),
	(82, 'Chinook jargon', 'vie'),
	(83, 'Choctaw', 'vie'),
	(84, 'Chipewyan', 'vie'),
	(85, 'Cherokee', 'vie'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'vie'),
	(87, 'Chuvash', 'vie'),
	(88, 'Cheyenne', 'vie'),
	(89, 'Chamic languages', 'vie'),
	(90, 'Coptic', 'vie'),
	(91, 'Cornish', 'vie'),
	(92, 'Corsican', 'vie'),
	(93, 'Creoles and pidgins, English based (Ot', 'vie'),
	(94, 'Creoles and pidgins, French-based (Oth', 'vie'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'vie'),
	(96, 'Cree', 'vie'),
	(97, 'Crimean Tatar; Crimean Turkish', 'vie'),
	(98, 'Creoles and pidgins (Other)', 'vie'),
	(99, 'Kashubian', 'vie'),
	(100, 'Cushitic (Other)', 'vie'),
	(101, 'Czech', 'vie'),
	(102, 'Dakota', 'vie'),
	(103, 'Danish', 'vie'),
	(104, 'Dargwa', 'vie'),
	(105, 'Land Dayak languages', 'vie'),
	(106, 'Delaware', 'vie'),
	(107, 'Slave (Athapascan)', 'vie'),
	(108, 'Dogrib', 'vie'),
	(109, 'Dinka', 'vie'),
	(110, 'Divehi; Dhivehi; Maldivian', 'vie'),
	(111, 'Dogri', 'vie'),
	(112, 'Dravidian (Other)', 'vie'),
	(113, 'Lower Sorbian', 'vie'),
	(114, 'Duala', 'vie'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'vie'),
	(116, 'Dutch; Flemish', 'vie'),
	(117, 'Dyula', 'vie'),
	(118, 'Dzongkha', 'vie'),
	(119, 'Efik', 'vie'),
	(120, 'Egyptian (Ancient)', 'vie'),
	(121, 'Ekajuk', 'vie'),
	(122, 'Elamite', 'vie'),
	(123, 'English', 'vie'),
	(124, 'English, Middle (1100-1500)', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(125, 'Esperanto', 'vie'),
	(126, 'Estonian', 'vie'),
	(127, 'Ewe', 'vie'),
	(128, 'Ewondo', 'vie'),
	(129, 'Fang', 'vie'),
	(130, 'Faroese', 'vie'),
	(131, 'Fanti', 'vie'),
	(132, 'Fijian', 'vie'),
	(133, 'Filipino; Pilipino', 'vie'),
	(134, 'Finnish', 'vie'),
	(135, 'Finno-Ugrian (Other)', 'vie'),
	(136, 'Fon', 'vie'),
	(137, 'French', 'vie'),
	(138, 'French, Middle (ca.1400-1600)', 'vie'),
	(139, 'French, Old (842-ca.1400)', 'vie'),
	(140, 'Northern Frisian', 'vie'),
	(141, 'Eastern Frisian', 'vie'),
	(142, 'Western Frisian', 'vie'),
	(143, 'Fulah', 'vie'),
	(144, 'Friulian', 'vie'),
	(145, 'Ga', 'vie'),
	(146, 'Gayo', 'vie'),
	(147, 'Gbaya', 'vie'),
	(148, 'Germanic (Other)', 'vie'),
	(149, 'Georgian', 'vie'),
	(150, 'German', 'vie'),
	(151, 'Geez', 'vie'),
	(152, 'Gilbertese', 'vie'),
	(153, 'Gaelic; Scottish Gaelic', 'vie'),
	(154, 'Irish', 'vie'),
	(155, 'Galician', 'vie'),
	(156, 'Manx', 'vie'),
	(157, 'German, Middle High (ca.1050-1500)', 'vie'),
	(158, 'German, Old High (ca.750-1050)', 'vie'),
	(159, 'Gondi', 'vie'),
	(160, 'Gorontalo', 'vie'),
	(161, 'Gothicanguage Association)', 'vie'),
	(162, 'Grebo', 'vie'),
	(163, 'Greek, Ancient (to 1453)', 'vie'),
	(164, 'Greek, Modern (1453-)', 'vie'),
	(165, 'Guarani', 'vie'),
	(166, 'Swiss German; Alemannic', 'vie'),
	(167, 'Gujarati', 'vie'),
	(168, 'Gwich''in', 'vie'),
	(169, 'Haida', 'vie'),
	(170, 'Haitian; Haitian Creole', 'vie'),
	(171, 'Hausa', 'vie'),
	(172, 'Hawaiian', 'vie'),
	(173, 'Hebrew', 'vie'),
	(174, 'Herero', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(175, 'Hiligaynon', 'vie'),
	(176, 'Himachali', 'vie'),
	(177, 'Hindi', 'vie'),
	(178, 'Hittite', 'vie'),
	(179, 'Hmong', 'vie'),
	(180, 'Hiri Motu', 'vie'),
	(181, 'Upper Sorbian', 'vie'),
	(182, 'Hungarian', 'vie'),
	(183, 'Hupa', 'vie'),
	(184, 'Iban', 'vie'),
	(185, 'Igbo', 'vie'),
	(186, 'Icelandic', 'vie'),
	(187, 'Ido', 'vie'),
	(188, 'Sichuan Yi', 'vie'),
	(189, 'Ijo languages', 'vie'),
	(190, 'Inuktitut', 'vie'),
	(191, 'Interlingue', 'vie'),
	(192, 'Iloko', 'vie'),
	(193, 'Interlingua (International Auxiliary L', 'vie'),
	(194, 'Indic (Other)', 'vie'),
	(195, 'Indonesian', 'vie'),
	(196, 'Indo-European (Other)', 'vie'),
	(197, 'Ingush', 'vie'),
	(198, 'Inupiaq', 'vie'),
	(199, 'Iranian (Other)', 'vie'),
	(200, 'Iroquoian languages', 'vie'),
	(201, 'Italian', 'vie'),
	(202, 'Javanese', 'vie'),
	(203, 'Lojban', 'vie'),
	(204, 'Japanese', 'vie'),
	(205, 'Judeo-Persian', 'vie'),
	(206, 'Judeo-Arabic', 'vie'),
	(207, 'Kara-Kalpak', 'vie'),
	(208, 'Kabyle', 'vie'),
	(209, 'Kachin; Jingpho', 'vie'),
	(210, 'Kalaallisut; Greenlandic', 'vie'),
	(211, 'Kamba', 'vie'),
	(212, 'Kannada', 'vie'),
	(213, 'Karen languages', 'vie'),
	(214, 'Kashmiri', 'vie'),
	(215, 'Kanuri', 'vie'),
	(216, 'Kawi', 'vie'),
	(217, 'Kazakh', 'vie'),
	(218, 'Kabardian', 'vie'),
	(219, 'Khasi', 'vie'),
	(220, 'Khoisan (Other)', 'vie'),
	(221, 'Central Khmer', 'vie'),
	(222, 'Khotanese', 'vie'),
	(223, 'Kikuyu; Gikuyu', 'vie'),
	(224, 'Kinyarwanda', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(225, 'Kirghiz; Kyrgyz', 'vie'),
	(226, 'Kimbundu', 'vie'),
	(227, 'Konkani', 'vie'),
	(228, 'Komi', 'vie'),
	(229, 'Kongo', 'vie'),
	(230, 'Korean', 'vie'),
	(231, 'Kosraean', 'vie'),
	(232, 'Kpelle', 'vie'),
	(233, 'Karachay-Balkar', 'vie'),
	(234, 'Karelian', 'vie'),
	(235, 'Kru languages', 'vie'),
	(236, 'Kurukh', 'vie'),
	(237, 'Kuanyama; Kwanyama', 'vie'),
	(238, 'Kumyk', 'vie'),
	(239, 'Kurdish', 'vie'),
	(240, 'Kutenai', 'vie'),
	(241, 'Ladino', 'vie'),
	(242, 'Lahnda', 'vie'),
	(243, 'Lamba', 'vie'),
	(244, 'Lao', 'vie'),
	(245, 'Latin', 'vie'),
	(246, 'Latvian', 'vie'),
	(247, 'Lezghian', 'vie'),
	(248, 'Limburgan; Limburger; Limburgish', 'vie'),
	(249, 'Lingala', 'vie'),
	(250, 'Lithuanian', 'vie'),
	(251, 'Mongo', 'vie'),
	(252, 'Lozi', 'vie'),
	(253, 'Luxembourgish; Letzeburgesch', 'vie'),
	(254, 'Luba-Lulua', 'vie'),
	(255, 'Luba-Katangaxon, Low', 'vie'),
	(256, 'Ganda', 'vie'),
	(257, 'Luiseno', 'vie'),
	(258, 'Lunda', 'vie'),
	(259, 'Luo (Kenya and Tanzania)', 'vie'),
	(260, 'Lushai', 'vie'),
	(261, 'Macedonian00E5l', 'vie'),
	(262, 'Madurese', 'vie'),
	(263, 'Magahi', 'vie'),
	(264, 'Marshallese', 'vie'),
	(265, 'Maithili', 'vie'),
	(266, 'Makasarl Nepal Bhasa', 'vie'),
	(267, 'Malayalam', 'vie'),
	(268, 'Mandingo', 'vie'),
	(269, 'Maori', 'vie'),
	(270, 'Austronesian (Other)', 'vie'),
	(271, 'Marathi', 'vie'),
	(272, 'Masai', 'vie'),
	(273, 'Malay', 'vie'),
	(274, 'Moksha', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(275, 'Mandar', 'vie'),
	(276, 'Mende', 'vie'),
	(277, 'Irish, Middle (900-1200)', 'vie'),
	(278, 'Mi''kmaq; Micmac', 'vie'),
	(279, 'Minangkabau', 'vie'),
	(280, 'Miscellaneous languages', 'vie'),
	(281, 'Mon-Khmer (Other)', 'vie'),
	(282, 'Malagasy', 'vie'),
	(283, 'Maltese', 'vie'),
	(284, 'Manchu', 'vie'),
	(285, 'Manipuri', 'vie'),
	(286, 'Manobo languages', 'vie'),
	(287, 'Mohawk', 'vie'),
	(288, 'Moldavian', 'vie'),
	(289, 'Mongolian', 'vie'),
	(290, 'Mossi', 'vie'),
	(291, 'Multiple languages', 'vie'),
	(292, 'Munda languages', 'vie'),
	(293, 'Creek', 'vie'),
	(294, 'Mirandese', 'vie'),
	(295, 'Marwari', 'vie'),
	(296, 'Mayan languages', 'vie'),
	(297, 'Erzya', 'vie'),
	(298, 'Nahuatl languages', 'vie'),
	(299, 'North American Indian', 'vie'),
	(300, 'Neapolitan', 'vie'),
	(301, 'Nauru', 'vie'),
	(302, 'Navajo; Navaho', 'vie'),
	(303, 'Ndebele, South; South Ndebele', 'vie'),
	(304, 'Ndebele, North; North Ndebele', 'vie'),
	(305, 'Ndonga', 'vie'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'vie'),
	(307, 'Nepali', 'vie'),
	(308, 'Nepal Bhasa; Newari', 'vie'),
	(309, 'Nias', 'vie'),
	(310, 'Niger-Kordofanian (Other)', 'vie'),
	(311, 'Niuean', 'vie'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'vie'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'vie'),
	(314, 'Nogai', 'vie'),
	(315, 'Norse, Old', 'vie'),
	(316, 'Norwegian', 'vie'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'vie'),
	(318, 'Nubian languages', 'vie'),
	(319, 'Classical Newari; Old Newari; Classica', 'vie'),
	(320, 'Chichewa; Chewa; Nyanja', 'vie'),
	(321, 'Nyamwezi', 'vie'),
	(322, 'Nyankole', 'vie'),
	(323, 'Nyoro', 'vie'),
	(324, 'Nzima', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(325, 'Occitan (post 1500); Provençal', 'vie'),
	(326, 'Ojibwa', 'vie'),
	(327, 'Oriya', 'vie'),
	(328, 'Oromo', 'vie'),
	(329, 'Osage', 'vie'),
	(330, 'Ossetian; Ossetic', 'vie'),
	(331, 'Turkish, Ottoman (1500-1928)', 'vie'),
	(332, 'Otomian languages', 'vie'),
	(333, 'Papuan (Other)', 'vie'),
	(334, 'Pangasinan', 'vie'),
	(335, 'Pahlavi', 'vie'),
	(336, 'Pampanga', 'vie'),
	(337, 'Panjabi; Punjabi', 'vie'),
	(338, 'Papiamento', 'vie'),
	(339, 'Palauan', 'vie'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'vie'),
	(341, 'Persian', 'vie'),
	(342, 'Philippine (Other)', 'vie'),
	(343, 'Phoenician', 'vie'),
	(344, 'Pali', 'vie'),
	(345, 'Polish', 'vie'),
	(346, 'Pohnpeian', 'vie'),
	(347, 'Portuguese', 'vie'),
	(348, 'Prakrit languages', 'vie'),
	(349, 'Provençal, Old (to 1500)', 'vie'),
	(350, 'Pushto', 'vie'),
	(351, 'Reserved for local use', 'vie'),
	(352, 'Quechua', 'vie'),
	(353, 'Rajasthani', 'vie'),
	(354, 'Rapanui', 'vie'),
	(355, 'Rarotongan; Cook Islands Maori', 'vie'),
	(356, 'Romance (Other)', 'vie'),
	(357, 'Romansh', 'vie'),
	(358, 'Romany', 'vie'),
	(359, 'Romanian', 'vie'),
	(360, 'Rundi', 'vie'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'vie'),
	(362, 'Russian', 'vie'),
	(363, 'Sandawe', 'vie'),
	(364, 'Sango', 'vie'),
	(365, 'Yakut', 'vie'),
	(366, 'South American Indian (Other)', 'vie'),
	(367, 'Salishan languages', 'vie'),
	(368, 'Samaritan Aramaic', 'vie'),
	(369, 'Sanskrit', 'vie'),
	(370, 'Sasak', 'vie'),
	(371, 'Santali', 'vie'),
	(372, 'Serbian', 'vie'),
	(373, 'Sicilian', 'vie'),
	(374, 'Scots', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(375, 'Croatian', 'vie'),
	(376, 'Selkup', 'vie'),
	(377, 'Semitic (Other)', 'vie'),
	(378, 'Irish, Old (to 900)', 'vie'),
	(379, 'Sign Languages', 'vie'),
	(380, 'Shan', 'vie'),
	(381, 'Sidamo', 'vie'),
	(382, 'Sinhala; Sinhalese', 'vie'),
	(383, 'Siouan languages', 'vie'),
	(384, 'Sino-Tibetan (Other)', 'vie'),
	(385, 'Slavic (Other)', 'vie'),
	(386, 'Slovak', 'vie'),
	(387, 'Slovenian', 'vie'),
	(388, 'Southern Sami', 'vie'),
	(389, 'Northern Sami', 'vie'),
	(390, 'Sami languages (Other)', 'vie'),
	(391, 'Lule Sami', 'vie'),
	(392, 'Inari Sami', 'vie'),
	(393, 'Samoan', 'vie'),
	(394, 'Skolt Sami', 'vie'),
	(395, 'Shona', 'vie'),
	(396, 'Sindhi', 'vie'),
	(397, 'Soninke', 'vie'),
	(398, 'Sogdian', 'vie'),
	(399, 'Somali', 'vie'),
	(400, 'Songhai languages', 'vie'),
	(401, 'Sotho, Southern', 'vie'),
	(402, 'Spanish; Castilian', 'vie'),
	(403, 'Sardinian; Zazaki', 'vie'),
	(404, 'Sranan Tongo', 'vie'),
	(405, 'Serer', 'vie'),
	(406, 'Nilo-Saharan (Other)', 'vie'),
	(407, 'Swati', 'vie'),
	(408, 'Sukuma', 'vie'),
	(409, 'Sundanese', 'vie'),
	(410, 'Susu', 'vie'),
	(411, 'Sumerian', 'vie'),
	(412, 'Swahili', 'vie'),
	(413, 'Swedish', 'vie'),
	(414, 'Syriac', 'vie'),
	(415, 'Tahitian', 'vie'),
	(416, 'Tai (Other)', 'vie'),
	(417, 'Tamil', 'vie'),
	(418, 'Tatar', 'vie'),
	(419, 'Telugu', 'vie'),
	(420, 'Timnendere)', 'vie'),
	(421, 'Tereno', 'vie'),
	(422, 'Tetum', 'vie'),
	(423, 'Tajik', 'vie'),
	(424, 'Tagalog', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(425, 'Thai', 'vie'),
	(426, 'Tibetan', 'vie'),
	(427, 'Tigre', 'vie'),
	(428, 'Tigrinya', 'vie'),
	(429, 'Tiv', 'vie'),
	(430, 'Tokelau', 'vie'),
	(431, 'Klingon; tlhIngan-Hol', 'vie'),
	(432, 'Tlingit', 'vie'),
	(433, 'Tamashek', 'vie'),
	(434, 'Tonga (Nyasa)', 'vie'),
	(435, 'Tonga (Tonga Islands)', 'vie'),
	(436, 'Tok Pisin', 'vie'),
	(437, 'Tsimshian', 'vie'),
	(438, 'Tswana', 'vie'),
	(439, 'Tsonga', 'vie'),
	(440, 'Turkmen', 'vie'),
	(441, 'Tumbuka', 'vie'),
	(442, 'Tupi languages', 'vie'),
	(443, 'Turkish', 'vie'),
	(444, 'Altaic (Other)', 'vie'),
	(445, 'Tuvalu', 'vie'),
	(446, 'Twi', 'vie'),
	(447, 'Tuvinian', 'vie'),
	(448, 'Udmurt', 'vie'),
	(449, 'Ugaritic', 'vie'),
	(450, 'Uighur; Uyghur', 'vie'),
	(451, 'Ukrainian', 'vie'),
	(452, 'Umbundu', 'vie'),
	(453, 'Undetermined', 'vie'),
	(454, 'Urdu', 'vie'),
	(455, 'Uzbek', 'vie'),
	(456, 'Vai', 'vie'),
	(457, 'Venda', 'vie'),
	(458, 'Vietnamese', 'vie'),
	(459, 'Volapük', 'vie'),
	(460, 'Votic', 'vie'),
	(461, 'Wakashan languages', 'vie'),
	(462, 'Walamo', 'vie'),
	(463, 'Waray', 'vie'),
	(464, 'Washo', 'vie'),
	(465, 'Welsh', 'vie'),
	(466, 'Sorbian languages', 'vie'),
	(467, 'Walloon', 'vie'),
	(468, 'Wolof', 'vie'),
	(469, 'Kalmyk; Oirat', 'vie'),
	(470, 'Xhosa', 'vie'),
	(471, 'Yao', 'vie'),
	(472, 'Yapese', 'vie'),
	(473, 'Yiddish', 'vie'),
	(474, 'Yoruba', 'vie');
INSERT INTO public.isolanguagesdes VALUES
	(475, 'Yupik languages', 'vie'),
	(476, 'Zapotec', 'vie'),
	(477, 'Zenaga', 'vie'),
	(478, 'Zhuang; Chuang', 'vie'),
	(479, 'Zande languages', 'vie'),
	(480, 'Zulu', 'vie'),
	(481, 'Zuni', 'vie'),
	(482, 'No linguistic content', 'vie'),
	(483, 'N''Ko', 'vie'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'vie'),
	(1, 'Afar', 'pol'),
	(2, 'Abkhazian', 'pol'),
	(3, 'Achinese', 'pol'),
	(4, 'Acoli', 'pol'),
	(5, 'Adangme', 'pol'),
	(6, 'Adyghe; Adygei', 'pol'),
	(7, 'Afro-Asiatic (Other)', 'pol'),
	(8, 'Afrihili', 'pol'),
	(9, 'Afrikaans', 'pol'),
	(10, 'Ainu', 'pol'),
	(11, 'Akan', 'pol'),
	(12, 'Akkadian', 'pol'),
	(13, 'Albanian', 'pol'),
	(14, 'Aleut', 'pol'),
	(15, 'Algonquian languages', 'pol'),
	(16, 'Southern Altai', 'pol'),
	(17, 'Amharic', 'pol'),
	(18, 'English, Old (ca.450-1100)', 'pol'),
	(19, 'Angika', 'pol'),
	(20, 'Apache languages', 'pol'),
	(21, 'Arabic', 'pol'),
	(22, 'Aramaic', 'pol'),
	(23, 'Aragonese', 'pol'),
	(24, 'Armenian', 'pol'),
	(25, 'Mapudungun; Mapuche', 'pol'),
	(26, 'Arapaho', 'pol'),
	(27, 'Artificial (Other)', 'pol'),
	(28, 'Arawak', 'pol'),
	(29, 'Assamese', 'pol'),
	(30, 'Asturian; Bable', 'pol'),
	(31, 'Athapascan languages', 'pol'),
	(32, 'Australian languages', 'pol'),
	(33, 'Avaric', 'pol'),
	(34, 'Avestan', 'pol'),
	(35, 'Awadhi', 'pol'),
	(36, 'Aymara', 'pol'),
	(37, 'Azerbaijani', 'pol'),
	(38, 'Banda languages', 'pol'),
	(39, 'Bamileke languages', 'pol'),
	(40, 'Bashkir', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(41, 'Baluchi', 'pol'),
	(42, 'Bambara', 'pol'),
	(43, 'Balinese', 'pol'),
	(44, 'Basque', 'pol'),
	(45, 'Basa', 'pol'),
	(46, 'Baltic (Other)', 'pol'),
	(47, 'Beja', 'pol'),
	(48, 'Belarusian', 'pol'),
	(49, 'Bemba', 'pol'),
	(50, 'Bengali', 'pol'),
	(51, 'Berber (Other)', 'pol'),
	(52, 'Bhojpuri', 'pol'),
	(53, 'Bihari', 'pol'),
	(54, 'Bikol', 'pol'),
	(55, 'Bini; Edo', 'pol'),
	(56, 'Bislama', 'pol'),
	(57, 'Siksika', 'pol'),
	(58, 'Bantu (Other)', 'pol'),
	(59, 'Bosnian', 'pol'),
	(60, 'Braj', 'pol'),
	(61, 'Breton', 'pol'),
	(62, 'Batak languages', 'pol'),
	(63, 'Buriat', 'pol'),
	(64, 'Buginese', 'pol'),
	(65, 'Bulgarian', 'pol'),
	(66, 'Burmese', 'pol'),
	(67, 'Blin; Bilin', 'pol'),
	(68, 'Caddo', 'pol'),
	(69, 'Central American Indian (Other)', 'pol'),
	(70, 'Galibi Carib', 'pol'),
	(71, 'Catalan; Valencian', 'pol'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'pol'),
	(73, 'Cebuano', 'pol'),
	(74, 'Celtic (Other)', 'pol'),
	(75, 'Chamorro', 'pol'),
	(76, 'Chibcha', 'pol'),
	(77, 'Chechen', 'pol'),
	(78, 'Chagataier)', 'pol'),
	(79, 'Chinese(Other)', 'pol'),
	(80, 'Chuukese', 'pol'),
	(81, 'Mari', 'pol'),
	(82, 'Chinook jargon', 'pol'),
	(83, 'Choctaw', 'pol'),
	(84, 'Chipewyan', 'pol'),
	(85, 'Cherokee', 'pol'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'pol'),
	(87, 'Chuvash', 'pol'),
	(88, 'Cheyenne', 'pol'),
	(89, 'Chamic languages', 'pol'),
	(90, 'Coptic', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(91, 'Cornish', 'pol'),
	(92, 'Corsican', 'pol'),
	(93, 'Creoles and pidgins, English based (Ot', 'pol'),
	(94, 'Creoles and pidgins, French-based (Oth', 'pol'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'pol'),
	(96, 'Cree', 'pol'),
	(97, 'Crimean Tatar; Crimean Turkish', 'pol'),
	(98, 'Creoles and pidgins (Other)', 'pol'),
	(99, 'Kashubian', 'pol'),
	(100, 'Cushitic (Other)', 'pol'),
	(101, 'Czech', 'pol'),
	(102, 'Dakota', 'pol'),
	(103, 'Danish', 'pol'),
	(104, 'Dargwa', 'pol'),
	(105, 'Land Dayak languages', 'pol'),
	(106, 'Delaware', 'pol'),
	(107, 'Slave (Athapascan)', 'pol'),
	(108, 'Dogrib', 'pol'),
	(109, 'Dinka', 'pol'),
	(110, 'Divehi; Dhivehi; Maldivian', 'pol'),
	(111, 'Dogri', 'pol'),
	(112, 'Dravidian (Other)', 'pol'),
	(113, 'Lower Sorbian', 'pol'),
	(114, 'Duala', 'pol'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'pol'),
	(116, 'Dutch; Flemish', 'pol'),
	(117, 'Dyula', 'pol'),
	(118, 'Dzongkha', 'pol'),
	(119, 'Efik', 'pol'),
	(120, 'Egyptian (Ancient)', 'pol'),
	(121, 'Ekajuk', 'pol'),
	(122, 'Elamite', 'pol'),
	(123, 'English', 'pol'),
	(124, 'English, Middle (1100-1500)', 'pol'),
	(125, 'Esperanto', 'pol'),
	(126, 'Estonian', 'pol'),
	(127, 'Ewe', 'pol'),
	(128, 'Ewondo', 'pol'),
	(129, 'Fang', 'pol'),
	(130, 'Faroese', 'pol'),
	(131, 'Fanti', 'pol'),
	(132, 'Fijian', 'pol'),
	(133, 'Filipino; Pilipino', 'pol'),
	(134, 'Finnish', 'pol'),
	(135, 'Finno-Ugrian (Other)', 'pol'),
	(136, 'Fon', 'pol'),
	(137, 'French', 'pol'),
	(138, 'French, Middle (ca.1400-1600)', 'pol'),
	(139, 'French, Old (842-ca.1400)', 'pol'),
	(140, 'Northern Frisian', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(141, 'Eastern Frisian', 'pol'),
	(142, 'Western Frisian', 'pol'),
	(143, 'Fulah', 'pol'),
	(144, 'Friulian', 'pol'),
	(145, 'Ga', 'pol'),
	(146, 'Gayo', 'pol'),
	(147, 'Gbaya', 'pol'),
	(148, 'Germanic (Other)', 'pol'),
	(149, 'Georgian', 'pol'),
	(150, 'German', 'pol'),
	(151, 'Geez', 'pol'),
	(152, 'Gilbertese', 'pol'),
	(153, 'Gaelic; Scottish Gaelic', 'pol'),
	(154, 'Irish', 'pol'),
	(155, 'Galician', 'pol'),
	(156, 'Manx', 'pol'),
	(157, 'German, Middle High (ca.1050-1500)', 'pol'),
	(158, 'German, Old High (ca.750-1050)', 'pol'),
	(159, 'Gondi', 'pol'),
	(160, 'Gorontalo', 'pol'),
	(161, 'Gothicanguage Association)', 'pol'),
	(162, 'Grebo', 'pol'),
	(163, 'Greek, Ancient (to 1453)', 'pol'),
	(164, 'Greek, Modern (1453-)', 'pol'),
	(165, 'Guarani', 'pol'),
	(166, 'Swiss German; Alemannic', 'pol'),
	(167, 'Gujarati', 'pol'),
	(168, 'Gwich''in', 'pol'),
	(169, 'Haida', 'pol'),
	(170, 'Haitian; Haitian Creole', 'pol'),
	(171, 'Hausa', 'pol'),
	(172, 'Hawaiian', 'pol'),
	(173, 'Hebrew', 'pol'),
	(174, 'Herero', 'pol'),
	(175, 'Hiligaynon', 'pol'),
	(176, 'Himachali', 'pol'),
	(177, 'Hindi', 'pol'),
	(178, 'Hittite', 'pol'),
	(179, 'Hmong', 'pol'),
	(180, 'Hiri Motu', 'pol'),
	(181, 'Upper Sorbian', 'pol'),
	(182, 'Hungarian', 'pol'),
	(183, 'Hupa', 'pol'),
	(184, 'Iban', 'pol'),
	(185, 'Igbo', 'pol'),
	(186, 'Icelandic', 'pol'),
	(187, 'Ido', 'pol'),
	(188, 'Sichuan Yi', 'pol'),
	(189, 'Ijo languages', 'pol'),
	(190, 'Inuktitut', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(191, 'Interlingue', 'pol'),
	(192, 'Iloko', 'pol'),
	(193, 'Interlingua (International Auxiliary L', 'pol'),
	(194, 'Indic (Other)', 'pol'),
	(195, 'Indonesian', 'pol'),
	(196, 'Indo-European (Other)', 'pol'),
	(197, 'Ingush', 'pol'),
	(198, 'Inupiaq', 'pol'),
	(199, 'Iranian (Other)', 'pol'),
	(200, 'Iroquoian languages', 'pol'),
	(201, 'Italian', 'pol'),
	(202, 'Javanese', 'pol'),
	(203, 'Lojban', 'pol'),
	(204, 'Japanese', 'pol'),
	(205, 'Judeo-Persian', 'pol'),
	(206, 'Judeo-Arabic', 'pol'),
	(207, 'Kara-Kalpak', 'pol'),
	(208, 'Kabyle', 'pol'),
	(209, 'Kachin; Jingpho', 'pol'),
	(210, 'Kalaallisut; Greenlandic', 'pol'),
	(211, 'Kamba', 'pol'),
	(212, 'Kannada', 'pol'),
	(213, 'Karen languages', 'pol'),
	(214, 'Kashmiri', 'pol'),
	(215, 'Kanuri', 'pol'),
	(216, 'Kawi', 'pol'),
	(217, 'Kazakh', 'pol'),
	(218, 'Kabardian', 'pol'),
	(219, 'Khasi', 'pol'),
	(220, 'Khoisan (Other)', 'pol'),
	(221, 'Central Khmer', 'pol'),
	(222, 'Khotanese', 'pol'),
	(223, 'Kikuyu; Gikuyu', 'pol'),
	(224, 'Kinyarwanda', 'pol'),
	(225, 'Kirghiz; Kyrgyz', 'pol'),
	(226, 'Kimbundu', 'pol'),
	(227, 'Konkani', 'pol'),
	(228, 'Komi', 'pol'),
	(229, 'Kongo', 'pol'),
	(230, 'Korean', 'pol'),
	(231, 'Kosraean', 'pol'),
	(232, 'Kpelle', 'pol'),
	(233, 'Karachay-Balkar', 'pol'),
	(234, 'Karelian', 'pol'),
	(235, 'Kru languages', 'pol'),
	(236, 'Kurukh', 'pol'),
	(237, 'Kuanyama; Kwanyama', 'pol'),
	(238, 'Kumyk', 'pol'),
	(239, 'Kurdish', 'pol'),
	(240, 'Kutenai', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(241, 'Ladino', 'pol'),
	(242, 'Lahnda', 'pol'),
	(243, 'Lamba', 'pol'),
	(244, 'Lao', 'pol'),
	(245, 'Latin', 'pol'),
	(246, 'Latvian', 'pol'),
	(247, 'Lezghian', 'pol'),
	(248, 'Limburgan; Limburger; Limburgish', 'pol'),
	(249, 'Lingala', 'pol'),
	(250, 'Lithuanian', 'pol'),
	(251, 'Mongo', 'pol'),
	(252, 'Lozi', 'pol'),
	(253, 'Luxembourgish; Letzeburgesch', 'pol'),
	(254, 'Luba-Lulua', 'pol'),
	(255, 'Luba-Katangaxon, Low', 'pol'),
	(256, 'Ganda', 'pol'),
	(257, 'Luiseno', 'pol'),
	(258, 'Lunda', 'pol'),
	(259, 'Luo (Kenya and Tanzania)', 'pol'),
	(260, 'Lushai', 'pol'),
	(261, 'Macedonian00E5l', 'pol'),
	(262, 'Madurese', 'pol'),
	(263, 'Magahi', 'pol'),
	(264, 'Marshallese', 'pol'),
	(265, 'Maithili', 'pol'),
	(266, 'Makasarl Nepal Bhasa', 'pol'),
	(267, 'Malayalam', 'pol'),
	(268, 'Mandingo', 'pol'),
	(269, 'Maori', 'pol'),
	(270, 'Austronesian (Other)', 'pol'),
	(271, 'Marathi', 'pol'),
	(272, 'Masai', 'pol'),
	(273, 'Malay', 'pol'),
	(274, 'Moksha', 'pol'),
	(275, 'Mandar', 'pol'),
	(276, 'Mende', 'pol'),
	(277, 'Irish, Middle (900-1200)', 'pol'),
	(278, 'Mi''kmaq; Micmac', 'pol'),
	(279, 'Minangkabau', 'pol'),
	(280, 'Miscellaneous languages', 'pol'),
	(281, 'Mon-Khmer (Other)', 'pol'),
	(282, 'Malagasy', 'pol'),
	(283, 'Maltese', 'pol'),
	(284, 'Manchu', 'pol'),
	(285, 'Manipuri', 'pol'),
	(286, 'Manobo languages', 'pol'),
	(287, 'Mohawk', 'pol'),
	(288, 'Moldavian', 'pol'),
	(289, 'Mongolian', 'pol'),
	(290, 'Mossi', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(291, 'Multiple languages', 'pol'),
	(292, 'Munda languages', 'pol'),
	(293, 'Creek', 'pol'),
	(294, 'Mirandese', 'pol'),
	(295, 'Marwari', 'pol'),
	(296, 'Mayan languages', 'pol'),
	(297, 'Erzya', 'pol'),
	(298, 'Nahuatl languages', 'pol'),
	(299, 'North American Indian', 'pol'),
	(300, 'Neapolitan', 'pol'),
	(301, 'Nauru', 'pol'),
	(302, 'Navajo; Navaho', 'pol'),
	(303, 'Ndebele, South; South Ndebele', 'pol'),
	(304, 'Ndebele, North; North Ndebele', 'pol'),
	(305, 'Ndonga', 'pol'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'pol'),
	(307, 'Nepali', 'pol'),
	(308, 'Nepal Bhasa; Newari', 'pol'),
	(309, 'Nias', 'pol'),
	(310, 'Niger-Kordofanian (Other)', 'pol'),
	(311, 'Niuean', 'pol'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'pol'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'pol'),
	(314, 'Nogai', 'pol'),
	(315, 'Norse, Old', 'pol'),
	(316, 'Norwegian', 'pol'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'pol'),
	(318, 'Nubian languages', 'pol'),
	(319, 'Classical Newari; Old Newari; Classica', 'pol'),
	(320, 'Chichewa; Chewa; Nyanja', 'pol'),
	(321, 'Nyamwezi', 'pol'),
	(322, 'Nyankole', 'pol'),
	(323, 'Nyoro', 'pol'),
	(324, 'Nzima', 'pol'),
	(325, 'Occitan (post 1500); Provençal', 'pol'),
	(326, 'Ojibwa', 'pol'),
	(327, 'Oriya', 'pol'),
	(328, 'Oromo', 'pol'),
	(329, 'Osage', 'pol'),
	(330, 'Ossetian; Ossetic', 'pol'),
	(331, 'Turkish, Ottoman (1500-1928)', 'pol'),
	(332, 'Otomian languages', 'pol'),
	(333, 'Papuan (Other)', 'pol'),
	(334, 'Pangasinan', 'pol'),
	(335, 'Pahlavi', 'pol'),
	(336, 'Pampanga', 'pol'),
	(337, 'Panjabi; Punjabi', 'pol'),
	(338, 'Papiamento', 'pol'),
	(339, 'Palauan', 'pol'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(341, 'Persian', 'pol'),
	(342, 'Philippine (Other)', 'pol'),
	(343, 'Phoenician', 'pol'),
	(344, 'Pali', 'pol'),
	(345, 'Polish', 'pol'),
	(346, 'Pohnpeian', 'pol'),
	(347, 'Portuguese', 'pol'),
	(348, 'Prakrit languages', 'pol'),
	(349, 'Provençal, Old (to 1500)', 'pol'),
	(350, 'Pushto', 'pol'),
	(351, 'Reserved for local use', 'pol'),
	(352, 'Quechua', 'pol'),
	(353, 'Rajasthani', 'pol'),
	(354, 'Rapanui', 'pol'),
	(355, 'Rarotongan; Cook Islands Maori', 'pol'),
	(356, 'Romance (Other)', 'pol'),
	(357, 'Romansh', 'pol'),
	(358, 'Romany', 'pol'),
	(359, 'Romanian', 'pol'),
	(360, 'Rundi', 'pol'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'pol'),
	(362, 'Russian', 'pol'),
	(363, 'Sandawe', 'pol'),
	(364, 'Sango', 'pol'),
	(365, 'Yakut', 'pol'),
	(366, 'South American Indian (Other)', 'pol'),
	(367, 'Salishan languages', 'pol'),
	(368, 'Samaritan Aramaic', 'pol'),
	(369, 'Sanskrit', 'pol'),
	(370, 'Sasak', 'pol'),
	(371, 'Santali', 'pol'),
	(372, 'Serbian', 'pol'),
	(373, 'Sicilian', 'pol'),
	(374, 'Scots', 'pol'),
	(375, 'Croatian', 'pol'),
	(376, 'Selkup', 'pol'),
	(377, 'Semitic (Other)', 'pol'),
	(378, 'Irish, Old (to 900)', 'pol'),
	(379, 'Sign Languages', 'pol'),
	(380, 'Shan', 'pol'),
	(381, 'Sidamo', 'pol'),
	(382, 'Sinhala; Sinhalese', 'pol'),
	(383, 'Siouan languages', 'pol'),
	(384, 'Sino-Tibetan (Other)', 'pol'),
	(385, 'Slavic (Other)', 'pol'),
	(386, 'Slovak', 'pol'),
	(387, 'Slovenian', 'pol'),
	(388, 'Southern Sami', 'pol'),
	(389, 'Northern Sami', 'pol'),
	(390, 'Sami languages (Other)', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(391, 'Lule Sami', 'pol'),
	(392, 'Inari Sami', 'pol'),
	(393, 'Samoan', 'pol'),
	(394, 'Skolt Sami', 'pol'),
	(395, 'Shona', 'pol'),
	(396, 'Sindhi', 'pol'),
	(397, 'Soninke', 'pol'),
	(398, 'Sogdian', 'pol'),
	(399, 'Somali', 'pol'),
	(400, 'Songhai languages', 'pol'),
	(401, 'Sotho, Southern', 'pol'),
	(402, 'Spanish; Castilian', 'pol'),
	(403, 'Sardinian; Zazaki', 'pol'),
	(404, 'Sranan Tongo', 'pol'),
	(405, 'Serer', 'pol'),
	(406, 'Nilo-Saharan (Other)', 'pol'),
	(407, 'Swati', 'pol'),
	(408, 'Sukuma', 'pol'),
	(409, 'Sundanese', 'pol'),
	(410, 'Susu', 'pol'),
	(411, 'Sumerian', 'pol'),
	(412, 'Swahili', 'pol'),
	(413, 'Swedish', 'pol'),
	(414, 'Syriac', 'pol'),
	(415, 'Tahitian', 'pol'),
	(416, 'Tai (Other)', 'pol'),
	(417, 'Tamil', 'pol'),
	(418, 'Tatar', 'pol'),
	(419, 'Telugu', 'pol'),
	(420, 'Timnendere)', 'pol'),
	(421, 'Tereno', 'pol'),
	(422, 'Tetum', 'pol'),
	(423, 'Tajik', 'pol'),
	(424, 'Tagalog', 'pol'),
	(425, 'Thai', 'pol'),
	(426, 'Tibetan', 'pol'),
	(427, 'Tigre', 'pol'),
	(428, 'Tigrinya', 'pol'),
	(429, 'Tiv', 'pol'),
	(430, 'Tokelau', 'pol'),
	(431, 'Klingon; tlhIngan-Hol', 'pol'),
	(432, 'Tlingit', 'pol'),
	(433, 'Tamashek', 'pol'),
	(434, 'Tonga (Nyasa)', 'pol'),
	(435, 'Tonga (Tonga Islands)', 'pol'),
	(436, 'Tok Pisin', 'pol'),
	(437, 'Tsimshian', 'pol'),
	(438, 'Tswana', 'pol'),
	(439, 'Tsonga', 'pol'),
	(440, 'Turkmen', 'pol');
INSERT INTO public.isolanguagesdes VALUES
	(441, 'Tumbuka', 'pol'),
	(442, 'Tupi languages', 'pol'),
	(443, 'Turkish', 'pol'),
	(444, 'Altaic (Other)', 'pol'),
	(445, 'Tuvalu', 'pol'),
	(446, 'Twi', 'pol'),
	(447, 'Tuvinian', 'pol'),
	(448, 'Udmurt', 'pol'),
	(449, 'Ugaritic', 'pol'),
	(450, 'Uighur; Uyghur', 'pol'),
	(451, 'Ukrainian', 'pol'),
	(452, 'Umbundu', 'pol'),
	(453, 'Undetermined', 'pol'),
	(454, 'Urdu', 'pol'),
	(455, 'Uzbek', 'pol'),
	(456, 'Vai', 'pol'),
	(457, 'Venda', 'pol'),
	(458, 'Vietnamese', 'pol'),
	(459, 'Volapük', 'pol'),
	(460, 'Votic', 'pol'),
	(461, 'Wakashan languages', 'pol'),
	(462, 'Walamo', 'pol'),
	(463, 'Waray', 'pol'),
	(464, 'Washo', 'pol'),
	(465, 'Welsh', 'pol'),
	(466, 'Sorbian languages', 'pol'),
	(467, 'Walloon', 'pol'),
	(468, 'Wolof', 'pol'),
	(469, 'Kalmyk; Oirat', 'pol'),
	(470, 'Xhosa', 'pol'),
	(471, 'Yao', 'pol'),
	(472, 'Yapese', 'pol'),
	(473, 'Yiddish', 'pol'),
	(474, 'Yoruba', 'pol'),
	(475, 'Yupik languages', 'pol'),
	(476, 'Zapotec', 'pol'),
	(477, 'Zenaga', 'pol'),
	(478, 'Zhuang; Chuang', 'pol'),
	(479, 'Zande languages', 'pol'),
	(480, 'Zulu', 'pol'),
	(481, 'Zuni', 'pol'),
	(482, 'No linguistic content', 'pol'),
	(483, 'N''Ko', 'pol'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'pol'),
	(1, 'Afar [SK]', 'slo'),
	(2, 'Abkhazian [SK]', 'slo'),
	(3, 'Achinese [SK]', 'slo'),
	(4, 'Acoli [SK]', 'slo'),
	(5, 'Adangme [SK]', 'slo'),
	(6, 'Adyghe; Adygei [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(7, 'Afro-Asiatic (Other) [SK]', 'slo'),
	(8, 'Afrihili [SK]', 'slo'),
	(9, 'Afrikaans [SK]', 'slo'),
	(10, 'Ainu [SK]', 'slo'),
	(11, 'Akan [SK]', 'slo'),
	(12, 'Akkadian [SK]', 'slo'),
	(13, 'Albanian [SK]', 'slo'),
	(14, 'Aleut [SK]', 'slo'),
	(15, 'Algonquian languages [SK]', 'slo'),
	(16, 'Southern Altai [SK]', 'slo'),
	(17, 'Amharic [SK]', 'slo'),
	(18, 'English, Old (ca.450-1100) [SK]', 'slo'),
	(19, 'Angika [SK]', 'slo'),
	(20, 'Apache languages [SK]', 'slo'),
	(21, 'Arabic [SK]', 'slo'),
	(22, 'Aramaic [SK]', 'slo'),
	(23, 'Aragonese [SK]', 'slo'),
	(24, 'Armenian [SK]', 'slo'),
	(25, 'Mapudungun; Mapuche [SK]', 'slo'),
	(26, 'Arapaho [SK]', 'slo'),
	(27, 'Artificial (Other) [SK]', 'slo'),
	(28, 'Arawak [SK]', 'slo'),
	(29, 'Assamese [SK]', 'slo'),
	(30, 'Asturian; Bable [SK]', 'slo'),
	(31, 'Athapascan languages [SK]', 'slo'),
	(32, 'Australian languages [SK]', 'slo'),
	(33, 'Avaric [SK]', 'slo'),
	(34, 'Avestan [SK]', 'slo'),
	(35, 'Awadhi [SK]', 'slo'),
	(36, 'Aymara [SK]', 'slo'),
	(37, 'Azerbaijani [SK]', 'slo'),
	(38, 'Banda languages [SK]', 'slo'),
	(39, 'Bamileke languages [SK]', 'slo'),
	(40, 'Bashkir [SK]', 'slo'),
	(41, 'Baluchi [SK]', 'slo'),
	(42, 'Bambara [SK]', 'slo'),
	(43, 'Balinese [SK]', 'slo'),
	(44, 'Basque [SK]', 'slo'),
	(45, 'Basa [SK]', 'slo'),
	(46, 'Baltic (Other) [SK]', 'slo'),
	(47, 'Beja [SK]', 'slo'),
	(48, 'Belarusian [SK]', 'slo'),
	(49, 'Bemba [SK]', 'slo'),
	(50, 'Bengali [SK]', 'slo'),
	(51, 'Berber (Other) [SK]', 'slo'),
	(52, 'Bhojpuri [SK]', 'slo'),
	(53, 'Bihari [SK]', 'slo'),
	(54, 'Bikol [SK]', 'slo'),
	(55, 'Bini; Edo [SK]', 'slo'),
	(56, 'Bislama [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(57, 'Siksika [SK]', 'slo'),
	(58, 'Bantu (Other) [SK]', 'slo'),
	(59, 'Bosnian [SK]', 'slo'),
	(60, 'Braj [SK]', 'slo'),
	(61, 'Breton [SK]', 'slo'),
	(62, 'Batak languages [SK]', 'slo'),
	(63, 'Buriat [SK]', 'slo'),
	(64, 'Buginese [SK]', 'slo'),
	(65, 'Bulgarian [SK]', 'slo'),
	(66, 'Burmese [SK]', 'slo'),
	(67, 'Blin; Bilin [SK]', 'slo'),
	(68, 'Caddo [SK]', 'slo'),
	(69, 'Central American Indian (Other) [SK]', 'slo'),
	(70, 'Galibi Carib [SK]', 'slo'),
	(71, 'Catalan; Valencian [SK]', 'slo'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare [SK]', 'slo'),
	(73, 'Cebuano [SK]', 'slo'),
	(74, 'Celtic (Other) [SK]', 'slo'),
	(75, 'Chamorro [SK]', 'slo'),
	(76, 'Chibcha [SK]', 'slo'),
	(77, 'Chechen [SK]', 'slo'),
	(78, 'Chagataier) [SK]', 'slo'),
	(79, 'Chinese(Other) [SK]', 'slo'),
	(80, 'Chuukese [SK]', 'slo'),
	(81, 'Mari [SK]', 'slo'),
	(82, 'Chinook jargon [SK]', 'slo'),
	(83, 'Choctaw [SK]', 'slo'),
	(84, 'Chipewyan [SK]', 'slo'),
	(85, 'Cherokee [SK]', 'slo'),
	(86, 'Church Slavic; Old Slavonic; Church Sl [SK]', 'slo'),
	(87, 'Chuvash [SK]', 'slo'),
	(88, 'Cheyenne [SK]', 'slo'),
	(89, 'Chamic languages [SK]', 'slo'),
	(90, 'Coptic [SK]', 'slo'),
	(91, 'Cornish [SK]', 'slo'),
	(92, 'Corsican [SK]', 'slo'),
	(93, 'Creoles and pidgins, English based (Ot [SK]', 'slo'),
	(94, 'Creoles and pidgins, French-based (Oth [SK]', 'slo'),
	(95, 'Creoles and pidgins, Portuguese-based  [SK]', 'slo'),
	(96, 'Cree [SK]', 'slo'),
	(97, 'Crimean Tatar; Crimean Turkish [SK]', 'slo'),
	(98, 'Creoles and pidgins (Other) [SK]', 'slo'),
	(99, 'Kashubian [SK]', 'slo'),
	(100, 'Cushitic (Other) [SK]', 'slo'),
	(101, 'Czech [SK]', 'slo'),
	(102, 'Dakota [SK]', 'slo'),
	(103, 'Danish [SK]', 'slo'),
	(104, 'Dargwa [SK]', 'slo'),
	(105, 'Land Dayak languages [SK]', 'slo'),
	(106, 'Delaware [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(107, 'Slave (Athapascan) [SK]', 'slo'),
	(108, 'Dogrib [SK]', 'slo'),
	(109, 'Dinka [SK]', 'slo'),
	(110, 'Divehi; Dhivehi; Maldivian [SK]', 'slo'),
	(111, 'Dogri [SK]', 'slo'),
	(112, 'Dravidian (Other) [SK]', 'slo'),
	(113, 'Lower Sorbian [SK]', 'slo'),
	(114, 'Duala [SK]', 'slo'),
	(115, 'Dutch, Middle (ca.1050-1350) [SK]', 'slo'),
	(116, 'Dutch; Flemish [SK]', 'slo'),
	(117, 'Dyula [SK]', 'slo'),
	(118, 'Dzongkha [SK]', 'slo'),
	(119, 'Efik [SK]', 'slo'),
	(120, 'Egyptian (Ancient) [SK]', 'slo'),
	(121, 'Ekajuk [SK]', 'slo'),
	(122, 'Elamite [SK]', 'slo'),
	(123, 'English [SK]', 'slo'),
	(124, 'English, Middle (1100-1500) [SK]', 'slo'),
	(125, 'Esperanto [SK]', 'slo'),
	(126, 'Estonian [SK]', 'slo'),
	(127, 'Ewe [SK]', 'slo'),
	(128, 'Ewondo [SK]', 'slo'),
	(129, 'Fang [SK]', 'slo'),
	(130, 'Faroese [SK]', 'slo'),
	(131, 'Fanti [SK]', 'slo'),
	(132, 'Fijian [SK]', 'slo'),
	(133, 'Filipino; Pilipino [SK]', 'slo'),
	(134, 'Finnish [SK]', 'slo'),
	(135, 'Finno-Ugrian (Other) [SK]', 'slo'),
	(136, 'Fon [SK]', 'slo'),
	(137, 'French [SK]', 'slo'),
	(138, 'French, Middle (ca.1400-1600) [SK]', 'slo'),
	(139, 'French, Old (842-ca.1400) [SK]', 'slo'),
	(140, 'Northern Frisian [SK]', 'slo'),
	(141, 'Eastern Frisian [SK]', 'slo'),
	(142, 'Western Frisian [SK]', 'slo'),
	(143, 'Fulah [SK]', 'slo'),
	(144, 'Friulian [SK]', 'slo'),
	(145, 'Ga [SK]', 'slo'),
	(146, 'Gayo [SK]', 'slo'),
	(147, 'Gbaya [SK]', 'slo'),
	(148, 'Germanic (Other) [SK]', 'slo'),
	(149, 'Georgian [SK]', 'slo'),
	(150, 'German [SK]', 'slo'),
	(151, 'Geez [SK]', 'slo'),
	(152, 'Gilbertese [SK]', 'slo'),
	(153, 'Gaelic; Scottish Gaelic [SK]', 'slo'),
	(154, 'Irish [SK]', 'slo'),
	(155, 'Galician [SK]', 'slo'),
	(156, 'Manx [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(157, 'German, Middle High (ca.1050-1500) [SK]', 'slo'),
	(158, 'German, Old High (ca.750-1050) [SK]', 'slo'),
	(159, 'Gondi [SK]', 'slo'),
	(160, 'Gorontalo [SK]', 'slo'),
	(161, 'Gothicanguage Association) [SK]', 'slo'),
	(162, 'Grebo [SK]', 'slo'),
	(163, 'Greek, Ancient (to 1453) [SK]', 'slo'),
	(164, 'Greek, Modern (1453-) [SK]', 'slo'),
	(165, 'Guarani [SK]', 'slo'),
	(166, 'Swiss German; Alemannic [SK]', 'slo'),
	(167, 'Gujarati [SK]', 'slo'),
	(168, 'Gwich''in [SK]', 'slo'),
	(169, 'Haida [SK]', 'slo'),
	(170, 'Haitian; Haitian Creole [SK]', 'slo'),
	(171, 'Hausa [SK]', 'slo'),
	(172, 'Hawaiian [SK]', 'slo'),
	(173, 'Hebrew [SK]', 'slo'),
	(174, 'Herero [SK]', 'slo'),
	(175, 'Hiligaynon [SK]', 'slo'),
	(176, 'Himachali [SK]', 'slo'),
	(177, 'Hindi [SK]', 'slo'),
	(178, 'Hittite [SK]', 'slo'),
	(179, 'Hmong [SK]', 'slo'),
	(180, 'Hiri Motu [SK]', 'slo'),
	(181, 'Upper Sorbian [SK]', 'slo'),
	(182, 'Hungarian [SK]', 'slo'),
	(183, 'Hupa [SK]', 'slo'),
	(184, 'Iban [SK]', 'slo'),
	(185, 'Igbo [SK]', 'slo'),
	(186, 'Icelandic [SK]', 'slo'),
	(187, 'Ido [SK]', 'slo'),
	(188, 'Sichuan Yi [SK]', 'slo'),
	(189, 'Ijo languages [SK]', 'slo'),
	(190, 'Inuktitut [SK]', 'slo'),
	(191, 'Interlingue [SK]', 'slo'),
	(192, 'Iloko [SK]', 'slo'),
	(193, 'Interlingua (International Auxiliary L [SK]', 'slo'),
	(194, 'Indic (Other) [SK]', 'slo'),
	(195, 'Indonesian [SK]', 'slo'),
	(196, 'Indo-European (Other) [SK]', 'slo'),
	(197, 'Ingush [SK]', 'slo'),
	(198, 'Inupiaq [SK]', 'slo'),
	(199, 'Iranian (Other) [SK]', 'slo'),
	(200, 'Iroquoian languages [SK]', 'slo'),
	(201, 'Italian [SK]', 'slo'),
	(202, 'Javanese [SK]', 'slo'),
	(203, 'Lojban [SK]', 'slo'),
	(204, 'Japanese [SK]', 'slo'),
	(205, 'Judeo-Persian [SK]', 'slo'),
	(206, 'Judeo-Arabic [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(207, 'Kara-Kalpak [SK]', 'slo'),
	(208, 'Kabyle [SK]', 'slo'),
	(209, 'Kachin; Jingpho [SK]', 'slo'),
	(210, 'Kalaallisut; Greenlandic [SK]', 'slo'),
	(211, 'Kamba [SK]', 'slo'),
	(212, 'Kannada [SK]', 'slo'),
	(213, 'Karen languages [SK]', 'slo'),
	(214, 'Kashmiri [SK]', 'slo'),
	(215, 'Kanuri [SK]', 'slo'),
	(216, 'Kawi [SK]', 'slo'),
	(217, 'Kazakh [SK]', 'slo'),
	(218, 'Kabardian [SK]', 'slo'),
	(219, 'Khasi [SK]', 'slo'),
	(220, 'Khoisan (Other) [SK]', 'slo'),
	(221, 'Central Khmer [SK]', 'slo'),
	(222, 'Khotanese [SK]', 'slo'),
	(223, 'Kikuyu; Gikuyu [SK]', 'slo'),
	(224, 'Kinyarwanda [SK]', 'slo'),
	(225, 'Kirghiz; Kyrgyz [SK]', 'slo'),
	(226, 'Kimbundu [SK]', 'slo'),
	(227, 'Konkani [SK]', 'slo'),
	(228, 'Komi [SK]', 'slo'),
	(229, 'Kongo [SK]', 'slo'),
	(230, 'Korean [SK]', 'slo'),
	(231, 'Kosraean [SK]', 'slo'),
	(232, 'Kpelle [SK]', 'slo'),
	(233, 'Karachay-Balkar [SK]', 'slo'),
	(234, 'Karelian [SK]', 'slo'),
	(235, 'Kru languages [SK]', 'slo'),
	(236, 'Kurukh [SK]', 'slo'),
	(237, 'Kuanyama; Kwanyama [SK]', 'slo'),
	(238, 'Kumyk [SK]', 'slo'),
	(239, 'Kurdish [SK]', 'slo'),
	(240, 'Kutenai [SK]', 'slo'),
	(241, 'Ladino [SK]', 'slo'),
	(242, 'Lahnda [SK]', 'slo'),
	(243, 'Lamba [SK]', 'slo'),
	(244, 'Lao [SK]', 'slo'),
	(245, 'Latin [SK]', 'slo'),
	(246, 'Latvian [SK]', 'slo'),
	(247, 'Lezghian [SK]', 'slo'),
	(248, 'Limburgan; Limburger; Limburgish [SK]', 'slo'),
	(249, 'Lingala [SK]', 'slo'),
	(250, 'Lithuanian [SK]', 'slo'),
	(251, 'Mongo [SK]', 'slo'),
	(252, 'Lozi [SK]', 'slo'),
	(253, 'Luxembourgish; Letzeburgesch [SK]', 'slo'),
	(254, 'Luba-Lulua [SK]', 'slo'),
	(255, 'Luba-Katangaxon, Low [SK]', 'slo'),
	(256, 'Ganda [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(257, 'Luiseno [SK]', 'slo'),
	(258, 'Lunda [SK]', 'slo'),
	(259, 'Luo (Kenya and Tanzania) [SK]', 'slo'),
	(260, 'Lushai [SK]', 'slo'),
	(261, 'Macedonian00E5l [SK]', 'slo'),
	(262, 'Madurese [SK]', 'slo'),
	(263, 'Magahi [SK]', 'slo'),
	(264, 'Marshallese [SK]', 'slo'),
	(265, 'Maithili [SK]', 'slo'),
	(266, 'Makasarl Nepal Bhasa [SK]', 'slo'),
	(267, 'Malayalam [SK]', 'slo'),
	(268, 'Mandingo [SK]', 'slo'),
	(269, 'Maori [SK]', 'slo'),
	(270, 'Austronesian (Other) [SK]', 'slo'),
	(271, 'Marathi [SK]', 'slo'),
	(272, 'Masai [SK]', 'slo'),
	(273, 'Malay [SK]', 'slo'),
	(274, 'Moksha [SK]', 'slo'),
	(275, 'Mandar [SK]', 'slo'),
	(276, 'Mende [SK]', 'slo'),
	(277, 'Irish, Middle (900-1200) [SK]', 'slo'),
	(278, 'Mi''kmaq; Micmac [SK]', 'slo'),
	(279, 'Minangkabau [SK]', 'slo'),
	(280, 'Miscellaneous languages [SK]', 'slo'),
	(281, 'Mon-Khmer (Other) [SK]', 'slo'),
	(282, 'Malagasy [SK]', 'slo'),
	(283, 'Maltese [SK]', 'slo'),
	(284, 'Manchu [SK]', 'slo'),
	(285, 'Manipuri [SK]', 'slo'),
	(286, 'Manobo languages [SK]', 'slo'),
	(287, 'Mohawk [SK]', 'slo'),
	(288, 'Moldavian [SK]', 'slo'),
	(289, 'Mongolian [SK]', 'slo'),
	(290, 'Mossi [SK]', 'slo'),
	(291, 'Multiple languages [SK]', 'slo'),
	(292, 'Munda languages [SK]', 'slo'),
	(293, 'Creek [SK]', 'slo'),
	(294, 'Mirandese [SK]', 'slo'),
	(295, 'Marwari [SK]', 'slo'),
	(296, 'Mayan languages [SK]', 'slo'),
	(297, 'Erzya [SK]', 'slo'),
	(298, 'Nahuatl languages [SK]', 'slo'),
	(299, 'North American Indian [SK]', 'slo'),
	(300, 'Neapolitan [SK]', 'slo'),
	(301, 'Nauru [SK]', 'slo'),
	(302, 'Navajo; Navaho [SK]', 'slo'),
	(303, 'Ndebele, South; South Ndebele [SK]', 'slo'),
	(304, 'Ndebele, North; North Ndebele [SK]', 'slo'),
	(305, 'Ndonga [SK]', 'slo'),
	(306, 'Low German; Low Saxon; German, Low; Sa [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(307, 'Nepali [SK]', 'slo'),
	(308, 'Nepal Bhasa; Newari [SK]', 'slo'),
	(309, 'Nias [SK]', 'slo'),
	(310, 'Niger-Kordofanian (Other) [SK]', 'slo'),
	(311, 'Niuean [SK]', 'slo'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian [SK]', 'slo'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål [SK]', 'slo'),
	(314, 'Nogai [SK]', 'slo'),
	(315, 'Norse, Old [SK]', 'slo'),
	(316, 'Norwegian [SK]', 'slo'),
	(317, 'Pedi; Sepedi; Northern Sotho [SK]', 'slo'),
	(318, 'Nubian languages [SK]', 'slo'),
	(319, 'Classical Newari; Old Newari; Classica [SK]', 'slo'),
	(320, 'Chichewa; Chewa; Nyanja [SK]', 'slo'),
	(321, 'Nyamwezi [SK]', 'slo'),
	(322, 'Nyankole [SK]', 'slo'),
	(323, 'Nyoro [SK]', 'slo'),
	(324, 'Nzima [SK]', 'slo'),
	(325, 'Occitan (post 1500); Provençal [SK]', 'slo'),
	(326, 'Ojibwa [SK]', 'slo'),
	(327, 'Oriya [SK]', 'slo'),
	(328, 'Oromo [SK]', 'slo'),
	(329, 'Osage [SK]', 'slo'),
	(330, 'Ossetian; Ossetic [SK]', 'slo'),
	(331, 'Turkish, Ottoman (1500-1928) [SK]', 'slo'),
	(332, 'Otomian languages [SK]', 'slo'),
	(333, 'Papuan (Other) [SK]', 'slo'),
	(334, 'Pangasinan [SK]', 'slo'),
	(335, 'Pahlavi [SK]', 'slo'),
	(336, 'Pampanga [SK]', 'slo'),
	(337, 'Panjabi; Punjabi [SK]', 'slo'),
	(338, 'Papiamento [SK]', 'slo'),
	(339, 'Palauan [SK]', 'slo'),
	(340, 'Persian, Old (ca.600-400 B.C.) [SK]', 'slo'),
	(341, 'Persian [SK]', 'slo'),
	(342, 'Philippine (Other) [SK]', 'slo'),
	(343, 'Phoenician [SK]', 'slo'),
	(344, 'Pali [SK]', 'slo'),
	(345, 'Polish [SK]', 'slo'),
	(346, 'Pohnpeian [SK]', 'slo'),
	(347, 'Portuguese [SK]', 'slo'),
	(348, 'Prakrit languages [SK]', 'slo'),
	(349, 'Provençal, Old (to 1500) [SK]', 'slo'),
	(350, 'Pushto [SK]', 'slo'),
	(351, 'Reserved for local use [SK]', 'slo'),
	(352, 'Quechua [SK]', 'slo'),
	(353, 'Rajasthani [SK]', 'slo'),
	(354, 'Rapanui [SK]', 'slo'),
	(355, 'Rarotongan; Cook Islands Maori [SK]', 'slo'),
	(356, 'Romance (Other) [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(357, 'Romansh [SK]', 'slo'),
	(358, 'Romany [SK]', 'slo'),
	(359, 'Romanian [SK]', 'slo'),
	(360, 'Rundi [SK]', 'slo'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian [SK]', 'slo'),
	(362, 'Russian [SK]', 'slo'),
	(363, 'Sandawe [SK]', 'slo'),
	(364, 'Sango [SK]', 'slo'),
	(365, 'Yakut [SK]', 'slo'),
	(366, 'South American Indian (Other) [SK]', 'slo'),
	(367, 'Salishan languages [SK]', 'slo'),
	(368, 'Samaritan Aramaic [SK]', 'slo'),
	(369, 'Sanskrit [SK]', 'slo'),
	(370, 'Sasak [SK]', 'slo'),
	(371, 'Santali [SK]', 'slo'),
	(372, 'Serbian [SK]', 'slo'),
	(373, 'Sicilian [SK]', 'slo'),
	(374, 'Scots [SK]', 'slo'),
	(375, 'Croatian [SK]', 'slo'),
	(376, 'Selkup [SK]', 'slo'),
	(377, 'Semitic (Other) [SK]', 'slo'),
	(378, 'Irish, Old (to 900) [SK]', 'slo'),
	(379, 'Sign Languages [SK]', 'slo'),
	(380, 'Shan [SK]', 'slo'),
	(381, 'Sidamo [SK]', 'slo'),
	(382, 'Sinhala; Sinhalese [SK]', 'slo'),
	(383, 'Siouan languages [SK]', 'slo'),
	(384, 'Sino-Tibetan (Other) [SK]', 'slo'),
	(385, 'Slavic (Other) [SK]', 'slo'),
	(386, 'Slovak [SK]', 'slo'),
	(387, 'Slovenian [SK]', 'slo'),
	(388, 'Southern Sami [SK]', 'slo'),
	(389, 'Northern Sami [SK]', 'slo'),
	(390, 'Sami languages (Other) [SK]', 'slo'),
	(391, 'Lule Sami [SK]', 'slo'),
	(392, 'Inari Sami [SK]', 'slo'),
	(393, 'Samoan [SK]', 'slo'),
	(394, 'Skolt Sami [SK]', 'slo'),
	(395, 'Shona [SK]', 'slo'),
	(396, 'Sindhi [SK]', 'slo'),
	(397, 'Soninke [SK]', 'slo'),
	(398, 'Sogdian [SK]', 'slo'),
	(399, 'Somali [SK]', 'slo'),
	(400, 'Songhai languages [SK]', 'slo'),
	(401, 'Sotho, Southern [SK]', 'slo'),
	(402, 'Spanish; Castilian [SK]', 'slo'),
	(403, 'Sardinian; Zazaki [SK]', 'slo'),
	(404, 'Sranan Tongo [SK]', 'slo'),
	(405, 'Serer [SK]', 'slo'),
	(406, 'Nilo-Saharan (Other) [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(407, 'Swati [SK]', 'slo'),
	(408, 'Sukuma [SK]', 'slo'),
	(409, 'Sundanese [SK]', 'slo'),
	(410, 'Susu [SK]', 'slo'),
	(411, 'Sumerian [SK]', 'slo'),
	(412, 'Swahili [SK]', 'slo'),
	(413, 'Swedish [SK]', 'slo'),
	(414, 'Syriac [SK]', 'slo'),
	(415, 'Tahitian [SK]', 'slo'),
	(416, 'Tai (Other) [SK]', 'slo'),
	(417, 'Tamil [SK]', 'slo'),
	(418, 'Tatar [SK]', 'slo'),
	(419, 'Telugu [SK]', 'slo'),
	(420, 'Timnendere) [SK]', 'slo'),
	(421, 'Tereno [SK]', 'slo'),
	(422, 'Tetum [SK]', 'slo'),
	(423, 'Tajik [SK]', 'slo'),
	(424, 'Tagalog [SK]', 'slo'),
	(425, 'Thai [SK]', 'slo'),
	(426, 'Tibetan [SK]', 'slo'),
	(427, 'Tigre [SK]', 'slo'),
	(428, 'Tigrinya [SK]', 'slo'),
	(429, 'Tiv [SK]', 'slo'),
	(430, 'Tokelau [SK]', 'slo'),
	(431, 'Klingon; tlhIngan-Hol [SK]', 'slo'),
	(432, 'Tlingit [SK]', 'slo'),
	(433, 'Tamashek [SK]', 'slo'),
	(434, 'Tonga (Nyasa) [SK]', 'slo'),
	(435, 'Tonga (Tonga Islands) [SK]', 'slo'),
	(436, 'Tok Pisin [SK]', 'slo'),
	(437, 'Tsimshian [SK]', 'slo'),
	(438, 'Tswana [SK]', 'slo'),
	(439, 'Tsonga [SK]', 'slo'),
	(440, 'Turkmen [SK]', 'slo'),
	(441, 'Tumbuka [SK]', 'slo'),
	(442, 'Tupi languages [SK]', 'slo'),
	(443, 'Turkish [SK]', 'slo'),
	(444, 'Altaic (Other) [SK]', 'slo'),
	(445, 'Tuvalu [SK]', 'slo'),
	(446, 'Twi [SK]', 'slo'),
	(447, 'Tuvinian [SK]', 'slo'),
	(448, 'Udmurt [SK]', 'slo'),
	(449, 'Ugaritic [SK]', 'slo'),
	(450, 'Uighur; Uyghur [SK]', 'slo'),
	(451, 'Ukrainian [SK]', 'slo'),
	(452, 'Umbundu [SK]', 'slo'),
	(453, 'Undetermined [SK]', 'slo'),
	(454, 'Urdu [SK]', 'slo'),
	(455, 'Uzbek [SK]', 'slo'),
	(456, 'Vai [SK]', 'slo');
INSERT INTO public.isolanguagesdes VALUES
	(457, 'Venda [SK]', 'slo'),
	(458, 'Vietnamese [SK]', 'slo'),
	(459, 'Volapük [SK]', 'slo'),
	(460, 'Votic [SK]', 'slo'),
	(461, 'Wakashan languages [SK]', 'slo'),
	(462, 'Walamo [SK]', 'slo'),
	(463, 'Waray [SK]', 'slo'),
	(464, 'Washo [SK]', 'slo'),
	(465, 'Welsh [SK]', 'slo'),
	(466, 'Sorbian languages [SK]', 'slo'),
	(467, 'Walloon [SK]', 'slo'),
	(468, 'Wolof [SK]', 'slo'),
	(469, 'Kalmyk; Oirat [SK]', 'slo'),
	(470, 'Xhosa [SK]', 'slo'),
	(471, 'Yao [SK]', 'slo'),
	(472, 'Yapese [SK]', 'slo'),
	(473, 'Yiddish [SK]', 'slo'),
	(474, 'Yoruba [SK]', 'slo'),
	(475, 'Yupik languages [SK]', 'slo'),
	(476, 'Zapotec [SK]', 'slo'),
	(477, 'Zenaga [SK]', 'slo'),
	(478, 'Zhuang; Chuang [SK]', 'slo'),
	(479, 'Zande languages [SK]', 'slo'),
	(480, 'Zulu [SK]', 'slo'),
	(481, 'Zuni [SK]', 'slo'),
	(482, 'No linguistic content [SK]', 'slo'),
	(483, 'N''Ko [SK]', 'slo'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki [SK]', 'slo'),
	(1, 'Afar', 'swe'),
	(2, 'Abkhazian', 'swe'),
	(3, 'Achinese', 'swe'),
	(4, 'Acoli', 'swe'),
	(5, 'Adangme', 'swe'),
	(6, 'Adyghe; Adygei', 'swe'),
	(7, 'Afro-Asiatic (Other)', 'swe'),
	(8, 'Afrihili', 'swe'),
	(9, 'Afrikaans', 'swe'),
	(10, 'Ainu', 'swe'),
	(11, 'Akan', 'swe'),
	(12, 'Akkadian', 'swe'),
	(13, 'Albanian', 'swe'),
	(14, 'Aleut', 'swe'),
	(15, 'Algonquian languages', 'swe'),
	(16, 'Southern Altai', 'swe'),
	(17, 'Amharic', 'swe'),
	(18, 'swelish, Old (ca.450-1100)', 'swe'),
	(19, 'Angika', 'swe'),
	(20, 'Apache languages', 'swe'),
	(21, 'Arabic', 'swe'),
	(22, 'Aramaic', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(23, 'Aragonese', 'swe'),
	(24, 'Armenian', 'swe'),
	(25, 'Mapudungun; Mapuche', 'swe'),
	(26, 'Arapaho', 'swe'),
	(27, 'Artificial (Other)', 'swe'),
	(28, 'Arawak', 'swe'),
	(29, 'Assamese', 'swe'),
	(30, 'Asturian; Bable', 'swe'),
	(31, 'Athapascan languages', 'swe'),
	(32, 'Australian languages', 'swe'),
	(33, 'Avaric', 'swe'),
	(34, 'Avestan', 'swe'),
	(35, 'Awadhi', 'swe'),
	(36, 'Aymara', 'swe'),
	(37, 'Azerbaijani', 'swe'),
	(38, 'Banda languages', 'swe'),
	(39, 'Bamileke languages', 'swe'),
	(40, 'Bashkir', 'swe'),
	(41, 'Baluchi', 'swe'),
	(42, 'Bambara', 'swe'),
	(43, 'Balinese', 'swe'),
	(44, 'Basque', 'swe'),
	(45, 'Basa', 'swe'),
	(46, 'Baltic (Other)', 'swe'),
	(47, 'Beja', 'swe'),
	(48, 'Belarusian', 'swe'),
	(49, 'Bemba', 'swe'),
	(50, 'Bsweali', 'swe'),
	(51, 'Berber (Other)', 'swe'),
	(52, 'Bhojpuri', 'swe'),
	(53, 'Bihari', 'swe'),
	(54, 'Bikol', 'swe'),
	(55, 'Bini; Edo', 'swe'),
	(56, 'Bislama', 'swe'),
	(57, 'Siksika', 'swe'),
	(58, 'Bantu (Other)', 'swe'),
	(59, 'Bosnian', 'swe'),
	(60, 'Braj', 'swe'),
	(61, 'Breton', 'swe'),
	(62, 'Batak languages', 'swe'),
	(63, 'Buriat', 'swe'),
	(64, 'Buginese', 'swe'),
	(65, 'Bulgarian', 'swe'),
	(66, 'Burmese', 'swe'),
	(67, 'Blin; Bilin', 'swe'),
	(68, 'Caddo', 'swe'),
	(69, 'Central American Indian (Other)', 'swe'),
	(70, 'Galibi Carib', 'swe'),
	(71, 'Catalan; Valencian', 'swe'),
	(72, 'Caucasian (Other)on liturgique; vieux bulgare', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(73, 'Cebuano', 'swe'),
	(74, 'Celtic (Other)', 'swe'),
	(75, 'Chamorro', 'swe'),
	(76, 'Chibcha', 'swe'),
	(77, 'Chechen', 'swe'),
	(78, 'Chagataier)', 'swe'),
	(79, 'Chinese(Other)', 'swe'),
	(80, 'Chuukese', 'swe'),
	(81, 'Mari', 'swe'),
	(82, 'Chinook jargon', 'swe'),
	(83, 'Choctaw', 'swe'),
	(84, 'Chipewyan', 'swe'),
	(85, 'Cherokee', 'swe'),
	(86, 'Church Slavic; Old Slavonic; Church Sl', 'swe'),
	(87, 'Chuvash', 'swe'),
	(88, 'Cheyenne', 'swe'),
	(89, 'Chamic languages', 'swe'),
	(90, 'Coptic', 'swe'),
	(91, 'Cornish', 'swe'),
	(92, 'Corsican', 'swe'),
	(93, 'Creoles and pidgins, swelish based (Ot', 'swe'),
	(94, 'Creoles and pidgins, French-based (Oth', 'swe'),
	(95, 'Creoles and pidgins, Portuguese-based ', 'swe'),
	(96, 'Cree', 'swe'),
	(97, 'Crimean Tatar; Crimean Turkish', 'swe'),
	(98, 'Creoles and pidgins (Other)', 'swe'),
	(99, 'Kashubian', 'swe'),
	(100, 'Cushitic (Other)', 'swe'),
	(101, 'Czech', 'swe'),
	(102, 'Dakota', 'swe'),
	(103, 'Danish', 'swe'),
	(104, 'Dargwa', 'swe'),
	(105, 'Land Dayak languages', 'swe'),
	(106, 'Delaware', 'swe'),
	(107, 'Slave (Athapascan)', 'swe'),
	(108, 'Dogrib', 'swe'),
	(109, 'Dinka', 'swe'),
	(110, 'Divehi; Dhivehi; Maldivian', 'swe'),
	(111, 'Dogri', 'swe'),
	(112, 'Dravidian (Other)', 'swe'),
	(113, 'Lower Sorbian', 'swe'),
	(114, 'Duala', 'swe'),
	(115, 'Dutch, Middle (ca.1050-1350)', 'swe'),
	(116, 'Dutch; Flemish', 'swe'),
	(117, 'Dyula', 'swe'),
	(118, 'Dzongkha', 'swe'),
	(119, 'Efik', 'swe'),
	(120, 'Egyptian (Ancient)', 'swe'),
	(121, 'Ekajuk', 'swe'),
	(122, 'Elamite', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(123, 'swelish', 'swe'),
	(124, 'swelish, Middle (1100-1500)', 'swe'),
	(125, 'Esperanto', 'swe'),
	(126, 'Estonian', 'swe'),
	(127, 'Ewe', 'swe'),
	(128, 'Ewondo', 'swe'),
	(129, 'Fang', 'swe'),
	(130, 'Faroese', 'swe'),
	(131, 'Fanti', 'swe'),
	(132, 'Fijian', 'swe'),
	(133, 'Filipino; Pilipino', 'swe'),
	(134, 'Finnish', 'swe'),
	(135, 'Finno-Ugrian (Other)', 'swe'),
	(136, 'Fon', 'swe'),
	(137, 'French', 'swe'),
	(138, 'French, Middle (ca.1400-1600)', 'swe'),
	(139, 'French, Old (842-ca.1400)', 'swe'),
	(140, 'Northern Frisian', 'swe'),
	(141, 'Eastern Frisian', 'swe'),
	(142, 'Western Frisian', 'swe'),
	(143, 'Fulah', 'swe'),
	(144, 'Friulian', 'swe'),
	(145, 'Ga', 'swe'),
	(146, 'Gayo', 'swe'),
	(147, 'Gbaya', 'swe'),
	(148, 'Germanic (Other)', 'swe'),
	(149, 'Georgian', 'swe'),
	(150, 'German', 'swe'),
	(151, 'Geez', 'swe'),
	(152, 'Gilbertese', 'swe'),
	(153, 'Gaelic; Scottish Gaelic', 'swe'),
	(154, 'Irish', 'swe'),
	(155, 'Galician', 'swe'),
	(156, 'Manx', 'swe'),
	(157, 'German, Middle High (ca.1050-1500)', 'swe'),
	(158, 'German, Old High (ca.750-1050)', 'swe'),
	(159, 'Gondi', 'swe'),
	(160, 'Gorontalo', 'swe'),
	(161, 'Gothicanguage Association)', 'swe'),
	(162, 'Grebo', 'swe'),
	(163, 'Greek, Ancient (to 1453)', 'swe'),
	(164, 'Greek, Modern (1453-)', 'swe'),
	(165, 'Guarani', 'swe'),
	(166, 'Swiss German; Alemannic', 'swe'),
	(167, 'Gujarati', 'swe'),
	(168, 'Gwich''in', 'swe'),
	(169, 'Haida', 'swe'),
	(170, 'Haitian; Haitian Creole', 'swe'),
	(171, 'Hausa', 'swe'),
	(172, 'Hawaiian', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(173, 'Hebrew', 'swe'),
	(174, 'Herero', 'swe'),
	(175, 'Hiligaynon', 'swe'),
	(176, 'Himachali', 'swe'),
	(177, 'Hindi', 'swe'),
	(178, 'Hittite', 'swe'),
	(179, 'Hmong', 'swe'),
	(180, 'Hiri Motu', 'swe'),
	(181, 'Upper Sorbian', 'swe'),
	(182, 'Hungarian', 'swe'),
	(183, 'Hupa', 'swe'),
	(184, 'Iban', 'swe'),
	(185, 'Igbo', 'swe'),
	(186, 'Icelandic', 'swe'),
	(187, 'Ido', 'swe'),
	(188, 'Sichuan Yi', 'swe'),
	(189, 'Ijo languages', 'swe'),
	(190, 'Inuktitut', 'swe'),
	(191, 'Interlingue', 'swe'),
	(192, 'Iloko', 'swe'),
	(193, 'Interlingua (International Auxiliary L', 'swe'),
	(194, 'Indic (Other)', 'swe'),
	(195, 'Indonesian', 'swe'),
	(196, 'Indo-European (Other)', 'swe'),
	(197, 'Ingush', 'swe'),
	(198, 'Inupiaq', 'swe'),
	(199, 'Iranian (Other)', 'swe'),
	(200, 'Iroquoian languages', 'swe'),
	(201, 'Italian', 'swe'),
	(202, 'Javanese', 'swe'),
	(203, 'Lojban', 'swe'),
	(204, 'Japanese', 'swe'),
	(205, 'Judeo-Persian', 'swe'),
	(206, 'Judeo-Arabic', 'swe'),
	(207, 'Kara-Kalpak', 'swe'),
	(208, 'Kabyle', 'swe'),
	(209, 'Kachin; Jingpho', 'swe'),
	(210, 'Kalaallisut; Greenlandic', 'swe'),
	(211, 'Kamba', 'swe'),
	(212, 'Kannada', 'swe'),
	(213, 'Karen languages', 'swe'),
	(214, 'Kashmiri', 'swe'),
	(215, 'Kanuri', 'swe'),
	(216, 'Kawi', 'swe'),
	(217, 'Kazakh', 'swe'),
	(218, 'Kabardian', 'swe'),
	(219, 'Khasi', 'swe'),
	(220, 'Khoisan (Other)', 'swe'),
	(221, 'Central Khmer', 'swe'),
	(222, 'Khotanese', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(223, 'Kikuyu; Gikuyu', 'swe'),
	(224, 'Kinyarwanda', 'swe'),
	(225, 'Kirghiz; Kyrgyz', 'swe'),
	(226, 'Kimbundu', 'swe'),
	(227, 'Konkani', 'swe'),
	(228, 'Komi', 'swe'),
	(229, 'Kongo', 'swe'),
	(230, 'Korean', 'swe'),
	(231, 'Kosraean', 'swe'),
	(232, 'Kpelle', 'swe'),
	(233, 'Karachay-Balkar', 'swe'),
	(234, 'Karelian', 'swe'),
	(235, 'Kru languages', 'swe'),
	(236, 'Kurukh', 'swe'),
	(237, 'Kuanyama; Kwanyama', 'swe'),
	(238, 'Kumyk', 'swe'),
	(239, 'Kurdish', 'swe'),
	(240, 'Kutenai', 'swe'),
	(241, 'Ladino', 'swe'),
	(242, 'Lahnda', 'swe'),
	(243, 'Lamba', 'swe'),
	(244, 'Lao', 'swe'),
	(245, 'Latin', 'swe'),
	(246, 'Latvian', 'swe'),
	(247, 'Lezghian', 'swe'),
	(248, 'Limburgan; Limburger; Limburgish', 'swe'),
	(249, 'Lingala', 'swe'),
	(250, 'Lithuanian', 'swe'),
	(251, 'Mongo', 'swe'),
	(252, 'Lozi', 'swe'),
	(253, 'Luxembourgish; Letzeburgesch', 'swe'),
	(254, 'Luba-Lulua', 'swe'),
	(255, 'Luba-Katangaxon, Low', 'swe'),
	(256, 'Ganda', 'swe'),
	(257, 'Luiseno', 'swe'),
	(258, 'Lunda', 'swe'),
	(259, 'Luo (Kenya and Tanzania)', 'swe'),
	(260, 'Lushai', 'swe'),
	(261, 'Macedonian00E5l', 'swe'),
	(262, 'Madurese', 'swe'),
	(263, 'Magahi', 'swe'),
	(264, 'Marshallese', 'swe'),
	(265, 'Maithili', 'swe'),
	(266, 'Makasarl Nepal Bhasa', 'swe'),
	(267, 'Malayalam', 'swe'),
	(268, 'Mandingo', 'swe'),
	(269, 'Maori', 'swe'),
	(270, 'Austronesian (Other)', 'swe'),
	(271, 'Marathi', 'swe'),
	(272, 'Masai', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(273, 'Malay', 'swe'),
	(274, 'Moksha', 'swe'),
	(275, 'Mandar', 'swe'),
	(276, 'Mende', 'swe'),
	(277, 'Irish, Middle (900-1200)', 'swe'),
	(278, 'Mi''kmaq; Micmac', 'swe'),
	(279, 'Minangkabau', 'swe'),
	(280, 'Miscellaneous languages', 'swe'),
	(281, 'Mon-Khmer (Other)', 'swe'),
	(282, 'Malagasy', 'swe'),
	(283, 'Maltese', 'swe'),
	(284, 'Manchu', 'swe'),
	(285, 'Manipuri', 'swe'),
	(286, 'Manobo languages', 'swe'),
	(287, 'Mohawk', 'swe'),
	(288, 'Moldavian', 'swe'),
	(289, 'Mongolian', 'swe'),
	(290, 'Mossi', 'swe'),
	(291, 'Multiple languages', 'swe'),
	(292, 'Munda languages', 'swe'),
	(293, 'Creek', 'swe'),
	(294, 'Mirandese', 'swe'),
	(295, 'Marwari', 'swe'),
	(296, 'Mayan languages', 'swe'),
	(297, 'Erzya', 'swe'),
	(298, 'Nahuatl languages', 'swe'),
	(299, 'North American Indian', 'swe'),
	(300, 'Neapolitan', 'swe'),
	(301, 'Nauru', 'swe'),
	(302, 'Navajo; Navaho', 'swe'),
	(303, 'Ndebele, South; South Ndebele', 'swe'),
	(304, 'Ndebele, North; North Ndebele', 'swe'),
	(305, 'Ndonga', 'swe'),
	(306, 'Low German; Low Saxon; German, Low; Sa', 'swe'),
	(307, 'Nepali', 'swe'),
	(308, 'Nepal Bhasa; Newari', 'swe'),
	(309, 'Nias', 'swe'),
	(310, 'Niger-Kordofanian (Other)', 'swe'),
	(311, 'Niuean', 'swe'),
	(312, 'Norwegian Nynorsk; Nynorsk, Norwegian', 'swe'),
	(313, 'Bokmål, Norwegian; Norwegian Bokmål', 'swe'),
	(314, 'Nogai', 'swe'),
	(315, 'Norse, Old', 'swe'),
	(316, 'Norwegian', 'swe'),
	(317, 'Pedi; Sepedi; Northern Sotho', 'swe'),
	(318, 'Nubian languages', 'swe'),
	(319, 'Classical Newari; Old Newari; Classica', 'swe'),
	(320, 'Chichewa; Chewa; Nyanja', 'swe'),
	(321, 'Nyamwezi', 'swe'),
	(322, 'Nyankole', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(323, 'Nyoro', 'swe'),
	(324, 'Nzima', 'swe'),
	(325, 'Occitan (post 1500); Provençal', 'swe'),
	(326, 'Ojibwa', 'swe'),
	(327, 'Oriya', 'swe'),
	(328, 'Oromo', 'swe'),
	(329, 'Osage', 'swe'),
	(330, 'Ossetian; Ossetic', 'swe'),
	(331, 'Turkish, Ottoman (1500-1928)', 'swe'),
	(332, 'Otomian languages', 'swe'),
	(333, 'Papuan (Other)', 'swe'),
	(334, 'Pangasinan', 'swe'),
	(335, 'Pahlavi', 'swe'),
	(336, 'Pampanga', 'swe'),
	(337, 'Panjabi; Punjabi', 'swe'),
	(338, 'Papiamento', 'swe'),
	(339, 'Palauan', 'swe'),
	(340, 'Persian, Old (ca.600-400 B.C.)', 'swe'),
	(341, 'Persian', 'swe'),
	(342, 'Philippine (Other)', 'swe'),
	(343, 'Phoenician', 'swe'),
	(344, 'Pali', 'swe'),
	(345, 'Polish', 'swe'),
	(346, 'Pohnpeian', 'swe'),
	(347, 'Portuguese', 'swe'),
	(348, 'Prakrit languages', 'swe'),
	(349, 'Provençal, Old (to 1500)', 'swe'),
	(350, 'Pushto', 'swe'),
	(351, 'Reserved for local use', 'swe'),
	(352, 'Quechua', 'swe'),
	(353, 'Rajasthani', 'swe'),
	(354, 'Rapanui', 'swe'),
	(355, 'Rarotongan; Cook Islands Maori', 'swe'),
	(356, 'Romance (Other)', 'swe'),
	(357, 'Romansh', 'swe'),
	(358, 'Romany', 'swe'),
	(359, 'Romanian', 'swe'),
	(360, 'Rundi', 'swe'),
	(361, 'Aromanian; Arumanian; Macedo-Romanian', 'swe'),
	(362, 'Russian', 'swe'),
	(363, 'Sandawe', 'swe'),
	(364, 'Sango', 'swe'),
	(365, 'Yakut', 'swe'),
	(366, 'South American Indian (Other)', 'swe'),
	(367, 'Salishan languages', 'swe'),
	(368, 'Samaritan Aramaic', 'swe'),
	(369, 'Sanskrit', 'swe'),
	(370, 'Sasak', 'swe'),
	(371, 'Santali', 'swe'),
	(372, 'Serbian', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(373, 'Sicilian', 'swe'),
	(374, 'Scots', 'swe'),
	(375, 'Croatian', 'swe'),
	(376, 'Selkup', 'swe'),
	(377, 'Semitic (Other)', 'swe'),
	(378, 'Irish, Old (to 900)', 'swe'),
	(379, 'Sign Languages', 'swe'),
	(380, 'Shan', 'swe'),
	(381, 'Sidamo', 'swe'),
	(382, 'Sinhala; Sinhalese', 'swe'),
	(383, 'Siouan languages', 'swe'),
	(384, 'Sino-Tibetan (Other)', 'swe'),
	(385, 'Slavic (Other)', 'swe'),
	(386, 'Slovak', 'swe'),
	(387, 'Slovenian', 'swe'),
	(388, 'Southern Sami', 'swe'),
	(389, 'Northern Sami', 'swe'),
	(390, 'Sami languages (Other)', 'swe'),
	(391, 'Lule Sami', 'swe'),
	(392, 'Inari Sami', 'swe'),
	(393, 'Samoan', 'swe'),
	(394, 'Skolt Sami', 'swe'),
	(395, 'Shona', 'swe'),
	(396, 'Sindhi', 'swe'),
	(397, 'Soninke', 'swe'),
	(398, 'Sogdian', 'swe'),
	(399, 'Somali', 'swe'),
	(400, 'Songhai languages', 'swe'),
	(401, 'Sotho, Southern', 'swe'),
	(402, 'Spanish; Castilian', 'swe'),
	(403, 'Sardinian; Zazaki', 'swe'),
	(404, 'Sranan Tongo', 'swe'),
	(405, 'Serer', 'swe'),
	(406, 'Nilo-Saharan (Other)', 'swe'),
	(407, 'Swati', 'swe'),
	(408, 'Sukuma', 'swe'),
	(409, 'Sundanese', 'swe'),
	(410, 'Susu', 'swe'),
	(411, 'Sumerian', 'swe'),
	(412, 'Swahili', 'swe'),
	(413, 'Swedish', 'swe'),
	(414, 'Syriac', 'swe'),
	(415, 'Tahitian', 'swe'),
	(416, 'Tai (Other)', 'swe'),
	(417, 'Tamil', 'swe'),
	(418, 'Tatar', 'swe'),
	(419, 'Telugu', 'swe'),
	(420, 'Timnendere)', 'swe'),
	(421, 'Tereno', 'swe'),
	(422, 'Tetum', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(423, 'Tajik', 'swe'),
	(424, 'Tagalog', 'swe'),
	(425, 'Thai', 'swe'),
	(426, 'Tibetan', 'swe'),
	(427, 'Tigre', 'swe'),
	(428, 'Tigrinya', 'swe'),
	(429, 'Tiv', 'swe'),
	(430, 'Tokelau', 'swe'),
	(431, 'Klingon; tlhIngan-Hol', 'swe'),
	(432, 'Tlingit', 'swe'),
	(433, 'Tamashek', 'swe'),
	(434, 'Tonga (Nyasa)', 'swe'),
	(435, 'Tonga (Tonga Islands)', 'swe'),
	(436, 'Tok Pisin', 'swe'),
	(437, 'Tsimshian', 'swe'),
	(438, 'Tswana', 'swe'),
	(439, 'Tsonga', 'swe'),
	(440, 'Turkmen', 'swe'),
	(441, 'Tumbuka', 'swe'),
	(442, 'Tupi languages', 'swe'),
	(443, 'Turkish', 'swe'),
	(444, 'Altaic (Other)', 'swe'),
	(445, 'Tuvalu', 'swe'),
	(446, 'Twi', 'swe'),
	(447, 'Tuvinian', 'swe'),
	(448, 'Udmurt', 'swe'),
	(449, 'Ugaritic', 'swe'),
	(450, 'Uighur; Uyghur', 'swe'),
	(451, 'Ukrainian', 'swe'),
	(452, 'Umbundu', 'swe'),
	(453, 'Undetermined', 'swe'),
	(454, 'Urdu', 'swe'),
	(455, 'Uzbek', 'swe'),
	(456, 'Vai', 'swe'),
	(457, 'Venda', 'swe'),
	(458, 'Vietnamese', 'swe'),
	(459, 'Volapük', 'swe'),
	(460, 'Votic', 'swe'),
	(461, 'Wakashan languages', 'swe'),
	(462, 'Walamo', 'swe'),
	(463, 'Waray', 'swe'),
	(464, 'Washo', 'swe'),
	(465, 'Welsh', 'swe'),
	(466, 'Sorbian languages', 'swe'),
	(467, 'Walloon', 'swe'),
	(468, 'Wolof', 'swe'),
	(469, 'Kalmyk; Oirat', 'swe'),
	(470, 'Xhosa', 'swe'),
	(471, 'Yao', 'swe'),
	(472, 'Yapese', 'swe');
INSERT INTO public.isolanguagesdes VALUES
	(473, 'Yiddish', 'swe'),
	(474, 'Yoruba', 'swe'),
	(475, 'Yupik languages', 'swe'),
	(476, 'Zapotec', 'swe'),
	(477, 'Zenaga', 'swe'),
	(478, 'Zhuang; Chuang', 'swe'),
	(479, 'Zande languages', 'swe'),
	(480, 'Zulu', 'swe'),
	(481, 'Zuni', 'swe'),
	(482, 'No linguistic content', 'swe'),
	(483, 'N''Ko', 'swe'),
	(484, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki', 'swe');


--
-- TOC entry 3841 (class 0 OID 16519)
-- Dependencies: 237
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.languages VALUES
	('eng', 'y', 'y', 'English'),
	('fre', 'n', 'y', 'Français'),
	('ger', 'n', 'y', 'Deutsch'),
	('spa', 'n', 'y', 'español'),
	('cat', 'n', 'n', 'català'),
	('rus', 'n', 'n', 'русский язык'),
	('por', 'n', 'y', 'português'),
	('chi', 'n', 'n', '中文'),
	('dut', 'n', 'y', 'Nederlands'),
	('nor', 'n', 'n', 'norsk'),
	('fin', 'n', 'y', 'suomi'),
	('ara', 'n', 'n', 'العربية'),
	('ita', 'n', 'y', 'Italiano'),
	('tur', 'n', 'n', 'Türkçe'),
	('vie', 'n', 'n', 'Tiếng Việt'),
	('pol', 'n', 'n', 'Polski'),
	('slo', 'n', 'n', 'Slovenčina'),
	('swe', 'n', 'y', 'swedish');


--
-- TOC entry 3842 (class 0 OID 16524)
-- Dependencies: 238
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3843 (class 0 OID 16531)
-- Dependencies: 239
-- Data for Name: linkstatus; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3844 (class 0 OID 16539)
-- Dependencies: 240
-- Data for Name: mapservers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3845 (class 0 OID 16546)
-- Dependencies: 241
-- Data for Name: messageproducerentity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3846 (class 0 OID 16553)
-- Dependencies: 242
-- Data for Name: metadata; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3847 (class 0 OID 16560)
-- Dependencies: 243
-- Data for Name: metadatacateg; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3848 (class 0 OID 16565)
-- Dependencies: 244
-- Data for Name: metadatadraft; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3849 (class 0 OID 16572)
-- Dependencies: 245
-- Data for Name: metadatafiledownloads; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3850 (class 0 OID 16579)
-- Dependencies: 246
-- Data for Name: metadatafileuploads; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3851 (class 0 OID 16586)
-- Dependencies: 247
-- Data for Name: metadataidentifiertemplate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.metadataidentifiertemplate VALUES
	(0, 'Custom URN', 'y', ' '),
	(1, 'Autogenerated URN', 'y', ' ');


--
-- TOC entry 3852 (class 0 OID 16592)
-- Dependencies: 248
-- Data for Name: metadatalink; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3853 (class 0 OID 16597)
-- Dependencies: 249
-- Data for Name: metadatarating; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3854 (class 0 OID 16602)
-- Dependencies: 250
-- Data for Name: metadatastatus; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3855 (class 0 OID 16609)
-- Dependencies: 251
-- Data for Name: operationallowed; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3856 (class 0 OID 16614)
-- Dependencies: 252
-- Data for Name: operations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.operations VALUES
	(0, 'view'),
	(1, 'download'),
	(2, 'editing'),
	(3, 'notify'),
	(5, 'dynamic'),
	(6, 'featured');


--
-- TOC entry 3857 (class 0 OID 16619)
-- Dependencies: 253
-- Data for Name: operationsdes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.operationsdes VALUES
	(0, 'Publish', 'eng'),
	(1, 'Download', 'eng'),
	(2, 'Editing', 'eng'),
	(3, 'Notify', 'eng'),
	(5, 'Interactive Map', 'eng'),
	(6, 'Featured', 'eng'),
	(0, 'Consulter', 'fre'),
	(1, 'Télécharger', 'fre'),
	(2, 'Éditer', 'fre'),
	(3, 'Notifier', 'fre'),
	(5, 'Visualiser', 'fre'),
	(6, 'Epingler', 'fre'),
	(0, 'Veröffentlichen', 'ger'),
	(1, 'Download', 'ger'),
	(2, 'Editieren', 'ger'),
	(3, 'Benachrichtigen', 'ger'),
	(5, 'Interaktive Karte', 'ger'),
	(6, 'Featured', 'ger'),
	(0, 'Publicar', 'spa'),
	(1, 'Descargar', 'spa'),
	(2, 'Editar', 'spa'),
	(3, 'Notificar', 'spa'),
	(5, 'Mapa interactivo', 'spa'),
	(6, 'Featured', 'spa'),
	(0, 'Publish', 'cat'),
	(1, 'Download', 'cat'),
	(2, 'Editing', 'cat'),
	(3, 'Notify', 'cat'),
	(5, 'Interactive Map', 'cat'),
	(6, 'Featured', 'cat'),
	(0, 'Просмотр', 'rus'),
	(1, 'Загрузка', 'rus'),
	(2, 'Editing', 'rus'),
	(3, 'Уведомление', 'rus'),
	(5, 'Интерактивная карта', 'rus'),
	(6, 'Предлагаемая карта', 'rus'),
	(0, 'Publicar', 'por'),
	(1, 'Download', 'por'),
	(2, 'Editar', 'por'),
	(3, 'Notificar', 'por'),
	(5, 'Mapa Interactivo', 'por'),
	(6, 'Featured', 'por'),
	(0, 'Publish', 'chi'),
	(1, 'Download', 'chi'),
	(2, 'Editing', 'chi'),
	(3, 'Notify', 'chi'),
	(5, 'Interactive Map', 'chi'),
	(6, 'Featured', 'chi'),
	(0, 'Publiceren', 'dut'),
	(1, 'Download', 'dut');
INSERT INTO public.operationsdes VALUES
	(2, 'Bewerken', 'dut'),
	(3, 'Informeren', 'dut'),
	(5, 'Interactieve Kaart', 'dut'),
	(6, 'Uitgelicht', 'dut'),
	(0, 'Publisér', 'nor'),
	(1, 'Nedlasting', 'nor'),
	(2, 'Oppdatering', 'nor'),
	(3, 'Varsle', 'nor'),
	(5, 'Interaktivt kart', 'nor'),
	(6, 'Aktuelt', 'nor'),
	(0, 'Publish', 'fin'),
	(1, 'Download', 'fin'),
	(2, 'Editing', 'fin'),
	(3, 'Notify', 'fin'),
	(5, 'Interactive Map', 'fin'),
	(6, 'Featured', 'fin'),
	(0, 'Publish', 'ara'),
	(1, 'Download', 'ara'),
	(2, 'Editing', 'ara'),
	(3, 'Notify', 'ara'),
	(5, 'Interactive Map', 'ara'),
	(6, 'Featured', 'ara'),
	(0, 'Pubblica', 'ita'),
	(1, 'Scarica', 'ita'),
	(2, 'Modifica', 'ita'),
	(3, 'Notifica', 'ita'),
	(5, 'Mappa interattiva', 'ita'),
	(6, 'In rilievo', 'ita'),
	(0, 'Publish', 'tur'),
	(1, 'Download', 'tur'),
	(2, 'Editing', 'tur'),
	(3, 'Notify', 'tur'),
	(5, 'Interactive Map', 'tur'),
	(6, 'Featured', 'tur'),
	(0, 'Publish', 'vie'),
	(1, 'Download', 'vie'),
	(2, 'Editing', 'vie'),
	(3, 'Notify', 'vie'),
	(5, 'Interactive Map', 'vie'),
	(6, 'Featured', 'vie'),
	(0, 'Publikacja', 'pol'),
	(1, 'Pobieranie', 'pol'),
	(2, 'Edycja', 'pol'),
	(3, 'Powiadamianie', 'pol'),
	(5, 'Mapy interaktywne', 'pol'),
	(6, 'Wyróżnione', 'pol'),
	(0, 'Publish [SK]', 'slo'),
	(1, 'Download [SK]', 'slo'),
	(2, 'Editing [SK]', 'slo'),
	(3, 'Notify [SK]', 'slo');
INSERT INTO public.operationsdes VALUES
	(5, 'Interactive Map [SK]', 'slo'),
	(6, 'Featured [SK]', 'slo'),
	(0, 'Publicera', 'swe'),
	(1, 'Ladda ned', 'swe'),
	(2, 'Redigera', 'swe'),
	(3, 'Avisera', 'swe'),
	(5, 'Interaktiv karta', 'swe'),
	(6, 'Urval', 'swe');


--
-- TOC entry 3858 (class 0 OID 16624)
-- Dependencies: 254
-- Data for Name: relations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3859 (class 0 OID 16629)
-- Dependencies: 255
-- Data for Name: schematron; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.schematron VALUES
	(100, 0, 'schematron-rules-dcat-ap-vl-rec.xsl', 'dcat2'),
	(101, 1, 'schematron-rules-dcat-ap-vl.xsl', 'dcat2'),
	(102, 2, 'schematron-rules-mdcat-rec.xsl', 'dcat2'),
	(103, 3, 'schematron-rules-mdcat.xsl', 'dcat2'),
	(104, 0, 'schematron-rules-datacite.xsl', 'iso19115-3.2018'),
	(105, 1, 'schematron-rules-iso.xsl', 'iso19115-3.2018'),
	(106, 0, 'schematron-rules-datacite.xsl', 'iso19139'),
	(107, 1, 'schematron-rules-geonetwork.xsl', 'iso19139'),
	(108, 2, 'schematron-rules-iso.xsl', 'iso19139'),
	(109, 3, 'schematron-rules-url-check.xsl', 'iso19139');


--
-- TOC entry 3860 (class 0 OID 16636)
-- Dependencies: 256
-- Data for Name: schematroncriteria; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.schematroncriteria VALUES
	(100, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 100),
	(101, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 101),
	(102, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 102),
	(103, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 103),
	(104, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 104),
	(105, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 105),
	(106, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 106),
	(107, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 107),
	(108, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 108),
	(109, 'ALWAYS_ACCEPT', NULL, NULL, '_ignored_', '*Generated*', 109);


--
-- TOC entry 3861 (class 0 OID 16643)
-- Dependencies: 257
-- Data for Name: schematroncriteriagroup; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.schematroncriteriagroup VALUES
	('*Generated*', 100, 'REQUIRED'),
	('*Generated*', 101, 'REQUIRED'),
	('*Generated*', 102, 'REQUIRED'),
	('*Generated*', 103, 'REQUIRED'),
	('*Generated*', 104, 'REQUIRED'),
	('*Generated*', 105, 'REQUIRED'),
	('*Generated*', 106, 'REQUIRED'),
	('*Generated*', 107, 'REQUIRED'),
	('*Generated*', 108, 'REQUIRED'),
	('*Generated*', 109, 'REQUIRED');


--
-- TOC entry 3862 (class 0 OID 16650)
-- Dependencies: 258
-- Data for Name: schematrondes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.schematrondes VALUES
	(100, 'schematron-rules-dcat-ap-vl-rec', 'eng'),
	(101, 'schematron-rules-dcat-ap-vl', 'eng'),
	(102, 'schematron-rules-mdcat-rec', 'eng'),
	(103, 'schematron-rules-mdcat', 'eng'),
	(104, 'schematron-rules-datacite', 'eng'),
	(105, 'schematron-rules-iso', 'eng'),
	(106, 'schematron-rules-datacite', 'eng'),
	(107, 'schematron-rules-geonetwork', 'eng'),
	(108, 'schematron-rules-iso', 'eng'),
	(109, 'schematron-rules-url-check', 'eng');


--
-- TOC entry 3863 (class 0 OID 16655)
-- Dependencies: 259
-- Data for Name: selections; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.selections VALUES
	(0, 'PreferredList', 'n'),
	(1, 'WatchList', 'y');


--
-- TOC entry 3864 (class 0 OID 16660)
-- Dependencies: 260
-- Data for Name: selectionsdes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.selectionsdes VALUES
	(0, 'Preferred records', 'eng'),
	(1, 'Watch list', 'eng'),
	(0, 'Fiches préférées', 'fre'),
	(1, 'Fiches observées', 'fre'),
	(0, 'Preferred records', 'ger'),
	(1, 'Watch list', 'ger'),
	(0, 'Preferred records', 'spa'),
	(1, 'Watch list', 'spa'),
	(0, 'Preferred records', 'cat'),
	(1, 'Watch list', 'cat'),
	(0, 'Preferred records', 'rus'),
	(1, 'Watch list', 'rus'),
	(0, 'Preferred records', 'por'),
	(1, 'Watch list', 'por'),
	(0, 'Preferred records', 'chi'),
	(1, 'Watch list', 'chi'),
	(0, 'Voorkeursrecords', 'dut'),
	(1, 'Favorieten lijst', 'dut'),
	(0, 'Preferred records', 'nor'),
	(1, 'Watch list', 'nor'),
	(0, 'Preferred records', 'fin'),
	(1, 'Watch list', 'fin'),
	(0, 'Preferred records', 'ara'),
	(1, 'Watch list', 'ara'),
	(0, 'Preferred records', 'ita'),
	(1, 'Watch list', 'ita'),
	(0, 'Preferred records', 'tur'),
	(1, 'Watch list', 'tur'),
	(0, 'Preferred records', 'vie'),
	(1, 'Watch list', 'vie'),
	(0, 'Preferred records', 'pol'),
	(1, 'Watch list', 'pol'),
	(0, 'Preferred records [SK]', 'slo'),
	(1, 'Watch list [SK]', 'slo'),
	(0, 'Föredragna poster', 'swe'),
	(1, 'Bevakningslista', 'swe');


--
-- TOC entry 3865 (class 0 OID 16665)
-- Dependencies: 261
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.settings VALUES
	('system/site/name', 0, 'y', 'n', 'n', 110, 'My GeoNetwork catalogue'),
	('system/site/organization', 0, 'y', 'n', 'n', 130, 'My organization'),
	('system/platform/version', 0, 'y', 'n', 'n', 150, '4.2.3'),
	('system/platform/subVersion', 0, 'y', 'n', 'n', 160, 'SNAPSHOT'),
	('system/site/svnUuid', 0, 'y', 'n', 'y', 170, ''),
	('system/server/host', 0, 'y', 'n', 'n', 210, 'localhost'),
	('system/server/protocol', 0, 'y', 'n', 'n', 220, 'http'),
	('system/server/port', 1, 'y', 'n', 'n', 230, '8080'),
	('system/server/log', 0, 'y', 'n', 'y', 250, 'log4j2.xml'),
	('system/server/timeZone', 0, 'y', 'n', 'n', 260, ''),
	('system/server/sitemapLinkUrl', 0, 'y', 'n', 'n', 270, NULL),
	('system/intranet/network', 0, 'y', 'n', 'y', 310, '127.0.0.1'),
	('system/intranet/netmask', 0, 'y', 'n', 'y', 320, '255.0.0.0'),
	('system/proxy/use', 2, 'y', 'n', 'y', 510, 'false'),
	('system/proxy/host', 0, 'y', 'n', 'y', 520, NULL),
	('system/proxy/port', 1, 'y', 'n', 'y', 530, NULL),
	('system/proxy/username', 0, 'y', 'n', 'y', 540, NULL),
	('system/proxy/password', 0, 'y', 'y', 'y', 550, NULL),
	('system/proxy/ignorehostlist', 0, 'y', 'n', 'y', 560, NULL),
	('system/cors/allowedHosts', 0, 'y', 'n', 'y', 561, '*'),
	('system/feedback/email', 0, 'y', 'n', 'y', 610, 'root@localhost'),
	('system/feedback/mailServer/host', 0, 'y', 'n', 'y', 630, ''),
	('system/feedback/mailServer/port', 1, 'y', 'n', 'y', 640, '25'),
	('system/feedback/mailServer/username', 0, 'y', 'n', 'y', 642, ''),
	('system/feedback/mailServer/password', 0, 'y', 'y', 'y', 643, ''),
	('system/feedback/mailServer/ssl', 2, 'y', 'n', 'y', 641, 'false'),
	('system/feedback/mailServer/tls', 2, 'y', 'n', 'y', 644, 'false'),
	('system/feedback/mailServer/ignoreSslCertificateErrors', 2, 'y', 'n', 'y', 645, 'false'),
	('system/selectionmanager/maxrecords', 1, 'y', 'n', 'y', 910, '1000'),
	('system/csw/enable', 2, 'y', 'n', 'y', 1210, 'true'),
	('system/csw/enabledWhenIndexing', 2, 'y', 'n', 'y', 1211, 'true'),
	('system/csw/capabilityRecordUuid', 0, 'y', 'n', 'y', 1220, '-1'),
	('system/csw/metadataPublic', 2, 'y', 'n', 'y', 1310, 'false'),
	('system/csw/transactionUpdateCreateXPath', 2, 'y', 'n', 'y', 1320, 'true'),
	('system/userSelfRegistration/enable', 2, 'y', 'n', 'n', 1910, 'false'),
	('system/userFeedback/enable', 2, 'y', 'n', 'n', 1911, 'false'),
	('system/userFeedback/lastNotificationDate', 0, 'n', 'n', 'y', 1912, ''),
	('system/clickablehyperlinks/enable', 2, 'y', 'n', 'y', 2010, 'true'),
	('system/localrating/enable', 0, 'y', 'n', 'n', 2110, 'advanced'),
	('system/localrating/notificationLevel', 0, 'y', 'n', 'n', 2111, 'catalogueAdministrator'),
	('system/localrating/notificationGroups', 0, 'y', 'n', 'n', 2112, ''),
	('system/xlinkResolver/enable', 2, 'y', 'n', 'n', 2310, 'false'),
	('system/xlinkResolver/localXlinkEnable', 2, 'y', 'n', 'n', 2311, 'true'),
	('system/xlinkResolver/ignore', 0, 'y', 'n', 'n', 2312, 'operatesOn,featureCatalogueCitation,Anchor,source,parentIdentifier'),
	('system/xlinkResolver/referencedDeletionAllowed', 2, 'y', 'n', 'n', 2313, 'true'),
	('system/hidewithheldelements/enableLogging', 2, 'y', 'n', 'y', 2320, 'false'),
	('system/autofixing/enable', 2, 'y', 'n', 'y', 2410, 'true'),
	('system/searchStats/enable', 2, 'y', 'n', 'n', 2510, 'false'),
	('system/oai/mdmode', 0, 'y', 'n', 'y', 7010, '1'),
	('system/oai/tokentimeout', 1, 'y', 'n', 'y', 7020, '3600');
INSERT INTO public.settings VALUES
	('system/oai/cachesize', 1, 'y', 'n', 'y', 7030, '60'),
	('system/oai/maxrecords', 1, 'y', 'n', 'y', 7040, '10'),
	('system/inspire/enable', 2, 'y', 'n', 'n', 7210, 'false'),
	('system/inspire/atom', 0, 'y', 'n', 'y', 7230, 'disabled'),
	('system/inspire/atomSchedule', 0, 'y', 'n', 'y', 7240, '0 0 0 * * ?'),
	('system/inspire/atomProtocol', 0, 'y', 'n', 'y', 7250, 'INSPIRE-ATOM'),
	('system/harvester/enableEditing', 2, 'y', 'n', 'n', 9010, 'false'),
	('system/harvester/enablePrivilegesManagement', 2, 'y', 'n', 'n', 9010, 'false'),
	('system/harvester/disabledHarvesterTypes', 0, 'y', 'n', 'n', 9011, ''),
	('system/harvesting/mail/recipient', 0, 'y', 'n', 'y', 9020, NULL),
	('system/harvesting/mail/template', 0, 'y', 'n', 'y', 9021, ''),
	('system/harvesting/mail/templateError', 0, 'y', 'n', 'y', 9022, 'There was an error on the harvesting: $$errorMsg$$'),
	('system/harvesting/mail/templateWarning', 0, 'y', 'n', 'y', 9023, ''),
	('system/harvesting/mail/subject', 0, 'y', 'n', 'y', 9024, '[$$harvesterType$$] $$harvesterName$$ finished harvesting'),
	('system/harvesting/mail/enabled', 2, 'y', 'n', 'y', 9025, 'false'),
	('system/harvesting/mail/level1', 2, 'y', 'n', 'y', 9026, 'false'),
	('system/harvesting/mail/level2', 2, 'y', 'n', 'y', 9027, 'false'),
	('system/harvesting/mail/level3', 2, 'y', 'n', 'y', 9028, 'false'),
	('system/users/identicon', 0, 'y', 'n', 'n', 9110, 'gravatar:mp'),
	('system/metadata/prefergrouplogo', 2, 'y', 'n', 'n', 9111, 'true'),
	('system/metadata/allThesaurus', 2, 'y', 'n', 'n', 9160, 'false'),
	('system/metadata/thesaurusNamespace', 0, 'y', 'n', 'n', 9161, 'https://registry.geonetwork-opensource.org/{{type}}/{{filename}}'),
	('metadata/vcs/enable', 2, 'y', 'n', 'n', 9161, 'false'),
	('system/metadata/validation/removeSchemaLocation', 2, 'y', 'n', 'n', 9170, 'false'),
	('system/metadata/history/enabled', 2, 'y', 'n', 'n', 9171, 'false'),
	('system/metadatacreate/generateUuid', 2, 'y', 'n', 'n', 9100, 'true'),
	('system/metadatacreate/preferredGroup', 1, 'y', 'n', 'n', 9105, ''),
	('system/metadatacreate/preferredTemplate', 0, 'y', 'n', 'n', 9106, ''),
	('system/metadataprivs/usergrouponly', 2, 'y', 'n', 'n', 9180, 'false'),
	('system/metadataprivs/publicationbyrevieweringroupowneronly', 2, 'y', 'n', 'n', 9181, 'true'),
	('system/metadataprivs/publication/notificationLevel', 0, 'y', 'n', 'n', 9182, ''),
	('system/metadataprivs/publication/notificationGroups', 0, 'y', 'n', 'n', 9183, ''),
	('system/index/indexingTimeRecordLink', 2, 'y', 'n', 'n', 9209, 'false'),
	('system/threadedindexing/maxthreads', 1, 'y', 'n', 'y', 9210, '1'),
	('system/inspire/remotevalidation/url', 0, 'y', 'n', 'n', 7211, ''),
	('system/inspire/remotevalidation/urlquery', 0, 'y', 'n', 'n', 7212, ''),
	('system/inspire/remotevalidation/nodeid', 0, 'y', 'n', 'n', 7213, ''),
	('system/inspire/remotevalidation/apikey', 0, 'y', 'n', 'y', 7214, ''),
	('region/getmap/background', 0, 'y', 'n', 'n', 9590, 'osm'),
	('region/getmap/width', 0, 'y', 'n', 'n', 9590, '500'),
	('region/getmap/summaryWidth', 0, 'y', 'n', 'n', 9590, '500'),
	('region/getmap/mapproj', 0, 'y', 'n', 'n', 9590, 'EPSG:3857'),
	('metadata/resourceIdentifierPrefix', 0, 'y', 'n', 'n', 10001, 'http://localhost:8080/geonetwork/srv/resources'),
	('metadata/import/restrict', 0, 'y', 'n', 'y', 11000, ''),
	('metadata/workflow/enable', 2, 'y', 'n', 'n', 100002, 'false'),
	('metadata/workflow/draftWhenInGroup', 0, 'y', 'n', 'n', 100003, ''),
	('metadata/workflow/allowSumitApproveInvalidMd', 2, 'y', 'n', 'n', 100004, 'true'),
	('metadata/workflow/allowPublishNonApprovedMd', 2, 'y', 'n', 'n', 100005, 'true'),
	('metadata/workflow/allowPublishInvalidMd', 2, 'y', 'n', 'n', 100006, 'true'),
	('metadata/workflow/automaticUnpublishInvalidMd', 2, 'y', 'n', 'n', 100007, 'false');
INSERT INTO public.settings VALUES
	('metadata/workflow/forceValidationOnMdSave', 2, 'y', 'n', 'n', 100008, 'false'),
	('metadata/backuparchive/enable', 2, 'y', 'n', 'n', 12000, 'false'),
	('metadata/link/excludedUrlPattern', 0, 'y', 'n', 'n', 12010, ''),
	('metadata/import/userprofile', 0, 'y', 'n', 'n', 12001, 'Editor'),
	('metadata/delete/profilePublishedMetadata', 0, 'y', 'n', 'n', 12011, 'Editor'),
	('metadata/pdfReport/coverPdf', 0, 'y', 'n', 'y', 12500, ''),
	('metadata/pdfReport/introPdf', 0, 'y', 'n', 'y', 12501, ''),
	('metadata/pdfReport/tocPage', 2, 'y', 'n', 'y', 12502, 'false'),
	('metadata/pdfReport/headerLeft', 0, 'y', 'n', 'y', 12504, '{siteInfo}'),
	('metadata/pdfReport/headerRight', 0, 'y', 'n', 'y', 12505, ''),
	('metadata/pdfReport/footerLeft', 0, 'y', 'n', 'y', 12506, ''),
	('metadata/pdfReport/footerRight', 0, 'y', 'n', 'y', 12507, '{date}'),
	('metadata/pdfReport/pdfName', 0, 'y', 'n', 'n', 12507, 'metadata_{datetime}.pdf'),
	('metadata/csvReport/csvName', 0, 'y', 'n', 'n', 12607, 'metadata_{datetime}.csv'),
	('system/ui/defaultView', 0, 'y', 'n', 'n', 10100, 'default'),
	('system/userSelfRegistration/recaptcha/enable', 2, 'y', 'n', 'n', 1910, 'false'),
	('system/userSelfRegistration/recaptcha/publickey', 0, 'y', 'n', 'n', 1910, ''),
	('system/userSelfRegistration/recaptcha/secretkey', 0, 'y', 'n', 'y', 1910, ''),
	('system/publication/doi/doienabled', 2, 'y', 'n', 'n', 100191, 'false'),
	('system/publication/doi/doiurl', 0, 'y', 'n', 'n', 100192, ''),
	('system/publication/doi/doiusername', 0, 'y', 'n', 'n', 100193, ''),
	('system/publication/doi/doipassword', 0, 'y', 'y', 'y', 100194, ''),
	('system/publication/doi/doikey', 0, 'y', 'n', 'n', 110095, ''),
	('system/publication/doi/doilandingpagetemplate', 0, 'y', 'n', 'n', 100195, 'http://localhost:8080/geonetwork/srv/resources/records/{{uuid}}'),
	('system/publication/doi/doipublicurl', 0, 'y', 'n', 'n', 100196, ''),
	('system/publication/doi/doipattern', 0, 'y', 'n', 'n', 100197, '{{uuid}}'),
	('system/security/passwordEnforcement/minLength', 1, 'y', 'n', 'n', 12000, '6'),
	('system/security/passwordEnforcement/maxLength', 1, 'y', 'n', 'n', 12001, '20'),
	('system/security/passwordEnforcement/usePattern', 2, 'y', 'n', 'n', 12002, 'true'),
	('system/security/passwordEnforcement/pattern', 0, 'n', 'n', 'n', 12003, '^((?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).*)$'),
	('system/site/siteId', 0, 'y', 'n', 'n', 120, 'c678d0fb-894d-403f-b146-4b96706a1a16');


--
-- TOC entry 3866 (class 0 OID 16676)
-- Dependencies: 262
-- Data for Name: settings_cssstyle; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3867 (class 0 OID 16683)
-- Dependencies: 263
-- Data for Name: settings_ui; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3868 (class 0 OID 16690)
-- Dependencies: 264
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sources VALUES
	('c678d0fb-894d-403f-b146-4b96706a1a16', '2023-02-15T09:13:54.697Z', NULL, NULL, 'y', NULL, 'My GeoNetwork catalogue', NULL, 'portal', NULL);


--
-- TOC entry 3869 (class 0 OID 16698)
-- Dependencies: 265
-- Data for Name: sourcesdes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sourcesdes VALUES
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'swe'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'dut'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'spa'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'chi'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'fin'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'pol'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'nor'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'tur'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'rus'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'ara'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'por'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'vie'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'ger'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'cat'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'ita'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'slo'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'fre'),
	('c678d0fb-894d-403f-b146-4b96706a1a16', 'My GeoNetwork catalogue', 'eng');


--
-- TOC entry 3870 (class 0 OID 16705)
-- Dependencies: 266
-- Data for Name: spg_page; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3871 (class 0 OID 16712)
-- Dependencies: 267
-- Data for Name: spg_sections; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3872 (class 0 OID 16717)
-- Dependencies: 268
-- Data for Name: statusvalues; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.statusvalues VALUES
	(1, 1, 'draft', 'recordUserAuthor', 'y', 'workflow'),
	(2, 3, 'approved', 'recordUserAuthor', 'y', 'workflow'),
	(3, 5, 'retired', 'recordUserAuthor', 'y', 'workflow'),
	(4, 2, 'submitted', 'recordProfileReviewer', 'y', 'workflow'),
	(5, 4, 'rejected', NULL, 'y', 'workflow'),
	(0, 0, 'unknown', NULL, 'y', 'workflow'),
	(100, 100, 'doiCreationTask', 'statusUserOwner', 'n', 'task'),
	(50, 50, 'recordcreated', NULL, 'y', 'event'),
	(51, 51, 'recordupdated', NULL, 'y', 'event'),
	(52, 52, 'attachmentadded', NULL, 'y', 'event'),
	(53, 53, 'attachmentdeleted', NULL, 'y', 'event'),
	(54, 54, 'recordownerchange', NULL, 'y', 'event'),
	(55, 55, 'recordgroupownerchange', NULL, 'y', 'event'),
	(56, 56, 'recordprivilegeschange', NULL, 'y', 'event'),
	(57, 57, 'recordcategorychange', NULL, 'y', 'event'),
	(58, 58, 'recordvalidationtriggered', NULL, 'y', 'event'),
	(59, 59, 'recordstatuschange', NULL, 'y', 'event'),
	(60, 60, 'recordprocessingchange', NULL, 'y', 'event'),
	(61, 61, 'recorddeleted', NULL, 'y', 'event'),
	(62, 62, 'recordimported', NULL, 'y', 'event'),
	(63, 63, 'recordrestored', NULL, 'y', 'event');


--
-- TOC entry 3873 (class 0 OID 16724)
-- Dependencies: 269
-- Data for Name: statusvaluesdes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.statusvaluesdes VALUES
	(0, 'Unknown', 'eng'),
	(1, 'Draft', 'eng'),
	(2, 'Approved', 'eng'),
	(3, 'Retired', 'eng'),
	(4, 'Submitted', 'eng'),
	(5, 'Rejected', 'eng'),
	(50, 'Record created.', 'eng'),
	(51, 'Record updated.', 'eng'),
	(52, 'Attachment {{h.currentStatus}} added.', 'eng'),
	(53, 'Attachment {{h.previousStatus}} deleted.', 'eng'),
	(54, 'Owner changed from {{h.previousStatus}} to {{h.currentStatus}}.', 'eng'),
	(55, 'Group owner changed from {{h.previousStatus}} to {{h.currentStatus}}.', 'eng'),
	(56, 'Privileges updated.', 'eng'),
	(57, 'Category changed. Now categories are {{h.currentStatus}}.', 'eng'),
	(58, 'Validation triggered. Exit status is now {{h.currentStatus}}.', 'eng'),
	(59, 'Status changed from {{h.previousStatus}} to {{h.currentStatus}}.', 'eng'),
	(60, 'Record updated by process {{h.currentStatus}}.', 'eng'),
	(61, 'Record deleted.', 'eng'),
	(62, 'Record imported.', 'eng'),
	(63, 'Record restored.', 'eng'),
	(100, 'DOI creation request', 'eng'),
	(0, 'Inconnu', 'fre'),
	(1, 'Brouillon', 'fre'),
	(2, 'Validé', 'fre'),
	(3, 'Retiré', 'fre'),
	(4, 'A valider', 'fre'),
	(5, 'Rejeté', 'fre'),
	(50, 'Fiche créée.', 'fre'),
	(51, 'Fiche mise à jour.', 'fre'),
	(52, 'Document {{h.item1}} ajouté.', 'fre'),
	(53, 'Document {{h.item1}} supprimé.', 'fre'),
	(54, 'Auteur {{h.item1}} remplacé par {{h.item2}}.', 'fre'),
	(55, 'Groupe {{h.item1}} remplacé par {{h.item2}}.', 'fre'),
	(56, 'Accès mis à jour.', 'fre'),
	(57, 'Changement de catégorie. Les catégories sont {{h.item1}}.', 'fre'),
	(58, 'Fiche validée. La validation est maintenant {{h.item1}}.', 'fre'),
	(59, 'Changement de status de {{h.item1}} à {{h.item2}}.', 'fre'),
	(60, 'Fiche mise à jour par le processus {{h.item1}}.', 'fre'),
	(61, 'Fiche supprimée.', 'fre'),
	(62, 'Fiche importée.', 'fre'),
	(63, 'Fiche restaurée.', 'fre'),
	(100, 'Demande de création de DOI', 'fre'),
	(0, 'Unknown', 'ger'),
	(1, 'Draft', 'ger'),
	(2, 'Approved', 'ger'),
	(3, 'Retired', 'ger'),
	(4, 'Submitted', 'ger'),
	(5, 'Rejected', 'ger'),
	(50, 'Record created.', 'ger'),
	(51, 'Record updated.', 'ger');
INSERT INTO public.statusvaluesdes VALUES
	(52, 'Attachment {{h.item1}} added.', 'ger'),
	(53, 'Attachment {{h.item1}} deleted.', 'ger'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'ger'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'ger'),
	(56, 'Privileges updated.', 'ger'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'ger'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'ger'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'ger'),
	(60, 'Record updated by process {{h.item1}}.', 'ger'),
	(61, 'Record deleted.', 'ger'),
	(62, 'Record imported.', 'ger'),
	(63, 'Record restored.', 'ger'),
	(100, 'DOI creation requested.', 'ger'),
	(0, 'Unknown', 'spa'),
	(1, 'Draft', 'spa'),
	(2, 'Approved', 'spa'),
	(3, 'Retired', 'spa'),
	(4, 'Submitted', 'spa'),
	(5, 'Rejected', 'spa'),
	(50, 'Record created.', 'spa'),
	(51, 'Record updated.', 'spa'),
	(52, 'Attachment {{h.item1}} added.', 'spa'),
	(53, 'Attachment {{h.item1}} deleted.', 'spa'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'spa'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'spa'),
	(56, 'Privileges updated.', 'spa'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'spa'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'spa'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'spa'),
	(60, 'Record updated by process {{h.item1}}.', 'spa'),
	(61, 'Record deleted.', 'spa'),
	(62, 'Record imported.', 'spa'),
	(63, 'Record restored.', 'spa'),
	(100, 'DOI creation requested.', 'spa'),
	(0, 'Unknown', 'cat'),
	(1, 'Draft', 'cat'),
	(2, 'Approved', 'cat'),
	(3, 'Retired', 'cat'),
	(4, 'Submitted', 'cat'),
	(5, 'Rejected', 'cat'),
	(50, 'Record created.', 'cat'),
	(51, 'Record updated.', 'cat'),
	(52, 'Attachment {{h.item1}} added.', 'cat'),
	(53, 'Attachment {{h.item1}} deleted.', 'cat'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'cat'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'cat'),
	(56, 'Privileges updated.', 'cat'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'cat'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'cat'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'cat');
INSERT INTO public.statusvaluesdes VALUES
	(60, 'Record updated by process {{h.item1}}.', 'cat'),
	(61, 'Record deleted.', 'cat'),
	(62, 'Record imported.', 'cat'),
	(63, 'Record restored.', 'cat'),
	(100, 'DOI creation requested.', 'cat'),
	(0, 'Unknown', 'rus'),
	(1, 'Draft', 'rus'),
	(2, 'Approved', 'rus'),
	(3, 'Retired', 'rus'),
	(4, 'Submitted', 'rus'),
	(5, 'Rejected', 'rus'),
	(50, 'Record created.', 'rus'),
	(51, 'Record updated.', 'rus'),
	(52, 'Attachment {{h.item1}} added.', 'rus'),
	(53, 'Attachment {{h.item1}} deleted.', 'rus'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'rus'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'rus'),
	(56, 'Privileges updated.', 'rus'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'rus'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'rus'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'rus'),
	(60, 'Record updated by process {{h.item1}}.', 'rus'),
	(61, 'Record deleted.', 'rus'),
	(62, 'Record imported.', 'rus'),
	(63, 'Record restored.', 'rus'),
	(100, 'DOI creation requested.', 'rus'),
	(0, 'Unknown', 'por'),
	(1, 'Draft', 'por'),
	(2, 'Approved', 'por'),
	(3, 'Retired', 'por'),
	(4, 'Submitted', 'por'),
	(5, 'Rejected', 'por'),
	(50, 'Record created.', 'por'),
	(51, 'Record updated.', 'por'),
	(52, 'Attachment {{h.item1}} added.', 'por'),
	(53, 'Attachment {{h.item1}} deleted.', 'por'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'por'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'por'),
	(56, 'Privileges updated.', 'por'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'por'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'por'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'por'),
	(60, 'Record updated by process {{h.item1}}.', 'por'),
	(61, 'Record deleted.', 'por'),
	(62, 'Record imported.', 'por'),
	(63, 'Record restored.', 'por'),
	(100, 'DOI creation requested.', 'por'),
	(0, 'Unknown', 'chi'),
	(1, 'Draft', 'chi'),
	(2, 'Approved', 'chi');
INSERT INTO public.statusvaluesdes VALUES
	(3, 'Retired', 'chi'),
	(4, 'Submitted', 'chi'),
	(5, 'Rejected', 'chi'),
	(50, 'Record created.', 'chi'),
	(51, 'Record updated.', 'chi'),
	(52, 'Attachment {{h.item1}} added.', 'chi'),
	(53, 'Attachment {{h.item1}} deleted.', 'chi'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'chi'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'chi'),
	(56, 'Privileges updated.', 'chi'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'chi'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'chi'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'chi'),
	(60, 'Record updated by process {{h.item1}}.', 'chi'),
	(61, 'Record deleted.', 'chi'),
	(62, 'Record imported.', 'chi'),
	(63, 'Record restored.', 'chi'),
	(100, 'DOI creation requested.', 'chi'),
	(0, 'Onbekend', 'dut'),
	(1, 'Concept', 'dut'),
	(2, 'Goedgekeurd', 'dut'),
	(3, 'Teruggetrokken', 'dut'),
	(4, 'Ingediend', 'dut'),
	(5, 'Afgekeurd', 'dut'),
	(50, 'Record aangemaakt.', 'dut'),
	(51, 'Record bijgewerkt.', 'dut'),
	(52, 'Bijlage {{h.item1}} toegevoegd.', 'dut'),
	(53, 'Bijlage {{h.item1}} verwijderd.', 'dut'),
	(54, 'Eigenaar veranderd van {{h.item1}} naar {{h.item2}}.', 'dut'),
	(55, 'Groep eigenaar veranderd van {{h.item1}} naar {{h.item2}}.', 'dut'),
	(56, 'Privileges bijgewerkt .', 'dut'),
	(57, 'Categorie veranderd. De categorieën zijn nu {{h.item1}}.', 'dut'),
	(58, 'Validatie gestart. Afsluitstatus is nu {{h.item1}}.', 'dut'),
	(59, 'Status veranderd van {{h.item1}} naar {{h.item2}}.', 'dut'),
	(60, 'Record bijgewerkt door proces {{h.item1}}.', 'dut'),
	(61, 'Record verwijderd.', 'dut'),
	(62, 'Record geïmporteerd.', 'dut'),
	(63, 'Record hersteld.', 'dut'),
	(100, 'DOI aangevraagd.', 'dut'),
	(0, 'Unknown', 'nor'),
	(1, 'Draft', 'nor'),
	(2, 'Approved', 'nor'),
	(3, 'Retired', 'nor'),
	(4, 'Submitted', 'nor'),
	(5, 'Rejected', 'nor'),
	(50, 'Record created.', 'nor'),
	(51, 'Record updated.', 'nor'),
	(52, 'Attachment {{h.item1}} added.', 'nor'),
	(53, 'Attachment {{h.item1}} deleted.', 'nor'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'nor');
INSERT INTO public.statusvaluesdes VALUES
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'nor'),
	(56, 'Privileges updated.', 'nor'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'nor'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'nor'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'nor'),
	(60, 'Record updated by process {{h.item1}}.', 'nor'),
	(61, 'Record deleted.', 'nor'),
	(62, 'Record imported.', 'nor'),
	(63, 'Record restored.', 'nor'),
	(100, 'DOI creation requested.', 'nor'),
	(0, 'Unknown', 'fin'),
	(1, 'Draft', 'fin'),
	(2, 'Approved', 'fin'),
	(3, 'Retired', 'fin'),
	(4, 'Submitted', 'fin'),
	(5, 'Rejected', 'fin'),
	(50, 'Record created.', 'fin'),
	(51, 'Record updated.', 'fin'),
	(52, 'Attachment {{h.item1}} added.', 'fin'),
	(53, 'Attachment {{h.item1}} deleted.', 'fin'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'fin'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'fin'),
	(56, 'Privileges updated.', 'fin'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'fin'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'fin'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'fin'),
	(60, 'Record updated by process {{h.item1}}.', 'fin'),
	(61, 'Record deleted.', 'fin'),
	(62, 'Record imported.', 'fin'),
	(63, 'Record restored.', 'fin'),
	(100, 'DOI creation requested.', 'fin'),
	(0, 'Unknown', 'ara'),
	(1, 'Draft', 'ara'),
	(2, 'Approved', 'ara'),
	(3, 'Retired', 'ara'),
	(4, 'Submitted', 'ara'),
	(5, 'Rejected', 'ara'),
	(50, 'Record created.', 'ara'),
	(51, 'Record updated.', 'ara'),
	(52, 'Attachment {{h.item1}} added.', 'ara'),
	(53, 'Attachment {{h.item1}} deleted.', 'ara'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'ara'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'ara'),
	(56, 'Privileges updated.', 'ara'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'ara'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'ara'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'ara'),
	(60, 'Record updated by process {{h.item1}}.', 'ara'),
	(61, 'Record deleted.', 'ara'),
	(62, 'Record imported.', 'ara');
INSERT INTO public.statusvaluesdes VALUES
	(63, 'Record restored.', 'ara'),
	(100, 'DOI creation requested.', 'ara'),
	(0, 'Sconosciuto', 'ita'),
	(1, 'Bozza', 'ita'),
	(2, 'Approvato', 'ita'),
	(3, 'Ritirato', 'ita'),
	(4, 'Proposto', 'ita'),
	(5, 'Respinto', 'ita'),
	(50, 'Record created.', 'ita'),
	(51, 'Record updated.', 'ita'),
	(52, 'Attachment {{h.item1}} added.', 'ita'),
	(53, 'Attachment {{h.item1}} deleted.', 'ita'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'ita'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'ita'),
	(56, 'Privileges updated.', 'ita'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'ita'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'ita'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'ita'),
	(60, 'Record updated by process {{h.item1}}.', 'ita'),
	(61, 'Record deleted.', 'ita'),
	(62, 'Record imported.', 'ita'),
	(63, 'Record restored.', 'ita'),
	(100, 'DOI creation requested.', 'ita'),
	(0, 'Unknown', 'tur'),
	(1, 'Draft', 'tur'),
	(2, 'Approved', 'tur'),
	(3, 'Retired', 'tur'),
	(4, 'Submitted', 'tur'),
	(5, 'Rejected', 'tur'),
	(50, 'Record created.', 'tur'),
	(51, 'Record updated.', 'tur'),
	(52, 'Attachment {{h.item1}} added.', 'tur'),
	(53, 'Attachment {{h.item1}} deleted.', 'tur'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'tur'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'tur'),
	(56, 'Privileges updated.', 'tur'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'tur'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'tur'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'tur'),
	(60, 'Record updated by process {{h.item1}}.', 'tur'),
	(61, 'Record deleted.', 'tur'),
	(62, 'Record imported.', 'tur'),
	(63, 'Record restored.', 'tur'),
	(100, 'DOI creation requested.', 'tur'),
	(0, 'Unknown', 'vie'),
	(1, 'Draft', 'vie'),
	(2, 'Approved', 'vie'),
	(3, 'Retired', 'vie'),
	(4, 'Submitted', 'vie'),
	(5, 'Rejected', 'vie');
INSERT INTO public.statusvaluesdes VALUES
	(50, 'Record created.', 'vie'),
	(51, 'Record updated.', 'vie'),
	(52, 'Attachment {{h.item1}} added.', 'vie'),
	(53, 'Attachment {{h.item1}} deleted.', 'vie'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'vie'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'vie'),
	(56, 'Privileges updated.', 'vie'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'vie'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'vie'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'vie'),
	(60, 'Record updated by process {{h.item1}}.', 'vie'),
	(61, 'Record deleted.', 'vie'),
	(62, 'Record imported.', 'vie'),
	(63, 'Record restored.', 'vie'),
	(100, 'DOI creation requested.', 'vie'),
	(0, 'Nieznany', 'pol'),
	(1, 'Draft', 'pol'),
	(2, 'Zaaprobowana', 'pol'),
	(3, 'Porzucone', 'pol'),
	(4, 'Załadowane', 'pol'),
	(5, 'Odrzucone', 'pol'),
	(50, 'Record created.', 'pol'),
	(51, 'Record updated.', 'pol'),
	(52, 'Attachment {{h.item1}} added.', 'pol'),
	(53, 'Attachment {{h.item1}} deleted.', 'pol'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'pol'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'pol'),
	(56, 'Privileges updated.', 'pol'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'pol'),
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'pol'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'pol'),
	(60, 'Record updated by process {{h.item1}}.', 'pol'),
	(61, 'Record deleted.', 'pol'),
	(62, 'Record imported.', 'pol'),
	(63, 'Record restored.', 'pol'),
	(100, 'DOI creation requested.', 'pol'),
	(0, 'Unknown [SK]', 'slo'),
	(1, 'Draft [SK]', 'slo'),
	(2, 'Approved [SK]', 'slo'),
	(3, 'Retired [SK]', 'slo'),
	(4, 'Submitted [SK]', 'slo'),
	(5, 'Rejected [SK]', 'slo'),
	(50, 'Record created.', 'slo'),
	(51, 'Record updated.', 'slo'),
	(52, 'Attachment {{h.item1}} added.', 'slo'),
	(53, 'Attachment {{h.item1}} deleted.', 'slo'),
	(54, 'Owner changed from {{h.item1}} to {{h.item2}}.', 'slo'),
	(55, 'Group owner changed from {{h.item1}} to {{h.item2}}.', 'slo'),
	(56, 'Privileges updated.', 'slo'),
	(57, 'Category changed. Now categories are {{h.item1}}.', 'slo');
INSERT INTO public.statusvaluesdes VALUES
	(58, 'Validation triggered. Exit status is now {{h.item1}}.', 'slo'),
	(59, 'Status changed from {{h.item1}} to {{h.item2}}.', 'slo'),
	(60, 'Record updated by process {{h.item1}}.', 'slo'),
	(61, 'Record deleted.', 'slo'),
	(62, 'Record imported.', 'slo'),
	(63, 'Record restored.', 'slo'),
	(100, 'DOI creation requested.', 'slo'),
	(0, 'Okänd', 'swe'),
	(1, 'Utkast', 'swe'),
	(2, 'Godkänd', 'swe'),
	(3, 'Tillbakadragen', 'swe'),
	(4, 'Ingiven', 'swe'),
	(5, 'Avvisad', 'swe'),
	(50, 'Post skapad.', 'swe'),
	(51, 'Post uppdaterad.', 'swe'),
	(52, 'Bilaga {{h.currentStatus}} tillagd.', 'swe'),
	(53, 'Bilaga {{h.previousStatus}} raderad.', 'swe'),
	(54, 'Ägare ändrad från {{h.previousStatus}} till {{h.currentStatus}}.', 'swe'),
	(55, 'Gruppägare ändrad från {{h.previousStatus}} till {{h.currentStatus}}.', 'swe'),
	(56, 'Behörigheter uppdaterade.', 'swe'),
	(57, 'Kategori ändrad. Ny kategori är {{h.currentStatus}}.', 'swe'),
	(58, 'Validering igångsatt. Avslutad med {{h.currentStatus}}.', 'swe'),
	(59, 'Status ändrad från {{h.previousStatus}} till {{h.currentStatus}}.', 'swe'),
	(60, 'Post uppdaterad genom process {{h.currentStatus}}.', 'swe'),
	(61, 'Post raderad.', 'swe'),
	(62, 'Post importerad.', 'swe'),
	(63, 'Post återställd.', 'swe'),
	(100, 'Begäran att skapa DOI', 'swe');


--
-- TOC entry 3874 (class 0 OID 16729)
-- Dependencies: 270
-- Data for Name: thesaurus; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3875 (class 0 OID 16734)
-- Dependencies: 271
-- Data for Name: translations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3876 (class 0 OID 16741)
-- Dependencies: 272
-- Data for Name: useraddress; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.useraddress VALUES
	(0, 0),
	(1, 1);


--
-- TOC entry 3877 (class 0 OID 16746)
-- Dependencies: 273
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3878 (class 0 OID 16751)
-- Dependencies: 274
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES
	(0, 'n', '', NULL, 'nobody', '', 4, '', NULL, '', '', 'nobody', 'nobody'),
	(1, 'y', '', '2023-02-15T09:16:07.585Z', 'admin', '', 0, '', 'srv', '46e44386069f7cf0d4f2a420b9a2383a612f316e2024b0fe84052b0b96c479a23e8a0be8b90fb8c2', '', 'admin', 'admin');


--
-- TOC entry 3879 (class 0 OID 16759)
-- Dependencies: 275
-- Data for Name: usersavedselections; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3880 (class 0 OID 16764)
-- Dependencies: 276
-- Data for Name: usersearch; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3881 (class 0 OID 16771)
-- Dependencies: 277
-- Data for Name: usersearch_group; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3882 (class 0 OID 16776)
-- Dependencies: 278
-- Data for Name: usersearchdes; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3883 (class 0 OID 16781)
-- Dependencies: 279
-- Data for Name: validation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3918 (class 0 OID 0)
-- Dependencies: 280
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.address_id_seq', 100, false);


--
-- TOC entry 3919 (class 0 OID 0)
-- Dependencies: 281
-- Name: csw_server_capabilities_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.csw_server_capabilities_info_id_seq', 100, false);


--
-- TOC entry 3920 (class 0 OID 0)
-- Dependencies: 282
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_id_seq', 1, false);


--
-- TOC entry 3921 (class 0 OID 0)
-- Dependencies: 283
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.group_id_seq', 100, false);


--
-- TOC entry 3922 (class 0 OID 0)
-- Dependencies: 284
-- Name: gufkey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gufkey_id_seq', 100, false);


--
-- TOC entry 3923 (class 0 OID 0)
-- Dependencies: 285
-- Name: gufrat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gufrat_id_seq', 100, false);


--
-- TOC entry 3924 (class 0 OID 0)
-- Dependencies: 286
-- Name: harvest_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.harvest_history_id_seq', 100, false);


--
-- TOC entry 3925 (class 0 OID 0)
-- Dependencies: 287
-- Name: harvester_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.harvester_setting_id_seq', 100, false);


--
-- TOC entry 3926 (class 0 OID 0)
-- Dependencies: 288
-- Name: inspire_atom_feed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inspire_atom_feed_id_seq', 100, false);


--
-- TOC entry 3927 (class 0 OID 0)
-- Dependencies: 289
-- Name: iso_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.iso_language_id_seq', 10000, false);


--
-- TOC entry 3928 (class 0 OID 0)
-- Dependencies: 290
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.link_id_seq', 1, false);


--
-- TOC entry 3929 (class 0 OID 0)
-- Dependencies: 291
-- Name: linkstatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.linkstatus_id_seq', 1, false);


--
-- TOC entry 3930 (class 0 OID 0)
-- Dependencies: 292
-- Name: mapserver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.mapserver_id_seq', 100, false);


--
-- TOC entry 3931 (class 0 OID 0)
-- Dependencies: 293
-- Name: message_producer_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.message_producer_entity_id_seq', 100, false);


--
-- TOC entry 3932 (class 0 OID 0)
-- Dependencies: 294
-- Name: metadata_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metadata_category_id_seq', 100, false);


--
-- TOC entry 3933 (class 0 OID 0)
-- Dependencies: 295
-- Name: metadata_filedownload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metadata_filedownload_id_seq', 100, false);


--
-- TOC entry 3934 (class 0 OID 0)
-- Dependencies: 296
-- Name: metadata_fileupload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metadata_fileupload_id_seq', 100, false);


--
-- TOC entry 3935 (class 0 OID 0)
-- Dependencies: 297
-- Name: metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metadata_id_seq', 100, false);


--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 298
-- Name: metadata_identifier_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metadata_identifier_template_id_seq', 100, false);


--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 299
-- Name: metadatastatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metadatastatus_id_seq', 100, false);


--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 300
-- Name: operation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.operation_id_seq', 100, false);


--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 301
-- Name: rating_criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rating_criteria_id_seq', 100, false);


--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 302
-- Name: schematron_criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.schematron_criteria_id_seq', 109, true);


--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 303
-- Name: schematron_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.schematron_id_seq', 109, true);


--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 304
-- Name: selection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.selection_id_seq', 100, false);


--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 305
-- Name: status_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.status_value_id_seq', 100, false);


--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 306
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 100, false);


--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 307
-- Name: user_search_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_search_id_seq', 100, false);


--
-- TOC entry 3475 (class 2606 OID 16395)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- TOC entry 3477 (class 2606 OID 16400)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3479 (class 2606 OID 16405)
-- Name: categoriesdes categoriesdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoriesdes
    ADD CONSTRAINT categoriesdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3481 (class 2606 OID 16412)
-- Name: customelementset customelementset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customelementset
    ADD CONSTRAINT customelementset_pkey PRIMARY KEY (xpathhashcode);


--
-- TOC entry 3483 (class 2606 OID 16420)
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- TOC entry 3485 (class 2606 OID 16431)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3487 (class 2606 OID 16436)
-- Name: groupsdes groupsdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groupsdes
    ADD CONSTRAINT groupsdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3489 (class 2606 OID 16441)
-- Name: guf_keywords guf_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_keywords
    ADD CONSTRAINT guf_keywords_pkey PRIMARY KEY (id);


--
-- TOC entry 3491 (class 2606 OID 16446)
-- Name: guf_rating guf_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_rating
    ADD CONSTRAINT guf_rating_pkey PRIMARY KEY (id);


--
-- TOC entry 3493 (class 2606 OID 16452)
-- Name: guf_ratingcriteria guf_ratingcriteria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_ratingcriteria
    ADD CONSTRAINT guf_ratingcriteria_pkey PRIMARY KEY (id);


--
-- TOC entry 3495 (class 2606 OID 16459)
-- Name: guf_ratingcriteriades guf_ratingcriteriades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_ratingcriteriades
    ADD CONSTRAINT guf_ratingcriteriades_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3497 (class 2606 OID 16464)
-- Name: guf_userfeedback_keyword guf_userfeedback_keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedback_keyword
    ADD CONSTRAINT guf_userfeedback_keyword_pkey PRIMARY KEY (userfeedback_uuid, keyword_id);


--
-- TOC entry 3499 (class 2606 OID 16471)
-- Name: guf_userfeedbacks guf_userfeedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks
    ADD CONSTRAINT guf_userfeedbacks_pkey PRIMARY KEY (uuid);


--
-- TOC entry 3503 (class 2606 OID 16481)
-- Name: harvesterdata harvesterdata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvesterdata
    ADD CONSTRAINT harvesterdata_pkey PRIMARY KEY (harvesteruuid, keyvalue);


--
-- TOC entry 3505 (class 2606 OID 16489)
-- Name: harvestersettings harvestersettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvestersettings
    ADD CONSTRAINT harvestersettings_pkey PRIMARY KEY (id);


--
-- TOC entry 3507 (class 2606 OID 16496)
-- Name: harvesthistory harvesthistory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvesthistory
    ADD CONSTRAINT harvesthistory_pkey PRIMARY KEY (id);


--
-- TOC entry 3510 (class 2606 OID 16503)
-- Name: inspireatomfeed inspireatomfeed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspireatomfeed
    ADD CONSTRAINT inspireatomfeed_pkey PRIMARY KEY (id);


--
-- TOC entry 3512 (class 2606 OID 16513)
-- Name: isolanguages isolanguages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.isolanguages
    ADD CONSTRAINT isolanguages_pkey PRIMARY KEY (id);


--
-- TOC entry 3514 (class 2606 OID 16518)
-- Name: isolanguagesdes isolanguagesdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.isolanguagesdes
    ADD CONSTRAINT isolanguagesdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3516 (class 2606 OID 16523)
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- TOC entry 3518 (class 2606 OID 16530)
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- TOC entry 3523 (class 2606 OID 16538)
-- Name: linkstatus linkstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkstatus
    ADD CONSTRAINT linkstatus_pkey PRIMARY KEY (id);


--
-- TOC entry 3525 (class 2606 OID 16545)
-- Name: mapservers mapservers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mapservers
    ADD CONSTRAINT mapservers_pkey PRIMARY KEY (id);


--
-- TOC entry 3527 (class 2606 OID 16552)
-- Name: messageproducerentity messageproducerentity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messageproducerentity
    ADD CONSTRAINT messageproducerentity_pkey PRIMARY KEY (id);


--
-- TOC entry 3531 (class 2606 OID 16559)
-- Name: metadata metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);


--
-- TOC entry 3535 (class 2606 OID 16564)
-- Name: metadatacateg metadatacateg_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatacateg
    ADD CONSTRAINT metadatacateg_pkey PRIMARY KEY (metadataid, categoryid);


--
-- TOC entry 3537 (class 2606 OID 16571)
-- Name: metadatadraft metadatadraft_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatadraft
    ADD CONSTRAINT metadatadraft_pkey PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 16578)
-- Name: metadatafiledownloads metadatafiledownloads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatafiledownloads
    ADD CONSTRAINT metadatafiledownloads_pkey PRIMARY KEY (id);


--
-- TOC entry 3547 (class 2606 OID 16585)
-- Name: metadatafileuploads metadatafileuploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatafileuploads
    ADD CONSTRAINT metadatafileuploads_pkey PRIMARY KEY (id);


--
-- TOC entry 3549 (class 2606 OID 16591)
-- Name: metadataidentifiertemplate metadataidentifiertemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadataidentifiertemplate
    ADD CONSTRAINT metadataidentifiertemplate_pkey PRIMARY KEY (id);


--
-- TOC entry 3553 (class 2606 OID 16596)
-- Name: metadatalink metadatalink_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatalink
    ADD CONSTRAINT metadatalink_pkey PRIMARY KEY (linkid, metadataid);


--
-- TOC entry 3555 (class 2606 OID 16601)
-- Name: metadatarating metadatarating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatarating
    ADD CONSTRAINT metadatarating_pkey PRIMARY KEY (ipaddress, metadataid);


--
-- TOC entry 3562 (class 2606 OID 16608)
-- Name: metadatastatus metadatastatus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatastatus
    ADD CONSTRAINT metadatastatus_pkey PRIMARY KEY (id);


--
-- TOC entry 3565 (class 2606 OID 16613)
-- Name: operationallowed operationallowed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operationallowed
    ADD CONSTRAINT operationallowed_pkey PRIMARY KEY (groupid, metadataid, operationid);


--
-- TOC entry 3567 (class 2606 OID 16618)
-- Name: operations operations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operations
    ADD CONSTRAINT operations_pkey PRIMARY KEY (id);


--
-- TOC entry 3569 (class 2606 OID 16623)
-- Name: operationsdes operationsdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operationsdes
    ADD CONSTRAINT operationsdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3571 (class 2606 OID 16628)
-- Name: relations relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id, relatedid);


--
-- TOC entry 3573 (class 2606 OID 16635)
-- Name: schematron schematron_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematron
    ADD CONSTRAINT schematron_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 16642)
-- Name: schematroncriteria schematroncriteria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematroncriteria
    ADD CONSTRAINT schematroncriteria_pkey PRIMARY KEY (id);


--
-- TOC entry 3579 (class 2606 OID 16649)
-- Name: schematroncriteriagroup schematroncriteriagroup_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematroncriteriagroup
    ADD CONSTRAINT schematroncriteriagroup_pkey PRIMARY KEY (name, schematronid);


--
-- TOC entry 3581 (class 2606 OID 16654)
-- Name: schematrondes schematrondes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematrondes
    ADD CONSTRAINT schematrondes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3583 (class 2606 OID 16659)
-- Name: selections selections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selections
    ADD CONSTRAINT selections_pkey PRIMARY KEY (id);


--
-- TOC entry 3585 (class 2606 OID 16664)
-- Name: selectionsdes selectionsdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selectionsdes
    ADD CONSTRAINT selectionsdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3589 (class 2606 OID 16682)
-- Name: settings_cssstyle settings_cssstyle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings_cssstyle
    ADD CONSTRAINT settings_cssstyle_pkey PRIMARY KEY (variable);


--
-- TOC entry 3587 (class 2606 OID 16675)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (name);


--
-- TOC entry 3591 (class 2606 OID 16689)
-- Name: settings_ui settings_ui_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings_ui
    ADD CONSTRAINT settings_ui_pkey PRIMARY KEY (id);


--
-- TOC entry 3593 (class 2606 OID 16697)
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (uuid);


--
-- TOC entry 3595 (class 2606 OID 16704)
-- Name: sourcesdes sourcesdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sourcesdes
    ADD CONSTRAINT sourcesdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3597 (class 2606 OID 16711)
-- Name: spg_page spg_page_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spg_page
    ADD CONSTRAINT spg_page_pkey PRIMARY KEY (language, linktext);


--
-- TOC entry 3599 (class 2606 OID 16723)
-- Name: statusvalues statusvalues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statusvalues
    ADD CONSTRAINT statusvalues_pkey PRIMARY KEY (id);


--
-- TOC entry 3601 (class 2606 OID 16728)
-- Name: statusvaluesdes statusvaluesdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statusvaluesdes
    ADD CONSTRAINT statusvaluesdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3603 (class 2606 OID 16733)
-- Name: thesaurus thesaurus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.thesaurus
    ADD CONSTRAINT thesaurus_pkey PRIMARY KEY (id);


--
-- TOC entry 3606 (class 2606 OID 16740)
-- Name: translations translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translations
    ADD CONSTRAINT translations_pkey PRIMARY KEY (idfield);


--
-- TOC entry 3529 (class 2606 OID 16795)
-- Name: messageproducerentity uk2cyob0hg1dx0ety6fw4osout9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messageproducerentity
    ADD CONSTRAINT uk2cyob0hg1dx0ety6fw4osout9 UNIQUE (url, typename);


--
-- TOC entry 3616 (class 2606 OID 16820)
-- Name: users uk_23y4gd49ajvbqgl3psjsvhff6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_23y4gd49ajvbqgl3psjsvhff6 UNIQUE (username);


--
-- TOC entry 3501 (class 2606 OID 16789)
-- Name: guf_userfeedbacks_guf_rating uk_53dsw4x938m53yxgfwk8ee636; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks_guf_rating
    ADD CONSTRAINT uk_53dsw4x938m53yxgfwk8ee636 UNIQUE (detailedratinglist_id);


--
-- TOC entry 3610 (class 2606 OID 16818)
-- Name: useraddress uk_8te6nqcuovmv45ej1oej73hg3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.useraddress
    ADD CONSTRAINT uk_8te6nqcuovmv45ej1oej73hg3 UNIQUE (addressid);


--
-- TOC entry 3533 (class 2606 OID 16797)
-- Name: metadata uk_e9w46i6v429h02tmynm3eefiy; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadata
    ADD CONSTRAINT uk_e9w46i6v429h02tmynm3eefiy UNIQUE (uuid);


--
-- TOC entry 3539 (class 2606 OID 16801)
-- Name: metadatadraft uk_fuc1tr6xyyrbjrxg0feavofb2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatadraft
    ADD CONSTRAINT uk_fuc1tr6xyyrbjrxg0feavofb2 UNIQUE (uuid);


--
-- TOC entry 3520 (class 2606 OID 16792)
-- Name: links uk_fwi9l3n3vcxonf7c3x1ntdivx; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT uk_fwi9l3n3vcxonf7c3x1ntdivx UNIQUE (url);


--
-- TOC entry 3541 (class 2606 OID 16799)
-- Name: metadatadraft uk_itccbjhvevxbh1g4axknj8n24; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatadraft
    ADD CONSTRAINT uk_itccbjhvevxbh1g4axknj8n24 UNIQUE (approvedversion_id);


--
-- TOC entry 3575 (class 2606 OID 16813)
-- Name: schematron ukk7c29i3x0x6p5hbvb0qsdmuek; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematron
    ADD CONSTRAINT ukk7c29i3x0x6p5hbvb0qsdmuek UNIQUE (schemaname, filename);


--
-- TOC entry 3608 (class 2606 OID 16816)
-- Name: translations ukl29iu1rtihaxn070vb0j2g3hw; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translations
    ADD CONSTRAINT ukl29iu1rtihaxn070vb0j2g3hw UNIQUE (field, langid);


--
-- TOC entry 3612 (class 2606 OID 16745)
-- Name: useraddress useraddress_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.useraddress
    ADD CONSTRAINT useraddress_pkey PRIMARY KEY (userid, addressid);


--
-- TOC entry 3614 (class 2606 OID 16750)
-- Name: usergroups usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_pkey PRIMARY KEY (groupid, profile, userid);


--
-- TOC entry 3618 (class 2606 OID 16758)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3621 (class 2606 OID 16763)
-- Name: usersavedselections usersavedselections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersavedselections
    ADD CONSTRAINT usersavedselections_pkey PRIMARY KEY (metadatauuid, selectionid, userid);


--
-- TOC entry 3625 (class 2606 OID 16775)
-- Name: usersearch_group usersearch_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersearch_group
    ADD CONSTRAINT usersearch_group_pkey PRIMARY KEY (usersearch_id, group_id);


--
-- TOC entry 3623 (class 2606 OID 16770)
-- Name: usersearch usersearch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersearch
    ADD CONSTRAINT usersearch_pkey PRIMARY KEY (id);


--
-- TOC entry 3627 (class 2606 OID 16780)
-- Name: usersearchdes usersearchdes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersearchdes
    ADD CONSTRAINT usersearchdes_pkey PRIMARY KEY (iddes, langid);


--
-- TOC entry 3630 (class 2606 OID 16787)
-- Name: validation validation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.validation
    ADD CONSTRAINT validation_pkey PRIMARY KEY (metadataid, valtype);


--
-- TOC entry 3508 (class 1259 OID 16790)
-- Name: idx_inspireatomfeed_metadataid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inspireatomfeed_metadataid ON public.inspireatomfeed USING btree (metadataid);


--
-- TOC entry 3521 (class 1259 OID 16793)
-- Name: idx_linkstatus_isfailing; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_linkstatus_isfailing ON public.linkstatus USING btree (failing);


--
-- TOC entry 3550 (class 1259 OID 16805)
-- Name: idx_metadatalink_linkid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_metadatalink_linkid ON public.metadatalink USING btree (linkid);


--
-- TOC entry 3551 (class 1259 OID 16804)
-- Name: idx_metadatalink_metadataid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_metadatalink_metadataid ON public.metadatalink USING btree (metadataid);


--
-- TOC entry 3556 (class 1259 OID 16810)
-- Name: idx_metadatastatus_changedate; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_metadatastatus_changedate ON public.metadatastatus USING btree (changedate);


--
-- TOC entry 3557 (class 1259 OID 16806)
-- Name: idx_metadatastatus_metadataid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_metadatastatus_metadataid ON public.metadatastatus USING btree (metadataid);


--
-- TOC entry 3558 (class 1259 OID 16809)
-- Name: idx_metadatastatus_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_metadatastatus_owner ON public.metadatastatus USING btree (owner);


--
-- TOC entry 3559 (class 1259 OID 16807)
-- Name: idx_metadatastatus_statusid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_metadatastatus_statusid ON public.metadatastatus USING btree (statusid);


--
-- TOC entry 3560 (class 1259 OID 16808)
-- Name: idx_metadatastatus_userid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_metadatastatus_userid ON public.metadatastatus USING btree (userid);


--
-- TOC entry 3604 (class 1259 OID 16814)
-- Name: idx_translations_lang; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_translations_lang ON public.translations USING btree (langid);


--
-- TOC entry 3619 (class 1259 OID 16821)
-- Name: idx_usersavedselections_metadatauuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usersavedselections_metadatauuid ON public.usersavedselections USING btree (metadatauuid);


--
-- TOC entry 3628 (class 1259 OID 16822)
-- Name: idx_validation_metadataid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_validation_metadataid ON public.validation USING btree (metadataid);


--
-- TOC entry 3542 (class 1259 OID 16802)
-- Name: ix_metadatafiledownloads_mdid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_metadatafiledownloads_mdid ON public.metadatafiledownloads USING btree (metadataid);


--
-- TOC entry 3545 (class 1259 OID 16803)
-- Name: ix_metadatafileuploads_mdid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_metadatafileuploads_mdid ON public.metadatafileuploads USING btree (metadataid);


--
-- TOC entry 3563 (class 1259 OID 16811)
-- Name: ix_operationallowed_mdid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_operationallowed_mdid ON public.operationallowed USING btree (metadataid);


--
-- TOC entry 3661 (class 2606 OID 17001)
-- Name: schematrondes fk134nfqy1njol3whafs4452o7p; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematrondes
    ADD CONSTRAINT fk134nfqy1njol3whafs4452o7p FOREIGN KEY (iddes) REFERENCES public.schematron(id);


--
-- TOC entry 3670 (class 2606 OID 17046)
-- Name: usersavedselections fk1dlybmn1uw13o92d59ubg9l3o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersavedselections
    ADD CONSTRAINT fk1dlybmn1uw13o92d59ubg9l3o FOREIGN KEY (selectionid) REFERENCES public.selections(id);


--
-- TOC entry 3642 (class 2606 OID 16921)
-- Name: guf_userfeedbacks fk1dywlancj7y3cial42sm1rkr7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks
    ADD CONSTRAINT fk1dywlancj7y3cial42sm1rkr7 FOREIGN KEY (parent_uuid) REFERENCES public.guf_userfeedbacks(uuid);


--
-- TOC entry 3648 (class 2606 OID 16936)
-- Name: harvestersettings fk2cqc1oca0gov1xjjs45yc0y3v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.harvestersettings
    ADD CONSTRAINT fk2cqc1oca0gov1xjjs45yc0y3v FOREIGN KEY (parentid) REFERENCES public.harvestersettings(id) ON DELETE CASCADE;


--
-- TOC entry 3659 (class 2606 OID 16991)
-- Name: schematroncriteria fk3tno1j5h8lla4ad6con5x7xrs; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematroncriteria
    ADD CONSTRAINT fk3tno1j5h8lla4ad6con5x7xrs FOREIGN KEY (group_name, group_schematronid) REFERENCES public.schematroncriteriagroup(name, schematronid);


--
-- TOC entry 3646 (class 2606 OID 16926)
-- Name: guf_userfeedbacks_guf_rating fk4e2gfvv6vvjsf1fwhv5fm8qug; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks_guf_rating
    ADD CONSTRAINT fk4e2gfvv6vvjsf1fwhv5fm8qug FOREIGN KEY (detailedratinglist_id) REFERENCES public.guf_rating(id);


--
-- TOC entry 3643 (class 2606 OID 16911)
-- Name: guf_userfeedbacks fk5fs31wee12rnvk4uq3futtwx8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks
    ADD CONSTRAINT fk5fs31wee12rnvk4uq3futtwx8 FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- TOC entry 3639 (class 2606 OID 16891)
-- Name: guf_ratingcriteriades fk7fgytrvbd2p0wq68uu52fvw77; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_ratingcriteriades
    ADD CONSTRAINT fk7fgytrvbd2p0wq68uu52fvw77 FOREIGN KEY (iddes) REFERENCES public.guf_ratingcriteria(id);


--
-- TOC entry 3675 (class 2606 OID 17071)
-- Name: usersearchdes fk8bvpbpbvt880m9cnb3c46oi61; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersearchdes
    ADD CONSTRAINT fk8bvpbpbvt880m9cnb3c46oi61 FOREIGN KEY (iddes) REFERENCES public.usersearch(id);


--
-- TOC entry 3637 (class 2606 OID 16886)
-- Name: guf_rating fkac2ja64p75d9wt5dnqkh1ak3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_rating
    ADD CONSTRAINT fkac2ja64p75d9wt5dnqkh1ak3d FOREIGN KEY (userfeedback_id) REFERENCES public.guf_userfeedbacks(uuid);


--
-- TOC entry 3654 (class 2606 OID 16966)
-- Name: metadatadraft fkb9t4gg74qa9arfjbhtd8k8rjd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatadraft
    ADD CONSTRAINT fkb9t4gg74qa9arfjbhtd8k8rjd FOREIGN KEY (approvedversion_id) REFERENCES public.metadata(id);


--
-- TOC entry 3664 (class 2606 OID 17016)
-- Name: spg_sections fkc1igxctl66s2y0lybilfxyr1u; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spg_sections
    ADD CONSTRAINT fkc1igxctl66s2y0lybilfxyr1u FOREIGN KEY (spg_page_language, spg_page_linktext) REFERENCES public.spg_page(language, linktext);


--
-- TOC entry 3673 (class 2606 OID 17061)
-- Name: usersearch_group fke4vw2pb2yy1s5gl1fjw39pbwy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersearch_group
    ADD CONSTRAINT fke4vw2pb2yy1s5gl1fjw39pbwy FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3649 (class 2606 OID 16941)
-- Name: inspireatomfeed_entrylist fke50emwo62bs4rebxuipq5reux; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspireatomfeed_entrylist
    ADD CONSTRAINT fke50emwo62bs4rebxuipq5reux FOREIGN KEY (inspireatomfeed_id) REFERENCES public.inspireatomfeed(id);


--
-- TOC entry 3672 (class 2606 OID 17056)
-- Name: usersearch fkelx0lms0v5rv3xlvamxtbb4ar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersearch
    ADD CONSTRAINT fkelx0lms0v5rv3xlvamxtbb4ar FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- TOC entry 3632 (class 2606 OID 16856)
-- Name: email fkemafd9x1hmt6f2v4dr5qgks79; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT fkemafd9x1hmt6f2v4dr5qgks79 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3666 (class 2606 OID 17031)
-- Name: useraddress fkfmhko1hdo84edmaylhlikax1w; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.useraddress
    ADD CONSTRAINT fkfmhko1hdo84edmaylhlikax1w FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- TOC entry 3658 (class 2606 OID 16986)
-- Name: operationsdes fkfrwne5bgphqcf5ujidkjb4x21; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operationsdes
    ADD CONSTRAINT fkfrwne5bgphqcf5ujidkjb4x21 FOREIGN KEY (iddes) REFERENCES public.operations(id);


--
-- TOC entry 3656 (class 2606 OID 16981)
-- Name: metadatastatus fkgf12fblfohqs5f8ln9ymj8bph; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatastatus
    ADD CONSTRAINT fkgf12fblfohqs5f8ln9ymj8bph FOREIGN KEY (statusid) REFERENCES public.statusvalues(id);


--
-- TOC entry 3633 (class 2606 OID 16866)
-- Name: group_category fkgohj7i0hd3j39ck4gpd9yciyd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_category
    ADD CONSTRAINT fkgohj7i0hd3j39ck4gpd9yciyd FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- TOC entry 3665 (class 2606 OID 17021)
-- Name: statusvaluesdes fkgw4mleubu37tior3ctorjoqrj; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statusvaluesdes
    ADD CONSTRAINT fkgw4mleubu37tior3ctorjoqrj FOREIGN KEY (iddes) REFERENCES public.statusvalues(id);


--
-- TOC entry 3647 (class 2606 OID 16931)
-- Name: guf_userfeedbacks_guf_rating fkh3ed3wakehxpnry31tslimy7f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks_guf_rating
    ADD CONSTRAINT fkh3ed3wakehxpnry31tslimy7f FOREIGN KEY (guf_userfeedback_uuid) REFERENCES public.guf_userfeedbacks(uuid);


--
-- TOC entry 3640 (class 2606 OID 16896)
-- Name: guf_userfeedback_keyword fkh9mgx854gcod9pu6bm4ss811t; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedback_keyword
    ADD CONSTRAINT fkh9mgx854gcod9pu6bm4ss811t FOREIGN KEY (keyword_id) REFERENCES public.guf_keywords(id);


--
-- TOC entry 3663 (class 2606 OID 17011)
-- Name: sourcesdes fkhbf76tinp79xw11hf1m4isp8c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sourcesdes
    ADD CONSTRAINT fkhbf76tinp79xw11hf1m4isp8c FOREIGN KEY (iddes) REFERENCES public.sources(uuid);


--
-- TOC entry 3674 (class 2606 OID 17066)
-- Name: usersearch_group fkhtcu5iot2xe0y5yhxvof7mjam; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersearch_group
    ADD CONSTRAINT fkhtcu5iot2xe0y5yhxvof7mjam FOREIGN KEY (usersearch_id) REFERENCES public.usersearch(id);


--
-- TOC entry 3635 (class 2606 OID 16871)
-- Name: groups fkj3jp00tlvelfgsg1vjp5l3nf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fkj3jp00tlvelfgsg1vjp5l3nf FOREIGN KEY (defaultcategory_id) REFERENCES public.categories(id);


--
-- TOC entry 3636 (class 2606 OID 16876)
-- Name: groupsdes fkjrp9gmobxptqovx4vhnncv147; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groupsdes
    ADD CONSTRAINT fkjrp9gmobxptqovx4vhnncv147 FOREIGN KEY (iddes) REFERENCES public.groups(id);


--
-- TOC entry 3668 (class 2606 OID 17041)
-- Name: usergroups fkml33uht6cka05y27o7tai781y; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT fkml33uht6cka05y27o7tai781y FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- TOC entry 3652 (class 2606 OID 16956)
-- Name: metadatacateg fknk98usj3vi3et8ko6lfmuh1g0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatacateg
    ADD CONSTRAINT fknk98usj3vi3et8ko6lfmuh1g0 FOREIGN KEY (categoryid) REFERENCES public.categories(id);


--
-- TOC entry 3667 (class 2606 OID 17026)
-- Name: useraddress fko00ntdyv9mj4lwywrp2hs8bj0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.useraddress
    ADD CONSTRAINT fko00ntdyv9mj4lwywrp2hs8bj0 FOREIGN KEY (addressid) REFERENCES public.address(id);


--
-- TOC entry 3641 (class 2606 OID 16901)
-- Name: guf_userfeedback_keyword fko3b1k9bho6p740haq47g1fab7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedback_keyword
    ADD CONSTRAINT fko3b1k9bho6p740haq47g1fab7 FOREIGN KEY (userfeedback_uuid) REFERENCES public.guf_userfeedbacks(uuid);


--
-- TOC entry 3651 (class 2606 OID 16951)
-- Name: linkstatus fkp5kjknw6whjr91s4h9xtadgv6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.linkstatus
    ADD CONSTRAINT fkp5kjknw6whjr91s4h9xtadgv6 FOREIGN KEY (link) REFERENCES public.links(id);


--
-- TOC entry 3634 (class 2606 OID 16861)
-- Name: group_category fkp8fp2e2ihonmmyp9wsyx748t3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_category
    ADD CONSTRAINT fkp8fp2e2ihonmmyp9wsyx748t3 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 3655 (class 2606 OID 16971)
-- Name: metadatalink fkpjuqhhlh09cdpl9bfgb1e0756; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatalink
    ADD CONSTRAINT fkpjuqhhlh09cdpl9bfgb1e0756 FOREIGN KEY (linkid) REFERENCES public.links(id);


--
-- TOC entry 3669 (class 2606 OID 17036)
-- Name: usergroups fkpvt3pynb0pfi5ouvk2m4uvrwp; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT fkpvt3pynb0pfi5ouvk2m4uvrwp FOREIGN KEY (groupid) REFERENCES public.groups(id);


--
-- TOC entry 3638 (class 2606 OID 16881)
-- Name: guf_rating fkpwjtc2mefxb8n08mq12ug0gko; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_rating
    ADD CONSTRAINT fkpwjtc2mefxb8n08mq12ug0gko FOREIGN KEY (criteria_id) REFERENCES public.guf_ratingcriteria(id);


--
-- TOC entry 3671 (class 2606 OID 17051)
-- Name: usersavedselections fkq971r8i90nbrn42wgw43f71bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usersavedselections
    ADD CONSTRAINT fkq971r8i90nbrn42wgw43f71bd FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- TOC entry 3653 (class 2606 OID 16961)
-- Name: metadatacateg fkrymar8yhocdu09m6erb49b1bo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatacateg
    ADD CONSTRAINT fkrymar8yhocdu09m6erb49b1bo FOREIGN KEY (metadataid) REFERENCES public.metadata(id);


--
-- TOC entry 3644 (class 2606 OID 16906)
-- Name: guf_userfeedbacks fks2f484931snpkem6kl4wm3wmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks
    ADD CONSTRAINT fks2f484931snpkem6kl4wm3wmd FOREIGN KEY (approver_id) REFERENCES public.users(id);


--
-- TOC entry 3662 (class 2606 OID 17006)
-- Name: selectionsdes fksajphs09xp3bsyvnactn7nuda; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selectionsdes
    ADD CONSTRAINT fksajphs09xp3bsyvnactn7nuda FOREIGN KEY (iddes) REFERENCES public.selections(id);


--
-- TOC entry 3631 (class 2606 OID 16851)
-- Name: categoriesdes fkso3adnjy8lpuw1fvpdws0o36n; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoriesdes
    ADD CONSTRAINT fkso3adnjy8lpuw1fvpdws0o36n FOREIGN KEY (iddes) REFERENCES public.categories(id);


--
-- TOC entry 3645 (class 2606 OID 16916)
-- Name: guf_userfeedbacks fkt4wa27oh82hshey01c4o8pv5b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guf_userfeedbacks
    ADD CONSTRAINT fkt4wa27oh82hshey01c4o8pv5b FOREIGN KEY (metadata_uuid) REFERENCES public.metadata(uuid);


--
-- TOC entry 3660 (class 2606 OID 16996)
-- Name: schematroncriteriagroup fkt8avbrgs5j8xvoros154qim3k; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schematroncriteriagroup
    ADD CONSTRAINT fkt8avbrgs5j8xvoros154qim3k FOREIGN KEY (schematronid) REFERENCES public.schematron(id);


--
-- TOC entry 3650 (class 2606 OID 16946)
-- Name: isolanguagesdes fktclc2b6qjjptx7lgll1dd5e3y; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.isolanguagesdes
    ADD CONSTRAINT fktclc2b6qjjptx7lgll1dd5e3y FOREIGN KEY (iddes) REFERENCES public.isolanguages(id);


--
-- TOC entry 3657 (class 2606 OID 16976)
-- Name: metadatastatus fktih0k768u8kuwxsp8dnm9kru3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metadatastatus
    ADD CONSTRAINT fktih0k768u8kuwxsp8dnm9kru3 FOREIGN KEY (relatedmetadatastatusid) REFERENCES public.metadatastatus(id);


-- Completed on 2023-02-15 10:17:58

--
-- PostgreSQL database dump complete
--

