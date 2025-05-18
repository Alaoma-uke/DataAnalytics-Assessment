WITH user_transactn AS 
	(
	SELECT savings.owner_id, 
		plan_id, 
		CASE WHEN is_regular_savings = 1 THEN 'Savings'
			WHEN is_a_fund = 1 THEN 'Investment'
		END AS type,
		DATE_FORMAT(MAX(transaction_date), '%Y-%m-%d') AS last_transaction_date,
		DATEDIFF(CURRENT_DATE(),  MAX(transaction_date)) AS inactivity_days
	FROM adashi_staging.savings_savingsaccount savings
	JOIN adashi_staging.plans_plan plan 
		ON savings.owner_id = plan.owner_id
		AND savings.plan_id = plan.id
	WHERE 1 = 1
		AND transaction_status = 'success'
	GROUP BY 1,2,3
	)

SELECT *
FROM user_transactn
WHERE 1 = 1 
	AND inactivity_days >= 365