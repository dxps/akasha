BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "access_levels" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text
);

-- Indexes
CREATE UNIQUE INDEX "access_level_name_uniq_idx" ON "access_levels" USING btree ("name");

-------------------------------------
-- dxps: "access_levels" initial data
-------------------------------------
INSERT INTO "access_levels" ("name", "description") VALUES
    ('Public', 'Publicly accessible data'),
    ('Private', 'Private data'),
    ('Confidential', 'Confidential data')
ON CONFLICT DO NOTHING;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "attribute_tmpls" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "valueType" text NOT NULL,
    "defaultValue" text NOT NULL,
    "required" boolean NOT NULL,
    "accessLevelId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "attr_tmpl_name_desc_uniq_idx" ON "attribute_tmpls" USING btree ("name", "description");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "attribute_tmpls"
    ADD CONSTRAINT "attribute_tmpls_fk_0"
    FOREIGN KEY("accessLevelId")
    REFERENCES "access_levels"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR akasha
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('akasha', '20260318075304592-attr-tmpls-access-levels', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260318075304592-attr-tmpls-access-levels', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
