const {obtenerUsuarios} = require('../services/usuarioService'); 

async function obtenerUsuariosController(req, res){
    try {
        const usuarios = await obtenerUsuarios();
        res.json(usuarios);
    } catch (error) {
        console.error('Error al obtener usuarios: ' + error);
        res.status(500).json({message: 'Error interno del servidor'});
    }
}

module.exports = {
    obtenerUsuariosController
};