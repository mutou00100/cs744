package com.utils;
import java.util.ArrayList;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

import com.dao.NodeDao;

public class RandomGenerator extends TimerTask  {
	private int random = -2;
	@Override
	public void run() {
		NodeDao nd1 = new NodeDao();
		ArrayList<Integer> activeNodes1 = nd1.getAllActiveNodes();
		while(activeNodes1.size()>0) {
			NodeDao nd = new NodeDao();
			ArrayList<Integer> activeNodes = nd.getAllActiveNodes();
			int range = activeNodes.size();
			Random generator = new Random();
			int node = activeNodes.get(generator.nextInt(range));
			random = node;
			nd.updateNodeToInactive(node);	
			System.out.println(node);
			try {
				Thread.sleep(6000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		return;
	}	
//	 
	public int getRandom() {
		return random;
	}
}
