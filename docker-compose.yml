version: '3.5'
services:
  mssql-db:
    image: microsoft/mssql-server-linux:latest
    restart: always
    environment:
      ACCEPT_EULA: Y
      SA_PASSWORD: password!1
    ports:
    - 1430:1433
    container_name: bigdata-cluster-mssql-db
    networks:
      - bigdata-cluster-network
  mssql-db-data-load :
    build:  ./mssql-db-data-load/
    command: sh -c './wait-for-it.sh mssql-db:1433 --timeout=0 --strict -- sleep 10 && ./run-data-load.sh'
    container_name: bigdata-cluster-mssql-db-data-load
    depends_on:
      - "mssql-db"
    networks:
      - bigdata-cluster-network
  bigdata-cluster:
    build: ./bigdata-cluster/
    restart: always
    container_name: bigdata-cluster
    command: sh -c './start-ecosystem.sh'
    depends_on:
      - mssql-db
    ports:
    - "1431:22"
    - "1432:8080"
    networks:
      - bigdata-cluster-network
networks:
  bigdata-cluster-network:
    name : bigdata-cluster-network
