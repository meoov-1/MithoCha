package com.mithocha.model;

import com.mithocha.util.JsonUtil;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * POJO for the `orders` table.
 *
 * CREATE TABLE orders (
 *   order_id         INT AUTO_INCREMENT PRIMARY KEY,
 *   user_id          INT,
 *   total_amount     DECIMAL(10,2),
 *   order_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 *   status           ENUM('pending','completed','cancelled') DEFAULT 'pending',
 *   items            JSON,
 *   payment          JSON,
 *   shipping_address JSON,
 *   FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
 * );
 *
 * JSON columns are stored/retrieved as raw String values.
 */
public class Order {

    private int        orderId;
    private int        userId;
    private BigDecimal totalAmount;
    private Timestamp  orderDate;
    private String     status;          // "pending" | "completed" | "cancelled"
    private String     items;           // raw JSON string
    private String     payment;         // raw JSON string
    private String     shippingAddress; // raw JSON string
    private List<OrderItem> orderItems = new ArrayList<>();
    private Payment paymentRecord;

    // ── Constructors ──────────────────────────────────────────────────────────

    public Order() {}

    /** Constructor for placing a new order (no id / date yet). */
    public Order(int userId, BigDecimal totalAmount, String status,
                 String items, String payment, String shippingAddress) {
        this.userId          = userId;
        this.totalAmount     = totalAmount;
        this.status          = status;
        this.items           = items;
        this.payment         = payment;
        this.shippingAddress = shippingAddress;
    }

    /** Full constructor (used when reading from DB). */
    public Order(int orderId, int userId, BigDecimal totalAmount, Timestamp orderDate,
                 String status, String items, String payment, String shippingAddress) {
        this(userId, totalAmount, status, items, payment, shippingAddress);
        this.orderId   = orderId;
        this.orderDate = orderDate;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────

    public int getOrderId()                          { return orderId; }
    public void setOrderId(int orderId)              { this.orderId = orderId; }

    public int getUserId()                           { return userId; }
    public void setUserId(int userId)                { this.userId = userId; }

    public BigDecimal getTotalAmount()                       { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount)       { this.totalAmount = totalAmount; }

    public Timestamp getOrderDate()                  { return orderDate; }
    public void setOrderDate(Timestamp orderDate)    { this.orderDate = orderDate; }

    public String getStatus()                        { return status; }
    public void setStatus(String status)             { this.status = status; }

    public String getItems() {
        if (items != null) {
            return items;
        }
        return orderItems.isEmpty() ? null : JsonUtil.toJson(orderItems);
    }
    public void setItems(String items)               { this.items = items; }

    public String getPayment() {
        if (payment != null) {
            return payment;
        }
        return paymentRecord == null ? null : JsonUtil.toJson(paymentRecord);
    }
    public void setPayment(String payment)           { this.payment = payment; }

    public String getShippingAddress()                           { return shippingAddress; }
    public void setShippingAddress(String shippingAddress)       { this.shippingAddress = shippingAddress; }

    public List<OrderItem> getOrderItems()                      { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems)       { this.orderItems = orderItems == null ? new ArrayList<>() : new ArrayList<>(orderItems); }

    public Payment getPaymentRecord()                           { return paymentRecord; }
    public void setPaymentRecord(Payment paymentRecord)         { this.paymentRecord = paymentRecord; }

    @Override
    public String toString() {
        return "Order{orderId=" + orderId + ", userId=" + userId
                + ", totalAmount=" + totalAmount + ", status='" + status + "'}";
    }
}
