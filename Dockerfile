FROM python:3.12-slim AS builder

WORKDIR /build

COPY pyproject.toml README.md ./
COPY src/ ./src/

RUN pip install --no-cache-dir --prefix=/install .

# -----------------------------------------------------------
FROM python:3.12-slim

LABEL org.opencontainers.image.source="https://github.com/AiFeatures/seclab-taskflows" \
      org.opencontainers.image.description="Security lab task flows and automation templates" \
      org.opencontainers.image.licenses="MIT"

COPY --from=builder /install /usr/local

WORKDIR /app
COPY src/ ./src/

RUN groupadd --system appgroup && useradd --system --gid appgroup appuser
USER appuser

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD ["python", "-c", "import seclab_taskflows; print('ok')"]

ENTRYPOINT ["python", "-m", "seclab_taskflows"]
