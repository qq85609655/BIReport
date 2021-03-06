package com.ailk.bi.marketing.dao;
import com.googlecode.genericdao.dao.hibernate.GenericDAO;
import com.ailk.bi.marketing.entity.ActivityModeInfo;
/**
 *【DAO层接口】营销方案
 * @author  方慧
 * @version  [版本号, 2012-04-10]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
public interface IActivityModeDao extends
GenericDAO<ActivityModeInfo, Integer> {
	public ActivityModeInfo getByActivityId(int activityId);
}
