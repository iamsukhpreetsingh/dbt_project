
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

SELECT DEPARTMENT, SUM(SALARY) AS SUM_OF_SALARY
FROM TEMP_DB.TEMP_SCHEMA.EMPLOYEES
GROUP BY DEPARTMENT




/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
