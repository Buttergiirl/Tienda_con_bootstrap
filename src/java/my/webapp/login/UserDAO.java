package my.webapp.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import my.webapp.database.Database;

public class UserDAO {
    public User ValidateLogin(String email, String pwd) {
        String sql = "SELECT id, alias, email FROM usuarios WHERE email = ? AND password = ?";

        try (Connection conn = new Database().getConnection();
             PreparedStatement pstat = conn.prepareStatement(sql)) {

            pstat.setString(1, email);
            pstat.setString(2, pwd);

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("alias"),
                        rs.getString("email")
                    );
                }
            }
        } catch (SQLException ex) {
            System.getLogger(UserDAO.class.getName())
                  .log(System.Logger.Level.ERROR, "Error validando el usuario", ex);
        }
        return null;
    }
}
