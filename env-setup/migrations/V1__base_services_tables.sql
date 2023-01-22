CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE pipeline_run
(
    id                      uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    pipeline_id             VARCHAR,
    total_runtime           INTEGER,
    number_of_jobs          INTEGER,
    total_core_hours        INTEGER,
    avg_waiting_time        INTEGER,
    avg_utilization         INTEGER,
    avg_cpu_utilization     INTEGER,
    avg_memory_utilization  INTEGER,
    "date"                  TIMESTAMP DEFAULT now(),
    created                 TIMESTAMP DEFAULT now(),
    updated                 TIMESTAMP DEFAULT now(),
    deleted                 boolean DEFAULT FALSE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON pipeline_run
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();


CREATE TABLE spark_job_metrics
(
    id                      uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    job_run_id              uuid,
    utilization             INTEGER,
    runtime                 INTEGER,
    waiting_time            INTEGER,
    core_hours              INTEGER,
    used_memory             INTEGER,
    number_of_cores         INTEGER,
    cpu_utilization         INTEGER,
    memory_utilization      INTEGER,
    created                 TIMESTAMP DEFAULT now(),
    updated                 TIMESTAMP DEFAULT now(),
    deleted                 boolean DEFAULT FALSE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON spark_job_metrics
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE job_run
(
    id                      uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    pipeline_run_id         uuid,
    spark_job_metrics_id    uuid,
    job_id                  VARCHAR,
    "date"                  TIMESTAMP DEFAULT now(),
    created                 TIMESTAMP DEFAULT now(),
    updated                 TIMESTAMP DEFAULT now(),
    deleted                 boolean DEFAULT  FALSE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON job_run
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();
