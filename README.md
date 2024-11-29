# Project manager

## 개발환경
- JDK 21
- MySQL 8.0

### MySQL 계정
| username | password |
|----------|----------|
| root     | secret   |
- src/main/resources/application.yaml 파일에서 변경 가능

### MySQL 스키마
```sql
CREATE
DATABASE project_manager;

CREATE TABLE projects
(
    id          BIGINT NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255),
    `key`       VARCHAR(255),
    leader      VARCHAR(255),
    description VARCHAR(255),
    PRIMARY KEY (id)
);


CREATE TABLE users
(
    id       BIGINT NOT NULL AUTO_INCREMENT,
    username VARCHAR(255),
    password VARCHAR(255),
    name     VARCHAR(255),
    profile  VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE tasks
(
    id               BIGINT NOT NULL AUTO_INCREMENT,
    `key`            VARCHAR(255),
    project_id       BIGINT,
    title            VARCHAR(255),
    body             VARCHAR(255),
    status           VARCHAR(255),
    priority         VARCHAR(255),
    label            VARCHAR(255),
    created_by       VARCHAR(255),
    person_in_charge VARCHAR(255),
    created_date     VARCHAR(255),
    due_date         VARCHAR(255),
    PRIMARY KEY (id)
);

```
