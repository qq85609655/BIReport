package com.ailk.bi.marketing.dao;
import java.util.List;
import com.googlecode.genericdao.dao.hibernate.GenericDAO;
import com.ailk.bi.marketing.entity.ContactPlyInfo;
/**
 *【DAO层接口】营销目标，策越对应关系表
 * @author  方慧
 * @version  [版本号, 2012-04-10]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
public interface IContactPlyDao extends
GenericDAO<ContactPlyInfo, Integer> {
	public List<ContactPlyInfo> getAllByTacticId(int tacticId);
	public boolean delectByTacticId(int id);
}
