const {obtenerConexion} = require('../database/conexionDB')
async function obtenerUsuarios(){
    try{
        const connection = await obtenerConexion();
        const consulta = 'SELECT * FROM usuario';
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

module.exports = {
    obtenerUsuarios
}