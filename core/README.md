# Core

## For Desktop (Windows & macOS)

```bash
#  macOS
go build -buildmode=c-shared -ldflags="-s -w" -o build/libcore.dylib
# Windows
go build -buildmode=c-shared -ldflags="-s -w" -o build/libcore.dll
```

## For iOS

```bash
chmod +x build_ios.sh
./build_ios.sh
```