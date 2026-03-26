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
CREATE TABLE "entity_tmpl_attributes" (
    "id" bigserial PRIMARY KEY,
    "entityTmplId" uuid NOT NULL,
    "attributeTmplId" uuid NOT NULL,
    "orderIdx" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "entity_tmpl_attribute_unique_idx" ON "entity_tmpl_attributes" USING btree ("entityTmplId", "attributeTmplId");
CREATE UNIQUE INDEX "entity_tmpl_attribute_order_idx_unique_idx" ON "entity_tmpl_attributes" USING btree ("entityTmplId", "orderIdx");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "entity_tmpl_links" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "orderIdx" bigint NOT NULL,
    "sourceId" uuid NOT NULL,
    "targetId" uuid NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "entity_link_tmpl_source_name_uniq_idx" ON "entity_tmpl_links" USING btree ("sourceId", "name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "entity_tmpls" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text
);

-- Indexes
CREATE UNIQUE INDEX "entity_tmpl_name_desc_uniq_idx" ON "entity_tmpls" USING btree ("name", "description");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "entity_tmpl_attributes"
    ADD CONSTRAINT "entity_tmpl_attributes_fk_0"
    FOREIGN KEY("entityTmplId")
    REFERENCES "entity_tmpls"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "entity_tmpl_attributes"
    ADD CONSTRAINT "entity_tmpl_attributes_fk_1"
    FOREIGN KEY("attributeTmplId")
    REFERENCES "attribute_tmpls"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "entity_tmpl_links"
    ADD CONSTRAINT "entity_tmpl_links_fk_0"
    FOREIGN KEY("sourceId")
    REFERENCES "entity_tmpls"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "entity_tmpl_links"
    ADD CONSTRAINT "entity_tmpl_links_fk_1"
    FOREIGN KEY("targetId")
    REFERENCES "entity_tmpls"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR akasha
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('akasha', '20260326170937357-entity-tmpls', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260326170937357-entity-tmpls', "timestamp" = now();

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
