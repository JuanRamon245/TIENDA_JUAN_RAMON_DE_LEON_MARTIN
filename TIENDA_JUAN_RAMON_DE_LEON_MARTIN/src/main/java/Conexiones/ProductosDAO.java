package Conexiones;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import Clases.Producto;

public class ProductosDAO {

	public Producto obtenerProductoPorId(int productoId) {
        Session session = HibernateManager.getSessionFactory().openSession();
        Producto producto = session.get(Producto.class, productoId);
        session.close();
        return producto;
    }
	
	public List<Producto> obtenerTodosLosUsuarios() {
        Session session = HibernateManager.getSessionFactory().openSession();
        List<Producto> productos = session.createQuery("FROM Producto", Producto.class).list();
        session.close();
        return productos;
    }
	
	public void actualizarStockProducto(int productoId, int nuevoStock) {
	    Session session = HibernateManager.getSessionFactory().openSession();
	    Transaction tx = session.beginTransaction();
	    
	    try {
	        Producto producto = session.get(Producto.class, productoId);
	        if (producto != null) {
	            producto.setStock(nuevoStock);  // Asigna el nuevo stock
	            session.update(producto);       // Actualiza el producto en la BD
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

