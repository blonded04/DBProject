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
    _name t_element PRIMARY KEY,
    _reactions BOOLEAN[8] DEFAULT '{false, false, false, false, false, false, false, false}'::BOOLEAN[]
);

-- countries
CREATE TABLE countries(
    _name TEXT PRIMARY KEY,
    _element t_element NOT NULL,
    _archont TEXT DEFAULT ''
);

-- updates
CREATE TABLE updates(
    _id SERIAL PRIMARY KEY,
    _version FLOAT NOT NULL,
    _type t_item NOT NULL,
    _item TEXT NOT NULL
);

-- stats
CREATE TABLE stats(
    _id SERIAL PRIMARY KEY,
    _damage INT DEFAULT 0,
    _damage_coef FLOAT DEFAULT 0,
    _hp INT DEFAULT 0,
    _hp_coef FLOAT DEFAULT 0,
    _heal_coef FLOAT DEFAULT 0,
    _elemental_coefs FLOAT[8] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}'::FLOAT[]
);

-- artifacts
CREATE TABLE artifacts(
    _name TEXT PRIMARY KEY,
    _set_name TEXT NOT NULL,
    _type t_artifact NOT NULL,
    _update INT references updates(_id),
    _stats INT references stats(_id),
    _set_bonus_stats INT references stats(_id),
    UNIQUE (_set_name, _type)
);

-- weapons
CREATE TABLE weapons(
    _name TEXT PRIMARY KEY,
    _type t_weapon NOT NULL,
    _stats INT references stats(_id),
    _update INT references updates(_id)
);

-- skills
CREATE TABLE skills(
    _name TEXT PRIMARY KEY,
    _type t_skill NOT NULL,
    _base_damage INT DEFAULT 0,
    _base_heal FLOAT DEFAULT 0,
    _cooldown FLOAT DEFAULT 5.5
);

-- characters
CREATE TABLE characters(
    _name TEXT PRIMARY KEY,
    _weapon_type t_weapon NOT NULL,
    _country TEXT references countries(_name),
    _base_stats INT references stats(_id),
    _update INT references updates(_id),
    _element t_element references elements(_name),
    _elemental_skill TEXT references skills(_name),
    _ultimate_skill TEXT references skills(_name)
);

-- units
CREATE TABLE units(
    _id SERIAL PRIMARY KEY,
    _character TEXT REFERENCES characters(_name),
    _weapon TEXT REFERENCES weapons(_name),
    _flower_artifact TEXT REFERENCES artifacts(_name),
    _clock_artifact TEXT REFERENCES artifacts(_name),
    _hat_artifact TEXT REFERENCES artifacts(_name),
    _total_hp INT DEFAULT 1000,
    _additional_damage INT DEFAULT 0,
    _boost_damage FLOAT DEFAULT 1,
    _boost_elemental FLOAT[8] DEFAULT '{1, 1, 1, 1, 1, 1, 1, 1}'::FLOAT[],
    _boost_heal FLOAT DEFAULT 1
);

-- players
CREATE TABLE players(
    _id SERIAL PRIMARY KEY,
    _unit_1 INT REFERENCES units(_id),
    _unit_2 INT REFERENCES units(_id),
    _unit_3 INT REFERENCES units(_id),
    _unit_4 INT REFERENCES units(_id),
    _elemental_bonus FLOAT[8] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}'::FLOAT[]
);

-- adding array constraints
ALTER TABLE stats ADD CHECK (array_ndims(_elemental_coefs) = 1 AND array_length(_elemental_coefs, 1) = 8);
ALTER TABLE players ADD CHECK (array_ndims(_elemental_bonus) = 1 AND array_length(_elemental_bonus, 1) = 8);
ALTER TABLE units ADD CHECK (array_ndims(_boost_elemental) = 1 AND array_length(_boost_elemental, 1) = 8);
ALTER TABLE elements ADD CHECK (array_ndims(_reactions) = 1 AND array_length(_reactions, 1) = 8);

CREATE OR REPLACE FUNCTION weapon_check(_character TEXT, _weapon TEXT) RETURNS BOOLEAN AS $$ 
BEGIN
RETURN (SELECT _weapon_type FROM "characters" WHERE _name = _character) = (SELECT _type FROM weapons WHERE _name = _weapon);
END;
$$ LANGUAGE plpgsql;

ALTER TABLE units ADD CHECK (weapon_check(_character, _weapon));

CREATE OR REPLACE FUNCTION artifact_check(_artifact TEXT, _type TEXT) RETURNS BOOLEAN AS $$ 
BEGIN
RETURN ((SELECT _type FROM artifacts WHERE _name_ = _artifact) = _type);
END;
$$ LANGUAGE plpgsql;

ALTER TABLE units ADD CHECK (artifact_check(_flower_artifact, 'Flower'));
ALTER TABLE units ADD CHECK (artifact_check(_clock_artifact, 'Clock'));
ALTER TABLE units ADD CHECK (artifact_check(_hat_artifact, 'Hat'));

