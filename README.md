# COVID-19 Data Analysis SQL Portfolio Project

## Overview:
This project involves analyzing COVID-19 vaccination, hospitalization, testing, and daily case data using SQL queries. The dataset includes information on vaccination doses administered, hospitalizations, ICU patients, testing data, and daily cases across various states. The queries aim to extract meaningful insights and trends from the data.

## Technologies Used:
* **SQL** (specifically, queries are written to be broadly compatible, tested with a relational database system like **MySQL** using MySQL Workbench)

## Dataset Description:
The project uses five main tables:

1. **States**: Contains information about states including their names, codes, population, and capitals.
2. **Daily_Cases**: Contains daily records of confirmed cases, recoveries, deaths, and active cases.
3. **Testing_Data**: Contains daily records of samples tested, RTPCR tests, antigen tests, and test positivity rates.
4. **Vaccination_Data**: Contains daily records of vaccination doses administered, including first, second, and precaution doses.
5. **Hospital_Data**: Contains daily records of hospitalizations, ICU patients, patients on ventilators, and new hospitalizations.

### States Table

- **Columns**:
  - `state_id`: Unique identifier for each state.
  - `state_name`: Name of the state.
  - `state_code`: Code representing the state.
  - `population_2021`: Population of the state as of 2021.
  - `capital`: Capital city of the state.

### Daily_Cases Table

- **Columns**:
  - `daily_case_id`: Unique identifier for each record.
  - `report_date`: Date of the report.
  - `state_id`: Identifier for the state.
  - `new_confirmed_cases`: Number of new confirmed cases on that day.
  - `new_recovered_cases`: Number of new recovered cases on that day.
  - `new_deaths`: Number of new deaths on that day.
  - `active_cases`: Number of active cases on that day.
  - `total_confirmed`: Cumulative number of confirmed cases.
  - `total_recovered`: Cumulative number of recovered cases.
  - `total_deaths`: Cumulative number of deaths.
  - `FOREIGN KEY (state_id) REFERENCES States(state_id)`: Foreign key linking to the States table.

### Testing_Data Table

- **Columns**:
  - `test_id`: Unique identifier for each record.
  - `report_date`: Date of the report.
  - `state_id`: Identifier for the state.
  - `total_samples_tested_daily`: Number of samples tested on that day.
  - `total_rtpcr_tests`: Number of RTPCR tests conducted on that day.
  - `total_antigen_tests`: Number of antigen tests conducted on that day.
  - `test_positivity_rate`: Positivity rate of tests conducted on that day.
  - `cumulative_samples_tested`: Cumulative number of samples tested.
  - `FOREIGN KEY (state_id) REFERENCES States(state_id)`: Foreign key linking to the States table.

### Vaccination_Data Table

- **Columns**:
  - `vaccination_id`: Unique identifier for each record.
  - `report_date`: Date of the report.
  - `state_id`: Identifier for the state.
  - `total_doses_administered_daily`: Total doses administered on that day.
  - `first_doses_daily`: Number of first doses administered on that day.
  - `second_doses_daily`: Number of second doses administered on that day.
  - `precaution_doses_daily`: Number of precaution doses administered on that day.
  - `cumulative_total_doses`: Cumulative total doses administered.
  - `cumulative_first_doses`: Cumulative number of first doses administered.
  - `cumulative_second_doses`: Cumulative number of second doses administered.
  - `cumulative_precaution_doses`: Cumulative number of precaution doses administered.
  - `FOREIGN KEY (state_id) REFERENCES States(state_id)`: Foreign key linking to the States table.

### Hospital_Data Table

- **Columns**:
  - `hospital_data_id`: Unique identifier for each record.
  - `report_date`: Date of the report.
  - `state_id`: Identifier for the state.
  - `patients_hospitalized`: Number of patients hospitalized on that day.
  - `patients_in_icu`: Number of patients in ICU on that day.
  - `patients_on_ventilator`: Number of patients on ventilators on that day.
  - `new_hospitalizations`: Number of new hospitalizations on that day.
  - `FOREIGN KEY (state_id) REFERENCES States(state_id)`: Foreign key linking to the States table.

## Key Findings:
### Vaccination Data Analysis:
- **Proactive States**: Identified states with above-average cumulative first doses administered, indicating proactive vaccination efforts.
- **High Precaution Doses**: Highlighted states with significant precaution doses on specific dates.
- **Daily and Cumulative Doses**: Provided insights into daily total doses administered and cumulative progress over time.
- **Percentage of First Doses**: Analyzed the proportion of first doses compared to overall doses administered daily.
- **Peak Vaccination Days**: Recognized days with the second highest daily doses administered for each state.
- **Dose Categorization**: Categorized daily doses into 'High', 'Medium', and 'Low', and counted states with 'High Doses'.

### Hospitalization Data Analysis:
- **High New Hospitalizations**: Identified states with significant spikes in new hospitalizations compared to Himachal Pradesh.
- **Hospitalization Trends**: Compared hospitalization rates on different dates to understand trends.
- **Daily Hospitalization Changes**: Analyzed daily differences in hospitalization rates.
- **Critical ICU Days**: Recognized days with the highest ICU admissions for each state.
- **Healthcare Burden**: Assessed the burden of new hospitalizations compared to patients on ventilators.

### Daily Cases and Testing Data Analysis:
- **Weekend Reporting Patterns**: Analyzed records reported on weekends to understand reporting patterns.

## Conclusion:
This project effectively demonstrates my proficiency in crafting complex SQL queries to extract meaningful, actionable insights from real-world, large-scale datasets. The findings shed light on critical aspects of the COVID-19 pandemic, including vaccination trends, hospitalization rates, and testing data, showcasing my ability to analyze data, identify key patterns, and contribute to data-driven decision-making. This portfolio piece highlights my analytical skills and readiness to tackle similar challenges in a professional data role.

