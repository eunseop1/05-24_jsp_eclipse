<%@page import="kr.human.vo.TestDTO"%>
<%@page import="java.util.List"%>
<%@page import="kr.human.vo.TestVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="kr.human.ibatis.ibatisApp"%>
<%@page import="com.ibatis.sqlmap.client.SqlMapClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	SqlMapClient sqlMapClient = ibatisApp.getSqlMapClient();

	try{
		sqlMapClient.startTransaction();
		//------------------------------------
		String today = (String)sqlMapClient.queryForObject("test.selectToday"); //한개만 받을땐 오브젝트
		out.println("DB 날짜: "+today);		
		
		HashMap<String, Integer> map = new HashMap<>();
		map.put("num1", 12);
		map.put("num2", 34);
		TestVO testVO = (TestVO)sqlMapClient.queryForObject("test.testVO", map);
		
		out.println("<br>받은결과: "+ testVO);
		List<TestDTO> list = sqlMapClient.queryForList("test.selectList");
		out.println("<br>전체 " + list.size() + "개<br>");
		for(TestDTO dto : list){
			out.println(dto.getIdx() + ". " + dto.getName() + "<br>");
		}
		//저장
		
		TestDTO dto = new TestDTO();
		dto.setName("육인간");
		sqlMapClient.insert("test.insert",dto);
		
		TestDTO testDTO = (TestDTO)sqlMapClient.queryForObject("test.selectByIdx", 21);
        out.println("<br> 4번 데이터 : " + testDTO);
        
		//------------------------------------
		
		sqlMapClient.commitTransaction();
	}finally{
		sqlMapClient.endTransaction();
		//만약 coomit이 이뤄지지 않으면 자동으로 롤백해준다
	}
%>
</body>
</html>