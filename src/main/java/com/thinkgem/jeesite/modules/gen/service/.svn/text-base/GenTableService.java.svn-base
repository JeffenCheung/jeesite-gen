/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gen.entity.GenTable;
import com.thinkgem.jeesite.modules.gen.entity.GenTableColumn;
import com.thinkgem.jeesite.modules.gen.util.GenUtils;
import com.thinkgem.jeesite.modules.gen.dao.GenDataBaseDictDao;
import com.thinkgem.jeesite.modules.gen.dao.GenDataBaseDictDao2;
import com.thinkgem.jeesite.modules.gen.dao.GenDataBaseDictDao3;
import com.thinkgem.jeesite.modules.gen.dao.GenDataBaseDictDao4;
import com.thinkgem.jeesite.modules.gen.dao.GenDataBaseDictDao5;
import com.thinkgem.jeesite.modules.gen.dao.GenTableColumnDao;
import com.thinkgem.jeesite.modules.gen.dao.GenTableDao;

/**
 * 业务表Service
 * @author ThinkGem
 * @version 2013-10-15
 * @version 2015-10-23 1.2.9 add multiple data source by Jeffen@pactera
 */
@Service
@Transactional(readOnly = true)
public class GenTableService extends BaseService {

	@Autowired
	private GenTableDao genTableDao;
	@Autowired
	private GenTableColumnDao genTableColumnDao;
	@Autowired
	private GenDataBaseDictDao genDataBaseDictDao;
	@Autowired
	private GenDataBaseDictDao2 genDataBaseDictDao2;
	
	// 需要配置额外数据源时打开注解，方便Spring IOC
	//@Autowired
	private GenDataBaseDictDao3 genDataBaseDictDao3;
	//@Autowired
	private GenDataBaseDictDao4 genDataBaseDictDao4;
	//@Autowired
	private GenDataBaseDictDao5 genDataBaseDictDao5;
	
	public GenTable get(String id) {
		GenTable genTable = genTableDao.get(id);
		GenTableColumn genTableColumn = new GenTableColumn();
		genTableColumn.setGenTable(new GenTable(genTable.getId()));
		genTable.setColumnList(genTableColumnDao.findList(genTableColumn));
		return genTable;
	}
	
	public Page<GenTable> find(Page<GenTable> page, GenTable genTable) {
		genTable.setPage(page);
		page.setList(genTableDao.findList(genTable));
		return page;
	}

	public List<GenTable> findAll() {
		return genTableDao.findAllList(new GenTable());
	}
	
	/**
	 * 获取物理数据表列表【多数据源】
	 * @param genTable
	 * @return
	 */
	public List<GenTable> findTableListFormDb(GenTable genTable){
		List<GenTable>  tableList = genDataBaseDictDao.findTableList(genTable);

		// 数据源2
		if ("2".equals(genTable.getDataSource())) {
			try {
				tableList = genDataBaseDictDao2.findTableList(genTable);
			} catch (Exception e) {
				tableList = new ArrayList<GenTable>();
			}
		}
		// 数据源3
		if ("3".equals(genTable.getDataSource())) {
			try {
				tableList = genDataBaseDictDao3.findTableList(genTable);
			} catch (Exception e) {
				tableList = new ArrayList<GenTable>();
			}
		}
		// 数据源4
		if ("4".equals(genTable.getDataSource())) {
			try {
				tableList = genDataBaseDictDao4.findTableList(genTable);
			} catch (Exception e) {
				tableList = new ArrayList<GenTable>();
			}
		}
		// 数据源5
		if ("5".equals(genTable.getDataSource())) {
			try {
				tableList = genDataBaseDictDao5.findTableList(genTable);
			} catch (Exception e) {
				tableList = new ArrayList<GenTable>();
			}
		}
		
		return tableList;
	}

	/**
	 * 获取物理数据表列数据的列表【多数据源】
	 * @param genTable
	 * @return
	 */
	public List<GenTableColumn> findTableColumnListFormDb(GenTable genTable){
		List<GenTableColumn> columnList = genDataBaseDictDao.findTableColumnList(genTable);

		// 数据源2
		if ("2".equals(genTable.getDataSource())) {
			try {
				columnList = genDataBaseDictDao2.findTableColumnList(genTable);
			} catch (Exception e) {
				columnList = new ArrayList<GenTableColumn>();
			}
		}
		// 数据源3
		if ("3".equals(genTable.getDataSource())) {
			try {
				columnList = genDataBaseDictDao3.findTableColumnList(genTable);
			} catch (Exception e) {
				columnList = new ArrayList<GenTableColumn>();
			}
		}
		// 数据源4
		if ("4".equals(genTable.getDataSource())) {
			try {
				columnList = genDataBaseDictDao4.findTableColumnList(genTable);
			} catch (Exception e) {
				columnList = new ArrayList<GenTableColumn>();
			}
		}
		// 数据源5
		if ("5".equals(genTable.getDataSource())) {
			try {
				columnList = genDataBaseDictDao5.findTableColumnList(genTable);
			} catch (Exception e) {
				columnList = new ArrayList<GenTableColumn>();
			}
		}
		
		return columnList;
	}

	/**
	 * 获取物理数据表主键的列表【多数据源】
	 * @param genTable
	 * @return
	 */
	public List<String> findTablePKFormDb(GenTable genTable){
		List<String> pkList = genDataBaseDictDao.findTablePK(genTable);

		// 数据源2
		if ("2".equals(genTable.getDataSource())) {
			try {
				pkList = genDataBaseDictDao2.findTablePK(genTable);
			} catch (Exception e) {
				pkList = new ArrayList<String>();
			}
		}
		// 数据源3
		if ("3".equals(genTable.getDataSource())) {
			try {
				pkList = genDataBaseDictDao3.findTablePK(genTable);
			} catch (Exception e) {
				pkList = new ArrayList<String>();
			}
		}
		// 数据源4
		if ("4".equals(genTable.getDataSource())) {
			try {
				pkList = genDataBaseDictDao4.findTablePK(genTable);
			} catch (Exception e) {
				pkList = new ArrayList<String>();
			}
		}
		// 数据源5
		if ("5".equals(genTable.getDataSource())) {
			try {
				pkList = genDataBaseDictDao5.findTablePK(genTable);
			} catch (Exception e) {
				pkList = new ArrayList<String>();
			}
		}
		
		return pkList;
	}
	
	/**
	 * 验证表名是否可用，如果已存在，则返回false
	 * @param genTable
	 * @return
	 */
	public boolean checkTableName(String tableName){
		if (StringUtils.isBlank(tableName)){
			return true;
		}
		GenTable genTable = new GenTable();
		genTable.setName(tableName);
		List<GenTable> list = genTableDao.findList(genTable);
		return list.size() == 0;
	}
	
	/**
	 * 获取物理数据表列表
	 * @param genTable
	 * @return
	 */
	public GenTable getTableFormDb(GenTable genTable){
		// 如果有表名，则获取物理表
		if (StringUtils.isNotBlank(genTable.getName())){
			
			List<GenTable> list = findTableListFormDb(genTable);
			if (list.size() > 0){
				
				// 如果是新增，初始化表属性
				if (StringUtils.isBlank(genTable.getId())){
					// 选择的数据源
					String dataSource = genTable.getDataSource();
					
					genTable = list.get(0);
					// 设置字段说明
					if (StringUtils.isBlank(genTable.getComments())){
						genTable.setComments(genTable.getName());
					}
					genTable.setClassName(StringUtils.toCapitalizeCamelCase(genTable.getName()));
					
					// 数据源保持
					genTable.setDataSource(dataSource);
				}
				
				// 添加新列
				List<GenTableColumn> columnList = findTableColumnListFormDb(genTable);
				for (GenTableColumn column : columnList){
					boolean b = false;
					for (GenTableColumn e : genTable.getColumnList()){
						if (e.getName().equals(column.getName())){
							b = true;
						}
					}
					if (!b){
						genTable.getColumnList().add(column);
					}
				}
				
				// 删除已删除的列
				for (GenTableColumn e : genTable.getColumnList()){
					boolean b = false;
					for (GenTableColumn column : columnList){
						if (column.getName().equals(e.getName())){
							b = true;
						}
					}
					if (!b){
						e.setDelFlag(GenTableColumn.DEL_FLAG_DELETE);
					}
				}
				
				// 获取主键
				genTable.setPkList(findTablePKFormDb(genTable));
				
				// 初始化列属性字段
				GenUtils.initColumnField(genTable);
				
			}
		}
		return genTable;
	}
	
	@Transactional(readOnly = false)
	public void save(GenTable genTable) {
		if (StringUtils.isBlank(genTable.getId())){
			genTable.preInsert();
			genTableDao.insert(genTable);
		}else{
			genTable.preUpdate();
			genTableDao.update(genTable);
		}
		// 保存列
		for (GenTableColumn column : genTable.getColumnList()){
			column.setGenTable(genTable);
			if (StringUtils.isBlank(column.getId())){
				column.preInsert();
				genTableColumnDao.insert(column);
			}else{
				column.preUpdate();
				genTableColumnDao.update(column);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(GenTable genTable) {
		genTableDao.delete(genTable);
		//genTableColumnDao.deleteByGenTableId(genTable.getId());
		
		// fixed by jeffen@pactera 2015/9/4
		//  java.sql.SQLException: ORA-12899: 列 "JEESITE"."GEN_TABLE_COLUMN"."DEL_FLAG" 的值太大 (实际值: 32, 最大值: 1)
		genTableColumnDao.deleteByGenTable(genTable);
	}
	
}
