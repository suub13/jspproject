package com.playdata.login;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String hashedPassword = LoginServlet.hashPassword(password);

        if (isAvailableUsername(request, username)) {
            // username이 사용 중이지 않아서 가입이 가능한 경우
            int resultRowCount = registerUser(username, hashedPassword);
        }
    }

    /**
     * 데이터베이스에 사용자 정보(username, hashedPassword)를 저장
     * @param username
     * @param hashedPassword
     * @return 저장된 행의 개수
     */
    private int registerUser(String username, String hashedPassword) {
        String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, hashedPassword);

            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 데이터베이스에 사용자 정보(username)가 이미 사용 중인지 조회
     * @param request
     * @param username
     * @return 이미 사용 중인 경우 false, 사용 가능한 경우 true
     */
    private boolean isAvailableUsername(HttpServletRequest request, String username) {
        // DB에서 username이 존재하는지 확인
        String sql = "SELECT * FROM users WHERE username = ?";
        Connection conn = (Connection) request.getServletContext().getAttribute("conn");
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 이미 username이 사용 중인 경우
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    ;
}
