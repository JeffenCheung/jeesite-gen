/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 生成方案Entity
 * @author ThinkGem
 * @version 2013-10-15
 */
public class GenScheme extends DataEntity<GenScheme> {
	
	private static final long serialVersionUID = 1L;
	private String name; 	// 名称
	private String category;		// 分类
	private String packageName;		// 生成包路径
	private String moduleName;		// 生成模块名
	private String subModuleName;		// 生成子模块名
	private String functionName;		// 生成功能名
	private String functionNameSimple;		// 生成功能名（简写）
	private String functionAuthor;		// 生成功能作者
	private GenTable genTable;		// 业务表名
	
	private String flag; 	// 0：保存方案； 1：保存方案并生成代码
	
	private Boolean replaceFile = true;	// 是否替换现有文件    0：不替换；1：替换文件
	
	// add io artifact by jeffen@pactera 2015/6/5 start
	private String ioArtifact;	// 导入导出工具包
	
	public String getIoArtifact() {
		return ioArtifact;
	}

	public void setIoArtifact(String ioArtifact) {
		this.ioArtifact = ioArtifact;
	}
	// add io util by jeffen@pactera 2015/6/5 end
	
	// add template file select option by jeffen@pactera 2015/6/9 start
	private String templateFiles;		// 模版文件清单
	private String projectPath;		// 工程路径
	public String getTemplateFiles() {
		return templateFiles;
	}

	public void setTemplateFiles(String templateFiles) {
		this.templateFiles = templateFiles;
	}
	
	public String getProjectPath() {
		return projectPath;
	}

	public void setProjectPath(String projectPath) {
		this.projectPath = projectPath;
	}
	// add template file select option by jeffen@pactera 2015/6/9 end
	
	//  add row-number by jeffen@pactera 2015/9/16 start
	private Boolean showRowNo = true;	// 是否显示行号    0：不显示；1：显示

	public Boolean getShowRowNo() {
		return showRowNo;
	}

	public void setShowRowNo(Boolean showRowNo) {
		this.showRowNo = showRowNo;
	}
	//  add row-number by jeffen@pactera 2015/9/16 end

	//  add row-checkbox by jeffen@pactera 2015/9/25 start
	private Boolean showRowCheckBox = true;	// 是否显示行复选    0：不显示；1：显示

	public Boolean getShowRowCheckBox() {
		return showRowCheckBox;
	}

	public void setShowRowCheckBox(Boolean showRowCheckBox) {
		this.showRowCheckBox = showRowCheckBox;
	}
	//  add row-checkbox by jeffen@pactera 2015/9/25 end
	//  add row-copy-function by jeffen@pactera 2015/10/4 start
	private Boolean showRowCopyFunction = true;	// 是否显示复制功能    0：不显示；1：显示
	private Boolean showPhysicalDeleteFunction = true;	// 是否显示物理删除功能    0：不显示；1：显示
	
	public Boolean getShowRowCopyFunction() {
		return showRowCopyFunction;
	}

	public void setShowRowCopyFunction(Boolean showRowCopyFunction) {
		this.showRowCopyFunction = showRowCopyFunction;
	}

	public Boolean getShowPhysicalDeleteFunction() {
		return showPhysicalDeleteFunction;
	}

	public void setShowPhysicalDeleteFunction(Boolean showPhysicalDeleteFunction) {
		this.showPhysicalDeleteFunction = showPhysicalDeleteFunction;
	}
	//  add row-copy-function by jeffen@pactera 2015/10/4 end
	
	public GenScheme() {
		super();
	}

	public GenScheme(String id){
		super(id);
	}
	
	@Length(min=1, max=200)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getSubModuleName() {
		return subModuleName;
	}

	public void setSubModuleName(String subModuleName) {
		this.subModuleName = subModuleName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public String getFunctionNameSimple() {
		return functionNameSimple;
	}

	public void setFunctionNameSimple(String functionNameSimple) {
		this.functionNameSimple = functionNameSimple;
	}

	public String getFunctionAuthor() {
		return functionAuthor;
	}

	public void setFunctionAuthor(String functionAuthor) {
		this.functionAuthor = functionAuthor;
	}

	public GenTable getGenTable() {
		return genTable;
	}

	public void setGenTable(GenTable genTable) {
		this.genTable = genTable;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Boolean getReplaceFile() {
		return replaceFile;
	}

	public void setReplaceFile(Boolean replaceFile) {
		this.replaceFile = replaceFile;
	}
	
}


