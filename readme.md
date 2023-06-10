# Wayland Vulkan Example

An example of using Wayland with Vulkan.

## Building

To build the project run the following commands:

```sh
mkdir -p build
cd build
cmake ..
make
cmake ..
make
```

`cmake` and `make` must be run twice because the first run generates source files which require a re-scan to be included in the build. The resulting binary can be found at `bin/wayland-vulkan-example`.

## License

Created by Amini Allight. The contents of this repository are licensed under Creative Commons Zero (CC0 1.0), placing them in the public domain.
