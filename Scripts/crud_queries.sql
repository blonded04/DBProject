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

