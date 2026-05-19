package com.mithocha.dao;

import com.mithocha.model.Payment;

public interface PaymentDAO {

    int insertPayment(Payment payment);

    Payment findByOrderId(int orderId);
}
