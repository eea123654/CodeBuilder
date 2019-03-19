<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>mapper.${table_name}Mapper">



    <sql id="${table_name?uncap_first}Columns">
        <#if model_column?exists>
            <#list model_column as model>
            a.${model.columnName} AS "${model.changeColumnName?uncap_first}",
            </#list>
        </#if>
    </sql>

    <sql id="${table_name?uncap_first}Joins">

    </sql>

    <select id="get" resultType="${table_name}" >
        SELECT
        <include refid="${table_name?uncap_first}Columns"/>
        FROM ${table_name_small} a
        <include refid="${table_name?uncap_first}Joins"/>
        WHERE a.id = ${r'#{id}'}
    </select>



    <select id="findList" resultType="${table_name}" >
        SELECT
        <include refid="${table_name?uncap_first}Columns"/>
        FROM ${table_name_small} a
        <include refid="${table_name?uncap_first}Joins"/>
        <where>

        ${r'${dataScope}'}<#-- hy注：不知道这是干什么用的，但jeeplus自动生成的代码有这个，所以我也保留了 -->

            <#list model_column as model>
                <#if model_index == 0>
                <if test="${model.changeColumnName?uncap_first} != null and ${model.changeColumnName?uncap_first} != ''">
                    a.${model.columnName} = ${r'#{'}${model.changeColumnName?uncap_first}},
                </if>
                <#else>
                <if test="${model.changeColumnName?uncap_first} != null and ${model.changeColumnName?uncap_first} != ''">
                AND a.${model.columnName} = ${r'#{'}${model.changeColumnName?uncap_first}},
                </if>
                </#if>
            </#list>

        </where>
        <choose>
            <when test="page !=null and page.orderBy != null and page.orderBy != ''">
                ORDER BY ${r'${page.orderBy}'}
            </when>
        <#--hy注： 目前固定隐藏此选项
        <otherwise>
            ORDER BY a.update_date DESC
        </otherwise>-->
        </choose>
    </select>


    <select id="findAllList" resultType="${table_name}" >
        SELECT
        <include refid="${table_name?uncap_first}Columns"/>
        FROM ${table_name_small} a
        <include refid="${table_name?uncap_first}Joins"/>
        <where>
        ${r'${dataScope}'}<#-- hy注：不知道这是干什么用的，但jeeplus自动生成的代码有这个，所以我也保留了 -->
        </where>
        <choose>
            <when test="page !=null and page.orderBy != null and page.orderBy != ''">
                ORDER BY ${r'${page.orderBy}'}
            </when>
            <#--hy注： 目前固定隐藏此选项
            <otherwise>
                ORDER BY a.update_date DESC
            </otherwise>-->
        </choose>
    </select>


    <insert id="insert">
        INSERT INTO ${table_name_small}(
        <#list model_column as model>
            ${model.columnName}<#if model_has_next>,</#if>
        </#list>
        ) VALUES (
        <#list model_column as model>
            ${r'#{'}${model.changeColumnName?uncap_first}}<#if model_has_next>,</#if>
        </#list>
        )
    </insert>


    <update id="update">
        UPDATE ${table_name_small} SET
         <#list model_column as model>
             <#if model.columnName != "id">
             ${model.columnName} =   ${r'#{'}${model.changeColumnName?uncap_first}}<#if model_has_next>,</#if>
             </#if>
         </#list>
        WHERE id = ${r'#{id}'}
    </update>


    <!--物理删除-->
    <update id="delete">
        DELETE FROM ${table_name_small}
        WHERE id = ${r'#{id}'}
    </update>

    <!--逻辑删除-->
    <update id="deleteByLogic">
        UPDATE ${table_name_small} SET
        del_flag = ${r'#{DEL_FLAG_DELETE}'}
        WHERE id = ${r'#{id}'}
    </update>


    <!-- 根据实体名称和字段名称和字段值获取唯一记录 -->
    <select id="findUniqueByProperty" resultType="${table_name}" statementType="STATEMENT">
        select * FROM ${table_name_small}  where ${r'${propertyName}'} = '${r'${value}'}'
    </select>



</mapper>