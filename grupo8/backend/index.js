const express= require('express');
const {obtenerCategoriasController, crearCategoriasController, actualizarCategoriaController}= require('./controller/categoriaController');
const {obtenerEpisodiosController, crearEpisodiosController, actualizarEpisodioController,listarEpisodiosSerieController}= require('./controller/episodioController');
const {obtenerPeliculasController, crearPeliculasController, actualizarPeliculaController}= require('./controller/peliculaController');
const {obtenerSeriesController, crearSeriesController, actualizarSerieController, listarCategoriasSerieController}= require('./controller/serieController');
const {obtenerTemporadasController, crearTemporadasController, actualizarTemporadaController}= require('./controller/temporadaController');

const {obtenerPeliculaCatsController, crearPeliculaCatsController, actualizarPeliculaCatsController}= require('./controller/peliculaCatController');
const {obtenerSerieCatsController, crearSerieCatsController, actualizarSerieCatsController}= require('./controller/serieCatController');
const PORT = process.env.PORT || 3000 
const app = express();
app.use(express.json());
//Categorías GET POST PUT
app.get('/obtenerCategorias', obtenerCategoriasController)
app.post('/crearCategorias', crearCategoriasController);
app.put('/actualizarCategoria/:id', actualizarCategoriaController)
//Episodios GET POST PUT
app.get('/obtenerEpisodios', obtenerEpisodiosController)
app.post('/crearEpisodios', crearEpisodiosController)
app.put('/actualizarEpisodio/:id', actualizarEpisodioController)
app.get('/listarEpisodiosSerie/:id', listarEpisodiosSerieController)
//Peliculas GET POST PUT
app.get('/obtenerPeliculas', obtenerPeliculasController)
app.post('/crearPeliculas', crearPeliculasController)
app.put('/actualizarPelicula/:id',actualizarPeliculaController)
// Series GET POST PUT
app.get('/obtenerSeries', obtenerSeriesController)
app.post('/crearSeries', crearSeriesController)
app.put('/actualizarSerie/:id', actualizarSerieController)
app.get('/listarCategoriasSeries/:id', listarCategoriasSerieController)
//Temporadas GET POST PUT
app.get('/obtenerTemporadas', obtenerTemporadasController)
app.post('/crearTemporadas', crearTemporadasController)
app.put('/actualizarTemporada/:id', actualizarTemporadaController)
//Peliculas - Categorías GET POST PUT
app.get('/obtenerPeliculaCats', obtenerPeliculaCatsController)
app.post('/crearPeliculasCats', crearPeliculaCatsController)
app.put('/actualizarPeliculaCat', actualizarPeliculaCatsController)
//Series - Categorías GET 
app.get('/obtenerSerieCats', obtenerSerieCatsController)
app.post('/crearSerieCats', crearSerieCatsController)
app.put('/actualizarSerieCat', actualizarSerieCatsController)



app.listen(PORT,() => {
    console.log('Escuchando puerto ' + PORT)
    })
