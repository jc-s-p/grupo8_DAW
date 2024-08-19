const {obtenerConexion} = require('../database/conexionDB')
async function obtenerEpisodios(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM episodio';
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

async function crearEpisodios(episodios){
    try{
        const connection = await obtenerConexion();
        const consulta = 'INSERT INTO episodio (temporadaID, titulo, descripcion, numeroEpisodio, duracion, contenidoURL) values?';
        const valores = episodios.map(ep => [ep.temporadaID,ep.titulo,ep.descripcion,ep.numeroEpisodio,ep.duracion,ep.contenidoURL]);
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

async function actualizarEpisodio(id, temporadaID, titulo, descripcion, numeroEpisodio, duracion, contenidoURL){
    try{
        const connection = await obtenerConexion();
        const consulta = 'UPDATE episodio SET temporadaID = ?, titulo = ?, descripcion = ?, numeroEpisodio = ?, duracion = ?, contenidoURL = ? WHERE episodioID = ?';
        return new Promise((resolve, reject) => {
            connection.query(consulta, [temporadaID, titulo, descripcion, numeroEpisodio, duracion, contenidoURL, id], (err, resultado) => {
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

async function listarEpisodiosSerie(id){
    try{
        const connection = await obtenerConexion();
        const consulta = `
            SELECT 
                s.titulo AS Serie,
                t.numeroTemporada AS Temporada,
                e.numeroEpisodio AS Episodio,
                e.titulo AS TituloEpisodio,
                e.descripcion AS DescripcionEpisodio,
                e.duracion AS DuracionEpisodio,
                e.contenidoURL AS URLContenido
            FROM Serie s
            INNER JOIN Temporada t ON s.serieID = t.serieID
            INNER JOIN Episodio e ON t.temporadaID = e.temporadaID
            WHERE s.serieID = ?
            ORDER BY t.numeroTemporada, e.numeroEpisodio;
        `;
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
    obtenerEpisodios,
    crearEpisodios,
    actualizarEpisodio,
    listarEpisodiosSerie
}