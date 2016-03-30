<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>业务表管理</title>
<meta name="decorator" content="default" />
	
	 <!-- CSS and JS for table fixed header -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.css">
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.js"></script>
	
<script type="text/javascript">
	$(document).ready(function() {
			$("#comments").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					$("input[type=checkbox]").each(function(){
						$(this).after("<input type=\"hidden\" name=\""+$(this).attr("name")+"\" value=\""
								+($(this).is(":checked")?"1":"0")+"\"/>");
						$(this).attr("name", "_"+$(this).attr("name"));
					});
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			// make the header fixed on scroll
			$(".table-fixed-header").fixedHeader();
			
			// Select the row without radio or checkbox by jeffen@pactera 2016/2/23
			$("#contentTable tbody tr").on("click", function() {
				$('.table-row-selected').removeClass('table-row-selected');
				$(this).addClass('table-row-selected').children().addClass("table-row-selected");
			});
			
			// change select2 renderd dom color by jeffen@pactera 2016/2/24
			$("select[class*='csv_check_block_']").each(function(idx, itm) {
				$(itm).next().find(".select2-selection__rendered").attr("style", "color: orange");
			});
			$("select[class*='excel_check_block_']").each(function(idx, itm) {
				$(itm).next().find(".select2-selection__rendered").attr("style", "color: blue");
			});
			
		});
		
		/**
		* sync block elements status.
		*
		* cid : class id
		* cb: checkbox dom object
		**/
		function syncCheckBlock(cid, cb){
			cDebug("syncCheckBlock", cid+" block checkstatus by is:"+$(cb).is(":checked"));
			cDebug("syncCheckBlock", cid+" block checkstatus by attr:"+$(cb).attr("checked"));
			$("." + cid).effect("highlight", 500).each(function(idx, itm) {
				if ($(cb).is(":checked")) {
					$(itm).removeAttr("disabled");
					if ($(itm)[0].tagName.toLowerCase() == "select") {
						// select2 change to classic theme for active style
						$(itm).next().removeClass("select2-container--default").addClass("select2-container--classic");
					}
					
				} else {
					$(itm).attr("disabled", true);
					if ($(itm)[0].tagName.toLowerCase() == "select") {
						// select2 change to default theme for disable style
						$(itm).next().removeClass("select2-container--classic").addClass("select2-container--default");
					}
				  
				}
				// set required-disabled input to disabled style.
				if ($(itm)[0].tagName.toLowerCase() == "input" && $(itm).hasClass("required")) {
					$(itm).toggleClass("required-disabled");
				}
			});
        }
</script>
</head>
<body>
	<ul id="mynav" class="nav nav-tabs">
		<li><a href="${ctx}/gen/genTable/">业务表列表</a></li>
		<li class="active"><a
			href="${ctx}/gen/genTable/form?id=${genTable.id}&name=${genTable.name}">业务表<shiro:hasPermission
					name="gen:genTable:edit">${not empty genTable.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="gen:genTable:edit">查看</shiro:lacksPermission>
		</a></li>
	</ul>
	<c:choose>
		<c:when test="${empty genTable.name}">
			<form:form id="inputForm" modelAttribute="genTable"
				action="${ctx}/gen/genTable/form" method="post"
				class="form-horizontal">
				<form:hidden path="id" />
				<sys:message content="${message}" />
				<br />

				<div class="control-group">
					<label class="control-label">数据源:</label>
					<div class="controls">
						<form:select path="dataSource" class="required input-xlarge" onchange="location.href='${ctx}/gen/genTable/form?id=${genTable.id}&name=${genTable.name}&dataSource='+this.value">
							<form:options items="${config.dataSourceList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>


				<div class="control-group">
					<label class="control-label">表名:</label>
					<div class="controls">
						<form:select path="name" class="input-xxlarge">
							<form:options items="${tableList}" itemLabel="nameAndComments"
								itemValue="name" htmlEscape="false" />
						</form:select>
					</div>
					<div class="form-actions">
						<input id="btnSubmit" class="btn btn-primary" type="submit"
							value="下一步" />&nbsp; <input id="btnCancel" class="btn"
							type="button" value="返 回" onclick="history.go(-1)" />
					</div>
				</div>
			</form:form>
		</c:when>
		<c:otherwise>
			<form:form id="inputForm" modelAttribute="genTable"
				action="${ctx}/gen/genTable/save" method="post"
				class="form-horizontal">
				<form:hidden path="id" />
				<sys:message content="${message}" />
				<fieldset>
					<legend>基本信息</legend>
					<div class="control-group">
						<label class="control-label">数据源:</label>
						<div class="controls">
							<form:select path="dataSource" class="required input-xlarge" >
								<form:options items="${config.dataSourceList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						
							&nbsp;表名:
							<form:input path="name" htmlEscape="false" maxlength="200"
								class="required" readonly="true" />
							&nbsp;说明:
							<form:input path="comments" htmlEscape="false" maxlength="200"
								class="required" />
							&nbsp;类名:
							<form:input path="className" htmlEscape="false" maxlength="200"
								class="required" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">父表表名:</label>
						<div class="controls">
							<form:select path="parentTable" cssClass="input-xlarge">
								<form:option value="" label="${fns:getLang('common.please.select', '---请选择---')}"/>
								<form:options items="${tableList}" itemLabel="nameAndComments"
									itemValue="name" htmlEscape="false" />
							</form:select>
							&nbsp;当前表外键：
							<form:select path="parentTableFk" cssClass="input-xlarge">
								<form:option value="" label="${fns:getLang('common.please.select', '---请选择---')}"/>
								<form:options items="${genTable.columnList}"
									itemLabel="nameAndComments" itemValue="name" htmlEscape="false" />
							</form:select>
							<span class="help-inline">如果有父表，请指定父表表名和外键</span>
						</div>
					</div>
					<div class="control-group hide">
						<label class="control-label">备注:</label>
						<div class="controls">
							<form:textarea path="remarks" htmlEscape="false" rows="4"
								maxlength="200" class="input-xxlarge" />
						</div>
					</div>
					<legend>字段列表</legend>
					<div class="control-group">
						<table id="contentTable"
							class="table table-striped table-bordered table-condensed table-hover table-fixed-header">
							<thead class="header">
								<tr>
									<th colspan="3">
										physical
									</th>
									<th colspan="2">
										logical
									</th>
									<th colspan="6">
										common
									</th>
									<th colspan="5" style="color: orange;">
										orangesignal-csv
									</th>
									<th colspan="5" style="color: blue;">
										poi
									</th>
									<th colspan="5">
										others
									</th>
								</tr>
								<tr>
									<th title="数据库字段名">列名</th>
									<th title="默认读取数据库字段备注">说明</th>
									<th title="数据库中设置的字段类型及长度">物理类型</th>
									<th title="实体对象的属性字段类型">Java类型</th>
									<th
										title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">Java属性名称
										<i class="icon-question-sign"></i></th>
									<th title="是否是数据库主键">主键</th>
									<th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
									<th title="选中后该字段被加入到insert语句里">插入</th>
									<th title="选中后该字段被加入到update语句里">编辑</th>
									<th title="选中后该字段被加入到查询列表里">列表</th>
									<th title="选中后该字段被加入到查询条件里">查询</th>

									<%
										// add csv position by jeffen@pactera 2015/6/5 start
									%>
									<th style="color: orange;" title="选中后CSV导入导出该字段生效">[&nbsp;&nbsp;CSV&nbsp;&nbsp;</th>
									<th style="color: orange;"
										title="CSV列数据访问方式：[READ]导入只读，但不导该出字段；[READ_WRITE]导入只读，并导该出字段；[WRITE]导入文件不含该字段，但导该出字段">CSV方式</th>
									<th style="color: orange;" title="CSV文件没有Header头部记录时标记各字段位置">CSV位置</th>
									<th style="color: orange;" title="CSV文件模版数据用例">默认值</th>
									<th style="color: orange;" title="CSV文件模版数据格式化(#,##0.0;yyyy/MM/dd;HH:mm:ss等)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格式化&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]</th>
									<%
										// add csv position by jeffen@pactera 2015/6/5 end
									%>
									
									<%
										// add excel io by jeffen@pactera 2015/9/11 start
									%>
									<th style="color: blue;" title="选中后Excel导入导出该字段生效">[&nbsp;&nbsp;Excel&nbsp;&nbsp;</th>
									<th style="color: blue;"
										title="EXCEL导出字段名（默认调用当前字段的“get”方法，如指定导出字段为对象，请填写“对象名.对象属性”，例：“area.name”、“office.name”）">字段名</th>
									<th style="color: blue;" title="EXCEL导出字段标题（需要添加批注请用“**”分隔，标题**批注，仅对导出模板有效）">字段标题</th>
									<th style="color: blue;" title="EXCEL字段类型（0：导出导入；1：仅导出；2：仅导入）">字段类型</th>
									<th style="color: blue;" title="EXCEL导出字段对齐方式（0：自动；1：靠左；2：居中；3：靠右）">对齐方式&nbsp;&nbsp;]</th>
									<%
										// add excel io by jeffen@pactera 2015/9/11 end
									%>
									
									<th title="查询结果排序方式（非排序字段、升序ASC、降序DESC）">结果排序方式</th>
									<th title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
									<th title="字段在表单中显示的类型">显示表单类型</th>
									<th title="显示表单类型设置为“下拉框、复选框、点选框、自动填充列表”时，需设置字典的类型">字典类型</th>
									<th>排序</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${genTable.columnList}" var="column"
									varStatus="vs">
									<tr ${column.delFlag eq '1'?' class="error"
										title="已删除的列，保存之后消失！"':''}>
										<td nowrap><input type="hidden"
											name="columnList[${vs.index}].id" value="${column.id}" /> <input
											type="hidden" name="columnList[${vs.index}].delFlag"
											value="${column.delFlag}" /> <input type="hidden"
											name="columnList[${vs.index}].genTable.id"
											value="${column.genTable.id}" /> <input type="hidden"
											name="columnList[${vs.index}].name" value="${column.name}" />${column.name}
										</td>
										<td><input type="text"
											name="columnList[${vs.index}].comments"
											value="${column.comments}" maxlength="200" class="required"
											style="width:100px;" />
										</td>
										<td nowrap><input type="hidden"
											name="columnList[${vs.index}].jdbcType"
											value="${column.jdbcType}" />${column.jdbcType}</td>
										<td><select name="columnList[${vs.index}].javaType"
											class="required input-mini" style="width:85px;*width:75px">
												<c:forEach items="${config.javaTypeList}" var="dict">
													<option value="${dict.value}"
														${dict.value==column.javaType?
														'selected':''} title="${dict.description}">${dict.label}</option>
												</c:forEach>
										</select>
										</td>
										<td><input type="text"
											name="columnList[${vs.index}].javaField"
											value="${column.javaField}" maxlength="200"
											class="required input-small" />
										</td>
										<td><input type="checkbox"
											name="columnList[${vs.index}].isPk" value="1" ${column.isPk eq '1' ? 'checked' : ''}/>
										</td>
										<td><input type="checkbox"
											name="columnList[${vs.index}].isNull" value="1"
											${column.isNull eq '1' ? 'checked' : ''}/>
										</td>
										<td><input type="checkbox"
											name="columnList[${vs.index}].isInsert" value="1"
											${column.isInsert eq '1' ? 'checked' : ''}/>
										</td>
										<td><input type="checkbox"
											name="columnList[${vs.index}].isEdit" value="1"
											${column.isEdit eq '1' ? 'checked' : ''}/>
										</td>
										<td><input type="checkbox"
											name="columnList[${vs.index}].isList" value="1"
											${column.isList eq '1' ? 'checked' : ''}/>
										</td>
										<td><input type="checkbox"
											name="columnList[${vs.index}].isQuery" value="1"
											${column.isQuery eq '1' ? 'checked' : ''}/>
										</td>

										<%
											// add csv position by jeffen@pactera 2015/6/5 start
										%>
										<td style="color: orange;">[&nbsp;<input type="checkbox"
											id="columnList[${vs.index}].isCsv" class="checkbox" style="display:none;"
											name="columnList[${vs.index}].isCsv" value="1" 
											onclick="syncCheckBlock('csv_check_block_${vs.index}', this);"
											${column.isCsv eq '1' ? 'checked' : ''}/>
											<label for="columnList[${vs.index}].isCsv"><span></span></label>
										</td>
										<td><form:select
												path="columnList[${vs.index}].csvColumnAccessType"
												class="input-mini csv_check_block_${vs.index}" 
												disabled="${column.isCsv eq '1' ? 'false' : 'true'}" >
												<form:option value=""
													label="${fns:getLang('common.null', null) }" />
												<form:options
													items="${fns:getDictList('CsvColumnAccessType')}"
													itemLabel="label" itemValue="value" htmlEscape="false" />
											</form:select>
										</td>
										<td style="color: orange;"><input type="text"
											name="columnList[${vs.index}].csvPosition"
											value="${column.csvPosition}" maxlength="3"
											style="width: 50px; color: orange" class="input-min digits csv_check_block_${vs.index}" 
											${column.isCsv eq '1' ? '' : 'disabled'}/>
										</td>
										<td style="color: orange;">
											<div style="width: 123px;">
												<input type="text" style="color: orange"
													name="columnList[${vs.index}].defaultValue"
													value="${column.defaultValue}" maxlength="200"
													class="input-mini csv_check_block_${vs.index}" 
													${column.isCsv eq '1' ? '' : 'disabled'}/>
											</div>
										</td>
										<td style="color: orange;">
											<div style="width: 123px;">
												<input type="text" style="color: orange"
													name="columnList[${vs.index}].format"
													value="${column.format}" maxlength="200"
													class="input-mini csv_check_block_${vs.index}" 
													${column.isCsv eq '1' ? '' : 'disabled'}/> &nbsp;]
											</div>
										</td>
										<%
											// add csv position by jeffen@pactera 2015/6/5 end
										%>

										<%
											// add excel io by jeffen@pactera 2015/9/11 start
										%>
										<td style="color: blue;">[&nbsp;<input type="checkbox"
											id="columnList[${vs.index}].isExcel" class="checkbox" style="display:none;"
											name="columnList[${vs.index}].isExcel" value="1" 
											onclick="syncCheckBlock('excel_check_block_${vs.index}', this);"
											${column.isExcel eq '1' ? 'checked' : ''}/>
											<label for="columnList[${vs.index}].isExcel"><span></span></label>
										</td>
										<td style="color: blue;"><input type="text"
											name="columnList[${vs.index}].excelValue"
											value="${column.excelValue}" maxlength="500"
											style="width: 123px; color: blue;" class="input-min excel_check_block_${vs.index}" 
											${column.isExcel eq '1' ? '' : 'disabled'}/>
										</td>
										<td style="color: blue;"><input type="text"
											name="columnList[${vs.index}].excelTitle"
											value="${column.excelTitle eq null or column.excelTitle eq '' ? column.comments : column.excelTitle}" maxlength="500"
											style="width: 123px; color: blue;" class="input-min required excel_check_block_${vs.index}" 
											${column.isExcel eq '1' ? '' : 'disabled'}/>
										</td>
										<td><form:select
												path="columnList[${vs.index}].excelType"
												class="input-mini excel_check_block_${vs.index}" 
												disabled="${column.isExcel eq '1' ? 'false' : 'true'}" >
												<form:option value=""
													label="${fns:getLang('common.null', null) }" />
												<form:options
													items="${fns:getDictList('ExcelType')}"
													itemLabel="label" itemValue="value" htmlEscape="false" />
											</form:select>
										</td>
										<td><form:select
												path="columnList[${vs.index}].excelAlign"
												class="input-mini excel_check_block_${vs.index}" 
												disabled="${column.isExcel eq '1' ? 'false' : 'true'}" >
												<form:option value=""
													label="${fns:getLang('common.null', null) }" />
												<form:options
													items="${fns:getDictList('ExcelAlign')}"
													itemLabel="label" itemValue="value" htmlEscape="false" />
											</form:select>
										</td>
										<%
											// add excel io by jeffen@pactera 2015/9/11 end
										%>
										
										<td><form:select path="columnList[${vs.index}].orderType"
												class="input-mini">
												<form:option value=""
													label="${fns:getLang('common.null', null) }" />
												<form:options items="${fns:getDictList('sys_order_type')}"
													itemLabel="label" itemValue="value" htmlEscape="false" />
											</form:select>
										</td>
										<td><select name="columnList[${vs.index}].queryType"
											class="required input-mini">
												<c:forEach items="${config.queryTypeList}" var="dict">
													<option value="${fns:escapeHtml(dict.value)}"
														${fns:escapeHtml(dict.value)==column.queryType?
														'selected':''} title="${dict.description}">${fns:escapeHtml(dict.label)}</option>
												</c:forEach>
										</select>
										</td>
										<td><select name="columnList[${vs.index}].showType"
											class="required" style="width:100px;">
												<c:forEach items="${config.showTypeList}" var="dict">
													<option value="${dict.value}"
														${dict.value==column.showType?
														'selected':''} title="${dict.description}">${dict.label}</option>
												</c:forEach>
										</select>
										</td>
										<td>
											<form:select path="columnList[${vs.index}].dictType" class="input-small">
												<form:options items="${fns:getDictTypeDesList()}" itemLabel="description" itemValue="type" htmlEscape="false"/>
												<form:option value="" label="${fns:getLang('common.please.select', '---请选择---')}"/>
											</form:select>
										</td>
										<td><input type="text"
											name="columnList[${vs.index}].sort" value="${column.sort}"
											maxlength="200" class="required input-minm digits text-right" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</fieldset>
				<div class="form-actions">
					<shiro:hasPermission name="gen:genTable:edit">
						<input id="btnSubmit" class="btn btn-primary" type="submit"
							value="保 存" />&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回"
						onclick="history.go(-1)" />
				</div>
			</form:form>
		</c:otherwise>
	</c:choose>
</body>
</html>
