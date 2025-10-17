package service;

import dal.criteria.CustomerCriteria;
import java.util.List;
import java.util.Optional;
import model.entity.Customer;

public interface ICustomerService {

    Optional<Customer> findById(int customerId);

    Optional<Customer> findByUserId(int userId);

    boolean createCustomer(Customer customer);

    boolean updateCustomer(Customer customer);

    boolean deleteCustomer(int customerId);

    List<Customer> findAllCustomers(CustomerCriteria criteria);
}
