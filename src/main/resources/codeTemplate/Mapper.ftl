package ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>mapper;

import org.springframework.stereotype.Repository;
import ${package_name}.core.persistence.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import ${package_name}.modules.${package_name}.entity.${table_name};

/**
 * ${table_name} MAPPER接口
 * @author ${author}
 * @version ${date}
 */
@Mapper
@Repository
public interface ${table_name}Mapper extends BaseMapper<${table_name}> {
	
}
