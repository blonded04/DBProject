-- schema creation
DROP SCHEMA IF EXISTS GenshinDB CASCADE;

CREATE SCHEMA GenshinDB;

SET search_path = GenshinDB;

-- enums creation
CREATE TYPE t_element AS ENUM ('Physical', 'Anemo', 'Geo', 'Electro', 'Dendro', 'Hydro', 'Pyro', 'Cryo');
CREATE TYPE t_weapon AS ENUM ('One handed', 'Two handed', 'Bow', 'Spear', 'Catalyst');
CREATE TYPE t_skill AS ENUM ('Elemental', 'Ultimate');
CREATE TYPE t_artifact AS ENUM ('Hat', 'Clock', 'Flower');
CREATE TYPE t_item AS ENUM ('Character', 'Artifact', 'Weapon');

-- tables creation
-- elements
CREATE TABLE elements(
    name t_element PRIMARY KEY,
    reactions BOOLEAN[8] DEFAULT '{false, false, false, false, false, false, false, false}'::BOOLEAN[]
);

-- countries
CREATE TABLE countries(
    name TEXT PRIMARY KEY,
    element t_element NOT NULL,
    archont TEXT DEFAULT ''
);

-- updates
CREATE TABLE updates (
    id SERIAL PRIMARY KEY,
    version FLOAT NOT NULL,
    type t_item NOT NULL,
    item TEXT NOT NULL
);

-- stats
CREATE TABLE stats(
    id SERIAL PRIMARY KEY,
    damage INT DEFAULT 0,
    damage_coef FLOAT DEFAULT 0,
    hp INT DEFAULT 0,
    hp_coef FLOAT DEFAULT 0,
    heal_coef FLOAT DEFAULT 0,
    elemental_coefs FLOAT[8] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}'::FLOAT[]
);

-- artifacts
CREATE TABLE artifacts (
    name TEXT PRIMARY KEY,
    set_name TEXT NOT NULL,
    type t_artifact NOT NULL,
    update INT references updates(id),
    stats INT references stats(id),
    set_bonus_stats INT references stats(id),
    UNIQUE (set_name, type)
);

-- weapons
CREATE TABLE weapons (
    name TEXT PRIMARY KEY,
    type t_weapon NOT NULL,
    stats INT references stats(id),
    update INT references updates(id)
);

-- skills
CREATE TABLE skills(
    name TEXT PRIMARY KEY,
    type t_skill NOT NULL,
    base_damage INT DEFAULT 0,
    base_heal FLOAT DEFAULT 0,
    cooldown FLOAT DEFAULT 5.5
);

-- characters
CREATE TABLE characters(
    name TEXT PRIMARY KEY,
    weapon_type t_weapon NOT NULL,
    country TEXT references countries(name),
    base_stats INT references stats(id),
    update INT references updates(id),
    element t_element references elements(name),
    elemental_skill TEXT references skills(name),
    ultimate_skill TEXT references skills(name)
);

-- units
CREATE TABLE units(
    id SERIAL PRIMARY KEY,
    character TEXT REFERENCES characters(name),
    weapon TEXT REFERENCES weapons(name),
    flower_artifact TEXT REFERENCES artifacts(name),
    clock_artifact TEXT REFERENCES artifacts(name),
    hat_artifact TEXT REFERENCES artifacts(name),
    total_hp INT DEFAULT 1000,
    additional_damage INT DEFAULT 0,
    boost_damage FLOAT DEFAULT 1,
    boost_elemental FLOAT[8] DEFAULT '{1, 1, 1, 1, 1, 1, 1, 1}'::FLOAT[],
    boost_heal FLOAT DEFAULT 1
);

-- players
CREATE TABLE players(
    id SERIAL PRIMARY KEY,
    unit_1 INT REFERENCES units(id),
    unit_2 INT REFERENCES units(id),
    unit_3 INT REFERENCES units(id),
    unit_4 INT REFERENCES units(id),
    elemental_bonus FLOAT[8] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}'::FLOAT[]
);

-- adding array constraints
ALTER TABLE stats ADD CHECK (array_ndims(elemental_coefs) = 1 AND array_length(elemental_coefs, 1) = 8);
ALTER TABLE players ADD CHECK (array_ndims(elemental_bonus) = 1 AND array_length(elemental_bonus, 1) = 8);
ALTER TABLE units ADD CHECK (array_ndims(boost_elemental) = 1 AND array_length(boost_elemental, 1) = 8);
ALTER TABLE elements ADD CHECK (array_ndims(reactions) = 1 AND array_length(reactions, 1) = 8);

CREATE OR REPLACE FUNCTION weapon_check("character" TEXT, weapon TEXT) RETURNS BOOLEAN AS $$ 
BEGIN
RETURN (SELECT weapon_type FROM "characters" WHERE "name" = "character") = (SELECT "type" FROM weapons WHERE "name" = weapon);
END;
$$ LANGUAGE plpgsql;

ALTER TABLE units ADD CHECK (weapon_check("character", weapon));

CREATE OR REPLACE FUNCTION artifact_check(artifact TEXT, "type" TEXT) RETURNS BOOLEAN AS $$ 
BEGIN
RETURN ((SELECT "type" FROM "artifacts" WHERE "name" = artifact) = "type");
END;
$$ LANGUAGE plpgsql;

ALTER TABLE units ADD CHECK (artifact_check(flower_artifact, 'Flower'));
ALTER TABLE units ADD CHECK (artifact_check(clock_artifact, 'Clock'));
ALTER TABLE units ADD CHECK (artifact_check(hat_artifact, 'Hat'));

