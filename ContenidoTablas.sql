use servicio_streaming
-- Insertar categorías
insert INTO Categoria (nombre) VALUES 
('Acción'),
('Aventura'),
('Comedia'),
('Drama'),
('Fantasía'),
('Terror'),
('Ciencia Ficción'),
('Documental');

-- Insertar películas
INSERT INTO Pelicula (titulo, descripcion, fechaEstreno, duracion, portadaURL, contenidoURL) VALUES 
('Inception', 'Un ladrón que roba secretos corporativos mediante el uso de tecnología de compartición de sueños se le asigna la tarea inversa de plantar una idea en la mente de un CEO.', '2010-07-16', 148, 'https://example.com/inception.jpg', 'https://example.com/inception.mp4'),
('The Matrix', 'Un programador pirata se entera de la verdadera naturaleza de su realidad y su papel en la guerra contra sus controladores.', '1999-03-31', 136, 'https://example.com/matrix.jpg', 'https://example.com/matrix.mp4'),
('Titanic', 'Una aristócrata de alto nivel se enamora de un pobre artista a bordo del lujoso y condenado R.M.S. Titanic.', '1997-12-19', 195, 'https://example.com/titanic.jpg', 'https://example.com/titanic.mp4');

-- Insertar series
INSERT INTO Serie (titulo, descripcion, fechaEstreno, portadaURL, contenidoURL) VALUES 
('Game of Thrones', 'Ocho familias nobles luchan por el control del mítico y helado continente de Westeros.', '2011-04-17', 'https://example.com/got.jpg', 'https://example.com/got.mp4'),
('Breaking Bad', 'Un profesor de química de secundaria con cáncer terminal se asocia con un exalumno para asegurar el futuro financiero de su familia fabricando y vendiendo metanfetaminas.', '2008-01-20', 'https://example.com/breakingbad.jpg', 'https://example.com/breakingbad.mp4'),
('Stranger Things', 'Un grupo de niños se enfrentan a fuerzas sobrenaturales y secretos del gobierno mientras buscan a su amigo desaparecido.', '2016-07-15', 'https://example.com/strangerthings.jpg', 'https://example.com/strangerthings.mp4');

-- Insertar temporadas
INSERT INTO Temporada (serieID, numeroTemporada) VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(3, 1),
(3, 2),
(3, 3),
(3, 4);

-- Insertar episodios
INSERT INTO Episodio (temporadaID, titulo, descripcion, numeroEpisodio, duracion, contenidoURL) VALUES 
(1, 'Winter Is Coming', 'Eddard Stark es llamado a la corte del Rey Robert Baratheon tras la misteriosa muerte de Jon Arryn.', 1, 62, 'https://example.com/got_s1_e1.mp4'),
(1, 'The Kingsroad', 'La familia Stark se enfrenta a la separación mientras Eddard viaja al sur.', 2, 56, 'https://example.com/got_s1_e2.mp4'),
(2, 'The North Remembers', 'Robb Stark continúa su lucha contra los Lannister mientras el Norte recuerda.', 1, 53, 'https://example.com/got_s2_e1.mp4'),
(2, 'The Night Lands', 'Tyrion llega a Desembarco del Rey para tomar su lugar como Mano del Rey.', 2, 54, 'https://example.com/got_s2_e2.mp4'),
(9, 'Pilot', 'Walter White, un profesor de química de secundaria, descubre que tiene cáncer terminal y se asocia con un antiguo alumno para fabricar y vender metanfetaminas.', 1, 58, 'https://example.com/breakingbad_s1_e1.mp4'),
(9, 'Cat\'s in the Bag...', 'Walter y Jesse deben deshacerse de dos cadáveres.', 2, 48, 'https://example.com/breakingbad_s1_e2.mp4'),
(16, 'Chapter One: The Vanishing of Will Byers', 'Un niño desaparece, lo que lleva a su madre, un jefe de policía y sus amigos a enfrentarse a fuerzas terroríficas para recuperarlo.', 1, 47, 'https://example.com/strangerthings_s1_e1.mp4'),
(16, 'Chapter Two: The Weirdo on Maple Street', 'Mike esconde a Eleven en su casa, y los chicos aprenden más sobre sus habilidades telequinéticas.', 2, 55, 'https://example.com/strangerthings_s1_e2.mp4');

-- Insertar relaciones de películas con categorías
INSERT INTO PeliculaCategoria (peliculaID, categoriaID) VALUES 
(1, 7),
(2, 7),
(3, 4);

-- Insertar relaciones de series con categorías
INSERT INTO SerieCategoria (serieID, categoriaID) VALUES 
(1, 5),
(2, 4),
(3, 6);
