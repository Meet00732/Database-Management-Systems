import pymysql as msql
from rich.console import Console
from rich.table import Table

sqlid = input('SQL Username: ')
sqlpw = input('SQL Password: ')

try:
    connect = msql.connect(host='localhost', user=sqlid, password=sqlpw, db='gym_management_system', charset='utf8mb4', cursorclass=msql.cursors.DictCursor)
    print("Connection Successful!")
    while(True):
        opt = int(input("\n -- Select a below operation: -- \n1. Login \n2. Exit\n"))
        cur = connect.cursor()
        match opt:
            case 1:
                print('\n----- Enter login credentials -----')
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
                                        try:
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
                                                if str(x['smoking']) == '1':
                                                    temp.append('Yes')
                                                else:
                                                    temp.append('No')
                                                if str(x['drinking']) == '1':
                                                    temp.append('Yes')
                                                else:
                                                    temp.append('No')
                                                if str(x['surgery']) == '1':
                                                    temp.append('Yes')
                                                else:
                                                    temp.append('No')
                                                rows.append(temp)
                                            for column in columns:
                                                table.add_column(column)
                                            for row in rows:
                                                table.add_row(*row, style='bright_green')
                                            console = Console()
                                            console.print(table)
                                        except msql.err.OperationalError as e:
                                            print('\n' + e.args[1])

                                    case 4:
                                        try:
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
                                        except msql.err.OperationalError as e:
                                            print('\n' + e.args[1])

                                    case 2:
                                        try:
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
                                        except msql.err.OperationalError as e:
                                            print('\n' + e.args[1])

                                    case 3:
                                        try:
                                            cur.callproc("view_exercise_schedule_client", args=[username])
                                            table = Table(title="Exercise Schedule")
                                            columns = ["Week day",  "Exercise Name","Exercise Id", "Sets", "Reps"]
                                            rows = []
                                            for x in cur.fetchall():
                                                temp = []
                                                temp.append(str(x['week_day']))
                                                temp.append(str(x['exercise_name']))
                                                temp.append(str(x['exercise_id']))
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
                                                        try:
                                                            print("\n -- Enter an exercise Id to check its details: --")
                                                            lv_exercise = int(input())
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
                                                        except msql.err.OperationalError as e:
                                                            print('\n' + e.args[1])
                                                    case 2:
                                                        break
                                        except msql.err.OperationalError as e:
                                            print('\n' + e.args[1])

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
                                                    trainer_update_fields = ['staff_name', 'contact_number', 'email', 'address', 'shift_start_time', 'shift_end_time', 'salary', 'specialization', 'years_of_experience']
                                                    while(True):
                                                        try:
                                                            trainer_id = input('\n Enter the Id of trainer to be changed: ')
                                                            cur.callproc("manager_view_trainers", args=[username, trainer_id])
                                                            table = Table(title="Trainer")
                                                            columns = ["Trainer Id", "Trainer name", "Contact number", "Email Id", "Address", "Shift start time", "Shift end time", 'Salary', "Specialization", "Years of experience"]
                                                            rows = []
                                                            for x in cur.fetchall():
                                                                temp = []
                                                                temp.append(str(x['staff_id']))
                                                                temp.append(str(x['staff_name']))
                                                                temp.append(str(x['contact_number']))
                                                                temp.append(str(x['email']))
                                                                temp.append(str(x['address']))
                                                                temp.append(str(x['shift_start_time']))
                                                                temp.append(str(x['shift_end_time']))
                                                                temp.append(str(x['salary']))
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
                                                                update_field = int(input('\n -- Select a field to be updated: -- \n1. Trainer name \n2. Contact number \n3. Email Id \n4. Address \n5. Shift start time \n6. Shift end time \n7. Salary \n8. Specialization \n9. Years of experience \n10. Go back \n'))
                                                                if type(update_field) == int and (update_field >= 1 and update_field <=9):
                                                                    value_field = input("\n Enter new value of the field: ")
                                                                    try:
                                                                        cur.callproc("manager_update_trainer", args=[trainer_id, trainer_update_fields[update_field - 1], value_field])                                                                
                                                                        connect.commit()
                                                                        print('\n -- Trainer details updated --')
                                                                        cur.callproc("manager_view_trainers", args=[username, trainer_id])
                                                                        table = Table(title="Trainer")
                                                                        columns = ["Trainer Id", "Trainer name", "Contact number", "Email Id", "Address", "Shift start time", "Shift end time", 'Salary', "Specialization", "Years of experience"]
                                                                        rows = []
                                                                        for x in cur.fetchall():
                                                                            temp = []
                                                                            temp.append(str(x['staff_id']))
                                                                            temp.append(str(x['staff_name']))
                                                                            temp.append(str(x['contact_number']))
                                                                            temp.append(str(x['email']))
                                                                            temp.append(str(x['address']))
                                                                            temp.append(str(x['shift_start_time']))
                                                                            temp.append(str(x['shift_end_time']))
                                                                            temp.append(str(x['salary']))
                                                                            temp.append(str(x['specialization']))
                                                                            temp.append(str(x['years_of_experience']))
                                                                            rows.append(temp)
                                                                        for column in columns:
                                                                            table.add_column(column)
                                                                        for row in rows:
                                                                            table.add_row(*row, style='bright_green')
                                                                        console = Console()
                                                                        console.print(table)
                                                                    except msql.err.OperationalError as e:
                                                                        print(e.args[1])
                                                                        continue
                                                                else:
                                                                    break                  
                                                            break
                                                        except msql.err.OperationalError as e:
                                                            print('\n' + e.args[1])
                                                            continue
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
                                        while(True):
                                            print("\n -- Select a below operation: -- \n1. Update client's details \n2. Delete a client \n3. Go back")
                                            temp2 = int(input())
                                            match temp2:
                                                case 1:
                                                    client_update_fields = ['name', 'phone_number', 'email', 'address', 'trainer_id']
                                                    while(True):
                                                        try:
                                                            client_id = input('\n Enter the Id of client to be changed: ')
                                                            cur.callproc("manager_view_client", args=[username, client_id])
                                                            table = Table(title="Client")
                                                            columns = ["Client Id", "Client name", "Contact number", "Email Id", "Address", "Assigned trainer", "Trainer Id"]
                                                            rows = []
                                                            for x in cur.fetchall():
                                                                temp = []
                                                                temp.append(str(x['client_id']))
                                                                temp.append(str(x['name']))
                                                                temp.append(str(x['phone_number']))
                                                                temp.append(str(x['email']))
                                                                temp.append(str(x['address']))
                                                                temp.append(str(x['trainer_name']))
                                                                temp.append(str(x['staff_id']))
                                                                rows.append(temp)
                                                            for column in columns:
                                                                table.add_column(column)
                                                            for row in rows:
                                                                table.add_row(*row, style='bright_green')
                                                            console = Console()
                                                            console.print(table)
                                                            while(True):
                                                                update_field = int(input('\n -- Select a field to be updated: -- \n1. Client name \n2. Contact number \n3. Email Id \n4. Address \n5. Assigned trainer \n6. Go back\n'))
                                                                if type(update_field) == int and (update_field >= 1 and update_field <=5):
                                                                    value_field = input("\n Enter new value of the field: ")
                                                                    try:
                                                                        cur.callproc("manager_update_client", args=[client_id, client_update_fields[update_field - 1], value_field])                                                                
                                                                        connect.commit()
                                                                        print('\n -- Client details updated --')
                                                                    except msql.err.OperationalError as e:
                                                                        print(e.args[1])
                                                                        continue
                                                                else:
                                                                    break                  
                                                            break
                                                        except msql.err.OperationalError as e:
                                                            print('\n' + e.args[1])
                                                            continue
                                                case 2:
                                                    client_id = input('\n Enter the Id of client to be deleted: ')
                                                    try:
                                                        cur.callproc("manager_delete_client", args=[client_id])
                                                        connect.commit()
                                                        print('\n -- Client deleted --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 3:
                                                    break
                                    case 3:
                                        columns = ["Client Id", "Client name", "Contact number", "Email Id", "Address", "Assigned trainer", "Membership type", "Membership start date(yyyy-mm-dd)"]
                                        client_insert_fields = ['id', 'name', 'phone_number', 'email', 'address', 'trainer_id']
                                        client_insert_values = []
                                        print("\n -- Enter the following details for the new client: --")
                                        for x in columns:
                                            client_field_value = input(x + ": ")
                                            if(client_field_value == ''):
                                                client_field_value = None
                                            client_insert_values.append(client_field_value)
                                        try:
                                            cur.callproc("manager_create_client", args=[client_insert_values[0],client_insert_values[1],client_insert_values[3],client_insert_values[2],client_insert_values[4],client_insert_values[5],None,None,client_insert_values[7],client_insert_values[6],username])
                                            connect.commit()
                                            print('\n -- New client created --')
                                        except msql.err.OperationalError as e:
                                            print('\n' + e.args[1])
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
                                        my_clients = []
                                        for x in cur.fetchall():
                                            temp = []
                                            temp.append(str(x['client_id']))
                                            my_clients.append(str(x['client_id']))
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
                                            temp3 = int(input("\n -- Select one of below operations: \n1. Select a client \n2. Go back \n"))
                                            health_report_ques = ['Age', 'Weight(lbs)', 'Height(feet.inches)', 'Fat percentage', 'Does the client smoke(Y/N)', 'Does the client drink(Y/N)', 'Has client undergone any surgery since last health report(Y/N)', 'Date(yyyy-mm-dd)']
                                            health_report_fields = ['age', 'weight', 'height', 'bmi', 'fat_percentage', 'smoking', 'drinking', 'surgery', 'date', 'client_id']
                                            match temp3:
                                                case 1: 
                                                    while(True):
                                                        client_id = input('\nEnter the client Id: ')
                                                        if client_id not in my_clients:
                                                            print(' -- This client is not assigned to you --')
                                                        else:
                                                            while(True):
                                                                temp2 = int(input("\n -- Select one of below operations: -- \n1. Update client's workout plan \n2. Update client's diet plan \n3. Create health report for client \n4. View health reports of client \n5. Go back\n"))
                                                                match temp2:
                                                                    case 1:
                                                                        cur.callproc("trainer_views_all_workout_type")
                                                                        # print(cur.fetchall())
                                                                        table = Table(title="Workout types")
                                                                        columns = ["Workout Id", "Workout type name"]
                                                                        workout_plans = []
                                                                        rows = []
                                                                        for x in cur.fetchall():
                                                                            temp = []
                                                                            temp.append(str(x['workout_id']))
                                                                            workout_plans.append(x['workout_id'])
                                                                            temp.append(str(x['workout_type']))
                                                                            rows.append(temp)
                                                                        for column in columns:
                                                                            table.add_column(column)
                                                                        for row in rows:
                                                                            table.add_row(*row, style='bright_green')
                                                                        console = Console()
                                                                        console.print(table)
                                                                        new_workout_plan = int(input('\nEnter the new workout plan Id for the client: '))
                                                                        if new_workout_plan not in workout_plans:
                                                                            print('\n -- Invalid workout type Id --')
                                                                        else:
                                                                            try:
                                                                                cur.callproc("trainer_update_client", args=[client_id, 'workout_id', new_workout_plan])
                                                                                connect.commit()
                                                                                print('\n -- Workout type updated for the client --')
                                                                            except msql.err.OperationalError as e:
                                                                                print(e.args[1])
                                                                    case 2:
                                                                        cur.callproc("trainer_views_all_diet_plan_type")
                                                                        # print(cur.fetchall())
                                                                        table = Table(title="Diet plan types")
                                                                        columns = ["Diet plan Id", "Diet plan name"]
                                                                        diet_plans = []
                                                                        rows = []
                                                                        for x in cur.fetchall():
                                                                            temp = []
                                                                            temp.append(str(x['plan_id']))
                                                                            diet_plans.append(x['plan_id'])
                                                                            temp.append(str(x['plan_type']))
                                                                            rows.append(temp)
                                                                        for column in columns:
                                                                            table.add_column(column)
                                                                        for row in rows:
                                                                            table.add_row(*row, style='bright_green')
                                                                        console = Console()
                                                                        console.print(table)
                                                                        new_diet_plan = int(input('\nEnter the new diet plan Id for the client: '))
                                                                        if new_diet_plan not in diet_plans:
                                                                            print('\n -- Invalid diet plan Id --')
                                                                        else:
                                                                            try:
                                                                                cur.callproc("trainer_update_client", args=[client_id, 'plan_id', new_diet_plan])
                                                                                connect.commit()
                                                                                print('\n -- Diet plan type updated for the client --')
                                                                            except msql.err.OperationalError as e:
                                                                                print(e.args[1])
                                                                    case 3:
                                                                        #create health report
                                                                        print('\n -- Enter the below details for the health report --')
                                                                        health_report_vals = []
                                                                        for x in health_report_ques:
                                                                            new_val = input(x + ': ')
                                                                            if new_val == 'Y' or new_val == 'y':
                                                                                new_val = 1
                                                                            elif new_val == 'N' or new_val == 'n':
                                                                                new_val = 0
                                                                            health_report_vals.append(new_val)
                                                                        try:
                                                                            cur.callproc("create_health_report", args=[health_report_vals[0], health_report_vals[1], health_report_vals[2], health_report_vals[3], health_report_vals[4], health_report_vals[5], health_report_vals[6], health_report_vals[7], client_id])
                                                                            connect.commit()
                                                                            print('\n -- New health report created for client ' + client_id + ' -- ')
                                                                        except msql.err.IntegrityError as e:
                                                                            print('\n' + e.args[1])
                                                                    case 4:
                                                                        #view all health reports
                                                                        try:
                                                                            cur.callproc("view_health_reports_client", args=[client_id])
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
                                                                                if str(x['smoking']) == '1':
                                                                                    temp.append('Yes')
                                                                                else:
                                                                                    temp.append('No')
                                                                                if str(x['drinking']) == '1':
                                                                                    temp.append('Yes')
                                                                                else:
                                                                                    temp.append('No')
                                                                                if str(x['surgery']) == '1':
                                                                                    temp.append('Yes')
                                                                                else:
                                                                                    temp.append('No')
                                                                                rows.append(temp)
                                                                            for column in columns:
                                                                                table.add_column(column)
                                                                            for row in rows:
                                                                                table.add_row(*row, style='bright_green')
                                                                            console = Console()
                                                                            console.print(table)
                                                                            while(True):
                                                                                health_repop = int(input("\n -- Select one of below operations: -- \n1. Delete health report \n2. Go back\n"))
                                                                                match health_repop:
                                                                                    case 1:
                                                                                        hr_date = input('\nEnter the date of health report to be deleted(yyyy-mm-dd): ')
                                                                                        try:
                                                                                            cur.callproc("trainer_delete_health_report", args=[client_id, hr_date])
                                                                                            connect.commit()
                                                                                            print('\n -- Health report deleted --')
                                                                                        except msql.err.OperationalError as e:
                                                                                            print('\n' + e.args[1])
                                                                                    case _:
                                                                                        break
                                                                        except msql.err.OperationalError as e:
                                                                            print('\n' + e.args[1])   
                                                                    case 5:
                                                                        break
                                                            break
                                                case 2:
                                                    break
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
                                        while(True):
                                            temp2 = int(input("\n -- Select one of below operations: -- \n1. Add equipment \n2. Update equipment \n3. Delete equipment \n4. Go back\n"))
                                            match temp2:
                                                case 1:
                                                    #Add new equipment
                                                    equip_name = input('\nEnter the equipment name: ')
                                                    equip_desc = input('\nEnter the equipment description:\n')
                                                    try:
                                                        cur.callproc("trainer_creates_equipment", args=[equip_name, equip_desc])
                                                        connect.commit()
                                                        print('\n -- New equipment added --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 2:
                                                    while(True):
                                                        equip_id = input('\nEnter the equipment Id: ')
                                                        while(True):
                                                            temp3 = int(input("\n -- Select one of below operations: -- \n1. Change equipment name \n2. Change equipment description \n3. Go back\n"))
                                                            match temp3:
                                                                case 1:
                                                                    change_field = 'equipment_name'
                                                                    try:
                                                                        new_val = input('Enter new value for the chosen field: ')
                                                                        cur.callproc("trainer_update_equipment", args=[equip_id, change_field, new_val])
                                                                        print('\n -- Equipment details updated --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])
                                                                case 2:
                                                                    change_field = 'equipment_description'
                                                                    try:
                                                                        new_val = input('Enter new value for the chosen field: ')
                                                                        cur.callproc("trainer_update_equipment", args=[equip_id, change_field, new_val])
                                                                        connect.commit()
                                                                        print('\n -- Equipment details updated --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])
                                                                case 3:
                                                                    break
                                                        break
                                                case 3:
                                                    equip_id = input('\nEnter the equipment Id: ')
                                                    try:
                                                        cur.callproc("trainer_delete_equipment", args=[equip_id])
                                                        connect.commit()
                                                        print('\n -- Equipment deleted --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 4:
                                                    break

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
                                        while(True):
                                            temp2 = int(input('\n -- Select one of below operations: -- \n1. Create new exercise \n2. Delete an exercise \n3. View equipments used in exercise \n4. Go back\n'))
                                            match temp2:
                                                case 1:
                                                    exer_name = input('\nEnter the name of new exercise: ')
                                                    exer_desc = input('\nEnter the description for new exercise: ')
                                                    try:
                                                        cur.callproc("trainer_create_exercise", args=[exer_name, exer_desc])
                                                        connect.commit()
                                                        print('\n -- New exercise created --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 2:
                                                    exer_id = input('\nEnter the Id of exercise to be deleted: ')
                                                    try:
                                                        cur.callproc("trainer_delete_exercise", args=[exer_id])
                                                        connect.commit()
                                                        print('\n -- Exercise deleted --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 3:
                                                    try:
                                                        exer_id = int(input('\nEnter the Id of exercise to check equipments: '))
                                                        cur.callproc("trainer_views_used_in", args=[exer_id])
                                                        # print(cur.fetchall())
                                                        table = Table(title="Equipments Used")
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
                                                        while(True):
                                                            #Add code here for equipments
                                                            temp2 = int(input('\n -- Select one of below operations: -- \n1. Add an equipment to exercise \n2. Delete an equipment from exercise \n3. Go back\n'))
                                                            match temp2:
                                                                case 1:
                                                                    try:
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
                                                                        equip_id = input('\nEnter the Id of equipment to be added: ')
                                                                        cur.callproc("trainer_create_used_in", args=[equip_id, exer_id])
                                                                        connect.commit()
                                                                        print('\n -- Equipment added --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])
                                                                case 2:
                                                                    try:
                                                                        equip_id = input('\nEnter the Id of equipment to be removed: ')
                                                                        cur.callproc("trainer_delete_used_in", args=[equip_id, exer_id])
                                                                        connect.commit()
                                                                        print('\n -- Equipment removed from exercise --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])   
                                                                case 3:
                                                                    break
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 4:
                                                    break

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
                                        while(True):
                                            temp2 = int(input("\n -- Select one of below operations: -- \n1. View workout schedule \n2. Add a workout type \n3. Delete workout type \n4. Go back\n"))
                                            match temp2:
                                                case 1:
                                                    #Add new equipment
                                                    workout_id = input('\nEnter the workout type Id for viewing the schedule: ')
                                                    try:
                                                        cur.callproc("trainer_views_workout_type", args=[workout_id])
                                                        table = Table(title="Workout schedule")
                                                        columns = ["Week day", "Exercise Id", "Exercise name", "Exercise description", "Sets", "Reps"]
                                                        rows = []
                                                        for x in cur.fetchall():
                                                            temp = []
                                                            temp.append(str(x['week_day']))
                                                            temp.append(str(x['exercise_id']))
                                                            temp.append(str(x['exercise_name']))
                                                            temp.append(str(x['exercise_description']))
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
                                                            temp2 = int(input("\n -- Select one of below operations: -- \n1. Add a schedule record \n2. Update a schedule record \n3. Delete a schedule record \n4. Go back\n"))
                                                            match temp2:
                                                                case 1:
                                                                    #Add new schedule
                                                                    weekday = int(input("\n -- Select a weekday: -- \n1. Monday \n2. Tuesday \n3. Wednesday \n4. Thursday \n5. Friday \n6. Saturday \n7. Sunday\n"))
                                                                    match weekday:
                                                                        case 1:
                                                                            weekday = 'Monday'
                                                                        case 2:
                                                                            weekday = 'Tuesday'
                                                                        case 3:
                                                                            weekday = 'Wednesday'
                                                                        case 4:
                                                                            weekday = 'Thursday'
                                                                        case 5:
                                                                            weekday = 'Friday'
                                                                        case 6:
                                                                            weekday = 'Saturday'
                                                                        case 7:
                                                                            weekday = 'Sunday'
                                                                        case _:
                                                                            print('\n -- Invalid weekday --')
                                                                            break
                                                                    exercise_id = input('\nEnter the exercise Id: ')
                                                                    sets = input('\nEnter the number of sets: ')
                                                                    reps = input('\nEnter the number of reps: ')
                                                                    try:
                                                                        cur.callproc("trainer_create_contain", args=[exercise_id, workout_id, weekday, sets, reps])
                                                                        connect.commit()
                                                                        print('\n -- New workout schedule record created --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])
                                
                                                                case 2:
                                                                    weekday = int(input("\n -- Select a weekday: -- \n1. Monday \n2. Tuesday \n3. Wednesday \n4. Thursday \n5. Friday \n6. Saturday \n7. Sunday\n"))
                                                                    match weekday:
                                                                        case 1:
                                                                            weekday = 'Monday'
                                                                        case 2:
                                                                            weekday = 'Tuesday'
                                                                        case 3:
                                                                            weekday = 'Wednesday'
                                                                        case 4:
                                                                            weekday = 'Thursday'
                                                                        case 5:
                                                                            weekday = 'Friday'
                                                                        case 6:
                                                                            weekday = 'Saturday'
                                                                        case 7:
                                                                            weekday = 'Sunday'
                                                                        case _:
                                                                            print('\n -- Invalid weekday --')
                                                                            break
                                                                    exercise_id = input('\nEnter the exercise Id: ')
                                                                    field_update = int(input("\n -- Select a field to be updated: -- \n1. Sets \n2. Reps\n"))
                                                                    match field_update:
                                                                        case 1:
                                                                            field_update = 'sets'
                                                                        case 2:
                                                                            field_update = 'reps'
                                                                        case _:
                                                                            print('\n -- Invalid field --')
                                                                            break
                                                                    new_val = input("\nEnter new value for selected field: ")
                                                                    try:
                                                                        cur.callproc("trainer_update_contain", args=[exercise_id, workout_id, weekday, field_update, new_val])
                                                                        connect.commit()
                                                                        print('\n -- Workout schedule record updated --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])

                                                                case 3:
                                                                    weekday = int(input("\n -- Select a weekday: -- \n1. Monday \n2. Tuesday \n3. Wednesday \n4. Thursday \n5. Friday \n6. Saturday \n7. Sunday\n"))
                                                                    match weekday:
                                                                        case 1:
                                                                            weekday = 'Monday'
                                                                        case 2:
                                                                            weekday = 'Tuesday'
                                                                        case 3:
                                                                            weekday = 'Wednesday'
                                                                        case 4:
                                                                            weekday = 'Thursday'
                                                                        case 5:
                                                                            weekday = 'Friday'
                                                                        case 6:
                                                                            weekday = 'Saturday'
                                                                        case 7:
                                                                            weekday = 'Sunday'
                                                                        case _:
                                                                            print('\n -- Invalid weekday --')
                                                                            break
                                                                    exercise_id = input('\nEnter the exercise Id: ')
                                                
                                                                    try:
                                                                        cur.callproc("trainer_delete_contain", args=[exercise_id, workout_id, weekday])
                                                                        connect.commit()
                                                                        print('\n -- Workout schedule record deleted --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])
                                                                case 4:
                                                                    break
                                                    #End of viewing schedule
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 2:
                                                    workout_name = input('\nEnter the new workout type name: ')
                                                    try:
                                                        cur.callproc("trainer_create_exercise_schedule", args=[workout_name])
                                                        connect.commit()
                                                        print('\n -- New workout type created --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 3:
                                                    workout_id = input('\nEnter the workout type Id to be deleted: ')
                                                    try:
                                                        cur.callproc("trainer_delete_exercise_schedule", args=[workout_id])
                                                        connect.commit()
                                                        print('\n -- Workout type deleted --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 4:
                                                    break

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
                                        while(True):
                                            temp2 = int(input("\n -- Select one of below operations: -- \n1. View diet plan schedule \n2. Add a diet plan \n3. Delete a diet plan \n4. Go back\n"))
                                            match temp2:
                                                case 1:                
                                                    diet_id = input('\nEnter the diet plan type Id for viewing the schedule: ')
                                                    try:
                                                        cur.callproc("trainer_views_diet_plan_type", args=[diet_id])
                                                        table = Table(title="Diet Plan Schedule")
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
                                                        while(True):
                                                            temp2 = int(input("\n -- Select one of below operations: -- \n1. Add a schedule record \n2. Update a schedule record \n3. Delete a schedule record \n4. Go back\n"))
                                                            match temp2:
                                                                case 1:
                                                                    #Add new schedule
                                                                    weekday = int(input("\n -- Select a weekday: -- \n1. Monday \n2. Tuesday \n3. Wednesday \n4. Thursday \n5. Friday \n6. Saturday \n7. Sunday\n"))
                                                                    match weekday:
                                                                        case 1:
                                                                            weekday = 'Monday'
                                                                        case 2:
                                                                            weekday = 'Tuesday'
                                                                        case 3:
                                                                            weekday = 'Wednesday'
                                                                        case 4:
                                                                            weekday = 'Thursday'
                                                                        case 5:
                                                                            weekday = 'Friday'
                                                                        case 6:
                                                                            weekday = 'Saturday'
                                                                        case 7:
                                                                            weekday = 'Sunday'
                                                                        case _:
                                                                            print('\n -- Invalid weekday --')
                                                                            break
                                                                    meal_time = int(input("\n -- Select a meal time: -- \n1. Breakfast \n2. Lunch \n3. Dinner \n"))
                                                                    match meal_time:
                                                                        case 1:
                                                                            meal_time = 'breakfast'
                                                                        case 2:
                                                                            meal_time = 'lunch'
                                                                        case 3:
                                                                            meal_time = 'dinner'
                                                                        case _:
                                                                            print('\n -- Invalid meal time --')
                                                                            break  
                                                                    meal_desc = input('\nEnter the meal description: ')
                                                                    calories = input('\nEnter the meal calories: ')
                                                                    try:
                                                                        cur.callproc("trainer_create_diet_plan_description", args=[meal_time, weekday, meal_desc, calories, diet_id])
                                                                        connect.commit()
                                                                        print('\n -- New diet plan schedule record created --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])
                                
                                                                case 2:
                                                                    weekday = int(input("\n -- Select a weekday: -- \n1. Monday \n2. Tuesday \n3. Wednesday \n4. Thursday \n5. Friday \n6. Saturday \n7. Sunday\n"))
                                                                    match weekday:
                                                                        case 1:
                                                                            weekday = 'Monday'
                                                                        case 2:
                                                                            weekday = 'Tuesday'
                                                                        case 3:
                                                                            weekday = 'Wednesday'
                                                                        case 4:
                                                                            weekday = 'Thursday'
                                                                        case 5:
                                                                            weekday = 'Friday'
                                                                        case 6:
                                                                            weekday = 'Saturday'
                                                                        case 7:
                                                                            weekday = 'Sunday'
                                                                        case _:
                                                                            print('\n -- Invalid weekday --')
                                                                            break
                                                                    meal_time = int(input("\n -- Select a meal time: -- \n1. Breakfast \n2. Lunch \n3. Dinner \n"))
                                                                    match meal_time:
                                                                        case 1:
                                                                            meal_time = 'breakfast'
                                                                        case 2:
                                                                            meal_time = 'lunch'
                                                                        case 3:
                                                                            meal_time = 'dinner'
                                                                        case _:
                                                                            print('\n -- Invalid meal time --')
                                                                            break
                                                                    field_update = int(input("\n -- Select a field to be updated: -- \n1. Meal description \n2. Meal calories\n"))
                                                                    match field_update:
                                                                        case 1:
                                                                            field_update = 'meal_description'
                                                                        case 2:
                                                                            field_update = 'calories'
                                                                        case _:
                                                                            print('\n -- Invalid field --')
                                                                            break
                                                                    new_val = input("\nEnter new value for selected field: ")
                                                                    try:
                                                                        cur.callproc("trainer_update_diet_plan_description", args=[diet_id, meal_time, weekday, field_update, new_val])
                                                                        connect.commit()
                                                                        print('\n -- Diet plan schedule record updated --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])

                                                                case 3:
                                                                    weekday = int(input("\n -- Select a weekday: -- \n1. Monday \n2. Tuesday \n3. Wednesday \n4. Thursday \n5. Friday \n6. Saturday \n7. Sunday\n"))
                                                                    match weekday:
                                                                        case 1:
                                                                            weekday = 'Monday'
                                                                        case 2:
                                                                            weekday = 'Tuesday'
                                                                        case 3:
                                                                            weekday = 'Wednesday'
                                                                        case 4:
                                                                            weekday = 'Thursday'
                                                                        case 5:
                                                                            weekday = 'Friday'
                                                                        case 6:
                                                                            weekday = 'Saturday'
                                                                        case 7:
                                                                            weekday = 'Sunday'
                                                                        case _:
                                                                            print('\n -- Invalid weekday --')
                                                                            break
                                                                    meal_time = int(input("\n -- Select a meal time: -- \n1. Breakfast \n2. Lunch \n3. Dinner \n"))
                                                                    match meal_time:
                                                                        case 1:
                                                                            meal_time = 'breakfast'
                                                                        case 2:
                                                                            meal_time = 'lunch'
                                                                        case 3:
                                                                            meal_time = 'dinner'
                                                                        case _:
                                                                            print('\n -- Invalid meal time --')
                                                                            break  
                                                                    try:
                                                                        cur.callproc("trainer_delete_diet_plan_description", args=[diet_id, meal_time, weekday])
                                                                        connect.commit()
                                                                        print('\n -- Diet plan schedule record deleted --')
                                                                    except msql.err.OperationalError as e:
                                                                        print('\n' + e.args[1])
                                                                case 4:
                                                                    break
                                                    #End of viewing schedule
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 2:
                                                    diet_name = input('\nEnter the new diet plan type name: ')
                                                    try:
                                                        cur.callproc("trainer_create_diet_plan", args=[diet_name])
                                                        connect.commit()
                                                        print('\n -- New diet plan type created --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 3:
                                                    diet_id = input('\nEnter the diet plan type Id to be deleted: ')
                                                    try:
                                                        cur.callproc("trainer_delete_diet_plan", args=[diet_id])
                                                        connect.commit()
                                                        print('\n -- Diet plan type deleted --')
                                                    except msql.err.OperationalError as e:
                                                        print('\n' + e.args[1])
                                                case 4:
                                                    break

                                    case 6: 
                                        break
                                        
                        case _:
                            print('\n-- Invalid Credentials! --')
                            continue
            case 2:
                cur.close()
                connect.close()
                break
except msql.err.OperationalError as e:
    print(e.args[1])