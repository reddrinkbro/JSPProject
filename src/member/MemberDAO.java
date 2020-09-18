package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String sql ="";
	
	public void resourceClose(){
		try {
			if(con != null) con.close();
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
		} catch (SQLException e) {
			System.out.println("resourceClose()에서 예외발생 : " + e);
		}
	}
	
	private Connection getConnection() throws Exception{
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:/comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		return con;
	}
	public int checkMember(String id, String pw){
		int check = -1;
		try {
			con = getConnection();
			
			sql = "select * from member where id=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					check = 1;
				}else{
					check = 0;
				}
			}
		} catch (Exception e) {
			System.out.println("userCheck()에서 예외발생 : "+ e);
		}finally {
			resourceClose();
		}
		return check;
	}
	
	public boolean insertMember(MemberBean memberbean){
		boolean check = false;
		try{
			con = getConnection();
			
			sql = "insert into member(id,pw,tel,email,postal,addr,detailAddr) values(?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, memberbean.getId());
			pstmt.setString(2, memberbean.getPw());
			pstmt.setString(3, memberbean.getTel());
			pstmt.setString(4, memberbean.getEmail());
			pstmt.setString(5, memberbean.getPostal());
			pstmt.setString(6, memberbean.getAddr());
			pstmt.setString(7, memberbean.getDetailAddr());
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("insertMember()에서 예외발생 : " +e);
		}finally{
			resourceClose();
			check = true;
		}
		return check;
	}
	public boolean modifyMember(MemberBean memberbean){
		boolean check = false;
		try{
			con = getConnection();
			
			sql = "update member set pw = ?, tel = ?, email = ?, postal = ?, addr = ?, detailAddr = ? where id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, memberbean.getPw());
			pstmt.setString(2, memberbean.getTel());
			pstmt.setString(3, memberbean.getEmail());
			pstmt.setString(4, memberbean.getPostal());
			pstmt.setString(5, memberbean.getAddr());
			pstmt.setString(6, memberbean.getDetailAddr());
			pstmt.setString(7, memberbean.getId());
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("modifyMember()에서 예외발생 : " +e);
		}finally{
			resourceClose();
			check = true;
		}
		return check;
	}
	public MemberBean getMember(String id){
		MemberBean bean = new MemberBean();
		try{
			con = getConnection();
			sql = "select* from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			bean.setId(rs.getString("id"));
			bean.setPw(rs.getString("pw"));
			bean.setTel(rs.getString("tel"));
			bean.setEmail(rs.getString("email"));
			bean.setPostal(rs.getString("postal"));
			bean.setAddr(rs.getString("addr"));
			bean.setDetailAddr(rs.getString("detailAddr"));
		}catch(Exception e){
			System.out.println("getMember()에서 예외발생 : " +e);
		}finally{
			resourceClose();
		}
		return bean;
	}
	public int idcheck(String id){
		int check = 0;
		try{
			con = getConnection();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check = 1;
			}
		}catch(Exception e){
			System.out.println("idcheck()에서 예외발생 : " +e);
		}finally{
			resourceClose();
		}
		return check;
	}
}
