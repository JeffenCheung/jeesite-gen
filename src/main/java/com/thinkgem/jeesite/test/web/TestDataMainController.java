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
import com.thinkgem.jeesite.test.entity.TestDataMain;
import com.thinkgem.jeesite.test.service.TestDataMainService;

import javax.validation.ConstraintViolationException;
import org.springframework.web.multipart.MultipartFile;

import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.Encodes;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
/**
 * 主子表生成Controller
 * @author Jeffen@pactera
 * @version 2015-10-10
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testDataMain")
public class TestDataMainController extends BaseController {

	public static final String URL_ADMIN_REPAGE = "redirect:"+Global.getAdminPath()+"/test/testDataMain/?repage";
	public static final String URL_MODULE_LIST = "jeesite/test/testDataMainList";
	public static final String URL_MODULE_FORM = "jeesite/test/testDataMainForm";
	
	public static final String PERMISSION_VIEW = "test:testDataMain:view";
	public static final String PERMISSION_EDIT = "test:testDataMain:edit";
	public static final String PERMISSION_DBA = "test:testDataMain:dba";
	public static final String PERMISSION_IO = "test:testDataMain:io";
	
	@Autowired
	private TestDataMainService testDataMainService;
	
	@ModelAttribute
	public TestDataMain get(@RequestParam(required=false) String id) {
		TestDataMain entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = testDataMainService.get(id);
		}
		if (entity == null){
			entity = new TestDataMain();
		}
		return entity;
	}
	
	
	@RequiresPermissions(PERMISSION_VIEW)
	@RequestMapping(value = {"list", ""})
	public String list(TestDataMain testDataMain, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestDataMain> page = testDataMainService.findPage(new Page<TestDataMain>(request, response), testDataMain); 
		model.addAttribute("page", page);
		return URL_MODULE_LIST;
	}

	@RequiresPermissions(PERMISSION_VIEW)
	@RequestMapping(value = "form")
	public String form(TestDataMain testDataMain, Model model) {
		model.addAttribute("testDataMain", testDataMain);
		return URL_MODULE_FORM;
	}

	@RequiresPermissions(PERMISSION_EDIT)
	@RequestMapping(value = "save")
	public String save(TestDataMain testDataMain, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testDataMain)){
			return form(testDataMain, model);
		}
		testDataMainService.save(testDataMain);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.save.success.param", "【主子表】"));
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_EDIT)
	@RequestMapping(value = "delete")
	public String delete(TestDataMain testDataMain, RedirectAttributes redirectAttributes) {
		testDataMainService.delete(testDataMain);
		String physicalDelete = testDataMain.getPhysicalDelete().booleanValue()?" <span class='text-warning'>[注：物理删除]</span>":"";
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.delete.success.param", "【主子表】") + physicalDelete);
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_EDIT)
	@RequestMapping(value = "deleteChecked")
	public String deleteChecked(TestDataMain testDataMain, RedirectAttributes redirectAttributes) {
		testDataMainService.deleteList(testDataMain);
		String physicalDelete = testDataMain.getPhysicalDelete().booleanValue()?" <span class='text-warning'>[注：物理删除]</span>":"";
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.delete.success.param", "【主子表】") + " （共批量删除 " + testDataMain.getCbRowDataIds().size() + " 条数据）" + physicalDelete);
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_DBA)
	@RequestMapping(value = "truncateTable")
	public String truncateTable(TestDataMain testDataMain, RedirectAttributes redirectAttributes) {
		testDataMainService.truncateTable(testDataMain);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.delete.success.param", "【主子表，<span class='text-warning'>物理清空</span>】"));
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_DBA)
	@RequestMapping(value = "copy")
	public String copy(TestDataMain testDataMain, RedirectAttributes redirectAttributes) {
		testDataMainService.copy(testDataMain);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.copy.success.param", "【主子表】"));
		return URL_ADMIN_REPAGE;
	}
	
	@RequiresPermissions(PERMISSION_DBA)
	@RequestMapping(value = "copyChecked")
	public String copyChecked(TestDataMain testDataMain, RedirectAttributes redirectAttributes) {
		testDataMainService.copyList(testDataMain);
		addMessage(redirectAttributes, MutiLangUtils.getLang("common.copy.success.param", "【主子表】") + " （共批量复制 " + testDataMain.getCbRowDataIds().size() + " 条数据）");
		return URL_ADMIN_REPAGE;
	}
	
	
	/**
	 * 导出Excel数据
	 * @param testDataMain
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(PERMISSION_IO)
	@RequestMapping(value = "export/excel", method = RequestMethod.POST)
	public String exportExcelFile(TestDataMain testDataMain, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "【主子表】" + DateUtils.getDateTimeTight() + ".xlsx";
			List<TestDataMain> lst = testDataMainService.findList(testDataMain);
			new ExportExcel("主子表", TestDataMain.class).setDataList(lst).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出主子表失败！失败信息：" + e.getMessage());
		}
		return URL_ADMIN_REPAGE;
	}

	/**
	 * 导入Excel数据
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(PERMISSION_IO)
	@RequestMapping(value = "import/excel", method = RequestMethod.POST)
	public String importExcelFile(MultipartFile file,
			RedirectAttributes redirectAttributes) throws Exception {
		if (Global.isDemoMode()) {
			addMessage4DemoMode(redirectAttributes);
			return "redirect:" + Global.getAdminPath()
					+ "/test/testDataMain/?repage";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			if (StringUtils.isBlank(file.getOriginalFilename())) {
				throw new RuntimeException("导入文档为空!");
			} else if (!file.getOriginalFilename().toLowerCase()
					.endsWith("xlsx")) {
				throw new RuntimeException("文档格式不正确!");
			} else {
				ImportExcel ei = new ImportExcel(file, 1, 0);
				List<TestDataMain> list = ei.getDataList(TestDataMain.class);
				long i = 0;
				for (TestDataMain testDataMain : list) {

					try {
						BeanValidators.validateWithException(validator, testDataMain);
						testDataMainService.save(testDataMain);
						successNum++;
						++i;
					} catch (ConstraintViolationException ex) {
						failureMsg.append("<br/>Excel数据第" + i + "行导入失败：");
						List<String> messageList = BeanValidators
								.extractPropertyAndMessageAsList(ex, ": ");
						for (String message : messageList) {
							failureMsg.append(message + "; ");
							failureNum++;
						}
					} catch (Exception ex) {
						failureMsg.append("<br/>导入Excel数据失败：" + ex.getMessage());
					}
				}
				if (failureNum > 0) {
					failureMsg.insert(0, "，失败 " + failureNum + " 条数据，导入信息如下：");
				}
				addMessage(redirectAttributes, "已成功导入 " + successNum
						+ " 条Excel数据" + failureMsg);
			}
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入Excel数据失败！失败信息：" + e.getMessage());
		}
		return URL_ADMIN_REPAGE;
	}

	/**
	 * 下载导入Excel数据的模板
	 * 
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions(PERMISSION_IO)
	@RequestMapping(value = "import/excel/template")
	public String importExcelFileTemplate(HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "【主子表】数据导入模板.xlsx";

			List<TestDataMain> list = new ArrayList();
			TestDataMain testDataMain = new TestDataMain();
			//testDataMain = testDataMain.getSinglePoJoByDefaultValue();
			list.add(testDataMain);

			new ExportExcel("主子表", TestDataMain.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;

		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return URL_ADMIN_REPAGE;
	}
}