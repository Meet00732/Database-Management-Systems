CREATE DATABASE  IF NOT EXISTS `gym_management_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gym_management_system`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: gym_management_system
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `street_number` varchar(250) NOT NULL,
  `street_name` varchar(150) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `zipcode` int NOT NULL,
  `phone_number` varchar(25) NOT NULL,
  `email` varchar(150) NOT NULL,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `street_number` (`street_number`,`street_name`,`city`,`state`,`zipcode`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,'100','Main St','Boston','MA',2108,'(123) 555-4567','MainStboston@gmail.com'),(2,'200','State St','Boston','MA',2109,'(445) 123-8906','StateStboston@gmail.com'),(3,'300','Beacon St','Boston','MA',2116,'(334) 563-9900','BeaconStboston@gmail.com'),(4,'400','Boylston St','Boston','MA',2116,'(112) 327-8900','BoylstonStboston@gmail.com'),(5,'500','Cambridge St','Boston','MA',2114,'(111) 222-3411','CambridgeStboston@gmail.com');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` varchar(64) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(250) NOT NULL,
  `trainer_id` varchar(10) DEFAULT NULL,
  `workout_id` int DEFAULT NULL,
  `plan_id` int DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  KEY `trainer_id` (`trainer_id`),
  KEY `workout_id` (`workout_id`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`trainer_id`) REFERENCES `trainer` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_2` FOREIGN KEY (`workout_id`) REFERENCES `exercise_schedule` (`workout_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_3` FOREIGN KEY (`plan_id`) REFERENCES `diet_plan` (`plan_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES ('CL1','Jake Paralta','jake.paralta@gmail.com','879-456-1234','123 Tremont St, Boston, MA 02120','TR1',1,1),('CL10','Tony Stark','tony.stark@gmail.com','664-335-0909','344 Tremont St, Boston, MA 02120','TR1',1,1),('CL11','Chris Evans','chris.evans@gmail.com','756-334-5577','666 downtown St, Boston, MA 02121','TR1',1,3),('CL12','Tom Holland','tom.holland@gmail.com','998-888-7788','221 Baker St, Boston, MA 02111','TR1',2,2),('CL13','Gwen Stacy','gwen.stacy@gmail.com','116-221-5577','666 downtown St, Boston, MA 02121','TR1',1,3),('CL14','Ana Armas','ana.armas@gmail.com','667-332-7878','221 Baker St, Boston, MA 02111','TR1',2,2),('CL2','Ted Mosby','ted.mosby@gmail.com','857-459-1324','345 Main St, Boston, MA 02122','TR1',3,2),('CL3','Barney Stinson','barney.stinson@gmail.com','567-456-9867','333 Huntington St, Boston, MA 02110','TR2',2,3),('CL4','Amy Santiago','amy.santiago@gmail.com','223-115-0909','344 Tremont St, Boston, MA 02120','TR1',3,1),('CL5','Sherlock Homles','sherlock.holmes@gmail.com','111-222-5577','666 downtown St, Boston, MA 02121','TR6',1,3),('CL6','Peter Parker','peter.parker@gmail.com','443-566-7788','221 Baker St, Boston, MA 02111','TR1',1,2),('CL7','Tom Cruise','tom.cruise@gmail.com','332-112-1234','123 Tremont St, Boston, MA 02120','TR1',1,1),('CL8','Phil Dundphy','phil.dundphy@gmail.com','111-222-2221','345 Main St, Boston, MA 02122','TR4',3,2),('CL9','Kartik Aaryan','kartik.aaryan@gmail.com','990-873-1254','333 Huntington St, Boston, MA 02110','TR2',2,3);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_in_registers` AFTER INSERT ON `clients` FOR EACH ROW begin
	set @mem_end_date = calculate_membership_end_date(@mem_start_date, @mem_type_p);
    select manager_branch_id into @branch from manager where staff_id = @manager;
	insert into registers(manager_id, branch_id, client_id, membership_type, membership_start_date, membership_end_date) 
    values (@manager, @branch, new.client_id, @mem_type_p, @mem_start_date, @mem_end_date);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `contain`
--

DROP TABLE IF EXISTS `contain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contain` (
  `exercise_id` int NOT NULL,
  `workout_id` int NOT NULL,
  `week_day` varchar(64) NOT NULL,
  `sets` int NOT NULL,
  `reps` int NOT NULL,
  PRIMARY KEY (`workout_id`,`week_day`,`exercise_id`),
  KEY `contain_ibfk_1_idx` (`exercise_id`),
  CONSTRAINT `contain_ibfk_1` FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`exercise_id`),
  CONSTRAINT `contain_ibfk_2` FOREIGN KEY (`workout_id`) REFERENCES `exercise_schedule` (`workout_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contain`
--

LOCK TABLES `contain` WRITE;
/*!40000 ALTER TABLE `contain` DISABLE KEYS */;
INSERT INTO `contain` VALUES (13,1,'Friday',3,15),(14,1,'Friday',2,18),(15,1,'Friday',4,12),(1,1,'Monday',3,15),(2,1,'Monday',2,12),(3,1,'Monday',4,20),(16,1,'Saturday',3,12),(17,1,'Saturday',2,20),(19,1,'Saturday',4,15),(10,1,'Thursday',3,18),(11,1,'Thursday',2,20),(12,1,'Thursday',4,16),(4,1,'Tuesday',3,10),(5,1,'Tuesday',2,15),(6,1,'Tuesday',4,18),(7,1,'Wednesday',3,12),(8,1,'Wednesday',2,20),(9,1,'Wednesday',4,13),(30,2,'Friday',4,12),(36,2,'Friday',2,18),(37,2,'Friday',3,15),(21,2,'Monday',3,15),(22,2,'Monday',2,12),(23,2,'Monday',4,20),(41,2,'Saturday',3,12),(43,2,'Saturday',4,15),(44,2,'Saturday',2,20),(32,2,'Thursday',3,18),(33,2,'Thursday',2,20),(35,2,'Thursday',4,16),(24,2,'Tuesday',3,10),(25,2,'Tuesday',2,15),(26,2,'Tuesday',4,18),(27,2,'Wednesday',3,12),(28,2,'Wednesday',2,20),(29,2,'Wednesday',4,13),(53,3,'Friday',3,15),(55,3,'Friday',2,18),(57,3,'Friday',4,12),(48,3,'Monday',3,15),(50,3,'Monday',2,12),(51,3,'Monday',4,20),(56,3,'Saturday',3,12),(58,3,'Saturday',4,15),(60,3,'Saturday',2,20),(51,3,'Thursday',4,16),(58,3,'Thursday',3,18),(60,3,'Thursday',2,20),(52,3,'Tuesday',3,10),(53,3,'Tuesday',2,15),(54,3,'Tuesday',4,18),(55,3,'Wednesday',3,12),(56,3,'Wednesday',2,20),(57,3,'Wednesday',4,13);
/*!40000 ALTER TABLE `contain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diet_plan`
--

DROP TABLE IF EXISTS `diet_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diet_plan` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `plan_type` varchar(64) NOT NULL,
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diet_plan`
--

LOCK TABLES `diet_plan` WRITE;
/*!40000 ALTER TABLE `diet_plan` DISABLE KEYS */;
INSERT INTO `diet_plan` VALUES (1,'Low Carb'),(2,'Ketogenic'),(3,'Vegetarian');
/*!40000 ALTER TABLE `diet_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diet_plan_description`
--

DROP TABLE IF EXISTS `diet_plan_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diet_plan_description` (
  `mealtime` varchar(64) NOT NULL,
  `week_day` varchar(64) NOT NULL,
  `meal_description` varchar(250) NOT NULL,
  `calories` varchar(64) NOT NULL,
  `plan_id` int NOT NULL,
  PRIMARY KEY (`plan_id`,`week_day`,`mealtime`),
  CONSTRAINT `diet_plan_description_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `diet_plan` (`plan_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diet_plan_description`
--

LOCK TABLES `diet_plan_description` WRITE;
/*!40000 ALTER TABLE `diet_plan_description` DISABLE KEYS */;
INSERT INTO `diet_plan_description` VALUES ('breakfast','Friday','Almond flour pancakes with berries','350',1),('dinner','Friday','Pesto chicken with roasted vegetables','450',1),('lunch','Friday','Tuna salad with cucumber and tomato','300',1),('breakfast','Monday','Scrambled eggs with spinach and mushrooms','300',1),('dinner','Monday','Baked salmon with cauliflower rice','450',1),('lunch','Monday','Grilled chicken with roasted vegetables','400',1),('breakfast','Saturday','Avocado and egg toast','300',1),('dinner','Saturday','Baked cod with asparagus and lemon','400',1),('lunch','Saturday','Grilled steak with roasted vegetables','450',1),('breakfast','Sunday','Low-carb waffles with bacon and eggs','400',1),('dinner','Sunday','Beef and vegetable kebabs with tzatziki sauce','450',1),('lunch','Sunday','Grilled chicken Caesar salad','350',1),('breakfast','Thursday','Baked egg muffins with spinach and cheese','300',1),('dinner','Thursday','Chicken and vegetable curry with cauliflower rice','450',1),('lunch','Thursday','Cauliflower crust pizza with vegetables','400',1),('breakfast','Tuesday','Greek yogurt with berries and almonds','250',1),('dinner','Tuesday','Beef stir-fry with broccoli and peppers','400',1),('lunch','Tuesday','Turkey lettuce wraps with avocado and tomato','350',1),('breakfast','Wednesday','Green smoothie with protein powder','300',1),('dinner','Wednesday','Grilled shrimp with zucchini noodles','400',1),('lunch','Wednesday','Spinach salad with grilled chicken and feta','350',1),('breakfast','Friday','Low-carb muffins with cream cheese','250',2),('dinner','Friday','Zucchini lasagna with ground beef and cheese','650',2),('lunch','Friday','Salmon burger with avocado and tomato','550',2),('breakfast','Monday','Scrambled eggs with avocado and bacon','400',2),('dinner','Monday','Grilled salmon with roasted vegetables','600',2),('lunch','Monday','Tuna salad with mixed greens and olive oil dressing','500',2),('breakfast','Saturday','Keto waffles with sugar-free syrup','400',2),('dinner','Saturday','Grilled steak with mixed vegetables','600',2),('lunch','Saturday','Tuna salad with avocado and cucumber','400',2),('breakfast','Sunday','Frittata with sausage and peppers','500',2),('dinner','Sunday','Spaghetti squash with meat sauce','550',2),('lunch','Sunday','Turkey and cheese roll-ups with mixed greens','450',2),('breakfast','Thursday','Keto smoothie with almond milk and berries','350',2),('dinner','Thursday','Pork chops with green beans and garlic butter','600',2),('lunch','Thursday','Turkey lettuce wraps with avocado and mayo','450',2),('breakfast','Tuesday','Keto pancakes with sugar-free syrup','300',2),('dinner','Tuesday','Beef stir-fry with zucchini noodles','650',2),('lunch','Tuesday','Grilled chicken with broccoli and cauliflower rice','550',2),('breakfast','Wednesday','Bacon and cheese omelet with spinach','450',2),('dinner','Wednesday','Baked cod with asparagus and lemon butter sauce','550',2),('lunch','Wednesday','Cobb salad with ranch dressing','500',2),('breakfast','Friday','Avocado toast with cherry tomatoes and feta cheese','350',3),('dinner','Friday','Eggplant parmesan with mixed greens salad','500',3),('lunch','Friday','Falafel wrap with hummus and tzatziki sauce','400',3),('breakfast','Monday','Grilled potato with spinach and tomatoes','350',3),('dinner','Monday','Roasted vegetables with quinoa and chickpeas','400',3),('lunch','Monday','Grilled portobello mushroom burger with avocado and sweet potato fries','500',3),('breakfast','Saturday','Mushroom and cheese omelette with whole wheat toast','400',3),('dinner','Saturday','Black bean and vegetable enchiladas with guacamole','500',3),('lunch','Saturday','Veggie burger with roasted sweet potato wedges','450',3),('breakfast','Sunday','Pancakes with maple syrup and fresh fruit','450',3),('dinner','Sunday','Vegetable curry with brown rice and naan bread','500',3),('lunch','Sunday','Spinach and feta quiche with mixed greens salad','400',3),('breakfast','Thursday','Green smoothie with kale, banana, and almond milk','300',3),('dinner','Thursday','Stuffed bell peppers with rice and black beans','450',3),('lunch','Thursday','Grilled cheese sandwich with tomato soup','400',3),('breakfast','Tuesday','Chia seed pudding with mixed berries and almond milk','300',3),('dinner','Tuesday','Spaghetti squash with marinara sauce and sautéed mushrooms','400',3),('lunch','Tuesday','Caprese salad with fresh basil and balsamic vinaigrette','250',3),('breakfast','Wednesday','Greek yogurt with honey and walnuts','250',3),('dinner','Wednesday','Butternut squash soup with crusty bread','350',3),('lunch','Wednesday','Vegetable stir-fry with tofu and brown rice','450',3);
/*!40000 ALTER TABLE `diet_plan_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int NOT NULL AUTO_INCREMENT,
  `equipment_name` varchar(100) NOT NULL,
  `equipment_description` varchar(250) NOT NULL,
  PRIMARY KEY (`equipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (101,'Treadmill','A cardio machine that simulates running or walking in place'),(102,'Stationary bike','A bike that stays in one place while you pedal it'),(103,'Elliptical','A cardio machine that combines aspects of running, cycling, and climbing'),(104,'Rowing machine','A machine that simulates the motion of rowing a boat'),(105,'Weight bench','A bench designed for weight training exercises'),(106,'Dumbbells','Free weights that are used for strength training'),(107,'Barbell','A long metal bar used for weightlifting exercises'),(108,'Squat rack','A piece of equipment used for exercises like squats and bench presses'),(109,'Leg press machine','A machine used for leg strengthening exercises'),(110,'Stair climber','A cardio machine that simulates climbing stairs'),(111,'Spin bike','A stationary bike used for indoor cycling classes'),(112,'Resistance bands','Elastic bands used for resistance training'),(113,'Jump rope','A simple piece of equipment used for cardio and coordination training'),(114,'Plyo box','A box used for plyometric exercises like box jumps'),(115,'Kettlebell','A type of weight used for functional fitness exercises');
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise`
--

DROP TABLE IF EXISTS `exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise` (
  `exercise_id` int NOT NULL AUTO_INCREMENT,
  `exercise_name` varchar(64) NOT NULL,
  `exercise_description` varchar(150) NOT NULL,
  PRIMARY KEY (`exercise_id`),
  UNIQUE KEY `exercise_name` (`exercise_name`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise`
--

LOCK TABLES `exercise` WRITE;
/*!40000 ALTER TABLE `exercise` DISABLE KEYS */;
INSERT INTO `exercise` VALUES (1,'Treadmill','A workout where you run or walk on a moving platform.'),(2,'Elliptical','A workout where you simulate running, walking, or climbing stairs.'),(3,'Stationary Bike','A workout where you cycle on a stationary bike.'),(4,'Stair Climber','A workout where you climb stairs on a machine.'),(5,'Rowing Machine','A workout where you simulate rowing on a machine.'),(6,'Jumping Jacks','A workout where you jump and spread your legs and arms.'),(7,'Jump Rope','A workout where you jump over a rope as it swings under your feet.'),(8,'High Knees','A workout where you jog in place, lifting your knees as high as you can.'),(9,'Mountain Climbers','A workout where you get into a push-up position and alternately bring your knees toward your chest.'),(10,'Sprints','A workout where you run as fast as you can for a short distance.'),(11,'Jogging','A workout where you run at a moderate pace.'),(12,'Hiking','A workout where you walk up and down hills and trails.'),(13,'Cycling','A workout where you cycle outdoors on a bike.'),(14,'Jumping Squats','A workout where you squat down and jump up.'),(15,'Plyometric Lunges','A workout where you alternate lunges with jumping.'),(16,'Jumping Lunges','A workout where you jump and alternate lunges.'),(17,'Jumping Jack Squats','A workout where you do a combination of jumping jacks and squats.'),(18,'Jumping Jack Burpees','A workout where you do a combination of jumping jacks and burpees.'),(19,'Jumping Jack High Knees','A workout where you do a combination of jumping jacks and high knees.'),(20,'Jumping Jack Mountain Climbers','A workout where you do a combination of jumping jacks and mountain climbers.'),(21,'Bicep Curl','Strength training exercise for biceps muscles'),(22,'Deadlift','Strength training exercise for back and leg muscles'),(23,'Squat','Strength training exercise for leg muscles'),(24,'Bench Press','Strength training exercise for chest muscles'),(25,'Pull-up','Strength training exercise for back and arm muscles'),(26,'Tricep Extension','Strength training exercise for triceps muscles'),(27,'Lateral Raise','Strength training exercise for shoulder muscles'),(28,'Crunches','Strength training exercise for abs muscles'),(29,'Leg Press','Strength training exercise for leg muscles'),(30,'Push-up','Strength training exercise for chest, shoulder, and arm muscles'),(31,'Dumbbell Fly','Strength training exercise for chest muscles'),(32,'Hammer Curl','Strength training exercise for biceps muscles'),(33,'Calf Raise','Strength training exercise for calf muscles'),(34,'Reverse Fly','Strength training exercise for back and shoulder muscles'),(35,'Russian Twist','Strength training exercise for abs muscles'),(36,'Dumbbell Row','Strength training exercise for back muscles'),(37,'Overhead Press','Strength training exercise for shoulder muscles'),(38,'Leg Curl','Strength training exercise for leg muscles'),(39,'Dumbbell Pullover','Strength training exercise for chest and back muscles'),(40,'Dumbbell Squat','Strength training exercise for leg muscles'),(41,'Dumbbell Lunges','Strength training exercise for leg muscles'),(42,'Seated Cable Row','Strength training exercise for back muscles'),(43,'Tricep Pushdown','Strength training exercise for triceps muscles'),(44,'Cable Curl','Strength training exercise for biceps muscles'),(45,'Incline Press','Strength training exercise for upper chest muscles'),(46,'Kettlebell Swing','Strengthens the posterior chain and improves cardiovascular endurance'),(47,'Turkish Get-Up','Full-body functional exercise that improves stability, mobility and coordination'),(48,'Medicine Ball Slam','Explosive exercise that improves power and cardiovascular fitness'),(49,'Battle Rope Wave','Total body exercise that improves muscular endurance and cardiovascular fitness'),(50,'Box Jump','Plyometric exercise that improves lower body power and explosiveness'),(51,'Burpee','Full-body exercise that improves cardiovascular fitness and muscular endurance'),(52,'Sandbag Clean and Press','Total body exercise that improves power and functional strength'),(53,'TRX Suspension Trainer Row','Improves upper back and shoulder strength and stability'),(54,'Boxing','Improves cardiovascular fitness and coordination'),(55,'Sled Push/Pull','Full-body exercise that improves power and functional strength'),(56,'Agility Ladder Drills','Improves footwork, speed and coordination'),(57,'Squat to Overhead Press','Total body exercise that improves power and functional strength'),(58,'Dumbbell Snatch','Total body exercise that improves power and functional strength'),(59,'Farmers Walk','Improves grip strength, core stability and functional strength'),(60,'Tire Flip','Total body exercise that improves power and functional strength');
/*!40000 ALTER TABLE `exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_schedule`
--

DROP TABLE IF EXISTS `exercise_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_schedule` (
  `workout_id` int NOT NULL AUTO_INCREMENT,
  `workout_type` varchar(64) NOT NULL,
  PRIMARY KEY (`workout_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_schedule`
--

LOCK TABLES `exercise_schedule` WRITE;
/*!40000 ALTER TABLE `exercise_schedule` DISABLE KEYS */;
INSERT INTO `exercise_schedule` VALUES (1,'Cardio'),(2,'Strength Training'),(3,'Functional Training');
/*!40000 ALTER TABLE `exercise_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `health_report`
--

DROP TABLE IF EXISTS `health_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health_report` (
  `age` int NOT NULL,
  `weight` float NOT NULL,
  `height` varchar(64) NOT NULL,
  `bmi` float DEFAULT NULL,
  `fat_percentage` float NOT NULL,
  `smoking` tinyint(1) NOT NULL,
  `drinking` tinyint(1) NOT NULL,
  `surgery` tinyint(1) NOT NULL,
  `date` date NOT NULL,
  `client_id` varchar(64) NOT NULL,
  PRIMARY KEY (`client_id`,`date`),
  CONSTRAINT `health_report_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_report`
--

LOCK TABLES `health_report` WRITE;
/*!40000 ALTER TABLE `health_report` DISABLE KEYS */;
INSERT INTO `health_report` VALUES (25,68.5,'170 cm',23.6,18.5,0,1,0,'2022-03-01','CL1'),(35,85.6,'180 cm',26.5,22.7,1,1,0,'2022-03-15','CL2'),(30,72.1,'172 cm',24.4,19.2,1,0,0,'2022-03-05','CL3'),(28,63.2,'165 cm',23.2,17.6,0,1,1,'2022-03-20','CL3'),(40,80,'175 cm',26.1,21.8,0,0,1,'2022-03-10','CL4');
/*!40000 ALTER TABLE `health_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_credentials`
--

DROP TABLE IF EXISTS `login_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_credentials` (
  `userid` varchar(10) NOT NULL,
  `passwd` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_credentials`
--

LOCK TABLES `login_credentials` WRITE;
/*!40000 ALTER TABLE `login_credentials` DISABLE KEYS */;
INSERT INTO `login_credentials` VALUES ('CL1','CL1PASS'),('CL4','CL4PASS'),('MA1','MA1PASS'),('TR1','TR1PASS');
/*!40000 ALTER TABLE `login_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `staff_id` varchar(10) NOT NULL,
  `staff_name` varchar(100) NOT NULL,
  `contact_number` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `address` varchar(150) NOT NULL,
  `shift_start_time` time NOT NULL,
  `shift_end_time` time NOT NULL,
  `salary` int NOT NULL,
  `manager_branch_id` int NOT NULL,
  `start_date` date NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `contact_number` (`contact_number`),
  UNIQUE KEY `email` (`email`),
  KEY `manager_branch_id` (`manager_branch_id`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`manager_branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ch_2` CHECK (((timediff(`shift_end_time`,`shift_start_time`) <= _utf8mb4'09:00:00') and (timediff(`shift_end_time`,`shift_start_time`) >= _utf8mb4'05:00:00')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES ('MA1','Jane Doe','617-123-4567','jane.doe@example.com','789 Elm St, Boston USA','09:00:00','18:00:00',90000,1,'2021-12-01'),('MA2','Michael Chen','617-234-5678','michael.chen@example.com','321 Maple Ave, Boston USA','08:00:00','17:00:00',95000,2,'2022-01-15'),('MA3','Karen Lee','617-345-6789','karen.lee@example.com','456 Pine St, Boston USA','10:00:00','19:00:00',85000,3,'2022-02-01'),('MA4','David Kim','617-456-7890','david.kim@example.com','987 Oak Rd, Boston USA','07:00:00','16:00:00',100000,4,'2022-03-15'),('MA5','Emily Chang','617-567-8901','emily.chang@example.com','654 Cedar Blvd, Boston USA','08:30:00','17:30:00',92000,5,'2022-04-01');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_plan`
--

DROP TABLE IF EXISTS `membership_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_plan` (
  `membership_type` varchar(64) NOT NULL,
  `fees` int NOT NULL,
  `duration` int NOT NULL,
  PRIMARY KEY (`membership_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_plan`
--

LOCK TABLES `membership_plan` WRITE;
/*!40000 ALTER TABLE `membership_plan` DISABLE KEYS */;
INSERT INTO `membership_plan` VALUES ('Gold',4500,6),('Platinum',6000,12),('Silver',2000,3);
/*!40000 ALTER TABLE `membership_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registers`
--

DROP TABLE IF EXISTS `registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registers` (
  `register_id` int NOT NULL AUTO_INCREMENT,
  `manager_id` varchar(64) NOT NULL,
  `branch_id` int NOT NULL,
  `client_id` varchar(64) NOT NULL,
  `membership_type` varchar(64) DEFAULT NULL,
  `membership_start_date` date NOT NULL,
  `membership_end_date` date DEFAULT NULL,
  PRIMARY KEY (`register_id`),
  KEY `manager_id` (`manager_id`),
  KEY `branch_id` (`branch_id`),
  KEY `membership_type` (`membership_type`),
  KEY `registers_ibfk_3_idx` (`client_id`),
  CONSTRAINT `registers_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`staff_id`) ON UPDATE CASCADE,
  CONSTRAINT `registers_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `registers_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  CONSTRAINT `registers_ibfk_4` FOREIGN KEY (`membership_type`) REFERENCES `membership_plan` (`membership_type`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registers`
--

LOCK TABLES `registers` WRITE;
/*!40000 ALTER TABLE `registers` DISABLE KEYS */;
INSERT INTO `registers` VALUES (1,'MA1',1,'CL2','Gold','2002-02-20','2002-08-20'),(2,'MA1',1,'CL1','Platinum','2001-02-20','2001-02-20'),(3,'MA2',2,'CL3','Silver','2002-02-06','2002-05-20'),(4,'MA2',2,'CL4','Gold','2002-02-20','2002-08-20'),(5,'MA1',1,'CL5','Silver','2002-01-06','2002-04-06'),(6,'MA1',1,'CL6','Gold','2001-02-07','2001-08-07'),(7,'MA1',1,'CL7','Silver','2001-03-12','2001-06-12'),(8,'MA1',1,'CL8','Gold','2000-05-15','2000-11-15'),(9,'MA1',1,'CL9','Silver','2001-01-20','2001-04-20'),(10,'MA1',1,'CL10','Gold','2002-02-23','2002-05-23'),(11,'MA1',1,'CL11','Silver','2001-06-26','2001-09-26'),(12,'MA1',1,'CL12','Gold','2000-02-20','2000-08-20'),(13,'MA1',1,'CL13','Silver','2000-07-29','2000-10-29'),(14,'MA1',1,'CL14','Gold','2000-04-14','2000-10-14');
/*!40000 ALTER TABLE `registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainer`
--

DROP TABLE IF EXISTS `trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainer` (
  `staff_id` varchar(10) NOT NULL,
  `staff_name` varchar(100) NOT NULL,
  `contact_number` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `address` varchar(150) NOT NULL,
  `shift_start_time` time NOT NULL,
  `shift_end_time` time NOT NULL,
  `salary` int NOT NULL,
  `specialization` varchar(250) NOT NULL,
  `years_of_experience` int NOT NULL,
  `trainer_branch_id` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `contact_number` (`contact_number`),
  UNIQUE KEY `email` (`email`),
  KEY `trainer_branch_id` (`trainer_branch_id`),
  CONSTRAINT `trainer_ibfk_1` FOREIGN KEY (`trainer_branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ch_1` CHECK (((timediff(`shift_end_time`,`shift_start_time`) <= _utf8mb4'08:00:00') and (timediff(`shift_end_time`,`shift_start_time`) >= _utf8mb4'05:00:00')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainer`
--

LOCK TABLES `trainer` WRITE;
/*!40000 ALTER TABLE `trainer` DISABLE KEYS */;
INSERT INTO `trainer` VALUES ('TR1','Meet Patel','234-555-1234','Meet.patel@example.com','123 Main St, Boston, MA 02108','08:00:00','16:00:00',50000,'Weight Lifting',5,1),('TR10','Lisa Kim','857-555-2345','lisa.kim@example.com','400 2nd St, Boston, CA 02115','14:00:00','22:00:00',65000,'Crossfit',10,5),('TR2','Mihir Chitre','278-555-5678','Mihir.chitre@example.com','456 Market St, Boston, CA 02108','12:00:00','20:00:00',60000,'Yoga',8,2),('TR3','Aditya Gurnani','099-555-9012','Aditya.gurnani@example.com','789 Elm St, Boston, IL 02116','09:00:00','17:00:00',55000,'Cardio',6,3),('TR4','Shashank Patel','678-555-3457','Shashank.patel@example.com','100 Fifth Ave, Boston, NY 02116','10:00:00','18:00:00',65000,'Pilates',10,4),('TR5','Krishi Panchal','111-555-7891','Krishi.panchal@example.com','200 Main St, Boston, TX 02109','07:00:00','15:00:00',45000,'Crossfit',3,5),('TR6','Pratik Poojari','673-555-2346','Pratik.poojari@example.com','1000 Main St, Boston, MA 02109','13:00:00','21:00:00',70000,'Spinning',9,2),('TR7','David Kim','857-555-6789','david.kim@example.com','500 1st St, Boston, WA 02114','11:00:00','19:00:00',60000,'Boxing',7,1),('TR8','Jennifer Aniston','857-555-3456','jennifer.aniston@example.com','700 Maple Ave, Boston, TX 02114','08:00:00','16:00:00',50000,'Zumba',5,4),('TR9','Brian Jones','857-555-7890','brian.jones@example.com','100 Park Ave, Boston, NY 02115','09:00:00','17:00:00',55000,'Martial Arts',6,3);
/*!40000 ALTER TABLE `trainer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `used_in`
--

DROP TABLE IF EXISTS `used_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `used_in` (
  `equipment_id` int NOT NULL,
  `exercise_id` int NOT NULL,
  PRIMARY KEY (`equipment_id`,`exercise_id`),
  KEY `used_in_ibfk_2_idx` (`exercise_id`),
  CONSTRAINT `used_in_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `used_in_ibfk_2` FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`exercise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `used_in`
--

LOCK TABLES `used_in` WRITE;
/*!40000 ALTER TABLE `used_in` DISABLE KEYS */;
INSERT INTO `used_in` VALUES (101,1),(102,2),(102,3),(103,3),(104,4),(105,5),(106,6),(108,6),(107,7),(108,8),(109,9),(101,10),(103,10),(110,10),(101,11),(104,11),(101,12),(102,12),(103,12),(104,12),(105,12),(108,15),(106,16),(106,18),(110,18),(107,20),(109,20),(109,48),(107,49),(110,50);
/*!40000 ALTER TABLE `used_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'gym_management_system'
--

--
-- Dumping routines for database 'gym_management_system'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_bmi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_bmi`(height_p FLOAT, weight_p FLOAT) RETURNS float
    READS SQL DATA
    DETERMINISTIC
BEGIN
		DECLARE bmi_var FLOAT;
        SET bmi_var = (weight_p / (height_p*height_p));
	RETURN bmi_var;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calculate_membership_end_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_membership_end_date`(start_date_p DATE, membership_type_p VARCHAR(64)) RETURNS date
    MODIFIES SQL DATA
    DETERMINISTIC
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
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_credentials` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_credentials`(IN userid_p VARCHAR(10), IN passwd_p VARCHAR(20))
BEGIN
	SELECT userid FROM login_credentials WHERE userid = userid_p AND passwd = passwd_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_health_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_health_report`(IN age_p INT, IN weight_p FLOAT, IN height_p FLOAT, IN fat_percentage_p FLOAT, IN smoking_p BOOL, 
										IN drinking_p BOOL, IN surgery_p BOOL, IN date_p DATE, IN client_id_p VARCHAR(64))
BEGIN
		DECLARE bmi_var FLOAT4;
        SET bmi_var = calculate_bmi(height_p, weight_p);
        
        INSERT INTO health_report
			VALUES (age_p, weight_p, ROUND(height_p,1), ROUND(bmi_var,2), fat_percentage_p, smoking_p, drinking_p, surgery_p, date_p, client_id_p);

    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_create_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_create_client`(IN client_id_p VARCHAR(64), IN name_p VARCHAR(150), IN email_p VARCHAR(150), 
										IN phone_number_p VARCHAR(20), IN address_p VARCHAR(250), IN trainer_id_p VARCHAR(64),
                                        IN workout_id_p VARCHAR(64), IN plan_id_p VARCHAR(64), IN mem_start_date_p date, IN mem_type_p varchar(64),
                                        IN manager_id_p varchar(64))
BEGIN
		DECLARE cl_var VARCHAR(64);
		SELECT client_id INTO cl_var FROM clients
			WHERE client_id = client_id_p;
        
        IF cl_var IS NULL THEN
			IF EXISTS(Select a.staff_id from trainer as a join manager as b on a.trainer_branch_id = b.manager_branch_id where 
					a.staff_id = trainer_id_p and b.staff_id = manager_id_p) then
						set @mem_start_date = mem_start_date_p;
						set @mem_type_p = mem_type_p;
						set @manager = manager_id_p;
							INSERT INTO clients
								VALUES (client_id_p, name_p, email_p, phone_number_p, address_p, trainer_id_p, workout_id_p, plan_id_p);
						ELSE
							SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Given trainer Id does not exist in your branch.';
						END IF;
			else
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Client_id Already Exists.';
			end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_delete_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_delete_client`(IN client_id_p VARCHAR(64))
BEGIN 
		DECLARE id VARCHAR(64);
        
        SELECT client_id INTO id FROM clients
			WHERE client_id = client_id_p;
            
        IF id IS NOT NULL THEN
			DELETE FROM clients
				WHERE client_id = client_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Client Id Does Not Exists';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_update_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_update_client`(IN client_id_p VARCHAR(64), IN col_name_p VARCHAR(200), IN val_p VARCHAR(200))
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
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_update_trainer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_update_trainer`(IN trainer_id_p VARCHAR(64), IN col_name_p VARCHAR(200), IN val_p VARCHAR(200))
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
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_view_all_clients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_view_all_clients`(IN manager_id_p VARCHAR(64))
BEGIN
		DECLARE manager_var VARCHAR(64);
        
        SELECT staff_name INTO manager_var FROM manager 
			WHERE staff_id = manager_id_p;
		
        IF manager_var IS NOT NULL THEN    
			SELECT c.client_id, c.name, c.email, c.phone_number, c.address, t.staff_name AS trainer_name FROM registers r
				JOIN manager m
					ON m.manager_branch_id = r.branch_id
				JOIN clients c
					ON r.client_id = c.client_id
				JOIN trainer t
					ON t.staff_id = c.trainer_id
			WHERE r.manager_id = manager_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Manager_Id Found!';
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_view_all_trainers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_view_all_trainers`(IN manager_id_p VARCHAR(64))
BEGIN
		SELECT t.* FROM manager m
			JOIN trainer t
				ON m.manager_branch_id = t.trainer_branch_id
		WHERE m.staff_id = manager_id_p;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_view_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_view_client`(IN manager_id_p VARCHAR(64), IN client_id_p VARCHAR(64))
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
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_view_trainers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_view_trainers`(IN manager_id_p VARCHAR(64), IN trainer_id_p VARCHAR(64))
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_visualize_membership_plan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_visualize_membership_plan`(IN staff_id_p VARCHAR(64))
BEGIN
		DECLARE id VARCHAR(64);
        
        SELECT staff_id INTO id FROM manager
			WHERE staff_id = staff_id_p;
            
		IF id IS NOT NULL THEN
			SELECT client_id, membership_type FROM registers
				WHERE manager_id = staff_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Manager_Id Does Not Exist';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_creates_equipment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_creates_equipment`(IN equipment_name_p VARCHAR(100), IN equipment_description_p VARCHAR(250))
BEGIN
		DECLARE id INT;
        DECLARE name VARCHAR(100);
            
		SELECT equipment_name INTO name FROM equipment
			WHERE equipment_name = equipment_name_p;
            
		IF name IS NULL THEN
			INSERT INTO equipment(equipment_name, equipment_description) VALUES (equipment_name_p, equipment_description_p);
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Equipment_Name Already Exists';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_create_contain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_create_contain`(IN exercise_id_p INT, IN workout_id_p INT, IN week_day_p VARCHAR(64), 
										IN sets_p INT, IN reps_p INT)
BEGIN
		DECLARE e_id, w_id INT;
        DECLARE week_day_m VARCHAR(64);
        
        SELECT workout_id INTO w_id FROM exercise_schedule
			WHERE workout_id = workout_id_p;
		
        SELECT exercise_id INTO e_id FROM exercise
			WHERE exercise_id = exercise_id_p;
        
        SELECT DISTINCT week_day INTO week_day_m FROM diet_plan_description
			WHERE week_day = week_day_p;
            
		IF w_id IS NOT NULL AND e_id IS NOT NULL AND week_day_m IS NOT NULL THEN
			IF EXISTS (SELECT * FROM contain 
						WHERE workout_id = w_id AND exercise_id = e_id AND week_day = week_day_m) THEN 
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Duplicate Entry Found!';
			ELSE
				INSERT INTO contain VALUES(exercise_id_p, workout_id_p, week_day_p, sets_p, reps_p);
			END IF;
        ELSE
			IF w_id IS NULL THEN	
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Workout_Id Does Not Exists';
			ELSE
				IF e_id IS NULL THEN
					SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise_Id Does Not Exists';
				ELSE
					SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Weekday Does Not Exists';
				END IF;
			END IF;
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_create_diet_plan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_create_diet_plan`(IN plan_type_p VARCHAR(150))
BEGIN
		DECLARE plan_type_var VARCHAR(150);
        
        SELECT plan_type INTO plan_type_var FROM diet_plan 
			WHERE plan_type = plan_type_p;
		
        IF plan_type_var IS NULL THEN
			INSERT INTO diet_plan(plan_type) VALUES(plan_type_p);
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Plan Already Exists';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_create_diet_plan_description` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_create_diet_plan_description`(IN mealtime_p VARCHAR(64), IN week_day_p VARCHAR(64), IN meal_description_p VARCHAR(250),
													IN calories_p VARCHAR(64), IN plan_id_p INT)
BEGIN
		DECLARE plan_id_var INT;
        
        SELECT plan_id INTO plan_id_var FROM diet_plan 
			WHERE plan_id = plan_id_p;
		
        IF plan_id_var IS NOT NULL THEN
			if exists(select * from diet_plan_description where plan_id = plan_id_p and week_day = week_day_p and mealtime = mealtime_p) then
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'This diet plan schedule already exists, you can update it.';
            else
				INSERT INTO diet_plan_description VALUES(mealtime_p, week_day_p, meal_description_p,
												calories_p, plan_id_p);
			end if;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Plan Does not Exists';
		END IF;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_create_exercise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_create_exercise`(IN exercise_name_p VARCHAR(64), exercise_description_p VARCHAR(150))
BEGIN
		DECLARE id INT;
        DECLARE name VARCHAR(64);
		
        SELECT exercise_name INTO name FROM exercise
			WHERE exercise_name = exercise_name_p;
		
        IF name IS NULL THEN
			INSERT INTO exercise(exercise_name, exercise_description) VALUES (exercise_name_p, exercise_description_p);
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise Already Exists';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_create_exercise_schedule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_create_exercise_schedule`(IN workout_type_p VARCHAR(64))
BEGIN
		DECLARE workout_var VARCHAR(64);
        
        SELECT workout_type INTO workout_var FROM exercise_schedule
			WHERE workout_type = workout_type_p;
		
        IF workout_var IS NULL THEN
			INSERT INTO exercise_schedule(workout_type) VALUES (workout_type_p);
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Workout_Type Already Exists';
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_create_used_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_create_used_in`(IN equipment_id_p INT, IN exercise_id_p INT)
BEGIN 
		DECLARE eq_id, e_id INT;
        
        SELECT exercise_id INTO e_id FROM exercise
			WHERE exercise_id = exercise_id_p;
		
        SELECT equipment_id INTO eq_id FROM equipment
			WHERE equipment_id = equipment_id_p;
            
		IF e_id IS NOT NULL AND eq_id IS NOT NULL THEN
			IF EXISTS (SELECT * FROM used_in 
						WHERE equipment_id = eq_id AND exercise_id = e_id) THEN
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Equipment already assigned to this exercise!';
			ELSE
				INSERT INTO used_in VALUES(equipment_id_p, exercise_id_p);
			END IF;
		ELSE
			IF e_id IS NULL THEN
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise Id Does Not Exists';
			ELSE
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Equipment Id Does Not Exists';
			END IF;
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_contain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_contain`(IN exercise_id_p INT, IN workout_id_p INT, IN week_day_p VARCHAR(64))
BEGIN
		DECLARE e_id, w_id INT;
        DECLARE week_day_m VARCHAR(64);
        
        SELECT workout_id INTO w_id FROM exercise_schedule
			WHERE workout_id = workout_id_p;
		
        SELECT exercise_id INTO e_id FROM exercise
			WHERE exercise_id = exercise_id_p;
        
        SELECT DISTINCT week_day INTO week_day_m FROM diet_plan_description
			WHERE week_day = week_day_p;
            
		IF w_id IS NOT NULL AND e_id IS NOT NULL AND week_day_m IS NOT NULL THEN
			IF EXISTS (SELECT * FROM contain 
						WHERE workout_id = w_id AND exercise_id = e_id AND week_day = week_day_m) THEN 
				delete from contain where exercise_id = exercise_id_p and workout_id = workout_id_p and week_day = week_day_p;
			ELSE				
                SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Schedule record not found!';
			END IF;
        ELSE
			IF w_id IS NULL THEN	
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Workout_Id Does Not Exists';
			ELSE
				IF e_id IS NULL THEN
					SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise_Id Does Not Exists';
				ELSE
					SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Weekday Does Not Exists';
				END IF;
			END IF;
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_diet_plan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_diet_plan`(IN plan_id_p INT)
BEGIN
		DECLARE id INT;
        
        SELECT plan_id INTO id FROM diet_plan
			WHERE plan_id = plan_id_p;
		
        IF id IS NOT NULL THEN
			DELETE FROM diet_plan
				WHERE plan_id = plan_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Plan Id Does Not Exists';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_diet_plan_description` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_diet_plan_description`(IN plan_id_p INT, IN mealtime_p VARCHAR(64), IN week_day_p VARCHAR(64))
BEGIN
		DECLARE id INT;
        DECLARE mealtime_m, week_day_m VARCHAR(64);
		
        SELECT DISTINCT plan_id INTO id FROM diet_plan_description
			WHERE plan_id = plan_id_p;
            
		SELECT DISTINCT mealtime INTO mealtime_m FROM diet_plan_description
			WHERE mealtime = mealtime_p;
            
		SELECT DISTINCT week_day INTO week_day_m FROM diet_plan_description
			WHERE week_day = week_day_p;
            
		IF id IS NOT NULL AND mealtime_m IS NOT NULL AND week_day_m IS NOT NULL THEN
			DELETE FROM diet_plan_description
				WHERE plan_id = plan_id_p AND mealtime = mealtime_p AND week_day = week_day_p;
		ELSE
			IF id IS NULL THEN 
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Plan Id Does Not Exists';
			ELSE
				IF mealtime_m IS NULL THEN
					SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Mealtime Does Not Exists';
				ELSE
					SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Week Day Does Not Exists';
				END IF;
			END IF;
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_equipment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_equipment`(IN equipment_id_p INT)
BEGIN
		DECLARE id INT;
        
        SELECT equipment_id INTO id FROM equipment
			WHERE equipment_id = equipment_id_p;
		
        IF id IS NOT NULL THEN
			DELETE FROM equipment
				WHERE equipment_id = equipment_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Equipment_Id Does Not Exists';
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_exercise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_exercise`(IN exercise_id_p INT)
BEGIN
		DECLARE id INT;
        
        SELECT exercise_id INTO id FROM exercise
			WHERE exercise_id = exercise_id_p;
		
        IF id IS NOT NULL THEN
			DELETE FROM exercise
				WHERE exercise_id = exercise_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise_Id Does Not Exists';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_exercise_schedule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_exercise_schedule`(IN workout_id_p INT)
BEGIN
		DECLARE id INT;
        
        SELECT workout_id INTO id FROM exercise_schedule
			WHERE workout_id = workout_id_p;
		
        IF id IS NOT NULL THEN
			DELETE FROM exercise_schedule
				WHERE workout_id = workout_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Workout_Id Does Not Exists';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_health_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_health_report`(IN client_id_p VARCHAR(64), IN date_p DATE)
BEGIN
		DECLARE id VARCHAR(64);
        DECLARE date_m DATE;
        
        SELECT DISTINCT client_id INTO id FROM health_report
			WHERE client_id = client_id_p;
            
		SELECT date INTO date_m FROM health_report
			WHERE date = date_p;
		
        IF id IS NOT NULL AND date_m IS NOT NULL THEN
			DELETE FROM health_report
				WHERE client_id = client_id_p AND date = date_p;
		ELSE
			IF id IS NULL THEN
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Client Id Does Not Exists';
			ELSE
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Date Does Not Exists';
			END IF;
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_delete_used_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_delete_used_in`(IN equipment_id_p INT, IN exercise_id_p INT)
BEGIN 
		DECLARE eq_id, e_id INT;
        
        SELECT exercise_id INTO e_id FROM exercise
			WHERE exercise_id = exercise_id_p;
		
        SELECT equipment_id INTO eq_id FROM equipment
			WHERE equipment_id = equipment_id_p;
            
		IF e_id IS NOT NULL AND eq_id IS NOT NULL THEN
			IF EXISTS (SELECT * FROM used_in 
						WHERE equipment_id = eq_id AND exercise_id = e_id) THEN
				delete from used_in where equipment_id = eq_id AND exercise_id = e_id;
			ELSE
                SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Equipment not assigned to this exercise!';
			END IF;
		ELSE
			IF e_id IS NULL THEN
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise Id Does Not Exists';
			ELSE
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Equipment Id Does Not Exists';
			END IF;
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_client`(IN client_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
BEGIN
        IF EXISTS (SELECT * FROM clients WHERE client_id = client_id_p) THEN
			SET @s = CONCAT('UPDATE clients SET ', col_name_p, ' = "', val_p, '" WHERE client_id = "', client_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Record Not Found!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_contain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_contain`(IN exercise_id_p INT, IN workout_id_p INT, week_day_p VARCHAR(64), 
											IN col_name_p VARCHAR(64), IN val_p INT)
BEGIN
		IF EXISTS (SELECT * FROM contain WHERE exercise_id = exercise_id_p AND workout_id = workout_id_p
					AND week_day = week_day_p ) THEN
			SET @s = CONCAT('UPDATE contain SET ', col_name_p, ' = "', val_p, '" WHERE workout_id = "', workout_id_p, '" AND ', 
								'exercise_id = "', exercise_id_p, '" AND ', 'week_day = "', week_day_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            SELECT 'Record Updated Successfully!';
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'This record does not exist!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_diet_plan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_diet_plan`(IN plan_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
BEGIN
        IF EXISTS (SELECT * FROM diet_plan WHERE plan_id = plan_id_p) THEN
			SET @s = CONCAT('UPDATE diet_plan SET ', col_name_p, ' = "', val_p, '" WHERE plan_id = "', plan_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Record Not Found!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_diet_plan_description` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_diet_plan_description`(IN plan_id_p INT, IN mealtime_p VARCHAR(64), IN week_day_p VARCHAR(64),
														IN col_name_p VARCHAR(64), IN val_p VARCHAR(250))
BEGIN
		IF EXISTS (SELECT * FROM diet_plan_description WHERE plan_id = plan_id_p AND mealtime = mealtime_p
					AND week_day = week_day_p ) THEN
			SET @s = CONCAT('UPDATE diet_plan_description SET ', col_name_p, ' = "', val_p, '" WHERE plan_id = "', plan_id_p, '" AND ', 
								'mealtime = "', mealtime_p, '" AND ', 'week_day = "', week_day_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Record Not Found!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_equipment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_equipment`(IN equipment_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
BEGIN
        IF EXISTS (SELECT * FROM equipment WHERE equipment_id = equipment_id_p) THEN
			SET @s = CONCAT('UPDATE equipment SET ', col_name_p, ' = "', val_p, '" WHERE equipment_id = "', equipment_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Record Not Found!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_exercise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_exercise`(IN exercise_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
BEGIN
        IF EXISTS (SELECT * FROM exercise WHERE exercise_id = exercise_id_p) THEN
			SET @s = CONCAT('UPDATE exercise SET ', col_name_p, ' = "', val_p, '" WHERE exercise_id = "', exercise_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Record Not Found!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_exercise_schedule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_exercise_schedule`(IN workout_id_p VARCHAR(64), IN col_name_p VARCHAR(150), IN val_p VARCHAR(150))
BEGIN
        IF EXISTS (SELECT * FROM exercise_schedule WHERE workout_id = workout_id_p) THEN
			SET @s = CONCAT('UPDATE exercise_schedule SET ', col_name_p, ' = "', val_p, '" WHERE workout_id = "', workout_id_p, '"');
			PREPARE stmt FROM @s;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Exercise schedule record not found!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_update_used_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_update_used_id`(IN equipment_id_p INT, IN exercise_id_p INT, IN col_name_p VARCHAR(64), IN val_p INT)
BEGIN
		DECLARE eq_id, e_id INT;
        
        SELECT equipment_id INTO eq_id FROM equipment
			WHERE equipment_id = equipment_id_p;
            
		SELECT exercise_id INTO e_id FROM exercise
			WHERE exercise_id = exercise_id_p;
            
		IF e_id IS NOT NULL AND eq_id IS NOT NULL THEN		
			IF EXISTS (SELECT * FROM used_in WHERE exercise_id = exercise_id_p AND equipment_id = equipment_id_p) THEN
				SET @s = CONCAT('UPDATE used_in SET ', col_name_p, ' = "', val_p, '" WHERE equipment_id = "', equipment_id_p, '" AND ', 
									'exercise_id = "', exercise_id_p, '"');
				PREPARE stmt FROM @s;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
			ELSE
				SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Record Not Found!';
			END IF;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Record Not Found!';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_all_diet_plan_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_all_diet_plan_type`()
BEGIN
		SELECT * FROM diet_plan;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_all_equipments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_all_equipments`()
BEGIN
		SELECT * FROM equipment;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_all_exercises` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_all_exercises`()
BEGIN
		SELECT e.*, GROUP_CONCAT(DISTINCT es.workout_type) AS workouts FROM exercise as e
			LEFT OUTER JOIN contain as c
				ON c.exercise_id = e.exercise_id
			LEFT OUTER JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
		GROUP BY e.exercise_id;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_all_workout_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_all_workout_type`()
BEGIN
		SELECT * FROM exercise_schedule;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_diet_plan_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_diet_plan_type`(IN plan_id_p INT)
BEGIN
		SELECT dp.plan_type, dpd.mealtime, dpd.week_day, dpd.meal_description, dpd.calories FROM diet_plan dp
			JOIN diet_plan_description dpd
				ON dp.plan_id = dpd.plan_id
		WHERE dpd.plan_id = plan_id_p;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_equipments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_equipments`(IN equipment_id_p INT)
BEGIN
		SELECT * FROM equipment
        WHERE equipment_id = equipment_id_p;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_exercise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_exercise`(IN exercise_id_p INT)
BEGIN
		SELECT es.workout_type, e.exercise_name, e.exercise_description FROM exercise e
			JOIN contain c
				ON c.exercise_id = e.exercise_id
			JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
		WHERE e.exercise_id = exercise_id_p;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_used_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_used_in`(IN exercise_id_p INT)
BEGIN
	if exists(select equipment_id from used_in where exercise_id = exercise_id_p) then
		select a.equipment_id, b.equipment_name, b.equipment_description from used_in as a
		join equipment as b on a.equipment_id = b.equipment_id where a.exercise_id = exercise_id_p;
	else
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No equipment used in selected exercise.';
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_views_workout_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_views_workout_type`(IN workout_id_p INT)
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
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Workout Id Record Found!';
        END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_view_all_clients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_view_all_clients`(IN trainer_id_p VARCHAR(64))
BEGIN
		SELECT c.client_id, c.name, c.email, c.phone_number, es.workout_type, dp.plan_type FROM clients c
			JOIN trainer t
				ON t.staff_id = c.trainer_id
			JOIN exercise_schedule es
				ON es.workout_id = c.workout_id
			JOIN diet_plan dp
				ON dp.plan_id = c.plan_id
		WHERE c.trainer_id = trainer_id_p;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_view_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_view_client`(IN trainer_id_p VARCHAR(64), IN client_id_p VARCHAR(64))
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
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_visualize_plan_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_visualize_plan_type`(IN trainer_id_p VARCHAR(64))
BEGIN
		DECLARE id VARCHAR(64);
        
        SELECT staff_id INTO id FROM trainer
			WHERE staff_id = trainer_id_p;
            
		IF id IS NOT NULL THEN
			SELECT client_id, plan_type FROM clients c
				JOIN diet_plan dp
					ON dp.plan_id = c.plan_id
			WHERE trainer_id = trainer_id_p;
        ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Trainer_Id Does Not Exist';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `trainer_visualize_workout_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `trainer_visualize_workout_type`(IN trainer_id_p VARCHAR(64))
BEGIN
		DECLARE id VARCHAR(64);
        
        SELECT staff_id INTO id FROM trainer
			WHERE staff_id = trainer_id_p;
            
		IF id IS NOT NULL THEN
			SELECT client_id, workout_type FROM clients c
				JOIN exercise_schedule es
					ON c.workout_id = es.workout_id
            WHERE trainer_id = trainer_id_p;
		ELSE
			SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'Trainer_Id Does Not Exist';
		END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_diet_plan_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_diet_plan_client`(IN client_id_p VARCHAR(10))
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_exercise_details_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_exercise_details_client`(IN exercise_id_p INT, IN client_id_p VARCHAR(10))
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
			LEFT OUTER JOIN used_in d 
				ON d.exercise_id = b.exercise_id
			LEFT OUTER JOIN equipment e 
				ON d.equipment_id = e.equipment_id
		WHERE client_id = client_id_p AND c.exercise_id = exercise_id_p;
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'This exercise is not assigned to you.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_exercise_schedule_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_exercise_schedule_client`(IN client_id_p VARCHAR(10))
BEGIN
	DECLARE workout_plan_var VARCHAR(64);
    
    SELECT a.workout_id INTO workout_plan_var FROM clients a
		JOIN exercise_schedule b
			ON a.workout_id = b.workout_id
	WHERE a.client_id = client_id_p;

	IF workout_plan_var IS NOT NULL THEN
		SELECT b.week_day, c.exercise_name, c.exercise_id, b.sets, b.reps FROM clients a 
			JOIN contain b 
				ON a.workout_id = b.workout_id
			JOIN exercise c
				ON b.exercise_id = c.exercise_id
		WHERE a.client_id = client_id_p
		ORDER BY FIELD(week_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Workout Found!';		
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_health_reports_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_health_reports_client`(IN client_id_p VARCHAR(10))
BEGIN
	DECLARE cl_id FLOAT;
    
    SELECT weight INTO cl_id FROM health_report
		WHERE client_id = client_id_p limit 1;
        
	IF cl_id IS NOT NULL THEN
		SELECT date, weight, height, bmi, fat_percentage, smoking, drinking, surgery FROM health_report 
			WHERE client_id = client_id_p 
            ORDER BY DATE DESC;
	ELSE
		SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'No Record Found!';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_trainer_details_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_trainer_details_client`(in client_id_p varchar(10))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-17  0:12:47
