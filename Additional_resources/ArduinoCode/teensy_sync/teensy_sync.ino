

#include "ArCOM.h"
ArCOM USB(SerialUSB); // USB is an ArCOM object. ArCOM wraps Arduino's SerialUSB interface, to
// simplify moving data types between Arduino and MATLAB/GNU Octave.

// Hardware setup
const int led_pin = 12;
const int ttl_pin = 13;

//Program variables
byte opCode = 0;

void setup() {
    SerialUSB.begin(115200);
    pinMode(ttl_pin, OUTPUT);
    pinMode(led_pin, OUTPUT);
}

void loop() {
  if (SerialUSB.available() > 0) {
    opCode = USB.readByte();
    switch(opCode) {
      case 'S': // Synchronize
         digitalWriteFast(ttl_pin, HIGH); // send signal to ephys
         digitalWriteFast(led_pin, HIGH); // send signal to LED
         USB.writeByte(216);
         delay(10); // length of ephys signal
         digitalWriteFast(ttl_pin, LOW); // end signal to ephys
         delay(990); // length of LED signal
         digitalWriteFast(led_pin, LOW); // end of LED signal     
       break;
      case 'C': // Handshake
        USB.writeByte(217);
      break;
    } //end opCode switch
  } // end serial availability check
} //end main loop
