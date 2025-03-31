-- Create Database & Schema
CREATE DATABASE CUSTOMER_DATA;
CREATE SCHEMA CUSTOMER_DATA_SCHEMA;

-- Create Storage Integration
CREATE OR REPLACE STORAGE INTEGRATION my_s3_integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = '<AWS_ROLE_ARN>'
STORAGE_ALLOWED_LOCATIONS = ('s3://customerdat/');

-- Show and Describe Integration
SHOW INTEGRATIONS;
DESC INTEGRATION my_s3_integration;

-- Grant Permissions
GRANT USAGE ON INTEGRATION my_s3_integration TO ROLE ACCOUNTADMIN;

-- Create Customers Table
CREATE OR REPLACE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName STRING,
    contactLastName STRING,
    contactFirstName STRING,
    phone STRING,
    addressLine1 STRING,
    addressLine2 STRING,
    city STRING,
    state STRING,
    postalCode STRING,
    country STRING,
    salesRepEmployeeNumber INT,
    creditLimit FLOAT
);

-- Define File Format
CREATE OR REPLACE FILE FORMAT my_csv_format
TYPE = CSV
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
SKIP_HEADER = 1;

-- Create External Stage
CREATE OR REPLACE STAGE my_s3_stage
STORAGE_INTEGRATION = my_s3_integration
FILE_FORMAT = my_csv_format
URL = 's3://customerdat/';

-- Remove File from Stage (if needed, I did it for testing/practice )
REMOVE @my_s3_stage/customers.csv;

-- Load Data from S3
COPY INTO customers
FROM @my_s3_stage
FILES = ('customers.csv')
FILE_FORMAT = (FORMAT_NAME = my_csv_format)
ON_ERROR = 'CONTINUE';

-- Verify Data Load
SELECT * FROM CUSTOMERS;
