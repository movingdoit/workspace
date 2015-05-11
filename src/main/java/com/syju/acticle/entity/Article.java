package com.syju.acticle.entity;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.syju.commons.entity.IdEntity;
import com.syju.house.entity.HouseInfo;


/**
 * 文章实体类管理
 * @author Administrator
 *
 */

@Entity
@Table(name = "article")
public class Article extends IdEntity implements java.io.Serializable {

	private static final long serialVersionUID = -4075163738491759399L;
	private String title;
	private String coversPic;
	private String summary;
	private Integer priority;
	private Boolean isDisplay;
	private Integer status;
	private Timestamp addTime;
	private Timestamp updateTime;

	// SEO优化字段
	private String seoDescription;
	private String seoKeywords;
	private String seoTitle;

	private String source;
	private String sourceUrl;
	
	// many to one
	private HouseInfo houseInfo;

	// one to one
	private ArticleContent articleContent;

	// many to one
	private ArticleCategory articleCategory;

	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "house_id")
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "article", cascade = CascadeType.ALL)
	// @OneToOne(fetch = FetchType.LAZY, optional = false, mappedBy = "article", cascade = CascadeType.ALL)
	public ArticleContent getArticleContent() {
		return articleContent;
	}

	public void setArticleContent(ArticleContent articleContent) {
		this.articleContent = articleContent;
	}

	// JPA 基于channel_id列的多对一关系定义
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "cat_id")
	public ArticleCategory getArticleCategory() {
		return articleCategory;
	}

	public void setArticleCategory(ArticleCategory articleCategory) {
		this.articleCategory = articleCategory;
	}


	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCoversPic() {
		return coversPic;
	}

	public void setCoversPic(String coversPic) {
		this.coversPic = coversPic;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public Boolean getIsDisplay() {
		return isDisplay;
	}

	public void setIsDisplay(Boolean isDisplay) {
		this.isDisplay = isDisplay;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Timestamp getAddTime() {
		return addTime;
	}

	public void setAddTime(Timestamp addTime) {
		this.addTime = addTime;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getSeoDescription() {
		return seoDescription;
	}

	public void setSeoDescription(String seoDescription) {
		this.seoDescription = seoDescription;
	}

	public String getSeoKeywords() {
		return seoKeywords;
	}

	public void setSeoKeywords(String seoKeywords) {
		this.seoKeywords = seoKeywords;
	}

	public String getSeoTitle() {
		return seoTitle;
	}

	public void setSeoTitle(String seoTitle) {
		this.seoTitle = seoTitle;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getSourceUrl() {
		return sourceUrl;
	}

	public void setSourceUrl(String sourceUrl) {
		this.sourceUrl = sourceUrl;
	}
}
