/**
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.served.
 */
package com.thinkgem.jeesite.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.test.entity.TestDataMain;
import com.thinkgem.jeesite.test.dao.TestDataMainDao;
import com.thinkgem.jeesite.test.entity.TestDataChild;
import com.thinkgem.jeesite.test.dao.TestDataChildDao;

/**
 * 主子表生成Service
 * @author Jeffen@pactera
 * @version 2015-10-10
 */
@Service
@Transactional(readOnly = true)
public class TestDataMainService extends CrudService<TestDataMainDao, TestDataMain> {

	@Autowired
	private TestDataChildDao testDataChildDao;
	
	public TestDataMain get(String id) {
		TestDataMain testDataMain = super.get(id);
		testDataMain.setTestDataChildList(testDataChildDao.findList(new TestDataChild(testDataMain)));
		return testDataMain;
	}
	
	public List<TestDataMain> findList(TestDataMain testDataMain) {
		return super.findList(testDataMain);
	}
	
	public Page<TestDataMain> findPage(Page<TestDataMain> page, TestDataMain testDataMain) {
		return super.findPage(page, testDataMain);
	}
	
	@Transactional(readOnly = false)
	public void save(TestDataMain testDataMain) {
		super.save(testDataMain);
		for (TestDataChild testDataChild : testDataMain.getTestDataChildList()){
			if (testDataChild.getId() == null){
				continue;
			}
			if (TestDataChild.DEL_FLAG_NORMAL.equals(testDataChild.getDelFlag())){
				if (StringUtils.isBlank(testDataChild.getId())){
					testDataChild.setTestDataMain(testDataMain);
					testDataChild.preInsert();
					testDataChildDao.insert(testDataChild);
				}else{
					testDataChild.preUpdate();
					testDataChildDao.update(testDataChild);
				}
			}else{
				testDataChildDao.delete(testDataChild);
			}
		}
	}
		
	@Transactional(readOnly = false)
	public void delete(TestDataMain testDataMain) {
		super.delete(testDataMain);
		if (testDataMain.getPhysicalDelete()) {
			testDataChildDao.deleteByPhysical(new TestDataChild(testDataMain));
		} else {
			testDataChildDao.delete(new TestDataChild(testDataMain));
		}
	}

	@Transactional(readOnly = false)
	public void deleteList(TestDataMain testDataMain) {
		super.deleteList(testDataMain);
		if (testDataMain.getPhysicalDelete()) {
			testDataChildDao.deleteListByPhysical(new TestDataChild(testDataMain));
		} else {
			testDataChildDao.deleteList(new TestDataChild(testDataMain));
		}
	}
		
	@Transactional(readOnly = false)
	public void truncateTable(TestDataMain testDataMain) {
		super.truncateTable(testDataMain);
		testDataChildDao.truncateTable(new TestDataChild(testDataMain));
	}
		
	/**
	 * 复制数据[主子表]
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void copy(TestDataMain testDataMain) {
		super.copy(testDataMain);
		for (TestDataChild testDataChild : testDataMain.getTestDataChildList()){
			testDataChild.setTestDataMain(testDataMain);
			testDataChild.preInsert();
			testDataChildDao.insert(testDataChild);
		}
	}
	
	/**
	 * 复制数据集合[主子表]
	 * 
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void copyList(TestDataMain testDataMain) {
		List<String> lst = testDataMain.getCbRowDataIds();
		for (int i = 0; i < lst.size(); i++) {
			TestDataMain ce = get(lst.get(i));
			copy(ce);
		}
	}
}