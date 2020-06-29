package Mypage;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import member.MemberDAO;
import member.MemberVO;


@WebServlet("/mypage/*")
public class ReviewController extends HttpServlet {
	private static String ARTICLE_IMAGE_REPO = "C:\\board\\article_image";
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
			//전체글 개수
			int count = reviewDAO.getReviewCount();
			//하나의 화면마다 보여줄 글 개수 10
			int pageSize = 10;
			//현재 보여질 페이지번호 가져오기
			String pageNum = request.getParameter("pageNum");
			//현재 보여질 페이지번호가 없으면 1페이지 처리
			if(pageNum == null) {
				pageNum = "1";
			}
			
			//현재 보여질 페이지번호 1을 기본정수 1로 변경/ 현재페이지
			int currentPage = Integer.parseInt(pageNum);
			//현재 보여질 페이지번호 -1 * 한페이지당 보여줄 글 개수 10
			int startRow = (currentPage-1) * pageSize;
			//게시판 글객체(BoardBean)를 저장하기 위한 용도
			List<ReviewVO> articleList = null;
			
			//만약 게시글이 있으면
			if(count > 0) {
				//글목록 가져오기
				articleList = reviewDAO.getReadReviewList(startRow, pageSize);
				System.out.println(articleList.size());
			}
			
			int pageCount = count/pageSize+(count%pageSize == 0?0:1);
			int pageBlock = 5;       
			int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock == 0?1:0))*pageBlock + 1;
			int endPage = startPage + pageBlock-1;//시작페이지번호 + 현재블럭에 보여줄 페이지수 -1
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			request.setAttribute("count", count);
			request.setAttribute("articleList", articleList);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageBlock", pageBlock);
			request.setAttribute("pageCount",pageCount);
			
			nextPage = "/MypageView/review.jsp"; //리뷰로 가즈아.
			
		}else if(action.equals("/reviewWrite.do")) { // 리뷰게시판 글쓰기 폼이동
			
			nextPage = "/MypageView/reviewWrite.jsp"; 
			
		}else if(action.equals("/reviewWritePro.do")) { //글쓰기 처리
		
			//값받아오기
			ServletContext ctx = getServletContext();
			int articleNO = 0;
			String realPath = ctx.getRealPath("/upload");
			int maxSize = 1024*1024*5;
			MultipartRequest multi = new MultipartRequest
					(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			ReviewVO vo = new ReviewVO();
			
			String id = multi.getParameter("id");
			String image = multi.getOriginalFileName("image");
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
		
			vo.setId(id);
			vo.setImage(image);
			vo.setTitle(title);
			vo.setContent(content);
			vo.setDate(new Timestamp(System.currentTimeMillis()));
			
			reviewDAO.insertReview(vo);	
			System.out.println(id);
			if (image != null && image.length() != 0) {
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + image);
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdirs();
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				srcFile.delete();
			}
			nextPage = "/MypageView/review.jsp"; // 글목록 이동(필수)
			
		}
					
		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}
	
	


}
