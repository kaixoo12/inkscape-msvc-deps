# Inkscape MSVC dependencies

A set of scripts that lets you get and build Inkscape's dependencies to a ZIP file, without needing MSYS2 or vcpkg.

## Dependencies

- MSVC (Microsoft Visual Compiler). **You do NOT need Visual Studio IDE.** In fact, we don't recommend installing it as it's a 15GB+ download. You only need MSVC.

- CMake (Winget)

- Meson (Winget)

- Doxygen (Winget)

- Make (Winget)

## How it works

- We first get the source code of all the dependencies we need (`1-GetDependencies.ps1` script).
- We build each dependency from source. Some projects use CMake while others use Meson, hence we need both.
- When the project is built, we install the resulting files (`cmake --install` or `meson install`) into an `out/` directory. This will be the directory that you'll need to copy to Inkscape's source code. This is the `2-BuilDependencies.ps1` script.
