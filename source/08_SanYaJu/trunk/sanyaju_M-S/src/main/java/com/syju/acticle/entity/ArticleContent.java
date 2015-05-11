package com.syju.acticle.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;


@Entity
@Table(name = "article_content")
public class ArticleContent implements java.io.Serializable {

	private static final long serialVersionUID = 408539392103352546L;
	private Long articleId;
	private Article article;
	private String content;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "article"))
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "article_id", unique = true, nullable = false)
	public Long getArticleId() {
		return articleId;
	}

	public void setArticleId(Long articleId) {
		this.articleId = articleId;
	}

	@OneToOne(fetch = FetchType.LAZY)
	// @OneToOne(fetch = FetchType.LAZY, optional = false)
	@PrimaryKeyJoinColumn
	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}

}

