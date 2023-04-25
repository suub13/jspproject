<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예외 처리 페이지</title>
</head>
<body>
    <h1>예외가 발생되었습니다.</h1>
    <%
        // 예외 객체를 가져오기
        Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");

        if(throwable != null) {
            out.println("<p>예외 클래스: " + throwable.getClass() + "</p>");
            out.println("<p>예외 메시지: " + throwable.getMessage() + "</p>");
        } else {
            out.println("<p>예외 정보가 없습니다.</p>");
        }
    %>
</body>
</html>