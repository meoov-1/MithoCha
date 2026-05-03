package com.mithocha.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {

    private int paymentId;
    private int orderId;
    private String transactionId;
    private String status;
    private BigDecimal amount;
    private String method;
    private Timestamp createdAt;

    public Payment() {}

    public Payment(int orderId, String transactionId, String status, BigDecimal amount, String method) {
        this.orderId = orderId;
        this.transactionId = transactionId;
        this.status = status;
        this.amount = amount;
        this.method = method;
    }

    public Payment(int paymentId, int orderId, String transactionId, String status,
                   BigDecimal amount, String method, Timestamp createdAt) {
        this(orderId, transactionId, status, amount, method);
        this.paymentId = paymentId;
        this.createdAt = createdAt;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
