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
                JsonObject error = Json.createObjectBuilder()
                 .add("status","Failure")
                 .add("message", "Flight already exists")
                 .build();
                 PrintWriter writer = response.getWriter();
                 writer.print(error);
               } else {
                sql = "INSERT INTO flights VALUES("+request.getParameter("flightId")+","+request.getParameter("NumberOfSeats")+")";
                stmt.executeUpdate(sql);
                JsonObject success = Json.createObjectBuilder()
                   .add("status","Success")
                   .build();
                   PrintWriter writer = response.getWriter();
                   writer.print(success);
               }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
