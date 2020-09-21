


% You will need to install the proper core the first time you run this:
% ardunio-cli core install arduino:avr
sketchPath = 'C:\Users\HUMPH\Documents\Scripts\demo\demo.ino'; % path of arduino sketch
FQBN = 'arduino:avr:uno'; % fully qualified board name
port = 'COM11';
ard_cli = '"C:\Program Files (x86)\Arduino\arduino-cli_0.11.0_Windows_64bit\arduino-cli.exe"'; % runs the cli
arduinoCmd = ['cd C:\Users\HUMPH\ && ' ard_cli ' compile -b ' FQBN ' -u -p ' port ' -t ' sketchPath ' && EXIT'];
system(arduinoCmd);
