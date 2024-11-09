package Conexiones;

import org.hibernate.Session;
import org.hibernate.Transaction;

import Clases.Pedido;

public class PedidoDAO {

	public int agregarPedido(Pedido pedido) {
        Session session = HibernateManager.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();
        session.save(pedido);
        tx.commit();
        session.close();
        
        return pedido.getId();
    }

	public void actualizarPedido(int pedidoId, String metodoPago, String numFactura, double totalPago) {
	    Session session = HibernateManager.getSessionFactory().openSession();
	    Transaction tx = session.beginTransaction();

	    try {
	        // Cargar el pedido usando el ID
	        Pedido pedido = session.get(Pedido.class, pedidoId);
	        
	        // Actualizar los campos
	        if (pedido != null) {
	            pedido.setMetodopago(metodoPago);
	            pedido.setNum_factura(numFactura);
	            pedido.setTotal(totalPago);
	            
	            // Guarda los cambios en la base de datos
	            session.update(pedido);
	            tx.commit();
	        }
	    } catch (Exception e) {
	        if (tx != null) tx.rollback();
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	}

}
