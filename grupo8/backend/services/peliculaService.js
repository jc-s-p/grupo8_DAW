const {obtenerConexion} = require('../database/conexionDB')
async function obtenerPeliculas(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM pelicula';
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

async function crearPeliculas(peliculas){
    try{
        const connection = await obtenerConexion();
        const consulta = 'INSERT INTO pelicula (titulo, descripcion, fechaEstreno, duracion, portadaURL, contenidoURL) values?';
        const valores = peliculas.map(pe => [pe.titulo, pe.descripcion, pe.fechaEstreno,pe.duracion, pe.portadaURL, pe.contenidoURL]);
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

async function actualizarPelicula(id, titulo, descripcion, fechaEstreno, duracion,portadaURL, contenidoURL){
    try{
        const connection = await obtenerConexion();
        const consulta = 'UPDATE episodio SET titulo = ?, descripcion = ?, fechaEstreno = ?, duracion = ?, portadaURL = ?, contenidoURL = ? WHERE peliculaID = ?';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [titulo, descripcion, fechaEstreno, duracion, portadaURL, contenidoURL, id], (err, resultado) => {
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
    obtenerPeliculas,
    crearPeliculas,
    actualizarPelicula
}