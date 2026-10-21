package my.webapp.producto;

import java.io.IOException;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import my.webapp.login.User;


public class ProductoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute("User");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=2");
            return;
        }

        request.setAttribute("productoList", new ProductoDAO().getAll());
        request.getRequestDispatcher("/productos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute("User");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=2");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ProductoDAO dao = new ProductoDAO();

        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.delete(id);
                response.sendRedirect(request.getContextPath() + "/ProductoServlet?mensaje=eliminado");
                return;
            }

            String nombre = request.getParameter("txtnombre");
            double precio = Double.parseDouble(request.getParameter("txtprecio"));
            int stock = Integer.parseInt(request.getParameter("txtstock"));

            if (nombre == null || nombre.trim().isEmpty() || precio < 0 || stock < 0) {
                response.sendRedirect(request.getContextPath() + "/producto-edit.jsp?error=1");
                return;
            }

            boolean registrado = dao.insert(new Producto(0, nombre.trim(), precio, stock));
            if (registrado) {
                response.sendRedirect(request.getContextPath() + "/ProductoServlet?mensaje=registrado");
            } else {
                response.sendRedirect(request.getContextPath() + "/producto-edit.jsp?error=2");
            }
        } catch (NumberFormatException ex) {
            response.sendRedirect(request.getContextPath() + "/producto-edit.jsp?error=1");
        }
    }
}
