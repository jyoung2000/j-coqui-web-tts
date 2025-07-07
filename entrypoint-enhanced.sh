#!/bin/bash
set -e

echo "Starting J-Coqui Enhanced TTS Container..."
echo "Running on port: ${PORT:-2222}"
echo "GPU enabled: ${USE_GPU:-true}"
echo "Custom voices directory: ${CUSTOM_VOICES_DIR:-/app/voices/custom}"
echo "Downloads directory: ${DOWNLOADS_DIR:-/app/downloads}"

# Ensure directories exist
mkdir -p "${CUSTOM_VOICES_DIR:-/app/voices/custom}"
mkdir -p "${DOWNLOADS_DIR:-/app/downloads}"

# Download model if needed
if [ "$DOWNLOAD_MODEL" = "true" ]; then
    echo "Downloading models..."
    python scripts/download_model.py --output api/src/models/v1_0
fi

# Check if models exist
if [ ! -f "api/src/models/v1_0/config.json" ]; then
    echo "Warning: Model files not found. Running download_model.py..."
    python scripts/download_model.py --output api/src/models/v1_0
fi

echo "Starting enhanced TTS service..."
exec uv run --extra ${DEVICE:-gpu} --no-sync python enhanced-main.py