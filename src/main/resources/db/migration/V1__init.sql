CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE users (
                       id          BIGSERIAL PRIMARY KEY,
                       email       VARCHAR(255) NOT NULL UNIQUE,
                       password    VARCHAR(255) NOT NULL,
                       nickname    VARCHAR(100) NOT NULL,
                       role        VARCHAR(20)  NOT NULL DEFAULT 'USER',
                       created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
                       updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
                       CONSTRAINT chk_users_role CHECK (role IN ('USER', 'ADMIN'))
);

CREATE TABLE missions (
                          id          BIGSERIAL PRIMARY KEY,
                          title       VARCHAR(500) NOT NULL,
                          description TEXT         NOT NULL,
                          difficulty  VARCHAR(10)  NOT NULL,
                          category    VARCHAR(100) NOT NULL,
                          language    VARCHAR(50)  NOT NULL,
                          creator_id  BIGINT REFERENCES users(id) ON DELETE SET NULL,
                          created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
                          CONSTRAINT chk_missions_difficulty CHECK (difficulty IN ('EASY', 'MEDIUM', 'HARD'))
);

CREATE TABLE generation_jobs (
                                 id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                 user_id     BIGINT REFERENCES users(id) ON DELETE CASCADE,
                                 status      VARCHAR(20) NOT NULL DEFAULT 'IN_PROGRESS',
                                 mission_id  BIGINT REFERENCES missions(id) ON DELETE SET NULL,
                                 error_msg   TEXT,
                                 difficulty  VARCHAR(10)  NOT NULL,
                                 category    VARCHAR(100) NOT NULL,
                                 language    VARCHAR(50)  NOT NULL,
                                 created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
                                 updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
                                 CONSTRAINT chk_generation_jobs_status CHECK (status IN ('IN_PROGRESS', 'COMPLETED', 'FAILED')),
                                 CONSTRAINT chk_generation_jobs_difficulty CHECK (difficulty IN ('EASY', 'MEDIUM', 'HARD'))
);