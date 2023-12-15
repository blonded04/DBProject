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
INSERT INTO elements(_name, _reactions) VALUES ('Physical', '{false, false, false, false, false, false, false, false}');
INSERT INTO elements(_name, _reactions) VALUES ('Anemo',    '{false, false, false, true, false, true, true, true}');
INSERT INTO elements(_name, _reactions) VALUES ('Geo',      '{false, false, false, true, false, true, true, true}');
INSERT INTO elements(_name, _reactions) VALUES ('Electro',  '{false, true, true, false, true, true, true, true}');
INSERT INTO elements(_name, _reactions) VALUES ('Dendro',   '{false, false, false, true, false, true, true, false}');
INSERT INTO elements(_name, _reactions) VALUES ('Hydro',    '{false, true, true, true, true, false, true, true}');
INSERT INTO elements(_name, _reactions) VALUES ('Pyro',     '{false, true, true, true, true, true, false, true}');
INSERT INTO elements(_name, _reactions) VALUES ('Cryo',     '{false, true, true, true, false, true, true, false}');

-- filling countries
INSERT INTO countries(_name, _element, _archont) VALUES ('Mondstadt', 'Anemo', 'Venti');
INSERT INTO countries(_name, _element, _archont) VALUES ('Liyue', 'Geo', 'Zhongli');
INSERT INTO countries(_name, _element, _archont) VALUES ('Inazuma', 'Electro', 'Raiden');
INSERT INTO countries(_name, _element, _archont) VALUES ('Sumeru', 'Dendro', 'Nahida');
INSERT INTO countries(_name, _element, _archont) VALUES ('Fontaine', 'Hydro', 'Furina');
INSERT INTO countries(_name, _element, _archont) VALUES ('Natlan', 'Pyro', 'Murata');
INSERT INTO countries(_name, _element, _archont) VALUES ('Snezhnaya', 'Cryo', 'Tsaritsa');

-- filling weapons (+ their _stats, + their updates)
--catalysts
WITH weapon_stats AS (INSERT INTO stats(_damage, _elemental_coefs) VALUES (542, '{0, 0.26, 0.26, 0.26, 0.26, 0.26, 0.26, 0.26}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.2, 'Weapon', 'A Thousand Floating Dreams') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'A Thousand Floating Dreams', 'Catalyst', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef) VALUES (674, 0.221) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (4.1, 'Weapon', 'Cashflow Supervision') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Cashflow Supervision', 'Catalyst', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _hp_coef, _heal_coef) VALUES (608, 0.496, 0.2) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.1, 'Weapon', 'Everlasting Moonglow') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Everlasting Moonglow', 'Catalyst', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _hp_coef, _damage_coef) VALUES (608, 0.496, 0.12) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.6, 'Weapon', 'Jadefalls Splendor') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Jadefalls Splendor', 'Catalyst', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

--bows
WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef) VALUES (608, 0.496) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Weapon', 'Amos Bow') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Amos Bow', 'Bow', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _hp_coef) VALUES (542, 0.441, 0.32) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.7, 'Weapon', 'Aqua Simulacra') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Aqua Simulacra', 'Bow', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _hp_coef) VALUES (608, 0.551) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.4, 'Weapon', 'Elegy for the End') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Elegy for the End', 'Bow', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (542, 0.441, '{0, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.0, 'Weapon', 'Hunters Path') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Hunters Path', 'Bow', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (608, 0.331, '{0, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.2, 'Weapon', 'Polar Star') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Polar Star', 'Bow', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

--spear
WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (741, 0.165, '{0, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.4, 'Weapon', 'Calamity Queller') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Calamity Queller', 'Spear', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _hp_coef, _damage_coef) VALUES (608, 0.22, 0.56) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.1, 'Weapon', 'Engulfing Lightning') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Engulfing Lightning', 'Spear', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (674, 0.221, '{0, 0, 0, 0, 0, 0.4, 0.4, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Weapon', 'Primordial Jade Winged-Spear') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Primordial Jade Winged-Spear', 'Spear', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _hp_coef) VALUES (674, 0.368) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Weapon', 'Skyward Spine') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Skyward Spine', 'Spear', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _hp_coef) VALUES (608, 0.331, 0.3) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.3, 'Weapon', 'Staff of Homa') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Staff of Homa', 'Spear', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

--one handed
WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (674, 0.4, '{0.413, 0, 0, 0, 0, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Weapon', 'Aquila Favonia') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Aquila Favonia', 'One handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _hp, _damage_coef) VALUES (608, 198, 0.2) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.6, 'Weapon', 'Freedom-Sworn') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Freedom-Sworn', 'One handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (608, 0.331, '{0, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24, 0.24}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.6, 'Weapon', 'Haran Geppaku Futsu') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Haran Geppaku Futsu', 'One handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _hp_coef) VALUES (542, 0.662) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.1, 'Weapon', 'Key of Khaj-Nisut') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Key of Khaj-Nisut', 'One handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef) VALUES (542, 0.441) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.4, 'Weapon', 'Light of Foliar Incision') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Light of Foliar Incision', 'One handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

-- two handed
WITH weapon_stats AS (INSERT INTO stats(_damage, _hp_coef) VALUES (608, 0.331) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.5, 'Weapon', 'Beacon of the Reed Sea') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Beacon of the Reed Sea', 'Two handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef) VALUES (542, 0.441) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.3, 'Weapon', 'Redhorn Stonethresher') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Redhorn Stonethresher', 'Two handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (608, 0.496, '{0.4, 0, 0, 0, 0, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Weapon', 'Wolfs Gravestone') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Wolfs Gravestone', 'Two handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (741, 0.32, '{0.207, 0, 0, 0, 0, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.5, 'Weapon', 'Song of Broken Pines') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Song of Broken Pines', 'Two handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

WITH weapon_stats AS (INSERT INTO stats(_damage, _elemental_coefs) VALUES (675, '{0, 0, 0, 0.36, 0, 0.36, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.1, 'Weapon', 'Rainslasher') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Rainslasher', 'Two handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;

-- filling artifacts (+ their _stats, + their updates)
-- healing set
WITH set_stats AS (INSERT INTO stats(_heal_coef, _hp_coef) VALUES (0.25, 0.15) RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _hp_coef) VALUES (400, 0.1) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Maidens Distant Love') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Maidens Distant Love', 'Maiden Beloved', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Maiden Beloved' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp) VALUES (100, 150) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Maidens Passing Youth') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Maidens Passing Youth', 'Maiden Beloved', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Maiden Beloved' LIMIT 1),
     item_stats AS (INSERT INTO stats(_hp, _heal_coef) VALUES (250, 0.1) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Maidens Fading Beauty') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Maidens Fading Beauty', 'Maiden Beloved', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- physical set
WITH set_stats AS (INSERT INTO stats(_damage, _damage_coef, _elemental_coefs) VALUES (120, 0.1, '{0.35, 0, 0, 0, 0, 0, 0, 0}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0.1, 0, 0, 0, 0, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.5, 'Artifact', 'Stainless Bloom') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Stainless Bloom', 'Pale Flame', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Pale Flame' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _damage_coef, _hp_coef) VALUES (100, 0.1, 0.15) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.5, 'Artifact', 'Moment of Cessation') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Moment of Cessation', 'Pale Flame', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Pale Flame' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp) VALUES (110, 75) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.5, 'Artifact', 'Mocking Mask') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Mocking Mask', 'Pale Flame', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- anemo set
WITH set_stats AS (INSERT INTO stats(_damage_coef, _hp_coef, _elemental_coefs) VALUES (0.17, 0.1, '{0, 0.35, 0, 0, 0, 0, 0, 0}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0, 0.1, 0, 0, 0, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'In Remembrance of Viridescent Fields') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'In Remembrance of Viridescent Fields', 'Viridescent Venerer', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Viridescent Venerer' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp) VALUES (100, 75) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Viridescent Venerers Determination') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Viridescent Venerers Determination', 'Viridescent Venerer', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Viridescent Venerer' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _damage_coef) VALUES (100, 0.12) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Viridescent Venerers Diadem') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Viridescent Venerers Diadem', 'Viridescent Venerer', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- geo set
WITH set_stats AS (INSERT INTO stats(_damage_coef, _hp_coef, _elemental_coefs) VALUES (0.17, 0.1, '{0, 0, 0.35, 0, 0, 0, 0, 0}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0, 0, 0.1, 0, 0, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Flower of Creviced Cliff') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Flower of Creviced Cliff', 'Archaic Petra', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Archaic Petra' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _damage_coef, _hp) VALUES (100, 0.17, 60) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Sundial of Enduring Jade') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Sundial of Enduring Jade', 'Archaic Petra', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Archaic Petra' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp_coef) VALUES (100, 0.12) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Mask of Solitude Basalt') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Mask of Solitude Basalt', 'Archaic Petra', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- electro set
WITH set_stats AS (INSERT INTO stats(_damage_coef, _elemental_coefs) VALUES (0.15, '{0, 0, 0, 0.35, 0, 0, 0, 0}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0, 0, 0, 0.1, 0, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Thunderbirds Mercy') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Thunderbirds Mercy', 'Thundering Fury', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Thundering Fury' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _damage_coef, _hp) VALUES (100, 0.17, 60) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Hourglass of Thunder') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Hourglass of Thunder', 'Thundering Fury', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Thundering Fury' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp_coef) VALUES (100, 0.12) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Thunder Summoners Crown') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Thunder Summoners Crown', 'Thundering Fury', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- dendro set
WITH set_stats AS (INSERT INTO stats(_damage, _elemental_coefs) VALUES (150, '{0, 0, 0, 0, 0.35, 0, 0, 0}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0.1, 0, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.0, 'Artifact', 'Labyrinth Wayfarer') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Labyrinth Wayfarer', 'Deepwood Memories', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Deepwood Memories' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp, _hp_coef) VALUES (100, 65, 0.16) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.0, 'Artifact', 'A Time of Insight') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'A Time of Insight', 'Deepwood Memories', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Deepwood Memories' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage_coef, _hp_coef) VALUES (0.15, 0.15) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.0, 'Artifact', 'Laurel Coronet') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Laurel Coronet', 'Deepwood Memories', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- hydro set
WITH set_stats AS (INSERT INTO stats(_hp_coef, _elemental_coefs) VALUES (0.2, '{0, 0, 0, 0, 0, 0.35, 0, 0}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0, 0.1, 0, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.2, 'Artifact', 'Gilded Corsage') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Gilded Corsage', 'Heart of Depth', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Heart of Depth' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp) VALUES (100, 100) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.2, 'Artifact', 'Copper Compass') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Copper Compass', 'Heart of Depth', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Heart of Depth' LIMIT 1),
     item_stats AS (INSERT INTO stats(_hp, _hp_coef) VALUES (200, 0.1) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.2, 'Artifact', 'Wine-Stained Tricorne') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Wine-Stained Tricorne', 'Heart of Depth', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- pyro set
WITH set_stats AS (INSERT INTO stats(_damage_coef, _elemental_coefs) VALUES (0.2, '{0, 0, 0, 0, 0, 0, 0.35, 0}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0, 0, 0, 0.1}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Witchs Flower of Blaze') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Witchs Flower of Blaze', 'Crimson Witch of Flames', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Crimson Witch of Flames' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _damage_coef, _hp) VALUES (100, 0.12, 25) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Witchs End Time') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Witchs End Time', 'Crimson Witch of Flames', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Crimson Witch of Flames' LIMIT 1),
     item_stats AS (INSERT INTO stats(_hp, _damage_coef, _hp_coef) VALUES (100, 0.1, 0.15) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Artifact', 'Witchs Scorching Hat') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Witchs Scorching Hat', 'Crimson Witch of Flames', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- cryo set
WITH set_stats AS (INSERT INTO stats(_heal_coef, _elemental_coefs) VALUES (0.12, '{0, 0, 0, 0, 0, 0, 0, 0.35}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _elemental_coefs) VALUES (400, '{0, 0, 0, 0, 0, 0, 0, 0.1}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.2, 'Artifact', 'Snowswept Memory') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Snowswept Memory', 'Blizzard Strayer', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Blizzard Strayer' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp) VALUES (130, 70) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.2, 'Artifact', 'Frozen Homelands Demise') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Frozen Homelands Demise', 'Blizzard Strayer', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Blizzard Strayer' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage_coef, _hp_coef) VALUES (0.18, 0.13) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.2, 'Artifact', 'Broken Rimes Echo') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Broken Rimes Echo', 'Blizzard Strayer', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

-- off set
WITH set_stats AS (INSERT INTO stats(_damage, _damage_coef, _hp, _hp_coef, _heal_coef, _elemental_coefs) VALUES (150, 0.12, 150, 0.12, 0.3, '{0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1}') RETURNING _id),
     item_stats AS (INSERT INTO stats(_hp, _damage_coef) VALUES (400, 0.2) RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.0, 'Artifact', 'Wind Rose of Stone Heart') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Wind Rose of Stone Heart', 'Nearsoccer Outfit', 'Flower', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Nearsoccer Outfit' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage, _hp) VALUES (130, 70) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.0, 'Artifact', 'Bust Down') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Bust Down', 'Nearsoccer Outfit', 'Clock', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;

WITH set_stats AS (SELECT _set_bonus_stats _id FROM artifacts WHERE _set_name = 'Nearsoccer Outfit' LIMIT 1),
     item_stats AS (INSERT INTO stats(_damage_coef, _hp_coef) VALUES (0.18, 0.13) RETURNING _id),
	 item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.0, 'Artifact', 'Goggle Hat of Fury') RETURNING _id)
INSERT INTO artifacts(_name, _set_name, _type, _update, _stats, _set_bonus_stats)
SELECT 'Goggle Hat of Fury', 'Nearsoccer Outfit', 'Hat', (SELECT _id FROM item_update), (SELECT _id FROM item_stats), (SELECT _id FROM set_stats)
FROM item_update, item_stats, set_stats;


-- filling characters (+ their stats, + their updates, + their skills)
WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (26, 807) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.5, 'Character', 'When the Sakura Bloom') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Yakan Evocation: Sesshou Sakura', 'Elemental', 128.93, 0.0, 4.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Great Secret Art: Tenko Kenshin', 'Ultimate', 552.5, 0.0, 22.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Yae Miko', 'Catalyst', 'Inazuma', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Electro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (26, 1004) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.1, 'Character', 'Floating World Under the Moonlight') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Transcendence: Baleful Omen', 'Elemental', 263.7, 0.0, 10.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Secret Art: Musou Shinsetsu', 'Ultimate', 902, 0.0, 18.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Raiden Shogun', 'Spear', 'Inazuma', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Electro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (14, 1039) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.6, 'Character', 'A Parade of Providence') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Universal Diagnosis', 'Elemental', 168.3, 2118.72, 10.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Holistic Revivification', 'Ultimate', 206.26, 1588.87, 20.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Baizhu', 'Catalyst', 'Liyue', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Dendro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (17, 1030) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.4, 'Character', 'The Exquisite Night Chimes') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Raphanus Sky Cluster', 'Elemental', 63.58, 454.002, 15.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Moonjade Descent', 'Ultimate', 406.86, 534.11, 20.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Yaoyao', 'Spear', 'Liyue', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Dendro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (15, 802) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.3, 'Character', 'Shadows Amidst Snowstorms') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Inuzaka All-Round Defense', 'Elemental', 0.0, 0.0, 10.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Juuga: Forward Unto Victory', 'Ultimate', 0.0, 0.0, 20.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Gorou', 'Bow', 'Inazuma', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Geo', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (19, 1143) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.1, 'Character', 'A New Star Approaches') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Dominus Lapidis', 'Elemental', 0.0, 0.0, 12.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Planet Befall', 'Ultimate', 1138.0, 0.0, 12.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Zhongli', 'Spear', 'Liyue', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Geo', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (20, 819) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (1.0, 'Character', 'Welcome To Teyvat') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Skyward Sonnet', 'Elemental', 586.5, 0.0, 6.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Winds Grand Ode', 'Ultimate', 1480.3, 0.0, 15.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Venti', 'Bow', 'Mondstadt', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Anemo', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (18, 1048) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.1, 'Character', 'Floating World Under the Moonlight') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Kurages Oath', 'Elemental', 232.03, 1165.29, 20.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Nereids Ascension', 'Ultimate', 0.0, 211.87, 18.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Sangonomiya Kokomi', 'Catalyst', 'Inazuma', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Hydro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (18, 1124) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (2.7, 'Character', 'Hidden Dreams in the Depths') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Lingering Lifeline', 'Elemental', 50.88, 0, 10.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Depth-Clarion Dice', 'Ultimate', 0.0, 0, 18.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Yelan', 'Bow', 'Liyue', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Hydro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (17, 1182) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (3.1, 'Character', 'King Deshret and the Three Magi') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Dance of Haftkarsvar', 'Elemental', 0, 0, 18.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Dance of Abzendegi: Distant Dreams, Listening Spring', 'Ultimate', 89.17, 0, 18.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Nilou', 'One handed', 'Sumeru', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Hydro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (24, 857) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (4.0, 'Character', 'As Light Rain Falls Without Reason') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Bewildering Lights', 'Elemental', 395.96, 0, 15.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Wondrous Trick: Miracle Parade', 'Ultimate', 1207.0, 0, 15.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Lyney', 'Bow', 'Fontaine', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Pyro', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

WITH character_stats AS (INSERT INTO stats(_damage, _hp) VALUES (21, 1012) RETURNING _id),
     character_update AS (INSERT INTO updates(_version, _type, _item) VALUES (4.0, 'Character', 'As Light Rain Falls Without Reason') RETURNING _id),
     character_skill_elemental AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Pressurized Floe', 'Elemental', 616.22, 0, 10.0) RETURNING _name),
     character_skill_ultimate AS (INSERT INTO skills(_name, _type, _base_damage, _base_heal, _cooldown) VALUES ('Shadowhunters Ambush', 'Ultimate', 573.12, 0, 15.0) RETURNING _name)
INSERT INTO characters(_name, _weapon_type, _country, _base_stats, _update, _element, _elemental_skill, _ultimate_skill)
SELECT 'Freminet', 'Two handed', 'Fontaine', (SELECT _id FROM character_stats), (SELECT _id FROM character_update), 'Cryo', (SELECT _name FROM character_skill_elemental), (SELECT _name FROM character_skill_ultimate)
FROM character_skill_ultimate, character_skill_elemental, character_update, character_stats;

-- filling units

-- filling players
