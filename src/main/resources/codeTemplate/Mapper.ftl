<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${package_name}.repository.mybatis.${table_name}DAO">


    <sql id="oaLzyTestColumns">
        <#if model_column?exists>
            <#list model_column as model>
            a.id AS "id",
            </#list>
        </#if>
    </sql>



    <resultMap id="${table_name}DTOResultMap" type="${package_name}.dto.${table_name}DTO"></resultMap>

    <sql id="findDtoSql">
        select * from (
        select * from  ${table_name_small} temp
        ) t
    </sql>

    <select id="findDTOById" parameterType="String" resultMap="${table_name}DTOResultMap">
        <include refid="findDtoSql"></include>
        <where>
            and t.id = ${r'#{id}'}
        </where>
    </select>

    <select id="find${table_name}Page" parameterType="${package_name}.dto.${table_name}DTO" resultMap="${table_name}DTOResultMap">
        <include refid="findDtoSql" />
        <where>

        </where>
    </select>

</mapper>
