WITH user_list AS 
	(
	SELECT  user.id AS customer_id, 
		CONCAT(first_name,' ',last_name) AS user_name,
		ROUND(DATEDIFF(CURRENT_DATE(), date_joined)/30,0) AS tenure_months,
		COUNT(*) AS total_transactions,
		SUM(confirmed_amount)/100 AS transaction_sum,
		(AVG(confirmed_amount)/100) * 0.001 AS avg_profit_per_transactn
    
	FROM adashi_staging.users_customuser user 
	JOIN adashi_staging.savings_savingsaccount savings
		ON savings.owner_id = user.id
	JOIN adashi_staging.plans_plan plan 
		ON user.id = plan.owner_id
		AND savings.plan_id = plan.id
	WHERE 1 = 1
		AND transaction_status = 'success'
	GROUP BY 1,2,3
	)

SELECT 
	customer_id, 
	user_name, 
	tenure_months, 
	total_transactions,
	ROUND((total_transactions/tenure_months) * 12 * avg_profit_per_transactn, 1) AS estimated_clv
FROM user_list 
WHERE 1 = 1 
ORDER BY 5 DESC