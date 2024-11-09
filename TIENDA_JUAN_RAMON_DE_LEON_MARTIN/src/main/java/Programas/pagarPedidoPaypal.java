package Programas;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Clases.Detalle;
import Clases.Producto;
import Conexiones.DetalleDAO;
import Conexiones.PedidoDAO;
import Conexiones.ProductosDAO;

/**
 * Servlet implementation class pagarPedidoPaypal
 */
@WebServlet("/pagarPedidoPaypal")
public class pagarPedidoPaypal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public pagarPedidoPaypal() {
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
		HttpSession session = request.getSession();
	    
	    // Recupera el ID del pedido y el total del pago desde la sesión
	    Integer pedidoId = (Integer) session.getAttribute("pedido_id");
	    Double totalPago = (Double) session.getAttribute("total_pago");
	    String numFactura = generarNumeroFactura();

	    // Llama al DAO para actualizar el pedido con el método de pago "PayPal"
	    PedidoDAO pedidoDAO = new PedidoDAO();
	    pedidoDAO.actualizarPedido(pedidoId, "PayPal", numFactura, totalPago);

	    // Obtener detalles del pedido
	    DetalleDAO detalleDAO = new DetalleDAO();
	    List<Detalle> detalles = detalleDAO.obtenerDetallesPorPedidoId(pedidoId);
	    
	    // Actualizar el stock de cada producto
	    ProductosDAO productosDAO = new ProductosDAO();
	    for (Detalle detalle : detalles) {
	        // Obtener el producto relacionado
	        Producto producto = productosDAO.obtenerProductoPorId(detalle.getProducto_id());
	        if (producto != null) {
	            int nuevoStock = producto.getStock() - detalle.getUnidades();
	            productosDAO.actualizarStockProducto(producto.getId(), nuevoStock);
	        }
	    }

	    // Limpia la sesión de estos datos después de finalizar la transacción
	    session.removeAttribute("total_pago");
	    session.removeAttribute("pedido_id");

	    // Redirige a la página de confirmación
	    response.sendRedirect("primeraInstancia.jsp");
    }

    // Método para generar un número de factura aleatorio de 8 caracteres
    private String generarNumeroFactura() {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(8);
        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(caracteres.length());
            sb.append(caracteres.charAt(index));
        }
        return sb.toString();
    }

}
