include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(My_Project_default_library_list )

# Handle files with suffix s, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_assemble)
add_library(My_Project_default_default_AVR_GCC_assemble OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_assemble})
    My_Project_default_default_AVR_GCC_assemble_rule(My_Project_default_default_AVR_GCC_assemble)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_assemble>")

endif()

# Handle files with suffix S, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_assembleWithPreprocess)
add_library(My_Project_default_default_AVR_GCC_assembleWithPreprocess OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_assembleWithPreprocess})
    My_Project_default_default_AVR_GCC_assembleWithPreprocess_rule(My_Project_default_default_AVR_GCC_assembleWithPreprocess)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_assembleWithPreprocess>")

endif()

# Handle files with suffix [cC], for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_compile)
add_library(My_Project_default_default_AVR_GCC_compile OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_compile})
    My_Project_default_default_AVR_GCC_compile_rule(My_Project_default_default_AVR_GCC_compile)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_compile>")

endif()

# Handle files with suffix cpp, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_compile_cpp)
add_library(My_Project_default_default_AVR_GCC_compile_cpp OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_compile_cpp})
    My_Project_default_default_AVR_GCC_compile_cpp_rule(My_Project_default_default_AVR_GCC_compile_cpp)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_compile_cpp>")

endif()

# Handle files with suffix elf, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_ihex)
add_library(My_Project_default_default_AVR_GCC_objcopy_ihex OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_ihex})
    My_Project_default_default_AVR_GCC_objcopy_ihex_rule(My_Project_default_default_AVR_GCC_objcopy_ihex)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_objcopy_ihex>")

endif()

# Handle files with suffix elf, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_eep)
add_library(My_Project_default_default_AVR_GCC_objcopy_eep OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_eep})
    My_Project_default_default_AVR_GCC_objcopy_eep_rule(My_Project_default_default_AVR_GCC_objcopy_eep)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_objcopy_eep>")

endif()

# Handle files with suffix elf, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_lss)
add_library(My_Project_default_default_AVR_GCC_objcopy_lss OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_lss})
    My_Project_default_default_AVR_GCC_objcopy_lss_rule(My_Project_default_default_AVR_GCC_objcopy_lss)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_objcopy_lss>")

endif()

# Handle files with suffix elf, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_srec)
add_library(My_Project_default_default_AVR_GCC_objcopy_srec OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_srec})
    My_Project_default_default_AVR_GCC_objcopy_srec_rule(My_Project_default_default_AVR_GCC_objcopy_srec)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_objcopy_srec>")

endif()

# Handle files with suffix elf, for group default-AVR-GCC
if(My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_sig)
add_library(My_Project_default_default_AVR_GCC_objcopy_sig OBJECT ${My_Project_default_default_AVR_GCC_FILE_TYPE_objcopy_sig})
    My_Project_default_default_AVR_GCC_objcopy_sig_rule(My_Project_default_default_AVR_GCC_objcopy_sig)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_AVR_GCC_objcopy_sig>")

endif()


# Main target for this project
add_executable(My_Project_default_image_apWc0xcm ${My_Project_default_library_list})

set_target_properties(My_Project_default_image_apWc0xcm PROPERTIES
    OUTPUT_NAME "default"
    SUFFIX ".elf"
    ADDITIONAL_CLEAN_FILES "${output_extensions}"
    RUNTIME_OUTPUT_DIRECTORY "${My_Project_default_output_dir}")
target_link_libraries(My_Project_default_image_apWc0xcm PRIVATE ${My_Project_default_default_AVR_GCC_FILE_TYPE_link})

#Add objcopy steps
My_Project_default_objcopy_ihex_rule(My_Project_default_image_apWc0xcm)
My_Project_default_objcopy_eep_rule(My_Project_default_image_apWc0xcm)
My_Project_default_objcopy_lss_rule(My_Project_default_image_apWc0xcm)
My_Project_default_objcopy_srec_rule(My_Project_default_image_apWc0xcm)
My_Project_default_objcopy_sig_rule(My_Project_default_image_apWc0xcm)
# Add the link options from the rule file.
My_Project_default_link_rule( My_Project_default_image_apWc0xcm)

add_custom_target(
    merge_loadable_files ALL
    COMMAND hexmate  /home/irfan/develop/AVR_bare_metal/lesson_01/blink.hex /home/irfan/develop/AVR_bare_metal/lesson_02/lession_two.hex /home/irfan/develop/AVR_bare_metal/lesson_03/lession_three.hex /home/irfan/develop/AVR_bare_metal/lesson_04/lession_4.hex /home/irfan/develop/AVR_bare_metal/lesson_06/lession_06.hex /home/irfan/develop/AVR_bare_metal/lesson_07/lession_07.hex /home/irfan/develop/AVR_bare_metal/lesson_08/lession_08.hex /home/irfan/develop/AVR_bare_metal/lesson_09/lession_09.hex /home/irfan/develop/AVR_bare_metal/lesson_10/lession_10.hex /home/irfan/develop/AVR_bare_metal/lesson_11/lession_11.hex /home/irfan/develop/AVR_bare_metal/lesson_12/lesson_12.hex /home/irfan/develop/AVR_bare_metal/lesson_13/lesson_13.hex /home/irfan/develop/AVR_bare_metal/project_01/project_01.hex /home/irfan/develop/AVR_bare_metal/project_02/project_02.hex ${CMAKE_CURRENT_SOURCE_DIR}/../../../out/My_Project/default.hex  -O${CMAKE_CURRENT_SOURCE_DIR}/../../../out/My_Project/default-unified.hex
    BYPRODUCTS ${CMAKE_CURRENT_SOURCE_DIR}/../../../out/My_Project/default-unified.hex
    COMMENT "Merging loadable hex files into unified image")
add_dependencies(merge_loadable_files My_Project_default_image_apWc0xcm)

