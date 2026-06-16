# The following variables contains the files used by the different stages of the build process.
set(My_Project_default_default_AVR_GCC_FILE_TYPE_assemble)
set_source_files_properties(${My_Project_default_default_AVR_GCC_FILE_TYPE_assemble} PROPERTIES LANGUAGE ASM)

# For assembly files, add "." to the include path for each file so that .include with a relative path works
foreach(source_file ${My_Project_default_default_AVR_GCC_FILE_TYPE_assemble})
        set_source_files_properties(${source_file} PROPERTIES INCLUDE_DIRECTORIES "$<PATH:NORMAL_PATH,$<PATH:REMOVE_FILENAME,${source_file}>>")
endforeach()

set(My_Project_default_default_AVR_GCC_FILE_TYPE_assembleWithPreprocess)
set_source_files_properties(${My_Project_default_default_AVR_GCC_FILE_TYPE_assembleWithPreprocess} PROPERTIES LANGUAGE ASM)

# For assembly files, add "." to the include path for each file so that .include with a relative path works
foreach(source_file ${My_Project_default_default_AVR_GCC_FILE_TYPE_assembleWithPreprocess})
        set_source_files_properties(${source_file} PROPERTIES INCLUDE_DIRECTORIES "$<PATH:NORMAL_PATH,$<PATH:REMOVE_FILENAME,${source_file}>>")
endforeach()

set(My_Project_default_default_AVR_GCC_FILE_TYPE_compile
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_01/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_02/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_03/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_04/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_05/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_06/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_07/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_08/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_09/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_10/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_11/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_12/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_13/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../lesson_14/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../project_01/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../project_02/main.c")
set_source_files_properties(${My_Project_default_default_AVR_GCC_FILE_TYPE_compile} PROPERTIES LANGUAGE C)
set(My_Project_default_default_AVR_GCC_FILE_TYPE_compile_cpp)
set_source_files_properties(${My_Project_default_default_AVR_GCC_FILE_TYPE_compile_cpp} PROPERTIES LANGUAGE CXX)
set(My_Project_default_default_AVR_GCC_FILE_TYPE_link)
set(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_ihex)
set(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_eep)
set(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_lss)
set(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_srec)
set(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_sig)
set(My_Project_default_image_name "default.elf")
set(My_Project_default_image_base_name "default")

# The output directory of the final image.
set(My_Project_default_output_dir "${CMAKE_CURRENT_SOURCE_DIR}/../../../out/My_Project")

# The full path to the final image.
set(My_Project_default_full_path_to_image ${My_Project_default_output_dir}/${My_Project_default_image_name})

# Potential output file extensions
set(output_extensions
    .hex
    .lss
    .eep
    .srec
    .usersignatures)
list(TRANSFORM output_extensions PREPEND "${My_Project_default_output_dir}/${My_Project_default_image_base_name}")
