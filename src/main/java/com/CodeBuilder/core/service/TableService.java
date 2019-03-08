package com.CodeBuilder.core.service;

import com.CodeBuilder.core.mapper.TableMapper;
import com.CodeBuilder.core.pojo.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableService {
    @Autowired
    TableMapper tableMapper;

    public List<Table> findList() {
        return tableMapper.findList();
    }

}
