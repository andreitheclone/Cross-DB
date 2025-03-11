DROP DATABASE IF exists cros;
CREATE DATABASE cros;
USE cros;
-- INSTALL PLUGIN mysql_native_password SONAME 'mysql_native_password.so';
 -- SHOW PLUGINS;
 -- ALTER USER 'your_username'@'your_host' IDENTIFIED WITH mysql_native_password BY 'your_password';

 -- Definire Tabele
CREATE TABLE Donatii(
    DonatieID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ParticipantID INT UNSIGNED NOT NULL,
    Suma INT UNSIGNED NOT NULL,
    Data_Donatie DATE NOT NULL
);
CREATE TABLE Participanți(
    ParticipantID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nume VARCHAR(200) NOT NULL,
    Prenume VARCHAR(200) NOT NULL,
    Data_Nasterii DATE NOT NULL,
    Email VARCHAR(200) NOT NULL,
    Telefon VARCHAR(200) NOT NULL,
    Adresa VARCHAR(200) NOT NULL
    
);
CREATE TABLE Inregistrare(
    InregistrareID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ParticipantID INT UNSIGNED NOT NULL,
    EvenimentID INT UNSIGNED NOT NULL,
    Data_Inregistrare DATE NOT NULL,
    -- TraseuID INT UNSIGNED NOT NULL,
    result_id INT UNSIGNED NOT NULL
);
CREATE TABLE Evenimente(
    EvenimentID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nume_Eveniment VARCHAR(200) NOT NULL,
    Data_Eveniment DATE NOT NULL,
    Locatie VARCHAR(200) NOT NULL,
    Descriere VARCHAR(200) NOT NULL,
    TraseuID INT UNSIGNED NOT NULL
);
CREATE TABLE Trasee(
    TraseuID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nume_Traseu VARCHAR(200) NOT NULL,
    Distanta INT UNSIGNED NOT NULL,
    Dificultate VARCHAR(200) NOT NULL
);
CREATE TABLE Rezultate(
    result_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    participant_id INT UNSIGNED NOT NULL,
    event_id INT UNSIGNED NOT NULL,
    timp_final TIME NOT NULL
);

 -- Legaturi intre tabele
ALTER TABLE
    Inregistrare ADD CONSTRAINT inregistrare_evenimentid_foreign FOREIGN KEY(EvenimentID) REFERENCES Evenimente(EvenimentID) ON DELETE CASCADE ;
ALTER TABLE
    Inregistrare ADD CONSTRAINT inregistrare_result_id_foreign FOREIGN KEY(result_id) REFERENCES Rezultate(result_id) ON DELETE CASCADE ;
ALTER TABLE
    Rezultate ADD CONSTRAINT rezultate_event_id_foreign FOREIGN KEY(event_id) REFERENCES Evenimente(EvenimentID) ON DELETE CASCADE ;
ALTER TABLE
    Donatii ADD CONSTRAINT donatii_participantid_foreign FOREIGN KEY(ParticipantID) REFERENCES Participanți(ParticipantID) ON DELETE CASCADE ;
ALTER TABLE
    Evenimente ADD CONSTRAINT evenimente_traseuid_foreign FOREIGN KEY(TraseuID) REFERENCES Trasee(TraseuID) ON DELETE CASCADE ;
ALTER TABLE
    Inregistrare ADD CONSTRAINT inregistrare_participantid_foreign FOREIGN KEY(ParticipantID) REFERENCES Participanți(ParticipantID) ON DELETE CASCADE ;
  
  -- Constrangeri de domeniu
ALTER TABLE  Participanți ADD CONSTRAINT unique_constr_telefon UNIQUE ( Telefon );
ALTER TABLE Participanți ADD CONSTRAINT check_data_nasterii CHECK (Data_Nasterii < '2024-01-01');

INSERT INTO Trasee (Nume_Traseu, Distanta, Dificultate) VALUES
('Traseu Montan', 10, 'Mediu'),
('Traseu Urban', 5, 'Usor'),
('Traseu Forestier', 15, 'Dificil');

INSERT INTO Evenimente (Nume_Eveniment, Data_Eveniment, Locatie, Descriere, TraseuID) VALUES
('Maraton Montan', '2024-06-15', 'Brasov', 'Cursa prin muntii Brasovului', 1),
('Cros Urban', '2024-07-20', 'Bucuresti', 'Cursa prin centrul Bucurestiului', 2),
('Cros Forestier', '2024-09-10', 'Sinaia', 'Cursa prin padurile Sinaiei', 3);

INSERT INTO Participanți (Nume, Prenume, Data_Nasterii, Email, Telefon, Adresa) VALUES
('Popescu', 'Ion', '1990-05-10', 'ion.popescu@example.com', '0712345678', 'Str. Libertatii 10, Bucuresti'),
('Ionescu', 'Maria', '1985-11-22', 'maria.ionescu@example.com', '0723456789', 'Str. Victoriei 5, Cluj-Napoca'),
('Georgescu', 'Alex', '1992-08-15', 'alex.georgescu@example.com', '0734567890', 'Str. Unirii 3, Iasi'),
('Mihai', 'Valeriu', '1990-07-12', 'mihai.valeriu@gmail.com', '0745673456', 'Str. Egalitatii 10, Craoiva');

INSERT INTO Donatii (ParticipantID, Suma, Data_Donatie) VALUES
(1, 100, '2024-04-01'),
(2, 150, '2024-04-15'),
(3, 200, '2024-05-10'),
(4, 500, '2024-05-12');

INSERT INTO Rezultate (participant_id, event_id, timp_final) VALUES
(1, 1, '01:30:00'),
(2, 2, '00:45:00'),
(3, 3, '02:15:00'),
(4, 2, '00:10:00');

INSERT INTO Inregistrare (ParticipantID, EvenimentID, Data_Inregistrare, result_id) VALUES
(1, 1, '2024-05-01', 1),
(2, 2, '2024-06-01', 2),
(3, 3, '2024-08-01', 3),
(4, 2, '2024-09-01', 4);

SELECT ev.Nume_Eveniment, COUNT(inr.ParticipantID) AS Nr_Participanti
     FROM Evenimente ev
    JOIN Inregistrare inr ON ev.EvenimentID = inr.EvenimentID
    GROUP BY ev.Nume_Eveniment;



























