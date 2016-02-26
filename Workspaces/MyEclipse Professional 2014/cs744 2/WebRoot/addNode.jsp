<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="draw.jsp"%>
<% 
if (allnodes.size() == 0){%>
   <script>
    alert("Please add a pattern first");
    window.location.href = "addConnector.jsp";</script>
   <% }
%>
<script type="text/javascript">
	function check() {
		if ( form2.n2.value ==""&& form2.n1.value =="") {
			return true;
		}
		if (form2.gid.value == form2.n1.value) {
			alert("The node1 can't be the connector!");
			return false;
		}if (form2.gid.value == form2.n2.value) {
			alert("The node2 can't be the connector!");
			return false;
		}if (form2.n1.value == form2.n2.value && form2.n1.value != "" && form2.n2.value != "") {
			alert("The node1 and node2 can't be the same!");
			return false;
		}
		var nubmer1 = parseInt(document.getElementById("n1").value);
		var nubmer2 = parseInt(document.getElementById("n2").value);
		if (form2.n1.value !=""&&(nubmer1<=0||!(/^\d+$/.test(nubmer1)))){
				 alert("Please enter a Integer!");
	     return false;
			}
			if (form2.n2.value !=""&&(nubmer2<=0||!(/^\d+$/.test(nubmer2)))){
				alert("Please enter a Integer!");
				return false;
			}
		return true;
	}
</script>
			<div class="span10" id="datacontent">

				<form id="form2" action="AddNode" method="post" onsubmit ="return check()">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Non-connector Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Pattern:</td>
								<td><select name="gid">
										<%
											if (allPatterns != null && allPatterns.size() != 0) {
												for (int i = 0; i < allPatterns.size(); i++) {
													int pattern = allPatterns.get(i);
													out.println("<option value = " +  pattern + ">" +  pattern
															+ "</option>");
												}
											}
										%>
								</select></td>
								<td>NonConnector Node1：</td>
								<td class="input"><input name="n1" id= "n1" class="input-small"
									size="10" type="text" value=""></input></td>
								<td>NonConnector Node2：</td>
								<td class="input"><input class="input-small" id= "n2" name="n2"
									size="10" type="text" value=""></input></td>
								<td class="input"><input name="flag" type="checkbox" value="0">Connect to the connector</input></td>
								<td>
									<button class="btn btn-primary" type="submit" onclick="return check();">Add</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<%@ include file="footer.jsp"%>