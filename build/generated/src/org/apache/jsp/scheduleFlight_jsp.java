package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;
import javax.json.Json;
import javax.json.JsonObject;

public final class scheduleFlight_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


            static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
            static final String DB_URL = "jdbc:mysql://localhost/airline";
            static final String USER = "root";
            static final String PASS = "";
            Connection conn = null;
            Statement stmt = null;
        
  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Status</title>\n");
      out.write("    </head>\n");
      out.write("        ");
      out.write("\n");
      out.write("    <body>\n");
      out.write("         ");

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
        
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
