package Conexiones;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import Clases.Detalle;

public class DetalleDAO {

	public void agregarDetalle(Detalle detalle) {
        Session session = HibernateManager.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();
        session.save(detalle);
        tx.commit();
        session.close();
    }
	
	public boolean detalleExiste(int pedido_id, int producto_id) {
	    Session session = HibernateManager.getSessionFactory().openSession();
	    boolean exists = false;

	    try {
	        // Usar COUNT para comprobar si existe algún registro que cumpla con los criterios
	        Long count = session.createQuery(
	            "SELECT COUNT(d) FROM Detalle d WHERE d.pedido_id = :pedido_id AND d.producto_id = :producto_id", 
	            Long.class)
	            .setParameter("pedido_id", pedido_id)
	            .setParameter("producto_id", producto_id)
	            .uniqueResult();

	        exists = (count != null && count > 0); // Si count es mayor a 0, entonces existe el detalle
	    } finally {
	        session.close();
	    }

	    return exists;
	}

	public Detalle obtenerDetallePorId(int detalleId) {
		Session session = HibernateManager.getSessionFactory().openSession();
		Detalle detalle = null;
		try {
		detalle = session.get(Detalle.class, detalleId);
		} finally {
			session.close();
		}
		return detalle;
	}
	
	public void actualizarDetalle(Detalle detalle) {
		Session session = HibernateManager.getSessionFactory().openSession();
    	Transaction transaccion = session.beginTransaction();
    	try {
    		session.update(detalle);
    		transaccion.commit();
    	} catch (Exception e){
    		if (transaccion != null) transaccion.rollback();
    		e.printStackTrace();
    	}	finally {
    		session.close();
    	}
	}
	
	public int obtenerDetallePorIDS (int producto_id, int pedido_id) {
    	Session session = HibernateManager.getSessionFactory().openSession();
    	Detalle detalle = session.createQuery("FROM Detalle WHERE pedido_id = :pedido_id AND producto_id = :producto_id", Detalle.class).setParameter("pedido_id", pedido_id).setParameter("producto_id", producto_id).uniqueResult();
    	session.close();
    	return detalle.getId();
    }
	
	public List<Detalle> obtenerDetallesPorPedidoId(int pedidoId) {
	    Session session = HibernateManager.getSessionFactory().openSession();
	    // Cambiar "pediodId" a "pedidoId" en la consulta
	    List<Detalle> detalles = session.createQuery("FROM Detalle WHERE pedido_id = :pedidoId", Detalle.class)
	                                    .setParameter("pedidoId", pedidoId)
	                                    .list();
	    session.close();
	    return detalles;
	}
	
	 public List<Detalle> obtenerTodosLosDetalles() {
	        Session session = HibernateManager.getSessionFactory().openSession();
	        List<Detalle> detalles = session.createQuery("FROM Detalle", Detalle.class).list();
	        session.close();
	        return detalles;
	 }
}
