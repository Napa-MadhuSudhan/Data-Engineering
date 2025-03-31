# Snowflake-S3-Integration

This project demonstrates how to integrate Amazon S3 with Snowflake using storage integration, AWS IAM roles, and Snowflake stages to load CSV data into a customer database.

## Prerequisites
- AWS S3 bucket (`s3://customerdat/`)
- Snowflake account with ACCOUNTADMIN privileges
- AWS IAM role with necessary permissions

## Setup Steps

1. **Create Database & Schema**  
2. **Configure Storage Integration**  
3. **Grant Permissions**  
4. **Create Table for Customer Data**  
5. **Define File Format**  
6. **Create External Stage in Snowflake**  
7. **Load Data from S3 to Snowflake**  
8. **Verify Data Load**

For detailed SQL commands, refer to the `worksheet.sql` file.

## Notes
- Replace `<AWS_ROLE_ARN>` with your actual IAM role ARN.
- Ensure `customers.csv` is uploaded to the S3 bucket before running the `COPY INTO` command.

## Author
[Madhusudhan Napa](https://www.linkedin.com/in/madhusudhannapa/)
