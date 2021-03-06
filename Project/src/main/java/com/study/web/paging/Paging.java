package com.study.web.paging;

public class Paging {
	private int startCount;
	private int endCount;
	private StringBuffer pagingHtml;

	public Paging(int currentPage, int totalCount, int blockCount,
			int blockPage, String pageUrl) {
		this(null,null, null, currentPage, totalCount, blockCount, blockPage,
				pageUrl, null);
	}

	public Paging(int currentPage, int totalCount, int blockCount,
			int blockPage, String pageUrl, String addKey) {
		this(null,null, null, currentPage, totalCount, blockCount, blockPage,
				pageUrl, addKey);
	}

	public Paging(String showdept, String keyField, String keyWord, int currentPage,
			int totalCount, int blockCount, int blockPage, String pageUrl) {
		this(showdept,keyField, keyWord, currentPage, totalCount, blockCount, blockPage,
				pageUrl, null);
	}

	public Paging(String dept,String keyField, String keyWord, int currentPage,
			int totalCount, int blockCount, int blockPage, String pageUrl,
			String addKey) {
		if (addKey == null) {
			addKey = "";
		}
		int totalPage = (int)Math.ceil((double)totalCount/blockCount);
		if (totalPage == 0) {
			totalPage = 1;
		}
		if (currentPage > totalPage) {
			currentPage = totalPage;
		}
		this.startCount = ((currentPage - 1) * blockCount + 1);
		this.endCount = (currentPage * blockCount);

		int startPage = (currentPage - 1) / blockPage * blockPage + 1;
		int endPage = startPage + blockPage - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		this.pagingHtml = new StringBuffer();		

		if (currentPage > blockPage) {
			if (keyWord == null) {
				this.pagingHtml.append("<a class='page-item item' href=" + pageUrl + "?pageNum="
						+ (startPage - 1) + addKey + ">");
			} else {
				this.pagingHtml.append("<a class='page-item item' href=" + pageUrl + "?keyField="
						+ keyField + "&keyWord=" + keyWord + "&pageNum="
						+ (startPage - 1) + addKey + " style='text-decoration: none;'>");
			}
			this.pagingHtml.append("<font size='2'><</font>");
			this.pagingHtml.append("</a>");
		}
		
		this.pagingHtml.append("&nbsp;&nbsp;");
		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}
			if (i == currentPage) {
				this.pagingHtml.append("&nbsp;<a class='page-item item'><b> <font color='red'>");
				this.pagingHtml.append(i);
				this.pagingHtml.append("</font></b></a>");
			} else {
				if (keyWord == null) {
					this.pagingHtml.append("&nbsp;<a class='page-item item' href='" + pageUrl
							+ "?pageNum=");
				} else {
					this.pagingHtml.append("&nbsp;<a class='page-item item' href='" + pageUrl
							+ "?keyField=" + keyField + "&keyWord=" + keyWord
							+ "&pageNum=");
				}
				this.pagingHtml.append(i);
				this.pagingHtml.append(addKey + "'style='text-decoration: none; '>");
				this.pagingHtml.append(i);
				this.pagingHtml.append("</a>");
			}
			this.pagingHtml.append("&nbsp;");
		}
		this.pagingHtml.append("&nbsp;&nbsp;&nbsp;&nbsp;");
		if (totalPage - startPage >= blockPage) {
			if (keyWord == null) {
				this.pagingHtml.append("<a class='page-item item' href=" + pageUrl + "?pageNum="
						+ (endPage + 1) + addKey + ">");
			} else {
				this.pagingHtml.append("<a class='page-item item' href=" + pageUrl + "?keyField="
						+ keyField + "&keyWord=" + keyWord + "&pageNum="
						+ (endPage + 1) + addKey +" style='text-decoration: none;'>");
			}
			this.pagingHtml.append("<font size='2'>></font>");
			this.pagingHtml.append("</a>");
		}
		
	}

	public StringBuffer getPagingHtml() {
		return this.pagingHtml;
	}

	public int getStartCount() {
		return this.startCount;
	}

	public int getEndCount() {
		return this.endCount;
	}
}
