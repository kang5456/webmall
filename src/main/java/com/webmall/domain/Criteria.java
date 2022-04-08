package com.webmall.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 검색 정보를 가지고 있는 클래스

@ToString
@Setter
@Getter
public class Criteria {

	private int pageNum; // 선택된 페이지 번호  1	2	3	4	5
	private int amount; // 페이지마다 출력할 게시물 개수
	
	private String type; // 검색종류
	private String keyword; // 검색어
	
	
	// /board/list 주소요청시 자동호출
	public Criteria() {
		this(1, 10); // 생성자 호출시 사용.. 1번째 페이지 게시물 10개출력
	}
	
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 검색종류와 관련되어 있음.
	// 조건식 type == null이 검색기능을 사용하지않음.
	// 조건식 type == null이  false 검색기능을 사용함.
	// 제목 or 작성자 or 내용 검색선택시(TWC) type필드에 TWC 값이 존재한다.
	
	public String[] getTypeArr() {
		
		return type == null? new String[] {} : type.split("");	//	new String[] {"T", "W", "C" }
	}
	
	// UriComponentsBuilder 클래스 : 여러개의 파라미터들을 연결하여 URL형태로 만들어주는 기능을 제공
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());		
		
		return builder.toUriString(); //	PageNum=7&amount=10&type=W&keyword=user2
	}
	
}
