CREATE DATABASE servicio_streaming;
USE servicio_streaming;
-- Tablas
-- Usuario

CREATE TABLE Usuario (
    usuarioID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100),
    fechaRegistro DATE
);

-- Perfil
CREATE TABLE Perfil (
    perfilID INT AUTO_INCREMENT PRIMARY KEY,
    usuarioID INT,
    nombre VARCHAR(100),
    preferencias TEXT,
    FOREIGN KEY (usuarioID) REFERENCES Usuario(usuarioID)
);

-- Pelicula
CREATE TABLE Pelicula (
    peliculaID INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    descripcion TEXT,
    fechaEstreno DATE,
    duracion INT,
    portadaURL VARCHAR(255),
    contenidoURL VARCHAR(255)
);

-- Serie
CREATE TABLE Serie (
    serieID INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    descripcion TEXT,
    fechaEstreno DATE,
    portadaURL VARCHAR(255),
    contenidoURL VARCHAR(255)
);

-- Temporada
CREATE TABLE Temporada (
    temporadaID INT AUTO_INCREMENT PRIMARY KEY,
    serieID INT,
    numeroTemporada INT,
    FOREIGN KEY (serieID) REFERENCES Serie(serieID)
);

-- Episodio
CREATE TABLE Episodio (
    episodioID INT AUTO_INCREMENT PRIMARY KEY,
    temporadaID INT,
    titulo VARCHAR(100),
    descripcion TEXT,
    numeroEpisodio INT,
    duracion INT,
    contenidoURL VARCHAR(255),
    FOREIGN KEY (temporadaID) REFERENCES Temporada(temporadaID)
);

-- HistorialVisto
CREATE TABLE HistorialVisto (
    historialID INT AUTO_INCREMENT PRIMARY KEY,
    perfilID INT,
    peliculaID INT,
    episodioID INT,
    fechaVisto DATE,
    FOREIGN KEY (perfilID) REFERENCES Perfil(perfilID),
    FOREIGN KEY (peliculaID) REFERENCES Pelicula(peliculaID),
    FOREIGN KEY (episodioID) REFERENCES Episodio(episodioID)
);

-- Reseña
CREATE TABLE Reseña (
    reseñaID INT AUTO_INCREMENT PRIMARY KEY,
    perfilID INT,
    peliculaID INT,
    episodioID INT,
    texto TEXT,
    rating INT,
    fechaReseña DATE,
    FOREIGN KEY (perfilID) REFERENCES Perfil(perfilID),
    FOREIGN KEY (peliculaID) REFERENCES Pelicula(peliculaID),
    FOREIGN KEY (episodioID) REFERENCES Episodio(episodioID)
);

-- PlanSuscripción
CREATE TABLE PlanSuscripción (
    planID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    duracionDias INT
);

-- Pago
CREATE TABLE Pago (
    pagoID INT AUTO_INCREMENT PRIMARY KEY,
    usuarioID INT,
    planID INT,
    fechaPago DATE,
    cantidad DECIMAL(10, 2),
    FOREIGN KEY (usuarioID) REFERENCES Usuario(usuarioID),
    FOREIGN KEY (planID) REFERENCES PlanSuscripción(planID)
);

-- Actor
CREATE TABLE Actor (
    actorID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    biografia TEXT
);

-- ActorParticipacion
CREATE TABLE ActorParticipacion (
    participacionID INT AUTO_INCREMENT PRIMARY KEY,
    actorID INT,
    peliculaID INT,
    episodioID INT,
    nombrePersonaje VARCHAR(100),
    FOREIGN KEY (actorID) REFERENCES Actor(actorID),
    FOREIGN KEY (peliculaID) REFERENCES Pelicula(peliculaID),
    FOREIGN KEY (episodioID) REFERENCES Episodio(episodioID)
);

-- BandaSonora
CREATE TABLE BandaSonora (
    bandaSonoraID INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    compositor VARCHAR(100),
    peliculaID INT,
    episodioID INT,
    FOREIGN KEY (peliculaID) REFERENCES Pelicula(peliculaID),
    FOREIGN KEY (episodioID) REFERENCES Episodio(episodioID)
);

-- Curiosidad
CREATE TABLE Curiosidad (
    curiosidadID INT AUTO_INCREMENT PRIMARY KEY,
    texto TEXT,
    peliculaID INT,
    episodioID INT,
    FOREIGN KEY (peliculaID) REFERENCES Pelicula(peliculaID),
    FOREIGN KEY (episodioID) REFERENCES Episodio(episodioID)
);

-- Categoria
CREATE TABLE Categoria (
    categoriaID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- PeliculaCategoria
CREATE TABLE PeliculaCategoria (
    peliculaID INT,
    categoriaID INT,
    PRIMARY KEY (peliculaID, categoriaID),
    FOREIGN KEY (peliculaID) REFERENCES Pelicula(peliculaID),
    FOREIGN KEY (categoriaID) REFERENCES Categoria(categoriaID)
);

-- SerieCategoria
CREATE TABLE SerieCategoria (
    serieID INT,
    categoriaID INT,
    PRIMARY KEY (serieID, categoriaID),
    FOREIGN KEY (serieID) REFERENCES Serie(serieID),
    FOREIGN KEY (categoriaID) REFERENCES Categoria(categoriaID)
);

-- //////////////////////////
-- //////////////////////////
-- //////////////////////////
-- //////////////////////////
-- //////////////////////////
-- Métodos (Procedimientos Almacenados)

-- Usuario
DELIMITER //

CREATE PROCEDURE crearUsuario(
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100)
)
BEGIN
    INSERT INTO Usuario (nombre, email, password, fechaRegistro)
    VALUES (p_nombre, p_email, p_password, CURDATE());
END//

CREATE PROCEDURE leerUsuario(
    IN p_usuarioID INT
)
BEGIN
    SELECT * FROM Usuario WHERE usuarioID = p_usuarioID;
END//

CREATE PROCEDURE actualizarUsuario(
    IN p_usuarioID INT,
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100)
)
BEGIN
    UPDATE Usuario
    SET nombre = p_nombre, email = p_email, password = p_password
    WHERE usuarioID = p_usuarioID;
END//

CREATE PROCEDURE eliminarUsuario(
    IN p_usuarioID INT
)
BEGIN
    DELETE FROM Usuario WHERE usuarioID = p_usuarioID;
END//

// DELIMITER ;

-- Perfil
DELIMITER //

CREATE PROCEDURE crearPerfil(
    IN p_usuarioID INT,
    IN p_nombre VARCHAR(100),
    IN p_preferencias TEXT
)
BEGIN
    INSERT INTO Perfil (usuarioID, nombre, preferencias)
    VALUES (p_usuarioID, p_nombre, p_preferencias);
END//

CREATE PROCEDURE leerPerfil(
    IN p_perfilID INT
)
BEGIN
    SELECT * FROM Perfil WHERE perfilID = p_perfilID;
END//

CREATE PROCEDURE actualizarPerfil(
    IN p_perfilID INT,
    IN p_nombre VARCHAR(100),
    IN p_preferencias TEXT
)
BEGIN
    UPDATE Perfil
    SET nombre = p_nombre, preferencias = p_preferencias
    WHERE perfilID = p_perfilID;
END//

CREATE PROCEDURE eliminarPerfil(
    IN p_perfilID INT
)
BEGIN
    DELETE FROM Perfil WHERE perfilID = p_perfilID;
END//

// DELIMITER ;

-- Pelicula
DELIMITER //

CREATE PROCEDURE crearPelicula(
    IN p_titulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_fechaEstreno DATE,
    IN p_duracion INT,
    IN p_portadaURL VARCHAR(255),
    IN p_contenidoURL VARCHAR(255)
)
BEGIN
    INSERT INTO Pelicula (titulo, descripcion, fechaEstreno, duracion, portadaURL, contenidoURL)
    VALUES (p_titulo, p_descripcion, p_fechaEstreno, p_duracion, p_portadaURL, p_contenidoURL);
END//

CREATE PROCEDURE leerPelicula(
    IN p_peliculaID INT
)
BEGIN
    SELECT * FROM Pelicula WHERE peliculaID = p_peliculaID;
END//

CREATE PROCEDURE actualizarPelicula(
    IN p_peliculaID INT,
    IN p_titulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_fechaEstreno DATE,
    IN p_duracion INT,
    IN p_portadaURL VARCHAR(255),
    IN p_contenidoURL VARCHAR(255)
)
BEGIN
    UPDATE Pelicula
    SET titulo = p_titulo, descripcion = p_descripcion, fechaEstreno = p_fechaEstreno,
        duracion = p_duracion, portadaURL = p_portadaURL, contenidoURL = p_contenidoURL
    WHERE peliculaID = p_peliculaID;
END//

CREATE PROCEDURE eliminarPelicula(
    IN p_peliculaID INT
)
BEGIN
    DELETE FROM Pelicula WHERE peliculaID = p_peliculaID;
END//

// DELIMITER ;

-- Serie
DELIMITER //

CREATE PROCEDURE crearSerie(
    IN p_titulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_fechaEstreno DATE,
    IN p_portadaURL VARCHAR(255),
    IN p_contenidoURL VARCHAR(255)
)
BEGIN
    INSERT INTO Serie (titulo, descripcion, fechaEstreno, portadaURL, contenidoURL)
    VALUES (p_titulo, p_descripcion, p_fechaEstreno, p_portadaURL, p_contenidoURL);
END//

CREATE PROCEDURE leerSerie(
    IN p_serieID INT
)
BEGIN
    SELECT * FROM Serie WHERE serieID = p_serieID;
END//

CREATE PROCEDURE actualizarSerie(
    IN p_serieID INT,
    IN p_titulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_fechaEstreno DATE,
    IN p_portadaURL VARCHAR(255),
    IN p_contenidoURL VARCHAR(255)
)
BEGIN
    UPDATE Serie
    SET titulo = p_titulo, descripcion = p_descripcion, fechaEstreno = p_fechaEstreno,
        portadaURL = p_portadaURL, contenidoURL = p_contenidoURL
    WHERE serieID = p_serieID;
END//

CREATE PROCEDURE eliminarSerie(
    IN p_serieID INT
)
BEGIN
    DELETE FROM Serie WHERE serieID = p_serieID;
END//

// DELIMITER ;

-- Temporada
DELIMITER //

CREATE PROCEDURE crearTemporada(
    IN p_serieID INT,
    IN p_numeroTemporada INT
)
BEGIN
    INSERT INTO Temporada (serieID, numeroTemporada)
    VALUES (p_serieID, p_numeroTemporada);
END//

CREATE PROCEDURE leerTemporada(
    IN p_temporadaID INT
)
BEGIN
    SELECT * FROM Temporada WHERE temporadaID = p_temporadaID;
END//

CREATE PROCEDURE actualizarTemporada(
    IN p_temporadaID INT,
    IN p_numeroTemporada INT
)
BEGIN
    UPDATE Temporada
    SET numeroTemporada = p_numeroTemporada
    WHERE temporadaID = p_temporadaID;
END//

CREATE PROCEDURE eliminarTemporada(
    IN p_temporadaID INT
)
BEGIN
    DELETE FROM Temporada WHERE temporadaID = p_temporadaID;
END//

// DELIMITER ;

-- Episodio
DELIMITER //

CREATE PROCEDURE crearEpisodio(
    IN p_temporadaID INT,
    IN p_titulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_numeroEpisodio INT,
    IN p_duracion INT,
    IN p_contenidoURL VARCHAR(255)
)
BEGIN
    INSERT INTO Episodio (temporadaID, titulo, descripcion, numeroEpisodio, duracion, contenidoURL)
    VALUES (p_temporadaID, p_titulo, p_descripcion, p_numeroEpisodio, p_duracion, p_contenidoURL);
END//

CREATE PROCEDURE leerEpisodio(
    IN p_episodioID INT
)
BEGIN
    SELECT * FROM Episodio WHERE episodioID = p_episodioID;
END//

CREATE PROCEDURE actualizarEpisodio(
    IN p_episodioID INT,
    IN p_titulo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_numeroEpisodio INT,
    IN p_duracion INT,
    IN p_contenidoURL VARCHAR(255)
)
BEGIN
    UPDATE Episodio
    SET titulo = p_titulo, descripcion = p_descripcion, numeroEpisodio = p_numeroEpisodio,
        duracion = p_duracion, contenidoURL = p_contenidoURL
    WHERE episodioID = p_episodioID;
END//

CREATE PROCEDURE eliminarEpisodio(
    IN p_episodioID INT
)
BEGIN
    DELETE FROM Episodio WHERE episodioID = p_episodioID;
END//

// DELIMITER ;

-- HistorialVisto
DELIMITER //

CREATE PROCEDURE crearHistorialVisto(
    IN p_perfilID INT,
    IN p_peliculaID INT,
    IN p_episodioID INT
)
BEGIN
    INSERT INTO HistorialVisto (perfilID, peliculaID, episodioID, fechaVisto)
    VALUES (p_perfilID, p_peliculaID, p_episodioID, CURDATE());
END//

CREATE PROCEDURE leerHistorialVisto(
    IN p_historialID INT
)
BEGIN
    SELECT * FROM HistorialVisto WHERE historialID = p_historialID;
END//

CREATE PROCEDURE actualizarHistorialVisto(
    IN p_historialID INT,
    IN p_perfilID INT,
    IN p_peliculaID INT,
    IN p_episodioID INT
)
BEGIN
    UPDATE HistorialVisto
    SET perfilID = p_perfilID, peliculaID = p_peliculaID, episodioID = p_episodioID
    WHERE historialID = p_historialID;
END//

CREATE PROCEDURE eliminarHistorialVisto(
    IN p_historialID INT
)
BEGIN
    DELETE FROM HistorialVisto WHERE historialID = p_historialID;
END//

// DELIMITER ;

-- Reseña
DELIMITER //

CREATE PROCEDURE crearReseña(
    IN p_perfilID INT,
    IN p_peliculaID INT,
    IN p_episodioID INT,
    IN p_texto TEXT,
    IN p_rating INT
)
BEGIN
    INSERT INTO Reseña (perfilID, peliculaID, episodioID, texto, rating, fechaReseña)
    VALUES (p_perfilID, p_peliculaID, p_episodioID, p_texto, p_rating, CURDATE());
END//

CREATE PROCEDURE leerReseña(
    IN p_reseñaID INT
)
BEGIN
    SELECT * FROM Reseña WHERE reseñaID = p_reseñaID;
END//

CREATE PROCEDURE actualizarReseña(
    IN p_reseñaID INT,
    IN p_texto TEXT,
    IN p_rating INT
)
BEGIN
    UPDATE Reseña
    SET texto = p_texto, rating = p_rating
    WHERE reseñaID = p_reseñaID;
END//

CREATE PROCEDURE eliminarReseña(
    IN p_reseñaID INT
)
BEGIN
    DELETE FROM Reseña WHERE reseñaID = p_reseñaID;
END//

// DELIMITER ;

-- PlanSuscripción
DELIMITER //

CREATE PROCEDURE crearPlanSuscripción(
    IN p_nombre VARCHAR(100),
    IN p_precio DECIMAL(10, 2),
    IN p_duracionDias INT
)
BEGIN
    INSERT INTO PlanSuscripción (nombre, precio, duracionDias)
    VALUES (p_nombre, p_precio, p_duracionDias);
END//

CREATE PROCEDURE leerPlanSuscripción(
    IN p_planID INT
)
BEGIN
    SELECT * FROM PlanSuscripción WHERE planID = p_planID;
END//

CREATE PROCEDURE actualizarPlanSuscripción(
    IN p_planID INT,
    IN p_nombre VARCHAR(100),
    IN p_precio DECIMAL(10, 2),
    IN p_duracionDias INT
)
BEGIN
    UPDATE PlanSuscripción
    SET nombre = p_nombre, precio = p_precio, duracionDias = p_duracionDias
    WHERE planID = p_planID;
END//

CREATE PROCEDURE eliminarPlanSuscripción(
    IN p_planID INT
)
BEGIN
    DELETE FROM PlanSuscripción WHERE planID = p_planID;
END//

// DELIMITER ;

-- Pago
DELIMITER //

CREATE PROCEDURE crearPago(
    IN p_usuarioID INT,
    IN p_planID INT,
    IN p_cantidad DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Pago (usuarioID, planID, fechaPago, cantidad)
    VALUES (p_usuarioID, p_planID, CURDATE(), p_cantidad);
END//

CREATE PROCEDURE leerPago(
    IN p_pagoID INT
)
BEGIN
    SELECT * FROM Pago WHERE pagoID = p_pagoID;
END//

CREATE PROCEDURE actualizarPago(
    IN p_pagoID INT,
    IN p_cantidad DECIMAL(10, 2)
)
BEGIN
    UPDATE Pago
    SET cantidad = p_cantidad
    WHERE pagoID = p_pagoID;
END//

CREATE PROCEDURE eliminarPago(
    IN p_pagoID INT
)
BEGIN
    DELETE FROM Pago WHERE pagoID = p_pagoID;
END//

// DELIMITER ;

-- Actor
DELIMITER //

CREATE PROCEDURE crearActor(
    IN p_nombre VARCHAR(100),
    IN p_biografia TEXT
)
BEGIN
    INSERT INTO Actor (nombre, biografia)
    VALUES (p_nombre, p_biografia);
END//

CREATE PROCEDURE leerActor(
    IN p_actorID INT
)
BEGIN
    SELECT * FROM Actor WHERE actorID = p_actorID;
END//

CREATE PROCEDURE actualizarActor(
    IN p_actorID INT,
    IN p_nombre VARCHAR(100),
    IN p_biografia TEXT
)
BEGIN
    UPDATE Actor
    SET nombre = p_nombre, biografia = p_biografia
    WHERE actorID = p_actorID;
END//

CREATE PROCEDURE eliminarActor(
    IN p_actorID INT
)
BEGIN
    DELETE FROM Actor WHERE actorID = p_actorID;
END//

// DELIMITER ;

-- ActorParticipacion
DELIMITER //

CREATE PROCEDURE crearActorParticipacion(
    IN p_actorID INT,
    IN p_peliculaID INT,
    IN p_episodioID INT,
    IN p_nombrePersonaje VARCHAR(100)
)
BEGIN
    INSERT INTO ActorParticipacion (actorID, peliculaID, episodioID, nombrePersonaje)
    VALUES (p_actorID, p_peliculaID, p_episodioID, p_nombrePersonaje);
END//

CREATE PROCEDURE leerActorParticipacion(
    IN p_participacionID INT
)
BEGIN
    SELECT * FROM ActorParticipacion WHERE participacionID = p_participacionID;
END//

CREATE PROCEDURE actualizarActorParticipacion(
    IN p_participacionID INT,
    IN p_nombrePersonaje VARCHAR(100)
)
BEGIN
    UPDATE ActorParticipacion
    SET nombrePersonaje = p_nombrePersonaje
    WHERE participacionID = p_participacionID;
END//

CREATE PROCEDURE eliminarActorParticipacion(
    IN p_participacionID INT
)
BEGIN
    DELETE FROM ActorParticipacion WHERE participacionID = p_participacionID;
END//

// DELIMITER ;

-- BandaSonora
DELIMITER //

CREATE PROCEDURE crearBandaSonora(
    IN p_titulo VARCHAR(100),
    IN p_compositor VARCHAR(100),
    IN p_peliculaID INT,
    IN p_episodioID INT
)
BEGIN
    INSERT INTO BandaSonora (titulo, compositor, peliculaID, episodioID)
    VALUES (p_titulo, p_compositor, p_peliculaID, p_episodioID);
END//

CREATE PROCEDURE leerBandaSonora(
    IN p_bandaSonoraID INT
)
BEGIN
    SELECT * FROM BandaSonora WHERE bandaSonoraID = p_bandaSonoraID;
END//

CREATE PROCEDURE actualizarBandaSonora(
    IN p_bandaSonoraID INT,
    IN p_titulo VARCHAR(100),
    IN p_compositor VARCHAR(100)
)
BEGIN
    UPDATE BandaSonora
    SET titulo = p_titulo, compositor = p_compositor
    WHERE bandaSonoraID = p_bandaSonoraID;
END//

CREATE PROCEDURE eliminarBandaSonora(
    IN p_bandaSonoraID INT
)
BEGIN
    DELETE FROM BandaSonora WHERE bandaSonoraID = p_bandaSonoraID;
END//

// DELIMITER ;

-- Curiosidad
DELIMITER //

CREATE PROCEDURE crearCuriosidad(
    IN p_texto TEXT,
    IN p_peliculaID INT,
    IN p_episodioID INT
)
BEGIN
    INSERT INTO Curiosidad (texto, peliculaID, episodioID)
    VALUES (p_texto, p_peliculaID, p_episodioID);
END//

CREATE PROCEDURE leerCuriosidad(
    IN p_curiosidadID INT
)
BEGIN
    SELECT * FROM Curiosidad WHERE curiosidadID = p_curiosidadID;
END//

CREATE PROCEDURE actualizarCuriosidad(
    IN p_curiosidadID INT,
    IN p_texto TEXT
)
BEGIN
    UPDATE Curiosidad
    SET texto = p_texto
    WHERE curiosidadID = p_curiosidadID;
END//

CREATE PROCEDURE eliminarCuriosidad(
    IN p_curiosidadID INT
)
BEGIN
    DELETE FROM Curiosidad WHERE curiosidadID = p_curiosidadID;
END//

// DELIMITER ;

-- Categoria
DELIMITER //

CREATE PROCEDURE crearCategoria(
    IN p_nombre VARCHAR(100)
)
BEGIN
    INSERT INTO Categoria (nombre)
    VALUES (p_nombre);
END//

CREATE PROCEDURE leerCategoria(
    IN p_categoriaID INT
)
BEGIN
    SELECT * FROM Categoria WHERE categoriaID = p_categoriaID;
END//

CREATE PROCEDURE actualizarCategoria(
    IN p_categoriaID INT,
    IN p_nombre VARCHAR(100)
)
BEGIN
    UPDATE Categoria
    SET nombre = p_nombre
    WHERE categoriaID = p_categoriaID;
END//

CREATE PROCEDURE eliminarCategoria(
    IN p_categoriaID INT
)
BEGIN
    DELETE FROM Categoria WHERE categoriaID = p_categoriaID;
END//

// DELIMITER ;

-- PeliculaCategoria
DELIMITER //

CREATE PROCEDURE crearPeliculaCategoria(
    IN p_peliculaID INT,
    IN p_categoriaID INT
)
BEGIN
    INSERT INTO PeliculaCategoria (peliculaID, categoriaID)
    VALUES (p_peliculaID, p_categoriaID);
END//

CREATE PROCEDURE leerPeliculaCategoria(
    IN p_peliculaID INT,
    IN p_categoriaID INT
)
BEGIN
    SELECT * FROM PeliculaCategoria WHERE peliculaID = p_peliculaID AND categoriaID = p_categoriaID;
END//

CREATE PROCEDURE eliminarPeliculaCategoria(
    IN p_peliculaID INT,
    IN p_categoriaID INT
)
BEGIN
    DELETE FROM PeliculaCategoria WHERE peliculaID = p_peliculaID AND categoriaID = p_categoriaID;
END//

// DELIMITER ;

-- SerieCategoria
DELIMITER //

CREATE PROCEDURE crearSerieCategoria(
    IN p_serieID INT,
    IN p_categoriaID INT
)
BEGIN
    INSERT INTO SerieCategoria (serieID, categoriaID)
    VALUES (p_serieID, p_categoriaID);
END//

CREATE PROCEDURE leerSerieCategoria(
    IN p_serieID INT,
    IN p_categoriaID INT
)
BEGIN
    SELECT * FROM SerieCategoria WHERE serieID = p_serieID AND categoriaID = p_categoriaID;
END//

CREATE PROCEDURE eliminarSerieCategoria(
    IN p_serieID INT,
    IN p_categoriaID INT
)
BEGIN
    DELETE FROM SerieCategoria WHERE serieID = p_serieID AND categoriaID = p_categoriaID;
END//

// DELIMITER ;

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
