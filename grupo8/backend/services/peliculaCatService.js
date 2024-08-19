const {obtenerConexion} = require('../database/conexionDB')
async function obtenerPeliculaCats(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM peliculaCategoria';
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

async function crearPeliculaCats(peliculasCats){
    try{
        const connection = await obtenerConexion();
        const consulta = 'INSERT INTO peliculacategoria (peliculaID, categoriaID) values?';
        const valores = peliculasCats.map(pc => [pc.peliculaID, pc.categoriaID]);
        return new Promise((resolve, reject) =>{
            connection.query(consulta, [valores], (err, resultado)=>{
                connection.end();
                if (err){
                    console.error("Error al ejecutar consulta: ", err);
                    reject(err);
                }else{
                    resolve(resultado)
                }
            });
        });
    } catch(err){
        console.error("Error al conectar la base de datos: "+err);
        throw err;
    }   
}

async function actualizarPeliculaCat(nuevaCatID, peliculaID, categoriaID){
    try{
        const connection = await obtenerConexion();
        const consulta = 'UPDATE peliculacategoria SET categoriaID = ? where peliculaID = ? AND categoriaID = ?';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [nuevaCatID, peliculaID, categoriaID], (err, resultado) => {
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
    obtenerPeliculaCats,
    crearPeliculaCats,
    actualizarPeliculaCat
}