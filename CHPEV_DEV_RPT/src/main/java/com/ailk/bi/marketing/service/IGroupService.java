package com.ailk.bi.marketing.service;
/**
 *【业务层接口】客户群
 * @author  方慧
 * @version  [版本号, 2012-04-10]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
import java.util.List;
import com.ailk.bi.marketing.entity.GroupInfo;

public interface IGroupService {
	public boolean save(GroupInfo entity);
	public boolean delete(String ids);
	public GroupInfo getById(String id);
	/**
	 * 通过条件查询，返回count条记录
	 * @param  entity 当entity为null时，没有条件
	 * @param  count 返回指定的记录数，当count=0时，返回所有的记录
	 */
	public List<GroupInfo> getAll(GroupInfo entity,int count);

}
