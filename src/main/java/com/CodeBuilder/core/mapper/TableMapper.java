package com.CodeBuilder.core.mapper;

import java.util.List;

import com.CodeBuilder.core.pojo.Table;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TableMapper {
    List<Table> findList();
}