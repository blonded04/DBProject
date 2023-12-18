SET search_path = GenshinDB;

DROP TRIGGER IF EXISTS update_unit ON units;
DROP TRIGGER IF EXISTS update_player ON players;

-- task 9-10: procedure of character's characteristics initialisation + it's trigger on unit changes
-- update_unit trigger+procedures
CREATE OR REPLACE FUNCTION check_artifact_set(unit_id INT) RETURNS BOOLEAN AS $$ 
BEGIN
    RETURN ((SELECT count(1) 
        FROM (SELECT count(1) cnt
            FROM units
            INNER JOIN artifacts ON artifacts."_name" IN (units._flower_artifact, units._clock_artifact, units._hat_artifact)
            WHERE units._id = unit_id
            GROUP BY artifacts."_set_name"
        ) selected) = 1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_unit_stats(unit_id INT) RETURNS INT[] AS $$ 
DECLARE
unit_stats_ids INT[] := '{}';
unit_character TEXT;
unit_weapon TEXT;
unit_flower TEXT;
unit_clock TEXT;
unit_hat TEXT;
BEGIN
    -- 1) get unit character, weapon and artifacts
    SELECT _character, _weapon, _flower_artifact, _clock_artifact, _hat_artifact 
    INTO unit_character, unit_weapon, unit_flower, unit_clock, unit_hat
    FROM units WHERE _id = unit_id;
    -- 2) add character stats
    SELECT unit_stats_ids || _base_stats 
    INTO unit_stats_ids 
    FROM "characters" 
    WHERE _name = unit_character;
    -- 3) add weapon stats
    SELECT unit_stats_ids || _stats INTO unit_stats_ids FROM weapons WHERE _name = unit_weapon;
    -- 4) add artifacts stats
    SELECT unit_stats_ids || _stats INTO unit_stats_ids FROM artifacts WHERE _name = unit_flower OR _name = unit_clock OR _name = unit_hat;
    IF check_artifact_set(unit_id) THEN
        SELECT unit_stats_ids || _set_bonus_stats INTO unit_stats_ids FROM artifacts WHERE _name = unit_flower;
    END IF;
    RETURN unit_stats_ids;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_hp(unit_stats_ids INT[]) RETURNS INT AS $$ 
DECLARE
sum_hp INT;
sum_hp_coef FLOAT;
BEGIN
    SELECT sum(_hp), sum(_hp_coef)
    INTO sum_hp, sum_hp_coef
    FROM stats
    WHERE _id = ANY(unit_stats_ids);
    RETURN sum_hp * (1 + sum_hp_coef);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_heal_coef(unit_stats_ids INT[]) RETURNS FLOAT AS $$ 
BEGIN
    RETURN (SELECT sum(_heal_coef)
    FROM stats
    WHERE _id = ANY(unit_stats_ids));
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_skill_damage(skill_type t_skill, unit_stats_ids INT[], unit_id INT) RETURNS INT AS $$ 
DECLARE
skill_damage_coef FLOAT := 1;
elemental_skill TEXT;
ultimate_skill TEXT;
sum_damage INT;
sum_damage_coef FLOAT;
element_damage_coef FLOAT;
element_type INT;
weapon_type t_weapon;
BEGIN
    SELECT e._id, c._weapon_type, c._elemental_skill, c._ultimate_skill
    INTO element_type, weapon_type, elemental_skill, ultimate_skill
    FROM units u 
    INNER JOIN "characters" c ON u._character = c._name 
    INNER JOIN elements e ON c._element = e._name 
    WHERE u._id = unit_id;
    IF (skill_type = 'Weapon attack' AND weapon_type != 'Catalyst') THEN
        element_type := (SELECT _id FROM elements WHERE _name = 'Physical');
    ELSIF (skill_type = 'Elemental') THEN 
        skill_damage_coef := (SELECT _base_damage FROM skills WHERE _name = elemental_skill);
    ELSIF (skill_type = 'Ultimate') THEN
        skill_damage_coef := (SELECT _base_damage FROM skills WHERE _name = ultimate_skill);
    END IF;

    SELECT sum(_damage), sum(_damage_coef), sum(_elemental_coefs[element_type])
    INTO sum_damage, sum_damage_coef, element_damage_coef
    FROM stats
    WHERE _id = ANY(unit_stats_ids);
    RETURN sum_damage * (1 + sum_damage_coef) * (1 + element_damage_coef) * skill_damage_coef;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_skill_heal(skill_type t_skill, unit_id INT) RETURNS FLOAT AS $$ 
DECLARE
elemental_skill TEXT;
ultimate_skill TEXT;
BEGIN
    SELECT c._elemental_skill, c._ultimate_skill
    INTO elemental_skill, ultimate_skill
    FROM units u 
    INNER JOIN "characters" c ON u._character = c._name
    WHERE u._id = unit_id;

    IF (skill_type = 'Elemental') THEN 
        RETURN (SELECT _base_heal FROM skills WHERE _name = elemental_skill);
    ELSIF (skill_type = 'Ultimate') THEN
        RETURN (SELECT _base_heal FROM skills WHERE _name = ultimate_skill);
    END IF;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE update_unit_statistics(unit_id INT) AS $$
DECLARE 
is_set_equipped BOOLEAN;
unit_stats_ids INT[];
total_hp INT;
total_heal_coef FLOAT;
BEGIN
    is_set_equipped := check_artifact_set(unit_id);
    unit_stats_ids := get_unit_stats(unit_id);
    total_hp := get_hp(unit_stats_ids);
    total_heal_coef := get_heal_coef(unit_stats_ids) + 1;
    UPDATE units 
    SET _is_set_equipped = is_set_equipped, 
        _total_hp = total_hp,
        _weapon_attack_damage = get_skill_damage('Weapon attack', unit_stats_ids, unit_id),
        _elemental_skill_damage = get_skill_damage('Elemental', unit_stats_ids, unit_id),
        _ultimate_skill_damage = get_skill_damage('Ultimate', unit_stats_ids, unit_id),
        _elemental_skill_heal = total_hp * get_skill_heal('Elemental', unit_id) * total_heal_coef,
        _ultimate_skill_heal = total_hp * get_skill_heal('Ultimate', unit_id) * total_heal_coef
    WHERE _id = unit_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION call_unit_update() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT' OR (OLD.* IS DISTINCT FROM NEW.*)) THEN
       CALL update_unit_statistics(NEW._id);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_unit
AFTER INSERT OR UPDATE ON units
FOR EACH ROW
EXECUTE FUNCTION call_unit_update();

-- update_player trigger+procedures
CREATE OR REPLACE PROCEDURAL update_player_statistics(player_id INT) AS $$
DECLARE 
column_name TEXT;
column_name1 TEXT;
column_name2 TEXT;
new_elemental_value FLOAT;
new_elemental_value1 FLOAT;
new_elemental_value2 FLOAT;
elemental_index INT;
diff_elemental_value1 FLOAT;
diff_elemental_value2 FLOAT;
elemental_index1 INT;
elemental_index2 INT;
element1 t_element;
element2 t_element;
elemental_bonus FLOAT[8] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}'::FLOAT[];
BEGIN
    FOR unit_index IN 1..4 LOOP
        column_name := '_unit_' || unit_index;
        
        EXECUTE 'SELECT e._id FROM elements e LEFT JOIN characters c ON c._element = e._name RIGHT JOIN units u ON u._character = c._name RIGHT JOIN players p ON p._id = player_id AND u._id = p.' || column_name
        INTO elemental_index;
        
        SELECT elemental_bonus[elemental_index] + 1 
        INTO new_elemental_value;
    
        elemental_bonus[elemental_index] := new_elemental_value;
    END LOOP;

    FOR unit_index1 IN 1..3 LOOP
        column_name1 := '_unit_' || unit_index1;
        FOR unit_index2 IN i+1..4 LOOP
            column_name2 := '_unit_' || unit_index2;
        
            EXECUTE 'SELECT e._element, e._id FROM elements e LEFT JOIN characters c ON c._element = e._name RIGHT JOIN units u ON u._character = c._name RIGHT JOIN players p ON p._id = player_id AND u._id = p.' || column_name1
            INTO element1, elemental_index1;
        
            EXECUTE 'SELECT e._element, e._id FROM elements e LEFT JOIN characters c ON c._element = e._name RIGHT JOIN units u ON u._character = c._name RIGHT JOIN players p ON p._id = player_id AND u._id = p.' || column_name2
            INTO element1, elemental_index1;
        
            SELECT _bonus FROM reactions r WHERE r._first = element1 AND r._second = element2 
            INTO diff_elemental_value_1;
            
            SELECT elemental_bonus[elemental_index1] + diff_elemental_value1 INTO new_elemental_value1;
            SELECT elemental_bonus[elemental_index2] + diff_elemental_value1 INTO new_elemental_value2;
            elemental_bonus[elemental_index1] := new_elemental_value1;
            elemental_bonus[elemental_index2] := new_elemental_value2;
        
            SELECT _bonus FROM reactions r WHERE r._first = element2 AND r._second = element1
            INTO diff_elemental_value_2;
            
            SELECT elemental_bonus[elemental_index1] + diff_elemental_value2 INTO new_elemental_value1;
            SELECT elemental_bonus[elemental_index2] + diff_elemental_value2 INTO new_elemental_value2;
            elemental_bonus[elemental_index1] := new_elemental_value1;
            elemental_bonus[elemental_index2] := new_elemental_value2;
        END LOOP;
    END LOOP;
    
    UPDATE players
    SET _elemental_bonus = elemental_bonus
    WHERE _id = player_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION call_player_update() RETURN TRIGGER AS $$
BEGIN 
    IF (TG_OP = 'INSERT' OR (OLD.* IS DISTINCT FROM NEW.*)) THEN
        CALL update_player_statistics(NEW._id);
    END IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;


CREATE TRIGGER update_player
AFTER INSERT OR UPDATE ON players
FOR EACH ROW 
EXECUTE FUNCTION call_player_update();
