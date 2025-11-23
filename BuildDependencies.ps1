$SRC_DIR = "$(Get-Location)\src"
$OUT_DIR = "$(Get-Location)\out"

# ORDER:
# 1. pkgconf
# 2. ZLIB
# 3. libpng and libjpeg
# 4. iconv, libxml2 and libxslt
# 5. glib, gtk and pango
# 6. glibmm, gtkmm and pangomm

cd ${SRC_DIR}/pkgconf
mkdir build -p
cd build
meson setup ..
meson compile
meson install --destdir=${OUT_DIR} --no-rebuild

$PKG_CONFIG_EXECUTABLE="${OUT_DIR}\bin\pkgconf.exe"

cd ${SRC_DIR}/zlib
mkdir build -p
cd build
cmake .. -DCMAKE_PREFIX_PATH=${OUT_DIR}
cmake --build . --config Release
cmake --install . --prefix ${OUT_DIR}

cd ${SRC_DIR}/libpng
mkdir build -p
cd build
cmake .. -DCMAKE_PREFIX_PATH=${OUT_DIR}
cmake --build . --config Release
cmake --install . --prefix ${OUT_DIR}

cd ${SRC_DIR}/libjpeg
mkdir build -p
cd build
cmake .. -DCMAKE_PREFIX_PATH=${OUT_DIR}
cmake --build . --config Release
cmake --install . --prefix ${OUT_DIR}

cd ${SRC_DIR}/libiconv
mkdir build -p
cd build
../configure.ac
make
make install

cd ${SRC_DIR}/libxml2
mkdir build -p
cd build
cmake .. -DCMAKE_PREFIX_PATH=${OUT_DIR}
cmake --build . --config Release
cmake --install . --prefix ${OUT_DIR}

cd ${SRC_DIR}/libxslt
mkdir build -p
cd build
cmake .. -DCMAKE_PREFIX_PATH=${OUT_DIR} -DLIBXSLT_WITH_PROGRAMS=ON
cmake --build . --config Release
cmake --install . --prefix ${OUT_DIR}

cd ${SRC_DIR}/glib
mkdir build -p
cd build
meson setup ..
meson compile
meson install --destdir=${OUT_DIR}

cd ${SRC_DIR}/gtk
mkdir build -p
cd build
meson setup .. --prefix=${OUT_DIR}
meson compile



##############################
# 2geom dependencies
##############################

cd ${SRC_DIR}/boost
git submodule init
git submodule update --init --recommend-shallow
mkdir build -p
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
cmake --install . --prefix=${OUT_DIR}

cd ${SRC_DIR}/double-conversion
git submodule init
git submodule update --init --recommend-shallow
# We use a different name as build dir because a file 'build' already exists
mkdir cmake-build -p
cd cmake-build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
cmake --install . --prefix=${OUT_DIR}

cd ${SRC_DIR}/gsl
git submodule init
git submodule update --init --recommend-shallow
mkdir build -p
cd build
# We disable tests because they use "unistd.h" which is a POSIX-only header
cmake .. -DCMAKE_BUILD_TYPE=Release -DGSL_DISABLE_TESTS=ON
cmake --build . --config Release
cmake --install . --prefix=${OUT_DIR}