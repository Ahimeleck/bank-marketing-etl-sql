SET search_path TO public;

CREATE TABLE client(
client_id INT PRIMARY KEY,
age INT,
job VARCHAR(20),
marital VARCHAR(20),
education VARCHAR(20),
credit_default BOOLEAN,
mortgage BOOLEAN
);

CREATE TABLE campaign(
campaign_id INT PRIMARY KEY,
client_id INT REFERENCES public.client(client_id),
number_contacts INT,
contact_duration INT,
previous_campaign_contacts INT,
previous_outcome BOOLEAN,
campaign_outcome  BOOLEAN,
last_contact_date TIMESTAMP
);

CREATE TABLE economics(
economics_id INT PRIMARY KEY,
client_id INT REFERENCES public.client(client_id),
cons_price_idx FLOAT,
euribor_three_months FLOAT
);