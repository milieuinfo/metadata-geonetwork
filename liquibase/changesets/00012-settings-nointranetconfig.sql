--liquibase formatted sql
--changeset fxprunayre:00012

UPDATE settings SET value = '' WHERE name = 'system/intranet/network';
UPDATE settings SET value = '' WHERE name = 'system/intranet/netmask';
