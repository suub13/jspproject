<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
    rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
    crossorigin="anonymous">
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="container">
        <h2>게시판</h2>
            <%
                // Query String으로 넘어온 id 값을 가져온다.
                int id = Integer.parseInt(request.getParameter("id"));

                Connection conn = (Connection) request.getServletContext().getAttribute("conn");
                String sql = "SELECT * FROM board WHERE id = ?";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
            %>
                            <h3><%= rs.getString("title")%></h3>
                            <p><%= rs.getString("content")%></p>
                            <p><%= rs.getString("author")%></p>
                            <p><%= rs.getString("created_at")%></p>
            <%
                            if (session.getAttribute("username") != null) {
            %>
                            <a href="edit.jsp?id=<%= id %>" class="btn btn-primary">수정</a>
                            <button class="btn btn-danger" onClick="deleteBoard()">삭제</button>
            <%
                            }
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
    </div>
    <script>
        function deleteBoard() {
            if(confirm("삭제하시겠습니까?")) {
                location.href = "delete.jsp?id=<%= id %>";
            }
        }
    </script>
</body>
</html>
