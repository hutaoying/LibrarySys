package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.actionForm.ManagerForm;
import com.actionForm.ReaderForm;
import org.apache.struts.action.*;

import com.dao.ReaderDAO;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

public class Reader extends Action {
    private ReaderDAO readerDAO = null;
    public Reader() {
        this.readerDAO = new ReaderDAO();
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {
        String action =request.getParameter("action");
        System.out.println("\nreader*********************action="+action);
        if(action==null||"".equals(action)){
            request.setAttribute("error","���Ĳ�������");
            return mapping.findForward("error");
        }else if("login_reader".equals(action)){
        	return readerlogin(mapping,form,request,response);
        }
        else if("readerAdd".equals(action)){
            return readerAdd(mapping,form,request,response);
        }else if("readerQuery".equals(action)){
            return readerQuery(mapping,form,request,response);
        }else if("readerModifyQuery".equals(action)){
            return readerModifyQuery(mapping,form,request,response);
        }else if("readerModify".equals(action)){
            return readerModify(mapping,form,request,response);
        }else if("readerDel".equals(action)){
            return readerDel(mapping,form,request,response);
        }else if("readerDetail".equals(action)){
            return readerDetail(mapping,form,request,response);
        }else if("querypwd".equals(action)){
        	return queryQwd(mapping,form,request,response);
        }else if ("modifypwd".equals(action)) {
			return modifypwd(mapping, form, request, response);
		}
        request.setAttribute("error","����ʧ�ܣ�");
        return mapping.findForward("error");
    }
    //�޸��û�����
    private ActionForward modifypwd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
    	ReaderForm readerForm = (ReaderForm) form;
    	readerForm.setName(readerForm.getName());
    	readerForm.setPassword(readerForm.getPassword());
		int ret = readerDAO.updatePwd(readerForm);
		if (ret == 0) {
			request.setAttribute("error", "���Ŀ���ʧ�ܣ�");
			return mapping.findForward("error");
		} else {
			return mapping.findForward("pwdModify");
		}
	}

	//�޸�����ʱ��ѯ
        private ActionForward queryQwd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
        	
        	ReaderForm readerForm = (ReaderForm) form;
    		HttpSession session = request.getSession();
    		String user_name = (String) session.getAttribute("user");
    		readerForm.setName(user_name);
    		System.out.print("��ѯ����user:" + user_name);
    		request.setAttribute("pwdQueryif", readerDAO.query_pwd(readerForm));
    		return mapping.findForward("pwdQueryModify");
    		
	}

	// ���������֤
    private ActionForward readerlogin(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
    	ReaderForm readerForm=(ReaderForm) form;
    	readerForm.setName(readerForm.getName());
    	readerForm.setPassword(readerForm.getPassword());
    	readerForm=readerDAO.checkReader(readerForm);
    	//int ret=readerDAO.checkReader(readerForm);
    	if (readerForm!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", readerForm.getName());
			session.setAttribute("user_id",readerForm.getId());
			return mapping.findForward("readerLoginok");
		} else {
			request.setAttribute("error", "��������û��˺Ż��������");
			return mapping.findForward("error");
		}
   
  
	}

	/***********************��Ӷ�����Ϣ**************************/
    private ActionForward readerAdd(ActionMapping mapping, ActionForm form,
                           HttpServletRequest request,
                           HttpServletResponse response){
           ReaderForm readerForm = (ReaderForm) form;
           readerForm.setName(readerForm.getName());
           readerForm.setSex(readerForm.getSex());
           readerForm.setNumid(readerForm.getNumid());
           readerForm.setVocation(readerForm.getVocation());
           readerForm.setBirthday(readerForm.getBirthday());
           readerForm.setPaperType(readerForm.getPaperType());
           readerForm.setPaperNO(readerForm.getPaperNO());
           readerForm.setTel(readerForm.getTel());
           readerForm.setEmail(readerForm.getEmail());
           //��ȡϵͳ����
           Date date1=new Date();
           java.sql.Date date=new java.sql.Date(date1.getTime());
           System.out.println(date);
           readerForm.setCreateDate(date);
           readerForm.setOperator(readerForm.getOperator());
           readerForm.setRemark(readerForm.getRemark());
           readerForm.setTypeid(readerForm.getTypeid());
           int a=readerDAO.insert(readerForm);
           if(a==0){
               request.setAttribute("error","������Ϣ���ʧ�ܣ�");
               return mapping.findForward("error");
         }else if(a==2){
             request.setAttribute("error","�ö�����Ϣ�Ѿ���ӣ�");
             return mapping.findForward("error");
         }else{
             return mapping.findForward("readerAdd");
        }
       }
       /***********************��ѯȫ��������Ϣ**************************/
       private ActionForward readerQuery(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response){
       String str=null;
       request.setAttribute("reader",readerDAO.query(str));
       ArrayList coll=(ArrayList) request.getAttribute("reader");
       System.out.println(coll+"================");
       return mapping.findForward("readerQuery");
       }
        /***********************��ѯ�޸Ķ�����Ϣ**************************/
        private ActionForward readerModifyQuery(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response){
            ReaderForm readerForm=(ReaderForm)form;
            System.out.println("��ѯ�޸Ķ�����Ϣ��"+request.getParameter("ID"));
            readerForm.setId(Integer.valueOf(request.getParameter("ID")));
            request.setAttribute("readerQueryif",readerDAO.queryM(readerForm));
            return mapping.findForward("readerQueryModify");
        }
        /***********************��ѯ������ϸ��Ϣ**************************/
        private ActionForward readerDetail(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response){
            ReaderForm readerForm=(ReaderForm)form;
            String d=request.getParameter("ID");
            
            readerForm.setId(Integer.valueOf(request.getParameter("ID")));
            request.setAttribute("readerDetail",readerDAO.queryM(readerForm));
            return mapping.findForward("readerDeatil");
        }
        /***********************�޸Ķ�����Ϣ**************************/
        private ActionForward readerModify(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response){
            ReaderForm readerForm=(ReaderForm)form;
            readerForm.setName(readerForm.getName());
            readerForm.setSex(readerForm.getSex());
            readerForm.setNumid(readerForm.getNumid());
            readerForm.setVocation(readerForm.getVocation());
            readerForm.setBirthday(readerForm.getBirthday());
            readerForm.setPaperType(readerForm.getPaperType());
            readerForm.setPaperNO(readerForm.getPaperNO());
            readerForm.setTel(readerForm.getTel());
            readerForm.setEmail(readerForm.getEmail());
            readerForm.setOperator(readerForm.getOperator());
            readerForm.setRemark(readerForm.getRemark());
            readerForm.setTypeid(readerForm.getTypeid());
            int ret=readerDAO.update(readerForm);
            if(ret==0){
                request.setAttribute("error","�޸Ķ�����Ϣʧ�ܣ�");
                return mapping.findForward("error");
            }else{
                return mapping.findForward("readerModify");
            }
        }
        /***********************ɾ��������Ϣ**************************/
        private ActionForward readerDel(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request,
                              HttpServletResponse response){
            ReaderForm readerForm=(ReaderForm)form;
            readerForm.setId(Integer.valueOf(request.getParameter("ID")));
            int ret=readerDAO.delete(readerForm);
            if(ret==0){
                request.setAttribute("error","ɾ��������Ϣʧ�ܣ�");
                return mapping.findForward("error");
            }else{
                return mapping.findForward("readerDel");
            }
        }
}
