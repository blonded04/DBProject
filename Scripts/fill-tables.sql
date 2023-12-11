SET search_path = GenshinDB;

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

-- filling characters (+ their stats, + their updates, + their skills)

-- filling units

-- filling players