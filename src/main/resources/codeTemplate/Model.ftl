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
    private String ${model.changeColumnName?uncap_first};  //${model.columnComment!}
        </#if>
        <#if model.columnType = 'TIMESTAMP' || model.columnType = 'DATETIME' >
    private Date ${model.changeColumnName?uncap_first};  //${model.columnComment!}
        </#if>
    </#list>
</#if>

    public ${table_name}(){
        super();
    }

    public ${table_name}(String id){
        super(id);
    }

<#if model_column?exists>
    <#list model_column as model>
        <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT')>
    @ExcelField(title="${model.changeColumnName?uncap_first}", align=2, sort=${model_index+1})
    public String get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(String ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

        </#if>
        <#if model.columnType = 'TIMESTAMP' || model.columnType = 'DATETIME'  >
    @ExcelField(title="${model.changeColumnName?uncap_first}", align=2, sort=${model_index+1})
    public Date get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Date ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

        </#if>
    </#list>
</#if>

}