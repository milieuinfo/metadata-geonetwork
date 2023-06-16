--liquibase formatted sql
--changeset fxprunayre:00023

alter table public.spg_sections
drop column page_language;

alter table public.spg_sections
drop column page_linktext;
