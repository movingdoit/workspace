package com.syju.activity.group.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

@Entity
@Table(name = "hd_grouprecommend")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GroupRecommend extends IdEntity {

	private Long priority;// 排序
	private String content; // 推荐内容
	private String title;// 推荐标题
	private Date createTime;// 创建时间
	
	private GroupActivity groupActivity;
	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "group_id")
	public GroupActivity getGroupActivity() {
		return groupActivity;
	}

	public void setGroupActivity(GroupActivity groupActivity) {
		this.groupActivity = groupActivity;
	}

	public Long getPriority() {
		return priority;
	}

	public void setPriority(Long priority) {
		this.priority = priority;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


}
