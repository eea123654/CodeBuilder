package ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import ${package_name}.common.utils.DateUtils;
import ${package_name}.common.json.AjaxJson;
import ${package_name}.core.persistence.Page;
import ${package_name}.core.web.BaseController;
import ${package_name}.common.utils.StringUtils;
import ${package_name}.common.utils.excel.ExportExcel;
import ${package_name}.common.utils.excel.ImportExcel;
import ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>entity.${table_name};
import ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>service.${table_name}Service;


/**
* 描述：${table_name} 控制层
* @author ${author}
* @date ${date}
*/
@Controller
@RequestMapping(value = "${r'${adminPath}'}/<#if module_name?? && module_name != "">${module_name}/</#if><#if submodule_name?? && submodule_name != "">${submodule_name}/</#if>${table_name?uncap_first}")
public class ${table_name}Controller extends BaseController {

    @Autowired
	private ${table_name}Service ${table_name?uncap_first}Service;


    @ModelAttribute
	public ${table_name} get(@RequestParam(required=false) String id) {
        ${table_name} entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ${table_name?uncap_first}Service.get(id);
		}
		if (entity == null){
			entity = new ${table_name}();
		}
		return entity;
	}

    /**
	 * 列表页面
	 */
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:list")
	@RequestMapping(value = {"list", ""})
	public String list(${table_name} ${table_name?uncap_first}, Model model) {
		model.addAttribute("${table_name?uncap_first}", ${table_name?uncap_first});
		return "modules/<#if module_name?? && module_name != "">${module_name}/</#if><#if submodule_name?? && submodule_name != "">${submodule_name}/</#if>${table_name?uncap_first}List";
	}

    /**
	 * 列表数据
	 */
	@ResponseBody
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:list")
	@RequestMapping(value = "data")
	public Map<String, Object> data(${table_name} ${table_name?uncap_first}, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<${table_name}> page = ${table_name?uncap_first}Service.findPage(new Page<${table_name}>(request, response), ${table_name?uncap_first});
    return getBootstrapData(page);
    }

    /**
    * 查看，增加，编辑表单页面
    * params:
    * 	mode: add, edit, view, 代表三种模式的页面
    */
    @RequiresPermissions(value={"${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:view","${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:add","${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:edit"},logical=Logical.OR)
    @RequestMapping(value = "form/{mode}")
    public String form(@PathVariable String mode, ${table_name} ${table_name?uncap_first}, Model model) {
    model.addAttribute("mode", mode);
    model.addAttribute("${table_name?uncap_first}", ${table_name?uncap_first});
    return "modules/<#if module_name?? && module_name != "">${module_name}/</#if><#if submodule_name?? && submodule_name != "">${submodule_name}/</#if>${table_name?uncap_first}Form";
    }

    /**
    * 保存
    */
    @ResponseBody
    @RequiresPermissions(value={"${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:add","${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:edit"},logical=Logical.OR)
    @RequestMapping(value = "save")
    public AjaxJson save(${table_name} ${table_name?uncap_first}, Model model) throws Exception{
    AjaxJson j = new AjaxJson();
    /**
    * 后台hibernate-validation插件校验
    */
    String errMsg = beanValidator(${table_name?uncap_first});
    if (StringUtils.isNotBlank(errMsg)){
    j.setSuccess(false);
    j.setMsg(errMsg);
    return j;
    }
    //新增或编辑表单保存
    ${table_name?uncap_first}Service.save(${table_name?uncap_first});//保存
    j.setSuccess(true);
    j.setMsg("保存成功");
    return j;
    }


    /**
	 * 批量删除
	 */
	@ResponseBody
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:del")
	@RequestMapping(value = "delete")
	public AjaxJson delete(String ids) {
		AjaxJson j = new AjaxJson();
		String idArray[] =ids.split(",");
		for(String id : idArray){
        ${table_name?uncap_first}Service.delete(${table_name?uncap_first}Service.get(id));
		}
		j.setMsg("删除成功");
		return j;
	}

	/**
	 * 导出excel文件
	 */
	@ResponseBody
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:export")
    @RequestMapping(value = "export")
    public AjaxJson exportFile(${table_name} ${table_name?uncap_first}, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		try {
            String fileName = "${module_name}"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<${table_name}> page = ${table_name?uncap_first}Service.findPage(new Page<${table_name}>(request, response, -1), ${table_name?uncap_first});
    new ExportExcel("${module_name}", ${table_name}.class).setDataList(page.getList()).write(response, fileName).dispose();
    return null;
    } catch (Exception e) {
    j.setSuccess(false);
    j.setMsg("导出记录失败！失败信息："+e.getMessage());
    }
    return j;
    }

    /**
    * 导入Excel数据

    */
    @ResponseBody
    @RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:import")
    @RequestMapping(value = "import")
    public AjaxJson importFile(@RequestParam("file")MultipartFile file, HttpServletResponse response, HttpServletRequest request) {
    AjaxJson j = new AjaxJson();
    try {
    int successNum = 0;
    int failureNum = 0;
    StringBuilder failureMsg = new StringBuilder();
    ImportExcel ei = new ImportExcel(file, 1, 0);
    List<${table_name}> list = ei.getDataList(${table_name}.class);
        for (${table_name} ${table_name?uncap_first} : list){
        try{
        ${table_name?uncap_first}Service.save(${table_name?uncap_first});
        successNum++;
        }catch(ConstraintViolationException ex){
        failureNum++;
        }catch (Exception ex) {
        failureNum++;
        }
        }
        if (failureNum>0){
        failureMsg.insert(0, "，失败 "+failureNum+" 条记录。");
        }
        j.setMsg( "已成功导入 "+successNum+" 条记录"+failureMsg);
        } catch (Exception e) {
        j.setSuccess(false);
        j.setMsg("导入失败！失败信息："+e.getMessage());
        }
        return j;
        }

        /**
        * 下载导入数据模板
        */
        @ResponseBody
        @RequiresPermissions(""${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:import")
        @RequestMapping(value = "import/template")
        public AjaxJson importFileTemplate(HttpServletResponse response) {
        AjaxJson j = new AjaxJson();
        try {
        String fileName = "数据导入模板.xlsx";
        List<${table_name}> list = Lists.newArrayList();
            new ExportExcel("tttt数据", ${table_name}.class, 1).setDataList(list).write(response, fileName).dispose();
            return null;
            } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg( "导入模板下载失败！失败信息："+e.getMessage());
            }
            return j;
        }

    }
