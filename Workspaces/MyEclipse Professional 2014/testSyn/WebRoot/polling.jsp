<%@ page language="java" contentType="text/html; charset=GBK"  
    pageEncoding="GBK"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=GBK">  
<script type="text/javascript" src="../../static/js/jquery-1.8.0.min.js"></script>  
<title >polling test</title>  
</head>  
<body>  
<div id="message"></div>  
</body>  
<script type="text/javascript">  
    var polling = function(){  
        $.post('../comet.do?method=polling', function(data, textStatus){  
            $("#message").append(data+"<br>");  
        });  
    };  
    interval = setInterval(polling, 3000);  
</script>  
</html>