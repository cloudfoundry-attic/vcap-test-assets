package com.vmware.appcloud.testapps.javatinyapp;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MainServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if ("true".equals(request.getParameter("shutdown"))) {
			System.exit(1);
		}
		response.setContentType("text/plain");
		response.setStatus(200);
		PrintWriter writer = response.getWriter();
		writer.println("It just needed to be restarted!");
		writer.println("My instance id: " + System.getenv("VCAP_APP_ID"));
		writer.println("My location: " + System.getenv("VCAP_DEA_HOST") + ":" + System.getenv("VCAP_DEA_PORT"));
		writer.close();
	}
}
