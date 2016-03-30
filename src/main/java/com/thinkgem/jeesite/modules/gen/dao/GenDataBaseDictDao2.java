/**
 * Copyright &copy; 2014-2016 <a href="https://github.com/jeffencheung/jeesite">Pactera-JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao2;
import com.thinkgem.jeesite.modules.gen.entity.GenTable;
import com.thinkgem.jeesite.modules.gen.entity.GenTableColumn;

/**
 * 【数据源2】业务表字段DAO接口
 * @author Jeffen
 * @version 2015-10-23
 */
@MyBatisDao2
public interface GenDataBaseDictDao2 extends CrudDao<GenTableColumn> {

	/**
	 * 查询表列表
	 * @param genTable
	 * @return
	 */
	List<GenTable> findTableList(GenTable genTable);

	/**
	 * 获取数据表字段
	 * @param genTable
	 * @return
	 */
	List<GenTableColumn> findTableColumnList(GenTable genTable);
	
	/**
	 * 获取数据表主键
	 * @param genTable
	 * @return
	 */
	List<String> findTablePK(GenTable genTable);
	
}
