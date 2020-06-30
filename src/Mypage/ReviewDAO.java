package Mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Mypage.ReviewVO;
import member.MemberVO;

public class ReviewDAO {
		Connection con;
		PreparedStatement pstmt;
		ResultSet rs;
		
		//커넥션풀(DataSource)을 얻은 후 ConnecionDB접속
			private Connection getConnection() throws Exception{
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/travel");
				//커넥션풀에 존재하는 커넥션 얻기
				Connection con = ds.getConnection();
				//커넥션 반환12
				return con;
			}
			
			private void freeResource() {
				try {
					if(rs == null) {rs.close();}
					if(pstmt != null) {pstmt.close();}
					if(con != null) {con.close();}
				} catch (SQLException e2) {
					e2.printStackTrace();
				}
			}
			
			public void insertReview(ReviewVO vo) {
				String sql = "";
				
				try {
					con=getConnection();
					sql = "select max(num) from review";
					pstmt = con.prepareStatement(sql);
					rs=pstmt.executeQuery();
					
								
					sql="insert into review "
							+ "(id,num,image,title,content,"
							+ "date,pos,depte)"
							+ "values(?,?,?,?,?,now(),?,?)";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, vo.getId());
					pstmt.setInt(2, vo.getNum());
					pstmt.setString(3, vo.getImage());
					pstmt.setString(4, vo.getTitle());
					pstmt.setString(5, vo.getContent());
					pstmt.setInt(6, vo.getPos());
					pstmt.setInt(7, vo.getDepte());
					
					pstmt.executeUpdate();
				} catch(Exception e) {
					e.printStackTrace();
				}finally {
					freeResource();
				}
				
			}
			
			public int getReviewCount() {//전체글개수
				
				String sql="";
				int count=0;
				try {
					con=getConnection();
					sql="select count(*) from review";
					pstmt=con.prepareStatement(sql);
					rs=pstmt.executeQuery();
					
					if(rs.next()) {
						count=rs.getInt(1);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					freeResource();
				}
				return count;
			}
			
			public List<ReviewVO> getReadReviewList(int startRow, int pageSize){
				String sql = "";
				List<ReviewVO> reviewList = new ArrayList<ReviewVO>();
				
				try {
					//DB연결 
					
					con = getConnection();
					//SQL문 만들기 
					//정렬 re_ref 내림차순 정렬하여 검색한 후 re_seq 오름차순정렬하여 검색해 오는데 
					//limit 각 페이지마다 맨위에 첫번째로 보여질 시작글 번호, 한 페이지당 보여줄 글개수 
					sql = "select * from review order by num desc limit ?,?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, pageSize);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						ReviewVO vo = new ReviewVO();
						//rs=> Boardvo에 저장 
						vo.setId(rs.getString("id"));
						vo.setNum(rs.getInt("num"));
						vo.setImage(rs.getString("image"));
						vo.setTitle(rs.getString("title"));
						vo.setContent(rs.getString("content"));
						vo.setDate(rs.getTimestamp("date"));
						vo.setPos(rs.getInt("pos"));
						vo.setDepte(rs.getInt("Depte"));
						 //Boardvo => ArrayList에 추가 
						 
						reviewList.add(vo);
					}//while반복
				}catch (Exception e) {
					System.out.println("getReadReviewList메소드에서 예외발생 : " +e);
					// TODO: handle exception
				}finally {
					freeResource();
				}
				return reviewList; //ArrayList를 notice.jsp로 리턴 
			}//getBoardList메소드 끝 
			
			
						
			public int insertNewArticle(ReviewVO article) {
				int num =0;
				try {
					con = getConnection();
					String title = article.getTitle();
					String content = article.getContent();
					String id = article.getId();
					String image = article.getImage();
					String query = "INSERT INTO review (id,image,title,content,date)"
							+ " VALUES (?, ? ,?, ?,now())";
					System.out.println(query);
					pstmt = con.prepareStatement(query);
					
					pstmt.setString(1, id);
					pstmt.setString(2, image);
					pstmt.setString(3, title);
					pstmt.setString(4, content);
					
					pstmt.executeUpdate();
					
					query = "SELECT  max(num) from review ";
					System.out.println(query);
					pstmt = con.prepareStatement(query);
					ResultSet rs = pstmt.executeQuery(query);
					if (rs.next())
						num = rs.getInt(1);
					
				
					pstmt.close();
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}

				return num;
			}
			
			public int reviewReadCount(int num) {
				
				String sql="";
			
				try {
					con=getConnection();
					sql="update review set readcount=readcount+1 where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null)try {rs.close();}catch(SQLException ex) {}
					if(pstmt!=null)try {pstmt.close();}catch(SQLException ex) {}
					if(con!=null)try {con.close();}catch(SQLException ex) {}
				}
				return num;
			}
			
			public ReviewVO getupload(int num){
				
				ReviewVO vo = null;		
				try {
					
					con = getConnection();
					
					String sql = "select * from review where num=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);			
					rs = pstmt.executeQuery();  			
					if(rs.next()) {			
					vo = new ReviewVO();
					vo.setNum(rs.getInt("num"));
					vo.setId(rs.getString("id"));
					vo.setImage(rs.getString("image"));
					vo.setTitle(rs.getString("title"));
				 	vo.setContent(rs.getString("content"));
					vo.setReadcount(rs.getInt("readcount"));
					vo.setDate(rs.getTimestamp("date"));
					
					}
				} catch (Exception e) {
					System.out.println("getupload 얻기 실패 : "+e);
				} finally {
					freeResource();
					if(con != null){try {con.close();} catch (Exception e) {e.printStackTrace();}}
					if(rs != null){try {rs.close();} catch (Exception e) {e.printStackTrace();}}
					if(pstmt != null){try {pstmt.close();} catch (Exception e) {e.printStackTrace();}}
				}//finally					
				return vo; //getupload 끝
			}
}
