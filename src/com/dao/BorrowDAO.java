package com.dao;

import com.core.ConnDB;
import com.core.MyDateUtils;

import java.util.*;
import com.actionForm.BorrowForm;
import java.sql.*;
import java.text.SimpleDateFormat;

import com.actionForm.ReaderForm;
import com.actionForm.BookForm;
import java.util.Date;

public class BorrowDAO {
	ConnDB conn = new ConnDB();

	public int insert() {
		String sql = "INSERT INTO t_borrow (bookid) vlaues(1) ";
		int ret = conn.executeUpdate(sql);
		return ret;
	}

	// *****************************图书借阅******************************
	public int insertBorrow(ReaderForm readerForm, BookForm bookForm,
			String operator) {
		// 获取系统日期
		Date dateU = new Date();
		java.sql.Date date = new java.sql.Date(dateU.getTime());
		System.out.println("date:"+date);
		String sql1 = "select t.days from t_bookinfo b left join t_booktype t on b.typeid=t.id where b.id="
				+ bookForm.getId() + "";
		System.out.println(sql1);
		ResultSet rs = conn.executeQuery(sql1);
		int days = 0;
		try {
			if (rs.next()) {
				days = rs.getInt(1);
			}
		} catch (SQLException ex) {
		}
		
		// 计算归还时间
		String endTime=MyDateUtils.getDate_Back(date, days);
		java.sql.Date backTime = java.sql.Date.valueOf(endTime);

		String sql = "Insert into t_borrow (numid,bookid,borrowTime,backTime,operator) values("
				+ readerForm.getNumid()
				+ ","
				+ bookForm.getId()
				+ ",'"
				+ date
				+ "','" + backTime + "','" + operator + "')";
		int falg = conn.executeUpdate(sql);
		System.out.println("添加图书借阅信息的SQL：" + sql);
		conn.close();
		return falg;
	}

	// *************************************图书继借*********************************
	public int renew(int id) {
		String sql0 = "SELECT bookid FROM t_borrow WHERE id=" + id + "";
		ResultSet rs1 = conn.executeQuery(sql0);
		int flag = 0;
		try {
			if (rs1.next()) {
				// 获取系统日期
				Date dateU = new Date();
				java.sql.Date date = new java.sql.Date(dateU.getTime());
				String sql1 = "select t.days from t_bookinfo b left join t_booktype t on b.typeid=t.id where b.id="
						+ rs1.getInt(1) + "";
				ResultSet rs = conn.executeQuery(sql1);
				int days = 0;
				try {
					if (rs.next()) {
						days = rs.getInt(1);
					}
				} catch (SQLException ex) {
				}
				// 计算归还时间
				String endTime=MyDateUtils.getDate_Back(date, days);
				java.sql.Date backTime = java.sql.Date.valueOf(endTime);
				String sql = "UPDATE t_borrow SET backtime='" + backTime
						+ "' where id=" + id + "";
				flag = conn.executeUpdate(sql);
			}
		} catch (Exception ex1) {
		}
		conn.close();
		return flag;
	}

	// *************************************图书归还*********************************
	public int back(int id, String operator) {
		String sql0 = "SELECT numid,bookid FROM t_borrow WHERE id=" + id
				+ "";
		System.out.println("执行归还操作："+sql0);
		ResultSet rs1 = conn.executeQuery(sql0);
		int flag = 0;
		try {
			if (rs1.next()) {
				// 获取系统日期
				Date dateU = new Date();
				java.sql.Date date = new java.sql.Date(dateU.getTime());
				int numid = rs1.getInt(1);
				int bookid = rs1.getInt(2);
				String sql1 = "INSERT INTO t_giveback (numid,bookid,backTime,operator) VALUES("
						+ numid
						+ ","
						+ bookid
						+ ",'"
						+ date
						+ "','"
						+ operator + "')";
				int ret = conn.executeUpdate(sql1);
				if (ret == 1) {
					String sql2 = "UPDATE t_borrow SET ifback=1 where id="
							+ id + "";
					flag = conn.executeUpdate(sql2);
				} else {
					flag = 0;
				}
			}
		} catch (Exception ex1) {
		}
		conn.close();
		return flag;
	}

	// *****************************查询图书借阅信息************************
	public Collection borrowinfo(String str) {
		String sql = "SELECT borr.*,book.bookname,book.author,book.price,book.pub_name,bs.name bookcasename FROM (SELECT * FROM t_borrow WHERE ifback=0) AS borr LEFT JOIN t_bookinfo book ON borr.bookid=book.id JOIN t_bookcase bs ON book.bookcaseid=bs.id JOIN t_reader r ON borr.numid=r.numid WHERE r.numid='"
+ str + "'";
		System.out.println("查询用户图书借阅信息的sql："+sql);
		ResultSet rs = conn.executeQuery(sql);
		Collection coll = new ArrayList();
		BorrowForm form = null;
		try {
			while (rs.next()) {
				form = new BorrowForm();
				form.setId(Integer.valueOf(rs.getInt(1)));
				form.setBorrowTime(rs.getString(4));
				form.setBackTime(rs.getString(5));
				form.setBookName(rs.getString(8));
				form.setAuthor(rs.getString(9));
				form.setPrice(Float.valueOf(rs.getFloat(10)));
				form.setPubName(rs.getString(11));
				form.setBookcaseName(rs.getString(12));
				coll.add(form);
			}
		} catch (SQLException ex) {
			System.out.println("借阅信息：" + ex.getMessage());
		}
		conn.close();
		return coll;
	}

	// *************************到期提醒******************************************
	public Collection bremind() {
		Date dateU = new Date();
		java.sql.Date date = new java.sql.Date(dateU.getTime());
		String sql = "select borr.borrowTime,borr.backTime,book.barcode,book.bookname,r.name readername,r.numid readerbarcode from t_borrow borr join t_bookinfo book on book.id=borr.bookid join t_reader r on r.numid=borr.numid where borr.backTime <='"
				+ date + "'";
		ResultSet rs = conn.executeQuery(sql);
		System.out.println("到时提醒的SQL：" + sql);
		Collection coll = new ArrayList();
		BorrowForm form = null;
		try {
			while (rs.next()) {
				form = new BorrowForm();
				form.setBorrowTime(rs.getString(1));
				form.setBackTime(rs.getString(2));
				form.setBookBarcode(rs.getString(3));
				form.setBookName(rs.getString(4));
				form.setReaderName(rs.getString(5));
				form.setNumId(rs.getString(6));
				coll.add(form);
				System.out.println("图书条形码：" + rs.getString(3));
			}
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}
		conn.close();
		return coll;
	}

	// *************************图书借阅查询******************************************
	public Collection borrowQuery(String strif) {
		String sql = "";
		if (strif != "all" && strif != null && strif != "") {
			sql = "select * from (select borr.borrowTime,borr.backTime,book.barcode,book.bookname,r.name readername,r.numid numid,borr.ifback from t_borrow borr join t_bookinfo book on book.id=borr.bookid join t_reader r on r.numid=borr.numid) as borr where borr."
					+ strif + "";
		} else {
			sql = "select * from (select borr.borrowTime,borr.backTime,book.barcode,book.bookname,r.name readername,r.numid numid,borr.ifback from t_borrow borr join t_bookinfo book on book.id=borr.bookid join t_reader r on r.numid=borr.numid) as borr";
		}
		ResultSet rs = conn.executeQuery(sql);
		System.out.println("图书借阅查询的SQL：" + sql);
		Collection coll = new ArrayList();
		BorrowForm form = null;
		try {
			while (rs.next()) {
				form = new BorrowForm();
				form.setBorrowTime(rs.getString(1));
				form.setBackTime(rs.getString(2));
				form.setBookBarcode(rs.getString(3));
				form.setBookName(rs.getString(4));
				form.setReaderName(rs.getString(5));
				form.setNumId(rs.getString(6));
				form.setIfBack(rs.getInt(7));
				coll.add(form);
			}
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}
		conn.close();
		return coll;
	}

	// *************************图书借阅排行******************************************
	public Collection bookBorrowSort() {
		String sql = "SELECT * FROM (SELECT bookid,COUNT(bookid) AS degree FROM t_borrow GROUP BY bookid) AS borr JOIN (SELECT b.*,c.name AS bookcaseName,t.typename FROM t_bookinfo b LEFT JOIN t_bookcase c ON b.bookcaseid=c.id  JOIN t_booktype t ON b.typeid=t.id WHERE b.del=0) AS book ON borr.bookid=book.id ORDER BY borr.degree DESC LIMIT 10";
		System.out.println("图书借阅排行：" + sql);
		Collection coll = new ArrayList();
		BorrowForm form = null;
		ResultSet rs = conn.executeQuery(sql);

		try {
			while (rs.next()) {
				form = new BorrowForm();
				form.setBookId(rs.getInt(1));
				form.setDegree(rs.getInt(2));
				form.setBookBarcode(rs.getString(3));
				form.setBookName(rs.getString(4));
				form.setAuthor(rs.getString(6));
				form.setPrice(Float.valueOf(rs.getString(9)));
				form.setPubName(rs.getString(15));
				form.setBookcaseName(rs.getString(16));
				form.setBookType(rs.getString(17));
				coll.add(form);
				System.out.print("RS：" + rs.getString(4));
			}
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}
		conn.close();
		return coll;
	}
}
