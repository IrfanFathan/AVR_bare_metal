# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "/home/irfan/develop/AVR_bare_metal/out/My_Project/default.eep"
  "/home/irfan/develop/AVR_bare_metal/out/My_Project/default.hex"
  "/home/irfan/develop/AVR_bare_metal/out/My_Project/default.lss"
  "/home/irfan/develop/AVR_bare_metal/out/My_Project/default.srec"
  "/home/irfan/develop/AVR_bare_metal/out/My_Project/default.usersignatures"
  )
endif()
