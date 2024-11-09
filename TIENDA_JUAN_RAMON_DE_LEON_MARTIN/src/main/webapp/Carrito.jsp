<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Conexiones.DetalleDAO" %>
<%@ page import="Conexiones.ProductosDAO" %>
<%@ page import="Clases.Detalle" %>
<%@ page import="Clases.Producto" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
		}
		
		.detalles-pedido {
			font-family: 'Open Sans', sans-serif;
			background-color: #9b9dde;
			padding: 20px;
		}
		
		.detalle-card {
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

        .detalle-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        } 
           
        .detalle-nombre {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }
        
        .detalle-unidades {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }
        .detalle-total {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }
        .totalValor {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }
        .btn {
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 10px;
            width: 100px;
            height: 30px;
            font-size: 1.2em;
            cursor: pointer;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        </style>
        
        <script>
        // Función para limitar la cantidad al stock máximo
        function validarCantidadMaxima(input, stockMaximo) {
            if (input.value > stockMaximo) {
                input.value = stockMaximo;
            } else if (input.value < 1) {
            	input.value = 1;
            }
        }
		</script>
	</head>
<body>

	<%@ include file="cabecera.jsp" %>

    <main class="detalles-pedido">
        <%
        	double sumarTotal = 0.0;
            // Obtener el pedido_id desde la sesión
            Integer pedidoId = (Integer) session.getAttribute("pedido_id");
            if (pedidoId != null) {
                DetalleDAO detalleDAO = new DetalleDAO();
                ProductosDAO productosDAO = new ProductosDAO();
                
                // Obtener los detalles del pedido actual
                List<Detalle> detalles = detalleDAO.obtenerDetallesPorPedidoId(pedidoId);

                // Mostrar cada detalle
                for (Detalle detalle : detalles) {
                    Producto producto = productosDAO.obtenerProductoPorId(detalle.getProducto_id());
                    if (producto != null) {
                    	sumarTotal += detalle.getTotal();
        %>
                    <div class="detalle-card">
                        <div class="detalle-info">
                            <div class="detalle-nombre">Producto: <%= producto.getNombre() %></div>
                            <form action="ActualizarDetalle" method="POST">
                            	<div class="detalle-unidades">Unidades: 
                            		<input type="hidden" name="detalleId" value="<%= detalle.getId() %>">
	                                <input type="number" class="cantidad-input" min="1" max="<%= producto.getStock() %>"  value="<%= detalle.getUnidades() %>" name="unidades" oninput="validarCantidadMaxima(this, <%= producto.getStock() %>)">
	                                <button type="submit" class="btn">Guardar</button>
	                            </div>
	                            <div class="detalle-total">Total: $<%= String.format("%.2f", detalle.getTotal()) %></div>
                            </form>
                        </div>
                    </div>
        <%
                    }
                }
            } else {
                out.println("<p>No hay detalles disponibles para este pedido.</p>");
            }
        %>
        <div class="detalle-card">
		    <div class="total-valor">Total: $<%=String.format("%.2f", sumarTotal) %></div>
		    <form action="ProcesarPago" method="POST">
		        <input type="hidden" name="total" value="<%= sumarTotal %>">
		        <button type="submit" class="btn" style="text-decoration: none;">Pagar</button>
		    </form>
		</div>
    </main>
    
</body>

<%@ include file="pieDePagina.jsp" %>

</html>