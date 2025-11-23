# Inkscape MSVC dependencies

> ⚠️ **This is an internal repo for inkscape maintainers.** ⚠️
>
> If you're just a regular person who wants to build Inkscape in Windows using MSVC, you only need to download the .zip file in the Releases tab, add it somewhere in your system, and set: `meson setup .. --prefix=<your_folder_location>`

A set of scripts that lets you get and build Inkscape's dependencies to a ZIP file, without needing MSYS2 or vcpkg.

> You can also get the dependencies from vcpkg or conan package manager if you prefer that.

## Dependencies

- MSVC (Microsoft Visual Compiler). **You do NOT need Visual Studio IDE.** In fact, we don't recommend installing it as it's a 15GB+ download. You only need MSVC.

- Git (Winget)

- CMake (Winget)

- Meson (Winget)

- Doxygen (Winget)

## How it works

**1. 🛒 Get the required dependencies.**

- Open a Powershell terminal and install these programs:

```
winget install -e --id Git.Git
winget install -e --id Kitware.CMake
winget install -e --id mesonbuild.meson
winget install -e --id DimitriVanHeesch.Doxygen
```

- Get Microsoft Visual Compiler (MSVC)

Go to [this link](https://visualstudio.microsoft.com/it/downloads/).

Scroll down here:

![Visual Studio Download Screen](/vshome.png)

Click **download** where it says **Build Tools For Visual Studio**.

An installer will be downloaded. It will ask for admin priviledges. It will only install the **Visual Studio Tools** like the compiler (`cl.exe`) and linker (`link.exe`), **NOT the Visual Studio IDE**.

**2. ⬇️ Clone the repository and get the submodules.**

Open powershell and run:

```
git clone https://github.com/Advanced-Effects/inkscape-msvc-deps.git
```

Enter into the directory and get the submodules. 

> ⚠️ It is IMPORTANT that you include the `--recommend-shallow` flag. Else, the download will take a very, very long time.

```
cd inkscape-msvc-deps
git submodule init
git submodule update --init --recommend-shallow
```

**3. 🧱 Build the dependencies**

Run `.\BuildDependencies.ps1`