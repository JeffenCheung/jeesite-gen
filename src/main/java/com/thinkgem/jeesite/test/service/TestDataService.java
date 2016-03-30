/**
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.served.
 */
package com.thinkgem.jeesite.test.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.test.entity.TestData;
import com.thinkgem.jeesite.test.entity.TestDatas;
import com.thinkgem.jeesite.test.service.api.TestDataServiceApi;
import com.thinkgem.jeesite.test.dao.TestDataDao;

/**
 * 单表生成Service
 * @author Jeffen@pactera
 * @version 2015-10-10
 */
@Service
@Transactional(readOnly = true)
@Component("testDataApplication")
public class TestDataService extends CrudService<TestDataDao, TestData> implements TestDataServiceApi{

	public TestData get(String id) {
		return super.get(id);
	}
	
	public List<TestData> findList(TestData testData) {
		return super.findList(testData);
	}
	
	public List<TestData> findAllList() {
		return super.findList(new TestData());
	}

	public TestDatas findAggregation(TestData testData)  throws IOException {
		List<TestData> list = super.findList(testData);

		TestDatas agg = new TestDatas();
		agg.setList(list);
		agg.setL(list != null ? list.size() : 0);
		agg.setArr((TestData[]) list.toArray());

		HashMap<String, TestData> map = new HashMap<String, TestData>();
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				map.put(list.get(i).getId(), list.get(i));
			}
		}
		agg.setMap(map);
		return agg;
	}
	public TestDatas findAllAggregation() throws IOException {
		return findAggregation(new TestData());
	}
	
	public Page<TestData> findPage(Page<TestData> page, TestData testData) {
		return super.findPage(page, testData);
	}
	
	@Transactional(readOnly = false)
	public void save(TestData testData) {
		super.save(testData);
	}
	
	@Transactional(readOnly = false)
	public void delete(TestData testData) {
		super.delete(testData);
	}

	@Transactional(readOnly = false)
	public void deleteList(TestData testData) {
		super.deleteList(testData);
	}
		
	@Transactional(readOnly = false)
	public void truncateTable(TestData testData) {
		super.truncateTable(testData);
	}
		
	@Transactional(readOnly = false)
	public void copy(TestData testData) {
		super.copy(testData);
	}
	
	@Transactional(readOnly = false)
	public void copyList(TestData testData) {
		super.copyList(testData);
	}
}