<%@ include file="realhead.jsp"%>
<% 
if (request.getAttribute("error") == null) {
	} else {
			 error = (String) request.getAttribute("error");
				%>
   <script>
    alert("<%=error%>");</script>
   <% }
%>
<body onload="draw();"> 
<div id="mynetwork" ></div>
<script type="text/javascript">
var inactivelist = [3];
   	var nodes, edges, network;
    var DIR = 'img/';
	var EDGE_LENGTH_MAIN = 500;
	var EDGE_LENGTH_SUB = 100;
	function draw() {
		nodes = new vis.DataSet();
		edges = new vis.DataSet();
<%
  		if(allnodes != null) { 
  			for (int i=0;i<allnodes.size();i++){%>
	
				<%if (allnodes.get(i).getType().equals("c")){%>
				nodes.add({id :<%=allnodes.get(i).getnID()%>, label : 'Pattern' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Network-Pipe-icon.png',shape : 'circularImage',
				 color: {
            	background: '#6AAFFF',
            	border: '#6AAFFF'
         		},
				});
				
				<%}
				if (allnodes.get(i).getType().equals("n")){%>
				nodes.add({id :<%=allnodes.get(i).getnID()%>,label : 'Node' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Hardware-My-Computer-3-icon.png',shape : 'circularImage', color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          },});<%}%>
          <%if (allnodes.get(i).getStatus()!=0){%>
				nodes.update({id :<%=allnodes.get(i).getnID()%>,
				 color: {
            background: '#6AAFFF',
            border: 'gray'
          }});
				<%}}}%>
		
	
		<%
  		if(edge != null) { // 有信息返
  			for (int i=0;i<edgeCC.size();i++){
  			%>
			edges.add({id: <%=edgeCC.get(i).geteID()%>, from :<%=edgeCC.get(i).getNode1()%>, to :<%=edgeCC.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_MAIN,dashes:true});
			<%}
			for (int i=0;i<edgeCN.size();i++){
  			%>	
			edges.add({from :<%=edgeCN.get(i).getNode1()%>, to :<%=edgeCN.get(i).getNode2()%>,smooth:false,length : EDGE_LENGTH_SUB});
			<%}
			for (int i=0;i<edgeNN.size();i++){	%>
			edges.add({id: <%=edgeNN.get(i).geteID()%>, from :<%=edgeNN.get(i).getNode1()%>, to :<%=edgeNN.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_SUB});
			<%}}
  		%>
	// create a network
		var container = document.getElementById('mynetwork');
		var data = {
			nodes : nodes,
			edges : edges
		};
		var options ={
		layout:{randomSeed:1},
		 nodes: {
		 borderWidth:6,
		  size:25,
          shapeProperties: {
            useBorderWithImage:true
          }
        },};
		network = new vis.Network(container, data, options);}
		
		function createXMLHttp(){
			if(window.XMLHttpRequest){
				xmlHttp = new XMLHttpRequest() ;
			} else {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP") ;
			}
		}
	function sendMessage(){
			ori = window.parent.document.getElementById('frame2').contentWindow.document.getElementById('ori').value;
			dest = window.parent.document.getElementById('frame2').contentWindow.document.getElementById('dest').value;
			message = window.parent.document.getElementById('frame2').contentWindow.document.getElementById('message').value;
			createXMLHttp() ;
			xmlHttp.open("POST","sendMessage?ori="+ori+ "&&dest=" +dest +"&&message=" + message) ;
			xmlHttp.onreadystatechange = sendMessageCallback ;
			xmlHttp.send() ;
	}
  	function sendMessageCallback(){
  		if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var txt1 = xmlHttp.responseText ;
					if (txt1 == "false") {
						alert("This message failed to be sent");
					} else {
					var txt2 = txt1.substring(1,txt1.length-1);
					var txt3 = txt2.split(",");
					txt=[];
					for(var j=0;j<txt3.length;j++){
						txt.push(parseInt(txt3[j]));
					}
						add(txt);
					}					
				}
			}
  	}
  	function add(txt)
  					{
  					console.log(txt);
  					var count = 0;
					for (var i = 0; i < txt.length; i++) {
						get(i,count,txt);
						get2(i,count+1,txt);
						count++;}	
  	}
  	function get(i,count,txt) {
			setTimeout(function() {
					if (inactivelist.indexOf(txt[i])<0){
						nodes.update({id: txt[i],color: {border: 'green'}});
						pre = txt[i];	
					}
						else {
						sendMessage(pre,dest,message);
					}
			},1000*count);
  	}
  	function get2(i,count,txt) {
  		setTimeout(function() {
  					if (i == txt.length - 1) {
  						alert("The message has been sent successfully");
  					} 
					nodes.update({id: txt[i],color: {border: '#6AAFFF'}});}
					,1000*(count));
  	}
  	function addEdge(node0, node1, node2, type){
  		if (type == "CC"){
  			edges.add({id: node0, from :node1, to :node2,smooth: {type: 'dynamic'},length : EDGE_LENGTH_MAIN,dashes:true});
  		} else if (type == "CN"){
  			edges.add({from :node1, to :node2,smooth:false,length : EDGE_LENGTH_SUB});
  		} else {
  			edges.add({id: node0, from :node1, to :node2,smooth: {type: 'dynamic'},length : EDGE_LENGTH_SUB});
  		}
  	}
  	function addNode(node, type) {
  		if (type == 'c'){
  		nodes.add({id :node, label : 'Pattern'+node,image : DIR + 'Network-Pipe-icon.png',shape : 'circularImage',
		 borderWidth:6,
		  size:25,
	      color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          },
          shapeProperties: {
            useBorderWithImage:true
          }
		});} else {
			nodes.add({id :node, label : 'Node'+node,image : DIR + 'Hardware-My-Computer-3-icon.png',shape : 'circularImage',
		 borderWidth:6,
		  size:25,
	      color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          },
          shapeProperties: {
            useBorderWithImage:true
          }
		});
		}
  	}
  	function addConnector(){
  			var checkboxes= window.parent.document.getElementById('frame2').contentWindow.document.getElementsByName('checkedC');
			var checkedC = [];
			for (var i=0; i<checkboxes.length; i++) {
			    if (checkboxes[i].checked) {
			        checkedC.push(checkboxes[i].value);
			    }
			}
			createXMLHttp() ;
			xmlHttp.open("POST","addConnector?checkedC="+checkedC) ;
			xmlHttp.onreadystatechange = addConnectorCallback ;
			xmlHttp.send() ;
  	}
  	function addConnectorCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
					//var parser = new DOMParser();
					//var xml = parser.parseFromString(xmlHttp.responseText, "application/xml");
					if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						addNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue, "c");
  						for (var i = 0; i < xml.getElementsByTagName("node1").length; i++) {
  						addEdge(xml.getElementsByTagName("node0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("node1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("node2")[i].childNodes[0].nodeValue, "CC");
  						}		
					}
				}
  	}}
  	function removeNode(node) {
  		nodes.remove({id :node});
  	}
  	function deleteNode(){
  			var nid= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('nid').value;
			createXMLHttp() ;
			xmlHttp.open("POST","deleteNode?nid="+nid) ;
			xmlHttp.onreadystatechange = deleteNodeCallback;
			xmlHttp.send() ;
  	}
  	function deleteNodeCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
					//var parser = new DOMParser();
					//var xml = parser.parseFromString(xmlHttp.responseText, "application/xml");
					if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						removeNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue);
  						for (var i = 0; i < xml.getElementsByTagName("addEdge1").length; i++) {
  						addEdge(xml.getElementsByTagName("addEdge0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("addEdge1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("addEdge2")[i].childNodes[0].nodeValue, "NN");
  						}		
					}
				}
  	}}
  	function addNonNode(){
  			var gid= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('gid').value;
  			var n1= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('n1').value;
  			var n2= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('n2').value;
  			var f= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('flag').checked;
  			var flag;
  			if (f == true) {
  				flag = 0; 
  			} else {
  				flag = -1;
  			}
			createXMLHttp() ;
			xmlHttp.open("POST","addNode?gid="+gid+"&&n1="+n1+"&&n2="+n2+"&&flag="+flag) ;
			xmlHttp.onreadystatechange = addNonNodeCallback;
			xmlHttp.send() ;
  	}
  	function addNonNodeCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
				if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						addNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue,"n");
  						for (var i = 0; i < xml.getElementsByTagName("edgeCN1").length; i++) {
  						addEdge("",xml.getElementsByTagName("edgeCN1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("edgeCN2")[i].childNodes[0].nodeValue, "CN");
  						}		
  						for (var i = 0; i < xml.getElementsByTagName("edgeNN0").length; i++) {
  						addEdge(xml.getElementsByTagName("edgeNN0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("edgeNN1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("edgeNN2")[i].childNodes[0].nodeValue, "NN");
  						}
  						for (var i = 0; i < xml.getElementsByTagName("edgeDelete").length; i++) {
  						edges.remove(xml.getElementsByTagName("edgeDelete")[i].childNodes[0].nodeValue);	
					}
  	}}}}
  	
  	function activateNode(){
  			var nid= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('nid').value;
			createXMLHttp() ;
			xmlHttp.open("POST","activateNode?nid="+nid) ;
			xmlHttp.onreadystatechange = activateNodeCallback;
			xmlHttp.send() ;
  	}
  	function activateNodeCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var text = xmlHttp.responseText;
				if (text == "error") {
						alert("you can't activate this node");
					} else {
						nodes.update({id: text,color: {border: '#6AAFFF'}});
					}
  	}}}	
		</script>