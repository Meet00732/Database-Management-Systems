# Function
USE gym_management_system;

-- View health reports
DROP PROCEDURE IF EXISTS view_health_reports_client;
DELIMITER $$
CREATE PROCEDURE view_health_reports_client(IN client_id_p VARCHAR(10))
BEGIN
	DECLARE cl_id FLOAT;
    
    SELECT weight INTO cl_id FROM health_report
		WHERE client_id = client_id_p;
        
	IF cl_id IS NOT NULL THEN
		SELECT date, weight, height, bmi, fat_percentage, smoking, drinking, surgery FROM health_report 
			WHERE client_id = client_id_p 
            ORDER BY DATE DESC;
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Record Found!';
    END IF;
END $$
DELIMITER ;

# CALL view_health_reports_client('CL12');

-- check credentials
DROP PROCEDURE IF EXISTS check_credentials;
DELIMITER $$
CREATE PROCEDURE check_credentials(IN userid_p VARCHAR(10), IN passwd_p VARCHAR(20))
BEGIN
	SELECT userid FROM login_credentials WHERE userid = userid_p AND passwd = passwd_p;
END $$
DELIMITER ;

-- view trainer's details
DROP PROCEDURE IF EXISTS view_trainer_details_client;
DELIMITER $$
CREATE PROCEDURE view_trainer_details_client(in client_id_p varchar(10))
BEGIN
	DECLARE t_var VARCHAR(150);
    
    SELECT t.staff_name INTO t_var FROM clients c 
        JOIN trainer t 
			ON c.trainer_id = t.staff_id
	WHERE c.client_id = client_id_p;
    
    IF t_var IS NOT NULL THEN
		SELECT t.staff_name, t.contact_number, t.email, t.shift_start_time, t.shift_end_time, t.specialization, t.years_of_experience 
			FROM clients c 
			JOIN trainer t 
				ON c.trainer_id = t.staff_id
		WHERE c.client_id = client_id_p;
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Trainer Found!';
    END IF;
END $$
DELIMITER ;

# CALL view_trainer_details_client('CL8');

-- View diet plan
DROP PROCEDURE IF EXISTS view_diet_plan_client;
DELIMITER $$
CREATE PROCEDURE view_diet_plan_client(IN client_id_p VARCHAR(10))
BEGIN
	DECLARE diet_plan_var VARCHAR(64);
    
    SELECT a.plan_id INTO diet_plan_var FROM clients a
		JOIN diet_plan b
			ON a.plan_id = b.plan_id
	WHERE a.client_id = client_id_p;
    
    IF diet_plan_var IS NOT NULL THEN		
		SELECT b.week_day, b.mealtime, b.meal_description, b.calories FROM clients a
			JOIN diet_plan_description b
				ON a.plan_id = b.plan_id
		WHERE a.client_id = client_id_p 
        ORDER BY FIELD(week_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
				FIELD(b.mealtime, 'Breakfast', 'Lunch', 'Dinner');
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Plan Found!';
    END IF;
end $$
DELIMITER ;

# CALL view_diet_plan_client('CL1');

-- view exercise schedule
DROP PROCEDURE IF EXISTS view_exercise_schedule_client;
DELIMITER $$
CREATE PROCEDURE view_exercise_schedule_client(IN client_id_p VARCHAR(10))
BEGIN
	DECLARE workout_plan_var VARCHAR(64);
    
    SELECT a.workout_id INTO workout_plan_var FROM clients a
		JOIN exercise_schedule b
			ON a.workout_id = b.workout_id
	WHERE a.client_id = client_id_p;

	IF workout_plan_var IS NOT NULL THEN
		SELECT b.week_day, c.exercise_name, b.sets, b.reps FROM clients a 
			JOIN contain b 
				ON a.workout_id = b.workout_id
			JOIN exercise c
				ON b.exercise_id = c.exercise_id
		WHERE a.client_id = client_id_p
		ORDER BY FIELD(week_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Workout Found!';		
    END IF;
END $$
DELIMITER ;

# SELECT * FROM clients;

CALL view_exercise_schedule_client('CL1');


-- view exercise details
DROP PROCEDURE IF EXISTS view_exercise_details_client;
DELIMITER $$
CREATE PROCEDURE view_exercise_details_client(IN exercise_id_p INT, IN client_id_p VARCHAR(10))
BEGIN
	DECLARE exercise_var VARCHAR(64);
    
    SELECT exercise_name INTO exercise_var FROM exercise
		WHERE exercise_id = exercise_id_p;
	
    IF exercise_var IS NOT NULL THEN
		SELECT c.exercise_name, c.exercise_description, e.equipment_name, e.equipment_description, e.equipment_id FROM clients a
			JOIN contain b 
				ON a.workout_id = b.workout_id
			JOIN exercise c
				ON b.exercise_id = c.exercise_id
			JOIN used_in d 
				ON d.exercise_id = b.exercise_id
			JOIN equipment e 
				ON d.equipment_id = e.equipment_id
		WHERE client_id = client_id_p AND c.exercise_id = exercise_id_p;
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Workout Found!';
    END IF;
END $$
DELIMITER ;

# SELECT * FROM exercise;

# CALL view_exercise_details_client(1, 'CL1');


# 1. Function to calculate bmi and insert value into health_report table
DROP FUNCTION IF EXISTS calculate_bmi;

DELIMITER $$
CREATE FUNCTION calculate_bmi(height_p FLOAT, weight_p FLOAT)
	RETURNS FLOAT
    DETERMINISTIC READS SQL DATA
    BEGIN
		DECLARE bmi_var FLOAT;
        SET bmi_var = (weight_p / (height_p*height_p));
	RETURN bmi_var;
    END $$
DELIMITER ;

SELECT MAX(client_id) FROM clients;


# 2. Function to calculate the membership_end_date

DROP FUNCTION IF EXISTS calculate_membership_end_date;

DELIMITER $$
CREATE FUNCTION calculate_membership_end_date(start_date_p DATE, membership_type_p VARCHAR(64))
	RETURNS DATE
    DETERMINISTIC MODIFIES SQL DATA
    BEGIN
		DECLARE end_date_var DATE;
        IF membership_type_p = 'Gold' THEN
			SELECT ADDDATE(start_date_p, INTERVAL 3 MONTH) INTO end_date_var;
		ELSE
			IF membership_type_p = 'Silver' THEN
				SELECT ADDDATE(start_date_p, INTERVAL 6 MONTH) INTO end_date_var;
			ELSE
				SELECT ADDDATE(start_date_p, INTERVAL 12 MONTH) INTO end_date_var;
			END IF;
		END IF;
	RETURN end_date_var;
    END $$
DELIMITER ;

-- SELECT calculate_membership_end_date('2000-02-20', 'Platinum'); 


# Procedures

# Manager
# 1. Procedure for manager to view all client details
# -> manager_id_p is the value used as credentials

DROP PROCEDURE IF EXISTS manager_view_all_clients;

DELIMITER $$
CREATE PROCEDURE manager_view_all_clients(IN manager_id_p VARCHAR(64))
    BEGIN
		SELECT c.client_id, c.name, c.email, c.phone_number, c.address, t.staff_name AS trainer_name FROM registers r
			JOIN manager m
				ON m.manager_branch_id = r.branch_id
			JOIN clients c
				ON r.client_id = c.client_id
			JOIN trainer t
				ON t.staff_id = c.trainer_id
		WHERE r.manager_id = manager_id_p;
	
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Manager_Id Found!';
    END $$
DELIMITER ;

# CALL manager_view_all_clients('MA1');


# 2. Procedure for manager to view particular client details
# -> manager_id_p is the value used as credentials

DROP PROCEDURE IF EXISTS manager_view_client;

DELIMITER $$
CREATE PROCEDURE manager_view_client(IN manager_id_p VARCHAR(64), IN client_id_p VARCHAR(64))
    BEGIN
		DECLARE client_var VARCHAR(64);
        
        SELECT name INTO client_var FROM registers r
			JOIN manager m
				ON m.manager_branch_id = r.branch_id
			JOIN clients c
				ON r.client_id = c.client_id
		WHERE c.client_id = client_id_p AND m.staff_id = manager_id_p;
            
		IF client_var IS NOT NULL THEN
			SELECT c.client_id, c.name, c.email, c.phone_number, c.address, t.staff_id, t.staff_name AS trainer_name FROM registers r
				JOIN manager m
					ON m.manager_branch_id = r.branch_id
				JOIN clients c
					ON r.client_id = c.client_id
				JOIN trainer t
					ON t.staff_id = c.trainer_id
			WHERE r.manager_id = manager_id_p AND c.client_id = client_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Client Record Found!';
        END IF;
    END $$
DELIMITER ;

# CALL manager_view_client('MA2', 'CL3');


# 3. Procedure for manager to view all trainer details

DROP PROCEDURE IF EXISTS manager_view_all_trainers;

DELIMITER $$
CREATE PROCEDURE manager_view_all_trainers(IN manager_id_p VARCHAR(64))
	BEGIN
		SELECT t.* FROM manager m
			JOIN trainer t
				ON m.manager_branch_id = t.trainer_branch_id
		WHERE m.staff_id = manager_id_p;
	END $$
DELIMITER ;

CALL manager_view_all_trainers('MA1');


# 4. Procedure for manager to view particular trainer details

DROP PROCEDURE IF EXISTS manager_view_trainers;

DELIMITER $$
CREATE PROCEDURE manager_view_trainers(IN manager_id_p VARCHAR(64), IN trainer_id_p VARCHAR(64))
	BEGIN
		DECLARE t_var VARCHAR(150);
        SELECT t.staff_name INTO t_var FROM trainer t 
			JOIN manager m
				ON m.manager_branch_id = t.trainer_branch_id
		WHERE m.staff_id = manager_id_p AND t.staff_id = trainer_id_p;
        
        IF t_var IS NOT NULL THEN
			SELECT t.* FROM manager m
				JOIN trainer t
					ON m.manager_branch_id = t.trainer_branch_id
			WHERE m.staff_id = manager_id_p AND t.staff_id = trainer_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Record Found!';
		END IF;
	END $$
DELIMITER ;

# CALL manager_view_trainers('MA1', 'TR3');



# Trainer

# 1. view details of clients assigned to trainer
# -> enter trainer_id_p as parameter used in python

DROP PROCEDURE IF EXISTS trainer_view_all_clients;

DELIMITER $$
CREATE PROCEDURE trainer_view_all_clients(IN trainer_id_p VARCHAR(64))
	BEGIN
		SELECT c.client_id, c.name, c.email, c.phone_number, es.workout_type, dp.plan_type FROM clients c
			JOIN trainer t
				ON t.staff_id = c.trainer_id
			JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
			JOIN diet_plan dp
				ON dp.plan_id = c.plan_id
		WHERE c.trainer_id = trainer_id_p;
	END $$
DELIMITER ;

CALL trainer_view_all_clients('TR3');


# 2. view details of clients assigned to trainer
# -> enter trainer_id_p as parameter used in python

DROP PROCEDURE IF EXISTS trainer_view_client;

DELIMITER $$
CREATE PROCEDURE trainer_view_client(IN trainer_id_p VARCHAR(64), IN client_id_p VARCHAR(64))
	BEGIN
		DECLARE client_var VARCHAR(150);
        
        SELECT name INTO client_var FROM clients
			WHERE trainer_id = trainer_id_p AND client_id = client_id_p;
    
		IF client_var IS NOT NULL THEN
			SELECT c.client_id, c.name, c.email, c.phone_number, es.workout_type, dp.plan_type FROM clients c
				JOIN trainer t
					ON t.staff_id = c.trainer_id
				JOIN exercise_schedule es
					ON es.workout_id = c.workout_id
				JOIN diet_plan dp
					ON dp.plan_id = c.plan_id
			WHERE c.trainer_id = trainer_id_p AND c.client_id = client_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Client Record Found!';
		END IF;
	END $$
DELIMITER ;

CALL trainer_view_client('TR3', 'CL7');


# 3. Trainer creates health_report 
DROP PROCEDURE IF EXISTS create_health_report;

DELIMITER $$
CREATE PROCEDURE create_health_report(IN age_p INT, IN weight_p FLOAT, IN height_p FLOAT, IN fat_percentage_p FLOAT, IN smoking_p BOOL, 
										IN drinking_p BOOL, IN surgery_p BOOL, IN date_p DATE, IN client_id_p VARCHAR(64))
	BEGIN
		DECLARE bmi_var FLOAT4;
        SET bmi_var = calculate_bmi(height_p, weight_p);
        
        INSERT INTO health_report
			VALUES (age_p, weight_p, height_p, bmi_var, fat_percentage_p, smoking_p, drinking_p, surgery_p, date_p, client_id_p);

    END $$
DELIMITER ;

# CALL create_health_report(22, 120, 5.11, 10.3, true, false, false, '2000-02-20', 'CL2');

# DELETE FROM health_report WHERE client_id = 'CL2';

SELECT * FROM health_report;


# 4. Trainer views workout_type
DROP PROCEDURE IF EXISTS trainer_views_all_workout_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_workout_type()
	BEGIN
		SELECT * FROM exercise_schedule;
    END $$
DELIMITER ;

CALL trainer_views_all_workout_type;


# 5. Trainer selects a particular workout_type
DROP PROCEDURE IF EXISTS trainer_views_workout_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_workout_type(IN workout_id_p INT)
	BEGIN
		DECLARE workout_var INT;
        SELECT workout_id INTO workout_var FROM exercise_schedule
			WHERE workout_id = workout_id_p;
        
        IF workout_var IS NOT NULL THEN
			SELECT es.workout_type, c.week_day, e.exercise_id, e.exercise_name, e.exercise_description, sets, reps FROM exercise_schedule es
				JOIN contain c
					ON es.workout_id = c.workout_id
				JOIN exercise e
					ON e.exercise_id = c.exercise_id
			WHERE es.workout_id = workout_id_p
			ORDER BY FIELD(week_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Workout_Id Record Found!';
        END IF;
    END $$
DELIMITER ;

CALL trainer_views_workout_type(1);


# 6. Trainers views all diet_plan_type
DROP PROCEDURE IF EXISTS trainer_views_all_diet_plan_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_diet_plan_type()
	BEGIN
		SELECT * FROM diet_plan;
	END $$
DELIMITER ;

CALL trainer_views_all_diet_plan_type;


# 7. Trainer selects a particular diet_plan
DROP PROCEDURE IF EXISTS trainer_views_diet_plan_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_diet_plan_type(IN plan_id_p INT)
	BEGIN
		DECLARE plan_var INT;
        SELECT plan_id INTO plan_var FROM diet_plan
			WHERE plan_id = plan_id_p;
		
        IF plan_var IS NOT NULL THEN
			SELECT dp.plan_type, dpd.mealtime, dpd.week_day, dpd.meal_description, dpd.calories FROM diet_plan dp
				JOIN diet_plan_description dpd
					ON dp.plan_id = dpd.plan_id
			WHERE dpd.plan_id = plan_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Plan_Id Record Found!';
        END IF;
    END $$
DELIMITER ;

# CALL trainer_views_diet_plan_type(1);


# 8. Trainer views all exercises
DROP PROCEDURE IF EXISTS trainer_views_all_exercises;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_exercises()
	BEGIN
		SELECT e.*, GROUP_CONCAT(DISTINCT es.workout_type) AS workouts FROM exercise e
			LEFT OUTER JOIN contain c
				ON c.exercise_id = e.exercise_id
			JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
		GROUP BY e.exercise_id;
    END $$
DELIMITER ;

CALL trainer_views_all_exercises;


# 9. Trainer selects an exercise
DROP PROCEDURE IF EXISTS trainer_views_exercise;

DELIMITER $$
CREATE PROCEDURE trainer_views_exercise(IN exercise_id_p INT)
	BEGIN
		DECLARE exercise_var INT;
        
        SELECT exercise_id INTO exercise_var FROM exercise
			WHERE exercise_id = exercise_id_p;
            
		IF exercise_var IS NOT NULL THEN
			SELECT es.workout_type, e.exercise_name, e.exercise_description FROM exercise e
				JOIN contain c
					ON c.exercise_id = e.exercise_id
				JOIN exercise_schedule es
					ON es.workout_id = c.workout_id
			WHERE e.exercise_id = exercise_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise_Id Record Not Found!';
        END IF;
    END $$
DELIMITER ;

CALL trainer_views_exercise(25);


# 10. Trainer views all equipments
DROP PROCEDURE IF EXISTS trainer_views_all_equipments;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_equipments()
	BEGIN
		SELECT * FROM equipment;
    END $$
DELIMITER ;

CALL trainer_views_all_equipments;

# 11. Trainer views an equipment
DROP PROCEDURE IF EXISTS trainer_views_equipments;

DELIMITER $$
CREATE PROCEDURE trainer_views_equipments(IN equipment_id_p INT)
	BEGIN
		DECLARE equipment_var INT;
        
		SELECT equipment_id INTO equipment_var FROM equipment
			WHERE equipment_id = equipment_id_p;
        
        IF equipment_var IS NOT NULL THEN
			SELECT * FROM equipment
			WHERE equipment_id = equipment_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Equipment_Id Record Found!';
        END IF;
    END $$
DELIMITER ;

CALL trainer_views_equipments(105);



# Update Manager Procedures
USE gym_management_system;
# 1. Manager updates details of clients
DROP PROCEDURE IF EXISTS manager_update_client;

DELIMITER $$
CREATE PROCEDURE manager_update_client(IN client_id_p VARCHAR(64), IN col_name_p VARCHAR(200), IN val_p VARCHAR(200))
	BEGIN
		IF EXISTS (SELECT * FROM clients WHERE client_id = client_id_p) THEN
			SET @s = CONCAT('UPDATE clients SET ', col_name_p, ' = "', val_p, '" WHERE client_id = "', client_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SELECT 'Record Not Found!';
		END IF;
    END $$
DELIMITER ;

SELECT * FROM clients;

CALL manager_update_client('CL10', 'workout_id', '1');
# CALL manager_update_client_varchar('CL1', 'email', 'meet.patel@gmail.com');

# 2. Manager updates details of trainer
DROP PROCEDURE IF EXISTS manager_update_trainer;

DELIMITER $$
CREATE PROCEDURE manager_update_trainer(IN trainer_id_p VARCHAR(64), IN col_name_p VARCHAR(200), IN val_p VARCHAR(200))
	BEGIN
		IF EXISTS (SELECT * FROM trainer WHERE staff_id = trainer_id_p) THEN
			SET @s = CONCAT('UPDATE trainer SET ', col_name_p, ' = "', val_p, '" WHERE staff_id = "', trainer_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SELECT 'Record Not Found!';
		END IF;
    END $$
DELIMITER ;

SELECT * FROM trainer;

CALL manager_update_trainer('TR1', 'years_of_experience', 10);

# 3. Trainer update a diet plan
DROP PROCEDURE IF EXISTS trainer_update_diet_plan;

DELIMITER $$
CREATE PROCEDURE trainer_update_diet_plan(IN plan_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
    BEGIN
        IF EXISTS (SELECT * FROM diet_plan WHERE plan_id = plan_id_p) THEN
			SET @s = CONCAT('UPDATE diet_plan SET ', col_name_p, ' = "', val_p, '" WHERE plan_id = "', plan_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SELECT 'Record Not Found!';
		END IF;
    END $$
DELIMITER ;


SELECT * FROM diet_plan;

# CALL trainer_update_diet_plan('4', 'plan_id', '2');


# 4. Trainer update details of client
DROP PROCEDURE IF EXISTS trainer_update_client;

DELIMITER $$
CREATE PROCEDURE trainer_update_client(IN client_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
    BEGIN
        IF EXISTS (SELECT * FROM clients WHERE client_id = client_id_p) THEN
			SET @s = CONCAT('UPDATE clients SET ', col_name_p, ' = "', val_p, '" WHERE client_id = "', client_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SELECT 'Record Not Found!';
		END IF;
    END $$
DELIMITER ;

SELECT * FROM clients;

# CALL trainer_update_client('CL1', 'name', 'Jake Paralta');


# 5. Trainer update details of equipment
DROP PROCEDURE IF EXISTS trainer_update_equipment;

DELIMITER $$
CREATE PROCEDURE trainer_update_equipment(IN equipment_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
    BEGIN
        IF EXISTS (SELECT * FROM equipment WHERE equipment_id = equipment_id_p) THEN
			SET @s = CONCAT('UPDATE equipment SET ', col_name_p, ' = "', val_p, '" WHERE equipment_id = "', equipment_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SELECT 'Record Not Found!';
		END IF;
    END $$
DELIMITER ;

SELECT * FROM equipment;

# CALL trainer_update_equipment('101', 'equipment_name', 'Treadmill');


# 6. Trainer update details of exercise
DROP PROCEDURE IF EXISTS trainer_update_exercise;

DELIMITER $$
CREATE PROCEDURE trainer_update_exercise(IN exercise_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
    BEGIN
        IF EXISTS (SELECT * FROM exercise WHERE exercise_id = exercise_id_p) THEN
			SET @s = CONCAT('UPDATE exercise SET ', col_name_p, ' = "', val_p, '" WHERE exercise_id = "', exercise_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SELECT 'Record Not Found!';
		END IF;
    END $$
DELIMITER ;

SELECT * FROM exercise;

# CALL trainer_update_exercise('1', 'exercise_name', 'Treadmill');


# 7. Trainer update details of exercise_schedule
DROP PROCEDURE IF EXISTS trainer_update_exercise_schedule;

DELIMITER $$
CREATE PROCEDURE trainer_update_exercise_schedule(IN workout_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
    BEGIN
        IF EXISTS (SELECT * FROM exercise_schedule WHERE workout_id = workout_id_p) THEN
			SET @s = CONCAT('UPDATE exercise_schedule SET ', col_name_p, ' = "', val_p, '" WHERE workout_id = "', workout_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SELECT 'Record Not Found!';
		END IF;
    END $$
DELIMITER ;

SELECT * FROM exercise_schedule;

# CALL trainer_update_exercise_schedule('1', 'workout_type', 'Cardio');






############################################################################################################

# Create

############################################################################################################

# 1. Manager create client

DROP PROCEDURE IF EXISTS manager_create_client;

DELIMITER $$
CREATE PROCEDURE manager_create_client(IN client_id_p VARCHAR(64), IN name_p VARCHAR(150), IN email_p VARCHAR(150), 
										IN phone_number_p VARCHAR(20), IN address_p VARCHAR(250), IN trainer_id_p VARCHAR(64),
                                        IN workout_id_p VARCHAR(64), IN plan_id_p VARCHAR(64))
	BEGIN
		DECLARE cl_var VARCHAR(64);
		SELECT client_id INTO cl_var FROM clients
			WHERE client_id = client_id_p;
        
        IF cl_var IS NULL THEN
			INSERT INTO clients
				VALUES (client_id_p, name_p, email_p, phone_number_p, address_p, trainer_id_p, workout_id_p, plan_id_p);
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Client_id Already Exists';
        END IF;
    END $$
DELIMITER ;

SELECT * FROM clients;

# CALL manager_create_client('CL11', 'Charles Bolye', 'jake.paralta@gmail.com', '879-456-1234', '123 Tremont St, Boston, MA 02120', NULL, NULL,  NULL);