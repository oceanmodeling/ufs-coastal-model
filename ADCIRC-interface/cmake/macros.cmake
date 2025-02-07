# adds mpi support
macro(add_mpi TARGET)
  if(MPI)
    target_include_directories(${TARGET} PRIVATE ${MPI_Fortran_INCLUDE_PATH})
    target_compile_definitions(${TARGET} PRIVATE CMPI)
    #target_link_libraries(${TARGET} ${MPI_Fortran_LIBRARIES})
  endif()
endmacro()

# adds netcdf support
macro(add_netcdf TARGET)
  if(NetCDF_Fortran_FOUND)
    target_compile_definitions(${TARGET} PRIVATE ADCNETCDF)
    if(NetCDF4_FOUND)
      target_compile_definitions(${TARGET} PRIVATE HAVE_NETCDF4)
      target_compile_definitions(${TARGET} PRIVATE NETCDF_CAN_DEFLATE)
    endif()
    target_include_directories(${TARGET} PRIVATE ${NetCDF_Fortran_INCLUDE_DIRS})
    target_link_libraries(${TARGET} PUBLIC NetCDF::NetCDF_Fortran)
  endif()
endmacro()
