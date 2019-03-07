package com.CodeBuilder.core.mapper;

import java.util.List;

import com.CodeBuilder.core.pojo.Client;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;


@Mapper
public interface ClientMapper {

    List<Client> findAll();

}