# Function

# 1. Function to calculate bmi and insert value into health_report table
DROP FUNCTION IF EXISTS bmi;

DELIMITER $$
CREATE FUNCTION bmi(height_p FLOAT, weight_p FLOAT)
	RETURNS VARCHAR(64)
    DETERMINISTIC MODIFIES SQL DATA
    BEGIN
		DECLARE bmi_var FLOAT;
        SELECT (weight_p / (height_p*height_p)) INTO bmi_var FROM health_report;
        
        INSERT INTO health_report (bmi) VALUES (bmi_var);
	RETURN NULL;
    END $$
DELIMITER ;