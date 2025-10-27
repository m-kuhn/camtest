Reproduces an issue where a simple app for showing the camera in a qml view crashes on start.

## Build shared libs (works well)
```
# Bootstrap vcpkg on windows: clone https://github.com/microsoft/vcpkg.git and run the bootstrap script
.\vcpkg.exe install qtdeclarative "qtmultimedia[ffmpeg,qml]" --triplet x64-windows --host-triplet x64-windows --x-buildtrees-root=C:/src

# Hint: add -DCMAKE_LIBRARY_PATH="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.20348.0\um\x64" if it complains about WMF missing

cmake -G "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE='C:\path\to\vcpkg\scripts\buildsystems\vcpkg.cmake' -DVCPKG_TARGET_TRIPLET=x64-windows -S . -B build
cmake --build build --config Release

# Set some environment variables to make Qt find the required plugins
$env:QML_IMPORT_PATH = "C:\Users\Public\dev\vcpkg\installed\x64-windows-release\Qt6\qml"
$env:QT_PLUGIN_PATH="C:\Users\Public\dev\vcpkg\installed\x64-windows-release\Qt6\plugins\"
```

## Build static libs (crashes on start)
```
.\vcpkg.exe install qtdeclarative "qtmultimedia[ffmpeg,qml]" --triplet x64-windows-static --host-triplet x64-windows-static --x-buildtrees-root=C:/src

# Hint: add -DCMAKE_LIBRARY_PATH="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.20348.0\um\x64" if it complains about WMF missing

cmake -G "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE='C:\path\to\vcpkg\scripts\buildsystems\vcpkg.cmake' -DVCPKG_TARGET_TRIPLET=x64-windows-static -S . -B build
cmake --build build --config Release
```