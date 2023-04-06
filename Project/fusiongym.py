import pymysql as msql
from rich.console import Console
from rich.table import Table

sqlid = input('SQL Username: ')
sqlpw = input('SQL Password: ')

#print(username, password)
try:
    connect = msql.connect(host='localhost', user=sqlid, password=sqlpw, db='gym_management_system', charset='utf8mb4', cursorclass=msql.cursors.DictCursor)
    print("Connection Successful!")
    while(True):
        print('\n----- Enter login credentials -----')
        cur = connect.cursor()
        username = input('Username: ')
        password = input('Password: ')
        cur.callproc("check_credentials", args=[username, password])
        if(cur.rowcount == 0):
            print('\n-- Invalid Credentials! --')
            continue
        else:
            match username[0:2]:
#Start of logic for the client
                case 'CL':
                    while(True):
                        print("\n -- Select a below operation: -- \n1. View health reports \n2. View diet plan \n3. View exercise schedule \n4. View my trainer's details \n5. Logout")
                        temp = int(input())
                        match temp:
                            case 1:
                                cur.callproc("view_health_reports_client", args=[username])
                                table = Table(title="Health Reports")
                                columns = ["Date", "Weight", "Height", "BMI", "Fat percentage", "Smoking", "Drinking", "Undergone surgery"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['date']))
                                    temp.append(str(x['weight']))
                                    temp.append(str(x['height']))
                                    temp.append(str(x['bmi']))
                                    temp.append(str(x['fat_percentage']))
                                    temp.append(str(x['smoking']))
                                    temp.append(str(x['drinking']))
                                    temp.append(str(x['surgery']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)

                            case 4:
                                cur.callproc("view_trainer_details_client", args=[username])
                                table = Table(title="Trainer details")
                                columns = ["Trainer name", "Contact number", "Email address", "Shift start time", "Shift end time", "Specialization", "Years of experience"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['staff_name']))
                                    temp.append(str(x['contact_number']))
                                    temp.append(str(x['email']))
                                    temp.append(str(x['shift_start_time']))
                                    temp.append(str(x['shift_end_time']))
                                    temp.append(str(x['specialization']))
                                    temp.append(str(x['years_of_experience']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)

                            case 2:
                                cur.callproc("view_diet_plan_client", args=[username])
                                table = Table(title="Diet Plan")
                                columns = ["Week day", "Meal time", "Meal Description", "Calories"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['week_day']))
                                    temp.append(str(x['mealtime']))
                                    temp.append(str(x['meal_description']))
                                    temp.append(str(x['calories']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)

                            case 3:
                                cur.callproc("view_exercise_schedule_client", args=[username])
                                table = Table(title="Exercise Schedule")
                                columns = ["Week day", "Exercise name", "Sets", "Reps"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['week_day']))
                                    temp.append(str(x['exercise_name']))
                                    temp.append(str(x['sets']))
                                    temp.append(str(x['reps']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                                while(True):
                                    print("\n -- Select a below operation: -- \n1. Check details of an exercise \n2. Go back")
                                    temp2 = int(input())
                                    match temp2:
                                        case 1:
                                            print("\n -- Enter an exercise to check its details: --")
                                            lv_exercise = input()
                                            cur.callproc("view_exercise_details_client", args=[lv_exercise, username])
                                            table = Table(title="Exercise Details")
                                            columns = ["Exercise name", "Exercise description", "Equipment name", "Equipment description", "Equipment id"]
                                            rows = []
                                            for x in cur.fetchall():
                                                temp = []
                                                temp.append(str(x['exercise_name']))
                                                temp.append(str(x['exercise_description']))
                                                temp.append(str(x['equipment_name']))
                                                temp.append(str(x['equipment_description']))
                                                temp.append(str(x['equipment_id']))
                                                rows.append(temp)
                                            for column in columns:
                                                table.add_column(column)
                                            for row in rows:
                                                table.add_row(*row, style='bright_green')
                                            console = Console()
                                            console.print(table)
                                        case 2:
                                            break

                            case 5:
                                break
#Start of logic for manager
                case 'MA':
                    while(True):
                        print("\n -- Select a below operation: -- \n1. View all trainers \n2. View all clients \n3. Register new client \n4. Logout")
                        temp = int(input())
                        match temp:
                            case 1: 
                                cur.callproc("manager_view_all_trainers", args=[username])
                                # print(cur.fetchall())
                                table = Table(title="Trainers' Details")
                                columns = ["Trainer Id", "Trainer name", "Contact number", "Email Id", "Shift start time", "Shift end time", "Specialization", "Years of experience"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['staff_id']))
                                    temp.append(str(x['staff_name']))
                                    temp.append(str(x['contact_number']))
                                    temp.append(str(x['email']))
                                    temp.append(str(x['shift_start_time']))
                                    temp.append(str(x['shift_end_time']))
                                    temp.append(str(x['specialization']))
                                    temp.append(str(x['years_of_experience']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                                while(True):
                                    print("\n -- Select a below operation: -- \n1. Update trainer's details \n2. Go back")
                                    temp2 = int(input())
                                    match temp2:
                                        case 1:
                                            trainer_id = int(input('Enter the Id of trainer to be changed: '))
                                            cur.callproc("manager_view_all_trainers", args=[username])
                                            # print(cur.fetchall())
                                            table = Table(title="Trainers")
                                            columns = ["Trainer Id", "Trainer name", "Contact number", "Email Id", "Shift start time", "Shift end time", "Specialization", "Years of experience"]
                                            rows = []
                                            for x in cur.fetchall():
                                                temp = []
                                                temp.append(str(x['staff_id']))
                                                temp.append(str(x['staff_name']))
                                                temp.append(str(x['contact_number']))
                                                temp.append(str(x['email']))
                                                temp.append(str(x['shift_start_time']))
                                                temp.append(str(x['shift_end_time']))
                                                temp.append(str(x['specialization']))
                                                temp.append(str(x['years_of_experience']))
                                                rows.append(temp)
                                            for column in columns:
                                                table.add_column(column)
                                            for row in rows:
                                                table.add_row(*row, style='bright_green')
                                            console = Console()
                                            console.print(table)
                                        case 2:
                                            break
                            case 2:
                                cur.callproc("manager_view_all_clients", args=[username])
                                # print(cur.fetchall())
                                table = Table(title="Clients' Details")
                                columns = ["Client Id", "Client name", "Contact number", "Email Id", "Address", "Assigned trainer"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['client_id']))
                                    temp.append(str(x['name']))
                                    temp.append(str(x['phone_number']))
                                    temp.append(str(x['email']))
                                    temp.append(str(x['address']))
                                    temp.append(str(x['trainer_name']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                            case 3:
                                break
                                #register new client
                            case 4:
                                break
#Start of logic for the trainer
                case 'TR':
                    while(True):
                        print("\n -- Select a below operation: -- \n1. View all clients \n2. View equipments \n3. View exercises \n4. View workout types \n5. View diet plans \n6. Logout")
                        temp = int(input())
                        match temp:
                            case 1: 
                                cur.callproc("trainer_view_all_clients", args=[username])
                                # print(cur.fetchall())
                                table = Table(title="Clients' Details")
                                columns = ["Client Id", "Client name", "Email Id", "Contact number", "Workout type", "Diet plan type"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['client_id']))
                                    temp.append(str(x['name']))
                                    temp.append(str(x['email']))
                                    temp.append(str(x['phone_number']))
                                    temp.append(str(x['workout_type']))
                                    temp.append(str(x['plan_type']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                                while(True):
                                    print("\n -- Select one of below operations: -- \n1. Update a client's workout/diet plan \n2. Go back")
                                    temp2 = int(input())
                            case 2: 
                                cur.callproc("trainer_views_all_equipments")
                                # print(cur.fetchall())
                                table = Table(title="Equipments")
                                columns = ["Equipment Id", "Equipment name", "Equipment description"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['equipment_id']))
                                    temp.append(str(x['equipment_name']))
                                    temp.append(str(x['equipment_description']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                            case 3: 
                                cur.callproc("trainer_views_all_exercises")
                                # print(cur.fetchall())
                                table = Table(title="Exercise Details")
                                columns = ["Exercise Id", "Exercise name", "Exercise description", "Assigned in workout types"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['exercise_id']))
                                    temp.append(str(x['exercise_name']))
                                    temp.append(str(x['exercise_description']))
                                    temp.append(str(x['workouts']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                            case 4: 
                                cur.callproc("trainer_views_all_workout_type")
                                # print(cur.fetchall())
                                table = Table(title="Workout types")
                                columns = ["Workout Id", "Workout type name"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['workout_id']))
                                    temp.append(str(x['workout_type']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                            case 5: 
                                cur.callproc("trainer_views_all_diet_plan_type")
                                # print(cur.fetchall())
                                table = Table(title="Diet plan types")
                                columns = ["Diet plan Id", "Diet plan name"]
                                rows = []
                                for x in cur.fetchall():
                                    temp = []
                                    temp.append(str(x['plan_id']))
                                    temp.append(str(x['plan_type']))
                                    rows.append(temp)
                                for column in columns:
                                    table.add_column(column)
                                for row in rows:
                                    table.add_row(*row, style='bright_green')
                                console = Console()
                                console.print(table)
                            case 6: 
                                break
                                
                case _:
                    print('\n-- Invalid Credentials! --')
                    continue

except msql.err.OperationalError as e:
    print('Error: %d: %s' % (e.args[0], e.args[1]))