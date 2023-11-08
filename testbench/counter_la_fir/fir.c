#include "fir.h"

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	//initial your fir
	write(data_length_address,data_length);
	for(int register i=0;i<N;i=i+1){
		write((tap_base+4*i),taps[i]);
	}
	reg_fir_x = 0;
	reg_fir_y = 0;
	outputbuffer[0] = 0;
}

void __attribute__ ( ( section ( ".mprjram" ) ) ) start() {
	//check ap_idle = 1(bit[2] = 1), ap_start = 1;
	while(1){
		if (((read(ap_control_address) & (1<<2)) == 0x00000004)){
			write((ap_control_address),((read(ap_control_address) | 1)));
			break;
		}
	}
}

void __attribute__ ( ( section ( ".mprjram" ) ) ) input() {
	//check fir ready to receive data (bit[4] = 1), then write data;
//	while(1){
//		if (read(ap_control_address) & (1<<4) == 0x00000010){
			write(input_address,reg_fir_x);
//			break;
//		}
//	}
}

void __attribute__ ( ( section ( ".mprjram" ) ) ) output() {
	//check fir is valid for output data (bit[5] = 1), then read data;
//	while(1){
//		if (read(ap_control_address) & (1<<5) == 0x00000020){
			reg_fir_y = read(output_address);
//			break;
//		}
//	}
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	// initialize fir (data_length, taps, ... etc)
	initfir();

	// check ap_idle = 1(bit[2] = 1), ap_start = 1;
	start();

	//write down your fir
	for(int register i=0;i<data_length;i=i+1){
		reg_fir_x = i;

		//check fir ready to receive data (bit[4] = 1), then write data;
		input();

		//check fir is valid for output data (bit[5] = 1), then read data;
		output();
		}

	start();
	//write down your fir
	for(int register i=0;i<data_length;i=i+1){
		reg_fir_x = i;

		//check fir ready to receive data (bit[4] = 1), then write data;
		input();

		//check fir is valid for output data (bit[5] = 1), then read data;
		output();
		}

	start();
	//write down your fir
	for(int register i=0;i<data_length;i=i+1){
		reg_fir_x = i;

		//check fir ready to receive data (bit[4] = 1), then write data;
		input();

		//check fir is valid for output data (bit[5] = 1), then read data;
		output();
		}
		
		outputbuffer[0] = reg_fir_y;
		return outputbuffer;
	}
