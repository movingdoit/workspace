package com.syju.house.constrant;

import java.util.HashMap;
import java.util.Map;

public class DictType {

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
	
	/* 推荐分类*/
	public static Map<Integer, String> getRecommend() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(1, "特价楼盘");
		map.put(2, "特色楼盘");
		map.put(3, "热点推荐");
		map.put(4, "热销排行");
		map.put(5, "最新优惠");
		return map;
	}

}
