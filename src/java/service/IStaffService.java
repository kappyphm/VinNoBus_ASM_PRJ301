package service;

import dal.criteria.StaffCriteria;
import java.util.List;
import java.util.Optional;
import model.entity.Staff;

public interface IStaffService {

    Optional<Staff> findById(int staffId);

    Optional<Staff> findByUserId(int userId);

    boolean createStaff(Staff staff);

    boolean updateStaff(Staff staff);

    boolean deleteStaff(int staffId);

    List<Staff> findAllStaff(StaffCriteria criteria);
}
