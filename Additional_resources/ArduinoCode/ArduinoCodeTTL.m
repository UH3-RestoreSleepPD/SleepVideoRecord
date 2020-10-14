% Check that Arduino Add on is installed
sum(contains(addons.Identifier,"ML_ARDUINO"))

% Load Arduino
a = arduino('COM4', 'Uno');

% Step up and down
writeDigitalPin(a, 'D13', 0);
writeDigitalPin(a, 'D13', 1);
pause(0.01)
writeDigitalPin(a, 'D13', 0);