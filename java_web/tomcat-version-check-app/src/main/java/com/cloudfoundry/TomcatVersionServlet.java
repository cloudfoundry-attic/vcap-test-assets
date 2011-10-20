package com.cloudfoundry;

import java.io.File;
import java.io.Serializable;
import java.io.InputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.Date;
import java.util.Enumeration;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.Cookie;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Simple servlet to get Tomcat version.
 *
 * Author: A.B.Srinivasan.
 */
public class TomcatVersionServlet extends HttpServlet {

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException
    {

        HttpSession session = request.getSession(true);

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        // Title
        out.println("<html>");
        out.println("<body bgcolor=\"white\">");
        out.println("<head>");
        String title = ("Tomcat version servlet");
        out.println("<title>" + title + "</title>");
        out.println("</head>");
        out.println("<body>");

        // Tomcat version
        out.println("<h2> Container info </h2>");
        out.println("<version>" + session.getServletContext().getServerInfo() + "</version>");

        out.println("</body>");
        out.println("</html>");
    }

    public void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException
    {
        doGet(request, response);
    }
}
