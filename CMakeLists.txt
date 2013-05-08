# Copyright (C) scitics GmbH
# -*- coding: utf-8 -*-

project( vlfeat )
cmake_minimum_required(VERSION 2.6)



file( GLOB_RECURSE ${PROJECT_NAME}_LIBSRC
  vl/aib.c
  vl/array.c 
  vl/covdet.c 
  vl/dsift.c
  vl/generic.c
  vl/getopt_long.c
  vl/hikmeans.c
  vl/hog.c
  vl/homkermap.c
  vl/host.c
  vl/ikmeans.c
  vl/imopv.c
  vl/imopv_sse2.c
  vl/kdtree.c
  vl/kmeans.c
  vl/lbp.c
  vl/mathop.c
  vl/mathop_sse2.c
  vl/mser.c
  vl/pegasos.c
  vl/pgm.c
  vl/quickshift.c
  vl/random.c
  vl/rodrigues.c
  vl/scalespace.c
  vl/sift.c
  vl/slic.c
  vl/stringop.c
  vl/svmdataset.c
)
 
file( GLOB_RECURSE ${PROJECT_NAME}_CMDSRC
  src/aib.c 
  src/mser.c 
  src/sift.c 
  src/test_gauss_elimination.c 
  src/test_getopt_long.c 
  src/test_heap-def.c 
  src/test_host.c 
  src/test_imopv.c 
  src/test_mathop.c 
  src/test_mathop_abs.c 
  src/test_nan.c 
  src/test_qsort-def.c 
  src/test_rand.c 
  src/test_stringop.c 
  src/test_svd2.c 
  src/test_threads.c 
  src/test_vec_comp.c
  )

file( GLOB_RECURSE ${PROJECT_NAME}_MEXSRC
  toolbox/aib/vl_aib.c
  toolbox/aib/vl_aibhist.c
  toolbox/geometry/vl_irodr.c
  toolbox/geometry/vl_rodr.c
  toolbox/imop/vl_imdisttf.c
  toolbox/imop/vl_imintegral.c
  toolbox/imop/vl_imsmooth.c
  toolbox/imop/vl_imwbackwardmx.c
  toolbox/imop/vl_tpsumx.c
  toolbox/kmeans/vl_hikmeans.c
  toolbox/kmeans/vl_hikmeanspush.c
  toolbox/kmeans/vl_ikmeans.c
  toolbox/kmeans/vl_ikmeanspush.c
  toolbox/kmeans/vl_kmeans.c
  toolbox/misc/vl_alldist.c 
  toolbox/misc/vl_alldist2.c
  toolbox/misc/vl_binsearch.c 
  toolbox/misc/vl_binsum.c 
  toolbox/misc/vl_cummax.c 
  toolbox/misc/vl_getpid.c 
  toolbox/misc/vl_hog.c 
  toolbox/misc/vl_homkermap.c 
  toolbox/misc/vl_ihashfind.c 
  toolbox/misc/vl_ihashsum.c 
  toolbox/misc/vl_inthist.c 
  toolbox/misc/vl_kdtreebuild.c 
  toolbox/misc/vl_kdtreequery.c 
  toolbox/misc/vl_lbp.c 
  toolbox/misc/vl_localmax.c 
  toolbox/misc/vl_maketrainingset.c 
  toolbox/misc/vl_pegasos.c 
  toolbox/misc/vl_sampleinthist.c 
  toolbox/misc/vl_simdctrl.c 
  toolbox/misc/vl_svmpegasos.c 
  toolbox/misc/vl_twister.c 
  toolbox/misc/vl_version.c
  toolbox/mser/vl_erfill.c 
  toolbox/mser/vl_mser.c 
  toolbox/quickshift/vl_quickshift.c 
  toolbox/sift/vl_covdet.c 
  toolbox/sift/vl_dsift.c 
  toolbox/sift/vl_sift.c 
  toolbox/sift/vl_siftdescriptor.c 
  toolbox/sift/vl_ubcmatch.c 
  toolbox/slic/vl_slic.c
)



include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/toolbox
    )

list( APPEND VLFEAT_COMPILE_FLAGS "_CRT_SECURE_NO_DEPRECATE")
list( APPEND VLFEAT_COMPILE_FLAGS "__LITTLE_ENDIAN__")
list( APPEND VLFEAT_COMPILE_FLAGS "VL_BUILD")
list( APPEND VLFEAT_COMPILE_FLAGS "__SSE2__")

add_library( ${PROJECT_NAME} 
                 STATIC
                
                ${${PROJECT_NAME}_LIBSRC} 
                )

IF( MSVC )
    SET_TARGET_PROPERTIES( ${PROJECT_NAME} PROPERTIES COMPILE_FLAGS /TP)
endif ()

set_target_properties( ${PROJECT_NAME}
    PROPERTIES
        COMPILE_DEFINITIONS "${VLFEAT_COMPILE_FLAGS}" )



#add_library( ${PROJECT_NAME}_MEX 
#                 STATIC
#                ${${PROJECT_NAME}_MEXSRC}
#                
#)

#set_target_properties( ${PROJECT_NAME}_MEX
#    PROPERTIES
#        COMPILE_DEFINITIONS "${VLFEAT_COMPILE_FLAGS}" )


#target_link_libraries( 
#    ${PROJECT_NAME}_MEX
#    ${PROJECT_NAME} 
#    )
