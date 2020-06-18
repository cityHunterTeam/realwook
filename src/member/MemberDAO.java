package member;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//커넥션풀(DataSource)을 얻은 후 ConnecionDB접속
		private Connection getConnection() throws Exception{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
			//커넥션풀에 존재하는 커넥션 얻기
			Connection con = ds.getConnection();
			//커넥션 반환
			return con;
		}

	
	public void addMember(MemberVO m) {
		try {
			con = getConnection();
			String id = m.getId();
			String passwd = m.getPasswd();
			String name = m.getName();
			String birth = m.getBirth();
			System.out.println(birth);
			String email = m.getEmail();
			String phone = m.getPhone();
			String address = m.getAddress();
			String query = "INSERT INTO member(id,passwd,name,birth,email,phone,address) VALUES(?,?,?,?,?,?,?)";
			
			System.out.println(query);
			//PreparedStatement객체를 생성하면서 SQL문을 인자로 전달합니다.
			pstmt = con.prepareStatement(query);
			//?값 셋팅
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			pstmt.setString(3, name);
			pstmt.setString(4, birth);
			pstmt.setString(5, email);
			pstmt.setString(6, phone);
			pstmt.setString(7, address);
			
			//SQL문을 실행합니다.
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
				if(con != null) {con.close();}
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}
	}
	

}
