const {obtenerConexion} = require('../database/conexionDB')
async function obtenerTemporadas(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM temporada';
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

async function crearTemporadas(temporadas){
    try{
        const connection = await obtenerConexion();
        const consulta = 'INSERT INTO temporada (serieID, numeroTemporada) values?';
        const valores = temporadas.map(te => [te.serieID, te.numeroTemporada]);
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

async function actualizarTemporada(id, serieID, numeroTemporada){
    try{
        const connection = await obtenerConexion();
        const consulta = 'UPDATE serie SET serieID = ?, numeroTemporada = ? WHERE peliculaID = ?';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [serieID, numeroTemporada, id], (err, resultado) => {
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
    obtenerTemporadas,
    crearTemporadas,
    actualizarTemporada    
}



