<%@ page import="java.sql.*" %>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="java.io.IOException" %>
    <%@ page import="java.io.FileWriter" %>
    <%@ page import="java.io.BufferedWriter" %>
    
    <%
        String jdbcUrl = "jdbc:mysql://localhost:3306/project";
        String dbUsername = "root";
        String dbPassword = "";

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
            String sql = "SELECT * FROM login WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter outa = response.getWriter();

            outa.println("<!DOCTYPE html>");
            outa.println("<html>");
            outa.println("<head>");
            outa.println("<title>Login</title>");
            outa.println("</head>");
            outa.println("<body>");

            if (rs.next()) {
                outa.println("<h1>Login successful!</h1>");
            } else {
                outa.println("<h1>Invalid ID or password. Please try again.</h1>");
            }

            outa.println("</body>");
            outa.println("</html>");

            rs.close();
            stmt.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>