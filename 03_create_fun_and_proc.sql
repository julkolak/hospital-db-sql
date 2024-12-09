-- Tworzenie funkcji, która po podaniu nr sali wypisuje dane pacjentów przypisanych do niej 

CREATE OR ALTER FUNCTION F_Z1 (@numer_sali INT) 
RETURNS TABLE
AS 
RETURN(	SELECT p.* 
		FROM pacjenci AS p 
		JOIN sale AS s ON p.id_sali = s.id_sali
		WHERE s.id_sali = @numer_sali)
GO

SELECT * FROM F_Z1(2)

-- Tworzenie procedury, która będzie sprawdzać czy dany pacjent i lekarz istnieje, jeśli nie, zwróci błąd, a jeśli istnieje to przypisze do niego danego lekarza

CREATE OR ALTER PROC p1 
@Id_pacjenta INT,
@Id_lekarza INT
AS 
	IF NOT EXISTS (SELECT id_pacjenta FROM pacjenci WHERE id_pacjenta = @Id_pacjenta)
	BEGIN
		RAISERROR('Nie ma pacjenta o id %d', 16, 1, @Id_pacjenta)
		RETURN
	END

	IF NOT EXISTS (SELECT id_lekarza FROM lekarze WHERE id_lekarza = @Id_lekarza)
	BEGIN
		RAISERROR('Nie ma lekarza o id %d', 16, 1, @Id_lekarza)
		RETURN
	END

	UPDATE pacjenci 
	SET id_lekarza_prowadzacego = @Id_lekarza
	WHERE id_pacjenta = @Id_pacjenta
GO

EXEC p1 5, 3
