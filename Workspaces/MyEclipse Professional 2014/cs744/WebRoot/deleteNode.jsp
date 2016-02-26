<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="draw.jsp"%>
<script type="text/javascript">
	//考虑到当pattern中只有一个点的情况，故并不一定需要左右节点，当pattern节点大于2时才需要，交由后台判断并返回错误信息。
	function check() {
		var x =  form2.nid.value;
		var nubmer1 = parseInt(document.getElementById("nid").value);
		if (x == null || x == "") {
			alert("The node can't be the null!");
			return false;
		}
		if (nubmer1<=0||!(/^\d+$/.test(nubmer1))){
			 alert("Please enter a Integer!");
		     return false;
		} 
			return true;
	}
</script>
			<div class="span10" id="datacontent">

				<form id="form2" action="deleteNode" method="post" onsubmit ="return check()">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Delete Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span1">Node ID:</td>
								<td class="span1"><input class="input-small" name="nid" id="nid"
									size="10" type="text" value=""></input></td>
								<td class="span6">
									<button class="btn btn-primary" type="submit">Delete</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<%@ include file="footer.jsp"%>