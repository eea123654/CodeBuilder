package com.jeeplus.modules.${package_name}.mapper;

import org.springframework.stereotype.Repository;
import com.jeeplus.core.persistence.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import com.jeeplus.modules.${package_name}.entity.${table_name};

/**
 * ${table_name} MAPPER接口
 * @author ${author}
 * @version ${date}
 */
@Mapper
@Repository
public interface ${table_name}Mapper extends BaseMapper<${table_name}> {
	
}
