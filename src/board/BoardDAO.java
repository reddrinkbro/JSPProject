package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
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
			System.out.println("resourceClose()�뿉�꽌 �삁�쇅諛쒖깮 : " + e);
		}
	}
	
	private Connection getConnection() throws Exception{
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:/comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		return con;
	}
	public boolean insertBoard(BoardBean bBean){
		boolean check = false;
		int num = 0;
		try {
			con = getConnection();
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			sql = "insert into board(num,subject,price,content,date,id,pw,category,img1,img2,img3) values (?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getSubject());
			pstmt.setString(3, bBean.getPrice());
			pstmt.setString(4, bBean.getContent());	
			pstmt.setString(5, bBean.getDate());
			pstmt.setString(6, bBean.getId());
			pstmt.setString(7, bBean.getPw());
			pstmt.setString(8, bBean.getCategory());
			pstmt.setString(9, bBean.getImg1());
			pstmt.setString(10, bBean.getImg2());
			pstmt.setString(11, bBean.getImg3());
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("insertBoard()에서 예외 발생 : " + e);
			e.printStackTrace();
		}finally{
			resourceClose();
			check = true;
		}
		return check;
	}
	public BoardBean getBoard(int num){
		BoardBean bean = null;
		try {

			con = getConnection();
			sql = "select * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bean = new BoardBean();
				bean.setId(rs.getString("id"));
				bean.setSubject(rs.getString("subject"));
				bean.setPrice(rs.getString("price"));
				bean.setContent(rs.getString("content"));
				bean.setImg1(rs.getString("img1"));
				bean.setImg2(rs.getString("img2"));
				bean.setImg3(rs.getString("img3"));
				bean.setDate(rs.getString("date"));
				bean.setNum(rs.getInt("num"));
				bean.setPw(rs.getString("pw"));
				bean.setCategory(rs.getString("category"));
			}
		} catch (Exception e) {
			System.out.println("getBoard()�뿉�꽌 �삁�쇅諛쒖깮 : " + e);
			e.printStackTrace();
		}finally{
			resourceClose();
		}
		return bean;
	}
	public int getBoardCount(){
		int count = 0;
		try {
			con = getConnection();
			sql = "select count(*) from board" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getBoardCount()�뿉�꽌 �삁�쇅諛쒖깮 : " + e);
			e.printStackTrace();
		}finally{
			resourceClose();
		}
		return count;
	}
	public List<BoardBean> getBoardList(){
		List<BoardBean> list = new ArrayList<BoardBean>();
		try {
			con = getConnection();
			sql = "select * from board order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BoardBean bean = new BoardBean();
				bean.setId(rs.getString("id"));
				bean.setSubject(rs.getString("subject"));
				bean.setPrice(rs.getString("price"));
				bean.setContent(rs.getString("content"));
				bean.setImg1(rs.getString("img1"));
				bean.setImg2(rs.getString("img2"));
				bean.setImg3(rs.getString("img3"));
				bean.setDate(rs.getString("date"));
				bean.setNum(rs.getInt("num"));
				bean.setPw(rs.getString("pw"));
				bean.setCategory(rs.getString("category"));
				list.add(bean);
			}

		} catch (Exception e) {
			System.out.println("getBoardList()�뿉�꽌 �삁�쇅諛쒖깮 : " + e);
			e.printStackTrace();
		}finally{
			resourceClose();
		}
		return list;
	}
	public int deleteBoard(int num, String passwd){
		int check = 0;
		try {
			con = getConnection();
			sql = "select * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(passwd.equals(rs.getString("pw"))){
					check = 1;
					sql = "delete from board where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			System.out.println("deleteBoard()�뿉�꽌 �삁�쇅諛쒖깮 : " + e);
			e.printStackTrace();
		}finally{
			resourceClose();
		}
		return check;
	}
	public boolean updateBoard(BoardBean bean){
		boolean check = false;
		try {
			con = getConnection();
			sql = "update board set subject = ?, price =?, content =?, date = ?, category = ?, img1 = ?, img2 = ?, img3 = ? where num = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getPrice());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getDate());
			pstmt.setString(5, bean.getCategory());
			pstmt.setString(6, bean.getImg1());
			pstmt.setString(7, bean.getImg2());
			pstmt.setString(8, bean.getImg3());
			pstmt.setInt(9, bean.getNum());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateBoard()에서 오류발생 : " + e);
			e.printStackTrace();
		}finally{
			resourceClose();
			check = true;
		}
		return check;
	}
}
