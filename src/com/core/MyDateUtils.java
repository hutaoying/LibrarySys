package com.core;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class MyDateUtils {
	private static SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	public static String getDate_Back(Date dateU,int days) {
		
		Calendar ca = Calendar.getInstance();
		         ca.add(Calendar.DATE, days);// num为增加的天数，可以改变的
		         dateU = ca.getTime();
		         String enddate = format.format(dateU);
		         System.out.println("增加天数以后的日期：" + enddate);
		         return enddate;
	}

}
