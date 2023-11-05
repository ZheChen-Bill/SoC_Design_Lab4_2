#ifndef __FIR_H__
#define __FIR_H__

#define N  11
#include <stdint.h>

#define input(address,data) (*(volatile uint32_t*) address) = data
#define data_length_address 0x30000010
#define tap_base            0x30000020
//#define input_address       0x30000080;
#define reg_fir_x           (*(volatile uint32_t*) 0x30000080)
#define reg_fir_y           (*(volatile uint32_t*) 0x30000084)

int data_length = 64;
int taps[N] = {0,-10,-9,23,56,63,56,23,-9,-10,0};
//int reg_fir_x;
//#define input_address       0x30000080

/*
#define reg_fir_x           (*(volatile uint32_t*) 0x30000080)
#define reg_fir_y           (*(volatile uint32_t*) 0x30000084)
#define ap_control  (*(volatile uint32_t*) 0x30000000)
#define data_length (*(volatile uint32_t*) 0x30000010) 
#define tap0        (*(volatile uint32_t*) 0x30000020) 
#define tap1        (*(volatile uint32_t*) 0x30000024) 
#define tap2        (*(volatile uint32_t*) 0x30000028) 
#define tap3        (*(volatile uint32_t*) 0x3000002c) 
#define tap4        (*(volatile uint32_t*) 0x30000030) 
#define tap5        (*(volatile uint32_t*) 0x30000034) 
#define tap6        (*(volatile uint32_t*) 0x30000038) 
#define tap7        (*(volatile uint32_t*) 0x3000003c) 
#define tap8        (*(volatile uint32_t*) 0x30000040) 
#define tap9        (*(volatile uint32_t*) 0x30000048) 
#define tap10       (*(volatile uint32_t*) 0x3000004c) 
#define input       (*(volatile uint32_t*) 0x30000080) 
#define output      (*(volatile uint32_t*) 0x30000084) 
*/
#endif
