package com.dao;

import com.core.ConnDB;
import java.sql.*;
import java.util.*;
import com.actionForm.BookForm;

public class BookDAO {
	private ConnDB conn = new ConnDB();

	// 查询数据
	public Collection query(String strif) {
		BookForm bookForm = null;
		Collection bookColl = new ArrayList();
		String sql = "";
		if (strif != "all" && strif != null && strif != "") {
			sql = "select * from (select b.*,c.name as bookcaseName,t.typename from t_bookinfo b left join t_bookcase c on b.bookcaseid=c.id join t_booktype t on b.typeid=t.id where b.del=0)  as book where book."
					+ strif + "'";
		} else {
			sql = "select b.*,c.name as bookcaseName,t.typename from t_bookinfo b left join t_bookcase c on b.bookcaseid=c.id join t_booktype t on b.typeid=t.id where b.del=0 and b.id<50";
		}
		System.out.println("图书查询时的SQL：" + sql);
		ResultSet rs = conn.executeQuery(sql);
		try {
			while (rs.next()) {
				bookForm = new BookForm();
				bookForm.setBarcode(rs.getString(1));
				bookForm.setBookName(rs.getString(2));
				bookForm.setTypeId(rs.getInt(3));
				bookForm.setAuthor(rs.getString(4));
				bookForm.setTranslator(rs.getString(5));
				bookForm.setIsbn(rs.getString(6));
				bookForm.setPrice(Float.valueOf(rs.getString(7))); // 此处必须进行类型转换
				bookForm.setBookcaseid(rs.getInt(8));
				bookForm.setInTime(rs.getString(9));
				bookForm.setOperator(rs.getString(10));
				bookForm.setDel(rs.getInt(11));
				bookForm.setId(rs.getInt(12));
				bookForm.setPublishing(rs.getString(13));
				bookForm.setBookcaseName(rs.getString(14));
				bookForm.setTypeName(rs.getString(15));
				bookColl.add(bookForm);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		conn.close();
		return bookColl;
	}

	// 用于修改的查询
	public BookForm queryM(BookForm bookForm1) {
		BookForm bookForm = null;
		String sql = "select b.*,c.name as bookcaseName,t.typename from t_bookinfo b left join t_bookcase c on b.bookcaseid=c.id join t_booktype t on b.typeid=t.id where b.id="
				+ bookForm1.getId() + "";
		System.out.println("修改时的SQL：" + sql);
		ResultSet rs = conn.executeQuery(sql);
		try {
			while (rs.next()) {
				bookForm = new BookForm();
				bookForm.setBarcode(rs.getString(1));
				bookForm.setBookName(rs.getString(2));
				bookForm.setTypeId(rs.getInt(3));
				bookForm.setAuthor(rs.getString(4));
				bookForm.setTranslator(rs.getString(5));
				bookForm.setIsbn(rs.getString(6));
				bookForm.setPrice(Float.valueOf(rs.getString(7))); // 此处必须进行类型转换
				bookForm.setBookcaseid(rs.getInt(8));
				bookForm.setInTime(rs.getString(9));
				bookForm.setOperator(rs.getString(10));
				bookForm.setDel(rs.getInt(11));
				bookForm.setId(rs.getInt(12));
				bookForm.setPublishing(rs.getString(13));
				bookForm.setBookcaseName(rs.getString(14));
				bookForm.setTypeName(rs.getString(15));
			}
		} catch (SQLException ex) {
		}
		conn.close();
		return bookForm;
	}

	// 用于借阅的查询
	public BookForm queryB(String f, String key) {
		BookForm bookForm = null;
		String sql = "select b.*,c.name as bookcaseName,t.typename from t_bookinfo b left join t_bookcase c on b.bookcaseid=c.id join t_booktype t on b.typeid=t.id where b.del=0 and b."
				+ f + "='" + key + "'";
		System.out.println("查询借阅信息时的SQL：" + sql);
		ResultSet rs = conn.executeQuery(sql);
		try {
			if (rs.next()) {
				bookForm = new BookForm();
				bookForm.setBarcode(rs.getString(1));
				bookForm.setBookName(rs.getString(2));
				bookForm.setTypeId(rs.getInt(3));
				bookForm.setAuthor(rs.getString(4));
				bookForm.setTranslator(rs.getString(5));
				bookForm.setIsbn(rs.getString(6));
				bookForm.setPrice(Float.valueOf(rs.getString(7))); // 此处必须进行类型转换
				bookForm.setBookcaseid(rs.getInt(8));
				bookForm.setInTime(rs.getString(9));
				bookForm.setOperator(rs.getString(10));
				bookForm.setDel(rs.getInt(11));
				bookForm.setId(rs.getInt(12));
				bookForm.setPublishing(rs.getString(13));
				bookForm.setBookcaseName(rs.getString(14));
				bookForm.setTypeName(rs.getString(15));
			}
		} catch (SQLException ex) {
		}
		conn.close();
		return bookForm;
	}

	// 添加数据
	public int insert(BookForm bookForm) {
		String sql1 = "SELECT * FROM t_bookinfo WHERE barcode='"
				+ bookForm.getBarcode() + "'";
		System.out.println(sql1+":::");
		ResultSet rs = conn.executeQuery(sql1);
		String sql = "";
		int falg = 0;
		try {
			if (rs.next()) {
				falg = 2;
			} else {
				sql = "Insert into t_bookinfo (barcode,bookname,typeid,author,translator,price,bookcaseid,inTime,operator,pub_name) values('"
						+ bookForm.getBarcode()
						+ "','"
						+ bookForm.getBookName()
						+ "',"
						+ bookForm.getTypeId()
						+ ",'"
						+ bookForm.getAuthor()
						+ "','"
						+ bookForm.getTranslator()
					
						+ "',"
						+ bookForm.getPrice()
						+ ","
						+ bookForm.getBookcaseid()
						+ ",'"
						+ bookForm.getInTime()
						+ "','"
						+ bookForm.getOperator()
						+ "','"
						+ bookForm.getPublishing()
						+ "')";
				falg = conn.executeUpdate(sql);
				System.out.println("添加图书的SQL：" + sql);
				conn.close();
			}
		} catch (SQLException ex) {
			falg = 0;
		}
		System.out.println("falg:" + falg);
		return falg;
	}

	// 修改数据
	public int update(BookForm bookForm) {
		String sql = "Update t_bookinfo set typeid=" + bookForm.getTypeId()
				+ ",author='" + bookForm.getAuthor() + "',translator='"
				+ bookForm.getTranslator()+"',pub_name='"
				+bookForm.getPublishing()
				+ "',price=" + bookForm.getPrice() 
				+ ",bookcaseid=" + bookForm.getBookcaseid()
				+ " where id=" + bookForm.getId() + "";
		int falg = conn.executeUpdate(sql);
		System.out.println("修改数据时的SQL：" + sql);
		conn.close();
		return falg;
	}

	// 删除数据
	public int delete(BookForm bookForm) {
		String sql = "UPDATE t_bookinfo SET del=1 where id="
				+ bookForm.getId() + "";
		int falg = conn.executeUpdate(sql);
		System.out.println("删除时的SQL：" + sql);
		return falg;
	}

}
