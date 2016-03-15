package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.MessageDao;
import com.dao.NodeDao;
import com.entity.Edge;

public class sendMessage extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
	}
	NodeDao nd = new NodeDao();
	boolean flag = false;
	boolean rememberToChange = false;
	ArrayList<Integer> path = new ArrayList<Integer>();
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		path.clear();
		rememberToChange = false;
		int ori = Integer.parseInt(request.getParameter("ori"));
		int dest = Integer.parseInt(request.getParameter("dest"));
		String message = request.getParameter("message");
		HashSet<Integer> hs = new HashSet<Integer>();
		PrintWriter out = response.getWriter() ;
		if (nd.getNodeById(ori) == null) {
			out.print("false");
		} else if (nd.getNodeById(ori).getStatus() == 0) {
			path.add(ori);
			hs.add(ori);
			if (!helper(hs, ori, dest,new ArrayList<Integer>())){
				out.print("false");
			} else {
				MessageDao md = new MessageDao();
				md.addMessage(message, ori, dest);
				request.setAttribute("pathNode", path);
				for (int i = 0; i < path.size(); i++) {
					System.out.print(path.get(i) + "");
				}
				out.print(path);
			}
		}
		//request.getRequestDispatcher("sendMessage.jsp").forward(request, response);	
	}
	boolean helper(HashSet<Integer> hs, int cur, int dest, ArrayList<Integer> fake) {
		if (rememberToChange) {
			return true;
		}
		if (cur == dest) {
			path.addAll(fake);
			rememberToChange = true;
			return true;
		}
		ArrayList<Integer> neighbors = new ArrayList<Integer>();
		neighbors.addAll(nd.searchNeighborNode(cur));
		if (nd.whetherConnectedToPattern(cur)) {
			neighbors.add(nd.whichPattern(cur));
		} else if (nd.whetherC(cur)) {
			neighbors.addAll(nd.getAllNforPattern(cur));
		}
		for (int i = 0; i < neighbors.size(); i++) {
			int temp = neighbors.get(i);
			if (!hs.contains(temp) && (nd.getNodeById(temp).getStatus() == 0)) {
				hs.add(temp);
				fake.add(temp);
				if (!helper(hs, temp, dest, fake)){
					fake.remove(fake.size() - 1);
				}
			}
		}
		return rememberToChange;
		}
	}
