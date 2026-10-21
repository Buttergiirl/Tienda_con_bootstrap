<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Tienda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <br>
    <div class="container d-flex justify-content-center">
        <div class="card shadow-sm" style="width: 24rem">
            <div class="card-header text-center"><h4>Iniciar sesión</h4></div>
            <div class="card-body">
                <% if ("1".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger">Correo o contraseña incorrectos.</div>
                <% } else if ("2".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-warning">Debe iniciar sesión para ingresar a productos.</div>
                <% } %>
                <% if ("1".equals(request.getParameter("logout"))) { %>
                    <div class="alert alert-success">La sesión se cerró correctamente.</div>
                <% } %>
                <form method="POST" action="<%=request.getContextPath()%>/LoginServlet">
                    <div class="mb-3">
                        <label for="txtemail" class="form-label">Correo electrónico</label>
                        <input name="txtemail" type="email" class="form-control" id="txtemail"
                               placeholder="admin@tienda.com" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtpwd" class="form-label">Contraseña</label>
                        <input name="txtpwd" type="password" class="form-control" id="txtpwd"
                               placeholder="Ingrese su contraseña" required>
                    </div>
                    <button class="btn btn-primary w-100" type="submit">Ingresar</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
