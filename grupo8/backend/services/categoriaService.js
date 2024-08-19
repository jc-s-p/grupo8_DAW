const {obtenerConexion} = require('../database/conexionDB')

async function obtenerCategorias(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM categoria';
        return new Promise ((resolve, reject) => {
            connection.query(consulta, (err, filas) => {
                connection.end();
                if(err){
                    console.error("Error al ejecutar consulta: ", err);
                    reject(err);
                }else{
                    resolve(filas);
                }
            });
        });
            
    } catch(err){
        console.error("Error al conectar a la base de datos: " + err);
        throw err;
    }
};

async function crearCategorias(categorias){
    try{
        const connection = await obtenerConexion();
        const consulta = 'INSERT INTO categoria (nombre) values?';
        const valores = categorias.map(categoria => [categoria.nombre]);

        return new Promise((resolve, reject) =>{
            connection.query(consulta, [valores], (err, resultado)=>{
                connection.end();
                if (err){
                    console.error("Error al ejecutar consulta: ", err);
                    reject(err);
                }else{
                    resolve(resultado.insertId)
                }
            });
        });
    } catch(err){
        console.error("Error al conectar la base de datos: "+err);
        throw err;
    }   
}

async function actualizarCategoria(id, nombre){
    try{
        const connection = await obtenerConexion();
        const consulta = 'UPDATE categoria SET nombre = ? where categoriaID = ?';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [nombre, id], (err, resultado) => {
                connection.end();
                if(err){
                    console.error("Error al ejecutar consulta: ", err);
                    reject(err);
                }else{
                    resolve(resultado.affectedRows);
                }
            });
        });
    }catch(err) {
        console.error("Error al conectar a la base de datos: "+err);
        throw err;
    } 
}

module.exports = {
    obtenerCategorias,
    crearCategorias,
    actualizarCategoria
}