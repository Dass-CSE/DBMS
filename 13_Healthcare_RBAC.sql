/* ============================================================
   EXPERIMENT 13(a)
   ROLE-BASED ACCESS CONTROL IN HEALTHCARE INFORMATION SYSTEM
   ============================================================ */

---------------------------------------------------------------
-- 1. USER TABLE
---------------------------------------------------------------
CREATE TABLE users (
    user_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username     VARCHAR2(50) UNIQUE NOT NULL,
    password     VARCHAR2(100) NOT NULL
);

---------------------------------------------------------------
-- 2. ROLE TABLE
---------------------------------------------------------------
CREATE TABLE roles (
    role_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role_name    VARCHAR2(50) UNIQUE NOT NULL
);

---------------------------------------------------------------
-- 3. USER-ROLE MAPPING
---------------------------------------------------------------
CREATE TABLE user_roles (
    map_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id      NUMBER NOT NULL,
    role_id      NUMBER NOT NULL,
    CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_ur_role FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

---------------------------------------------------------------
-- 4. PERMISSIONS TABLE
---------------------------------------------------------------
CREATE TABLE permissions (
    perm_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    perm_name    VARCHAR2(100) UNIQUE NOT NULL
);

---------------------------------------------------------------
-- 5. ROLE-PERMISSION MAPPING
---------------------------------------------------------------
CREATE TABLE role_permissions (
    rp_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role_id      NUMBER NOT NULL,
    perm_id      NUMBER NOT NULL,
    CONSTRAINT fk_rp_role FOREIGN KEY (role_id) REFERENCES roles(role_id),
    CONSTRAINT fk_rp_perm FOREIGN KEY (perm_id) REFERENCES permissions(perm_id)
);

---------------------------------------------------------------
-- 6. SAMPLE HEALTHCARE TABLE (PATIENT RECORDS)
---------------------------------------------------------------
CREATE TABLE patient_records (
    patient_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR2(100),
    diagnosis    VARCHAR2(200),
    treatment    VARCHAR2(300)
);

---------------------------------------------------------------
-- 7. VIEW: ROLE-WISE ACCESS REPORT
---------------------------------------------------------------
CREATE OR REPLACE VIEW vw_role_access AS
SELECT r.role_name, p.perm_name
FROM roles r
JOIN role_permissions rp ON r.role_id = rp.role_id
JOIN permissions p ON rp.perm_id = p.perm_id;

---------------------------------------------------------------
-- 8. TRIGGER: AUDIT ACCESS TO PATIENT RECORDS
---------------------------------------------------------------
CREATE TABLE audit_log (
    log_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id      NUMBER,
    action       VARCHAR2(50),
    record_id    NUMBER,
    timestamp    DATE DEFAULT SYSDATE
);

CREATE OR REPLACE TRIGGER trg_patient_access_audit
AFTER INSERT OR UPDATE OR DELETE ON patient_records
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (user_id, action, record_id)
    VALUES (USERENV('SESSIONID'),
            CASE WHEN INSERTING THEN 'INSERT'
                 WHEN UPDATING THEN 'UPDATE'
                 WHEN DELETING THEN 'DELETE'
            END,
            NVL(:NEW.patient_id, :OLD.patient_id));
END;
/


/* ============================================================
   EXPERIMENT 13(b)
   REAL-TIME FINANCIAL MANAGEMENT SYSTEM FOR HOMEOWNER ASSOCIATIONS
   (Exactly as asked in the question)
   ============================================================ */

---------------------------------------------------------------
-- 1. ENTITY MODEL (TABLES WITH NORMALIZATION)
---------------------------------------------------------------

CREATE TABLE homeowners (
    homeowner_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name         VARCHAR2(100) NOT NULL,
    email             VARCHAR2(100)
);

CREATE TABLE monthly_dues (
    due_id            NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    homeowner_id      NUMBER NOT NULL,
    month_year        VARCHAR2(20),
    amount            NUMBER(10,2),
    status            VARCHAR2(20) DEFAULT 'PENDING',
    CONSTRAINT fk_md_home FOREIGN KEY (homeowner_id) REFERENCES homeowners(homeowner_id)
);

CREATE TABLE gold_loans (
    loan_id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    homeowner_id      NUMBER,
    principal         NUMBER(10,2),
    interest_rate     NUMBER(5,2),
    tenure_months     NUMBER,
    start_date        DATE,
    CONSTRAINT fk_gl_home FOREIGN KEY (homeowner_id) REFERENCES homeowners(homeowner_id)
);

---------------------------------------------------------------
-- 2. VIEWS, TRIGGERS, FUNCTIONS
---------------------------------------------------------------

-- VIEW: Audit-style summary for enterprise reporting
CREATE OR REPLACE VIEW vw_homeowner_balance AS
SELECT 
    h.full_name,
    SUM(CASE WHEN m.status='PENDING' THEN m.amount ELSE 0 END) AS outstanding_amount
FROM homeowners h
LEFT JOIN monthly_dues m ON h.homeowner_id=m.homeowner_id
GROUP BY h.full_name;

-- TRIGGER: For auditing purposes
CREATE TABLE audit_financial (
   audit_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   action_type    VARCHAR2(20),
   entity_name    VARCHAR2(50),
   id_value       NUMBER,
   action_time    DATE DEFAULT SYSDATE
);

CREATE OR REPLACE TRIGGER trg_monthly_dues_audit
AFTER INSERT OR UPDATE OR DELETE ON monthly_dues
FOR EACH ROW
BEGIN
    INSERT INTO audit_financial (action_type, entity_name, id_value)
    VALUES (
        CASE WHEN INSERTING THEN 'INSERT'
             WHEN UPDATING THEN 'UPDATE'
             WHEN DELETING THEN 'DELETE'
        END,
        'monthly_dues',
        NVL(:NEW.due_id, :OLD.due_id)
    );
END;
/

-- FUNCTION: Outstanding EMI/Pending Amount
CREATE OR REPLACE FUNCTION fn_get_outstanding(p_homeowner_id NUMBER)
RETURN NUMBER
IS
    amt NUMBER;
BEGIN
    SELECT NVL(SUM(amount),0) INTO amt
    FROM monthly_dues
    WHERE homeowner_id = p_homeowner_id AND status='PENDING';

    RETURN amt;
END;
/

---------------------------------------------------------------
-- 3. STORED PROCEDURE FOR EOD EMI PROCESSING
---------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_generate_emi IS
BEGIN
    FOR rec IN (SELECT * FROM gold_loans) LOOP
        DECLARE
            R NUMBER := rec.interest_rate/1200;
            N NUMBER := rec.tenure_months;
            EMI NUMBER;
        BEGIN
            EMI := rec.principal * R * POWER(1+R,N) / (POWER(1+R,N)-1);

            INSERT INTO monthly_dues (homeowner_id, month_year, amount, status)
            VALUES (rec.homeowner_id, TO_CHAR(SYSDATE,'Mon-YYYY'), EMI, 'PENDING');
        END;
    END LOOP;
END;
/
