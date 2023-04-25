<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

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
        <hr>
        <h3>글쓰기</h3>
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
        <form method="post" action="update.jsp">
            <div class="input-group mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" id="title" name="title" class="form-control" value="<%=rs.getString("title")%>" required>
            </div>
            <div class="input-group mb-3">
                <label for="author" class="form-label">작성자</label>
                <input type="text" id="author" name="author" class="form-control" value="<%=rs.getString("author")%>" required>
            </div>
            <div class="input-group mb-3">
                <lable for="content" class="form-label">내용</lable>
                <textarea id="content" name="content" rows="5" class="form-control" required><%=rs.getString("content")%></textarea>
            </div>
            <input type="hidden" name="id" value="<%=rs.getInt("id")%>">
            <button type="submit" class="btn btn-primary">수정</button>
        </form>
        <%
                    } // if-end
                } // try-end
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        <div>
        </div>
    </div>
</body>
</html>
