# Flutter FFI Dynamic Library Template

A template for integrating native dynamic libraries (static libraries for iOS) into Flutter projects via FFI (Foreign Function Interface).

## Table of Contents

- [Usage in Dart](#usage-in-dart)
- [Configuration](#configuration)
  - [Windows](#for-windows)
  - [macOS](#for-macos)
  - [iOS](#for-ios)
  - [Android](#for-android)

## Usage in Dart

1. Add the `ffi` package to your project's dependencies.
2. Refer to the usage examples provided in `lib/components/adder` and `lib/components/concater`.

## Configuration

### For Windows

1. Build the `.dll` from `core` (or your own native source).
2. Move the `.dll` file into the `windows/` directory.
3. Add the following script to `windows/runner/CMakeLists.txt` (**not** `windows/CMakeLists.txt`):

```cmake
   set(DLL_SOURCE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../libcore.dll")

   add_custom_command(
     TARGET ${BINARY_NAME} POST_BUILD
     COMMAND ${CMAKE_COMMAND} -E copy_if_different
       "${DLL_SOURCE_PATH}"
       "$<TARGET_FILE_DIR:${BINARY_NAME}>/libcore.dll"
     COMMENT "Copying libcore.dll to output directory"
   )
```

### For macOS

1. Build the `.dylib` from `core` (or your own native source).
2. Open `macos/Runner.xcworkspace` in Xcode.
3. Drag the `.dylib` file into the **Frameworks** group in the Project Navigator.
4. When prompted, select the `Runner` target and click **Finish**.
   ![Step 4](screenshot/macos/1.png)
5. Under **Build Phases → Link Binary with Libraries**, set the status of the `.dylib` to **Optional**.
   If it's not listed, add it manually.
   ![Step 5](screenshot/macos/2.png)
6. Add the `.dylib` file to both **Copy Bundle Resources** and **Embed Frameworks**.
   Ensure **Code Sign on Copy** is checked.
   ![Step 6](screenshot/macos/3.png)
7. Confirm the `.dylib` appears under **Frameworks, Libraries, and Embedded Content**
   with **Embed & Sign** selected.
   ![Step 7](screenshot/macos/4.png)

### For iOS

1. Build the `.xcframework` from `core` (or your own native source).
2. Move the `.xcframework` folder into the `ios/` directory.
3. Open `ios/Runner.xcworkspace` in Xcode.
4. Navigate to **General → Frameworks, Libraries, and Embedded Content** and click **+**.
   ![Step 4](screenshot/ios/1.png)
5. Choose **Add Other → Add Files**, then select the `.xcframework` folder.
   ![Step 5](screenshot/ios/2.png)
6. In **Build Settings**, search for `Dead Code Stripping` and set it to **No**.
   ![Step 6](screenshot/ios/3.png)
7. In **Build Settings**, search for `Other Linker Flags`.
   ![Step 7](screenshot/ios/4.png)
8. Add the following flags — use the **simulator** entry for Debug, and the **device** entry for Profile/Release:

   **Debug (Simulator):**  
   `-force_load`  
   `$(PROJECT_DIR)/libcore.xcframework/ios-arm64-simulator/libcore-sim.a`

   **Profile / Release (Device):**  
   `-force_load`  
   `$(PROJECT_DIR)/libcore.xcframework/ios-arm64/libcore-device.a`

   ![Step 8](screenshot/ios/5.png)

### For Android

1. Build the `.so` file from `core` (or your own native source).
2. Move the `.so` file into `android/app/src/main/jniLibs/arm64-v8a/`.
   Create the directory manually if it does not exist.