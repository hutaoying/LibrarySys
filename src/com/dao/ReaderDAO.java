package com.dao;

import com.core.ChStr;
import com.core.ConnDB;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.*;
import java.sql.Date;

import com.actionForm.ManagerForm;
import com.actionForm.ReaderForm;

public class ReaderDAO {
	//SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
    private ConnDB conn=new ConnDB();
//查询数据
public ArrayList<ReaderForm> query(String strif){
    ReaderForm readerForm=null;
    ArrayList<ReaderForm> readerColl=new ArrayList<ReaderForm>();
    String sql="";
        if(strif!="all" && strif!=null && strif!=""){
        sql="select r.*,t.name as typename,t.number from t_reader r left join t_readerType t on r.typeid=t.id where "+strif+"";
    }else{
        sql="select r.*,t.name as typename,t.number from t_reader r left join t_readerType t on r.typeid=t.id";
    }
    ResultSet rs=conn.executeQuery(sql);
    
    try {
        while (rs.next()) {
            readerForm=new ReaderForm();
            System.out.println(rs.getString(1)+":"+rs.getString(2)+":"+rs.getDate(12));
            readerForm.setId(Integer.valueOf(rs.getString(1)));
            readerForm.setName(rs.getString(2));
            readerForm.setPassword(rs.getString(3));
            readerForm.setSex(rs.getString(4));
            readerForm.setNumid(rs.getString(5));
            readerForm.setVocation(rs.getString(6));
            readerForm.setBirthday(rs.getString(7));
            readerForm.setPaperType(rs.getString(8));
            readerForm.setPaperNO(rs.getString(9));
            readerForm.setTel(rs.getString(10));
            readerForm.setEmail(rs.getString(11));
            readerForm.setCreateDate(rs.getDate(12));
            readerForm.setOperator(rs.getString(13));
            readerForm.setRemark(rs.getString(14));
            readerForm.setTypeid(rs.getInt(15));
            readerForm.setTypename(rs.getString(16));
            readerForm.setNumber(rs.getInt(17));
            readerColl.add(readerForm);
            System.out.println(rs.getString(1)+":"+rs.getString(2));
        }
    } catch (SQLException ex) {
    	ex.printStackTrace();
    } 
    conn.close();
    return readerColl;
}


	//读者身份认证

public ReaderForm checkReader(ReaderForm readerForm) {
	ReaderForm readerForm1=null;
    int flag = 0;
    ChStr chStr=new ChStr();
    String sql = "SELECT id,name,password,numid FROM t_reader where name='" +
    		 chStr.filterStr(readerForm.getName()) + "'and password='"+chStr.filterStr(readerForm.getPassword())+"'";
    System.out.println(sql);
    ResultSet rs = conn.executeQuery(sql);
    System.out.println(rs+"--rs");
    try {
        while(rs.next()) {
        	readerForm1=new ReaderForm();
        	readerForm1.setId(rs.getInt(1));
        	readerForm1.setName(rs.getString(2));
        	readerForm1.setPassword(rs.getString(3));
        	readerForm1.setNumid(rs.getString(4));
            //String password = chStr.filterStr(readerForm.getPassword());		//获取输入的密码并过滤输入字符串中的危险字符
           // if (password.equals(rs.getString(3))) {
               // flag = 1;
        	System.out.println(readerForm+"------------");
  
    }
        }catch (SQLException ex) {
    	ex.printStackTrace();
    }
    	conn.close();
    
    //return flag;
    return readerForm1;
}
//用于修改的查询
public ReaderForm queryM(ReaderForm readerForm){
    ReaderForm readerForm1=null;
      
    String sql="";
    if(readerForm.getId()!=null){
            sql="select r.*,t.name as typename,t.number from t_reader r left join t_readerType t on r.typeid=t.id where r.id="+readerForm.getId()+"";
    }else if(readerForm.getNumid()!=null){
            sql="select r.*,t.name as typename,t.number from t_reader r left join t_readerType t on r.typeid=t.id where r.numid="+readerForm.getNumid()+"";
        }
    System.out.println("修改读者信息时的查询SQL："+sql);
    ResultSet rs=conn.executeQuery(sql);
    try {
        while (rs.next()) {
        	 readerForm1=new ReaderForm();
        	 readerForm1.setId(rs.getInt(1));
             readerForm1.setName(rs.getString(2));
             readerForm1.setPassword(rs.getString(3));
             readerForm1.setSex(rs.getString(4));
             readerForm1.setNumid(rs.getString(5));
             readerForm1.setVocation(rs.getString(6));
             readerForm1.setBirthday(rs.getString(7));
             readerForm1.setPaperType(rs.getString(8));
             readerForm1.setPaperNO(rs.getString(9));
             readerForm1.setTel(rs.getString(10));
             readerForm1.setEmail(rs.getString(11));
             readerForm1.setCreateDate(rs.getDate(12));
             readerForm1.setOperator(rs.getString(13));
             readerForm1.setRemark(rs.getString(14));
             readerForm1.setTypeid(rs.getInt(15));
             readerForm1.setTypename(rs.getString(16));
             readerForm1.setNumber(rs.getInt(17));
            System.out.println(rs.getString(2));
        }
    } catch (SQLException ex) {
    	ex.printStackTrace();
    }
    conn.close();
    return readerForm1;
}
//根据name查询是否存在该读者

public boolean query_p(String user_name) {
	
  String sql = "select * from t_reader where name='"+user_name+"'";
  ResultSet rs = conn.executeQuery(sql);
  try {
      if(rs!=null){
      	
      	return true;
      }
  }finally{
  	conn.close();
  }
  return false;
}

//更改口令时应用的查询方法
public ReaderForm query_pwd(ReaderForm readerForm) {
	ReaderForm readerForm1 = null;
    String sql = "SELECT id,name,password FROM t_reader WHERE name='" +readerForm.getName() + "'";
    System.out.println(sql);
    ResultSet rs = conn.executeQuery(sql);
    try {
        while (rs.next()) {
        	readerForm1 = new ReaderForm();
        	readerForm1.setId(rs.getInt(1));
        	readerForm1.setName(rs.getString(2));
        	readerForm1.setPassword(rs.getString(3));
        }
    } catch (SQLException ex) {
    	ex.printStackTrace();
    }finally{
    	conn.close();
    }
    return readerForm1;
}
//添加数据
public int insert(ReaderForm readerForm){
String sql1="SELECT * FROM t_reader WHERE numid='"+readerForm.getNumid()+"'";
ResultSet rs = conn.executeQuery(sql1);
String sql = "";
int falg = 0;
try {
    if (rs.next()) {
        falg = 2;
    } else {
        sql ="Insert into t_reader (name,sex,numid,vocation,birthday,paperType,paperNO,tel,email,createDate,operator,remark,typeid) values('"+readerForm.getName()+"','"+readerForm.getSex()+"','"+readerForm.getNumid()+"','"+readerForm.getVocation()+"','"+readerForm.getBirthday()+"','"+readerForm.getPaperType()+"','"+readerForm.getPaperNO()+"','"+readerForm.getTel()+"','"+readerForm.getEmail()+"','"+readerForm.getCreateDate()+"','"+readerForm.getOperator()+"','"+readerForm.getRemark()+"',"+readerForm.getTypeid()+")";
        falg = conn.executeUpdate(sql);
        System.out.println("添加读者信息的SQL：" + sql);
        conn.close();
    }
} catch (SQLException ex) {
    falg = 0;
}
System.out.println("falg:"+falg);
return falg;
}

//修改密码
public int updatePwd(ReaderForm readerForm){
 String sql="UPDATE t_reader SET password='"+readerForm.getPassword()+"' where name='"+readerForm.getName()+"'";
 int ret=conn.executeUpdate(sql);
 System.out.println("修改管理员密码时的SQL："+sql);
 conn.close();
 return ret;
}

//修改数据
public int update(ReaderForm readerForm){
String sql="Update t_reader set sex='"+readerForm.getSex()+"',numid='"+readerForm.getNumid()+"',vocation='"+readerForm.getVocation()+"',birthday='"+readerForm.getBirthday()+"',paperType='"+readerForm.getPaperType()+"',paperNO='"+readerForm.getPaperNO()+"',tel='"+readerForm.getTel()+"',email='"+readerForm.getEmail()+"',remark='"+readerForm.getRemark()+"',typeid="+readerForm.getTypeid()+" where id="+readerForm.getId()+"";
int falg=conn.executeUpdate(sql);
System.out.println("修改数据时的SQL："+sql);
conn.close();
return falg;
}
//删除数据
public int delete(ReaderForm readerForm){
String sql="Delete from t_reader where id="+readerForm.getId()+"";
int falg=conn.executeUpdate(sql);
System.out.println("删除时的SQL："+sql);
return falg;
}
}
