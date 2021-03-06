package com.ailk.bi.marketing.dao.impl;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import com.ailk.bi.base.dao.BaseDAO;
import com.ailk.bi.marketing.dao.IPolicyDao;
import com.ailk.bi.marketing.entity.PolicyInfo;
/**
 *【DAO层接口实现类】政策
 * @author  方慧
 * @version  [版本号, 2012-04-10]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
@Repository
public class PolicyDaoImpl extends
BaseDAO<PolicyInfo, Integer> implements IPolicyDao {
	@SuppressWarnings("unchecked")
	public List<PolicyInfo> getAll(PolicyInfo entity,int count)
	{
		Session session = getSession();
		Criteria criter = session.createCriteria(PolicyInfo.class,"PolicyInfo");
		if (null == entity && count == 0) {
			return super.findAll();
		} else {
			if (count > 0) {
				criter.setMaxResults(count);
			}
			// 对内容进行模糊查询
			String name = "%";
			if (null != entity.getPolicyName()) {
				name = "%" + entity.getPolicyName() + "%";
				criter.add(Restrictions.like("PolicyInfo.policyName",name));
			}
			if (entity.getPolicyType() != -999) {
				criter.add(Restrictions.eq("PolicyInfo.policyType",entity.getPolicyType()));
			}
			if (entity.getState() != -999) {
				criter.add(Restrictions.eq("PolicyInfo.state",entity.getState()));
			}
			criter.addOrder( Property.forName("PolicyInfo.createDate").desc() );
			List<PolicyInfo> results = criter.list();
			session.flush();
			return results;
		}
	}

	public boolean delect(String ids) {
		int count = 0;
		try {
			Session session = super.getSession();
			String HSQL = "DELETE PolicyInfo WHERE policyId IN (" + ids + ")";
			count = session.createQuery(HSQL).executeUpdate();
			System.out.println("删除条数：" + count);
			session.flush();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("批量删除出现问题");
		}
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
}
