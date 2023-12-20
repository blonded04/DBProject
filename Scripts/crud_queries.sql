SET search_path = GenshinDB;

-- task 5: just CRUD queries
-- table: weapons
-- Create
WITH weapon_stats AS (INSERT INTO stats(_damage, _hp, _elemental_coefs) VALUES (1000, -100, '{0, 0, 0, 0, 0, 0, 0.5, 0}') RETURNING _id),
     item_update AS (INSERT INTO updates(_version, _type, _item) VALUES (4.0, 'Weapon', 'Lamesaber') RETURNING _id)
INSERT INTO weapons(_name, _type, _stats, _update)
SELECT 'Lamesaber', 'One handed', (SELECT _id FROM weapon_stats), (SELECT _id FROM item_update)
FROM weapon_stats, item_update;
-- Read
SELECT _name, _type, _stats
FROM weapons
WHERE _stats % 2 = 1
ORDER BY _stats DESC;
SELECT * FROM weapons WHERE _name = 'Lamesaber';
-- Update
UPDATE weapons SET _name = 'Lightsaber' WHERE _name = 'Lamesaber';
-- Delete
DELETE FROM weapons WHERE _name = 'Lightsaber';
-- table: countries
-- Create
INSERT INTO countries(_name, _element, _archont) VALUES ('Amogus ship', 'Electro', 'Aboba');
-- Read
SELECT _element, count(1) cnt 
FROM countries
GROUP BY _element
HAVING _element = ANY('{Dendro, Electro, Geo}'::t_element[]) 
ORDER BY _element ASC;
-- Update
UPDATE countries SET _archont = 'Bebra', _element = 'Physical' WHERE _name = 'Amogus ship';
-- Delete
DELETE FROM countries WHERE _archont = 'Bebra';
--
-- task 6: motivated queries

-- 1: Найти 3-его юнита по электро урону (берётся сумма всех электро навыков)
SELECT DISTINCT res._unit_id, res._damage
FROM (SELECT u._id AS _unit_id, (st._damage + sum (sk._base_damage) OVER (PARTITION BY u._id)) AS _damage
       FROM units AS u
       INNER JOIN characters ON characters._name = u._character AND characters._element = 'Electro'
       INNER JOIN skills AS sk ON characters._elemental_skill = sk._name OR characters._ultimate_skill = sk._name
       INNER JOIN weapons ON u._weapon = weapons._name
       INNER JOIN stats AS st ON weapons._stats = st._id) res
ORDER BY _damage desc
LIMIT 1 OFFSET 2;

-- 2: Максимальное значение хила от элементального навыка у юнитов из Инадзумы
SELECT max (skills._base_heal)
FROM skills
INNER JOIN characters ON characters._elemental_skill = skills._name
WHERE skills._type = 'Elemental' and characters._country = 'Inazuma';

-- 3: Для каждой страны вычислить количество персонажей и юнитов
SELECT countries._name country, COALESCE(counter.char_cnt, 0) characters_cnt, COALESCE(counter.unit_cnt, 0) units_cnt
FROM countries
LEFT JOIN 
    (SELECT count(u._character) unit_cnt, count(DISTINCT c._name) char_cnt, _country 
    FROM "characters" c 
    LEFT JOIN units u ON u._character = c._name 
    GROUP BY _country) counter ON countries._name = counter._country;

-- 4: Для каждого персонажа вывести массив индексов его юнитов
SELECT characters._name, string_agg (cast (units._id AS TEXT), ', ') 
FROM characters 
LEFT JOIN units ON units._character = characters._name
GROUP BY characters._name
ORDER BY characters._name;


-- 5: Найти игрока, у которого лучший бонус для гидро урона за элементальные реакции
SELECT * 
FROM players 
WHERE _elemental_bonus[(SELECT _id FROM elements WHERE _name = 'Hydro')] = 
(SELECT max(_elemental_bonus[(SELECT _id FROM elements WHERE _name = 'Hydro')])
FROM players)
LIMIT 1;

-- 6: Найти юнитов, которые состоят из предметов, добавленных в течении одной мажорной версии игры (например, версии всех предметов вида 1.Х)
SELECT u.* 
FROM units u
INNER JOIN (SELECT _name, _version FROM "characters" INNER JOIN updates ON _update = _id) ch ON u._character = ch._name
INNER JOIN (SELECT _name, _version FROM weapons INNER JOIN updates ON _update = _id) w ON u._weapon = w._name
INNER JOIN (SELECT _name, _version FROM artifacts INNER JOIN updates ON _update = _id) f ON u._flower_artifact = f._name
INNER JOIN (SELECT _name, _version FROM artifacts INNER JOIN updates ON _update = _id) c ON u._clock_artifact = c._name
INNER JOIN (SELECT _name, _version FROM artifacts INNER JOIN updates ON _update = _id) h ON u._hat_artifact = h._name
WHERE CAST(ch._version AS INT) = CAST(w._version AS INT) AND
    CAST(ch._version AS INT) = CAST(f._version AS INT) AND 
    CAST(ch._version AS INT) = CAST(c._version AS INT) AND 
    CAST(ch._version AS INT) = CAST(h._version AS INT);
