<%-- 
    Document   : newjsp
    Created on : 5 Jun, 2020, 12:58:35 AM
    Author     : OM
--%>

<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@page import="javax.json.Json" %>
<%@page import="javax.json.JsonObject" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Status</title>
    </head>
    <%!
        static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
        static final String DB_URL = "jdbc:mysql://localhost/airline";
        static final String USER = "root";
        static final String PASS = "";
        Connection conn = null;
        Statement stmt = null;
        int id;
        int seats;
    %>
    <body>
        <%
            try{
               Class.forName(JDBC_DRIVER);
               conn = DriverManager.getConnection(DB_URL, USER, PASS);
               stmt = conn.createStatement();
               String sql = "SELECT * from flights where flight_Id = "+request.getParameter("flightId");
               ResultSet rs = stmt.executeQuery(sql);
               
               if(rs.next()){
                   id = rs.getInt("flight_id");
                   seats = rs.getInt("seatsAvailable");
                   JsonObject error = Json.createObjectBuilder()
                     .add("status", "Success")
                     .add("count", seats)
                     .build();
                     PrintWriter writer = response.getWriter();
                     writer.print(error);
               } else {
                JsonObject value = Json.createObjectBuilder()
                    .add("status", "Failure")
                    .build();
                PrintWriter writer = response.getWriter();
                writer.print(value);
               }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
