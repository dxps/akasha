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
CREATE TABLE "bool_attributes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "valueType" text NOT NULL,
    "value" boolean NOT NULL,
    "accessLevelId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "date_attributes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "valueType" text NOT NULL,
    "value" timestamp without time zone NOT NULL,
    "accessLevelId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "datetime_attributes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "valueType" text NOT NULL,
    "value" timestamp without time zone NOT NULL,
    "accessLevelId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "entities" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "listingAttribute" json NOT NULL,
    "attributesOrder" json NOT NULL,
    "textAttributes" json NOT NULL,
    "numberAttributes" json NOT NULL,
    "boolAttributes" json NOT NULL,
    "dateAttributes" json NOT NULL,
    "dateTimeAttributes" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "entity_links" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "orderIdx" bigint NOT NULL,
    "sourceId" uuid NOT NULL,
    "targetId" uuid NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "number_attributes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "valueType" text NOT NULL,
    "value" double precision NOT NULL,
    "accessLevelId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "text_attributes" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "valueType" text NOT NULL,
    "value" text NOT NULL,
    "accessLevelId" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bool_attributes"
    ADD CONSTRAINT "bool_attributes_fk_0"
    FOREIGN KEY("accessLevelId")
    REFERENCES "access_levels"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "date_attributes"
    ADD CONSTRAINT "date_attributes_fk_0"
    FOREIGN KEY("accessLevelId")
    REFERENCES "access_levels"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "datetime_attributes"
    ADD CONSTRAINT "datetime_attributes_fk_0"
    FOREIGN KEY("accessLevelId")
    REFERENCES "access_levels"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "entity_links"
    ADD CONSTRAINT "entity_links_fk_0"
    FOREIGN KEY("sourceId")
    REFERENCES "entities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "entity_links"
    ADD CONSTRAINT "entity_links_fk_1"
    FOREIGN KEY("targetId")
    REFERENCES "entities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "number_attributes"
    ADD CONSTRAINT "number_attributes_fk_0"
    FOREIGN KEY("accessLevelId")
    REFERENCES "access_levels"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "text_attributes"
    ADD CONSTRAINT "text_attributes_fk_0"
    FOREIGN KEY("accessLevelId")
    REFERENCES "access_levels"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR akasha
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('akasha', '20260403134452892-ent-and-attrs', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260403134452892-ent-and-attrs', "timestamp" = now();

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
