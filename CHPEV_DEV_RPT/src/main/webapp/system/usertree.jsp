<%@page import="com.ailk.bi.SysConsts"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.ailk.bi.base.struct.UserCtlRegionStruct"%>
<%@ page import="com.ailk.bi.base.util.*" %>
<%
if (!com.ailk.bi.common.app.WebChecker.isLoginUser(request,response))
		return;
%>

<%
 //树型类型
String treeType = request.getParameter("treeType");
System.out.println("treeType================="+treeType);

String loginRegion = "";
UserCtlRegionStruct region = (UserCtlRegionStruct)session.getAttribute(WebConstKeys.ATTR_C_UserCtlStruct);
if(SysConsts.RIGHT_LVL_METRO.equals(region.ctl_lvl)) {
	loginRegion=region.ctl_metro_str_add;
}else {
	loginRegion = region.ctl_city_str_add;
}

//区域名称
//String tree_name = LSInfoRegion.getRegionName(loginRegion);
%>
<HTML>
<head>
<title>树形管理</title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
<META HTTP-EQUIV="expires" CONTENT="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xtree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlextras.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xloadtree.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/other/xtree.css" />
<script type="text/javascript">
	webFXTreeConfig.rootIcon		= "../images/common/xmltree/xp/root.gif";
	webFXTreeConfig.openRootIcon	= "../images/common/xmltree/xp/root.gif";
	webFXTreeConfig.lMinusIcon		= "../images/common/xmltree/xp/Lminus.png";
	webFXTreeConfig.lPlusIcon		= "../images/common/xmltree/xp/Lplus.png";
	webFXTreeConfig.tMinusIcon		= "../images/common/xmltree/xp/Tminus.png";
	webFXTreeConfig.tPlusIcon		= "../images/common/xmltree/xp/Tplus.png";
	webFXTreeConfig.iIcon			= "../images/common/xmltree/xp/I.png";
	webFXTreeConfig.lIcon			= "../images/common/xmltree/xp/L.png";
	webFXTreeConfig.tIcon			= "../images/common/xmltree/xp/T.png";

<%

  out.println("webFXTreeConfig.folderIcon		= \"../images/common/xmltree/xp/dept.gif\";");
  out.println("webFXTreeConfig.openFolderIcon		= \"../images/common/xmltree/xp/deptOpen.gif\";");
  out.println("webFXTreeConfig.fileIcon		= \"../images/common/xmltree/xp/deptdef.gif\";");

%>

</script>
</head>
<body>

<TABLE cellpadding="0" WIDTH="90%" >
<TR valign="top">
<TD>
<script>


var tree = new WebFXLoadTree("用户树","createDeptUserXML.rptdo?first=1&region_parent=<%=loginRegion%>");
document.write(tree);


</script>
</TD></TR></TABLE>
<script language=javascript>
function linkUrl(){
//	parent.parent.userDefPage.pageRedirect_region(<%=loginRegion%>, '');
}
</script>

</body>
</html>

