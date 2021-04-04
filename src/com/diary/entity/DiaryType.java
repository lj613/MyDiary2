package com.diary.entity;

public class DiaryType {
	private Long diaryTypeId;
	private String typeName;
	public Long getDiaryTypeId() {
		return diaryTypeId;
	}
	public void setDiaryTypeId(Long diaryTypeId) {
		this.diaryTypeId = diaryTypeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	public String toString() {
		return "DiaryType[diaryTypeId="+ diaryTypeId +",typeName="+ typeName +"]";
	}
      

}
