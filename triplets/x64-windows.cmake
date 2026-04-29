set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
# Static library linkage fixes Qt plugin LNK1107 ("invalid or corrupt file:
# cannot read at 0x3C0") on qsvgicond.dll and similar large DLLs.
set(VCPKG_LIBRARY_LINKAGE static)

# Write debug info to separate .pdb files instead of embedding it in every
# .obj. Required to:
#   - prevent corrupted Qt plugin DLLs (LNK1107)
#   - keep static archives like opentxs.lib under the 4 GB PE/COFF limit (LNK1248)
#   - allow stepping into Qt/Boost/opentxs sources under MSVC
set(VCPKG_CXX_FLAGS_RELEASE "/Zi")
set(VCPKG_C_FLAGS_RELEASE   "/Zi")
set(VCPKG_CXX_FLAGS_DEBUG   "/Zi /Od /Oy-")
set(VCPKG_C_FLAGS_DEBUG     "/Zi /Od /Oy-")

# CMake 4.x + Ninja + MSVC C++20 module dependency scanner regression.
# Without these, opentxs (which contains opentxs.cppm) fails with:
#   ninja: error: 'CMakeFiles/opentxs-common@synth_*.dir/CXX.dd', missing
#
# Three flags, each addressing a separate layer of the bug:
#
#   CMAKE_DEPENDS_USE_COMPILER=OFF
#     Restores CMake's pre-4.x dependency tracking for the Makefile generator.
#     Necessary but not sufficient on Ninja.
#
#   CMAKE_CXX_SCAN_FOR_MODULES=OFF
#     Disables the Ninja generator's C++20 module dyndep scan globally. This
#     is what actually prevents the missing CXX.dd file under Ninja+MSVC.
#
#   OT_ENABLE_MODULE=OFF
#     opentxs-specific. opentxs registers opentxs.cppm via a FILE_SET
#     CXX_MODULES, which forces module scanning on that target *regardless*
#     of the global SCAN_FOR_MODULES setting. Disabling OT_ENABLE_MODULE
#     stops opentxs from registering the module source in the first place.
#     Harmless for non-opentxs ports (CMake ignores unused cache vars).
set(VCPKG_CMAKE_CONFIGURE_OPTIONS
    -DCMAKE_DEPENDS_USE_COMPILER=OFF
    -DCMAKE_CXX_SCAN_FOR_MODULES=OFF
    -DOT_ENABLE_MODULE=OFF
)

