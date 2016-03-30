/**
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.test.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.utils.MutiLangUtils;
import com.thinkgem.jeesite.test.entity.TestData;
import com.thinkgem.jeesite.test.service.TestDataService;

import javax.validation.ConstraintViolationException;
import org.springframework.web.multipart.MultipartFile;
import com.orangesignal.csv.CsvConfig;
import com.orangesignal.csv.manager.CsvEntityManager;
import com.orangesignal.csv.manager.CsvSaver;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.Encodes;
/**
 * 单表生成Controller
 * @author Jeffen@pactera
 * @version 2015-10-10
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testData")
public class TestDataController extends BaseController {

	public static final String URL_ADMIN_REPAGE = "redirect:"+Global.getAdminPath()+"/test/testData/?repage";
	public static final String URL_MODULE_LIST = "jeesite/test/testDataList";
	public static final String URL_MODULE_FORM = "jeesite/test/testDataForm";
	
	public static final String PERMISSION_VIEW = "test:testData:view";
	public static final String PERMISSION_EDIT = "test:testData:edit";
	public static final String PERMISSION_DBA = "test:testData:dba";
	public static final String PERMISSION_IO = "test:testData:io";
	
	@Autowired
	private TestDataService testDataService;
	
	@ModelAttribute
	public TestData get(@RequestParam(required=false) String id) {
		TestData entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = testDataService.get(id);
		}
		if (entity == null){
			entity = new TestData();
		}
		return entity;
	}
	
	/**
	 * 异步取得[名称]列表
	 * @param query
	 * @return
	 */
	@RequestMapping(value = "getNameList", method = RequestMethod.GET)
	public @ResponseBody List<TestData> getNameList(@RequestParam("term") String query) {
		TestData testData = new TestData();
		testData.setName(query);
		testData.getPage().setPageSize(Integer.valueOf(Global.getConfig("autocomplete.menuSize")));
		List<TestData> nameList= testDataService.findList(testData);
		return nameList;
	}
	
	@RequiresPermissions(PERMISSION_VIEW)
	@RequestMapping(value = {"list", ""})
	public String list(TestData testData, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestData> page = testDataService.findPage(new Page<TestData>(request, response), testData); 
		model.addAttribute("page", page);
		return URL_MODULE_LIST;
	}

	@RequiresPermissions(PERMISSION_VIEW)
	@RequestMapping(value = "form")
	public String form(TestData testData, Model model) {
		model.addAttribute("testData", testData);
		return URL_MODULE_FORM;
	}

	@RequiresPermissions(PERMISSION_EDIT)
	@RequestMapping(value = "save")
	public String save(TestData testData, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testData)){
			return form(testData, model);
		}
		testDataService.save(testData);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.save.success.param", "【单表】"));
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_EDIT)
	@RequestMapping(value = "delete")
	public String delete(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.delete(testData);
		String physicalDelete = testData.getPhysicalDelete().booleanValue()?" <span class='text-warning'>[注：物理删除]</span>":"";
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.delete.success.param", "【单表】") + physicalDelete);
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_EDIT)
	@RequestMapping(value = "deleteChecked")
	public String deleteChecked(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.deleteList(testData);
		String physicalDelete = testData.getPhysicalDelete().booleanValue()?" <span class='text-warning'>[注：物理删除]</span>":"";
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.delete.success.param", "【单表】") + " （共批量删除 " + testData.getCbRowDataIds().size() + " 条数据）" + physicalDelete);
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_DBA)
	@RequestMapping(value = "truncateTable")
	public String truncateTable(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.truncateTable(testData);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.delete.success.param", "【单表，<span class='text-warning'>物理清空</span>】"));
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_DBA)
	@RequestMapping(value = "copy")
	public String copy(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.copy(testData);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.copy.success.param", "【单表】"));
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_DBA)
	@RequestMapping(value = "copyChecked")
	public String copyChecked(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.copyList(testData);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.copy.success.param", "【单表】") + " （共批量复制 " + testData.getCbRowDataIds().size() + " 条数据）");
		return URL_ADMIN_REPAGE;
	}
	
	/**
	 * 导出CSV数据
	 * @param testData
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(PERMISSION_IO)
	@RequestMapping(value = "export/csv", method = RequestMethod.POST)
	public String exportCsvFile(TestData testData, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "【单表】" + DateUtils.getDateTimeTight() + ".csv";
			List<TestData> lst = testDataService.findList(testData);
			CsvEntityManager cet = new CsvEntityManager(new CsvConfig(
					CsvConfig.DEFAULT_SEPARATOR));
			CsvSaver csvSaver = null;
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename="
					+ Encodes.urlEncode(fileName));
			csvSaver = cet.save(lst, TestData.class);
			csvSaver.to(response.getOutputStream());
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出单表失败！失败信息：" + e.getMessage());
		}
		return URL_ADMIN_REPAGE;
	}

	/**
	 * 导入CSV数据
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(PERMISSION_IO)
	@RequestMapping(value = "import/csv", method = RequestMethod.POST)
	public String importCsvFile(MultipartFile file,
			RedirectAttributes redirectAttributes) throws Exception {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath()
					+ "/test/testData/?repage";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			if (StringUtils.isBlank(file.getOriginalFilename())) {
				throw new RuntimeException("导入文档为空!");
			} else if (!file.getOriginalFilename().toLowerCase()
					.endsWith("csv")) {
				throw new RuntimeException("文档格式不正确!");
			} else {
				List<TestData> list = new CsvEntityManager().load(
						TestData.class).from(file.getInputStream());
				long i = 0;
				for (TestData testData : list) {

					try {
						BeanValidators.validateWithException(validator, testData);
						testDataService.save(testData);
						successNum++;
						++i;
					} catch (ConstraintViolationException ex) {
						failureMsg.append("<br/>CSV数据第" + i + "行导入失败：");
						List<String> messageList = BeanValidators
								.extractPropertyAndMessageAsList(ex, ": ");
						for (String message : messageList) {
							failureMsg.append(message + "; ");
							failureNum++;
						}
					} catch (Exception ex) {
						failureMsg.append("<br/>导入CSV数据失败：" + ex.getMessage());
					}
				}
				if (failureNum > 0) {
					failureMsg.insert(0, "，失败 " + failureNum + " 条数据，导入信息如下：");
				}
				addMessage(redirectAttributes, "已成功导入 " + successNum
						+ " 条CSV数据" + failureMsg);
			}
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入CSV数据失败！失败信息：" + e.getMessage());
		}
		return URL_ADMIN_REPAGE;
	}

	/**
	 * 下载导入CSV数据的模板
	 * 
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(PERMISSION_IO)
	@RequestMapping(value = "import/csv/template")
	public String importCsvFileTemplate(HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "【单表】数据导入模板.csv";

			List<TestData> list = new ArrayList();
			TestData testData = new TestData();
			//testData = testData.getSinglePoJoByDefaultValue();
			list.add(testData);

			CsvEntityManager cet = new CsvEntityManager();
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename="
					+ Encodes.urlEncode(fileName));
			cet.save(list, TestData.class).to(response.getOutputStream());
			return null;

		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return URL_ADMIN_REPAGE;
	}
	
}