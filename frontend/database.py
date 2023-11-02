import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Pnroshni28@",
    database="bookpublishing"
)
c = mydb.cursor()


def create_table():
    c.execute('CREATE TABLE IF NOT EXISTS subjects(S_ID TEXT, subject_name TEXT)')


def add_data(S_ID, subject_name):
    c.execute('INSERT INTO subjects(S_ID, subject_name) VALUES (%s,%s)',
    (S_ID, subject_name))
    mydb.commit()


def view_all_data():
    c.execute('SELECT * FROM subjects')
    data = c.fetchall()
    return data


def view_only_subject_number():
    c.execute('SELECT S_ID FROM subjects')
    data = c.fetchall()
    return data


def edit_subject_data(new_sname, subject_name):
    c.execute("UPDATE subjects SET subject_name=%s where S_ID = %s", (new_sname, subject_name))
    mydb.commit()
    data = c.fetchall()
    return data


def delete_data(S_ID):
    c.execute('DELETE FROM subjects WHERE S_ID="{}"'.format(S_ID))
    mydb.commit()

def pie_chart():
    c.execute('SELECT b.S_ID,subject_name, COUNT(B_ID) FROM subjects s JOIN book b ON s.S_ID = b.S_ID GROUP BY b.S_ID')
    data = c.fetchall()
    return data

def qexec(query):
    c.execute(query)
    data = c.fetchall()
    return data

