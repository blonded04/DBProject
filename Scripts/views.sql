DROP SCHEMA IF EXISTS GenshinViews CASCADE;

CREATE SCHEMA GenshinViews;

SET search_path = GenshinViews;

-- elements
CREATE OR REPLACE VIEW elements_view AS
SELECT _name, _reactions
FROM GenshinDB.elements;

-- countries
CREATE OR REPLACE VIEW countries_view AS
SELECT _name, _element, _archont
FROM GenshinDB.countries;

-- updates
CREATE OR REPLACE VIEW updates_view AS
SELECT _id, _version, _type, _item
FROM GenshinDB.updates;

-- stats
CREATE OR REPLACE VIEW stats_view AS
SELECT _id, _damage, _damage_coef, _hp, _hp_coef, _heal_coef, _elemental_coefs
FROM GenshinDB.stats;

-- artifacts
CREATE OR REPLACE VIEW artifacts_view AS
SELECT _name, _set_name, _type, _update, _stats, _set_bonus_stats
FROM GenshinDB.artifacts;

-- weapons
CREATE OR REPLACE VIEW weapons_view AS
SELECT _name, _type, _stats, _update
FROM GenshinDB.weapons;

-- skills
CREATE OR REPLACE VIEW skills_view AS
SELECT _name, _type, _base_damage, _base_heal, _cooldown
FROM GenshinDB.skills;

-- characters
CREATE OR REPLACE VIEW characters_view AS
SELECT _name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill
FROM GenshinDB.characters;

-- units
CREATE OR REPLACE VIEW units_view AS
SELECT _id, _total_hp, _character, _weapon_attack_damage, _elemental_skill_damage, _ultimate_skill_damage, _elemental_skill_heal, _ultimate_skill_heal
FROM GenshinDB.units;

-- players
CREATE OR REPLACE VIEW players_view AS
SELECT _id, _unit_1, _unit_2, _unit_3, _unit_4, _elemental_bonus
FROM GenshinDB.players;

-- hard

-- all archonts
CREATE OR REPLACE VIEW characters_archont_view AS
SELECT *
FROM GenshinDB.characters
WHERE _name = (SELECT _archont FROM GenshinDB.countries WHERE _name = characters._country);

-- sets stats
CREATE OR REPLACE VIEW artifact_stats_view AS
SELECT art._set_name,
    SUM(art._set_bonus_stats) AS total_set_bonus_stats,
    SUM(s._damage) AS total_damage,
    SUM(s._damage_coef) AS total_damage_coef,
    SUM(s._hp) AS total_hp,
    SUM(s._hp_coef) AS total_hp_coef,
    SUM(s._heal_coef) AS total_heal_coef,
    ARRAY[
        SUM(s._elemental_coefs[1]),
        SUM(s._elemental_coefs[2]),
        SUM(s._elemental_coefs[3]),
        SUM(s._elemental_coefs[4]),
        SUM(s._elemental_coefs[5]),
        SUM(s._elemental_coefs[6]),
        SUM(s._elemental_coefs[7]),
        SUM(s._elemental_coefs[8])
    ] AS total_elemental_coefs
FROM GenshinDB.artifacts art
JOIN GenshinDB.stats s ON art._stats = s._id
GROUP BY art._set_name;

-- ultimate skills of archonts
CREATE OR REPLACE VIEW characters_ultimate_skill_view AS
SELECT ch._name AS character_name, ch._ultimate_skill
FROM GenshinDB.characters ch
JOIN GenshinDB.countries cn ON ch._name = cn._archont
JOIN GenshinDB.skills sk ON ch._ultimate_skill = sk._name;
