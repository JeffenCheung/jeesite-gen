<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表${fns:getLang('common.management', null)}</title>
	<meta name="decorator" content="default"/>	
	
	 <!-- CSS and JS for table fixed header -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.css">
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.js"></script>
	<script src="${ctxStatic}/common/gridify.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$( "#name" ).autocomplete({
		        minLength: 1,
		        delay: 500,
		        //define callback to format results
		        source: function (request, response) {
		            $.getJSON("${ctx}/test/testData/getNameList", request, function(result) {
		                response($.map(result, function(item) {
		                    return {
		                        // following property gets displayed in drop down
		                        label: item.name,
		                        // following property gets entered in the textbox
		                        value: item.name
		                    }
		                }));
		            });
		        },
		 
		        //define select handler
		        select : function(event, ui) {
		            if (ui.item) {
		                event.preventDefault();
		                $("#name").val(ui.item.value);
		                $("#name").blur();
		                return false;
		            }
		        }
		    });
			$("#btnCsvExport").click(function(){
				top.$.jBox.confirm("确认要导出数据文件吗？如果数据过大，可能需要一些时间。","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#exportCsvForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnCsvImport").click(function(){
				$.jBox($("#importCsvBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“csv”格式文件！"});
			});
				
				
			// 删除选中行数据
			$("#btnDeleteChecked").click(function(){
				$.batPro("${ctx}/test/testData/deleteChecked", "${fns:getLang('common.delete', null)}");
			});

			// 复制选中行数据
			$("#btnCopyChecked").click(function(){
				$.batPro("${ctx}/test/testData/copyChecked", "${fns:getLang('common.copy', null)}");
			});
				
			// 双击记录进行编辑
			$("#contentTable tbody tr").on("dblclick", function() {
			    location.href="${ctx}/test/testData/form?id="+this.id;
			});
			
			// make the header fixed on scroll
			$(".table-fixed-header").fixedHeader();
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
	<div id="importCsvBox" class="hide">
		<form id="importCsvForm" action="${ctx}/test/testData/import/csv" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadCsvFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportCsvSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/test/testData/import/csv/template">下载模板</a>
		</form>
		<form id="exportCsvForm" action="${ctx}/test/testData/export/csv" method="post" enctype="multipart/form-data">
		</form>
	</div>
	<ul id="mynav" class="nav nav-tabs">
		<li class="active"><a href="${ctx}/test/testData/">单表${fns:getLang('common.list', null)}</a></li>
		<shiro:hasPermission name="test:testData:edit"><li><a href="${ctx}/test/testData/form">单表${fns:getLang('common.add', null)}</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testData" action="${ctx}/test/testData/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>归属用户：</label>
				<sys:treeselect id="user" name="user.id" value="${testData.user.id}" labelName="user.name" labelValue="${testData.user.name}"
					title="${fns:getLang('common.user', null)}" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>归属部门：</label>
				<sys:treeselect id="office" name="office.id" value="${testData.office.id}" labelName="office.name" labelValue="${testData.office.name}"
					title="${fns:getLang('common.dept', null)}" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>归属区域：</label>
				<sys:treeselect id="area" name="area.id" value="${testData.area.id}" labelName="area.name" labelValue="${testData.area.name}"
					title="${fns:getLang('common.area', null)}" url="/sys/area/treeData" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>名称：</label>
				<form:input id="name" path="name" htmlEscape="false" maxlength="100" class="input-medium" onFocus="inputFocus(this)" onBlur="inputBlur(this)"/>
			</li>
			<li><label>性别：</label>
				<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>加入日期：</label>
				<input name="beginInDate" id="beginInDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${testData.beginInDate}" pattern="yyyy-MM-dd"/>"
					onfocus="gangDateStart('endInDate', true, 'yyyy-MM-dd');" onclick="gangDateStart('endInDate', true, 'yyyy-MM-dd');"/> - 
				<input name="endInDate" id="endInDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${testData.endInDate}" pattern="yyyy-MM-dd"/>"
					onfocus="gangDateEnd('beginInDate', true, 'yyyy-MM-dd');" onclick="gangDateEnd('beginInDate', true, 'yyyy-MM-dd');"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="${fns:getLang('common.query', null)}"/></li>
			<li class="btns"><input id="btnSearchReset" class="btn btn-primary" type="reset" value="${fns:getLang('common.reset', null)}" onclick="searchReset('searchForm');"/></li>
			<li class="btns"><input id="btnDeleteChecked" class="btn btn-primary" type="button" value="${fns:getLang('common.delete', null)}" disabled="true" /></li>
			<shiro:hasPermission name="test:testData:dba"><li class="btns" style="padding-left:30px;"><input id="btnCopyChecked" class="btn btn-primary" type="button" value="${fns:getLang('common.copy', null)}" disabled="true" /></li></shiro:hasPermission>
			
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<form:form id="gridForm" modelAttribute="testData" action="${ctx}/test/testData/deleteChecked" method="post">
		<span id="cbRowDataIdsBox">
			<input name="cbRowDataIds" type="hidden" value=""/>
		</span>
		<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover table-fixed-header">
			<thead class="header">
				<tr>
					<th class="row-checkbox" title="${fns:getLang('common.checkall', null)}"><input type="checkbox" name="checkall" id="checkall" class="checkbox" /><label for="checkall"><span></span></label></th>
					<th class="row-number">No.</th>
					<th style="display:none;">ID</th>
					<th>归属用户</th>
					<th>归属部门</th>
					<th>归属区域</th>
					<th class="sort-column a.name">名称</th>
					<th>性别</th>
					<th class="sort-column a.update_date">更新时间</th>
					<th>备注信息</th>
					<shiro:hasPermission name="test:testData:edit"><th>
						${fns:getLang('common.operate', null)}
						<shiro:hasAnyPermissions name="test:testData:dba,test:testData:io">
						<div class="btn-group pull-right">
							<a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
							<ul class="dropdown-menu">
								<% // 物理删除选项 %>
								<shiro:hasPermission name="test:testData:dba">
								<form:checkbox id="physicalDelete" path="physicalDelete" label="物理删除" title="默认逻辑删除，勾选后进行物理删除" />
								<li class="btns"><input id="btnTruncateTable" class="btn btn-warning typeahead" type="button" value="物理清空" onclick="truncateTable('${ctx}/test/testData/truncateTable');"/></li></shiro:hasPermission>
								<% // CSV管理： 模版下载、数据导入、导入数据校验、数据导出 %>
								<li class="divider"></li>
								<shiro:hasPermission name="test:testData:io">
								<li class="btns"><input id="btnCsvExport" class="btn btn-primary typeahead" type="button" value="CSV数据导出"/></li>
								<li class="btns"><input id="btnCsvImport" class="btn btn-primary typeahead" type="button" value="CSV数据导入"/></li></shiro:hasPermission>
							</ul>
						</div></shiro:hasAnyPermissions>
					</th></shiro:hasPermission>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="testData" varStatus="vs">
				<tr id="${testData.id}">
					<td class="row-checkbox"><input type="checkbox" name="cbRowData" id="cb_${testData.id}" class="checkbox" /><label for="cb_${testData.id}"><span></span></label></td></td>
					<td class="row-number">
						${vs.index + 1}
					</td>
					<td class="row-id" style="display:none;">${testData.id}</td>
					<td><a href="${ctx}/test/testData/form?id=${testData.id}">
						${testData.user.name}
					</a></td>
					<td>
						${testData.office.name}
					</td>
					<td>
						${testData.area.name}
					</td>
					<td>
						${testData.name}
					</td>
					<td>
						${fns:getDictLabel(testData.sex, 'sex', '')}
					</td>
					<td>
						<fmt:formatDate value="${testData.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td>
						${testData.remarks}
					</td>
					<shiro:hasPermission name="test:testData:edit"><td class="row-operate">
	    				<a href="${ctx}/test/testData/form?id=${testData.id}">${fns:getLang('common.edit', null)}</a>
						<a href="javascript:void(0)" onclick="rowDelete('${ctx}/test/testData/delete?id=${testData.id}');">${fns:getLang('common.delete', null)}</a>
						<shiro:hasPermission name="test:testData:dba">&nbsp;|&nbsp;<a href="${ctx}/test/testData/copy?id=${testData.id}" onclick="top.$.jBox.tip.mess=false;return this.href">${fns:getLang('common.copy', null)}</a></shiro:hasPermission>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form:form>
	<div class="pagination">${page}</div>
</body>
</html>