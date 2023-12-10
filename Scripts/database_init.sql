-- schema creation
DROP SCHEMA IF EXISTS GenshinDB CASCADE;

CREATE SCHEMA GenshinDB;

SET search_path = GenshinDB;

-- enums creation
CREATE TYPE element_type AS ENUM ('Physical', 'Anemo', 'Geo', 'Electro', 'Dendro', 'Hydro', 'Pyro', 'Cryo');
CREATE TYPE weapon_type AS ENUM ('One handed', 'Two handed', 'Bow', 'Spear', 'Catalyst');
CREATE TYPE skill_type AS ENUM ('Elemental', 'Ultimate');
CREATE TYPE artifact_type AS ENUM ('Hat', 'Clock', 'Flower');
CREATE TYPE item_type AS ENUM ('Character', 'Artifact', 'Weapon');

-- tables creation
-- updates
DROP TABLE IF EXISTS updates CASCADE;
CREATE TABLE updates (
    id SERIAL PRIMARY KEY,
    version FLOAT NOT NULL,
    type item_type NOT NULL,
    item_id INT NOT NULL
);

-- characters

-- artifacts
DROP TABLE IF EXISTS artifacts CASCADE;
CREATE TABLE artifacts (
    id SERIAL PRIMARY KEY,
    set_name TEXT NOT NULL,
    type artifact_type NOT NULL,
    UNIQUE (set_name, type)
);

-- weapons
DROP TABLE IF EXISTS weapons CASCADE;
CREATE TABLE weapons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    type weapon_type NOT NULL
);

-- elements
DROP TABLE IF EXISTS elements CASCADE;
CREATE TABLE elements(
    type element_type PRIMARY KEY,
    reactions BOOLEAN[8] DEFAULT '{false, false, false, false, false, false, false, false}'::BOOLEAN[]
);

-- countries


-- units

-- stats
DROP TABLE IF EXISTS stats CASCADE;
CREATE TABLE stats(
    id SERIAL PRIMARY KEY,
    damage INT DEFAULT 0,
    damage_coef FLOAT DEFAULT 1,
    hp INT DEFAULT 0,
    hp_coef FLOAT DEFAULT 1,
    heal_coef FLOAT DEFAULT 0,
    elemental_coefs FLOAT[8] DEFAULT '{1, 1, 1, 1, 1, 1, 1, 1}'::FLOAT[]
);

-- players
DROP TABLE IF EXISTS players CASCADE;
CREATE TABLE players(
    id SERIAL PRIMARY KEY,
    elemental_bonus FLOAT[8] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}'::FLOAT[]
);

-- skills
DROP TABLE IF EXISTS skills CASCADE;
CREATE TABLE skills(
    id SERIAL PRIMARY KEY,
    name TEXT,
    type skill_type NOT NULL,
    base_damage INT DEFAULT 0,
    base_heal FLOAT DEFAULT 0,
    cooldown FLOAT DEFAULT 5.5
);

-- adding foreign keys
ALTER TABLE artifacts ADD COLUMN update INT references updates(id);
ALTER TABLE artifacts ADD COLUMN stats INT references stats(id);
ALTER TABLE artifacts ADD COLUMN set_bonus_stats INT references stats(id);

ALTER TABLE weapons ADD COLUMN stats INT references stats(id);
ALTER TABLE weapons ADD COLUMN update INT references updates(id);

--ALTER TABLE elements ADD COLUMN country int references countries(id);

--ALTER TABLE players ADD COLUMN unit_1 INT REFERENCES units(id);
--ALTER TABLE players ADD COLUMN unit_2 INT REFERENCES units(id);
--ALTER TABLE players ADD COLUMN unit_3 INT REFERENCES units(id);
--ALTER TABLE players ADD COLUMN unit_4 INT REFERENCES units(id);

--ALTER TABLE skills ADD COLUMN character_id INT REFERENCES characters(id);

ALTER TABLE stats ADD CHECK (array_ndims(elemental_coefs) = 1 AND array_length(elemental_coefs, 1) = 8);
ALTER TABLE players ADD CHECK (array_ndims(elemental_bonus) = 1 AND array_length(elemental_bonus, 1) = 8);
ALTER TABLE elements ADD CHECK (array_ndims(reactions) = 1 AND array_length(reactions, 1) = 8);