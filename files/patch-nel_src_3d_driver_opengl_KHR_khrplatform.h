--- nel/src/3d/driver/opengl/KHR/khrplatform.h.orig	2024-12-17 22:41:50 UTC
+++ nel/src/3d/driver/opengl/KHR/khrplatform.h
@@ -220,7 +220,7 @@ typedef signed   short int     khronos_int16_t;
 typedef signed   char          khronos_int8_t;
 typedef unsigned char          khronos_uint8_t;
 typedef signed   short int     khronos_int16_t;
-typedef unsigned short int     khronos_uint16_t;
+typedef unsigned short int     khronos_char16_t;
 
 /*
  * Types that differ between LLP64 and LP64 architectures - in LLP64, 
