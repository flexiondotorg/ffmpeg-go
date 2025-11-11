# Default recipe (shows available commands)
default:
    @just --list

# Build FFmpeg static library for current platform
build-ffmpeg:
    @echo "Building FFmpeg static library..."
    #!/usr/bin/env sh
    GOOS=$(go env GOOS)
    GOARCH=$(go env GOARCH)
    go run ./internal/builder libffmpeg_${GOOS}_${GOARCH}.a

# Build all Go packages
build:
    go build -v ./...

# Generate Go bindings from FFmpeg headers using libclang
generate:
    @go run ./internal/generator 2>&1 | grep -v "cgo-gcc-prolog\|deprecated" || true

# Run tests
test:
    go test -v ./...
