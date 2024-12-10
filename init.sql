DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'fastapi_db') THEN
      CREATE DATABASE fastapi_db;
   END IF;
END
$$;

DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'fastapi_user') THEN
      CREATE USER fastapi_user WITH PASSWORD 'secret_password';
   END IF;
END
$$;

GRANT ALL PRIVILEGES ON DATABASE fastapi_db TO fastapi_user;
