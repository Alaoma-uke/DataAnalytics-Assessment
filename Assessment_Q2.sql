WITH user_daily_trans AS 
	( -- aggregating all tramsactions at a daily level per user
	SELECT  user.id , 
		CONCAT(first_name,' ',last_name) AS user_name, 
		DATE(transaction_date) AS transaction_date,
		COUNT(*) AS daily_transaction
	FROM adashi_staging.savings_savingsaccount savings
	JOIN adashi_staging.users_customuser user
		ON savings.owner_id = user.id
	WHERE 1 = 1
	GROUP BY 1,2,3
	ORDER BY 4 DESC
	),

mntly_user_avg AS
	( -- average transaction per user on a monthly basis
	SELECT id, user_name, 
		DATE_FORMAT(transaction_date, '%Y-%m-01') AS mnth, 
		AVG(daily_transaction) AS mnth_avg
	FROM user_daily_trans 
	WHERE 1 = 1 
	GROUP BY 1,2,3
    ),

freq_grp AS 
	( -- monthly transactions per user grouped by their frequency group
	SELECT *,
	CASE WHEN mnth_avg <= 2 THEN 'Low Frequeny' 
		 WHEN mnth_avg > 2 AND mnth_avg <= 9 THEN 'Medium Frequency' 
		 WHEN mnth_avg > 9 THEN 'High Frequency' 
	END AS frequency_category
	FROM mntly_user_avg
    )

SELECT frequency_category, 
COUNT(*) AS customer_count,
AVG(mnth_avg) AS avg_transactions_per_month
FROM freq_grp 
GROUP BY 1