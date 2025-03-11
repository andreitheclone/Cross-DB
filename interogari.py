# Interogare cu clauze secundare
@app.route('/query_participanti2')
def query_participanti2():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Participanți WHERE Data_Nasterii < '2000-01-01' AND Email LIKE '%gmail.com'")
    results = cursor.fetchall()
    return render_template('query.html', results=results)

# Interogare inter-tabel
@app.route('/query_inter_table')
def query_inter_table():
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT p.Nume, p.Prenume, d.Suma, d.Data_Donatie
        FROM Participanți p
        JOIN Donatii d ON p.ParticipantID = d.ParticipantID
    """)
    results = cursor.fetchall()
    return render_template('query.html', results=results)

# Sub-interogare
@app.route('/query_subquery')
def query_subquery():
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT Nume, Prenume FROM Participanți
        WHERE ParticipantID IN (SELECT ParticipantID FROM Donatii WHERE Suma > 100)
    """)
    results = cursor.fetchall()
    return render_template('query.html', results=results)
