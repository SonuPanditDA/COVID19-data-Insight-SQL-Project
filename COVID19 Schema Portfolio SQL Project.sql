#1)Find report_date and state_name from Vaccination_Data where cumulative_first_doses is greater than the average cumulative_first_doses across all states for that specific date.
	select
		v.report_date,
		v.state_id
	from
		vaccination_data v
	where 
		cumulative_first_doses > (
			select 
				avg(v1.cumulative_first_doses) 
			from vaccination_data v1
	        where v1.report_date=v.report_date );
	
	
#2)List state_code and state_name for states that have cumulative_precaution_doses greater than 3,000,000 on '2022-01-07'.
	select
		state_code,
	    state_name
	from
		states
	where 
		state_id in (
			select 
				state_id
			from vaccination_data
	        where 
				cumulative_precaution_doses>3000000 and
	            report_date='2022/01/07');
	

#3)Retrieve report_date and state_name for entries in Hospital_Data where new_hospitalizations is higher than any new_hospitalizations recorded for 'Himachal Pradesh' (HP)
	select
		h.report_date,
	    s.state_name
	from
		hospital_data h join states s
	on h.state_id=s.state_id
	where 
		h.new_hospitalizations  > (
			select 
				max(h1.new_hospitalizations)
			from hospital_data h1 join states s1
	        on h1.state_id=s1.state_id
	        where 
				s1.state_name='Himachal Pradesh');


#4)Find state_name of states where patients_hospitalized on '2022-01-05' was greater than patients_hospitalized on '2022-01-01' for the same state.
	select
		 s.state_name
	from
		hospital_data h1 join hospital_data h2 
		On h1.state_id = h2.state_id
		Join states s on h1.state_id=s.state_id
		where
			h1.report_date = '2022-01-05'
		  AND h2.report_date = '2022-01-01'
		  AND h1.patients_hospitalized > h2.patients_hospitalized;
		

#5)For each state_id, find the daily total_doses_administered_daily and the cumulative sum of otal_doses_administered_daily over time, ordered by report_date.
		select
			state_id,
		    report_date,
		    total_doses_administered_daily,
		    sum(total_doses_administered_daily)over(partition by state_id order by report_date) TDA
		from vaccination_data;
		
		
#6)Calculate the daily difference in patients_hospitalized compared to the previous day for each state.
		select
			state_id,
		    report_date,
		    patients_hospitalized,
		    lag(patients_hospitalized)over(partition by state_id order by report_date) prevdayCount,
		    patients_hospitalized-lag(patients_hospitalized)over(partition by state_id order by report_date) DailyDiff
		from hospital_data;
		
		
#7)Rank states by their cumulative_total_doses on '2022-01-10'.
		select
			state_id,
		    cumulative_total_doses,
		    rank()over(order by cumulative_total_doses desc) rnk
		from vaccination_data
		where report_date='2022/01/10';
		
#8)For each state and report_date, find the first_doses_daily and the average first_doses_daily for that state over the entire period.
		select
			state_id,
		    report_date,
			first_doses_daily,
		    avg(first_doses_daily)over(partition by state_id) AvgDosesatEntirePeriod
		from vaccination_data;
		
		
#9)Assign a row number to each vaccination record within each state, ordered by report_date.
		select
			*,
		    row_number()over(partition by state_id order by report_date) rowNo
		from vaccination_data;
		
		
#10)For each state, find the report_date and patients_in_icu on the day with the highest patients_in_icu.
		WITH RankedData AS (
		    SELECT
		        state_id,
		        report_date,
		        patients_in_icu,
		        ROW_NUMBER() OVER (PARTITION BY state_id ORDER BY patients_in_icu DESC) AS rn
		    FROM
		        hospital_data
		)
		SELECT
		    state_id,
		    report_date,
		    patients_in_icu
		FROM
		    RankedData
		WHERE
		    rn = 1;
		
		
#11)Calculate the percentage of first_doses_daily out of total_doses_administered_daily for each record.
		SELECT
		    *,
		    (first_doses_daily / total_doses_administered_daily) * 100 AS percentage_first_doses
		FROM
		    vaccination_data;
		
		
#12)For each state, find the report_date and total_doses_administered_daily that correspond to the second highest daily dose administered.
		with CTE as(select
			state_id,
		    report_date,
		    total_doses_administered_daily,
		    dense_rank()over(partition by state_id order by total_doses_administered_daily desc) dosesRNK
		from
			vaccination_data)
		select 
			state_id,
			report_date,
		    total_doses_administered_daily
		from CTE
		where dosesRNK=2;
		
		
#13)Categorize the total doses administered daily into 'High Doses', 'Medium Doses', and 'Low Doses'. Then, it counts the number of states with 'High Doses'.
		with CTE as(select
			vaccination_id,
		    state_id,
		    total_doses_administered_daily,
		    case 
		    when total_doses_administered_daily >150000 then 'High Doses'
		    when total_doses_administered_daily > 80000 and total_doses_administered_daily < 150000
				then 'Medium Doses'
			else
				'Low Doses'
			end as DosesLevel    
		from
			vaccination_data)
		select
			count(state_id)
		from CTE where DosesLevel='High Doses';
		
#14)Show the state_name and for each record, if new_hospitalizations is greater than patients_on_ventilator, label it 'High Burden', otherwise 'Normal'.
		select
			state_id,
		    case
				when new_hospitalizations  > patients_on_ventilator then 'High Burden'
			else 'Stable'
		    end as PatientsRush
		from
			hospital_data;
		
#15)Find the report_date and state_id for all records reported on a weekend (Saturday or Sunday).
		select
			report_date,
		    state_id
		from
			daily_cases
		where weekday(report_date) in (0,6);
