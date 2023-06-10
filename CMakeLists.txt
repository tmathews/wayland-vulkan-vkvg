cmake_minimum_required(VERSION 3.0)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(wayland-vulkan-example)

add_definitions("-g")

include_directories("${PROJECT_SOURCE_DIR}/src")

add_custom_target(directories COMMAND mkdir -p ${PROJECT_SOURCE_DIR}/bin)

file(GLOB SOURCES "${PROJECT_SOURCE_DIR}/src/*.c")
add_executable(wayland-vulkan-example ${SOURCES})
set_target_properties(wayland-vulkan-example PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin/")
add_dependencies(directories wayland-vulkan-example)

function(add_wayland_protocol_target TARGET_NAME SPEC NAME)
    add_custom_target(wayland_${TARGET_NAME}_header COMMAND wayland-scanner client-header /usr/share/wayland-protocols${SPEC} ${PROJECT_SOURCE_DIR}/src/${NAME}.h)
    add_dependencies(wayland-vulkan-example wayland_${TARGET_NAME}_header)
    add_custom_target(wayland_${TARGET_NAME}_source COMMAND wayland-scanner private-code /usr/share/wayland-protocols${SPEC} ${PROJECT_SOURCE_DIR}/src/${NAME}.c)
    add_dependencies(wayland-vulkan-example wayland_${TARGET_NAME}_source)
endfunction()

add_wayland_protocol_target(xdg_shell "/stable/xdg-shell/xdg-shell.xml" xdg-shell)

target_link_libraries(wayland-vulkan-example vulkan)
target_link_libraries(wayland-vulkan-example wayland-client)
