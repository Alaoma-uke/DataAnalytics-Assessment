WITH user_list AS 
	(
	SELECT  user.id , CONCAT(first_name,' ',last_name) AS user_name, 
	COUNT(DISTINCT 
			CASE WHEN is_regular_savings = 1 THEN plan_id 
			END
         ) AS savings_count, 
	COUNT(DISTINCT 
			CASE WHEN is_a_fund = 1 THEN plan_id 
            END
		 ) AS investment_count,
	SUM(confirmed_amount) AS total_deposits
	FROM adashi_staging.savings_savingsaccount savings
	JOIN adashi_staging.users_customuser user
		ON savings.owner_id = user.id
	JOIN adashi_staging.plans_plan plan 
		ON user.id = plan.owner_id
		AND savings.plan_id = plan.id
	WHERE 1 = 1
	GROUP BY 1,2
	ORDER BY 5 DESC
	)

SELECT *
FROM user_list 
WHERE 1 = 1 
	AND savings_count >= 1
    AND investment_count >= 1