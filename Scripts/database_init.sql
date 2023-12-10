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


-- characters
DROP TABLE IF EXISTS characters CASCADE;
CREATE TABLE characters(
    id SERIAL PRIMARY KEY,
    aboba TEXT
);


-- artifacts


-- weapons


-- elements
DROP TABLE IF EXISTS elements CASCADE;
CREATE TABLE elements(
    id SERIAL PRIMARY KEY,
    aboba TEXT
);


-- countries


-- units
DROP TABLE IF EXISTS units CASCADE;
CREATE TABLE units(
    id SERIAL PRIMARY KEY,
    aboba TEXT
);


-- stats
DROP TABLE IF EXISTS stats CASCADE;
CREATE TABLE stats(
    id SERIAL PRIMARY KEY,
    damage INT DEFAULT 0,
    damage_coef FLOAT DEFAULT 1,
    hp INT DEFAULT 0,
    hp_coef FLOAT DEFAULT 1,
    heal_coef FLOAT DEFAULT 0,
    element INT REFERENCES elements(id),
    elemental_coef FLOAT DEFAULT 1
);


-- players
DROP TABLE IF EXISTS players CASCADE;
CREATE TABLE players(
    id SERIAL PRIMARY KEY,
    unit_1 INT REFERENCES units(id),
    unit_2 INT REFERENCES units(id),
    unit_3 INT REFERENCES units(id),
    unit_4 INT REFERENCES units(id),
    elemental_bonus FLOAT[] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}'::FLOAT[]
);


-- skills
DROP TABLE IF EXISTS skills CASCADE;
CREATE TABLE skills(
    id SERIAL PRIMARY KEY,
    name TEXT,
    character_id INT REFERENCES characters(id),
    type skill_type NOT NULL,
    base_damage INT DEFAULT 0,
    base_heal FLOAT DEFAULT 0,
    cooldown FLOAT DEFAULT 5.5
);
