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

## For Android

### Build in Windows

#### For simulator (x86)

```bash
$env:NDK_PATH=/path/to/your/android-ndk

$env:CC="$env:NDK_PATH\toolchains\llvm\prebuilt\windows-x86_64\bin\x86_64-linux-android30-clang.cmd"

$env:CGO_ENABLED="1"
$env:GOOS="android"
$env:GOARCH="amd64"
$env:CGO_ASFLAGS="-target x86_64-linux-android"

go build -buildmode=c-shared -o build/libcore.so
```

#### For build (arm64)

```bash
$env:NDK_PATH=/path/to/your/android-ndk

$env:CC="$env:NDK_PATH\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android30-clang.cmd"

$env:CGO_ENABLED="1"
$env:GOOS="android"
$env:GOARCH="arm64"

go build -buildmode=c-shared -o build/libcore.so
```

### Build in macOS

```bash
export NDK_PATH=/path/to/your/android-ndk
export CC_PATH=$NDK_PATH/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android30-clang

CGO_ENABLED=1 \
GOOS=android \
GOARCH=arm64 \
CC=$CC_PATH \
go build -buildmode=c-shared -o build/libcore.so
```