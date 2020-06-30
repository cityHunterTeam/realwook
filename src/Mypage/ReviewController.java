package Mypage;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	private static String ARTICLE_IMAGE_REPO = "D:\\git\\TeamProject\\WebContent\\upload";
	ReviewDAO reviewDAO;
	ReviewVO vo;


	
	public void init(ServletConfig config) throws ServletException {
		
		reviewDAO = new ReviewDAO();
		vo = new ReviewVO();
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
			
			int articleNO = 0;
			Map<String, String> articleMap = upload(request, response);
			String id = articleMap.get("id");
			String image = articleMap.get("image");
			String title = articleMap.get("title");
			String content = articleMap.get("content");

			vo.setId(id);
			vo.setImage(image);
			vo.setTitle(title);
			vo.setContent(content);
			
			articleNO = reviewDAO.insertNewArticle(vo);
			if (image != null && image.length() != 0) {
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + image);
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
				destDir.mkdirs();
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				srcFile.delete();
			}
			PrintWriter pw = response.getWriter();
			pw.print("<script>" + "  alert('새글을 추가했습니다.');" + " location.href='" + request.getContextPath()
					+ "/mypage/review.do';" + "</script>");

			return;
		
		}
					
		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}//doHandle
	
	
	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "utf-8";
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("파라미터명:" + fileItem.getFieldName());
					//System.out.println("파일명:" + fileItem.getName());
					System.out.println("파일크기:" + fileItem.getSize() + "bytes");
					//articleMap.put(fileItem.getFieldName(), fileItem.getName());
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}

						String fileName = fileItem.getName().substring(idx + 1);
						System.out.println("파일명:" + fileName);
						//익스플로러에서 업로드 파일의 경로 제거 후 map에 파일명 저장
						articleMap.put(fileItem.getFieldName(), fileName);  
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);

					} // end if
				} // end if
			} // end for
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleMap;
	}//upload

}
