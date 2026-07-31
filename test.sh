#!/bin/bash

echo "======================================"
echo " CollegeDB SQL Assignment Autograding "
echo "======================================"


mysql -u root -proot < starter.sql


# Check Database Creation

DB=$(mysql -u root -proot -N -e "SHOW DATABASES LIKE 'CollegeDB';")


if [ "$DB" == "CollegeDB" ]
then
    echo "✓ Database Created Successfully"
    MARK1=3
else
    echo "✗ Database Creation Failed"
    echo "Marks : 0/3"
    exit 1
fi



# Check Table Creation

TABLE=$(mysql -u root -proot -N -e "
USE CollegeDB;
SHOW TABLES LIKE 'Department';
")


if [ "$TABLE" == "Department" ]
then
    echo "✓ Department Table Created"
    MARK2=4
else
    echo "✗ Department Table Not Found"
    exit 1
fi



# Check Columns

COLUMN=$(mysql -u root -proot -N -e "
USE CollegeDB;
DESC Department;
")


echo "$COLUMN"



# Check Primary Key

PK=$(mysql -u root -proot -N -e "
USE CollegeDB;
SHOW KEYS FROM Department WHERE Key_name='PRIMARY';
")


if [ ! -z "$PK" ]
then
    echo "✓ Primary Key Constraint Available"
    MARK3=2
else
    echo "✗ Primary Key Missing"
    exit 1
fi



# Check Data Types

TYPE=$(mysql -u root -proot -N -e "
USE CollegeDB;
DESC Department;
")


if echo "$TYPE" | grep -q "varchar"
then
    echo "✓ Data Types Verified"
    MARK4=1
else
    echo "✗ Data Types Incorrect"
    exit 1
fi


TOTAL=$((MARK1+MARK2+MARK3+MARK4))


echo "================================"
echo "Marks : $TOTAL/10"
echo "================================"
