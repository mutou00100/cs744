package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import com.entity.Message;
import com.entity.Question;
import com.utils.ConnUtils;
import com.utils.SeparatePage;

public class MessageDao {
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private int ri,row,rc;
	public boolean addMessage(String content, int origin, int destination) {
		boolean result = false;
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = sdf.format(dt);
			try {
				conn = ConnUtils.getConnection();//
				pstmt = conn.prepareStatement("INSERT INTO Message(id,content,origin, destination)"
						+ "VALUES(?,?,?,?)");
				
				pstmt.setString(1, currentTime);
				pstmt.setString(2, content);
				pstmt.setInt(3, origin);
				pstmt.setInt(4, destination);
				row = pstmt.executeUpdate();
				if (row > 0){
				    result =true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				ConnUtils.releaseConn(rs, pstmt, conn);
			}
			return result;
		}
	public List<Message> showMessage(int pageNo, int pageSize, Map<String, String> parameters) {
		List<Message> result = new ArrayList<Message>();
		int firstPos = (pageNo - 1) * pageSize;
		StringBuffer sql = new StringBuffer("SELECT * FROM T_per_info ");
		if (parameters != null){
			Set keySet = parameters.keySet();
			if (keySet != null && keySet.size() > 0){
				for (Iterator it = keySet.iterator(); it.hasNext(); ){
					String key = (String)it.next();
					String value = "'%" + (String)parameters.get(key) + "%'";
					if (sql.indexOf("WHERE") == -1){
						sql.append(" WHERE ").append(key).append(" LIKE ").append(value);
					} else {
						sql.append(" OR ").append(key).append(" LIKE ").append(value);
					}
				}
			}
		}
		sql.append(" LIMIT ").append(firstPos).append(",").append(pageSize);
		
		try {
			conn = ConnUtils.getConnection();//
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				Message message = new Message();
				result.add(message);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnUtils.releaseConn(rs, pstmt, conn);
		}
		return result;

	}
	public int GetMessageCount(Map parameters){
		int result = 0;
		StringBuffer sql = new StringBuffer().append("SELECT COUNT(*) FROM T_per_info");
		if (parameters != null){
			Set keySet = parameters.keySet();
			if (keySet != null && keySet.size() > 0){
				for (Iterator it = keySet.iterator(); it.hasNext(); ){
					String key = (String)it.next();
					String value = "'%" + (String)parameters.get(key) + "%'";
					if (sql.indexOf("WHERE") == -1){
						sql.append(" WHERE ").append(key).append(" LIKE ").append(value);
					} else {
						sql.append(" OR ").append(key).append(" LIKE ").append(value);
					}
				}
			}
		}
		try{
		conn = ConnUtils.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql.toString());
		if (rs.next()){
			result = rs.getInt(1);
		}
		}catch (SQLException e){}
		finally {
			ConnUtils.releaseConn(rs, stmt, conn);
		}
		return result;
	}
	public SeparatePage showMessageService(int pageNo, int pageSize, Map parameters) {
		List<Message> userList = showMessage(pageNo, pageSize, parameters);
		int totalRecord = GetMessageCount(parameters);
		SeparatePage sp = new SeparatePage();
		parameters.put("method", "show");
		sp = sp.createSeparatePage("userServlet", pageNo, pageSize, totalRecord, userList, parameters);
		return sp;
	}}
	