--liquibase formatted sql
--changeset fxprunayre:00015

UPDATE settings SET name = 'metadata/workflow/allowSubmitApproveInvalidMd'
WHERE name = 'metadata/workflow/allowSumitApproveInvalidMd';
