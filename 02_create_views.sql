-- Tworzenie widoków:

CREATE OR ALTER VIEW lekarze_informacje -- informacje o salach i oddziałach na jakich pracują lekarze
AS 
	SELECT DISTINCT l.*, s.nazwa AS nazwa_sali, o.nazwa AS nazwa_oddzialu
	FROM lekarze AS l 
		JOIN pacjenci AS p ON l.id_lekarza = p.id_lekarza_prowadzacego
		JOIN sale AS s ON p.id_sali = s.id_sali
		JOIN oddzialy AS o ON o.id_oddzialu = s.id_oddzialu;


CREATE OR ALTER VIEW pacjenci_informacje -- informacje o pacjentach, chorobach i salach w jakich przebywają
AS
	SELECT p.*, c.nazwa AS nazwa_choroby, (l.imie + ' ' + l.nazwisko) AS lekarz_prowadzacy, s.nazwa AS nazwa_sali
	FROM pacjenci AS p 
		JOIN choroby_pacjenci AS cp ON cp.id_pacjenta = p.id_pacjenta
		JOIN choroby AS c ON c.id_choroby = cp.id_chorby
		JOIN lekarze AS l ON l.id_lekarza = p.id_lekarza_prowadzacego
		JOIN sale AS s ON s.id_sali = p.id_sali;
