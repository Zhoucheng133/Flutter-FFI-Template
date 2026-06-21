# Flutter FFI Dynamic Library Template

## Steps

### For Windows
1. Build dll from `core` or else
2. Move dll file to `windows`
3. Add following script to `windows/runner/CMakeLists.txt` (NOT `windows/CMakeLists.txt`)
   ```
   set(DLL_SOURCE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../libcore.dll")

   add_custom_command(
      TARGET ${BINARY_NAME} POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy_if_different
         "${DLL_SOURCE_PATH}"
         "$<TARGET_FILE_DIR:${BINARY_NAME}>/libcore.dll"
      COMMENT "Copy dll file"
   )
   ```

### For macOS

1. Build dylib from `core` or else
2. Open `macos/Runner.xcworkspace` with Xcode
3. Drag dylib file to Frameworks
4. Choose the target `Runner` and click Finish
   ![step4](screenshot/macos/1.png)
5. Change Status for `Link Binary with Libraries` to Optional (if not included, add it manually)
   ![step5](screenshot/macos/2.png)
6. Add dylib file to `Copy Bundle Resources` and `Bundle Framework`, and make sure the `Code Sign On Copy` is selected
   ![step6](screenshot/macos/3.png)
7. Make sure the dylib file is shown on `Frameworks, Libraries, and Embedded Content` and `Embed & Sign` is choosen
   ![step7](screenshot/macos/4.png)


### For iOS

1. Build xcframework from `core` or else
2. Move xcframework file to `ios`
3. Open `iOS/Runner.xcworkspace` with Xcode
4. Add `Frameworks, Libraries, and Embedded Content`
   ![step3](screenshot/ios/1.png)
5. Select `Add Other` - `Add Files` and select xcframework folder
   ![step4](screenshot/ios/2.png)
6. Search `Dead Code` on `Build Settings` and set `Dead Code Stripping` to `No`
   ![step5](screenshot/ios/3.png)
7. Search `Other Linker Flags` on `Build Settings`
   ![step6](screenshot/ios/4.png)
8. Add these these lines for debug and profile/release:
   ```
   -force_load
   $(PROJECT_DIR)/libcore.xcframework/ios-arm64-simulator/libcore-sim.a
   ```
   ```
   -force_load
   $(PROJECT_DIR)/libcore.xcframework/ios-arm64/libcore-device.a
   ```
   ![step7](screenshot/ios/5.png)