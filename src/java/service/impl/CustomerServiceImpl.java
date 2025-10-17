package service.impl;

import dal.criteria.CustomerCriteria;
import dal.dao.CustomerDAO;
import java.util.List;
import java.util.Optional;
import model.entity.Customer;
import service.ICustomerService;

public class CustomerServiceImpl implements ICustomerService {

    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    public Optional<Customer> findById(int customerId) {
        return customerDAO.findById(customerId);
    }

    @Override
    public Optional<Customer> findByUserId(int userId) {
        return customerDAO.findByUserId(userId);
    }

    @Override
    public boolean createCustomer(Customer customer) {
        return customerDAO.insert(customer);
    }

    @Override
    public boolean updateCustomer(Customer customer) {
        return customerDAO.update(customer);
    }

    @Override
    public boolean deleteCustomer(int customerId) {
        return customerDAO.delete(customerId);
    }

    @Override
    public List<Customer> findAllCustomers(CustomerCriteria criteria) {
        return customerDAO.findAll(criteria);
    }
}
