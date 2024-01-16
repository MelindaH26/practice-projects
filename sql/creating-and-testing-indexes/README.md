# Creating and testing indexes in PorsgreSQL
This project was completed as part of the Codecademy Back-End Engineering course. 

The purpose of this project was to work with a mock book store database and create multiple indexes and test their impact on query speed and table size. 

Part 1 of the project includes basic indexting and part 2 inludes more avanced indexing such as multi-column and partial indexing.

It is worth noting that the database used in this exercise wasn't at a large enough size to benefit from using these indexes. It is also important to weight up the pros and cons of an index depending on the needs of a particular database and its users. While an index might make it quicker to query a database, it will negatively impact file sizes and the speed of INSERT, UPDATE, or DELETE statements.

Note some other important factors pointed out by CodeCademy below: 
<blockquote>
One thing to note is that when we were testing it on a local database, we had different results than on Codecademy. The size increased by about 50% and the runtime had almost no change. However, when we create the same database on the Codecademy website, the runtime did have a real difference. The lesson here is to always make sure you do your final testing in the environment that matters — your production database server.
</blockquote>