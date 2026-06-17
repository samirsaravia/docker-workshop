# Rodar o postgres
docker run -it --rm \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v ny_taxi_postgres_data:/var/lib/postgresql \
  -p 5432:5432 \
  --network=pg-network \
  --name pgdatabase \
  postgres:18


  # conectar no database
  uv run pgcli \
    -h localhost \
    -p 5432 \
    -u root \
    -d ny_taxi

# para o docker, lembrando que antes foi construido o container com o comando:/
# docker build -t taxi_ingest:v001 . 
# docker network create pg-network
docker run -it  --rm \
  --network=pg-network \
  taxi_ingest:v001 \
    --pg-user=root \
    --pg-pass=root \
    --pg-host=pgdatabase \ # aqui é o nome do container do postgres, pois ambos estão na mesma rede
    --pg-port=5432 \
    --pg-db=ny_taxi \
    --target-table=yellow_taxi_february


# rodar notebook.py
uv run notebook.py \
  --pg-user=root \
  --pg-pass=root \
  --pg-host=localhost \
  --pg-port=5432 \
  --pg-db=ny_taxi \
  --target-table=yellow_taxi_data

# em outro terminal , rodar pgAdmin na mesma rede do docker para acessar o banco de dados
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -v pgadmin_data:/var/lib/pgadmin \
  -p 8085:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4:latest