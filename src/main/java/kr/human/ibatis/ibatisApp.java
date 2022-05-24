package kr.human.ibatis;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class ibatisApp {
	//정적 멤버는 클래스가 로드될때 자동으로 메모리에 올라온다
	//올라오기전에 정적 초기화가 먼저 올라온다 -> 올라온 대로 사용한다
	private static SqlMapClient sqlMapClient; //한줄로 초기화 되지 않기에
	
	//한줄로 정적 멤버를 초기화 할수 없을때는 정적 초기화 블록을 이용한다
	//블록 안에서 필요한 것을 읽어서 클라이언트를 만들고 초기화한 다음
	static {
		String resource = "SqlMapConfig.xml";
		Reader reader = null;		
		try {
			reader = Resources.getResourceAsReader (resource);
			sqlMapClient = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//밖에서 사용하기 위해 메서드를 public으로 만들어준다
	public static SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
}
