package servlet;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    // パスワードをSHA-256でハッシュ化するメソッド
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        
        // 🛡️ 入力されたパスワードをハッシュ化
        String hashedPass = hashPassword(pass);
        String dbPath = "jdbc:sqlite:C:/temp/security.db";

        try {
            Class.forName("org.sqlite.JDBC");
            try (Connection conn = DriverManager.getConnection(dbPath);
                 Statement stmt = conn.createStatement()) {
                
                stmt.executeUpdate("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
                // ハッシュ化されたパスワードを保存
                stmt.executeUpdate("INSERT INTO users (username, password) VALUES ('" + user + "', '" + hashedPass + "')");
                
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("登録完了！ハッシュ化して保存しました。 <a href='index.jsp'>戻る</a>");
            }
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}