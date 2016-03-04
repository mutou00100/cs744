package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class showMessage extends HttpServlet {
			@Override
			protected void doGet(HttpServletRequest req, HttpServletResponse resp)
					throws ServletException, IOException {
				// TODO Auto-generated method stub
				String method = req.getParameter("method");
				if (method != null){
					if (method.equals("show")){
						int pageNo = 1;
						int pageSize = 8;
						String key = req.getParameter("id");
						if (key == null || key.equals("null")) key = "";
						HashMap parameters = new HashMap();
						parameters.put("id", key);
						parameters.put("name", key);
						req.setAttribute("id", key);
						if (req.getParameter("pageNo") != null){
							pageNo = Integer.parseInt(req.getParameter("pageNo"));
						}
						if (req.getParameter("pageSize") != null){
							pageSize = Integer.parseInt(req.getParameter("pageSize"));
						}
						req.setAttribute("sp", dao.showUser(pageNo, pageSize, parameters));
						req.getRequestDispatcher("showin.jsp").forward(req, resp);
					}
				} else {
					this.addUser(req,resp);
				}
			}

			@Override
			protected void doPost(HttpServletRequest req, HttpServletResponse resp)
					throws ServletException, IOException {
				doGet(req,resp);
			}
			
			private void addUser(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
				User user = new User();
				
				boolean result = service.addUser(user);
				if (result){
					
					req.getRequestDispatcher("add_success.jsp").forward(req,
							resp);
				} else {
					req.getRequestDispatcher("add_fal.jsp").forward(req,
							resp);
				}
			}