#!/bin/bash

echo "======================================"
echo " CollegeDB SQL Assignment Autograding "
echo "======================================"


MYSQL="mysql -h 127.0.0.1 -u root -proot"


# Wait for MySQL Server

echo "Waiting for MySQL Server..."

sleep 20


# Execute Student SQL File

$MYSQL < starter.sql


# Check Database Creation

DB=$($MYSQL -N -e "SHOW DATABASES LIKE 'CollegeDB';")


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

TABLE=$($MYSQL -N -e "
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



# Check Primary Key

PK=$($MYSQL -N -e "
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

TYPE=$($MYSQL -N -e "
USE CollegeDB;
DESC Department;
")


if echo "$TYPE" | grep -qi "varchar"
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
