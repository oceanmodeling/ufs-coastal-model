help([[
loads UFS Model prerequisites for Frontera/Intel
]])

prepend_path("MODULEPATH", "/work2/06146/tg854455/frontera/spack-stack/modulefiles")
load("ecflow/5.8.4")

prepend_path("MODULEPATH", "/work2/01118/tg803972/frontera/spack-stack/spack-stack-1.6.0/envs/unified-env/install/modulefiles/Core")

stack_intel_ver=os.getenv("stack_intel_ver") or "19.1.1.217"
load(pathJoin("stack-intel", stack_intel_ver))

stack_impi_ver=os.getenv("stack_impi_ver") or "2020.4.304"
load(pathJoin("stack-intel-mpi", stack_impi_ver))

cmake_ver=os.getenv("cmake_ver") or "3.24.2"
load(pathJoin("cmake", cmake_ver))
--load("cmake/3.24.2")

--load("ufs_common")
--quick fix for https://github.com/JCSDA/spack-stack/issues/1388
local ufs_modules = {
  {["jasper"]          = "2.0.32"},
  {["zlib"]            = "1.2.13"},
  {["libpng"]          = "1.6.37"},
  {["hdf5"]            = "1.14.0"},
  {["netcdf-c"]        = "4.9.2"},
  {["netcdf-fortran"]  = "4.6.1"},
  {["parallelio"]      = "2.5.10"},
  {["esmf"]            = "8.6.0"},
  {["fms"]             = "2023.04"},
  {["bacio"]           = "2.4.1"},
  {["crtm"]            = "2.4.0"},
  {["g2"]              = "3.4.5"},
  {["g2tmpl"]          = "1.10.2"},
  {["ip"]              = "4.3.0"},
  {["sp"]              = "2.5.0"},
  {["w3emc"]           = "2.10.0"},
  {["gftl-shared"]     = "1.6.1"},
  {["mapl"]            = "2.40.3-esmf-8.6.0"},
  {["scotch"]          = "7.0.4"},
}

for i = 1, #ufs_modules do
  for name, default_version in pairs(ufs_modules[i]) do
    local env_version_name = string.gsub(name, "-", "_") .. "_ver"
    load(pathJoin(name, os.getenv(env_version_name) or default_version))
  end
end

stack_python_ver=os.getenv("stack_python_ver") or "3.10.13"
load(pathJoin("stack-python", stack_python_ver))

nccmp_ver=os.getenv("nccmp_ver") or "1.9.0.1"
load(pathJoin("nccmp", nccmp_ver))

setenv("CC", "mpiicc")
setenv("CXX", "mpiicpc")
setenv("FC", "mpiifort")
setenv("CMAKE_Platform", "frontera.intel")

whatis("Description: UFS build environment")
