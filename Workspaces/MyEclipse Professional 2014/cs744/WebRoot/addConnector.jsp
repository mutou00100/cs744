<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="draw.jsp"%>
<script type="text/javascript">
function check() {
	var len = document.querySelectorAll('input[type="checkbox"]:checked').length;
	var x = <%=res%>.length;
	if (x != 0 && len == 0 ) {
		alert("You must select at least one pattern!");
		return false;
	}
	return true;
}
</script>
<div class="span10" id="datacontent">
		<form id="form2" action="AddConnector" method="post"
		method="post" onsubmit ="return check()">
		<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Pattern</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span4"><% 
    	if (res.size() != 0) {
    	 out.println("Please choose the neighbor patterns");}
    	for (int i = 0; i < res.size(); i++) {
    		out.print("<input type=\"checkbox\" name= \"checkedC\" value="+res.get(i)+">" + res.get(i));
    	} %></td>
						
								<td class="span6">
									<button class="btn btn-primary" type="submit">Generate Pattern</button>
								</td>
							</tr>
						</tbody>
					</table>
		</form>
<%@ include file="footer.jsp"%>