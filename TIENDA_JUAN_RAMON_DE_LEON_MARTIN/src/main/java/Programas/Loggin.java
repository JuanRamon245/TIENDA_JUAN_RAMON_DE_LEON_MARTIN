package Programas;

import java.io.IOException;

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
 * Servlet implementation class Loggin
 */
@WebServlet("/Loggin")
public class Loggin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Loggin() {
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

		String log_pass = request.getParameter("log_pass");
		String log_mail = request.getParameter("log_email");
		
		boolean validarPass = true;
		boolean validarMail = true;

		if (log_pass.isBlank() || log_pass.isEmpty() || log_pass.length() < 1) {
			validarPass = false;
		}
		
		if (log_mail.isBlank() || log_mail.isEmpty() || log_mail.length() < 5) {						
			validarMail = false;
		}
		
		if (validarPass == true && validarMail == true) {
			UsuarioDAO usuarioDAO = new UsuarioDAO();
			
			Usuario usuario = usuarioDAO.obtenerUsuarioPorCorreo(log_mail);
			
			if (usuario != null && usuario.getClave().equals(log_pass)) {
				session.setAttribute("usuario", log_mail);
				
				Cookie cookie = new Cookie("usuario", log_mail);
				cookie.setMaxAge(7 * 24 * 60 *60);
				response.addCookie(cookie);
				
				pagina = "primeraInstancia.jsp";
				response.sendRedirect(pagina);
			} else {
				request.setAttribute("error", "Credenciales incorrectas.");
				pagina = "Loggin.jsp";
				response.sendRedirect(pagina);
			}
		}

	}

}
