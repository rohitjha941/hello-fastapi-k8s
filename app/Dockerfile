# Multi-arch build support
FROM --platform=$BUILDPLATFORM python:3.11-slim AS builder

# Set build arguments
ARG TARGETPLATFORM
ARG BUILDPLATFORM

WORKDIR /app

# Install uv for fast Python package management
RUN pip install uv

# Copy dependency files
COPY pyproject.toml .

# Install dependencies using uv
RUN uv pip install --system -r pyproject.toml

# Final stage - runtime
FROM --platform=$TARGETPLATFORM python:3.11-slim

WORKDIR /app

# Copy Python environment from builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy application code
COPY . .

# Create non-root user for security
RUN groupadd -r fastapi && useradd -r -g fastapi fastapi
RUN chown -R fastapi:fastapi /app
USER fastapi

# Expose the port FastAPI will run on
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# Run the FastAPI application with uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]