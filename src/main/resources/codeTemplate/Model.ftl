package ${package_name}.modules.<#if module_name?? && module_name != "">${module_name}.</#if><#if submodule_name?? && submodule_name != "">${submodule_name}.</#if>entity;

import ${package_name}.core.persistence.DataEntity;
import ${package_name}.common.utils.excel.annotation.ExcelField;

/**
* 描述：${table_annotation}实体类
* @author ${author}
* @date ${date}
*/


public class ${table_name} extends DataEntity<${table_name}>  {

    private static final long serialVersionUID = 1L;

<#if model_column?exists>
    <#list model_column as model>
    <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT')>
    <#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性</#if>
    private String ${model.changeColumnName?uncap_first};  <#if model.columnComment?? && model.columnComment != "">//${model.columnComment!}</#if>
    </#if>
    <#if model.columnType = 'TIMESTAMP' || model.columnType = 'DATETIME' ><#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性</#if>
    private Date ${model.changeColumnName?uncap_first};  <#if model.columnComment?? && model.columnComment != "">//${model.columnComment!}</#if>
    </#if>
    </#list>
</#if>
    <#if ishxmodel=="true">//构造方法</#if>
    public ${table_name}(){
        super(); <#if ishxmodel=="true">//父类的构造方法</#if>
    }
    <#if ishxmodel=="true">//带id的构造方法</#if>
    public ${table_name}(String id){
        super(id); <#if ishxmodel=="true">//父类的构造方法</#if>
    }

<#if model_column?exists>
    <#list model_column as model>
        <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT')>
    @ExcelField(title="${model.changeColumnName?uncap_first}", align=2, sort=${model_index+1})
    <#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性的get方法</#if>
    public String get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first}; <#if ishxmodel=="true">//返回${model.changeColumnName?uncap_first}属性</#if>
    }
    <#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性的set方法</#if>
    public void set${model.changeColumnName}(String ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first}; <#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性</#if>
    }

        </#if>
        <#if model.columnType = 'TIMESTAMP' || model.columnType = 'DATETIME'  >
    @ExcelField(title="${model.changeColumnName?uncap_first}", align=2, sort=${model_index+1})
    <#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性的get方法</#if>
    public Date get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first}; <#if ishxmodel=="true">//返回${model.changeColumnName?uncap_first}属性</#if>
    }
    <#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性的set方法</#if>
    public void set${model.changeColumnName}(Date ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first}; <#if ishxmodel=="true">//设置${model.changeColumnName?uncap_first}属性</#if>
    }

        </#if>
    </#list>
</#if>

}