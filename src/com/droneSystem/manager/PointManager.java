package com.droneSystem.manager;



import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Transaction;

import com.droneSystem.hibernate.Point;
import com.droneSystem.hibernate.PointDAO;
import com.droneSystem.util.KeyValueWithOperator;


public class PointManager {
	private PointDAO m_dao = new PointDAO();
	
	/**
	 * ����CheckPoint Id ���� User����
	 * @param id CheckPoint Id
	 * @return CheckPoint����
	 */
	public Point findById(int id) {
		return m_dao.findById(id);
	}
	
	/**
	 * ����һ��CheckPoint��¼
	 * @param checkPoint CheckPoint����
	 * @return ����ɹ�������true�����򷵻�false
	 */
	public boolean save(Point checkPoint){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {	
			m_dao.save(checkPoint);
			tran.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return false;
		} finally {
			m_dao.closeSession();
		}
	}
	
	/**
	 * ����һ��CheckPoint��¼
	 * @param checkPoint CheckPoint����
	 * @return ���³ɹ�������true�����򷵻�false
	 */
	public boolean update(Point checkPoint){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {			
			m_dao.update(checkPoint);
			tran.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return false;
		} finally {
			m_dao.closeSession();
		}
	}
	
	/**
	 * ����CheckPoint Id,ɾ��CheckPoint����
	 * @param id CheckPoint id
	 * @return ɾ���ɹ�������true�����򷵻�false
	 */
	public boolean deleteById(int id){
		Transaction tran = m_dao.getSession().beginTransaction();
		try {			
			Point u = m_dao.findById(id);
			if(u == null){
				return true;
			}else{
				m_dao.delete(u);
			}			
			tran.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return false;
		} finally {
			m_dao.closeSession();
		}
	}	
	
	/**
	 * ��ҳ����
	 * @param currentPage ��ǰҳ��
	 * @param pageSize ÿҳ�ļ�¼��
	 * @param arr ������ֵ��
	 * @return ��ҳ���User�б�
	 */
	public List<Point> findPagedAll(int currentPage, int pageSize, KeyValueWithOperator...arr) {
		try {
			return m_dao.findPagedAll("CheckPoint", currentPage,pageSize, arr);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * ��ҳ����
	 * @param currentPage ��ǰҳ��
	 * @param pageSize ÿҳ�ļ�¼��
	 * @return ��ҳ���Specification�б�
	 */
	public List<Point> findPagedAll(int currentPage, int pageSize, List<KeyValueWithOperator> arr) {
		try {
			return m_dao.findPagedAll("CheckPoint", currentPage, pageSize, arr);
		} catch (Exception e) {
			return null;
		}
	}
	
	
	/**
	 * �õ�����CheckPoint��¼��
	 * @return CheckPoint��¼��
	 */
	public int getTotalCount(KeyValueWithOperator...arr){
		return m_dao.getTotalCount("CheckPoint", arr);		
	}
	
	/**
	 * �õ�����CheckPoint��¼��
	 * @return CheckPoint��¼��
	 */
	public int getTotalCount(List<KeyValueWithOperator> arr){
		return m_dao.getTotalCount("CheckPoint",arr);		
	}
	
	/**
	 * ��������ϲ�ѯ
	 * @param instance ���������
	 * @return ���������ļ�¼
	 */
	public List findByExample(Point instance) {
		return m_dao.findByExample(instance);
	}
	
	public List findByName(String checkPointName){
		return m_dao.findByName(checkPointName);
	}
	
	/**
	 * �жϼ������Ƿ��Ѿ�����
	 * @param checkPointName ������
	 * @return ���ڷ���true�������ڷ���false
	 */
	public boolean isUserNameExist(String checkPointName){
		Point checkPoint = new Point();
		checkPoint.setName(checkPointName);
		List<Point> list= m_dao.findByExample(checkPoint);
		if(list==null||list.size()==0){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 
	 * @param arr
	 * @return
	 */
	public List<Point> findByVarProperty(KeyValueWithOperator...arr){
		try{
			return m_dao.findByVarProperty("CheckPoint", arr);
		}
		catch(Exception e){
			return null;
		}
	}
	
	/**
	* ��ҳ��ʾ����
	*@param queryString:��ѯ��䣨HQL��
	* @param currentPage
	* ��ǰҳ��, �� 1 ��ʼ
	* @param pageSize
	* ÿҳ��ʾ������
	* @param arr ��ѯ�����?��Ӧ��ֵ
	* @return ��ҳ��������б�- List
	*/
	public List findPageAllByHQL(String queryString, int currentPage, int pageSize, Object...arr){
		try{
			return m_dao.findPageAllByHQL(queryString, currentPage, pageSize, arr);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	* ��ҳ��ʾ����
	*@param queryString:��ѯ��䣨HQL��
	* @param currentPage
	* ��ǰҳ��, �� 1 ��ʼ
	* @param pageSize
	* ÿҳ��ʾ������
	* @param arr ��ѯ�����?��Ӧ��ֵ
	* @return ��ҳ��������б�- List
	*/
	public List findPageAllByHQL(String queryString, int currentPage, int pageSize, List<Object> arr){
		try{
			return m_dao.findPageAllByHQL(queryString, currentPage, pageSize, arr);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	* ��ҳ��ʾ����
	* @param currentPage
	* ��ǰҳ��, �� 1 ��ʼ
	* @param pageSize
	* ÿҳ��ʾ������
	* @param orderby�������ĸ��ֶ�����
	* @param asc��true ���� false ����
	* @param arr:Ϊ��ѯ������(��-ֵ)������
	* @return ��ҳ��������б�- List<TaskAssign>
	*/
	public List<Point> findPagedAllBySort(int currentPage, int pageSize, String orderby,boolean asc,List<KeyValueWithOperator> condList){
		try{
			return m_dao.findPagedAllBySort("CheckPoint", currentPage, pageSize, orderby, asc, condList);
		}catch(Exception e){
			return null;
		}
	}
	
	/**
	 * �õ���¼����
	 * @param queryString ��ѯ��䣨HQL��
	 * @param arr ��ѯ�����?��Ӧ��ֵ
	 * @return
	 */
	public int getTotalCountByHQL(String queryString,Object...arr) {
		try{
			return m_dao.getTotalCountByHQL(queryString, arr);
		}catch(Exception ex){
			return 0;
		}
	}
	
	/**
	 * �õ���¼����
	 * @param queryString ��ѯ��䣨HQL��
	 * @param arr ��ѯ�����?��Ӧ��ֵ
	 * @return
	 */
	public int getTotalCountByHQL(String queryString,List<Object> arr) {
		try{
			return m_dao.getTotalCountByHQL(queryString, arr);
		}catch(Exception ex){
			return 0;
		}
	}
	
	/**
	* ����HQL����
	* @param updateString HQL��䣨update ���� set �ֶ�=ֵ where ������
	* @param arr ����
	* @return ���²���Ӱ��ļ�¼��
	*/
	public int updateByHQL(String updateString, Object...arr) {		
		Transaction tran = m_dao.getSession().beginTransaction();
		try{
			int i = m_dao.updateByHQL(updateString, arr);
			tran.commit();
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			tran.rollback();
			return 0;
		}finally {
			m_dao.closeSession();
		}
	}
}

