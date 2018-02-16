package com.softcake.sim.datatable;

import java.util.List;

public class SearchDataTable<T> {
	
	private T dataSearch;
	private String tableType;
	private String roleUser;
	private int draw;
	private List<Column> columns;
	private int start;
	private int length;
	private ColumnSearch search;
	private List<Order> order;
	
	public T getDataSearch() {
		return dataSearch;
	}
	public void setDataSearch(T dataSearch) {
		this.dataSearch = dataSearch;
	}
	public String getTableType() {
		return tableType;
	}
	public void setTableType(String tableType) {
		this.tableType = tableType;
	}
	public String getRoleUser() {
		return roleUser;
	}
	public void setRoleUser(String roleUser) {
		this.roleUser = roleUser;
	}
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public List<Column> getColumns() {
		return columns;
	}
	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	public ColumnSearch getSearch() {
		return search;
	}
	public void setSearch(ColumnSearch search) {
		this.search = search;
	}
	public List<Order> getOrder() {
		return order;
	}
	public void setOrder(List<Order> order) {
		this.order = order;
	}

}
