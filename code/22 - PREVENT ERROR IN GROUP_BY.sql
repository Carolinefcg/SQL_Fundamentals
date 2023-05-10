set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

/*
Depending on your operating system and version of MySQL, you will be working with different SQL settings.

To make sure you can take some of the remaining lectures of the course without unnecessary interruption, we strongly advise you to execute the following query now.

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

If you’re interested in the reason we are asking you to do this, you can read the technical description below.

Technical description:

The GROUP BY clause will be used in several queries by the end of the course. Different versions of the SQL language and MySQL, in particular, can set different limits on how the GROUP BY clause can be applied.

In some of the lectures in the JOINs section, we have opted for queries where multiple table columns that are not included in the GROUP BY clause will be listed in the SELECT statement. We have decided this is the correct approach to teaching the use of the GROUP BY clause at this stage. At the same time, we are aware some versions of MySQL may not allow such queries, or at least not by default.

To adjust the relevant default settings, there is a system variable, called ‘sql_mode’, which needs to be reconfigured.

In order to view the current value of this variable in your case, you have to execute the following command.

select @@global.sql_mode;

An expression containing a few values, separated by commas, will appear in the result grid. They correspond to various MySQL settings that influence the way in which MySQL will behave in different situations.

One of these values, ‘only_full_group_by’, blocks certain type of group statements and that can potentially lead to Error Code 1055. The latter signifies the problem of listing fields in the SELECT statement that are not included in the GROUP BY clause.

Naturally, we want to avoid that. Hence, to prevent it from happening, we must execute the following statement.

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

REPLACE() is the function that will remove the “only_full_group_by” value from the expression here. Thus, error 1055 will not show up in the future.

Finally, if for some reason you’d like to disallow this behavior you can always execute the following command which will do exactly the opposite: it will add the “only_full_group_by” value to the expression.

set @@global.sql_mode := concat('ONLY_FULL_GROUP_BY,', @@global.sql_mode);


That said, we must also add that there is a reason behind this functionality. If you think about it, it is not logical to allow a column value to be listed in the output alongside a value that has been included in the GROUP BY clause of the query. We just cannot be sure that the not-grouped value that has been retrieved is going to be correct. But for the sake of our exercises, and for the purpose of making them clearer, we have allowed such syntax.
*/