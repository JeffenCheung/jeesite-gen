/**
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.served.
 */
package com.thinkgem.jeesite.test.entity;

import java.util.HashMap;

import javax.xml.bind.annotation.XmlRootElement;

import java.util.List;

/**
 * 单表生成Entity for aggregation
 * 
 * @author Jeffen@pactera
 * @version 2015-10-10
 */
@XmlRootElement
public class TestDatas {

	private long l;
	private List<TestData> list;
	private TestData[] arr;
	private HashMap<String, TestData> map;

	public TestDatas() {
		super();
	}

	public long getL() {
		return l;
	}

	public void setL(long l) {
		this.l = l;
	}

	public List<TestData> getList() {
		return list;
	}

	public void setList(List<TestData> list) {
		this.list = list;
	}

	public TestData[] getArr() {
		return arr;
	}

	public void setArr(TestData[] arr) {
		this.arr = arr;
	}

	public HashMap<String, TestData> getMap() {
		return map;
	}

	public void setMap(HashMap<String, TestData> map) {
		this.map = map;
	}

	@Override
	public String toString() {
		return this.l + "#";
	}

}