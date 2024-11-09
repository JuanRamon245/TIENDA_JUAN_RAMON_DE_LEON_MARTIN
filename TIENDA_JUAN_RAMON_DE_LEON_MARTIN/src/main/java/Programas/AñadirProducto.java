package Programas;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Clases.Detalle;
import Clases.Pedido;
import Clases.Usuario;
import Conexiones.DetalleDAO;
import Conexiones.PedidoDAO;
import Conexiones.UsuarioDAO;

/**
 * Servlet implementation class AñadirProducto
 */
@WebServlet("/AñadirProducto")
public class AñadirProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AñadirProducto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Obtener el producto y sus detalles desde el formulario
        int productoId = Integer.parseInt(request.getParameter("productoId"));
        double precio = Double.parseDouble(request.getParameter("precio"));
        double impuesto = Double.parseDouble(request.getParameter("impuesto"));
        int unidades = 1;

        // Calcular el total para el detalle
        double totalDetalle = (precio * unidades) + (precio * unidades * impuesto / 100);

        // Obtener el correo del usuario de la cookie
        String correoUsuario = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("usuario")) {
                    correoUsuario = cookie.getValue();
                    break;
                }
            }
        }
        
        if (correoUsuario != null) {
        	// Obtener el usuario_id usando UsuarioDAO y el correo
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            Usuario usuario = usuarioDAO.obtenerUsuarioPorCorreo(correoUsuario);
            int usuarioId = usuario.getId();
            HttpSession session = request.getSession();
            Integer pedidoIdSession = (Integer) session.getAttribute("pedido_id");
            
            
            	// Si no hay un pedido en la sesión, crearlo
	            if (pedidoIdSession == null) {
	            	// Crear el pedido con los datos iniciales
	                Pedido pedido = new Pedido();
	                pedido.setUsuario_id(usuarioId);
	                pedido.setFecha(new java.sql.Date(System.currentTimeMillis())); // Fecha actual
	                pedido.setMetodopago("o"); // Método de pago temporal
	                pedido.setNum_factura("o"); // Número de factura temporal
	                pedido.setTotal((double) 0); // Total inicial
	
	                // Guardar el pedido en la base de datos y obtener el pedido_id generado
	                PedidoDAO pedidoDAO = new PedidoDAO();
	                int pedidoId = pedidoDAO.agregarPedido(pedido);
	                session.setAttribute("pedido_id", pedidoId);
	                
	                // Crear el detalle utilizando el pedido_id generado
	                Detalle detalle = new Detalle();
	                detalle.setPedido_id(pedidoId);
	                detalle.setProducto_id(productoId);
	                detalle.setUnidades(unidades);
	                detalle.setPreciounidad(precio);
	                detalle.setImpuesto(impuesto);
	                detalle.setTotal(totalDetalle);
	
	                // Guardar el detalle en la base de datos
	                DetalleDAO detalleDAO = new DetalleDAO();
	                detalleDAO.agregarDetalle(detalle);
	            } else {
	            	
	            	DetalleDAO detalleDAO = new DetalleDAO();

	            	// Verificar si el detalle ya existe para el pedido y producto
	            	if (!detalleDAO.detalleExiste(pedidoIdSession, productoId)) {
	            	    // Crear el detalle si no existe
	            	    Detalle detalle = new Detalle();
	            	    detalle.setPedido_id(pedidoIdSession);
	            	    detalle.setProducto_id(productoId);
	            	    detalle.setUnidades(unidades);
	            	    detalle.setPreciounidad(precio);
	            	    detalle.setImpuesto(impuesto);
	            	    detalle.setTotal(totalDetalle);

	            	    // Guardar el detalle en la base de datos
	            	    detalleDAO.agregarDetalle(detalle);
	            	}
	            }
            response.sendRedirect("primeraInstancia.jsp");
        } else {
        	response.sendRedirect("Loggin.jsp");
        }
	}
}
