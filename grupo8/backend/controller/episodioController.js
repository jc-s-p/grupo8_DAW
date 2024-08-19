const {obtenerEpisodios, crearEpisodios, actualizarEpisodio,listarEpisodiosSerie} = require('../services/episodioService'); 

async function obtenerEpisodiosController(req, res){
    try {
        const episodios = await obtenerEpisodios();
        res.json(episodios);
    } catch (error) {
        console.error('Error al obtener episodios: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function crearEpisodiosController(req, res){
    const episodios = req.body;
    try{
        const insertId = await crearEpisodios(episodios);
        res.status(201).json({insertId});
    }catch{
        console.error('Error al crear episodios: '+ error);
        res.status(500).json({message: 'Error interno del servidor (POST)'});
    }
}

async function actualizarEpisodioController(req, res){
    const {id} = req.params;
    const {temporadaID, titulo, descripcion, numeroEpisodio, duracion, contenidoURL} = req.body;
    try{
        const filasAfectadas = await actualizarEpisodio(id, temporadaID, titulo, descripcion, numeroEpisodio, duracion, contenidoURL);
        if (filasAfectadas>0){
            res.json({message: 'Episodio Actualizado'});            
        }else{
            res.status(404).json({message: 'Episodio no encontrado'});
        }
    }catch(error){
        console.error('Error al actualizar episodio: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

async function listarEpisodiosSerieController(req, res){
    const {id} = req.params;    
    try{
        const episodiosSerie = await listarEpisodiosSerie(id);
        res.json(episodiosSerie);
    }catch(error){
        console.error('Error al listar categorias: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

module.exports = {
    obtenerEpisodiosController,
    crearEpisodiosController,
    actualizarEpisodioController,
    listarEpisodiosSerieController
};  