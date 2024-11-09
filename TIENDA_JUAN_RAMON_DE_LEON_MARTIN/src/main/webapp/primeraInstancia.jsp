<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Conexiones.ProductosDAO" %>
<%@ page import="Clases.Producto" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Listado de Productos</title>
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
		}
		
		.catalogo {
			font-family: 'Open Sans', sans-serif;
			background-color: #9b9dde;
			padding: 20px;
		}
		
		.producto-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .producto-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .producto-nombre {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }

        .producto-precio-stock {
            background-color: #595dd9;
            color: #fff;
            padding: 8px;
            border-radius: 5px;
            font-size: 0.9em;
            display: inline-block;
            margin-top: 5px;
        }

        .cantidad-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cantidad-input {
            width: 60px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            text-align: center;
        }

        .btn-mas {
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            font-size: 1.2em;
            cursor: pointer;
        }
    </style>
    
</head>

<%@ include file="cabecera.jsp" %>

<body>
	<main class="catalogo">
    <h2>Productos disponibles</h2>
    <%
        ProductosDAO productosDAO = new ProductosDAO();
        List<Producto> productos = productosDAO.obtenerTodosLosUsuarios();
        for (Producto producto : productos) {
    %>
        <div class="producto-card">
            <div class="producto-info">
                <div class="producto-nombre"><%= producto.getNombre() %></div>
                <div class="producto-descripcion"><%= producto.getDescripcion() %></div>
                <div class="producto-precio-stock">Precio: $<%= producto.getPrecio() %></div>
                <div class="producto-precio-stock">Stock: <%= producto.getStock() %> unidades</div>
            </div>
            <form action="AñadirProducto" method="POST">
                <div class="cantidad-container">
                    <input type="hidden" name="productoId" value="<%= producto.getId() %>">
                    <input type="hidden" name="precio" value="<%= producto.getPrecio() %>">
                    <input type="hidden" name="impuesto" value="<%= producto.getImpuesto() %>">
                    <button type="submit" class="btn-mas">+</button>
                </div>
            </form>
        </div>
    <%
        }
    %>
</main>
	
</body>

<%@ include file="pieDePagina.jsp" %>
</html>