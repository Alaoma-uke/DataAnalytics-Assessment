###  Assessment Q1
    Per-Question Explanations: 
    • Executed an inner join between all the tables in the first CTE. This eliminates users with no values in any of the tables.
    • Aggregated savings and investment values per user
    • Final select statement excludes users with less than 1 plan in each product
    
    Challenges: 
    • Identified that a plan can have multiple transactions due to top ups or withdrawals. This creates duplicates on the plan_id. Applied a distinct count on the plan_id  to accomidate for this.

###  Assessment Q2
    Per-Question Explanations: 
    • First CTE aggregates the users' daily transaction and next the average monthly transaction. After grouping it into the different frequency category, the final select statement counts the number of users in each category and its monthly average.

    Challenges: 
    • The frequency grouping provided in the task requirement doesn't adequately accomodate the results for the averages. For example, the low frequency is <= 2 and medium from 3 to 9. This means everything between    2.01 and 2.99 are not accomodated for. Hence, the grouping uses >2 and <= 9 for the medium frequency.

###  Assessment Q3
    Per-Question Explanations: 
    • Selected the maximum transaction by a user and calculated the difference between that and the current calendar date.
    • Final statement then filters only cases where the user has been inactive for over 1 year.

    Challenges: 
    • Didn't encounter any challenge.

###  Assessment Q4
    Per-Question Explanations: 
    • Selected only successful transactions per user to ensure that the transactions are not inflated by looking at failed transactions.
    • Calculated and rounded the difference between the current date and the date joined for users tenure
    • Converted the amount value into naira and then rounded the final calculated result to 1 decimal place for easy readability.

    Challenges: 
    • Didn't encounter any challenge.
