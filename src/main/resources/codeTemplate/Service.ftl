
package ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${package_name}.core.persistence.Page;
import ${package_name}.core.service.CrudService;
import ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>entity.${table_name};
import ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>mapper.${table_name}Mapper;

/**
* 描述：${table_name} Service层
* @author ${author}
* @date ${date}
*/
@Service
@Transactional(readOnly = true)
public class ${table_name}Service extends CrudService<${table_name}Mapper, ${table_name}> {

	public ${table_name} get(String id) {
		return super.get(id);
	}

	public List<${table_name}> findList(${table_name} ${table_name?uncap_first}) {
    return super.findList(${table_name?uncap_first});
    }

    public Page<${table_name}> findPage(Page<${table_name}> page, ${table_name} ${table_name?uncap_first}) {
        return super.findPage(page, ${table_name?uncap_first});
    }

    @Transactional(readOnly = false)
    public void save(${table_name} ${table_name?uncap_first}) {
        super.save(${table_name?uncap_first});
    }

    @Transactional(readOnly = false)
    public void delete(${table_name} ${table_name?uncap_first}) {
        super.delete(${table_name?uncap_first});
    }

}