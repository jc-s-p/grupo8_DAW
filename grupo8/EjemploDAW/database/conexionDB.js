const mysql = require("mysql");

function obtenerConexion(){
    return new Promise((resolve, reject)=>{
        const connection = mysql.createConnection({
            host: "localhost",
            user: "root",
            password: "admin123",
            database: "ejemplo"
        });

        connection.connect((error)=>{
            if(error){
                reject(error);
            }else{
                console.log("Conexión establecida con el id: " + connection.threadId);
                resolve(connection);
            }
        });
    });
}

module.exports = {obtenerConexion}