const {obtenerSeries, crearSeries, actualizarSerie, listarCategoriasSerie} = require('../services/serieService'); 

async function obtenerSeriesController(req, res){
    try {
        const series = await obtenerSeries();
        res.json(series);
    } catch (error) {
        console.error('Error al obtener series: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function crearSeriesController(req, res){
    const series = req.body;
    try{
        const insertId = await crearSeries(series);
        res.status(201).json({insertId});
    }catch{
        console.error('Error al crear series: '+ error);
        res.status(500).json({message: 'Error interno del servidor (POST)'});
    }
}

async function actualizarSerieController(req, res){
    const {id} = req.params;
    const {titulo, descripcion, fechaEstreno, portadaURL, contenidoURL} = req.body;
    try{
        const filasAfectadas = await actualizarSerie(id, titulo, descripcion, fechaEstreno, portadaURL, contenidoURL);
        if (filasAfectadas>0){
            res.json({message: 'Serie Actualizada'});            
        }else{
            res.status(404).json({message: 'Serie no encontrada'});
        }
    }catch(error){
        console.error('Error al actualizar serie: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

async function listarCategoriasSerieController(req, res){
    const {id} = req.params;    
    try{
        const catsSerie = await listarCategoriasSerie(id);
        res.json(catsSerie);
    }catch(error){
        console.error('Error al listar categorias: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

module.exports = {
    obtenerSeriesController,
    crearSeriesController,
    actualizarSerieController,
    listarCategoriasSerieController
};  