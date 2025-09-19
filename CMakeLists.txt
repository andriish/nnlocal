cmake_minimum_required(VERSION 3.16)
project(NNLOCAL LANGUAGES Fortran)

# -------------------------------------------------------------------
# Configuration Options
# -------------------------------------------------------------------
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules ${CMAKE_MODULE_PATH})
include("CMakePrintHelpers")
include("GNUInstallDirs")
option(NNLOCAL_ENABLE_LHAPDF "Enable compilation with LHAPDF" ON)

message(STATUS "NNLOCAL: NNLOCAL_ENABLE_LHAPDF             ${NNLOCAL_ENABLE_LHAPDF}")

# -------------------------------------------------------------------
# Compiler Flags
# -------------------------------------------------------------------

# Detect and set Fortran flags based on compiler
if(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel" OR CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
    # Flags for Intel Fortran (classic or LLVM-based)
    set(CMAKE_Fortran_FLAGS "-traceback -g -O2  -diag-disable 8291 -diag-disable 6375 -extend-source 132")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "NVHPC")
    # NVIDIA HPC Fortran
    set(CMAKE_Fortran_FLAGS "-g -Mbounds -Mpreprocess -Mextend")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
    # GNU Fortran
    set(CMAKE_Fortran_FLAGS "-fno-automatic -std=legacy -fno-f2c -g -ffixed-line-length-none")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "LFortran")
    # LFortran
    set(CMAKE_Fortran_FLAGS "--implicit-interface -g --fixed-form --implicit-typing")
else()
    message(WARNING "Unknown Fortran compiler: ${CMAKE_Fortran_COMPILER_ID}. Using default flags.")
    set(CMAKE_Fortran_FLAGS "-g")
endif()
message(STATUS "NNLOCAL: CMAKE_Fortran_COMPILER_ID         ${CMAKE_Fortran_COMPILER_ID}")
message(STATUS "NNLOCAL: CMAKE_Fortran_FLAGS               ${CMAKE_Fortran_FLAGS}")

# -------------------------------------------------------------------
# Dependencies
# -------------------------------------------------------------------
if(NNLOCAL_ENABLE_LHAPDF)
    find_package(LHAPDF REQUIRED)
    cmake_print_properties(TARGETS LHAPDF::LHAPDF PROPERTIES LOCATION INTERFACE_INCLUDE_DIRECTORIES)
endif()

# -------------------------------------------------------------------
# Includes
# -------------------------------------------------------------------

include_directories(src/Inc src/Intcts/include src/hp_Intcts/include )


# Source file groups
set(
HPINTCTS 
hp_Iopmat2.f hp_cli2.f hp_Li3.f hp_WGPLG.f hp_mylog.f hp_glog.f hp_a12srscrsgg.f hp_a2srsgg.f 
hp_a2carssrsgg.f hp_a2carbssrsgg.f hp_a2carsggg.f hp_a2carsggg_bulk.f hp_a2carbsgggg.f hp_a2carbsgggg_bulk.f
 hp_a12srsssgg.f hp_a12srscasssgg.f hp_a12carscasggg.f hp_a12carssrsssgg.f hp_a12casbrcasgggg.f 
 hp_a12carssrscrsgg.f hp_a12carssrscasssgg.f hp_AGTBa12carscrsggg.f hp_BGTAa12carscrsggg.f hp_a12carscrs.f
  hp_AGTBa12carscrsssggg.f hp_BGTAa12carscrsssggg.f hp_a12carscrsss.f hp_AGTBa12carscasssggg.f
   hp_BGTAa12carscasssggg.f hp_a12carscasss.f hp_AGTBa12carsssggg.f hp_BGTAa12carsssggg.f hp_a12carsss.f
    hp_a1a1cassscarsragg.f hp_a1a1cbrcasgggg.f hp_a1a1cassssragg.f hp_a1a1sscarsragg.f hp_a1a1carcasggg.f 
    hp_a1a1sssrgg.f hp_AGTBa1a1crscasggg.f hp_BGTAa1a1crscasggg.f hp_a1a1crscas.f hp_AGTBa1a1crssscarggg.f
     hp_BGTAa1a1crssscarggg.f hp_a1a1crssscar.f hp_AGTBa1a1sscarggg.f hp_BGTAa1a1sscarggg.f hp_a1a1sscar.f 
     hp_rva1ncar1gg.f hp_rva1sr1g.f hp_rva1carsr1g.f hp_a1ncar0gg.f hp_a1sr0g.f hp_a1carsr0g.f hp_a1c1cargggg.f 
     hp_a1c1cbrgggg.f hp_APfactors.f)
list(TRANSFORM HPINTCTS    PREPEND "src/hp_Intcts/")

set(
INTCTS  
Iopmat2.f cli2.f Li3.f WGPLG.f mylog.f glog.f a12srscrsgg.f a2srsgg.f a2carssrsgg.f a2carbssrsgg.f a2carsggg.f 
a2carsggg_bulk.f a2carbsgggg.f a2carbsgggg_bulk.f a12srsssgg.f a12srscasssgg.f a12carscasggg.f a12carssrsssgg.f 
a12casbrcasgggg.f a12carssrscrsgg.f a12carssrscasssgg.f AGTBa12carscrsggg.f BGTAa12carscrsggg.f a12carscrs.f 
AGTBa12carscrsssggg.f BGTAa12carscrsssggg.f a12carscrsss.f AGTBa12carscasssggg.f BGTAa12carscasssggg.f 
a12carscasss.f AGTBa12carsssggg.f BGTAa12carsssggg.f a12carsss.f a1a1cassscarsragg.f a1a1cbrcasgggg.f 
a1a1cassssragg.f a1a1sscarsragg.f a1a1carcasggg.f a1a1sssrgg.f AGTBa1a1crscasggg.f BGTAa1a1crscasggg.f 
a1a1crscas.f AGTBa1a1crssscarggg.f BGTAa1a1crssscarggg.f a1a1crssscar.f AGTBa1a1sscarggg.f BGTAa1a1sscarggg.f 
a1a1sscar.f rva1ncar1gg.f rva1sr1g.f rva1carsr1g.f a1ncar0gg_loprec.f a1ncar0gg.f a1sr0g.f a1carsr0g.f 
a1c1cargggg.f a1c1cbrgggg.f APfactors.f)
list(TRANSFORM INTCTS   PREPEND "src/Intcts/")

set(
GGHFILES  
finitemtcorr.f Ftriangle.f gg_hgaga_v_cf.f gg_hgamgam.f gg_hgamgam_v.f gg_hgamgam_gvec.f gg_hgamgam_gvecgvec.f 
gg_hgamgam_v_cf.f gg_hgamgam_gs_cf.f gg_hgamgam_vgvec_cf.f gg_hgagag_gs_colorful.f gg_hgagag.f gg_hgagagg.f 
gg_hgagag_gvec.f gg_hgagag_v.f gg_hg_z_cf.f gg_hg_z_wrap.f gg_htot.f h4g.f hqqgg.f hjetfill.f msqgamgam.f)
list(TRANSFORM GGHFILES    PREPEND "src/ggH/")

set(
INTEGRATEFILES 
dgauss.f ebook.f mbook.f ran0.f ran1.f rn.f vegas.f)
list(TRANSFORM INTEGRATEFILES    PREPEND "src/Integrate/")

set(
NEEDFILES  
aveptjet.f banner.f boost.f checkndotp.f checkversion.f ckmfill.f compnewgridpar.f90
computepdfuncertainty.f coupling.f coupling2.f couplz.f ddilog.f dzero.f dipolesubA1_colorful.f 
dipolesubRVA1_colorful.f dipolesubA2_colorful.f dipolesubA12_colorful.f determinefilenames.f dipoles_cf.f 
donothing_gvec.f dot.f dotem.f etmiss.f getbs.f getptilde.f getptildejet.f higgsp.f higgsw.f histofin.f 
hbbdecay.f htautaudecay.f hwwdecay.f hbbdecay_g.f hbbdecay_v.f Iopmat1.f includedipole.f interpolate_hto.f 
is_functions.f lenocc.f lnrat.f masscuts.f mfrun.f nnlocal_main.f nnlocal_exit.f nnlocal_init.f nnlocal_vegas.f 
ptyrap.f r.f read_jetcuts.f reader_input.f realhistos.f scaleset.f scaleset_m34.f scaleset_Msqpt34sq.f scaleset_HT.f
 sethparams.f setmb_msbar.f setrunname.f setvdecay.f smalls.f spinoru.f storeptilde.f swapjet.f transformA1_colorful.f 
 transformA2_colorful.f writeinfo.f writeinput.f writeout.f zeromsq.f)
list(TRANSFORM NEEDFILES   PREPEND "src/Need/")

set(
PARTONFILES  
alfamz.f checkpath.f newton1.f)
list(TRANSFORM PARTONFILES   PREPEND "src/Parton//")

set(
PSLIMITFILES 
genlimit.f print.f rambo.f singen.f
)
list(TRANSFORM PSLIMITFILES   PREPEND  "src/pslimits/")

set(
PHASEFILES 
breitw.f gencheck.f gen2.f gen3.f gen4.f phase3.f phase4.f phi1_2m_nobw.f phi3.f phi3m.f phi3m0.f)
list(TRANSFORM PHASEFILES    PREPEND  "src/Phase/")

set(
PROCDEPFILES  
bornint.f chooser.f gen_born_ps.f gen_virt_ps.f gen_real_ps.f realint.f virtint.f)
list(TRANSFORM PROCDEPFILES    PREPEND  "src/Procdep/")

set(
USERFILES  
bookplot.f deltarj.f durhamalg.f genclust2.f genclust_kt.f genclust_cone.f gencuts.f gencuts_input.f 
genplots.f getet.f idjet.f integratehisto.f irregbins.f mdata.f miscclust.f nplotter.f nplotter_generic.f setnotag.f)
list(TRANSFORM USERFILES   PREPEND "src/User/")

###########################
# -------------------------------------------------------------------
# Optional LHAPDF Sources
# -------------------------------------------------------------------
if(NNLOCAL_ENABLE_LHAPDF)
    list(APPEND PARTONFILES
        src/Parton/alfamz_lhapdf.f
        src/Parton/fdist_lhapdf.f
        src/Parton/pdfwrap_lhapdf.f
    )
endif()

# -------------------------------------------------------------------
# Executables
# -------------------------------------------------------------------

add_executable(nnlocal
    src/Need/nnlocal.f
    ${NEEDFILES} ${PROCDEPFILES} ${PHASEFILES} ${PSLIMITFILES}
    ${HPINTCTS} ${INTCTS} ${USERFILES} ${GGHFILES}
    ${INTEGRATEFILES} ${PARTONFILES}
)
if(NNLOCAL_ENABLE_LHAPDF)
    target_link_libraries(nnlocal PRIVATE LHAPDF::LHAPDF)
endif()

add_executable(gridplot src/Need/rgrids.f)
add_executable(mergedata src/Need/mergedata.f90)

# -------------------------------------------------------------------
# Installation
# -------------------------------------------------------------------
install(TARGETS nnlocal gridplot mergedata
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
