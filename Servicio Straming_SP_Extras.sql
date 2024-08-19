USE servicio_streaming;

-- OTROS PROCEDIMIENTOS ALMACENADOS
DELIMITER //

CREATE PROCEDURE buscarPeliculaPorNombre(IN nombre VARCHAR(100))
BEGIN
    SELECT * FROM Pelicula WHERE titulo LIKE CONCAT('%', nombre, '%');
END //

CREATE PROCEDURE buscarSeriePorNombre(IN nombre VARCHAR(100))
BEGIN
    SELECT * FROM Serie WHERE titulo LIKE CONCAT('%', nombre, '%');
END //

CREATE PROCEDURE buscarCapitulosPorTemporada(IN serieID INT, IN numeroTemporada INT)
BEGIN
    SELECT e.*
    FROM Episodio e
    JOIN Temporada t ON e.temporadaID = t.temporadaID
    WHERE t.serieID = serieID AND t.numeroTemporada = numeroTemporada;
END //

CREATE PROCEDURE verSeriesPorCategoria(IN categoriaID INT)
BEGIN
    SELECT s.*
    FROM Serie s
    JOIN SerieCategoria sc ON s.serieID = sc.serieID
    WHERE sc.categoriaID = categoriaID;
END //

CREATE PROCEDURE verPeliculasPorCategoria(IN categoriaID INT)
BEGIN
    SELECT p.*
    FROM Pelicula p
    JOIN PeliculaCategoria pc ON p.peliculaID = pc.peliculaID
    WHERE pc.categoriaID = categoriaID;
END //

CREATE PROCEDURE buscarActoresPorPelicula(IN peliculaID INT)
BEGIN
    SELECT a.*
    FROM Actor a
    JOIN ActorParticipacion ap ON a.actorID = ap.actorID
    WHERE ap.peliculaID = peliculaID;
END //

CREATE PROCEDURE buscarActoresPorEpisodio(IN episodioID INT)
BEGIN
    SELECT a.*
    FROM Actor a
    JOIN ActorParticipacion ap ON a.actorID = ap.actorID
    WHERE ap.episodioID = episodioID;
END //

CREATE PROCEDURE verHistorialPorPerfil(IN perfilID INT)
BEGIN
    SELECT hv.*, p.titulo AS peliculaTitulo, e.titulo AS episodioTitulo
    FROM HistorialVisto hv
    LEFT JOIN Pelicula p ON hv.peliculaID = p.peliculaID
    LEFT JOIN Episodio e ON hv.episodioID = e.episodioID
    WHERE hv.perfilID = perfilID;
END //

DELIMITER ;