# J-Coqui Enhanced TTS

A comprehensive Docker container for Text-to-Speech generation with voice cloning capabilities, built on Kokoro TTS with an enhanced web interface.

## 🚀 Features

- **🎯 Enhanced Web Interface**: Modern, responsive UI with comprehensive TTS controls
- **🎭 Voice Cloning**: Upload audio samples to create custom voice models
- **🎵 Voice Mixing**: Combine multiple voices with weighted ratios
- **📱 Multi-Format Support**: MP3, WAV, FLAC, OPUS output formats
- **🌍 Multi-Language**: English, Spanish, French, Japanese, Chinese, and more
- **⚡ GPU Acceleration**: NVIDIA GPU support for faster generation
- **🔗 OpenAI Compatible API**: Drop-in replacement for OpenAI TTS API
- **📦 UnRaid Ready**: Optimized for UnRaid deployment
- **💾 Persistent Storage**: Custom voices and settings persistence

## 🏃 Quick Start

### Docker Compose (Recommended)

```bash
# Clone the repository
git clone https://github.com/jyoung2000/j-coqui-web-tts.git
cd j-coqui-web-tts

# Build and start the container
docker-compose up --build -d
```

### Docker Run

```bash
docker run -d \
  --name j-coqui-web \
  --gpus all \
  -p 2222:2222 \
  -v ./voices:/app/voices/custom \
  -v ./downloads:/app/downloads \
  -e USE_GPU=true \
  -e ALLOW_VOICE_CLONING=true \
  --restart unless-stopped \
  j-coqui-web-tts
```

## 🌐 Access

- **Web Interface**: http://localhost:2222
- **API Documentation**: http://localhost:2222/docs
- **Health Check**: http://localhost:2222/health

## 🔧 Development

More documentation and files coming soon...

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>