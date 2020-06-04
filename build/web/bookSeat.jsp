
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
        int seats;
    %>
    <%!
        void insertRecord(int flightId, String Username) {
            try {
                stmt = conn.createStatement();

                String sql = "INSERT INTO reservations " +
                             "VALUES (" + flightId + ",'" +Username+ "')";
                stmt.executeUpdate(sql);
            } catch (Exception e ) {
                e.printStackTrace();
            }
        }
        Boolean checkAvailaibility(int flightId) {
            Boolean flag = false;
            int seatsAvailable = 0;
            try{
               String sql = "SELECT * FROM flights where flight_id = "+flightId;
               ResultSet rs = stmt.executeQuery(sql);
               if(rs.next()) {
                   seatsAvailable = rs.getInt("seatsAvailable");
               } else {
                   return flag;
               }
               
               if(seatsAvailable > 0) {
                   flag = true;
               } else {
                   flag = false;
               }
               rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return flag;
        }
        void updateSeats(int flightId) {
            try {
                String sql = "SELECT * FROM flights where flight_id = "+flightId;
                ResultSet rs = stmt.executeQuery(sql);
                if(rs.next()) {
                   seats = rs.getInt("seatsAvailable");
                }
                seats = seats - 1;
                stmt = conn.createStatement();
                sql = "UPDATE flights " + "SET seatsAvailable = "+seats+" WHERE flight_id ="+String.valueOf(flightId);
                stmt.executeUpdate(sql);
            } catch (Exception e ) {
                e.printStackTrace();
            }
        }
    %>
    <body>
        <%
            PrintWriter writer = response.getWriter();
            try{
               Class.forName(JDBC_DRIVER);
               conn = DriverManager.getConnection(DB_URL, USER, PASS);
               stmt = conn.createStatement();
            } catch (Exception e) {
                e.printStackTrace();
            }
            int flightId = Integer.parseInt(request.getParameter("flightId"));
            String username = request.getParameter("Username");
            if(checkAvailaibility(flightId)) {
                insertRecord(flightId, username);
                updateSeats(flightId);
                JsonObject success = Json.createObjectBuilder()
                .add("status", "Success")
                .add("seatNumber",  "1")
                .build();
                writer.print(success);
            } else {
                JsonObject error = Json.createObjectBuilder()
                .add("status", "Failure")
                .add("message",  "Tickets Full")
                .build();
                writer.print(error);
            }
            
        %>
    </body>
</html>
