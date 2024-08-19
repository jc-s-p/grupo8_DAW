const {obtenerSerieCats, crearSerieCats, actualizarSerieCat} = require('../services/serieCatService'); 

async function obtenerSerieCatsController(req, res){
    try {
        const serieCat = await obtenerSerieCats();
        res.json(serieCat);
    } catch (error) {
        console.error('Error al obtener Categorías de Series: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function crearSerieCatsController(req, res){
    const serieCat = req.body;
    try{
        const insertId = await crearSerieCats(serieCat);
        res.status(201).json({insertId});
    } catch (error) {
        console.error('Error al crear Categorías de Series: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function actualizarSerieCatsController(req, res){
    const {nuevaCatID, serieID, categoriaID} = req.body;
    try{
        const filasAfectadas = await actualizarSerieCat(nuevaCatID, serieID, categoriaID) ;
        if (filasAfectadas>0){
            res.json({message: 'Categoría de serie Actualizada'});            
        }else{
            res.status(404).json({message: 'Categoría de serie no encontrada'});
        }
    }catch(error){
        console.error('Error al actualizar categoría de serie: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

module.exports = {
    obtenerSerieCatsController,
    crearSerieCatsController,
    actualizarSerieCatsController    
};  