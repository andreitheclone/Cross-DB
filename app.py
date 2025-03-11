from flask import Flask, render_template, request, redirect, url_for
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="admin",
    database="cros"
)

@app.route('/')
def index():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Participanți")
    participanti = cursor.fetchall()
    cursor.execute("SELECT * FROM Donatii")
    donatii = cursor.fetchall()
    cursor.execute("SELECT * FROM Evenimente")
    evenimente = cursor.fetchall()
    return render_template('index.html', participanti=participanti, donatii=donatii, evenimente=evenimente)

@app.route('/add_participant', methods=['POST'])
def add_participant():
    nume = request.form['nume']
    prenume = request.form['prenume']
    data_nasterii = request.form['data_nasterii']
    email = request.form['email']
    telefon = request.form['telefon']
    adresa = request.form['adresa']
    cursor = db.cursor()
    cursor.execute("INSERT INTO Participanți (Nume, Prenume, Data_Nasterii, Email, Telefon, Adresa) VALUES (%s, %s, %s, %s, %s, %s)", (nume, prenume, data_nasterii, email, telefon, adresa))
    db.commit()
    return redirect(url_for('index'))

@app.route('/update_participant/<int:id>', methods=['POST'])
def update_participant(id):
    nume = request.form['nume']
    prenume = request.form['prenume']
    data_nasterii = request.form['data_nasterii']
    email = request.form['email']
    telefon = request.form['telefon']
    adresa = request.form['adresa']
    cursor = db.cursor()
    cursor.execute("UPDATE Participanți SET Nume=%s, Prenume=%s, Data_Nasterii=%s, Email=%s, Telefon=%s, Adresa=%s WHERE ParticipantID=%s", (nume, prenume, data_nasterii, email, telefon, adresa, id))
    db.commit()
    return redirect(url_for('index'))

@app.route('/delete_participant/<int:id>')
def delete_participant(id):
    cursor = db.cursor()
    cursor.execute("DELETE FROM Participanți WHERE ParticipantID=%s", (id,))
    db.commit()
    return redirect(url_for('index'))

# Interogări intra-tabel
@app.route('/query_participanti')
def query_participanti():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Participanți WHERE Nume LIKE 'A%'")
    results = cursor.fetchall()
    return render_template('query.html', results=results)

# Alte interogări intra-tabel și inter-tabele
# ...

if __name__ == '__main__':
    app.run(debug=True)
