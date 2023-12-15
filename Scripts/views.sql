CREATE SCHEMA GenshinViews;

SET search_path = GenshinViews;

-- elements
CREATE OR REPLACE VIEW elements_view AS
SELECT name, reactions
FROM GenshinDB.elements;

-- countries
CREATE OR REPLACE VIEW countries_view AS
SELECT name, element, archont
FROM GenshinDB.countries;

-- updates
CREATE OR REPLACE VIEW updates_view AS
SELECT id, version, type, item
FROM GenshinDB.updates;

-- stats
CREATE OR REPLACE VIEW stats_view AS
SELECT id, damage, damage_coef, hp, hp_coef, heal_coef, elemental_coefs
FROM GenshinDB.stats;

-- artifacts
CREATE OR REPLACE VIEW artifacts_view AS
SELECT name, set_name, type, update, stats, set_bonus_stats
FROM GenshinDB.artifacts;

-- weapons
CREATE OR REPLACE VIEW weapons_view AS
SELECT name, type, stats, update
FROM GenshinDB.weapons;

-- skills
CREATE OR REPLACE VIEW skills_view AS
SELECT name, type, base_damage, base_heal, cooldown
FROM GenshinDB.skills;

-- characters
CREATE OR REPLACE VIEW characters_view AS
SELECT name, weapon_type, country, base_stats, update, element, elemental_skill, ultimate_skill
FROM GenshinDB.characters;

-- units
CREATE OR REPLACE VIEW units_view AS
SELECT id, total_hp, additional_damage, boost_damage, boost_elemental, boost_heal
FROM GenshinDB.units;

-- players
CREATE OR REPLACE VIEW players_view AS
SELECT id, unit_1, unit_2, unit_3, unit_4, elemental_bonus
FROM GenshinDB.players;
