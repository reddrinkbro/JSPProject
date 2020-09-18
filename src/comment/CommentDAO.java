package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {
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
	public void insertComment(CommentBean bean){
		int num = 0;
		try {
			con = getConnection();
			sql = "select max(num) from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) +1;
			}else{
				num = 1;
			}
			sql = "insert into comment(id, comment, re_ref,re_lev,re_seq,num) values (?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getComment());
			pstmt.setInt(3, num);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, 0);
			pstmt.setInt(6, bean.getNum());
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("insertComment()�뿉�꽌 �삁�쇅諛쒖깮 : "+ e);
		}finally {
			resourceClose();
		}
	}
	public List<CommentBean> getComment(int num){
		List<CommentBean> list = new ArrayList<CommentBean>();
		try {
			con = getConnection();
			sql = "select * from comment where num = ? order by re_ref asc, re_seq asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				CommentBean bean = new CommentBean();
				bean.setId(rs.getString("id"));
				bean.setNum(rs.getInt("num"));
				bean.setComment(rs.getString("comment"));
				bean.setRe_ref(rs.getInt("re_ref"));
				bean.setRe_lev(rs.getInt("re_lev"));
				bean.setRe_seq(rs.getInt("re_seq"));
				list.add(bean);
			}
		} catch (Exception e) {
			System.out.println("getComment()�뿉�꽌 �삁�쇅諛쒖깮 : "+ e);
		}finally {
			resourceClose();
		}
		return list;
	}
	public boolean InsertRecomment(CommentBean bean){
		boolean check = false;
		try{
			con = getConnection();
			
			// re_seq �떟湲� �닚�꽌 �옱諛곗튂
			// 議곌굔 : 遺�紐④� 洹몃９踰덊샇�� 媛숈� 洹몃９�씠硫댁꽌.. 
			// 遺�紐④��쓽 seq媛믩낫�떎 �겙 湲��뱾��? seq媛믪쓣 1利앷� �떆�궓�떎.
			sql = "update comment set re_seq = re_seq+1 where re_ref = ? and re_seq > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getRe_ref()); //遺�紐④��쓽 洹몃９踰덊샇 �궗�슜
			pstmt.setInt(2, bean.getRe_seq()); // 遺�紐④��쓽 �닚�꽌
			pstmt.executeUpdate();
			
			// �떟蹂�湲� �젙蹂� DB�뿉 異붽�
			sql = "insert into comment(id, comment, re_ref,re_lev,re_seq,num) values (?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getComment());
			pstmt.setInt(3, bean.getRe_ref()); 
			pstmt.setInt(4, bean.getRe_lev()+1);
			pstmt.setInt(5, bean.getRe_seq()+1); 
			pstmt.setInt(6, bean.getNum()); 
			
			//�떟湲� insert
			pstmt.executeUpdate();
		}catch(Exception err){
			System.out.println("InsertRecomment()�뿉�꽌 �뿉�윭: "+ err);
		}finally {
			// �옄�썝�빐�젣
			resourceClose();
			check = true;
		}
		return check;
	}
}
