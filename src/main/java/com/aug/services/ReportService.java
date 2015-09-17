package com.aug.services;
import java.util.Collection;
import java.util.Map;

import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.jasperreports.JasperReportsMultiFormatView;

@Service("reportService")
public class ReportService {
	@Autowired private ApplicationContext appContext;
    @Autowired private DataSource dataSource;
   
    
    public ModelAndView getReport(Collection<?> beanCollection , String reportName,String reportType,Map<String,Object> parameterMap) {	
        JRDataSource JRdataSource = new JRBeanCollectionDataSource(beanCollection,false);
        parameterMap.put("datasource", JRdataSource);
        //parameterMap.put("JasperCustomSubReportDatasource", subDatasource);
        parameterMap.put("format", reportType);
        JasperReportsMultiFormatView view = new JasperReportsMultiFormatView();
        view.setJdbcDataSource(dataSource);
        view.setUrl("classpath:reports/"+reportName+".jasper");
        view.setApplicationContext(appContext);
        
        return new ModelAndView(view, parameterMap);
    }
}