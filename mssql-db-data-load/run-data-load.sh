#!/bin/bash
/opt/mssql-tools/bin/sqlcmd -S mssql-db,1433 -U sa -P 'password!1' -i create-hive-metastore-db.sql;
