-- Query to see current users and their permissions
SELECT rolname,
    rolsuper,
    rolcreaterole,
    rolcanlogin,
    rolcreatedb 
FROM pg_roles;

-- Check current role
SELECT current_role;

-- Create a login role called abc_open_data
CREATE ROLE abc_open_data WITH login nosuperuser;

-- Create a group role for publishers that uncludes abc_open_data as a member
CREATE ROLE publishers WITH login nosuperuser ROLE abc_open_data;

-- Grant publishers access to the analytics schema
GRANT USAGE ON SCHEMA analytics TO publishers;

-- Grant select ability on tables in analytics to publishers
GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO publishers;

-- Check to see what privileges the publisher role has
SELECT *
FROM information_schema.table_privileges
WHERE grantee = 'publishers';

-- Check that abc_open_data has ability to select from the downloads table through inheritance by setting your role ro abc_open_data
SET ROLE abc_open_data;

SELECT *
FROM analytics.downloads
LIMIT 10;

-- Set role back to Codecademy superuser
SET ROLE ccuser;

-- Grant usage and select on chosen collumns on directory.datasets to the role publishers
GRANT USAGE ON SCHEMA directory TO publishers;

GRANT SELECT (id, create_date, hosting_path, publisher, src_size )
ON directory.datasets TO publishers;

-- Add row level security on downloads data so that only rows with downloads.owner equal to the current user can view them
CREATE POLICY downloads_row_level_security ON analytics.downloads
FOR SELECT TO publishers USING (downloads.owner = current_role);

ALTER TABLE analytics.downloads ENABLE ROW LEVEL SECURITY;

-- Set user to abc open data and check that the row level security works
SET ROLE abc_open_data;

SELECT *
FROM analytics.downloads
LIMIT 10;