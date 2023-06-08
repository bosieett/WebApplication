/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

const registroform = document.getElementById('registroForm');

const inputs = document.querySelectorAll('#registroForm input');

const expresiones = {
    usuario: /^[a-zA-Z0-9\_\-]{4,16}$/, // Letras, numeros, guion y guion_bajo.
    apellido: /^[a-zA-ZÀ-ÿ\s]{1,40}$/,  //Solo acepta letras.
    nombre: /^[a-zA-ZÀ-ÿ\s]{1,40}$/, // Letras y espacios, pueden llevar acentos.
    password: /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[-!.,:;¿?¡!])[a-zA-Z0-9-!.,:;¿?¡!]{8,16}$/, // 8 a 16 caracteres, debe tener minimo una minuscula, mayuscula y acepta digitos.
    correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/ //formato de correo.
};

const campos = {
    nombre : false,
    appaterno : false,
    apmaterno : false,
    email : false,
    usuario : false,
    password : false,
    imagen: true,
    date: true
};

const validarFormulario = (e) => {
   switch (e.target.name){
       case "nombre":
            validarCampo(expresiones.nombre, e.target, 'nombre');
       break;
       case "appaterno":
            validarCampo(expresiones.apellido, e.target, 'apellidoP');
       break;
       case "apmaterno":
            validarCampo(expresiones.nombre, e.target, 'apellidoM');      
       break;
       case "email":
            validarCampo(expresiones.correo, e.target, 'correo');      
       break;
       case "nick":
            validarCampo(expresiones.usuario, e.target, 'usuario');   
       break;
       case "pass":
            validarCampo(expresiones.password, e.target, 'password');  
            validarPassword2();
       break;
       case "confpass":
            validarPassword2();     
       break;
   }
};

const validarCampo = (expresion, input, campo) => {
    if(expresion.test(input.value)){
        document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-incorrecto');
        document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-correcto');
        document.querySelector(`#grupo__${campo} i`).classList.add('fa-circle-check');
        document.querySelector(`#grupo__${campo} i`).classList.remove('fa-circle-xmark');
        document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.remove('formulario__input-error-activo');
        campos[campo] = true;
    }else{
        document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-incorrecto');
        document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-correcto');
        document.querySelector(`#grupo__${campo} i`).classList.add('fa-circle-xmark');
        document.querySelector(`#grupo__${campo} i`).classList.remove('fa-circle-check');
        document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.add('formulario__input-error-activo');
        campos[campo] = false;
    }
};

const validarPassword2 = () => {
    
    const inputPassword1 = document.getElementById('password');
    const inputPassword2 = document.getElementById('password2');
    
    if(inputPassword1.value !== inputPassword2.value){
        document.getElementById(`grupo__password2`).classList.add('formulario__grupo-incorrecto');
        document.getElementById(`grupo__password2`).classList.remove('formulario__grupo-correcto');
        document.querySelector(`#grupo__password2 i`).classList.add('fa-circle-xmark');
        document.querySelector(`#grupo__password2 i`).classList.remove('fa-circle-check');
        document.querySelector(`#grupo__password2 .formulario__input-error`).classList.add('formulario__input-error-activo');
        campos['password'] = false;
    }
    else{
        document.getElementById(`grupo__password2`).classList.remove('formulario__grupo-incorrecto');
        document.getElementById(`grupo__password2`).classList.add('formulario__grupo-correcto');
        document.querySelector(`#grupo__password2 i`).classList.remove('fa-circle-xmark');
        document.querySelector(`#grupo__password2 i`).classList.add('fa-circle-check');
        document.querySelector(`#grupo__password2 .formulario__input-error`).classList.remove('formulario__input-error-activo');
        campos['password'] = true;
    }
};

inputs.forEach((input) => {
    input.addEventListener('keyup', validarFormulario);
    input.addEventListener('blur', validarFormulario);
});

registroform.addEventListener('submit', (e) => {
    //e.preventDefault();
    
    
    if(campos.nombre && campos.appaterno && campos.apmaterno && campos.email && campos.usuario){
        registroform.reset();
        
        document.getElementById('formulario__mensaje-exito').classList.add('formulario__mensaje-exito-activo');
        setTimeout(() => {
            document.getElementById('formulario__mensaje-exito').classList.remove('formulario__mensaje-exito-activo');
        }, 5000);
        
        document.querySelectorAll('.formulario__grupo-correcto').forEach((icono) => {
            icono.classList.remove('formulario__grupo-correcto');
        });
        
        console.log('si estan pasando los datos');
    }
    else {
        document.getElementById('formulario__mensaje').classList.add('formulario__mensaje-activo');
        console.log('no esta jalando esta chingadera');
    }
    
});
