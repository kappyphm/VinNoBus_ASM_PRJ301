/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.dao.UserDAO;

/**
 *
 * @author kappyphm
 */
public class UserService extends BaseService{

    private UserDAO userDAO = new UserDAO(getConnection());

    

    
}
