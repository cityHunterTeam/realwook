package Mypage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDAO;
import member.MemberVO;


@WebServlet("/mypage/*")
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
		HttpSession session = request.getSession();
		
		if(action.equals("/review.do")) { //리뷰 게시판을 보여줘~ 
			
			nextPage = "/MypageView/review.jsp"; //리뷰로 가즈아.
			
		}else if(action.equals("/reviewWrite.do")) { // 리뷰게시판 글쓰기 폼이동
			
			nextPage = "/MypageView/reviewWrite.jsp"; 
			
		}else if(action.equals("/reviewWritePro.do")) { //글쓰기 처리
			
			//값받아오기
			String id = (String)session.getAttribute("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			ReviewVO vo = new ReviewVO(id,title,content);
			reviewDAO.insertReview(vo);
			
			nextPage = "/MypageView/review.jsp"; // 글목록 이동(필수)
			
		}else if(action.equals("/review.do")) {//글목록 보이기
			
			List<ReviewVO> list = reviewDAO.getReviewList();
			request.setAttribute("ReviewList", list);
			
			nextPage = "/MypageView/review.jsp"; //글목록 이동(필수,실행하기위해서?) 
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}
	
	


}
