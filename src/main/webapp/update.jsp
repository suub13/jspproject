<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // form에서 넘어온 데이터를 받는다.
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String content = request.getParameter("content");

    String sql = "update board set title=?, author=?, content=? where id=?";
    Connection conn = (Connection) request.getServletContext().getAttribute("conn");
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, title);
        stmt.setString(2, author);
        stmt.setString(3, content);
        stmt.setInt(4, id);
        int resultCnt = stmt.executeUpdate();
        response.sendRedirect("view.jsp?id=" + id);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>