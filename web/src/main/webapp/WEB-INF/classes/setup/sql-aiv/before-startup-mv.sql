
UPDATE settings SET position = "[position]" WHERE "[position]" IS NOT NULL;
ALTER TABLE settings DROP COLUMN "[position]";

UPDATE metadata SET data = "[data]" WHERE "[data]" IS NOT NULL;
ALTER TABLE metadata DROP COLUMN "[data]";

UPDATE metadata SET source = "[source]" WHERE "[source]" IS NOT NULL;
ALTER TABLE metadata DROP COLUMN "[source]";
