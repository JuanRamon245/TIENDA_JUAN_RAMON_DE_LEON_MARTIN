<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Loggin</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap">
	<style>
	
	
		* {
				margin: 0;
				padding: 0;
				box-sizing: border-box;
			}
	
		header, footer {
			margin: 0;
			padding: 0;
		}
	
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #9b9dde;
            display: flex;
            flex-direction:column;
            justify-content: center;
            align-items: center;
        }
        
        .detalles-loggin {
			font-family: 'Open Sans', sans-serif;
			background-color: #9b9dde;
			margin: 0;
            height: 100vh;
            width: 100%;
            padding: 20px;
		}
        
        .contenedor {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 200%;
            margin: 0 auto;
            text-align: center;
            transform: translateX(-25%);
        }

        header {
            margin-bottom: 80px;
            padding: 0;
            background-color: #3b3ea3;
            color: white;
            text-align: center;
            width: 100%;
        }

        footer {
            margin-top: 80px;
            padding: 0;
            background-color: #3b3ea3;
            color: white;
            text-align: center;
            width: 100%;
        }
        
        .tabulacion {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            border-bottom: 2px solid #ddd;
        }
        .tab {
            width: 50%;
            padding: 10px 0;
            cursor: pointer;
            font-weight: 700;
            color: #555;
            border-bottom: 3px solid transparent;
            transition: color 0.3s, border-color 0.3s;
        }
        .tab.active {
            color: #3b3ea3;
            border-bottom-color: #3b3ea3;
        }

        .form-container {
            display: none;
        }
        .form-container.active {
            display: block;
        }
        .form-container h2 {
            margin-bottom: 20px;
            color: #0c1c4d;
        }

        .inputs {
            margin-bottom: 20px;
            text-align: left;
        }

        .inputs label {
            display: block;
            margin-bottom: 5px;
            font-weight: 700;
            color: #555;
        }

        .inputs input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .inputs input:focus {
            border-color: #3b3ea3;
            outline: none;
        }

        .login-button, .register-button {
            background-color: #3b3ea3;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 2px;
            font-size: 22px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        .forgot-password {
            margin-top: 15px;
            display: block;
            color: #007BFF;
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        p.error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

        .message{
            color: green;
            font-size: 20px;
            margin-top: 10px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
    </style>
</head>
<body>

<%@ include file="cabecera.jsp" %>
	
	<main class="detalles-pedido">
		<div class="contenedor">
			<div class="tabulacion">
				<div class="tab active" onclick="switchTab('Logearse')">Iniciar sesión</div>
				<div class="tab" onclick="switchTab('Registrarse')">Registrarse</div>
			</div>
			
			<div class="form-container active" id="loggin-form">
				<h2>Iniciar Sesión</h2>
				
				<form action="Loggin" method="POST">
					<div class="inputs">
						<label class="gmail">Correo: </label>
						<input type="text" id="gmail" name="log_email" required>
					</div>
					<div class="inputs">
						<label class="password">Contraseña: </label>
						<input type="password" id="password" name="log_pass" required>
					</div>
					<button type="submit" class="login-button">Acceder</button>
				</form>
				
	            <a href="#" class="forgot-password">Recuperar contraseña</a>
	            
	            <% String mensaje; 
	               if (request.getAttribute("error") != null) { 
	                   mensaje = (String) request.getAttribute("error"); 
	            %>
		        <p class="error-message"><%= mensaje %></p>
		        <% } %>
			</div>
			
			<div class="form-container" id="Registrer-form">
				<h2>Registrarse</h2>
				
				<form action="Registrer" method="POST">
					<div class="inputs">
						<label class="username">Nombre: </label>
						<input type="text" id="username" name="reg_user" required>
					</div>
					<div class="inputs">
						<label class="surname">Apellidos: </label>
						<input type="text" id="surname" name="reg_sur" required>
					</div>
					<div class="inputs">
						<label class="gmail">Correo: </label>
						<input type="text" id="gmail" name="reg_email" required>
					</div>
					<div class="inputs">
						<label class="password">Contraseña: </label>
						<input type="password" id="password" name="reg_pass" required>
					</div>
					<button type="submit" class="register-button">Registrarse</button>
				</form>
	
	            <% if (request.getAttribute("error") != null) { 
	                   mensaje = (String) request.getAttribute("error"); 
	            %>
		        <p class="error-message"><%= mensaje %></p>
		        <% } %>
			</div>
		</div>
	</main>
	
	<script>
	    function switchTab(tabName) {
	        // Obtener todas las pestañas y formularios
	        var tabs = document.getElementsByClassName('tab');
	        var forms = document.getElementsByClassName('form-container');
	
	        // Ocultar todos los formularios
	        for (var i = 0; i < forms.length; i++) {
	            forms[i].classList.remove('active');
	        }
	
	        // Desactivar todas las pestañas
	        for (var i = 0; i < tabs.length; i++) {
	            tabs[i].classList.remove('active');
	        }
	
	        // Mostrar el formulario seleccionado y activar la pestaña correspondiente
	        if (tabName === 'Logearse') {
	            document.getElementById('loggin-form').classList.add('active');
	            tabs[0].classList.add('active');
	        } else if (tabName === 'Registrarse') {
	            document.getElementById('Registrer-form').classList.add('active');
	            tabs[1].classList.add('active');
	        }
	    }
	</script>
	
	<%@ include file="pieDePagina.jsp" %>
</body>
</html>
