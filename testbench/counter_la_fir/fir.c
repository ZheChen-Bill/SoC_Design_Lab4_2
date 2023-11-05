#include "fir.h"

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	input(data_length_address,data_length);
	for(int i=0;i<N;i=i+1){
		input((tap_base+4*i),taps[i]);
	}
	reg_fir_x = 0;
	//initial your fir
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	initfir();
	//write down your fir
	for(int i=0;i<data_length;i=i+1){
		reg_fir_x = i;
		// input(input_address,reg_fir_x);
		while(1){
			if(reg_fir_y == i){
				break;
			}
		}
	}
}
		
