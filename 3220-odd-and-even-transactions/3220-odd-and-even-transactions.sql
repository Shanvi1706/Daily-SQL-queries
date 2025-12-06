# Write your MySQL query statement below
SELECT transaction_date,
    SUM(if(amount%2 != 0, amount, 0)) as odd_sum,
    SUM(if(amount%2 = 0, amount , 0)) as even_sum
FROM  transactions
GROUP BY transaction_date
Order BY transaction_Date




