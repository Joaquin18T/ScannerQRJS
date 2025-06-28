USE superhero;

CREATE VIEW vs_superhero_all
AS
SELECT 
	SH.id, SH.superhero_name, SH.full_name,SH.publisher_id,
    GD.gender, 
    C1.colour 'eye_colour', 
    C2.colour 'hair_colour', 
    C3.colour 'skin_colour',
    RC.race, PB.publisher_name
	FROM superhero SH
    LEFT JOIN gender GD ON GD.id = SH.gender_id
    LEFT JOIN colour C1 ON C1.id = SH.eye_colour_id
    LEFT JOIN colour C2 ON C2.id = SH.hair_colour_id
    LEFT JOIN colour C3 ON C3.id = SH.skin_colour_id
    LEFT JOIN race RC ON RC.id = SH.race_id
    LEFT JOIN publisher PB ON PB.id = SH.publisher_id;
    


DELIMITER $$
CREATE PROCEDURE spu_superhero_by_publisher(IN _publisher_id INT)
BEGIN
SELECT
	SH.id, SH.superhero_name, SH.full_name,SH.publisher_id,
    GD.gender, 
    C1.colour 'eye_colour', 
    C2.colour 'hair_colour', 
    C3.colour 'skin_colour',
    RC.race, PB.publisher_name
	FROM superhero SH
    LEFT JOIN gender GD ON GD.id = SH.gender_id
    LEFT JOIN colour C1 ON C1.id = SH.eye_colour_id
    LEFT JOIN colour C2 ON C2.id = SH.hair_colour_id
    LEFT JOIN colour C3 ON C3.id = SH.skin_colour_id
    LEFT JOIN race RC ON RC.id = SH.race_id
    LEFT JOIN publisher PB ON PB.id = SH.publisher_id
    WHERE SH.publisher_id=_publisher_id;
END$$

-- CALL spu_superhero_by_publisher(3);
-- SELECT * FROM publisher;

-- version 1
DELIMITER $$
CREATE PROCEDURE sp_get_publisher()
BEGIN
	SELECT id, publisher_name FROM publisher ORDER BY publisher_name;
END $$
-- CALL sp_get_publisher();

-- VERSION 2(lista + numero de registro)
SELECT 
	SH.publisher_id,
    PB.publisher_name,
    COUNT(SH.publisher_id) 'total'
	FROM superhero SH
	INNER JOIN publisher PB ON PB.id=SH.publisher_id
    GROUP BY SH.publisher_id;


-- VERSION 3 corregir los espacios en blanco
CREATE VIEW vs_publisher_count
AS
SELECT 
	SH.publisher_id,
    CASE
		 WHEN  PB.publisher_name = '' THEN 'No especificado'
         WHEN   PB.publisher_name!= '' THEN PB.publisher_name
    END 'publisher_name',
    COUNT(SH.publisher_id) 'total'
	FROM superhero SH
	INNER JOIN publisher PB ON PB.id=SH.publisher_id
    GROUP BY SH.publisher_id;
    
-- SELECT*FROM superhero;

DELIMITER $$
CREATE PROCEDURE spu_publisherid(IN _id INT)
BEGIN
SELECT 
	SH.superhero_name, SH.full_name,
    GD.gender,
    RC.race, PB.publisher_name
	FROM superhero SH
    LEFT JOIN gender GD ON GD.id = SH.gender_id
    LEFT JOIN colour C1 ON C1.id = SH.eye_colour_id
    LEFT JOIN colour C2 ON C2.id = SH.hair_colour_id
    LEFT JOIN colour C3 ON C3.id = SH.skin_colour_id
    LEFT JOIN race RC ON RC.id = SH.race_id
    LEFT JOIN publisher PB ON PB.id = SH.publisher_id
	WHERE SH.id=_id;
END$$

CALL spu_publisherid(5);

DELIMITER $$
CREATE PROCEDURE sp_filter_publisher
(
	IN _publisher_id INT,
    IN _gender_id INT,
    IN _cantmax INT
)
BEGIN
	SELECT 
		SH.id, SH.superhero_name, SH.full_name,
        RC.race,
        AL.alignment,
        SH.height_cm, SH.weight_kg,
        PB.publisher_name,
        GD.gender
    FROM superhero SH
	LEFT JOIN race RC ON RC.id = SH.race_id
    LEFT JOIN alignment AL ON AL.id = SH.alignment_id
    LEFT JOIN publisher PB ON PB.id = SH.publisher_id
    LEFT JOIN gender GD ON GD.id = SH.gender_id
    WHERE SH.publisher_id=_publisher_id AND SH.gender_id=_gender_id LIMIT _cantmax;
END $$

-- CALL sp_filter_publisher(3,1,5);

DELIMITER $$
CREATE PROCEDURE sp_filtrar_fisico
(
	IN _minest INT,
    IN _maxest INT,
    IN _minwgt INT,
    IN _maxwgt INT
)
BEGIN
		SELECT 
		SH.id, SH.superhero_name, SH.full_name,
        RC.race,
        AL.alignment,
        SH.height_cm, SH.weight_kg,
        PB.publisher_name,
        GD.gender
    FROM superhero SH
	LEFT JOIN race RC ON RC.id = SH.race_id
    LEFT JOIN alignment AL ON AL.id = SH.alignment_id
    LEFT JOIN publisher PB ON PB.id = SH.publisher_id
    LEFT JOIN gender GD ON GD.id = SH.gender_id
	WHERE SH.height_cm BETWEEN _minest AND _maxest
    AND SH.weight_kg BETWEEN _minwgt AND _maxwgt;
END$$

-- CALL sp_filtrar_fisico(150, 200, 50, 120);

-- SELECT * FROM gender;
-- SELECT*FROM superhero