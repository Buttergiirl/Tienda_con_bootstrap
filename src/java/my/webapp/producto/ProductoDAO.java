package my.webapp.producto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import my.webapp.database.Database;

public class ProductoDAO {
    public List<Producto> getAll() {
        List<Producto> productoList = new ArrayList<>();
        String sql = "SELECT id, nombre, precio, stock FROM productos ORDER BY id";

        try (Connection conn = new Database().getConnection();
             PreparedStatement pstat = conn.prepareStatement(sql);
             ResultSet rs = pstat.executeQuery()) {

            while (rs.next()) {
                productoList.add(new Producto(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getDouble("precio"),
                    rs.getInt("stock")
                ));
            }
        } catch (SQLException ex) {
            System.getLogger(ProductoDAO.class.getName())
                  .log(System.Logger.Level.ERROR, "Error consultando productos", ex);
        }
        return productoList;
    }

    public boolean insert(Producto producto) {
        String sql = "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)";

        try (Connection conn = new Database().getConnection();
             PreparedStatement pstat = conn.prepareStatement(sql)) {
            pstat.setString(1, producto.getNombre());
            pstat.setDouble(2, producto.getPrecio());
            pstat.setInt(3, producto.getStock());
            return pstat.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.getLogger(ProductoDAO.class.getName())
                  .log(System.Logger.Level.ERROR, "Error registrando producto", ex);
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM productos WHERE id = ?";

        try (Connection conn = new Database().getConnection();
             PreparedStatement pstat = conn.prepareStatement(sql)) {
            pstat.setInt(1, id);
            return pstat.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.getLogger(ProductoDAO.class.getName())
                  .log(System.Logger.Level.ERROR, "Error eliminando producto", ex);
            return false;
        }
    }
}
