ALTER TABLE public."groups" ADD orgcode varchar NULL;
COMMENT ON COLUMN public."groups".orgcode IS 'the org code for this group, as returned by acm/idm';
ALTER TABLE public."groups" ADD ismdc bool NULL;
COMMENT ON COLUMN public."groups".ismdc IS 'whether this group is a metadatacenter group or not';

ALTER TABLE public."groups" ALTER COLUMN "name" TYPE varchar(255) USING "name"::varchar;

ALTER TABLE public."groups" ADD CONSTRAINT groups_unq_orgcode_mdc UNIQUE (ismdc,orgcode);
