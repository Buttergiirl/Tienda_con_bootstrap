<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="my.webapp.login.User"%>
<%@page import="my.webapp.producto.Producto"%>
<%@page import="java.util.List"%>
<%
    User user = (User) session.getAttribute("User");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=2");
        return;
    }
    List<Producto> productoList = (List<Producto>) request.getAttribute("productoList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Productos - Tienda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/ProductoServlet">Tienda WebApp</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="<%=request.getContextPath()%>/producto-edit.jsp">Registrar producto</a>
                <a class="nav-link" href="<%=request.getContextPath()%>/LogoutServlet">Cerrar sesión</a>
            </div>
        </div>
    </nav>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h3>Lista de productos</h3>
                <p class="text-muted mb-0">Bienvenido, <strong><%=user.getAlias()%></strong></p>
            </div>
            <a class="btn btn-success" href="<%=request.getContextPath()%>/producto-edit.jsp">+ Nuevo producto</a>
        </div>
        <% if ("registrado".equals(request.getParameter("mensaje"))) { %>
            <div class="alert alert-success">Producto registrado correctamente.</div>
        <% } else if ("eliminado".equals(request.getParameter("mensaje"))) { %>
            <div class="alert alert-info">Se procesó la solicitud de eliminación.</div>
        <% } %>
        <div class="card shadow-sm">
            <div class="card-body table-responsive">
                <table class="table table-hover table-striped align-middle">
                    <thead class="table-primary">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Precio</th>
                            <th scope="col">Stock</th>
                            <th scope="col">Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (productoList != null && !productoList.isEmpty()) {
                            for (Producto producto : productoList) { %>
                            <tr>
                                <th scope="row"><%=producto.getId()%></th>
                                <td><%=producto.getNombre()%></td>
                                <td>₡<%=String.format(java.util.Locale.US, "%,.2f", producto.getPrecio())%></td>
                                <td><%=producto.getStock()%></td>
                                <td>
                                    <form method="POST" action="<%=request.getContextPath()%>/ProductoServlet"
                                          onsubmit="return confirm('¿Está seguro de que desea eliminar este producto?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%=producto.getId()%>">
                                        <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                        <%  }
                           } else { %>
                            <tr><td colspan="5" class="text-center">No hay productos registrados.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
