package Conexiones;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import Clases.Usuario;

public class UsuarioDAO {
	
	public void agregarUsuario(Usuario usuario) {
        Session session = HibernateManager.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();
        session.save(usuario);
        tx.commit();
        session.close();
    }

    public Usuario obtenerUsuario(int id) {
        Session session = HibernateManager.getSessionFactory().openSession();
        Usuario usuario = session.get(Usuario.class, id);
        session.close();
        return usuario;
    }
    
    public Usuario obtenerUsuarioPorCorreo (String email) {
    	Session session = HibernateManager.getSessionFactory().openSession();
    	Usuario usuario = session.createQuery("FROM Usuario WHERE email = :email", Usuario.class).setParameter("email", email).uniqueResult();
    	session.close();
    	return usuario;
    }

    public List<Usuario> obtenerTodosLosUsuarios() {
        Session session = HibernateManager.getSessionFactory().openSession();
        List<Usuario> contactos = session.createQuery("FROM Usuario", Usuario.class).list();
        session.close();
        return contactos;
    }
}
