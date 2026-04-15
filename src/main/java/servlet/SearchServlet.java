package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String dbPath = "jdbc:sqlite:C:/temp/security.db";
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // デザイン部分（Header）
        out.println("<!DOCTYPE html><html lang='ja'><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>社員照会システム - 結果</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head><body class='bg-light'>");
        out.println("<nav class='navbar navbar-dark bg-primary mb-4'><div class='container'><span class='navbar-brand'>社内データベース照会ユニット</span></div></nav>");
        out.println("<div class='container'><div class='row justify-content-center'><div class='col-md-10'>");
        out.println("<div class='card shadow-sm'><div class='card-header bg-white'><h5 class='mb-0'>検索実行結果</h5></div>");
        out.println("<div class='card-body'>");

        try {
            Class.forName("org.sqlite.JDBC");
            try (Connection conn = DriverManager.getConnection(dbPath);
                 Statement stmt = conn.createStatement()) {
                
                // ☠️ 脆弱性：LIKE句をそのまま結合
                String sql = "SELECT username FROM users WHERE username LIKE '%" + keyword + "%'";
                ResultSet rs = stmt.executeQuery(sql);

                out.println("<table class='table table-striped table-hover'>");
                out.println("<thead class='table-dark'><tr><th>取得データ（社員名 / 内部識別子）</th></tr></thead><tbody>");
                
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    // カラム1つ分を出力（UNION攻撃時はここにハッシュが並ぶ）
                    out.println("<tr><td><code class='text-dark'>" + rs.getString(1) + "</code></td></tr>");
                }
                
                if (!hasData) {
                    out.println("<tr><td class='text-muted text-center'>該当するデータは見つかりませんでした。</td></tr>");
                }
                
                out.println("</tbody></table>");
            }
        } catch (Exception e) {
            // エラー時は真っ赤なアラートを表示（インジェクションの試行錯誤中に役立ちます）
            out.println("<div class='alert alert-danger mt-3'>");
            out.println("<h6 class='alert-heading'>SQL実行エラーが発生しました：</h6>");
            out.println("<pre class='mb-0'>" + e.getMessage() + "</pre></div>");
        }
        
        out.println("<div class='mt-4'><a href='welcome.jsp' class='btn btn-secondary'>検索メニューへ戻る</a></div>");
        out.println("</div></div></div></div></div>");
        out.println("<footer class='text-center mt-5 text-muted small'>&copy; 2026 Maruyama Construction Security Systems</footer>");
        out.println("</body></html>");
    }
}