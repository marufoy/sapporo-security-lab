package servlet;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

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
        
        // 💡 登録時と同じように空白を削除（正規化）
        if (user != null) {
            user = user.strip();
        }
        
        // パスワードのnull回避（NullPointerExceptionを防ぐ）
        if (pass == null) {
            pass = ""; 
        }

        // 🛡️ 入力パスワードをハッシュ化して突合する準備
        String hashedPass = hashPassword(pass);
        String dbPath = "jdbc:sqlite:C:/temp/security.db";

        try {
            Class.forName("org.sqlite.JDBC");
            try (Connection conn = DriverManager.getConnection(dbPath);
                 Statement stmt = conn.createStatement()) {
                
                // ☠️ 研修用：あえて残しているSQLインジェクションの的（ハッシュ化してもこの構造なら突破可能）
                String sql = "SELECT * FROM users WHERE username='" + user + "' AND password='" + hashedPass + "'";
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    // 🎯 成功したら管理画面へリダイレクト
                    response.sendRedirect("welcome.jsp");
                } else {
                    response.setContentType("text/html; charset=UTF-8");
                    response.getWriter().println("Login Failed");
                }
            }
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}