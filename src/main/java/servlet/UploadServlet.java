package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part part = request.getPart("uploadFile");
        String filename = part.getSubmittedFileName();

        // 🎯 究極の力技：丸山さんのPCの絶対パスを直接指定（スラッシュの向きに注意）
        String savePath = "C:/Users/shishidoreo/Documents/workspace/WebSecurityLab/src/main/webapp/" + filename;

        // Tomcatの part.write() を使わず、Javaの標準ストリームで「強制書き込み」
        try (java.io.InputStream in = part.getInputStream();
             java.io.FileOutputStream out = new java.io.FileOutputStream(savePath)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }

        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<h1>アップロード（強制）完了</h1>");
        response.getWriter().println("<p>物理的な保存先: " + savePath + "</p>");
        response.getWriter().println("<a href='" + filename + "' target='_blank'>Webシェル起動！</a><br><br>");
        response.getWriter().println("<a href='welcome.jsp'>戻る</a>");
    }
}