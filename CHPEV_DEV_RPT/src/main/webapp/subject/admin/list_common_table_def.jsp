<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib uri="/WEB-INF/tld/BIBM.tld" prefix="BIBM" %>
<%@taglib uri="/WEB-INF/tld/TAG.tld" prefix="Tag" %>
<%@page import="com.ailk.bi.base.util.WebKeys"%>
<%@page import="com.ailk.bi.report.domain.RptResourceTable"%>
<%@page import="com.ailk.bi.report.struct.ReportQryStruct"%>
<%@page import="com.ailk.bi.subject.admin.SubjectCommonConst"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.ailk.bi.subject.admin.entity.UiSubjectCommonTableDef"%>

<%
if( !com.ailk.bi.common.app.WebChecker.isLoginUser(request, response))
  return;
%>
<%
//报表列表
List listInfo = (ArrayList)request.getAttribute(SubjectCommonConst.CONST_SUBJECT_TABLE_DEF);
String table_id = (String)request.getAttribute("table_id");
String table_name = (String)request.getAttribute("table_name");
String rpt_cycle = (String)request.getAttribute("rpt_cycle");
%>

<html>
<script language=javascript>
function _editRptHead(rpt_id){
  var optstr = "height=600,width=800,left=0,top=0,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no";
  var strUrl = "SubjectCommonTblDef.rptdo?opt_type=edthead&table_id=" + rpt_id;
  newsWin = window.open(strUrl,"editRptHead",optstr);
  if(newsWin!=null){
    newsWin.focus();
  }
}
function _drillTableDefSet(rpt_id){
  var optstr = "height=600,width=800,left=0,top=0,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no";
  var strUrl = "SubjectCommonTblDef.rptdo?opt_type=listDrillset&table_id=" + rpt_id;
  document.frmEdit.action = strUrl;
  document.frmEdit.submit();
 
}

function listTblColDef(rpt_id){
  var optstr = "height=600,width=800,left=0,top=0,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no";
  var strUrl = "SubjectCommonTblDef.rptdo?opt_type=listTblColDef&table_id=" + rpt_id;
  document.frmEdit.action = strUrl;
  document.frmEdit.submit();
 
}
function listConditionInfo(rpt_id){
  var optstr = "height=600,width=800,left=0,top=0,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no";
  var strUrl = "SubjectCommonTblDef.rptdo?opt_type=listTblCondition&table_id=" + rpt_id;
  document.frmEdit.action = strUrl;
  document.frmEdit.submit();
 
}


function _editRptTableDef(rpt_id){
  var optstr = "height=600,width=800,left=0,top=0,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no";
  var strUrl = "SubjectCommonTblDef.rptdo?opt_type=edtTblDef&table_id=" + rpt_id;
  newsWin = window.open(strUrl,"editRptHead",optstr);
  if(newsWin!=null){
    newsWin.focus();
  }
}

function addNewInfo(rpt_id){
  var optstr = "height=600,width=800,left=0,top=0,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=no";
  var strUrl = "SubjectCommonTblDef.rptdo?opt_type=addTblDef&table_id=" + rpt_id;
  newsWin = window.open(strUrl,"editRptHead",optstr);
  if(newsWin!=null){
    newsWin.focus();
  }
}

function fnSubmit(){
  document.frmEdit.submit();
}
function addNew(){
  document.frmEdit.action = "SubjectCommonTblDef.rptdo?opType=step1&opSubmit=addnew";
  document.frmEdit.submit();
}
</script>

<head>
<SCRIPT language=javascript src="<%=request.getContextPath()%>/js/tab_js.js"></SCRIPT>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/other/css.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/other/tab_css.css" type="text/css">
<title>报表列表</title>
<BIBM:SelfRefreshTag pageNames="frmEdit.qry" attrNames="<%=WebKeys.ATTR_REPORT_QRYSTRUCT%>" warn="1"/>
</head>
<body class="main-body" onLoad="selfDisp();">
<form NAME="frmEdit" ID="frmEdit" ACTION="SubjectCommonTblDef.rptdo?opt_type=list" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="1" background="../images/black-dot.gif"></td>
	</tr>
	<tr>
		<td height="2"></td>
	</tr>
	<!--条件区展示 start-->
  <tr>
    <td>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="squareB" >
      <tr> 
        <td><img src="../images/square_corner_1.gif" width="5" height="5"></td>
        <td background="../images/square_line_1.gif"></td>
        <td><img src="../images/square_corner_2.gif" width="5" height="5"></td>
      </tr>
      <tr> 
        <td background="../images/square_line_2.gif"></td>
        <td width="100%" height="100%" valign="top">
        <table width="100%" border="0">
          <tr>
            <td width="5%" nowrap>统计周期：</td>
            <td nowrap><BIBM:TagSelectList listID="S3001" allFlag="" listName="rpt_cycle" /></td>		
			<td width="5%" nowrap>报表编码：</td>
			<td nowrap><input type="text" size="20" name="table_id" value="<%=table_id%>"></td>
			<td width="5%" nowrap>报表名称：</td>
			<td nowrap><input type="text" size="20" name="table_name" value="<%=table_name%>"></td>
            
            <td>
             <input type="button" name="search" class="button" onMouseOver="switchClass(this)" onMouseOut="switchClass(this)" value="查询" onclick="javascript:fnSubmit();"> <input type="button" name="addnew" class="button" onMouseOver="switchClass(this)" onMouseOut="switchClass(this)" value="新增" onclick="javascript:addNewInfo('');"> 
            </td>
          </tr>
				  
        </table>
        </td>
        <td background="../images/square_line_3.gif"></td>
      </tr>
      <tr> 
        <td height="6"><img src="../images/square_corner_3.gif" width="5" height="5"></td>
        <td background="../images/square_line_4.gif"></td>
        <td><img src="../images/square_corner_4.gif" width="5" height="5"></td>
      </tr>
    </table>
    </td>
  </tr>
  <!--条件区展示 end-->
  <tr>
    <td height="5"></td>
  </tr>
  <!--报表显示 start-->
  <tr>
  <td class="tab-side2">
<TABLE width="100%" border="0" cellpadding="0" cellspacing="1" class="table-bg">
  <tr align="center">
    <td class="tab-title" width="15%">统计周期</td>
    <td class="tab-title"  width="15%">报表编码</td>
    <td class="tab-title" width="20%">报表名称</td>
    <td class="tab-title">操作</td>
  </tr>
  <%if(listInfo==null||listInfo.size()==0){ %>
  <tr class="table-white-bg">
    <td colspan="7" nowrap align="center">该条件下没有符合要求的数据</td>
  </tr>
  <%}else{ %>
  <%for(int i=0;i<listInfo.size();i++){ 
    UiSubjectCommonTableDef obj = (UiSubjectCommonTableDef)listInfo.get(i);
	  String rptCycleType = "";
	  if (Integer.parseInt(obj.getTimeLevel())==4){
		rptCycleType = "月报";
	  }else if (Integer.parseInt(obj.getTimeLevel())==6){
		rptCycleType = "日报";
	  }
  %>

  <tr class="table-white-bg">
    <td nowrap><%=rptCycleType%></td>
	<td nowrap><%=obj.getTableId()%></td>
	<td nowrap><%=obj.getTableName()%></td>
	<td nowrap><a href="javascript:;" onclick="javascript:_editRptTableDef('<%=obj.getTableId()%>');">修改</a>&nbsp;&nbsp;<a href="javascript:;" onclick="javascript:listTblColDef('<%=obj.getTableId()%>');">指标显示</a>&nbsp;&nbsp;<a href="javascript:;" onclick="javascript:_editRptHead('<%=obj.getTableId()%>');">复杂表头</a>&nbsp;&nbsp;
		<a href="javascript:;" onclick="javascript:listConditionInfo('<%=obj.getTableId()%>');">条件定制</a>&nbsp;&nbsp;
		<a href="javascript:;" onclick="javascript:_drillTableDefSet('<%=obj.getTableId()%>');">钻取设置</a>&nbsp;&nbsp;
		<a href="javascript:;" onClick='window.open("EditorView.screen?id=<%=obj.getTableId()%>&date=0", "", "left=100,top=100,width=600,height=450")'>指标说明</a>&nbsp;&nbsp;</td>
  </tr>
  <%} %>
  <%} %>
</TABLE>
    </td>
  </tr>
  <!--报表显示 end-->
</table>
</form>
<span style="display:none" id="report_msu_memo"></span>
</body>
</html>