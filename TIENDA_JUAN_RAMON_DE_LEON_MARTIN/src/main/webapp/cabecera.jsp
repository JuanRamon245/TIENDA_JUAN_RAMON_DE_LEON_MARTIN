<!-- header.jsp -->
<header>
    <div style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #595dd9;">
    
        <!-- Sección Home -->
        <a href="primeraInstancia.jsp" style="text-decoration: none; color: inherit; font-size: 1.2em; font-weight: bold;">Home</a>

        <!-- Barra de búsqueda -->
        <div style="display: flex; align-items: center;">
            <input type="text" placeholder="Buscar..." style="padding: 10px; font-size: 1em; border-radius: 20px; width: 600px;">
            <button type="button" style="padding: 5px; border-radius: 50%; margin-left: 10px; background-color: #333; color: #fff; border: none; display: flex; align-items: center; justify-content: center; width: 45px; height: 45px">
                <img src="https://img.icons8.com/ios-filled/20/ffffff/search--v1.png" alt="Buscar">
            </button>
        </div>

        <!-- Botones Carrito y Login -->
        <div>
            <a href="Carrito.jsp" style="padding: 10px; border-radius: 20px; background-color: #333; color: #fff; border: none; text-decoration: none; width:100px;">Carrito</a>
            <% 
            Cookie [] cookies = request.getCookies();
			String usuario = null;
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("usuario")) {
						usuario = cookie.getValue();
						break;
					}
				}
			}
                if (usuario != null) { 
            %>
                <span style="color: #fff; margin-right: 15px;"><%= usuario %></span>
                <a href="CerrarSesion" style="padding: 10px; border-radius: 20px; background-color: #333; color: #fff; border: none; text-decoration: none;">Cerrar sesion</a>
            <% } else { %>
                <a href="Loggin.jsp" style="padding: 10px; border-radius: 20px; background-color: #333; color: #fff; border: none; text-decoration: none;">Login</a>
            <% } %>
        </div>
    </div>
</header>