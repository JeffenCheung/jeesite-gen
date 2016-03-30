package com.thinkgem.jeesite;

import javax.ws.rs.core.MediaType;

import org.apache.cxf.jaxrs.client.WebClient;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.sun.tools.javac.util.List;
import com.thinkgem.jeesite.test.entity.TestData;
import com.thinkgem.jeesite.test.entity.TestDatas;
import com.thinkgem.jeesite.test.service.api.TestDataServiceApi;

/**
 * <b>function:</b> RESTful风格WebService client for gen project
 * 
 * @author jeffen
 * @createDate 2016/3/14
 * @file RSETServiceClientTestData.java
 * @package com.thinkgem.jeesite
 * @project CXFWebService
 * @blog http://
 * @email jeffencheung@gmail.com
 * @version 0.1
 */
public class RSETServiceClientTestData {

	protected Logger logger = LoggerFactory.getLogger(getClass()); // 日志对象
																	// 输出到日志文件

	private static ApplicationContext ctx; // 客户端配置
	private static WebClient client; // 客户端配置文件
	private static TestData req;
	private static TestData resp;
	private static TestDatas agg;
	private static java.util.List<TestData> list;
	private static String json;

	private static TestDataServiceApi service;

	@Before
	public void init() {

		// 从Spring Ioc容器中拿webClient对象
		ctx = new ClassPathXmlApplicationContext(
				"spring-context-cxf-client.xml");
		
		// 手动创建webClient对象
		String webClient = "genserviceClient_0.1";
		client = ctx.getBean(webClient, WebClient.class);
		logger.info("init()" + webClient);
	}

	@After
	public void destory() {
	}

	@Test
	public void testServiceBean() { // done
		try {
			service = ctx.getBean("testDataServiceBean"	//	直接使用Ico容器注入的接口中的方法
																					//	applicationContext-client.xml中增加配置testDataServiceBean
																					//	class org.apache.cxf.jaxrs.client.JAXRSClientFactory
						, TestDataServiceApi.class);
			resp = service.get("eb5d4bbc5ca5491b9cc1c46d3f9a9052");
			
			req = new TestData();
			req.setBeginInDate(new java.util.Date());
			req.setEndInDate(new java.util.Date());
			//agg = service.findAggregation(req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (resp != null)
			System.out.println("testServiceBean().get().response="
					+ resp.getName());
		if(agg != null)
			System.out.println("testServiceBean().findAggregation().response="
					+ agg);

	}

	@Test
	public void testGetJson() { // done
		try {
			json = client.path("test/get/69213c5083384a4ab8eb6b653a1e15b3")
					.accept(MediaType.APPLICATION_JSON_TYPE)	//	application/json
					.get(String.class);
			System.out.println("testGetJson().response=" + json);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Test
	public void testGetXML() { //	done
												//		annotation the XmlRootElement to bean
		try {
			resp = client
					.path("test/get/{id}", "fb8ee2057b8041c1b8b5f28c42c8ceb4")
					.accept(MediaType.APPLICATION_XML)	//	application/xml
					.get(TestData.class);
			System.out.println("testGetXML().response=" + resp);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Test
	public void testGet() {	//	done
		try {
			resp = client.path("test/get/eb4db65a5dbd40419b45cf08e7969b7d")
					.accept(MediaType.APPLICATION_XML)	//	application/xml
					.get(TestData.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (resp != null)
			System.out.println("testGet().response=" + resp.getName());
	}

	//@Test
	@SuppressWarnings("unchecked")
	public void testFindeAllList() {	//	NG:javax.ws.rs.NotFoundException
		try {
			req = new TestData();
			req.setBeginInDate(new java.util.Date());
			req.setEndInDate(new java.util.Date());
			list = client.path("test/findAllList/")
					.accept(MediaType.APPLICATION_XML)	//	application/xml
					.get(List.class);
			System.out.println("testFindeAllList().response=" + list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testFindAggregation() {	// NG:javax.ws.rs.InternalServerErrorException
		try {
			req = new TestData();
			req.setBeginInDate(new java.util.Date());
			req.setEndInDate(new java.util.Date());
			agg = client.path("test/findAllAggregation/")
					.accept(MediaType.APPLICATION_XML)	//	application/xml
					.get(TestDatas.class);
			System.out.println("testFindAggregation().response=" + agg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// @Test
	public void testPutData() {
		TestData e = new TestData();
		e.setName("testPutData1");
		e.setBeginInDate(new java.util.Date());

		TestData resp = client.path("tet/putData/")
				.accept(MediaType.APPLICATION_JSON).put(e, TestData.class);
		System.out.println("testPutData().response=" + resp);
	}

}
