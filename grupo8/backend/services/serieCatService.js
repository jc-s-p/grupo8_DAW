const {obtenerConexion} = require('../database/conexionDB')
async function obtenerSerieCats(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM serieCategoria';
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

async function crearSerieCats(seriesCats){
    try{
        const connection = await obtenerConexion();
        const consulta = 'INSERT INTO seriecategoria (serieID, categoriaID) values?';
        const valores = seriesCats.map(sc => [sc.serieID, sc.categoriaID]);
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

async function actualizarSerieCat(nuevaCatID, serieID, categoriaID ){
    try{
        const connection = await obtenerConexion();
        const consulta = 'UPDATE seriecategoria SET categoriaID = ? where serieID = ? AND categoriaID = ?';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [nuevaCatID, serieID, categoriaID], (err, resultado) => {
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
    obtenerSerieCats,
    crearSerieCats,
    actualizarSerieCat    
}