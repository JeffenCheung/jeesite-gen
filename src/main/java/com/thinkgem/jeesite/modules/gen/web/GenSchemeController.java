/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.web;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.gen.entity.GenCategory;
import com.thinkgem.jeesite.modules.gen.entity.GenConfig;
import com.thinkgem.jeesite.modules.gen.entity.GenScheme;
import com.thinkgem.jeesite.modules.gen.service.GenSchemeService;
import com.thinkgem.jeesite.modules.gen.service.GenTableService;
import com.thinkgem.jeesite.modules.gen.util.GenUtils;

/**
 * 生成方案Controller
 * 
 * @author ThinkGem
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genScheme")
public class GenSchemeController extends BaseController {

	@Autowired
	private GenSchemeService genSchemeService;

	@Autowired
	private GenTableService genTableService;

	/**
	 * request mapping DTO
	 * 
	 * @author Jeffen@pactera
	 * @date 2015/6/10
	 * @since v1.2.8
	 * @param id
	 * @param category
	 * @return
	 */
	@ModelAttribute
	public GenScheme get(@RequestParam(required = false) String id,
			@RequestParam(required = false) String category) {
		GenScheme gs = new GenScheme();
		if (StringUtils.isNotBlank(id)) {
			gs = genSchemeService.get(id);
		}

		if (StringUtils.isBlank(category)) {
			// set default category 4 load config.xml
			category = "curd";
		}
		gs.setCategory(category);
		return gs;
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = { "list", "" })
	public String list(GenScheme genScheme, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()) {
			genScheme.setCreateBy(user);
		}
		Page<GenScheme> page = genSchemeService.find(new Page<GenScheme>(
				request, response), genScheme);
		model.addAttribute("page", page);

		return "modules/gen/genSchemeList";
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "form")
	public String form(GenScheme genScheme, Model model) {
		// update features fields by jeffen@pactera 2015/9/6 start
		if (StringUtils.isBlank(genScheme.getProjectPath())) {
			genScheme.setProjectPath(Global.getConfig("projectPath"));
		}
		// update features fields by jeffen@pactera 2015/9/6 end
		if (StringUtils.isBlank(genScheme.getPackageName())) {
			genScheme.setPackageName("com.thinkgem.jeesite.modules");
		}
		// if (StringUtils.isBlank(genScheme.getFunctionAuthor())){
		// genScheme.setFunctionAuthor(UserUtils.getUser().getName());
		// }
		model.addAttribute("genScheme", genScheme);

		// add template file select option by jeffen@pactera 2015/6/9 start
		GenConfig gc = GenUtils.getConfig();
		// 遍历config.xml配置文件分类
		for (GenCategory gci : gc.getCategoryList()) {
			if (!gci.getValue().equals(genScheme.getCategory()))
				continue;
			List<Dict> templateFiles = new ArrayList<Dict>();
			if (gci.getTemplate() != null)
				for (String t : gci.getTemplate()) {
					Dict d = new Dict();
					d.setLabel(t);
					d.setValue(t);
					templateFiles.add(d);
				}
			if (gci.getChildTableTemplate() != null)
				for (String t : gci.getChildTableTemplate()) {
					Dict d = new Dict();
					d.setLabel(t);
					d.setValue(t);
					templateFiles.add(d);
				}
			// 更新模版文件清单下拉列表
			gc.setTemplateFiles(templateFiles);
		}
		// add template file select option by jeffen@pactera 2015/6/9 end

		model.addAttribute("config", gc);
		model.addAttribute("tableList", genTableService.findAll());
		return "modules/gen/genSchemeForm";
	}

	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "save")
	public String save(GenScheme genScheme, Model model,
			RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage4DemoMode(redirectAttributes);
			return "redirect:" + adminPath + "/gen/genScheme/?repage";
		}
		if (!beanValidator(model, genScheme)) {
			return form(genScheme, model);
		}

		String result = genSchemeService.save(genScheme);
		addMessage(redirectAttributes, "操作生成方案'" + genScheme.getName()
				+ "'成功<br/>" + result);
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}

	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "delete")
	public String delete(GenScheme genScheme,
			RedirectAttributes redirectAttributes) {

		if(Global.isDemoMode()){
			addMessage4DemoMode(redirectAttributes);
			return "redirect:" + adminPath + "/gen/genScheme/?repage";
		}
		genSchemeService.delete(genScheme);
		addMessage(redirectAttributes, "删除生成方案成功");
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}

}
