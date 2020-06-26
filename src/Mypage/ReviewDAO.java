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
					sql = "select max(num) from board";
					pstmt = con.prepareStatement(sql);
					rs=pstmt.executeQuery();
					
								
					sql="insert into board "
							+ "(id,num,title,content,"
							+ "date,pos,depte)"
							+ "values(?,?,?,?,now(),?,?)";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, vo.getId());
					pstmt.setInt(2, vo.getNum());
					pstmt.setString(3, vo.getTitle());
					pstmt.setString(4, vo.getContent());
					pstmt.setInt(5, vo.getPos());
					pstmt.setInt(6, vo.getDepte());
					
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
					sql="select count(*) from board";
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
			
			public List<ReviewVO> getReviewList(){//배열
				
				
				String sql="";
				List<ReviewVO> ReviewList =new ArrayList<ReviewVO>();
				
				try {
					con=getConnection();
					sql = "select * from board";
					pstmt=con.prepareStatement(sql);
					
					rs=pstmt.executeQuery();
					
					while(rs.next()) {
						ReviewVO vo=new ReviewVO();
						
						vo.setNum(rs.getInt("num"));
						System.out.println(vo.getNum());
						vo.setTitle(rs.getString("title"));
						System.out.println(vo.getTitle());
						vo.setDate(rs.getDate("date"));
						System.out.println(vo.getDate());
						
						ReviewList.add(vo);
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						freeResource();
					}
					return ReviewList;
				}
}
