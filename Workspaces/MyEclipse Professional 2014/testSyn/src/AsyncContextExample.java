import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.AsyncContext;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(asyncSupported = true, value = "/AsyncContextExample", loadOnStartup = 1)
public class AsyncContextExample extends HttpServlet   {
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
		doGet(request,response);
	}
    public void doGet(final HttpServletRequest request, HttpServletResponse response) throws IOException{
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();
      AsyncContext asyncContext = request.startAsync();
      asyncContext.setTimeout(0);
      ServletRequest servReq = asyncContext.getRequest();
      boolean b = servReq.isAsyncStarted();
      final int count = 0;
      asyncContext.dispatch("/asynctest.jsp");
      Timer timer=new Timer();
      timer.schedule(new TimerTask(){
    	  public void run(){ request.setAttribute("nodes", count++);}}, 1000, 2000); 
      out.println("isAsyncStarted : "+(count++));
	  out.println("<br/>asynchronous task finished.");	
     }
	}
}
