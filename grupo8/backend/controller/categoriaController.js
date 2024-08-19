const {obtenerCategorias, crearCategorias, actualizarCategoria} = require('../services/categoriaService'); 

async function obtenerCategoriasController(req, res){
    try {
        const categorias = await obtenerCategorias();
        res.json(categorias);
    } catch (error) {
        console.error('Error al obtener categorías: ' + error);
        res.status(500).json({message: 'Error interno del servidor (GET)'});
    }
}

async function crearCategoriasController(req, res){
    const categorias = req.body;
    try{
        const insertId = await crearCategorias(categorias);
        res.status(201).json({insertId});
    }catch{
        console.error('Error al crear categorías: '+ error);
        res.status(500).json({message: 'Error interno del servidor (POST)'});
    }
}

async function actualizarCategoriaController(req, res){
    const {id} = req.params;
    const {nombre} = req.body;
    try{
        const filasAfectadas = await actualizarCategoria(id, nombre);
        if (filasAfectadas>0){
            res.json({message: 'Categoría Actualizada'});            
        }else{
            res.status(404).json({message: 'Categoría no encontrada'});
        }
    }catch(error){
        console.error('Error al actualizar categoría: '+ error);
        res.status(500).json({message: 'Error interno del servidor (PUT)'});
    }
}

module.exports = {
    obtenerCategoriasController,
    crearCategoriasController,
    actualizarCategoriaController
};