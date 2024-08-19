const {obtenerPeliculas, crearPeliculas, actualizarPelicula} = require('../services/peliculaService'); 

async function obtenerPeliculasController(req, res){
    try {
        const peliculas = await obtenerPeliculas();
        res.json(peliculas);
    } catch (error) {
        console.error('Error al obtener peliculas: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function crearPeliculasController(req, res){
    const peliculas = req.body;
    try{
        const insertId = await crearPeliculas(peliculas);
        res.status(201).json({insertId});
    }catch{
        console.error('Error al crear películas: '+ error);
        res.status(500).json({message: 'Error interno del servidor (POST)'});
    }
}

async function actualizarPeliculaController(req, res){
    const {id} = req.params;
    const {titulo, descripcion, fechaEstreno, duracion, portadaURL, contenidoURL} = req.body;
    try{
        const filasAfectadas = await actualizarPelicula(id, titulo, descripcion, fechaEstreno, duracion, portadaURL, contenidoURL);
        if (filasAfectadas>0){
            res.json({message: 'Película Actualizada'});            
        }else{
            res.status(404).json({message: 'Película no encontrada'});
        }
    }catch(error){
        console.error('Error al actualizar película: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

module.exports = {
    obtenerPeliculasController,
    crearPeliculasController,
    actualizarPeliculaController
};  