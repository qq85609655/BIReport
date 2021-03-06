package com.ailk.bi.marketing.action;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ailk.bi.base.common.InitServlet;
import com.ailk.bi.base.struct.UserCtlRegionStruct;
import com.ailk.bi.base.util.StringTool;
import com.ailk.bi.base.util.WebConstKeys;
import com.ailk.bi.base.util.WebKeys;
import com.ailk.bi.common.app.AppException;
import com.ailk.bi.common.app.AppWebUtil;
import com.ailk.bi.marketing.entity.GroupInfo;
import com.ailk.bi.marketing.entity.SellUserInfo;
import com.ailk.bi.marketing.service.IGroupService;
import com.ailk.bi.marketing.service.ISellUserService;
import com.ailk.bi.report.struct.ReportQryStruct;
import com.ailk.bi.report.util.ReportConsts;
import waf.controller.web.action.HTMLActionException;
import waf.controller.web.action.HTMLActionSupport;
/**
 *实现对客户增删改查的控制
 * 【action控制层】活动目标控制层
 * @author  方慧
 * @version  [版本号, 2012-04-10]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */

public class SellUserAction extends HTMLActionSupport {
	private static final long serialVersionUID = 1L;
	@Resource(name = "sellUserService")
	private ISellUserService sellUserService;
	@Resource(name = "groupService")
	private IGroupService groupService;

	public void doTrans(HttpServletRequest request, HttpServletResponse response)
			throws HTMLActionException {
		// 判断用户是否有效登陆
		if (!com.ailk.bi.common.app.WebChecker.isLoginUser(request, response))
			return;
		HttpSession session = request.getSession();
		// 获取页面screen标示
		String optype = request.getParameter("optype");//获得制定的的JSP页面
		String doType = request.getParameter("doType");//获得具体的操作
		String groupId = request.getParameter("groupId");
		String fileUrl=request.getParameter("fileUrl");
		if (optype == null || "".equals(optype)) {
			throw new HTMLActionException(session, HTMLActionException.WARN_PAGE, "未知界面查询操作，请检查！");
		}
		// 查询结构，接受界面条件值
		ReportQryStruct qryStruct = new ReportQryStruct();
		// 判断是否有外部传入条件，p_condition约定名称
		String p_condition = request.getParameter("p_condition");
		if (StringTool.checkEmptyString(p_condition)) {
			p_condition = ReportConsts.NO;
		}
		try {
			if (ReportConsts.YES.equals(p_condition)) {
				qryStruct = (ReportQryStruct) session
						.getAttribute(WebKeys.ATTR_SUBJECT_QUERY_STRUCT);
			} else {
				AppWebUtil.getHtmlObject(request, "qry", qryStruct);
			}
		} catch (AppException ex) {
			throw new HTMLActionException(session, HTMLActionException.WARN_PAGE,
					"提取界面查询信息失败，请注意是否登陆超时！");
		}

		// 加入权限控制条件-用户控制区域
		UserCtlRegionStruct ctlStruct = (UserCtlRegionStruct) session
				.getAttribute(WebConstKeys.ATTR_C_UserCtlStruct);
		if (ctlStruct == null) {
			ctlStruct = new UserCtlRegionStruct();
		}
		/**
		 * 业务开始
		 *@author f00211612
		 * */
		InitServlet.init(super.config, this, "sellUserService");
		InitServlet.init(super.config, this, "groupService");
		InitServlet.init(super.config, this, "activityGroupService");

		if (null != sellUserService) {
			if ("search".equals(doType)) {
				if (!StringTool.checkEmptyString(groupId)) {
					GroupInfo groupinfo = groupService.getById(groupId);
					List<SellUserInfo> list = sellUserService.getAllByGroupId(groupId, 0);
					request.setAttribute("GroupInfo", groupinfo);
					request.setAttribute("SellUserInfoList", list);
				}
			}else if("delect".equals(doType)) {
				String ids = "";
				String[] arr = request.getParameterValues("checkbox");
				if(null!=arr){
					for(int i=0;i<arr.length;i++){
						ids+=arr[i]+",";
					}
				}
				char lastChar =',';
				if(ids.charAt(ids.length()-1)==lastChar)
				{
					ids = ids.substring(0, ids.length()-1);
				}
				sellUserService.delete(ids);
				int count = sellUserService.getCountbyGroupId(groupId);
				//删除后重新刷新
				if (!StringTool.checkEmptyString(groupId)) {
					GroupInfo groupinfo = groupService.getById(groupId);
					groupinfo.setCustomerCount(count);
					groupService.save(groupinfo);
					List<SellUserInfo> list = sellUserService.getAllByGroupId(groupId, 0);
					request.setAttribute("GroupInfo", groupinfo);
					request.setAttribute("SellUserInfoList", list);
				}
			}else if("add".equals(doType)) {
			}else if("fileRead".equals(doType)) {
				if(null!=fileUrl){
					List<String> list = new ArrayList<String>();
					BufferedReader in = null;
				    String   line="";
					try {
						request.setAttribute("fileReadMsg", null);
						int count=0;
						in = new   BufferedReader(new   FileReader( fileUrl));
						while((line   =   in.readLine())!=null){
							line = line.trim();
							if(line.length()==11){
								SellUserInfo uinfo = new  SellUserInfo();
								uinfo.setGroupId(groupId);
								uinfo.setServNumber(line);
								sellUserService.save(uinfo);
								list.add(line);
							}else{
								count++;
							}
						}
						if(count>0){
							request.setAttribute("fileReadMsg", count+"");
						}else{
							request.setAttribute("fileReadMsg", null);
						}

					} catch (FileNotFoundException e) {
						e.printStackTrace();
					}catch (IOException e) {
						e.printStackTrace();
					}
				}

				//添加后重新刷新
				int count = sellUserService.getCountbyGroupId(groupId);
				if (!StringTool.checkEmptyString(groupId)) {
					GroupInfo groupinfo = groupService.getById(groupId);
					groupinfo.setCustomerCount(count);
					groupService.save(groupinfo);
					List<SellUserInfo> list = sellUserService.getAllByGroupId(groupId, 0);
					request.setAttribute("GroupInfo", groupinfo);
					request.setAttribute("SellUserInfoList", list);
				}
			}else if("save".equals(doType)) {
				String phoneNumber =request.getParameter("txt_phoneNumber");
				SellUserInfo newInfo = new SellUserInfo();
				if (!StringTool.checkEmptyString(phoneNumber)) {
					newInfo.setServNumber(phoneNumber);
				}
				if (!StringTool.checkEmptyString(groupId)) {
					newInfo.setGroupId(groupId);
				}
				sellUserService.save(newInfo);
				int count = sellUserService.getCountbyGroupId(newInfo.getGroupId());

				//添加后重新刷新
				if (!StringTool.checkEmptyString(groupId)) {
					GroupInfo groupinfo = groupService.getById(groupId);
					groupinfo.setCustomerCount(count);
					groupService.save(groupinfo);
					List<SellUserInfo> list = sellUserService.getAllByGroupId(groupId, 0);
					request.setAttribute("GroupInfo", groupinfo);
					request.setAttribute("SellUserInfoList", list);
				}
			}
		}
		session.setAttribute(WebKeys.ATTR_SUBJECT_QUERY_STRUCT, qryStruct);
		setNextScreen(request, optype+".screen");
	}
}
