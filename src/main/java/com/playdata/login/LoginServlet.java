package com.playdata.login;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 패스워드 암호화 처리
        String hashedPassword = hashPassword(password);

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        Connection conn = (Connection) request.getServletContext().getAttribute("conn");

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, hashedPassword);

            try (ResultSet rs = pstmt.executeQuery()) {
                if(rs.next()) {
                    // 로그인 성공
                    // 세션 username 속성에 사용자 이름을 저장
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    // 로그인 성공 시, 로그인 실패 횟수 0으로 초기화

                    // 메인 페이지로 이동
                    response.sendRedirect("/index.jsp");
                } else {
                    // 로그인 실패
                    // 로그인 실패 횟수 1증가
                    // 로그인 폼으로 다시 이동, 에러 값 전달
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 패스워드 암호화 처리
     * @param password
     * @return hashedPassword
     */
    public static String hashPassword(String password) {
        String hashedPassword = "";
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            hashedPassword = Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return hashedPassword;
    }
}
