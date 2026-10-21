<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="my.webapp.login.User"%>
<%
    User user = (User) session.getAttribute("User");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=2");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registrar producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/ProductoServlet">Tienda WebApp</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="<%=request.getContextPath()%>/ProductoServlet">Ver productos</a>
                <a class="nav-link" href="<%=request.getContextPath()%>/LogoutServlet">Cerrar sesión</a>
            </div>
        </div>
    </nav>
    <div class="container mt-4">
        <p>Bienvenido, <strong><%=user.getAlias()%></strong></p>
        <div class="card">
            <div class="card-header"><h4>Registrar producto</h4></div>
            <div class="card-body">
                <% if ("1".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-warning">Revise los datos. El precio y el stock no pueden ser negativos.</div>
                <% } else if ("2".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger">No se pudo registrar el producto. Revise la conexión con MySQL.</div>
                <% } %>
                <form method="POST" action="<%=request.getContextPath()%>/ProductoServlet">
                    <div class="mb-3">
                        <label for="txtnombre" class="form-label">Nombre del producto</label>
                        <input name="txtnombre" type="text" class="form-control" id="txtnombre" maxlength="120" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtprecio" class="form-label">Precio</label>
                        <input name="txtprecio" type="number" class="form-control" id="txtprecio"
                               min="0" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtstock" class="form-label">Stock</label>
                        <input name="txtstock" type="number" class="form-control" id="txtstock"
                               min="0" step="1" required>
                    </div>
                    <button class="btn btn-primary" type="submit">Guardar</button>
                    <a class="btn btn-secondary" href="<%=request.getContextPath()%>/ProductoServlet">Cancelar</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
