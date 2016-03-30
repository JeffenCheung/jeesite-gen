/**
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.served.
 */
package com.thinkgem.jeesite.test.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import org.hibernate.validator.constraints.Length;
import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.orangesignal.csv.annotation.*;

/**
 * 单表生成Entity
 * @author Jeffen@pactera
 * @version 2015-10-10
 */
@CsvEntity(header = true)
@XmlRootElement
public class TestData extends DataEntity<TestData> {
	
	private static final long serialVersionUID = 1L;
	@CsvColumn(access=CsvColumnAccessType.READ_WRITE, name = "归属用户")
	private User user;		// 归属用户
	@CsvColumn(access=CsvColumnAccessType.READ_WRITE, name = "归属部门")
	private Office office;		// 归属部门
	@CsvColumn(access=CsvColumnAccessType.READ, name = "归属区域")
	private Area area;		// 归属区域
	@CsvColumn(access=CsvColumnAccessType.READ_WRITE, name = "名称")
	private String name;		// 名称
	@CsvColumn(access=CsvColumnAccessType.READ_WRITE, name = "性别")
	private String sex;		// 性别
	@CsvColumn(access=CsvColumnAccessType.READ_WRITE, name = "加入日期")
	private Date inDate;		// 加入日期
	private Date beginInDate;		// 开始 加入日期
	private Date endInDate;		// 结束 加入日期

	public TestData() {
		super();
	}

	public TestData(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=0, max=100, message="名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=1, message="性别长度必须介于 0 和 1 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getInDate() {
		return inDate;
	}

	public void setInDate(Date inDate) {
		this.inDate = inDate;
	}
	
	public Date getBeginInDate() {
		return beginInDate;
	}

	public void setBeginInDate(Date beginInDate) {
		this.beginInDate = beginInDate;
	}
	
	public Date getEndInDate() {
		return endInDate;
	}

	public void setEndInDate(Date endInDate) {
		this.endInDate = endInDate;
	}
	
	@Override
	public String toString(){
		return this.id + "#" + this.name + "#" ;
	}
		
}