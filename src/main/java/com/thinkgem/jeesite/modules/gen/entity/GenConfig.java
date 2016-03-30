/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.entity;

import java.io.Serializable;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.thinkgem.jeesite.modules.sys.entity.Dict;

/**
 * 生成方案Entity
 * @author ThinkGem
 * @version 2013-10-15
 * @version 2015-10-23 1.2.9 add multiple data source by Jeffen@pactera
 */
@XmlRootElement(name="config")
public class GenConfig implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private List<GenCategory> categoryList;	// 代码模板分类
	private List<Dict> javaTypeList;		// Java类型
	private List<Dict> queryTypeList;		// 查询类型
	private List<Dict> showTypeList;		// 显示类型

	// add template file select option by jeffen@pactera 2015/6/9 start
	private List<Dict> templateFiles; // 模版文件清单
	public List<Dict> getTemplateFiles() {
		return templateFiles;
	}

	public void setTemplateFiles(List<Dict> templateFiles) {
		this.templateFiles = templateFiles;
	}
	// add template file select option by jeffen@pactera 2015/6/9 end

	// add multiple data source select option by jeffen@pactera 2015/10/23 start
	private List<Dict> dataSourceList; // 数据源
	@XmlElementWrapper(name = "dataSource")
	@XmlElement(name = "dict")
	public List<Dict> getDataSourceList() {
		return dataSourceList;
	}

	public void setDataSourceList(List<Dict> dataSourceList) {
		this.dataSourceList = dataSourceList;
	}
	//  add multiple data source select option by jeffen@pactera 2015/10/23 end
	
	public GenConfig() {
		super();
	}

	@XmlElementWrapper(name = "category")
	@XmlElement(name = "category")
	public List<GenCategory> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<GenCategory> categoryList) {
		this.categoryList = categoryList;
	}

	@XmlElementWrapper(name = "javaType")
	@XmlElement(name = "dict")
	public List<Dict> getJavaTypeList() {
		return javaTypeList;
	}

	public void setJavaTypeList(List<Dict> javaTypeList) {
		this.javaTypeList = javaTypeList;
	}

	@XmlElementWrapper(name = "queryType")
	@XmlElement(name = "dict")
	public List<Dict> getQueryTypeList() {
		return queryTypeList;
	}

	public void setQueryTypeList(List<Dict> queryTypeList) {
		this.queryTypeList = queryTypeList;
	}

	@XmlElementWrapper(name = "showType")
	@XmlElement(name = "dict")
	public List<Dict> getShowTypeList() {
		return showTypeList;
	}

	public void setShowTypeList(List<Dict> showTypeList) {
		this.showTypeList = showTypeList;
	}
	
}