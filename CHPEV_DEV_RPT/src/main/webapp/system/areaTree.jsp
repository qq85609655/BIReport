<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.ailk.bi.base.util.*"%>
<%@ page import="com.ailk.bi.base.table.*"%>
<%@ page import="com.ailk.bi.system.common.*"%>
<%@ page import="com.ailk.bi.system.facade.impl.*"%>


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
	webFXTreeConfig.folderIcon		= "../images/common/xmltree/xp/region.gif";
	webFXTreeConfig.fileIcon		= "../images/common/xmltree/xp/regiondef.gif";
	webFXTreeConfig.openFolderIcon	= "../images/common/xmltree/xp/regionOpen.gif";
	webFXTreeConfig.lMinusIcon		= "../images/common/xmltree/xp/Lminus.png";
	webFXTreeConfig.lPlusIcon		= "../images/common/xmltree/xp/Lplus.png";
	webFXTreeConfig.tMinusIcon		= "../images/common/xmltree/xp/Tminus.png";
	webFXTreeConfig.tPlusIcon		= "../images/common/xmltree/xp/Tplus.png";
	webFXTreeConfig.iIcon			= "../images/common/xmltree/xp/I.png";
	webFXTreeConfig.lIcon			= "../images/common/xmltree/xp/L.png";
	webFXTreeConfig.tIcon			= "../images/common/xmltree/xp/T.png";
	webFXTreeConfig.blankIcon     	= "../images/common/xmltree/xp/blank.png";
</script>
<%
InfoOperTable loginUser = CommonFacade.getLoginUser(session);
String user_id = loginUser.user_id;
String region_parent = null;request.getParameter("region_parent");
if(region_parent == null || "".equals(region_parent)){
	region_parent = "";//loginUser.region_id;
}
String tree_name = LSInfoRegion.getRegionName(region_parent);
if(tree_name==null||"".equals(tree_name)){
	tree_name = "选择区域";
}
%>
</head>
<body>

<TABLE cellpadding="0" WIDTH="100%" HEIGHT="100%">
<TR valign="top">
<TD>
<script>
var tree = new WebFXLoadTree("<%=tree_name%>","createAreaTreeXML.rptdo?region_parent=<%=region_parent%>&user_id=<%=user_id%>");
document.write(tree);
</script>
</TD>
</TR>
</TABLE>
<script language=javascript>
function linkUrl(){
	parent.getArea("<%=tree_name%>", "<%=region_parent%>");
}
</script>

</body>
</html>

