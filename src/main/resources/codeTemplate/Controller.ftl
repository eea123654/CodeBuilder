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
	private ${table_name}Service ${table_name?uncap_first}Service; <#if ishxmodel=="true">//注入${table_name}的service</#if>


    @ModelAttribute
	public ${table_name} get(@RequestParam(required=false) String id) {
        ${table_name} entity = null; <#if ishxmodel=="true">//定义${table_name}的变量</#if>
		if (StringUtils.isNotBlank(id)){ <#if ishxmodel=="true">//判断传入id不为空</#if>
			entity = ${table_name?uncap_first}Service.get(id); <#if ishxmodel=="true">//为${table_name}实体类赋值</#if>
		}
		if (entity == null){ <#if ishxmodel=="true">//查询不到的情况</#if>
			entity = new ${table_name}(); <#if ishxmodel=="true">//实例化一个${table_name}的实体类</#if>
		}
		return entity; <#if ishxmodel=="true">//返回${table_name}的实体类</#if>
	}

    /**
	 * 列表页面
	 */
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:list")
	@RequestMapping(value = {"list", ""})
	public String list(${table_name} ${table_name?uncap_first}, Model model) {
		model.addAttribute("${table_name?uncap_first}", ${table_name?uncap_first});  <#if ishxmodel=="true">//向前台传递${table_name?uncap_first}数据</#if>
		return "modules/<#if module_name?? && module_name != "">${module_name}/</#if><#if submodule_name?? && submodule_name != "">${submodule_name}/</#if>${table_name?uncap_first}List"; <#if ishxmodel=="true">//返回${table_name?uncap_first}List视图</#if>
	}

    /**
	 * 列表数据
	 */
	@ResponseBody
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:list")
	@RequestMapping(value = "data")
	public Map<String, Object> data(${table_name} ${table_name?uncap_first}, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<${table_name}> page = ${table_name?uncap_first}Service.findPage(new Page<${table_name}>(request, response), ${table_name?uncap_first});   <#if ishxmodel=="true">//查询${table_name?uncap_first}列表数据</#if>
        return getBootstrapData(page); <#if ishxmodel=="true">//返回${table_name}的分页类</#if>
    }

    /**
    * 查看，增加，编辑表单页面
    * params:
    * 	mode: add, edit, view, 代表三种模式的页面
    */
    @RequiresPermissions(value={"${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:view","${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:add","${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:edit"},logical=Logical.OR)
    @RequestMapping(value = "form/{mode}")
    public String form(@PathVariable String mode, ${table_name} ${table_name?uncap_first}, Model model) {
    model.addAttribute("mode", mode); <#if ishxmodel=="true">//向前台传递mode数据</#if>
    model.addAttribute("${table_name?uncap_first}", ${table_name?uncap_first}); <#if ishxmodel=="true">//向前台传递${table_name?uncap_first}数据</#if>
    return "modules/<#if module_name?? && module_name != "">${module_name}/</#if><#if submodule_name?? && submodule_name != "">${submodule_name}/</#if>${table_name?uncap_first}Form"; <#if ishxmodel=="true">//返回${table_name?uncap_first}Form视图</#if>
    }

    /**
    * 保存
    */
    @ResponseBody
    @RequiresPermissions(value={"${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:add","${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:edit"},logical=Logical.OR)
    @RequestMapping(value = "save")
    public AjaxJson save(${table_name} ${table_name?uncap_first}, Model model) throws Exception{
    AjaxJson j = new AjaxJson(); <#if ishxmodel=="true">//创建AjaxJson对象</#if>
    /**
    * 后台hibernate-validation插件校验
    */
    String errMsg = beanValidator(${table_name?uncap_first}); <#if ishxmodel=="true">//创建errMsg变量，用来存储错误信息</#if>
    if (StringUtils.isNotBlank(errMsg)){ <#if ishxmodel=="true">//当errMsg变量不为空</#if>
    j.setSuccess(false); <#if ishxmodel=="true">//将AjaxJson对象的success属性设置为false</#if>
    j.setMsg(errMsg); <#if ishxmodel=="true">//将AjaxJson对象的msg属性设置为errMsg的值</#if>
    return j; <#if ishxmodel=="true">//返回AjaxJson对象</#if>
    }
    //新增或编辑表单保存
    ${table_name?uncap_first}Service.save(${table_name?uncap_first}); <#if ishxmodel=="true">//保存${table_name?uncap_first}对象</#if>
    j.setSuccess(true); <#if ishxmodel=="true">//将AjaxJson对象的success属性设置为true</#if>
    j.setMsg("保存成功"); <#if ishxmodel=="true">//将AjaxJson对象的msg属性设置为保存成功</#if>
    return j; <#if ishxmodel=="true">//返回AjaxJson对象</#if>
    }


    /**
	 * 批量删除
	 */
	@ResponseBody
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:del")
	@RequestMapping(value = "delete")
	public AjaxJson delete(String ids) {
		AjaxJson j = new AjaxJson(); <#if ishxmodel=="true">//创建AjaxJson对象</#if>
		String idArray[] =ids.split(","); <#if ishxmodel=="true">//创建id数组</#if>
		for(String id : idArray){ <#if ishxmodel=="true">//循环id数组</#if>
        ${table_name?uncap_first}Service.delete(${table_name?uncap_first}Service.get(id)); <#if ishxmodel=="true">//根据id来删除${table_name?uncap_first}</#if>
		}
		j.setMsg("删除成功"); <#if ishxmodel=="true">//设置AjaxJson对象的msg属性</#if>
		return j; <#if ishxmodel=="true">//返回AjaxJson对象</#if>
	}

	/**
	 * 导出excel文件
	 */
	@ResponseBody
	@RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:export")
    @RequestMapping(value = "export")
    public AjaxJson exportFile(${table_name} ${table_name?uncap_first}, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson(); <#if ishxmodel=="true">//创建AjaxJson对象</#if>
		try {
            String fileName = "${module_name}"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; <#if ishxmodel=="true">//创建文件名称</#if>
            Page<${table_name}> page = ${table_name?uncap_first}Service.findPage(new Page<${table_name}>(request, response, -1), ${table_name?uncap_first}); <#if ishxmodel=="true">//创建${table_name}分页类</#if>
            new ExportExcel("${module_name}", ${table_name}.class).setDataList(page.getList()).write(response, fileName).dispose(); <#if ishxmodel=="true">//创建ExportExcel类</#if>
            return null;
        } catch (Exception e) {
        j.setSuccess(false); <#if ishxmodel=="true">//将AjaxJson对象的success属性设置为false</#if>
        j.setMsg("导出记录失败！失败信息："+e.getMessage()); <#if ishxmodel=="true">//设置AjaxJson对象的msg属性</#if>
        }
        return j; <#if ishxmodel=="true">//返回AjaxJson对象</#if>
    }

    /**
    * 导入Excel数据

    */
    @ResponseBody
    @RequiresPermissions("${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:import")
    @RequestMapping(value = "import")
    public AjaxJson importFile(@RequestParam("file")MultipartFile file, HttpServletResponse response, HttpServletRequest request) {
    AjaxJson j = new AjaxJson(); <#if ishxmodel=="true">//创建AjaxJson对象</#if>
    try {
    int successNum = 0; <#if ishxmodel=="true">//创建successNum变量。存放导入成功的数量</#if>
    int failureNum = 0; <#if ishxmodel=="true">//创建failureNum变量。存放导入失败的数量</#if>
    StringBuilder failureMsg = new StringBuilder(); <#if ishxmodel=="true">//创建StringBuilder对象</#if>
    ImportExcel ei = new ImportExcel(file, 1, 0); <#if ishxmodel=="true">//创建ImportExcel对象</#if>
    List<${table_name}> list = ei.getDataList(${table_name}.class); <#if ishxmodel=="true">//获取List</#if>
        for (${table_name} ${table_name?uncap_first} : list){ <#if ishxmodel=="true">//循环List</#if>
        try{
        ${table_name?uncap_first}Service.save(${table_name?uncap_first}); <#if ishxmodel=="true">//保存${table_name?uncap_first}对象</#if>
        successNum++; <#if ishxmodel=="true">//successNum自增</#if>
        }catch(ConstraintViolationException ex){ <#if ishxmodel=="true">//如果捕获ConstraintViolationException异常</#if>
        failureNum++; <#if ishxmodel=="true">//failureNum自增</#if>
        }catch (Exception ex) { <#if ishxmodel=="true">//如果捕获其他异常</#if>
        failureNum++; <#if ishxmodel=="true">//failureNum自增</#if>
        }
        }
        if (failureNum>0){ <#if ishxmodel=="true">//如果failureNum大于0</#if>
        failureMsg.insert(0, "，失败 "+failureNum+" 条记录。"); <#if ishxmodel=="true">//记录失败数量</#if>
        }
        j.setMsg( "已成功导入 "+successNum+" 条记录"+failureMsg); <#if ishxmodel=="true">//记录成功数量</#if>
        } catch (Exception e) { <#if ishxmodel=="true">//如果捕获其他异常</#if>
        j.setSuccess(false); <#if ishxmodel=="true">//将AjaxJson对象的success属性设置为false</#if>
        j.setMsg("导入失败！失败信息："+e.getMessage()); <#if ishxmodel=="true">//设置AjaxJson对象的msg属性</#if>
        }
        return j; <#if ishxmodel=="true">//返回AjaxJson对象</#if>
        }

    /**
    * 下载导入数据模板
    */
    @ResponseBody
    @RequiresPermissions(""${module_name}:<#if submodule_name?? && submodule_name != "">${submodule_name}:</#if>${table_name?uncap_first}:import")
    @RequestMapping(value = "import/template")
    public AjaxJson importFileTemplate(HttpServletResponse response) {
        AjaxJson j = new AjaxJson(); <#if ishxmodel=="true">//创建AjaxJson对象</#if>
        try {
        String fileName = "数据导入模板.xlsx"; <#if ishxmodel=="true">//定义模板文件名称</#if>
        List<${table_name}> list = Lists.newArrayList(); <#if ishxmodel=="true">//定义${table_name}list</#if>
            new ExportExcel("${table_name}数据", ${table_name}.class, 1).setDataList(list).write(response, fileName).dispose(); <#if ishxmodel=="true">//创建ExportExcel类</#if>
            return null;
            } catch (Exception e) { <#if ishxmodel=="true">//如果捕获到异常</#if>
            j.setSuccess(false); <#if ishxmodel=="true">//将AjaxJson对象的success属性设置为false</#if>
            j.setMsg( "导入模板下载失败！失败信息："+e.getMessage()); <#if ishxmodel=="true">//设置AjaxJson对象的msg属性</#if>
            }
            return j; <#if ishxmodel=="true">//返回AjaxJson对象</#if>
        }

    }