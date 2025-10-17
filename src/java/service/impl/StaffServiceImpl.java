package service.impl;

import dal.criteria.StaffCriteria;
import dal.dao.StaffDAO;
import java.util.List;
import java.util.Optional;
import model.entity.Staff;
import service.IStaffService;

public class StaffServiceImpl implements IStaffService {

    private final StaffDAO staffDAO = new StaffDAO();

    @Override
    public Optional<Staff> findById(int staffId) {
        return staffDAO.findById(staffId);
    }

    @Override
    public Optional<Staff> findByUserId(int userId) {
        return staffDAO.findByUserId(userId);
    }

    @Override
    public boolean createStaff(Staff staff) {
        return staffDAO.insert(staff);
    }

    @Override
    public boolean updateStaff(Staff staff) {
        return staffDAO.update(staff);
    }

    @Override
    public boolean deleteStaff(int staffId) {
        return staffDAO.delete(staffId);
    }

    @Override
    public List<Staff> findAllStaff(StaffCriteria criteria) {
        return staffDAO.findAll(criteria);
    }
}
