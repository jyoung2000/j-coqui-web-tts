# J-Coqui Enhanced TTS Project

## Overview
This project transforms the original Kokoro TTS FastAPI wrapper into a comprehensive Docker container with enhanced web interface, voice cloning capabilities, and UnRaid compatibility.

## Architecture

### Core Components
- **Base**: Kokoro TTS FastAPI wrapper (port 8880 → 2222)
- **Enhanced FastAPI**: `enhanced-main.py` with voice cloning endpoints
- **Web Interface**: `/enhanced-web/` with comprehensive TTS controls
- **Docker**: NVIDIA CUDA-based container with GPU support
- **UnRaid**: Optimized for UnRaid deployment with proper volume mounts

### Key Features
1. **Voice Cloning**: Upload audio samples to create custom voice models
2. **Voice Mixing**: Combine multiple voices with weighted ratios
3. **Enhanced UI**: Modern web interface with tabs for different functions
4. **API Compatibility**: Maintains OpenAI-compatible endpoints
5. **GPU Support**: NVIDIA GPU acceleration with CUDA
6. **Persistent Storage**: Custom voices and downloads persistence

## File Structure
```
j-coqui-web-tts/
├── Dockerfile                 # Enhanced container definition
├── docker-compose.yml         # UnRaid-compatible deployment
├── enhanced-main.py           # Enhanced FastAPI application
├── entrypoint-enhanced.sh     # Container startup script
├── enhanced-web/             # Enhanced web interface
│   ├── index.html            # Main UI with tabs
│   ├── styles/               # CSS styling
│   └── src/                  # JavaScript modules
│       ├── enhanced-app.js   # Main application controller
│       └── services/         # Service modules
├── Kokoro-FastAPI-master/    # Original Kokoro TTS code
├── CLAUDE.md                 # This documentation
└── README.md                 # Project documentation
```

## Essential Commands

### Build and Run
```bash
# Build the container
docker-compose build

# Start the container
docker-compose up -d

# View logs
docker logs j-coqui-web-tts -f
```

### Development
```bash
# Local development
uv sync --extra gpu
uv run python enhanced-main.py

# Test the API
curl http://localhost:2222/health
```

### Git Management
```bash
# Add and commit changes
git add .
git commit -m "Description of changes"

# Push to GitHub
git push origin main
```

## Environment Variables
| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `2222` | Application port |
| `USE_GPU` | `true` | Enable GPU acceleration |
| `ALLOW_VOICE_CLONING` | `true` | Enable voice cloning |
| `CUSTOM_VOICES_DIR` | `/app/voices/custom` | Custom voices storage |
| `DOWNLOADS_DIR` | `/app/downloads` | Downloads storage |

## API Endpoints

### Enhanced Endpoints
- `GET /` - Enhanced web interface
- `GET /health` - Health check with system info
- `POST /v1/voices/clone` - Voice cloning (placeholder)
- `GET /v1/voices/custom` - List custom voices
- `GET /v1/system/info` - System information

### OpenAI Compatible
- `POST /v1/audio/speech` - Generate speech
- `GET /v1/models` - List available models
- `GET /v1/voices` - List available voices

## UnRaid Deployment

### Volume Mounts
- `/mnt/user/appdata/j-coqui-web/voices:/app/voices/custom`
- `/mnt/user/appdata/j-coqui-web/downloads:/app/downloads`
- `/mnt/user/Media/TTS-Output:/app/output`

### Network
- Port: `2222` (WebUI)
- GPU: Requires NVIDIA GPU support
- Memory: 8GB limit recommended

## Development Notes

### Voice Cloning Implementation
The voice cloning feature is currently implemented as a placeholder. Full implementation would require:
1. Audio preprocessing and feature extraction
2. Voice model training pipeline
3. Model storage and loading system
4. Integration with existing TTS pipeline

### Web Interface Architecture
The enhanced web interface uses a modular JavaScript architecture:
- `enhanced-app.js`: Main controller
- `services/`: Individual service modules (VoiceManager, AudioService, etc.)
- Tab-based UI for different functionalities

### Testing
```bash
# Test locally with Docker Desktop
docker-compose up --build

# Test API endpoints
curl http://localhost:2222/health
curl http://localhost:2222/v1/voices
```

## Troubleshooting

### Common Issues
1. **Port 2222 in use**: Change port in docker-compose.yml
2. **GPU not detected**: Ensure NVIDIA Docker support
3. **Models not loading**: Check DOWNLOAD_MODEL environment variable
4. **Voice cloning fails**: Verify ALLOW_VOICE_CLONING=true

### Logs
```bash
docker logs j-coqui-web-tts
```

## Future Enhancements
1. Complete voice cloning implementation
2. Voice mixing with neural blending
3. Real-time voice conversion
4. Advanced audio processing options
5. Multi-language support expansion

## Version History
- v1.0: Initial Kokoro TTS wrapper
- v2.0: Enhanced web interface with voice cloning framework
- v2.1: (Planned) Full voice cloning implementation

---

**Note**: This project is designed for UnRaid deployment but can run on any Docker-compatible system with NVIDIA GPU support.