#!/bin/bash

echo "--Directory data insertion" >> user_test.sql

for dir in {1..100}
do
  echo "INSERT INTO cwd_directory(id, directory_name, lower_directory_name, created_date, updated_date, active, impl_class, lower_impl_class, directory_type) VALUES ('${dir}', 'testdir${dir}', 'testdir${dir}', now(), now(), 'T', 'com.atlassian.crowd.directory.InternalDirectory', 'com.atlassian.crowd.directory.internaldirectory', 'INTERNAL');" >> user_test.sql
done

echo
echo "--User data insertion" >> user_test.sql

for user in {1..100}
do
  echo "INSERT INTO cwd_user(id, user_name, lower_user_name, active, created_date, updated_date, email_address, directory_id) VALUES ('${user}', 'testuser${user}', 'testuser${user}', 'T', now(), now(), 'testuser${user}@gmail.com', '${user}');" >> user_test.sql
done
