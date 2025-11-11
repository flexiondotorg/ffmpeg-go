# Default recipe (shows available commands)
default:
    @just --list

# Generate Go bindings from FFmpeg headers using libclang
generate:
    @go run ./internal/generator 2>&1 | grep -v "cgo-gcc-prolog\|deprecated" || true

# Run tests
test:
    go test -v ./...
