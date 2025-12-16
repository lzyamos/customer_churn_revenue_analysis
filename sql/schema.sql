CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    signup_date DATE,
    country TEXT
);

CREATE TABLE subscriptions (
    customer_id INTEGER,
    plan_type TEXT,
    monthly_price INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE usage (
    customer_id INTEGER,
    usage_hours REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE support_tickets (
    customer_id INTEGER,
    ticket_count INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE churn (
    customer_id INTEGER,
    churned TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    customer_id INTEGER,
    monthly_revenue INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
