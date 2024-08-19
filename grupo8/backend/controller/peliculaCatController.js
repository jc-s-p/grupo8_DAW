const {obtenerPeliculaCats, crearPeliculaCats, actualizarPeliculaCat} = require('../services/peliculaCatService'); 

async function obtenerPeliculaCatsController(req, res){
    try {
        const peliculaCat = await obtenerPeliculaCats();
        res.json(peliculaCat);
    } catch (error) {
        console.error('Error al obtener Categorías de Películas: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function crearPeliculaCatsController(req, res){
    const peliculaCat = req.body;
    try{
        const insertId = await crearPeliculaCats(peliculaCat);
        res.status(201).json({insertId});
    } catch (error) {
        console.error('Error al crear Categorías de Películas: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function actualizarPeliculaCatsController(req, res){
    const {nuevaCatID, peliculaID, categoriaID, } = req.body;
    try{
        const filasAfectadas = await actualizarPeliculaCat(nuevaCatID, peliculaID, categoriaID);
        if (filasAfectadas>0){
            res.json({message: 'Categoría de película Actualizada'});            
        }else{
            res.status(404).json({message: 'Categoría de película no encontrada'});
        }
    }catch(error){
        console.error('Error al actualizar categoría de película: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}



module.exports = {
    obtenerPeliculaCatsController,
    crearPeliculaCatsController,
    actualizarPeliculaCatsController
};  