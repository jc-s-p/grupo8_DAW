const {obtenerTemporadas, crearTemporadas, actualizarTemporada} = require('../services/temporadaService'); 

async function obtenerTemporadasController(req, res){
    try {
        const temporadas = await obtenerTemporadas();
        res.json(temporadas);
    } catch (error) {
        console.error('Error al obtener temporada: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

async function crearTemporadasController(req, res){
    const temporadas = req.body;
    try{
        const insertId = await crearTemporadas(temporadas);
        res.status(201).json({insertId});
    }catch{
        console.error('Error al crear temporadas: '+ error);
        res.status(500).json({message: 'Error interno del servidor (POST)'});
    }
}

async function actualizarTemporadaController(req, res){
    const {id} = req.params;
    const {serieID,numeroTemporada} = req.body;
    try{
        const filasAfectadas = await actualizarTemporada(id, serieID, numeroTemporada);
        if (filasAfectadas>0){
            res.json({message: 'Temporada Actualizada'});            
        }else{
            res.status(404).json({message: 'Temporada no encontrada'});
        }
    }catch(error){
        console.error('Error al actualizar temporada: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

module.exports = {
    obtenerTemporadasController,
    crearTemporadasController,
    actualizarTemporadaController
};  