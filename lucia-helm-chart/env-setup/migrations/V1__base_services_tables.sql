CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TABLE spark_job_run
(
    id                              VARCHAR PRIMARY KEY,
    job_id                          VARCHAR,
    pipeline_run_id                 VARCHAR,
    pipeline_id                     VARCHAR,
    num_of_executors                INTEGER,    
    total_memory_per_executor       FLOAT,
    total_bytes_read                BIGINT, 
    total_bytes_written             BIGINT, 
    total_shuffle_bytes_read        BIGINT, 
    total_shuffle_bytes_written     BIGINT, 
    total_cpu_time_used             FLOAT,
    total_cpu_uptime                FLOAT,
    peak_memory_usage               FLOAT,
    total_cores_num                 INTEGER,
    cpu_utilization                 FLOAT,
    start_time                      TIMESTAMP DEFAULT null,
    end_time                        TIMESTAMP DEFAULT null,
    created                         TIMESTAMP DEFAULT now(),
    updated                         TIMESTAMP DEFAULT now(),
    deleted                         boolean DEFAULT  FALSE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON spark_job_run
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE raw_event
(
    id                          uuid PRIMARY KEY DEFAULT public.uuid_generate_v4(),
    job_run_id                  VARCHAR,
    job_id                      VARCHAR,
    pipeline_run_id             VARCHAR,
    pipeline_id                 VARCHAR,
    "event"                     JSONB,
    created                     TIMESTAMP DEFAULT now(),
    updated                     TIMESTAMP DEFAULT now(),
    deleted                     boolean DEFAULT  FALSE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON raw_event
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();