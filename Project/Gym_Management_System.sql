DROP DATABASE IF EXISTS gym_management_system;

CREATE DATABASE IF NOT EXISTS gym_management_system;

USE gym_management_system;

# Branch Table
DROP TABLE IF EXISTS branch;

CREATE TABLE IF NOT EXISTS branch(
	branch_id INT auto_increment PRIMARY KEY,
    street_number VARCHAR(250) NOT NULL,
    street_name VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zipcode INT(6) NOT NULL,
    phone_number VARCHAR(25) NOT NULL,
    email VARCHAR(150) NOT NULL,
    unique (street_number, street_name, city, state, zipcode)
);

INSERT INTO branch (branch_id, street_number, street_name, city, state, zipcode, phone_number, email) 
VALUES 
    (1, '100', 'Main St', 'Boston', 'MA', '02108', '(123) 555-4567', 'MainStboston@gmail.com'),
    (2, '200', 'State St', 'Boston', 'MA', '02109', '(445) 123-8906', 'StateStboston@gmail.com'),
    (3, '300', 'Beacon St', 'Boston', 'MA', '02116', '(334) 563-9900', 'BeaconStboston@gmail.com'),
    (4, '400', 'Boylston St', 'Boston', 'MA', '02116', '(112) 327-8900', 'BoylstonStboston@gmail.com'),
    (5, '500', 'Cambridge St', 'Boston', 'MA', '02114', '(111) 222-3411', 'CambridgeStboston@gmail.com');


# Trainer Table
DROP TABLE IF EXISTS trainer;

CREATE TABLE IF NOT EXISTS trainer(
	staff_id VARCHAR(10) PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    address VARCHAR(150) NOT NULL,
    shift_start_time TIME NOT NULL,
    shift_end_time TIME NOT NULL,
    salary INT NOT NULL,
    specialization VARCHAR(250) NOT NULL,
    years_of_experience INT NOT NULL,
    trainer_branch_id INT,
    FOREIGN KEY (trainer_branch_id) REFERENCES branch(branch_id)
		ON UPDATE CASCADE ON DELETE SET NULL
);


INSERT INTO trainer (staff_id, staff_name, contact_number, email, address, shift_start_time, shift_end_time, salary, specialization, years_of_experience, trainer_branch_id) 
VALUES 
    ('TR1', 'Meet Patel', '234-555-1234', 'Meet.patel@example.com', '123 Main St, Boston, MA 02108', '08:00:00', '16:00:00', 50000, 'Weight Lifting', 5, 1),
    ('TR2', 'Mihir Chitre', '278-555-5678', 'Mihir.chitre@example.com', '456 Market St, Boston, CA 02108', '12:00:00', '20:00:00', 60000, 'Yoga', 8, 2),
    ('TR3', 'Aditya Gurnani', '099-555-9012', 'Aditya.gurnani@example.com', '789 Elm St, Boston, IL 02116', '09:00:00', '17:00:00', 55000, 'Cardio', 6, 3),
    ('TR4', 'Shashank Patel', '678-555-3457', 'Shashank.patel@example.com', '100 Fifth Ave, Boston, NY 02116', '10:00:00', '18:00:00', 65000, 'Pilates', 10, 4),
    ('TR5', 'Krishi Panchal', '111-555-7891', 'Krishi.panchal@example.com', '200 Main St, Boston, TX 02109', '07:00:00', '15:00:00', 45000, 'Crossfit', 3, 5),
    ('TR6', 'Pratik Poojari', '673-555-2346', 'Pratik.poojari@example.com', '1000 Main St, Boston, MA 02109', '13:00:00', '21:00:00', 70000, 'Spinning', 9, 2),
    ('TR7', 'David Kim', '857-555-6789', 'david.kim@example.com', '500 1st St, Boston, WA 02114', '11:00:00', '19:00:00', 60000, 'Boxing', 7, 1),
    ('TR8', 'Jennifer Aniston', '857-555-3456', 'jennifer.aniston@example.com', '700 Maple Ave, Boston, TX 02114', '08:00:00', '16:00:00', 50000, 'Zumba', 5, 4),
    ('TR9', 'Brian Jones', '857-555-7890', 'brian.jones@example.com', '100 Park Ave, Boston, NY 02115', '09:00:00', '17:00:00', 55000, 'Martial Arts', 6, 3),
    ('TR10', 'Lisa Kim', '857-555-2345', 'lisa.kim@example.com', '400 2nd St, Boston, CA 02115', '14:00:00', '22:00:00', 65000, 'Crossfit', 10, 5);



# manager Table
DROP TABLE IF EXISTS manager;

CREATE TABLE IF NOT EXISTS manager(
	staff_id VARCHAR(10) PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
	address VARCHAR(150) NOT NULL,
    shift_start_time TIME NOT NULL,
    shift_end_time TIME NOT NULL,
    salary INT NOT NULL,
    manager_branch_id INT,
    start_date DATE,
    FOREIGN KEY (manager_branch_id) REFERENCES branch(branch_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO manager (staff_id, staff_name, contact_number, email, address, shift_start_time, shift_end_time, salary, manager_branch_id, start_date) 
VALUES 
	('MA1', 'Jane Doe', '617-123-4567', 'jane.doe@example.com', '789 Elm St, Boston USA', '09:00:00', '18:00:00', 90000, 1, '2021-12-01'),
	('MA2', 'Michael Chen', '617-234-5678', 'michael.chen@example.com', '321 Maple Ave, Boston USA', '08:00:00', '17:00:00', 95000, 2, '2022-01-15'),
	('MA3', 'Karen Lee', '617-345-6789', 'karen.lee@example.com', '456 Pine St, Boston USA', '10:00:00', '19:00:00', 85000, 3, '2022-02-01'),
	('MA4', 'David Kim', '617-456-7890', 'david.kim@example.com', '987 Oak Rd, Boston USA', '07:00:00', '16:00:00', 100000, 4, '2022-03-15'),
	('MA5', 'Emily Chang', '617-567-8901', 'emily.chang@example.com', '654 Cedar Blvd, Boston USA', '08:30:00', '17:30:00', 92000, 5, '2022-04-01');




# Membership_plan Table
DROP TABLE IF EXISTS membership_plan;

CREATE TABLE IF NOT EXISTS membership_plan(
	# enum (premium, gold, silver)
    membership_type VARCHAR(64) PRIMARY KEY,
    fees INT NOT NULL,
    duration INT NOT NULL
);

INSERT INTO membership_plan (membership_type, fees, duration)
VALUES 
	('Silver', 2000, 3),
    ('Gold', 4500, 6),
    ('Platinum', '6000', 12);
    


# Equipment Table
DROP TABLE IF EXISTS equipment;

CREATE TABLE IF NOT EXISTS equipment(
	equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(100) NOT NULL,
    equipment_description VARCHAR(250) NOT NULL
);


# Equipment
# What if equipment with same name, description is in different branch? Repeatable Data? Maybe branch_id in this table is not relevant.
# We can remove branch_id (Assuming these equipments are in all branches)
 INSERT INTO equipment (equipment_id, equipment_name, equipment_description) 
VALUES 
(101, 'Treadmill', 'A cardio machine that simulates running or walking in place'),
(102, 'Stationary bike', 'A bike that stays in one place while you pedal it'),
(103, 'Elliptical', 'A cardio machine that combines aspects of running, cycling, and climbing'),
(104, 'Rowing machine', 'A machine that simulates the motion of rowing a boat'),
(105, 'Weight bench', 'A bench designed for weight training exercises'),
(106, 'Dumbbells', 'Free weights that are used for strength training'),
(107, 'Barbell', 'A long metal bar used for weightlifting exercises'),
(108, 'Squat rack', 'A piece of equipment used for exercises like squats and bench presses'),
(109, 'Leg press machine', 'A machine used for leg strengthening exercises'),
(110, 'Stair climber', 'A cardio machine that simulates climbing stairs'),
(111, 'Spin bike', 'A stationary bike used for indoor cycling classes'),
(112, 'Resistance bands', 'Elastic bands used for resistance training'),
(113, 'Jump rope', 'A simple piece of equipment used for cardio and coordination training'),
(114, 'Plyo box', 'A box used for plyometric exercises like box jumps'),
(115, 'Kettlebell', 'A type of weight used for functional fitness exercises');



# Exercise Table
DROP TABLE IF EXISTS exercise;

CREATE TABLE IF NOT EXISTS exercise(
	exercise_id INT PRIMARY KEY,
    exercise_name VARCHAR(64) UNIQUE NOT NULL,
    exercise_description VARCHAR(150) NOT NULL
);

INSERT INTO exercise (exercise_id, exercise_name, exercise_description) VALUES
(1, 'Treadmill', 'A workout where you run or walk on a moving platform.'),
(2, 'Elliptical', 'A workout where you simulate running, walking, or climbing stairs.'),
(3, 'Stationary Bike', 'A workout where you cycle on a stationary bike.'),
(4, 'Stair Climber', 'A workout where you climb stairs on a machine.'),
(5, 'Rowing Machine', 'A workout where you simulate rowing on a machine.'),
(6, 'Jumping Jacks', 'A workout where you jump and spread your legs and arms.'),
(7, 'Jump Rope', 'A workout where you jump over a rope as it swings under your feet.'),
(8, 'High Knees', 'A workout where you jog in place, lifting your knees as high as you can.'),
(9, 'Mountain Climbers', 'A workout where you get into a push-up position and alternately bring your knees toward your chest.'),
(10, 'Sprints', 'A workout where you run as fast as you can for a short distance.'),
(11, 'Jogging', 'A workout where you run at a moderate pace.'),
(12, 'Hiking', 'A workout where you walk up and down hills and trails.'),
(13, 'Cycling', 'A workout where you cycle outdoors on a bike.'),
(14, 'Jumping Squats', 'A workout where you squat down and jump up.'),
(15, 'Plyometric Lunges', 'A workout where you alternate lunges with jumping.'),
(16, 'Jumping Lunges', 'A workout where you jump and alternate lunges.'),
(17, 'Jumping Jack Squats', 'A workout where you do a combination of jumping jacks and squats.'),
(18, 'Jumping Jack Burpees', 'A workout where you do a combination of jumping jacks and burpees.'),
(19, 'Jumping Jack High Knees', 'A workout where you do a combination of jumping jacks and high knees.'),
(20, 'Jumping Jack Mountain Climbers', 'A workout where you do a combination of jumping jacks and mountain climbers.'),
(21, 'Bicep Curl', 'Strength training exercise for biceps muscles'),
(22, 'Deadlift', 'Strength training exercise for back and leg muscles'),
(23, 'Squat', 'Strength training exercise for leg muscles'),
(24, 'Bench Press', 'Strength training exercise for chest muscles'),
(25, 'Pull-up', 'Strength training exercise for back and arm muscles'),
(26, 'Tricep Extension', 'Strength training exercise for triceps muscles'),
(27, 'Lateral Raise', 'Strength training exercise for shoulder muscles'),
(28, 'Crunches', 'Strength training exercise for abs muscles'),
(29, 'Leg Press', 'Strength training exercise for leg muscles'),
(30, 'Push-up', 'Strength training exercise for chest, shoulder, and arm muscles'),
(31, 'Dumbbell Fly', 'Strength training exercise for chest muscles'),
(32, 'Hammer Curl', 'Strength training exercise for biceps muscles'),
(33, 'Calf Raise', 'Strength training exercise for calf muscles'),
(34, 'Reverse Fly', 'Strength training exercise for back and shoulder muscles'),
(35, 'Russian Twist', 'Strength training exercise for abs muscles'),
(36, 'Dumbbell Row', 'Strength training exercise for back muscles'),
(37, 'Overhead Press', 'Strength training exercise for shoulder muscles'),
(38, 'Leg Curl', 'Strength training exercise for leg muscles'),
(39, 'Dumbbell Pullover', 'Strength training exercise for chest and back muscles'),
(40, 'Dumbbell Squat', 'Strength training exercise for leg muscles'),
(41, 'Dumbbell Lunges', 'Strength training exercise for leg muscles'),
(42, 'Seated Cable Row', 'Strength training exercise for back muscles'),
(43, 'Tricep Pushdown', 'Strength training exercise for triceps muscles'),
(44, 'Cable Curl', 'Strength training exercise for biceps muscles'),
(45, 'Incline Press', 'Strength training exercise for upper chest muscles'),
(46, 'Kettlebell Swing', 'Strengthens the posterior chain and improves cardiovascular endurance'),
(47, 'Turkish Get-Up', 'Full-body functional exercise that improves stability, mobility and coordination'),
(48, 'Medicine Ball Slam', 'Explosive exercise that improves power and cardiovascular fitness'),
(49, 'Battle Rope Wave', 'Total body exercise that improves muscular endurance and cardiovascular fitness'),
(50, 'Box Jump', 'Plyometric exercise that improves lower body power and explosiveness'),
(51, 'Burpee', 'Full-body exercise that improves cardiovascular fitness and muscular endurance'),
(52, 'Sandbag Clean and Press', 'Total body exercise that improves power and functional strength'),
(53, 'TRX Suspension Trainer Row', 'Improves upper back and shoulder strength and stability'),
(54, 'Boxing', 'Improves cardiovascular fitness and coordination'),
(55, 'Sled Push/Pull', 'Full-body exercise that improves power and functional strength'),
(56, 'Agility Ladder Drills', 'Improves footwork, speed and coordination'),
(57, 'Squat to Overhead Press', 'Total body exercise that improves power and functional strength'),
(58, 'Dumbbell Snatch', 'Total body exercise that improves power and functional strength'),
(59, 'Farmers Walk', 'Improves grip strength, core stability and functional strength'),
(60, 'Tire Flip', 'Total body exercise that improves power and functional strength');



# used_in table
DROP TABLE IF EXISTS used_in;

CREATE TABLE IF NOT EXISTS used_in(
	equipment_id INT,
    exercise_id INT,
    primary key (equipment_id, exercise_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

# Exercise_schedule Table
DROP TABLE IF EXISTS exercise_schedule;

CREATE TABLE IF NOT EXISTS exercise_schedule(
	workout_id INT AUTO_INCREMENT PRIMARY KEY,
	workout_type VARCHAR(64)
);

INSERT INTO exercise_schedule (workout_type) VALUES
('Cardio'),
('Strength Training'),
('Functional Training');

# contains Table
DROP TABLE IF EXISTS contain;

CREATE TABLE IF NOT EXISTS contain(
	exercise_id INT,
    workout_id INT,
    week_day VARCHAR(64) NOT NULL,
    sets INT NOT NULL,
    reps INT NOT NULL,
    primary key(workout_id, week_day, exercise_id),
    FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (workout_id) REFERENCES exercise_schedule(workout_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO contain (exercise_id, workout_id, week_day, sets, reps)
VALUES 
	(1, 1, 'Monday', 3, 15),
	(2, 1, 'Monday', 2, 12),
	(3, 1, 'Monday', 4, 20),
	(4, 1, 'Tuesday', 3, 10),
	(5, 1, 'Tuesday', 2, 15),
	(6, 1, 'Tuesday', 4, 18),
    (7, 1, 'Wednesday', 3, 12),
	(8, 1, 'Wednesday', 2, 20),
	(9, 1, 'Wednesday', 4, 13),
	(10, 1, 'Thursday', 3, 18),
	(11, 1, 'Thursday', 2, 20),
	(12, 1, 'Thursday', 4, 16),
	(13, 1, 'Friday', 3, 15),
	(14, 1, 'Friday', 2, 18),
	(15, 1, 'Friday', 4, 12),
    (16, 1, 'Saturday', 3, 12),
	(17, 1, 'Saturday', 2, 20),
	(19, 1, 'Saturday', 4, 15),
    (21, 2, 'Monday', 3, 15),
	(22, 2, 'Monday', 2, 12),
	(23, 2, 'Monday', 4, 20),
	(24, 2, 'Tuesday', 3, 10),
	(25, 2, 'Tuesday', 2, 15),
	(26, 2, 'Tuesday', 4, 18),
    (27, 2, 'Wednesday', 3, 12),
	(28, 2, 'Wednesday', 2, 20),
	(29, 2, 'Wednesday', 4, 13),
	(32, 2, 'Thursday', 3, 18),
	(33, 2, 'Thursday', 2, 20),
	(35, 2, 'Thursday', 4, 16),
	(37, 2, 'Friday', 3, 15),
	(36, 2, 'Friday', 2, 18),
	(30, 2, 'Friday', 4, 12),
    (41, 2, 'Saturday', 3, 12),
	(44, 2, 'Saturday', 2, 20),
	(43, 2, 'Saturday', 4, 15),
    
    (48, 3, 'Monday', 3, 15),
	(50, 3, 'Monday', 2, 12),
	(51, 3, 'Monday', 4, 20),
	(52, 3, 'Tuesday', 3, 10),
	(53, 3, 'Tuesday', 2, 15),
	(54, 3, 'Tuesday', 4, 18),
    (55, 3, 'Wednesday', 3, 12),
	(56, 3, 'Wednesday', 2, 20),
	(57, 3, 'Wednesday', 4, 13),
	(58, 3, 'Thursday', 3, 18),
	(60, 3, 'Thursday', 2, 20),
	(51, 3, 'Thursday', 4, 16),
	(53, 3, 'Friday', 3, 15),
	(55, 3, 'Friday', 2, 18),
	(57, 3, 'Friday', 4, 12),
    (56, 3, 'Saturday', 3, 12),
	(60, 3, 'Saturday', 2, 20),
	(58, 3, 'Saturday', 4, 15);
    
    
  
  
# Diet_plan Table
DROP TABLE IF EXISTS diet_plan;

CREATE TABLE IF NOT EXISTS diet_plan(
	plan_id INT AUTO_INCREMENT PRIMARY KEY,
	plan_type VARCHAR(64)
);

INSERT INTO diet_plan (plan_type) VALUES
('Low Carb'),
('Ketogenic'),
('Vegetarian');


# Diet_plan_description Table
DROP TABLE IF EXISTS diet_plan_description;

CREATE TABLE IF NOT EXISTS diet_plan_description(
	mealtime VARCHAR(64) NOT NULL,
    week_day VARCHAR(64) NOT NULL,
    meal_description VARCHAR(250) NOT NULL,
    calories VARCHAR(64) NOT NULL,
    plan_id INT,
    primary key (plan_id, week_day, mealtime),
    FOREIGN KEY (plan_id) REFERENCES diet_plan(plan_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO diet_plan_description (mealtime, week_day, meal_description, calories, plan_id)
VALUES 
    ('breakfast', 'Monday', 'Scrambled eggs with spinach and mushrooms', '300', 1),
    ('lunch', 'Monday', 'Grilled chicken with roasted vegetables', '400', 1),
    ('dinner', 'Monday', 'Baked salmon with cauliflower rice', '450', 1),
    ('breakfast', 'Tuesday', 'Greek yogurt with berries and almonds', '250', 1),
    ('lunch', 'Tuesday', 'Turkey lettuce wraps with avocado and tomato', '350', 1),
    ('dinner', 'Tuesday', 'Beef stir-fry with broccoli and peppers', '400', 1),
    ('breakfast', 'Wednesday', 'Green smoothie with protein powder', '300', 1),
    ('lunch', 'Wednesday', 'Spinach salad with grilled chicken and feta', '350', 1),
    ('dinner', 'Wednesday', 'Grilled shrimp with zucchini noodles', '400', 1),
    ('breakfast', 'Thursday', 'Baked egg muffins with spinach and cheese', '300', 1),
    ('lunch', 'Thursday', 'Cauliflower crust pizza with vegetables', '400', 1),
    ('dinner', 'Thursday', 'Chicken and vegetable curry with cauliflower rice', '450', 1),
    ('breakfast', 'Friday', 'Almond flour pancakes with berries', '350', 1),
    ('lunch', 'Friday', 'Tuna salad with cucumber and tomato', '300', 1),
    ('dinner', 'Friday', 'Pesto chicken with roasted vegetables', '450', 1),
    ('breakfast', 'Saturday', 'Avocado and egg toast', '300', 1),
    ('lunch', 'Saturday', 'Grilled steak with roasted vegetables', '450', 1),
    ('dinner', 'Saturday', 'Baked cod with asparagus and lemon', '400', 1),
    ('breakfast', 'Sunday', 'Low-carb waffles with bacon and eggs', '400', 1),
    ('lunch', 'Sunday', 'Grilled chicken Caesar salad', '350', 1),
    ('dinner', 'Sunday', 'Beef and vegetable kebabs with tzatziki sauce', '450', 1),
    ('breakfast', 'Monday', 'Scrambled eggs with avocado and bacon', '400', 2),
    ('lunch', 'Monday', 'Tuna salad with mixed greens and olive oil dressing', '500', 2),
    ('dinner', 'Monday', 'Grilled salmon with roasted vegetables', '600', 2),
    ('breakfast', 'Tuesday', 'Keto pancakes with sugar-free syrup', '300', 2),
    ('lunch', 'Tuesday', 'Grilled chicken with broccoli and cauliflower rice', '550', 2),
    ('dinner', 'Tuesday', 'Beef stir-fry with zucchini noodles', '650', 2),
    ('breakfast', 'Wednesday', 'Bacon and cheese omelet with spinach', '450', 2),
    ('lunch', 'Wednesday', 'Cobb salad with ranch dressing', '500', 2),
    ('dinner', 'Wednesday', 'Baked cod with asparagus and lemon butter sauce', '550', 2),
    ('breakfast', 'Thursday', 'Keto smoothie with almond milk and berries', '350', 2),
    ('lunch', 'Thursday', 'Turkey lettuce wraps with avocado and mayo', '450', 2),
    ('dinner', 'Thursday', 'Pork chops with green beans and garlic butter', '600', 2),
    ('breakfast', 'Friday', 'Low-carb muffins with cream cheese', '250', 2),
    ('lunch', 'Friday', 'Salmon burger with avocado and tomato', '550', 2),
    ('dinner', 'Friday', 'Zucchini lasagna with ground beef and cheese', '650', 2),
    ('breakfast', 'Saturday', 'Keto waffles with sugar-free syrup', '400', 2),
	('lunch', 'Saturday', 'Tuna salad with avocado and cucumber', '400', 2),
	('dinner', 'Saturday', 'Grilled steak with mixed vegetables', '600', 2),
	('breakfast', 'Sunday', 'Frittata with sausage and peppers', '500', 2),
	('lunch', 'Sunday', 'Turkey and cheese roll-ups with mixed greens', '450', 2),
	('dinner', 'Sunday', 'Spaghetti squash with meat sauce', '550', 2),
    ('breakfast', 'Monday', 'Grilled potato with spinach and tomatoes', '350', 3),
    ('lunch', 'Monday', 'Grilled portobello mushroom burger with avocado and sweet potato fries', '500', 3),
    ('dinner', 'Monday', 'Roasted vegetables with quinoa and chickpeas', '400', 3),
    ('breakfast', 'Tuesday', 'Chia seed pudding with mixed berries and almond milk', '300', 3),
    ('lunch', 'Tuesday', 'Caprese salad with fresh basil and balsamic vinaigrette', '250', 3),
    ('dinner', 'Tuesday', 'Spaghetti squash with marinara sauce and sautéed mushrooms', '400', 3),
    ('breakfast', 'Wednesday', 'Greek yogurt with honey and walnuts', '250', 3),
    ('lunch', 'Wednesday', 'Vegetable stir-fry with tofu and brown rice', '450', 3),
    ('dinner', 'Wednesday', 'Butternut squash soup with crusty bread', '350', 3),
    ('breakfast', 'Thursday', 'Green smoothie with kale, banana, and almond milk', '300', 3),
    ('lunch', 'Thursday', 'Grilled cheese sandwich with tomato soup', '400', 3),
    ('dinner', 'Thursday', 'Stuffed bell peppers with rice and black beans', '450', 3),
    ('breakfast', 'Friday', 'Avocado toast with cherry tomatoes and feta cheese', '350', 3),
    ('lunch', 'Friday', 'Falafel wrap with hummus and tzatziki sauce', '400', 3),
    ('dinner', 'Friday', 'Eggplant parmesan with mixed greens salad', '500', 3),
    ('breakfast', 'Saturday', 'Mushroom and cheese omelette with whole wheat toast', '400', 3),
    ('lunch', 'Saturday', 'Veggie burger with roasted sweet potato wedges', '450', 3),
    ('dinner', 'Saturday', 'Black bean and vegetable enchiladas with guacamole', '500', 3),
    ('breakfast', 'Sunday', 'Pancakes with maple syrup and fresh fruit', '450', 3),
    ('lunch', 'Sunday', 'Spinach and feta quiche with mixed greens salad', '400', 3),
    ('dinner', 'Sunday', 'Vegetable curry with brown rice and naan bread', '500', 3);


#Client Table
DROP TABLE IF EXISTS clients;

CREATE TABLE IF NOT EXISTS clients(
	client_id VARCHAR(64) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(250) NOT NULL,
    trainer_id VARCHAR(10),
    workout_id INT,
    plan_id INT,
    FOREIGN KEY (trainer_id) REFERENCES trainer(staff_id)
		ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (workout_id) REFERENCES exercise_schedule(workout_id)
		ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (plan_id) REFERENCES diet_plan(plan_id)
		ON UPDATE CASCADE ON DELETE SET NULL
);


INSERT INTO clients (client_id, name, email, phone_number, address, trainer_id, workout_id, plan_id)
VALUES 
	('CL1', 'Jake Paralta', 'jake.paralta@gmail.com', '879-456-1234', '123 Tremont St, Boston, MA 02120', 'TR3', 1, 1),
    ('CL2', 'Ted Mosby', 'ted.mosby@gmail.com', '857-459-1324', '345 Main St, Boston, MA 02122', 'TR4', 3, 2),
    ('CL3', 'Barney Stinson', 'barney.stinson@gmail.com', '567-456-9867', '333 Huntington St, Boston, MA 02110', 'TR2', 2, 3),
    ('CL4', 'Amy Santiago', 'amy.santiago@gmail.com', '223-115-0909', '344 Tremont St, Boston, MA 02120', 'TR1', 3, 1),
    ('CL5', 'Sherlock Homles', 'sherlock.holmes@gmail.com', '111-222-5577', '666 downtown St, Boston, MA 02121', 'TR6', 1, 3),
    ('CL6', 'Peter Parker', 'peter.parker@gmail.com', '443-566-7788', '221 Baker St, Boston, MA 02111', 'TR5', 2, 2);

INSERT INTO clients (client_id, name, email, phone_number, address, trainer_id, workout_id, plan_id)
VALUES
	('CL7', 'Gwen Stacy', 'gwen.stacy@gmail.com', '667-334-1111', '007 Bond St, Boston, MA 02120', 'TR3', 2, 3);

# Health Report Table
DROP TABLE IF EXISTS health_report;

CREATE TABLE IF NOT EXISTS health_report(
	weight FLOAT NOT NULL,
    height VARCHAR(64) NOT NULL,
    bmi FLOAT,
    fat_percentage FLOAT NOT NULL,
    smoking BOOL NOT NULL,
    drinking BOOL NOT NULL,
    surgery BOOL NOT NULL,
    date DATE NOT NULL,
    client_id VARCHAR(64),
    primary key(client_id, date),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);


# Registers Table
DROP TABLE IF EXISTS registers;

CREATE TABLE IF NOT EXISTS registers(
	register_id INT AUTO_INCREMENT PRIMARY KEY,
	manager_id VARCHAR(64),
	branch_id INT,
    client_id VARCHAR(64),
    membership_type VARCHAR(64),
    membership_start_date DATE NOT NULL,
    membership_end_date DATE,
    FOREIGN KEY (manager_id) REFERENCES manager(staff_id)
		ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (client_id) REFERENCES clients(client_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (membership_type) REFERENCES membership_plan(membership_type)
		ON UPDATE CASCADE ON DELETE SET NULL
);


INSERT INTO registers
VALUES 
	(1, 'MA1', 1, 'CL2', 'Gold', '2000-02-20', '2000-05-20'),
    (2, 'MA1', 1, 'CL1', 'Platinum', '2001-02-20', '2002-02-20'),
    (3, 'MA2', 2, 'CL3', 'Silver', '2000-02-20', '2000-08-20'),
    (4, 'MA2', 2, 'CL4', 'Gold', '2000-02-20', '2000-05-20');

