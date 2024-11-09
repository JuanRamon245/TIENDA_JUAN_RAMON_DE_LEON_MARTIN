<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Pago</title>
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
        
        .detalles-pago {
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
            width: 50%;
            margin: 0 auto;
            text-align: center;
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

        .pagoP-button, .pagoT-button {
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
	
	<main class="detalles-pago">
		<div class="contenedor">
			<div class="tabulacion">
				<div class="tab active" onclick="switchTab('Paypal')">Paypal</div>
				<div class="tab" onclick="switchTab('Tarjeta')">Tarjeta</div>
			</div>
			
			<div class="form-container active" id="paypal-form">
				<h2>Paypal</h2>
				
				<form action="pagarPedidoPaypal" method="POST">
					<div class="inputs">
						<label class="gmail">Correo: </label>
						<input type="text" id="gmail" name="pay_email" required>
					</div>
					<div class="inputs">
						<label class="password">Contraseña: </label>
						<input type="password" id="password" name="pay_pass" required>
					</div>
					<button type="submit" class="pagoP-button">Pagar</button>
				</form>
	            
	            <% String mensaje; 
	               if (request.getAttribute("error") != null) { 
	                   mensaje = (String) request.getAttribute("error"); 
	            %>
		        <p class="error-message"><%= mensaje %></p>
		        <% } %>
			</div>
			
			<div class="form-container" id="tarjeta-form">
				<h2>Tarjeta</h2>
				
				<form action="pagarPedidoTarjeta" method="POST">
					<div class="inputs">
						<label class="Card">NºTarjeta: </label>
						<input type="number" id="Card" name="pay_numb" required>
					</div>
					<div class="inputs">
						<label class="Date">Fecha de caducidad: </label>
						<input type="number" id="Date" name="pay_date" required>
					</div>
					<div class="inputs">
						<label class="Codigo">Codigo: </label>
						<input type="number" id="Codigo" name="pay_code" required>
					</div>
					<button type="submit" class="pagoT-button">Pagar</button>
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
	        if (tabName === 'Paypal') {
	            document.getElementById('paypal-form').classList.add('active');
	            tabs[0].classList.add('active');
	        } else if (tabName === 'Tarjeta') {
	            document.getElementById('tarjeta-form').classList.add('active');
	            tabs[1].classList.add('active');
	        }
	    }
	</script>
	
	<%@ include file="pieDePagina.jsp" %>
</body>
</html>
