/* Database schema to keep the structure of entire database. */

CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    date_of_birth DATE,
    PRIMARY KEY(id) 
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR,
    PRIMARY KEY(id)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    PRIMARY KEY(id)
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR,
    name VARCHAR,
    PRIMARY KEY(id)
);

CREATE TABLE medical_histories_treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    medical_history_id INT,
    treatment_id INT,
    PRIMARY KEY(id)
);

ALTER TABLE
    medical_histories ADD CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id);

ALTER TABLE
    invoices ADD CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

ALTER TABLE
    invoice_items ADD CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices(id);

ALTER TABLE
    invoice_items ADD CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id);

ALTER TABLE
    medical_histories_treatments ADD CONSTRAINT fk_medical_histories_treatments_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

ALTER TABLE
    medical_histories_treatments ADD CONSTRAINT fk_medical_histories_treatment_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id);

CREATE INDEX fk_patient_id_medical_histories ON medical_histories(patient_id);

CREATE INDEX fk_medical_history_id ON invoices(medical_history_id);

CREATE INDEX fk_inovice_id ON invoice_items(invoice_id);

CREATE INDEX fk_treatment_id ON invoice_items(treatment_id);

CREATE INDEX fk_medical_histories_treatments_medical_history_id ON medical_histories_treatments(medical_history_id);

CREATE INDEX fk_medical_histories_treatment_treatment_id ON medical_histories_treatments(treatment_id);
