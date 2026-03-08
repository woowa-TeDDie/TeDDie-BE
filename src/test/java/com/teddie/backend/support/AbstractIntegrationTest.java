package com.teddie.backend.support;

import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/**
 * 통합 테스트 기반 클래스.
 *
 * <p>Testcontainers를 사용하여 PostgreSQL 컨테이너를 실행하고,
 * {@link ServiceConnection}으로 Spring DataSource에 자동 연결한다.
 *
 * <p>컨테이너는 JVM 전체에서 한 번만 실행되어 테스트 간 재사용된다 (static).
 */
@Testcontainers
public abstract class AbstractIntegrationTest {

    @Container
    @ServiceConnection
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:15");
}
