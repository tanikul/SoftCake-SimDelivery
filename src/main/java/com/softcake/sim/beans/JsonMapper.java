package com.softcake.sim.beans;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import org.springframework.util.StringUtils;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonMapper<T> {

	private Class<T> typeClass;
	private T result;

	public JsonMapper(Class<T> typeClass) {
        this.typeClass = typeClass;
    }
	
	public <typeClass> JsonMapper(String json, Class<T> typeClass) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		if(StringUtils.isEmpty(json)){
			result = null;
		}else if("java.util.List".equals(typeClass.getName())){
			result = mapper.readValue(json,  new TypeReference<typeClass>(){});
		}else{
			result = (T) mapper.readValue(json,  typeClass);	
		}
	}
	
	public JsonMapper(String json) throws JsonParseException, JsonMappingException, IOException{
		ObjectMapper mapper = new ObjectMapper();
		result = mapper.readValue(json, new TypeReference<List<Map<String, Object>>>(){});
	}

	public T getResult() {
		return result;
	}

	public void setResult(T result) {
		this.result = result;
	}

	public Class<T> getTypeClass() {
		return typeClass;
	}

	public void setTypeClass(Class<T> typeClass) {
		this.typeClass = typeClass;
	}

	public class JsonListMap {
		
		private List<Map<String, Object>> result;

		public List<Map<String, Object>> getResult() {
			return result;
		}

		public void setResult(List<Map<String, Object>> result) {
			this.result = result;
		}
		
	}
}

