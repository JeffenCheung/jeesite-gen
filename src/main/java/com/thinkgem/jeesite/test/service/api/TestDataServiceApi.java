package com.thinkgem.jeesite.test.service.api;

import java.io.IOException;
import java.util.List;

import javax.ws.rs.BeanParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.thinkgem.jeesite.test.entity.TestData;
import com.thinkgem.jeesite.test.entity.TestDatas;

@Path(value = "/test")
public interface TestDataServiceApi {

	@GET
	@Path("/get/{id}")
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public TestData get(@PathParam("id") String id);

	@POST
	@Path("/findList/{testData}")
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public List<TestData> findList(@FormParam("testData") TestData testData);
	
	@GET
	@Path("/findAllList/")
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public List<TestData> findAllList();
	
	@GET
	@Path("/findAggregation/")
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public TestDatas findAggregation(@javax.ws.rs.BeanParam @FormParam("testData") TestData testData) throws IOException;

	@GET
	@Path("/findAllAggregation/")
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public TestDatas findAllAggregation() throws IOException;

	@PUT
	@Path("/putData/{testData}")
	@Consumes({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public void save(TestData testData);

	@DELETE
	@Path("/removeData/{id}")
	public void delete(TestData testData);
}
