# Function
USE gym_management_system;

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

DROP FUNCTION calculate_membership_end_date;

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

DROP PROCEDURE manage_view_all_clients;

DELIMITER $$
CREATE PROCEDURE manager_view_all_clients(IN manager_id_p VARCHAR(64))
    BEGIN
		SELECT c.client_id, c.name, c.email, c.phone_number, c.address, t.staff_name AS trainer_name FROM registers r
			JOIN clients c
				ON r.client_id = c.client_id
			JOIN trainer t
				ON t.staff_id = c.trainer_id
		WHERE r.manager_id = manager_id_p;
    END $$
DELIMITER ;


CALL manager_view_all_clients('MA2');



# 2. Procedure for manager to view particular client details
# -> manager_id_p is the value used as credentials

DROP PROCEDURE manager_view_client;

DELIMITER $$
CREATE PROCEDURE manager_view_client(IN manager_id_p VARCHAR(64), IN client_id_p VARCHAR(64))
    BEGIN
		SELECT c.client_id, c.name, c.email, c.phone_number, c.address, t.staff_name AS trainer_name FROM registers r
			JOIN clients c
				ON r.client_id = c.client_id
			JOIN trainer t
				ON t.staff_id = c.trainer_id
		WHERE r.manager_id = manager_id_p AND c.client_id = client_id_p;
    END $$
DELIMITER ;


CALL manager_view_client('MA2', 'CL2');


# 3. Procedure for manager to view all trainer details

DROP PROCEDURE manager_view_all_trainers;

DELIMITER $$
CREATE PROCEDURE manager_view_all_trainers(IN manager_id_p VARCHAR(64))
	BEGIN
		SELECT t.staff_id, t.staff_name, t.contact_number, t.email, t.shift_start_time, t.shift_end_time, t.specialization, t.years_of_experience
			FROM registers r
			JOIN clients c
				ON r.client_id = c.client_id
			JOIN trainer t
				ON t.staff_id = c.trainer_id
		WHERE r.manager_id = manager_id_p;
	END $$
DELIMITER ;

CALL manager_view_all_trainers('MA1');


# 4. Procedure for manager to view particular trainer details

DROP PROCEDURE manager_view_trainers;

DELIMITER $$
CREATE PROCEDURE manager_view_trainers(IN manager_id_p VARCHAR(64), IN trainer_id_p VARCHAR(64))
	BEGIN
		SELECT t.staff_id, t.staff_name, t.contact_number, t.email, t.shift_start_time, t.shift_end_time, t.specialization, t.years_of_experience
			FROM registers r
			JOIN clients c
				ON r.client_id = c.client_id
			JOIN trainer t
				ON t.staff_id = c.trainer_id 
		WHERE r.manager_id = manager_id_p AND c.trainer_id = trainer_id_p;
	END $$
DELIMITER ;

CALL manager_view_trainers('MA2', 'TR3');



# Trainer

# 1. view details of clients assigned to trainer
# -> enter trainer_id_p as parameter used in python

DROP PROCEDURE trainer_view_all_clients;

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

DROP PROCEDURE trainer_view_client;

DELIMITER $$
CREATE PROCEDURE trainer_view_client(IN trainer_id_p VARCHAR(64), IN client_id_p VARCHAR(64))
	BEGIN
		SELECT c.client_id, c.name, c.email, c.phone_number, es.workout_type, dp.plan_type FROM clients c
			JOIN trainer t
				ON t.staff_id = c.trainer_id
			JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
			JOIN diet_plan dp
				ON dp.plan_id = c.plan_id
		WHERE c.trainer_id = trainer_id_p AND c.client_id = client_id_p;
	END $$
DELIMITER ;

CALL trainer_view_client('TR3', 'CL7');



# 3. Trainer creates health_report 
DROP PROCEDURE create_health_report;

DELIMITER $$
CREATE PROCEDURE create_health_report(IN weight_p FLOAT, IN height_p FLOAT, IN fat_percentage_p FLOAT, IN smoking_p BOOL, 
										IN drinking_p BOOL, IN surgery_p BOOL, IN date_p DATE, IN client_id_p VARCHAR(64))
	BEGIN
		DECLARE bmi_var FLOAT4;
        SET bmi_var = calculate_bmi(height_p, weight_p);
        
        INSERT INTO health_report
			VALUES (weight_p, height_p, bmi_var, fat_percentage_p, smoking_p, drinking_p, surgery_p, date_p, client_id_p);

    END $$
DELIMITER ;

CALL create_health_report(120, 5.11, 10.3, true, false, false, '2000-02-20', 'CL2');

# DELETE FROM health_report WHERE client_id = 'CL2';

SELECT * FROM health_report;


# 4. Trainer views workout_type
DROP PROCEDURE trainer_views_all_workout_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_workout_type()
	BEGIN
		SELECT * FROM exercise_schedule;
    END $$
DELIMITER ;

CALL trainer_views_all_workout_type;


# 5. Trainer selects a particular workout_type
DROP PROCEDURE trainer_views_workout_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_workout_type(IN workout_id_p INT)
	BEGIN
		SELECT es.workout_type, c.week_day, e.exercise_id, e.exercise_name, e.exercise_description, sets, reps FROM exercise_schedule es
			JOIN contain c
				ON es.workout_id = c.workout_id
			JOIN exercise e
				ON e.exercise_id = c.exercise_id
		WHERE es.workout_id = workout_id_p
        ORDER BY FIELD(week_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
    END $$
DELIMITER ;

CALL trainer_views_workout_type(1);


# 6. Trainers views all diet_plan_type
DROP PROCEDURE trainer_views_all_diet_plan_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_diet_plan_type()
	BEGIN
		SELECT * FROM diet_plan;
	END $$
DELIMITER ;

CALL trainer_views_all_diet_plan_type;


# 7. Trainer selects a particular diet_plan
DROP PROCEDURE trainer_views_diet_plan_type;

DELIMITER $$
CREATE PROCEDURE trainer_views_diet_plan_type(IN plan_id_p INT)
	BEGIN
		SELECT dp.plan_type, dpd.mealtime, dpd.week_day, dpd.meal_description, dpd.calories FROM diet_plan dp
			JOIN diet_plan_description dpd
				ON dp.plan_id = dpd.plan_id
		WHERE dpd.plan_id = plan_id_p;
    END $$
DELIMITER ;

CALL trainer_views_diet_plan_type(3);


# 8. Trainer views all exercises
DROP PROCEDURE trainer_views_all_exercises;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_exercises()
	BEGIN
		SELECT es.workout_type, e.* FROM exercise e
			JOIN contain c
				ON c.exercise_id = e.exercise_id
			JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
		GROUP BY e.exercise_id
		ORDER BY e.exercise_id;
    END $$
DELIMITER ;

CALL trainer_views_all_exercises;


# 9. Trainer selects an exercise
DROP PROCEDURE trainer_views_exercise;

DELIMITER $$
CREATE PROCEDURE trainer_views_exercise(IN exercise_id_p INT)
	BEGIN
		SELECT es.workout_type, e.* FROM exercise e
			JOIN contain c
				ON c.exercise_id = e.exercise_id
			JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
		GROUP BY e.exercise_id
        HAVING exercise_id = exercise_id_p
		ORDER BY e.exercise_id;
        
    END $$
DELIMITER ;

CALL trainer_views_exercise(25);


# 10. Trainer views all equipments
DROP PROCEDURE trainer_views_all_equipments;

DELIMITER $$
CREATE PROCEDURE trainer_views_all_equipments()
	BEGIN
		SELECT * FROM equipment;
    END $$
DELIMITER ;

CALL trainer_views_all_equipments;

# 11. Trainer views an equipment
DROP PROCEDURE trainer_views_equipments;

DELIMITER $$
CREATE PROCEDURE trainer_views_equipments(IN equipment_id_p INT)
	BEGIN
		SELECT * FROM equipment
        WHERE equipment_id = equipment_id_p;
    END $$
DELIMITER ;

CALL trainer_views_equipments(105);