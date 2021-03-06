/*
 *	Sub class that adds a check box in front of the tree item icon
 *
 *	Created by Erik Arvidsson (http://webfx.eae.net/contact.html#erik)
 *
 *	Disclaimer:	This is not any official WebFX component. It was created due to
 *				demand and is just a quick and dirty implementation. If you are
 *				interested in this functionality the contact us
 *				http://webfx.eae.net/contact.html
 *
 *	Notice that you'll need to add a css rule the sets the size of the input box.
 *	Something like this will do fairly good in both Moz and IE
 *
 *	input.tree-check-box {
 *		width:		auto;
 *		margin:		0;
 *		padding:	0;
 *		height:		14px;
 *		vertical-align:	middle;
 *	}
 *
 */

function WebFXCheckBoxTreeItem(sText, sAction, sValue,bChecked, eParent, sIcon, sOpenIcon) {
	this.base = WebFXTreeItem;
	this.base(sText, sAction, sValue, eParent, sIcon, sOpenIcon);
	this._checked = bChecked;
}

WebFXCheckBoxTreeItem.prototype = new WebFXTreeItem;

WebFXCheckBoxTreeItem.prototype.toString = function (nItem, nItemCount) {
	var foo = this.parentNode;
	var indent = '';
	if (nItem + 1 == nItemCount) { this.parentNode._last = true; }
	var i = 0;
	while (foo.parentNode) {
		foo = foo.parentNode;
		indent = "<img id=\"" + this.id + "-indent-" + i + "\" src=\"" + ((foo._last)?webFXTreeConfig.blankIcon:webFXTreeConfig.iIcon) + "\">" + indent;
		i++;
	}
	this._level = i;
	if (this.childNodes.length) { this.folder = 1; }
	else { this.open = false; }
	if ((this.folder) || (webFXTreeHandler.behavior != 'classic')) {
		if (!this.icon) { this.icon = webFXTreeConfig.folderIcon; }
		if (!this.openIcon) { this.openIcon = webFXTreeConfig.openFolderIcon; }
	}
	else if (!this.icon) { this.icon = webFXTreeConfig.fileIcon; }
	var label = this.text.replace(/</g, '&lt;').replace(/>/g, '&gt;');
	var str = "<div id=\"" + this.id + "\" ondblclick=\"webFXTreeHandler.toggle(this);\" class=\"webfx-tree-item\" onkeydown=\"return webFXTreeHandler.keydown(this, event)\">";
	str += indent;
	str += "<img id=\"" + this.id + "-plus\" src=\"" + ((this.folder)?((this.open)?((this.parentNode._last)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.tMinusIcon):((this.parentNode._last)?webFXTreeConfig.lPlusIcon:webFXTreeConfig.tPlusIcon)):((this.parentNode._last)?webFXTreeConfig.lIcon:webFXTreeConfig.tIcon)) + "\" onclick=\"webFXTreeHandler.toggle(this);\">"

	// insert check box
	str += "<input type=\"checkbox\" name=\"tcheck\"" +
		" class=\"tree-check-box\"" +
		(this._checked ? " checked=\"checked\"" : "") +
		" value ="+this.value+
		" onclick=\"webFXTreeHandler.all[this.parentNode.id].setChecked(this.checked)\"" +
		" />";
	// end insert checkbox

	str += "<img id=\"" + this.id + "-icon\" class=\"webfx-tree-icon\" src=\"" + ((webFXTreeHandler.behavior == 'classic' && this.open)?this.openIcon:this.icon) + "\" onclick=\"webFXTreeHandler.select(this);\"><a href=\"" + this.action + "\" id=\"" + this.id + "-anchor\" onfocus=\"webFXTreeHandler.focus(this);\" onblur=\"webFXTreeHandler.blur(this);\">" + label + "</a></div>";
	str += "<div id=\"" + this.id + "-cont\" class=\"webfx-tree-container\" style=\"display: " + ((this.open)?'block':'none') + ";\">";
	for (var i = 0; i < this.childNodes.length; i++) {
		str += this.childNodes[i].toString(i,this.childNodes.length);
	}
	str += "</div>";
	this.plusIcon = ((this.parentNode._last)?webFXTreeConfig.lPlusIcon:webFXTreeConfig.tPlusIcon);
	this.minusIcon = ((this.parentNode._last)?webFXTreeConfig.lMinusIcon:webFXTreeConfig.tMinusIcon);
	return str;
}

WebFXCheckBoxTreeItem.prototype.getChecked = function () {
	var divEl = document.getElementById(this.id);
	var inputEl = divEl.getElementsByTagName("INPUT")[0];
	return this._checked = inputEl.checked;
};

//设置checkbox
WebFXCheckBoxTreeItem.prototype.setChecked = function (bChecked) {
	if (bChecked != this.getChecked()) {
		var divEl = document.getElementById(this.id);
		var inputEl = divEl.getElementsByTagName("INPUT")[0];
		this._checked = inputEl.checked = bChecked;
	}

	if(this._checked){
		this.CheckSonNode();
		this.CheckParent();
	}else{
		this.CheckSonNode();
		this.CheckParent();
	}
};
//
//设置checkbox
WebFXCheckBoxTreeItem.prototype.setParentChecked = function (bChecked) {
	if (bChecked != this.getChecked()) {
		var divEl = document.getElementById(this.id);
		var inputEl = divEl.getElementsByTagName("INPUT")[0];
		this._checked = inputEl.checked = bChecked;
	}

	if(this._checked){
		this.CheckParent();
	}else{
		this.CheckParent();
	}
};
//
WebFXCheckBoxTreeItem.prototype.CheckParent = function () {
	//父亲
	var parent = this.parentNode;
	var bcount=0;
	for(var i=0;i<parent.childNodes.length;i++){
		var divEl = document.getElementById(parent.childNodes[i].id);
		var inputEl = divEl.getElementsByTagName("INPUT")[0];
		if(!inputEl.checked){
                   bcount++;
		}

	}
	//
	if(bcount == parent.childNodes.length){
		if(('系统菜单资源' != parent.text)&&(parent.getChecked())){
			
			parent.setParentChecked(false);
			//parent.CheckParent();
		}
	}else{
		if(('系统菜单资源' != parent.text)&&(!parent.getChecked())){
			parent.setParentChecked(true);
			//parent.CheckParent();
		}
	}


};

//判断
 WebFXCheckBoxTreeItem.prototype.CheckParentNode = function () {
	//父亲
	var parent = this.parentNode;
	var bcount=0;
	var dcount=0;
	for(var i=0;i<parent.childNodes.length;i++){
		var divEl = document.getElementById(parent.childNodes[i].id);
		var inputEl = divEl.getElementsByTagName("INPUT")[0];
		if(inputEl.checked){
			bcount++;
		}
	}
	//
	if(bcount == parent.childNodes.length){
		if(('系统菜单资源' != parent.text)&&(!parent.getChecked())){
			parent.setChecked(true);
		}
	}else if(bcount <=0){
		if(('系统菜单资源' != parent.text)&&(parent.getChecked())){
			parent.setChecked(false);
		}
	}

};
//
WebFXCheckBoxTreeItem.prototype.CheckSonNode = function (){

	//
	if(this.getChecked()){
		for(var i=0;i<this.childNodes.length;i++){
			var divEl = document.getElementById(this.childNodes[i].id);
			var inputEl = divEl.getElementsByTagName("INPUT")[0];
			inputEl.checked = true;
			if(this.childNodes[i].getSonNumber()>0){
				this.childNodes[i].CheckSonNode();
			}
		}
	}else{
		for(var i=0;i<this.childNodes.length;i++){
			var divEl = document.getElementById(this.childNodes[i].id);
			var inputEl = divEl.getElementsByTagName("INPUT")[0];
			inputEl.checked = false;
			if(this.childNodes[i].getSonNumber()>0){
				this.childNodes[i].CheckSonNode();
			}
		}
	}

};
//儿子
WebFXCheckBoxTreeItem.prototype.getSonNumber = function (){
	//
	return this.childNodes.length;
};
//父亲
WebFXCheckBoxTreeItem.prototype.hasParent = function (){
	//
	return (this.parentNode==null);
};



