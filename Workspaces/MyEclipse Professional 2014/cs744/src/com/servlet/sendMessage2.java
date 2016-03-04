package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.MessageDao;
import com.dao.NodeDao;
import com.entity.Edge;

public class sendMessage2 extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
	NodeDao nd = new NodeDao();
	boolean flag = false;
	ArrayList<Integer> path = new ArrayList<Integer>();
	ArrayList<Integer> fake = new ArrayList<Integer>();
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int ori = Integer.parseInt(request.getParameter("ori"));
		int dest = Integer.parseInt(request.getParameter("dest"));
		String message = request.getParameter("message");	
		
		
	}
	boolean helper(HashSet<Integer> hs, int cur, int dest, ArrayList<Integer> fake) {
		if (rememberToChange) {
			return true;
		}
		if (cur == dest) {
			rememberToChange = true;
			return true;
		}
		ArrayList<Integer> neighbors = nd.searchNeighborNode(cur);
		for (int i = 0; i < neighbors.size(); i++) {
			int temp = neighbors.get(i);
			if (!hs.contains(temp) && nd.getNodeById(temp).getStatus() == 0) {
				hs.add(temp);
				fake.add(temp);
				if (!helper(hs, temp, dest, fake)){
					fake.remove(fake.size() - 1);
				}
			}
		}
		return rememberToChange;
	}
	ArrayList<Integer> helper(int ori, int cur, int dest) {
		ArrayList<Integer> neighbors = new ArrayList<Integer>();
		neighbors.addAll(nd.searchNeighborNode(cur));
		if (nd.whetherConnectedToPattern(cur)) {
			neighbors.add(nd.whichPattern(cur));
		} else if (nd.whetherC(cur)) {
			neighbors.addAll(nd.getAllNforPattern(cur));
		}
		for (int i = 0; i < neighbors.size(); i++) {
			int temp = neighbors.get(i);
			if (!hs.contains(temp) && nd.getNodeById(temp).getStatus() == 0) {
				hs.add(temp);
				fake.add(temp);
				if (!helper(hs, temp, dest, fake)){
					fake.remove(fake.size() - 1);
				}
			}
		}
		}
	}
		}
	}

}
