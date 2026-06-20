# Core

## For Desktop (Windows & macOS)

```bash
#  macOS
go build -buildmode=c-shared -ldflags="-s -w" -o build/core.dylib
# Windows
go build -buildmode=c-shared -ldflags="-s -w" -o build/core.dll
```