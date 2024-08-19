const express= require('express');
const {obtenerUsuariosController}= require('./controller/usuarioController');
const PORT = process.env.PORT || 3000 
const app = express();
app.use(express.json());
app.get('/obtenerUsuarios', obtenerUsuariosController)
app.listen(PORT,() => {
    console.log('Escuchando puerto ' + PORT)
    })
