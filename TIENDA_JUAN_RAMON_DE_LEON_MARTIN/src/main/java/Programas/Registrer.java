package Programas;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Clases.Usuario;
import Conexiones.UsuarioDAO;

/**
 * Servlet implementation class Registrer
 */
@WebServlet("/Registrer")
public class Registrer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registrer() {
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
		
		String pagina = "Loggin.jsp";

		String reg_user = request.getParameter("reg_user");
		String reg_sur = request.getParameter("reg_sur");
		String reg_pass = request.getParameter("reg_pass");
		String reg_mail = request.getParameter("reg_email");
		
		boolean validarNombre = true;
		boolean validarApellidos = true;
		boolean validarPass = true;
		boolean validarMail = true;
		
		if (reg_user.isBlank() || reg_user.isEmpty() || reg_user.length() < 2) {						
			validarNombre = false;
		}
		if (reg_sur.isBlank() || reg_sur.isEmpty() || reg_sur.length() < 2) {						
			validarApellidos = false;
		}
		if (reg_pass.isBlank() || reg_pass.isEmpty() || reg_pass.length() < 1) {						
			validarPass = false;
		}
		if (reg_mail.isBlank() || reg_mail.isEmpty() || reg_mail.length() < 5) {						
			validarMail = false;
		}
		
		if (validarNombre == true && validarApellidos == true && validarPass == true && validarMail == true) {
			UsuarioDAO usuarioDAO = new UsuarioDAO();
			
			final String finalEmail = reg_mail;
	        if (usuarioDAO.obtenerTodosLosUsuarios().stream().anyMatch(c -> c.getEmail().equals(finalEmail))) {
	        	request.setAttribute("error", "Usuario ya existente.");
	        	response.sendRedirect(pagina);
	        } else {
	        	usuarioDAO.agregarUsuario(new Usuario(1, reg_mail, reg_pass, reg_user, reg_sur, false));
	        	session.setAttribute("usuario", reg_mail);
				
				Cookie cookie = new Cookie("usuario", reg_mail);
				cookie.setMaxAge(7 * 24 * 60 *60);
				response.addCookie(cookie);
	        	
				pagina = "primeraInstancia.jsp";
	            response.sendRedirect(pagina);
	        }
		}
	}
}
