package com.syju.house.constrant;

import java.util.HashMap;
import java.util.Map;

public class DictType {
	
	
	public final static int specialHouse = 1;  //特价楼盘
	public final static int featureHouse = 2;  //特色楼盘
	public final static int hotrecommend = 3;  //热点推荐
	public final static int hotSort = 4;       //热销排行
	public final static int newFav = 5;        //最新优惠
	public final static int newGuide = 6;        //新盘导购
	public final static int houseRecommend = 7; //楼盘推荐
	
	/* 楼盘类型 */
	public static Map<Integer, String> getHouseType() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "一房");
		map.put(2, "两房");
		map.put(3, "三房");
		map.put(4, "四房以上");
		return map;
	}

	/* 房屋类型 */
	public static Map<Integer, String> getHomeType() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "海景房");
		map.put(2, "河景房");
		map.put(3, "养生圣地");
		map.put(4, "宜居养老");
		return map;
	}

	/* 房屋类型 */
	public static Map<Integer, String> getAreaType() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "海口");
		map.put(2, "文昌");
		map.put(3, "三亚");
		map.put(4, "陵水");
		return map;
	}

	/* 装修类型 */
	public static Map<Integer, String> getDecorateType() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "毛坯房");
		map.put(2, "精装修");
		map.put(3, "简装");
		return map;
	}

	/* 装修类型 */
	public static Map<Integer, String> getSaleStatus() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "在售");
		map.put(2, "热销楼盘");
		return map;
	}

	/* 推荐分类 */
	public static Map<Integer, String> getRecommend() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "特价楼盘");
		map.put(2, "特色楼盘");
		map.put(3, "热点推荐");
		map.put(4, "热销排行");
		map.put(5, "最新优惠");
		map.put(6, "新盘导购");
		map.put(7, "楼盘推荐");
		return map;
	}
	
	
	/* 楼盘图片分类*/
	public static Map<Integer, String> getHousePhoto() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "实景图");
		map.put(2, "效果图");
		map.put(3, "样板图");
		map.put(4, "区位交通图");
		return map;
	}
	
	/* 楼盘户型图片分类*/
	public static Map<Integer, String> getHouseTypePhoto() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "一户型");
		map.put(2, "二户型");
		map.put(3, "三户型");
		map.put(4, "其他");
		return map;
	}
	
	/* 团购类型*/
	public static Map<Integer, String> getActivityType() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "团购活动");
		map.put(2, "专题活动");
		return map;
	}
	
	
	/*
	 * 广告类型
	 * public static Map<Integer, String> getAdType() {
	 * Map<Integer, String> map = new HashMap<Integer, String>();
	 * map.put(1, "首页广告");
	 * map.put(2, "楼盘展示页广告");
	 * map.put(3, "特价楼盘广告");
	 * map.put(4, "搜索页广告");
	 * map.put(5, "新闻资讯广告");
	 * return map;
	 * }
	 * 
	 * 广告位置
	 * public static Map<Integer, String> getAdLocation() {
	 * Map<Integer, String> map = new HashMap<Integer, String>();
	 * map.put(1, "特价楼盘");
	 * map.put(2, "特色楼盘");
	 * map.put(3, "热点推荐");
	 * map.put(4, "热销排行");
	 * map.put(5, "最新优惠");
	 * return map;
	 * }
	 */

}
