package Mypage;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;


@WebServlet("/Mypage.do")
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ReviewDAO reviewDAO;

	
	public void init(ServletConfig config) throws ServletException {
		reviewDAO = new ReviewDAO();
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doHandle(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String nextPage = null;//초기화
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String action = request.getPathInfo(); //경로를 지정하는 아이
		System.out.println("action:" + action);
		
		if(action.equals("review.do")) { //리뷰 게시판을 보여줘~ 
			nextPage = "/Mypage/review.jsp"; //리뷰로 가즈아.
		}
	}

}
