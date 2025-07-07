FROM --platform=$BUILDPLATFORM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04

LABEL maintainer="jyoung2000@github.com"
LABEL description="Enhanced Kokoro TTS with Voice Cloning and Comprehensive Web Interface"
LABEL version="2.0.0"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=utf-8 \
    PYTHONPATH=/app:/app/api \
    UV_SYSTEM_PYTHON=1 \
    UV_CACHE_DIR=/tmp/uv-cache \
    PORT=2222 \
    USE_GPU=true \
    ALLOW_VOICE_CLONING=true \
    CUSTOM_VOICES_DIR=/app/voices/custom \
    DOWNLOADS_DIR=/app/downloads \
    DOWNLOAD_MODEL=false

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    ffmpeg \
    espeak-ng \
    build-essential \
    python3-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install UV package manager
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Create app user and directories
RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN mkdir -p /app /app/voices/custom /app/downloads /app/output /app/temp \
    && chown -R appuser:appuser /app

# Set working directory
WORKDIR /app

# Copy project files
COPY --chown=appuser:appuser . /app/

# Install Python dependencies
RUN cd /app && uv sync --extra gpu --no-dev

# Make scripts executable
RUN chmod +x /app/entrypoint-enhanced.sh

# Create symlink for the enhanced web interface
RUN ln -sf /app/enhanced-web /app/web-enhanced

# Switch to app user
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 \
    CMD curl -f http://localhost:${PORT}/health || exit 1

# Expose port
EXPOSE 2222

# Start the enhanced application
CMD ["./entrypoint-enhanced.sh"]