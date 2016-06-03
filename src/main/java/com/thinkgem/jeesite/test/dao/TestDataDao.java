/**
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.served.
 */
package com.thinkgem.jeesite.test.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.test.entity.TestData;

/**
 * 【数据源】单表生成DAO接口
 * @author Jeffen@pactera
 * @version 2016-05-27
 */
@MyBatisDao
public interface TestDataDao extends CrudDao<TestData> {
	
}