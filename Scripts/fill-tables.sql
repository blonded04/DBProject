SET search_path = GenshinDB;

-- erasing all content
TRUNCATE elements CASCADE;
TRUNCATE countries CASCADE;
TRUNCATE stats CASCADE;
TRUNCATE updates CASCADE;
TRUNCATE skills CASCADE;
TRUNCATE weapons CASCADE;
TRUNCATE artifacts CASCADE;
TRUNCATE characters CASCADE;
TRUNCATE units CASCADE;
TRUNCATE players CASCADE;

-- filling elements  ('Physical', 'Anemo', 'Geo', 'Electro', 'Dendro', 'Hydro', 'Pyro', 'Cryo')
INSERT INTO elements(name, reactions) VALUES ('Physical', '{false, false, false, false, false, false, false, false}');
INSERT INTO elements(name, reactions) VALUES ('Anemo',    '{false, false, false, true, false, true, true, true}');
INSERT INTO elements(name, reactions) VALUES ('Geo',      '{false, false, false, true, false, true, true, true}');
INSERT INTO elements(name, reactions) VALUES ('Electro',  '{false, true, true, false, true, true, true, true}');
INSERT INTO elements(name, reactions) VALUES ('Dendro',   '{false, false, false, true, false, true, true, false}');
INSERT INTO elements(name, reactions) VALUES ('Hydro',    '{false, true, true, true, true, false, true, true}');
INSERT INTO elements(name, reactions) VALUES ('Pyro',     '{false, true, true, true, true, true, false, true}');
INSERT INTO elements(name, reactions) VALUES ('Cryo',     '{false, true, true, true, false, true, true, false}');

-- filling countries
INSERT INTO countries(name, element, archont) VALUES ('Mondstadt', 'Anemo', 'Venti');
INSERT INTO countries(name, element, archont) VALUES ('Liyue', 'Anemo', 'Zhongli');
INSERT INTO countries(name, element, archont) VALUES ('Inazuma', 'Anemo', 'Raiden');
INSERT INTO countries(name, element, archont) VALUES ('Sumeru', 'Anemo', 'Nahida');
INSERT INTO countries(name, element, archont) VALUES ('Fontaine', 'Anemo', 'Furina');
INSERT INTO countries(name, element, archont) VALUES ('Natlan', 'Anemo', 'Murata');
INSERT INTO countries(name, element, archont) VALUES ('Snezhnaya', 'Anemo', 'Tsaritsa');

-- filling weapons (+ their stats, + their updates)

-- filling artifacts (+ their stats, + their updates)
-- healing set
WITH set_stats AS (INSERT INTO stats(heal_coef, hp_coef) VALUES (0.25, 1.15) RETURNING id),
     stats AS (INSERT INTO stats(hp, hp_coef) VALUES (400, 1.1) RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Flower of Life') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Flower of Life', 'Maiden Beloved', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Maiden Beloved' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp) VALUES (70, 150) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Sands of Eon') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Sands of Eon', 'Maiden Beloved', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Maiden Beloved' LIMIT 1),
     stats AS (INSERT INTO stats(hp, heal_coef) VALUES (250, 0.1) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Circlet of Logos') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Circlet of Logos', 'Maiden Beloved', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- filling characters (+ their stats, + their updates, + their skills)

-- filling units

-- filling players