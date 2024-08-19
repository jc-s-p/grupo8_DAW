const {obtenerConexion} = require('../database/conexionDB')
async function obtenerSeries(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM serie';
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

async function crearSeries(series){
    try{
        const connection = await obtenerConexion();
        const consulta = 'INSERT INTO serie (titulo, descripcion, fechaEstreno, portadaURL, contenidoURL) values?';
        const valores = series.map(se => [se.titulo, se.descripcion, se.fechaEstreno, se.portadaURL, se.contenidoURL]);
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

async function actualizarSerie(id, titulo, descripcion, fechaEstreno, portadaURL, contenidoURL){
    try{
        const connection = await obtenerConexion();
        const consulta = 'UPDATE serie SET titulo = ?, descripcion = ?, fechaEstreno = ?, portadaURL = ?, contenidoURL = ? WHERE peliculaID = ?';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [titulo, descripcion, fechaEstreno, portadaURL, contenidoURL, id], (err, resultado) => {
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

async function listarCategoriasSerie(id){
    try{
        const connection = await obtenerConexion();
        const consulta = 'select c.nombre as categoria from serie s inner join seriecategoria sc on s.serieid = sc.serieid inner join categoria c on sc.categoriaid = c.categoriaid where s.serieid = ? order by c.nombre';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [id], (err, resultado) => {
                connection.end();
                if(err){
                    console.error("Error al ejecutar consulta: ", err);
                    reject(err);
                }else{
                    resolve(resultado);
                }
            });
        });
    }catch(err) {
        console.error("Error al conectar a la base de datos: "+err);
        throw err;
    } 
}


module.exports = {
    obtenerSeries,
    crearSeries,
    actualizarSerie,
    listarCategoriasSerie
}