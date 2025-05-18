WITH user_list AS 
	(
	SELECT  user.id , 
	CONCAT(first_name,' ',last_name) AS user_name, 
	COUNT(DISTINCT 
		CASE WHEN is_regular_savings = 1 AND transaction_status = 'success' THEN plan_id 
		END
             ) AS savings_count, 
	COUNT(DISTINCT 
		CASE WHEN is_a_fund = 1 AND transaction_status = 'success' THEN plan_id 
            	END
	     ) AS investment_count,
	ROUND(SUM(confirmed_amount)/100,1) AS total_deposits
	FROM adashi_staging.users_customuser user 
	JOIN adashi_staging.savings_savingsaccount savings
		ON savings.owner_id = user.id
	JOIN adashi_staging.plans_plan plan 
		ON user.id = plan.owner_id
		AND savings.plan_id = plan.id
	WHERE 1 = 1
	GROUP BY 1,2
	)

SELECT *
FROM user_list 
WHERE 1 = 1 
	AND savings_count >= 1
    	AND investment_count >= 1
ORDER BY 5 DESC
