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
WITH set_stats AS (INSERT INTO stats(heal_coef, hp_coef) VALUES (0.25, 0.15) RETURNING id),
     stats AS (INSERT INTO stats(hp, hp_coef) VALUES (400, 0.1) RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Maidens Distant Love') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Maidens Distant Love', 'Maiden Beloved', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Maiden Beloved' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp) VALUES (100, 150) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Maidens Passing Youth') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Maidens Passing Youth', 'Maiden Beloved', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Maiden Beloved' LIMIT 1),
     stats AS (INSERT INTO stats(hp, heal_coef) VALUES (250, 0.1) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Maidens Fading Beauty') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Maidens Fading Beauty', 'Maiden Beloved', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- physical set
WITH set_stats AS (INSERT INTO stats(damage, damage_coef, elemental_coefs) VALUES (120, 0.1, '{0.35, 0, 0, 0, 0, 0, 0, 0}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0.1, 0, 0, 0, 0, 0, 0, 0}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.5, 'Artifact', 'Stainless Bloom') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Stainless Bloom', 'Pale Flame', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Pale Flame' LIMIT 1),
     stats AS (INSERT INTO stats(damage, damage_coef, hp_coef) VALUES (100, 0.1, 0.15) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.5, 'Artifact', 'Moment of Cessation') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Moment of Cessation', 'Pale Flame', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Pale Flame' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp) VALUES (110, 75) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.5, 'Artifact', 'Mocking Mask') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Mocking Mask', 'Pale Flame', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- anemo set
WITH set_stats AS (INSERT INTO stats(damage_coef, hp_coef, elemental_coefs) VALUES (0.17, 0.1, '{0, 0.35, 0, 0, 0, 0, 0, 0}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0, 0.1, 0, 0, 0, 0, 0, 0}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'In Remembrance of Viridescent Fields') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'In Remembrance of Viridescent Fields', 'Viridescent Venerer', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Viridescent Venerer' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp) VALUES (100, 75) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Viridescent Venerers Determination') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Viridescent Venerers Determination', 'Viridescent Venerer', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Viridescent Venerer' LIMIT 1),
     stats AS (INSERT INTO stats(damage, damage_coef) VALUES (100, 0.12) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Viridescent Venerers Diadem') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Viridescent Venerers Diadem', 'Viridescent Venerer', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- geo set
WITH set_stats AS (INSERT INTO stats(damage_coef, hp_coef, elemental_coefs) VALUES (0.17, 0.1, '{0, 0, 0.35, 0, 0, 0, 0, 0}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0, 0, 0.1, 0, 0, 0, 0, 0}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Flower of Creviced Cliff') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Flower of Creviced Cliff', 'Archaic Petra', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Archaic Petra' LIMIT 1),
     stats AS (INSERT INTO stats(damage, damage_coef, hp) VALUES (100, 0.17, 60) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Sundial of Enduring Jade') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Sundial of Enduring Jade', 'Archaic Petra', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Archaic Petra' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp_coef) VALUES (100, 0.12) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Mask of Solitude Basalt') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Mask of Solitude Basalt', 'Archaic Petra', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- electro set
WITH set_stats AS (INSERT INTO stats(damage_coef, elemental_coefs) VALUES (0.15, '{0, 0, 0, 0.35, 0, 0, 0, 0}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0, 0, 0, 0.1, 0, 0, 0, 0}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Thunderbirds Mercy') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Thunderbirds Mercy', 'Thundering Fury', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Thundering Fury' LIMIT 1),
     stats AS (INSERT INTO stats(damage, damage_coef, hp) VALUES (100, 0.17, 60) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Hourglass of Thunder') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Hourglass of Thunder', 'Thundering Fury', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Thundering Fury' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp_coef) VALUES (100, 0.12) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Thunder Summoners Crown') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Thunder Summoners Crown', 'Thundering Fury', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- dendro set
WITH set_stats AS (INSERT INTO stats(damage, elemental_coefs) VALUES (150, '{0, 0, 0, 0, 0.35, 0, 0, 0}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0.1, 0, 0, 0}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (3.0, 'Artifact', 'Labyrinth Wayfarer') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Labyrinth Wayfarer', 'Deepwood Memories', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Deepwood Memories' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp, hp_coef) VALUES (100, 65, 0.16) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (3.0, 'Artifact', 'A Time of Insight') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'A Time of Insight', 'Deepwood Memories', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Deepwood Memories' LIMIT 1),
     stats AS (INSERT INTO stats(damage_coef, hp_coef) VALUES (0.15, 0.15) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (3.0, 'Artifact', 'Laurel Coronet') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Laurel Coronet', 'Deepwood Memories', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- hydro set
WITH set_stats AS (INSERT INTO stats(hp_coef, elemental_coefs) VALUES (0.2, '{0, 0, 0, 0, 0, 0.35, 0, 0}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0, 0.1, 0, 0}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.2, 'Artifact', 'Gilded Corsage') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Gilded Corsage', 'Heart of Depth', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Heart of Depth' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp) VALUES (100, 100) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.2, 'Artifact', 'Copper Compass') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Copper Compass', 'Heart of Depth', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Heart of Depth' LIMIT 1),
     stats AS (INSERT INTO stats(hp, hp_coef) VALUES (200, 0.1) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.2, 'Artifact', 'Wine-Stained Tricorne') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Wine-Stained Tricorne', 'Heart of Depth', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- pyro set
WITH set_stats AS (INSERT INTO stats(damage_coef, elemental_coefs) VALUES (0.2, '{0, 0, 0, 0, 0, 0, 0.35, 0}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0, 0, 0, 0.1}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Witchs Flower of Blaze') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Witchs Flower of Blaze', 'Crimson Witch of Flames', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Crimson Witch of Flames' LIMIT 1),
     stats AS (INSERT INTO stats(damage, damage_coef, hp) VALUES (100, 0.12, 25) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Witchs End Time') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Witchs End Time', 'Crimson Witch of Flames', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Crimson Witch of Flames' LIMIT 1),
     stats AS (INSERT INTO stats(hp, damage_coef, hp_coef) VALUES (100, 0.1, 0.15) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.0, 'Artifact', 'Witchs Scorching Hat') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Witchs Scorching Hat', 'Crimson Witch of Flames', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- cryo set
WITH set_stats AS (INSERT INTO stats(heal_coef, elemental_coefs) VALUES (0.12, '{0, 0, 0, 0, 0, 0, 0, 0.35}') RETURNING id),
     stats AS (INSERT INTO stats(hp, elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0, 0, 0, 0.1}') RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (1.2, 'Artifact', 'Snowswept Memory') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Snowswept Memory', 'Blizzard Strayer', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Blizzard Strayer' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp) VALUES (130, 70) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.2, 'Artifact', 'Frozen Homelands Demise') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Frozen Homelands Demise', 'Blizzard Strayer', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Blizzard Strayer' LIMIT 1),
     stats AS (INSERT INTO stats(damage_coef, hp_coef) VALUES (0.18, 0.13) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (1.2, 'Artifact', 'Broken Rimes Echo') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Broken Rimes Echo', 'Blizzard Strayer', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

-- off set
WITH set_stats AS (INSERT INTO stats(damage, damage_coef, hp, hp_coef, heal_coef, elemental_coefs) VALUES (150, 0.12, 150, 0.12, 0.3, '{0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1}') RETURNING id),
     stats AS (INSERT INTO stats(hp, damage_coef) VALUES (400, 0.2) RETURNING id),
     item_update AS (INSERT INTO updates(version, type, item) VALUES (2.0, 'Artifact', 'Wind Rose of Stone Heart') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Wind Rose of Stone Heart', 'Nearsoccer Outfit', 'Flower', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Nearsoccer Outfit' LIMIT 1),
     stats AS (INSERT INTO stats(damage, hp) VALUES (130, 70) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (2.0, 'Artifact', 'Bust Down') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Bust Down', 'Nearsoccer Outfit', 'Clock', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;

WITH set_stats AS (SELECT set_bonus_stats id FROM artifacts WHERE set_name = 'Nearsoccer Outfit' LIMIT 1),
     stats AS (INSERT INTO stats(damage_coef, hp_coef) VALUES (0.18, 0.13) RETURNING id),
	 item_update AS (INSERT INTO updates(version, type, item) VALUES (2.0, 'Artifact', 'Goggle Hat of Fury') RETURNING id)
INSERT INTO artifacts(name, set_name, type, update, stats, set_bonus_stats)
SELECT 'Goggle Hat of Fury', 'Nearsoccer Outfit', 'Hat', (SELECT id FROM item_update), (SELECT id FROM stats), (SELECT id FROM set_stats)
FROM item_update, stats, set_stats;


-- filling characters (+ their stats, + their updates, + their skills)

-- filling units

-- filling players