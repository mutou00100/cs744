<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="head.jsp"%>
<%String error = "";
	NodeDao nd = new NodeDao();
	ArrayList<Integer> res = nd.getAllC();
	List<Node> allnodes = nd.getAllNodes();
	List<Edge> edge = nd.getCEdges();
	List<Edge> edgeCC = nd.getEdgesForC();
	List<Edge> edgeNN = nd.getEdgesForN();
	List<Edge> edgeCN = nd.getCEdges();
	edge.addAll(nd.getNEdges());
	List<Integer> allPatterns = nd.getAllC();
	ArrayList<Edge> pathEdge = new ArrayList<Edge>();
	ArrayList<Integer> pathNode = new ArrayList<Integer>();
	if (request.getAttribute("pathEdge") != null) {
		 pathEdge = (ArrayList<Edge>)request.getAttribute("pathEdge");
	}
	if (request.getAttribute("pathNode") != null) {
		pathNode = (ArrayList<Integer>)request.getAttribute("Integer");
	}
	HashSet<Edge> hs = new HashSet<Edge>();
	HashSet<Edge> hs1 = new HashSet<Edge>();
	
	if (pathEdge.size() != 0){
		hs = new HashSet<Edge>(pathEdge);
	}
	if (edgeCC.size() != 0){
		hs1 = new HashSet<Edge>(edgeCC);
	}
	%>
<link type="text/css" rel="stylesheet" href="css/table.css" />
<script type="text/javascript" src="js/exampleUtil.js"></script>
<script type="text/javascript" src="js/vis.js"></script>
<link href="js/vis.css" rel="stylesheet" type="text/css" />
<script src="js/googleAnalytics.js"></script>
<% 
if (request.getAttribute("error") == null) {
	} else {
			 error = (String) request.getAttribute("error");
				%>
   <script>
    alert("<%=error%>");</script>
   <% }
%>
<div class="span10" id="datacontent">

				<form id="form2" action="sendMessage" method="post" onsubmit ="return check()">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Non-connector Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>sender：</td>
								<td class="input"><input name="ori" id= "n1" class="input-small"
									size="10" type="text" value=""></input></td>
								<td>receiver：</td>
								<td class="input"><input class="input-small" id= "n2" name="dest"
									size="10" type="text" value=""></input></td>
								<td>message：</td>
								<td class="input"><input class="input-small" id= "n2" name="message"
									size="10" type="text" value=""></input></td>
								<td><a onclick = addx();>show path</a>></td>
								<td>
									<button class="btn btn-primary" type="submit">Send</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<%@ include file="footer.jsp"%>
<script type="text/javascript">
   var nodes, edges, network;
    var DIR = '<%=path%>/img/';
	var EDGE_LENGTH_MAIN = 400;
	var EDGE_LENGTH_SUB = 80;
  		
	function draw() {
		nodes = new vis.DataSet();
		edges = new vis.DataSet();
<%
  		if(allnodes != null) { 
  			for (int i=0;i<allnodes.size();i++){%>
	
				<%if (allnodes.get(i).getType().equals("c")){%>
				nodes.add({id :<%=allnodes.get(i).getnID()%>, label : 'Pattern' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Network-Pipe-icon.png',shape : 'image'
				});
				<%}else {%>
				nodes.add({id :<%=allnodes.get(i).getnID()%>,label : 'Node' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Hardware-My-Computer-3-icon.png',shape : 'image'});
<%}%>
	
<%}
  		}%>
	
		<%
  		if(edge != null) { // 有信息返
  			for (int i=0;i<edgeCC.size();i++){
  			if (!hs.contains((edgeCC.get(i)))){
  			%>
			edges.add({from :<%=edgeCC.get(i).getNode1()%>, to :<%=edgeCC.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_MAIN,dashes:true});
			<%}}
			for (int i=0;i<edgeCN.size();i++){
			if( !hs.contains((edgeCN.get(i)))){
  			%>	
			edges.add({from :<%=edgeCN.get(i).getNode1()%>, to :<%=edgeCN.get(i).getNode2()%>,smooth:false,length : EDGE_LENGTH_SUB});
			<%}}
			for (int i=0;i<edgeNN.size();i++){
			if (!hs.contains((edgeNN.get(i)))){			%>
			edges.add({from :<%=edgeNN.get(i).getNode1()%>, to :<%=edgeNN.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_SUB});
			<%}}
  		}%>
	// create a network
		var container = document.getElementById('mynetwork');
		var data = {
			nodes : nodes,
			edges : edges
		};
		var options ={layout:{randomSeed:1}};
		network = new vis.Network(container, data, options);
	}
	function addx(){
		<%
  		if(pathEdge != null) { // 有信息返
  			for (int i=0;i<pathEdge.size();i++){
  			if (hs1.contains(pathEdge.get(i))){
  			%>		
			setTimeout(edges.add({from :<%=pathEdge.get(i).getNode1()%>, 
			to :<%=pathEdge.get(i).getNode2()%>,
			arrows:'to',color:'#FFA807',
			length : EDGE_LENGTH_MAIN,dashes:true}),2000);
			<%} else { %>
			setTimeout(edges.add({from :<%=pathEdge.get(i).getNode1()%>, 
			to :<%=pathEdge.get(i).getNode2()%>,
			arrows:'to',color:'#FFA807'}),2000);
  		<%}}
  		}%>}
<% 
if (pathEdge.size() != 0){
		hs = new HashSet<Edge>(pathEdge);%>
	</script><%}
request.getParameter("path");
if (allnodes.size() == 0){%>
   <script>
    alert("Please add a pattern first");
    window.location.href = "addConnector.jsp";</script>
   <% }
%>