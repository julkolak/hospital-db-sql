-- Tworzenie bazy danych:

CREATE DATABASE Szpital1;

-- Używanie bazy danych:

USE Szpital1;

-- Tworzenie tabeli oddzialy, z klauzulą CHECK dla liczby sal w oddziale

CREATE TABLE oddzialy (
	id_oddzialu INT PRIMARY KEY,
    nazwa VARCHAR(50),
    lokalizacja VARCHAR(50),
    liczba_sal INT CHECK (liczba_sal > 0)
);

-- Tworzenie tabeli sale, z klauzulą CHECK dla maksymalnej pojemności sali

CREATE TABLE sale (
    id_sali INT PRIMARY KEY,
    nazwa VARCHAR(50),
    id_oddzialu INT,
	FOREIGN KEY(id_oddzialu) REFERENCES oddzialy(id_oddzialu),
    max_pojemnosc INT CHECK (max_pojemnosc > 0) -- Klauzula CHECK dla maksymalnej pojemności sali
);

-- Tworzenie tabeli lekarze:

CREATE TABLE lekarze (
    id_lekarza INT PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    specjalizacja VARCHAR(50)
);

-- Tworzenie tabeli pacjenci, z klauzulą CHECK dla wieku pacjenta i płci pacjenta

CREATE TABLE pacjenci (
    id_pacjenta INT PRIMARY KEY,
	id_sali INT,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
	id_lekarza_prowadzacego INT,
	FOREIGN KEY(id_sali) REFERENCES sale(id_sali),
	FOREIGN KEY(id_lekarza_prowadzacego) REFERENCES lekarze(id_lekarza),
    wiek INT CHECK (wiek > 0 AND wiek <= 120),
    plec VARCHAR(10) CHECK (plec IN ('M', 'F'))
);

-- Tworzenie tabeli choroby: 

CREATE TABLE choroby (
    id_choroby INT PRIMARY KEY,
    nazwa VARCHAR(50),
    opis VARCHAR(100)
);

-- Tworzenie tabeli choroby_pacjenci:

CREATE TABLE choroby_pacjenci (
    id_chorby INT,
    id_pacjenta INT,
    FOREIGN KEY (id_chorby) REFERENCES choroby(id_choroby),
    FOREIGN KEY (id_pacjenta) REFERENCES pacjenci(id_pacjenta),
    CHECK (id_chorby > 0 AND id_pacjenta > 0)
);
