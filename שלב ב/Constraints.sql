ALTER TABLE Catering
MODIFY Cosher DEFAULT 'N';

ALTER TABLE Material
MODIFY Type DEFAULT 'Unknown';

ALTER TABLE Worker
ADD CONSTRAINT chk_worker_salary CHECK (Salary > 0);
