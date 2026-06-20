# Flutter FFI Dynamic Library Template

## Steps

### For macOS

1. Generate dylib from `core`
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