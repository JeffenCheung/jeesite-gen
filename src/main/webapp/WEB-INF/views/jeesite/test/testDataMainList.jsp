<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>主子表${fns:getLang('common.management', null)}</title>
	<meta name="decorator" content="default"/>	
	
	 <!-- CSS and JS for table fixed header -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.css">
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.js"></script>
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/bottom-sticker.min.js"></script>
	<script src="${ctxStatic}/common/gridify.min.js"></script>
	<script src="${ctxStatic}/jquery-plugin/colResizable-1.6.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
				
			$("#btnExcelExport").click(function(){
				top.$.jBox.confirm("确认要导出数据文件吗？如果数据过大，可能需要一些时间。","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#exportExcelForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnExcelImport").click(function(){
				$.jBox($("#importExcelBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
				
			// 删除选中行数据
			$("#btnDeleteChecked").click(function(){
				$.batPro("${ctx}/test/testDataMain/deleteChecked", "${fns:getLang('common.delete', null)}");
			});

			// 复制选中行数据
			$("#btnCopyChecked").click(function(){
				$.batPro("${ctx}/test/testDataMain/copyChecked", "${fns:getLang('common.copy', null)}");
			});
				
			// 双击记录进行编辑
			$("#contentTable tbody tr").on("dblclick", function() {
			    location.href="${ctx}/test/testDataMain/form?id="+this.id;
			});
			
			// make the header fixed on scroll
			$(".table-fixed-header").fixedHeader();
			$("#bottom-sticker").bottomSticker();
			
			// adding column resizing features
			$("#contentTable").colResizable(reDefColResizable());
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        	    
	    // 重置按钮
	    function searchReset(formId){
	    	// 重置所有输入框
	    	var inputDom = $("#" + formId).find(":input[type='text']");
	    	if(inputDom) inputDom.val("");
	    	
	    	// 重置下拉框
	    	//$("#type").val("");
	    	
	    	// 刷新表单
			$("#" + formId).submit();	    	
	    }
	</script>
</head>
<body>
	<div id="importExcelBox" class="hide">
		<form id="importExcelForm" action="${ctx}/test/testDataMain/import/excel" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadExcelFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportExcelSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/test/testDataMain/import/excel/template">下载模板</a>
		</form>
		<form id="exportExcelForm" action="${ctx}/test/testDataMain/export/excel" method="post" enctype="multipart/form-data">
		</form>
	</div>
	<ul id="mynav" class="nav nav-tabs">
		<li class="active"><a href="${ctx}/test/testDataMain/">主子表${fns:getLang('common.list', null)}</a></li>
		<shiro:hasPermission name="test:testDataMain:edit"><li><a href="${ctx}/test/testDataMain/form">主子表${fns:getLang('common.add', null)}</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testDataMain" action="${ctx}/test/testDataMain/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>归属用户：</label>
				<sys:treeselect id="user" name="user.id" value="${testDataMain.user.id}" labelName="user.name" labelValue="${testDataMain.user.name}"
					title="${fns:getLang('common.user', null)}" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>名称：</label>
				<form:input id="name" path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:select path="sex" class="input-medium">
					<form:option value="" label="${fns:getLang('common.null', null) }"/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="${fns:getLang('common.query', null)}"/></li>
			<li class="btns"><input id="btnSearchReset" class="btn btn-primary" type="reset" value="${fns:getLang('common.reset', null)}" onclick="searchReset('searchForm');"/></li>
			<li class="btns"><input id="btnDeleteChecked" class="btn btn-primary" type="button" value="${fns:getLang('common.delete', null)}" disabled="true" /></li>
			<shiro:hasPermission name="test:testDataMain:dba"><li class="btns" style="padding-left:30px;"><input id="btnCopyChecked" class="btn btn-primary" type="button" value="${fns:getLang('common.copy', null)}" disabled="true" /></li></shiro:hasPermission>
			
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<form:form id="gridForm" modelAttribute="testDataMain" action="${ctx}/test/testDataMain/deleteChecked" method="post">
		<span id="cbRowDataIdsBox">
			<input name="cbRowDataIds" type="hidden" value=""/>
		</span>
		<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover table-fixed-header">
			<thead class="header">
				<tr>
					<th style="width: 30px;" class="row-checkbox" title="${fns:getLang('common.checkall', null)}"><input type="checkbox" name="checkall" id="checkall" class="checkbox" /><label for="checkall"><span></span></label></th>
					<th style="width: 30px;" class="row-number">No.</th>
					<th style="display:none;">ID</th>
					<th style="width: 222px;">归属用户</th>
					<th style="width: 222px;">名称</th>
					<th style="width: 150px;" >更新时间</th>
					<th style="width: 222px;">备注信息</th>
					<shiro:hasPermission name="test:testDataMain:edit"><th style="width: 120px;">
						${fns:getLang('common.operate', null)}
						<div class="btn-group pull-right">
							<a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
							<ul class="dropdown-menu">
								<% // 物理删除选项 %>
								<shiro:hasPermission name="test:testDataMain:dba">
								<form:checkbox id="physicalDelete" path="physicalDelete" label="物理删除" title="默认逻辑删除，勾选后进行物理删除" />
								<li class="btns"><input id="btnTruncateTable" class="btn btn-warning typeahead" type="button" value="物理清空" onclick="truncateTable('${ctx}/test/testDataMain/truncateTable');"/></li></shiro:hasPermission>
								<% // Excel管理： 模版下载、数据导入、导入数据校验、数据导出 %>
								<shiro:hasPermission name="test:testDataMain:io">
								<li class="divider"></li>
								<li class="btns"><input id="btnExcelExport" class="btn btn-primary typeahead" type="button" value="Excel数据导出"/></li>
								<li class="btns"><input id="btnExcelImport" class="btn btn-primary typeahead" type="button" value="Excel数据导入"/></li></shiro:hasPermission>
							</ul>
						</div>
					</th></shiro:hasPermission>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="testDataMain" varStatus="vs">
				<tr id="${testDataMain.id}">
					<td class="row-checkbox"><input type="checkbox" name="cbRowData" id="cb_${testDataMain.id}" class="checkbox" /><label for="cb_${testDataMain.id}"><span></span></label></td></td>
					<td class="row-number">
						${vs.index + 1 + (page.pageNo-1)*page.pageSize}
					</td>
					<td class="row-id" style="display:none;">${testDataMain.id}</td>
					<td><a href="${ctx}/test/testDataMain/form?id=${testDataMain.id}">
						${testDataMain.user.name}
					</a></td>
					<td>
						${testDataMain.name}
					</td>
					<td>
						<fmt:formatDate value="${testDataMain.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td>
						${testDataMain.remarks}
					</td>
					<shiro:hasPermission name="test:testDataMain:edit"><td class="row-operate">
	    				<a href="${ctx}/test/testDataMain/form?id=${testDataMain.id}">${fns:getLang('common.edit', null)}</a>
						<a href="javascript:void(0)" onclick="rowDelete('${ctx}/test/testDataMain/delete?id=${testDataMain.id}');">${fns:getLang('common.delete', null)}</a>
						<shiro:hasPermission name="test:testDataMain:dba">&nbsp;|&nbsp;<a href="${ctx}/test/testDataMain/copy?id=${testDataMain.id}" onclick="top.$.jBox.tip.mess=false;return this.href">${fns:getLang('common.copy', null)}</a></shiro:hasPermission>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="pagination" id="bottom-sticker">${page}</div>
	</form:form>
</body>
</html>