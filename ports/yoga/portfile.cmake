include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO facebook/yoga
    REF 1.18.0
    SHA512 dba75bff0fd3b72a3c17a6856253bd14d8af7fbb2832b432118c6ee509f9fe234874969a9cfb56690ec5a2649637a6bf090da5c5f5e8907c1e1e9c09f05977e2
    HEAD_REF master
    PATCHES add-project-declaration.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_build_cmake()
vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/yoga DESTINATION ${CURRENT_PACKAGES_DIR}/include FILES_MATCHING PATTERN "*.h")

set(YOGA_LIB_PREFFIX )
if (NOT VCPKG_TARGET_IS_WINDOWS)
    set(YOGA_LIB_PREFFIX lib)
endif()
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    set(YOGA_BINARY_PATH )
    if (VCPKG_TARGET_IS_WINDOWS)
        set(YOGA_BINARY_PATH Release/)
    endif()
    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${YOGA_BINARY_PATH}${YOGA_LIB_PREFFIX}yogacore${VCPKG_TARGET_STATIC_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
endif()
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    set(YOGA_BINARY_PATH )
    if (VCPKG_TARGET_IS_WINDOWS)
        set(YOGA_BINARY_PATH Debug/)
    endif()
    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${YOGA_BINARY_PATH}${YOGA_LIB_PREFFIX}yogacore${VCPKG_TARGET_STATIC_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
