/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.service;

import module.core.BaseService;
import module.user.dao.CustomerDAO;
import module.user.dao.ProfileDAO;
import module.user.dao.StaffDAO;
import module.user.dao.UserDAO;

/**
 *
 * @author kappyphm
 */
public class StaffService extends BaseService {

    private final ProfileDAO profileDao = new ProfileDAO(connection);
    private final UserDAO userDao = new UserDAO(connection);
    private final StaffDAO staffDao = new StaffDAO(connection);
    private final CustomerDAO customerDao = new CustomerDAO(connection);

    

}
