
ALTER TABLE Dishs ADD (IsSpecial NUMBER(1) DEFAULT 0);
ALTER TABLE The_Order ADD (Status VARCHAR2(20) DEFAULT 'Pending');

CREATE OR REPLACE TRIGGER trg_check_expiry_date
BEFORE INSERT OR UPDATE ON Material
FOR EACH ROW
BEGIN
    IF :NEW.ExpiryDate <= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'ExpiryDate must be in the future');
    END IF;
END;
