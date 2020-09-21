%{
----------------------------------------------------------------------------

This file is part of the Sanworks Pulse Pal repository
Copyright (C) 2016 Sanworks LLC, Sound Beach, New York, USA

----------------------------------------------------------------------------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3.

This program is distributed  WITHOUT ANY WARRANTY and without even the
implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
%}

% ChoiceWheel is a system to measure lateral paw sweeps in mice.
%
% Installation:
% 1. Install PsychToolbox from: http://psychtoolbox.org/download/
% 2. Install ArCOM from https://github.com/sanworks/ArCOM
%
% - Create a ChoiceWheel object with W = ChoiceWheel('COMx') where COMx is your serial port string
% - By default, you can directly manipulate its fields to change trial parameters on the device.
% - Run W.stream to see streaming output (for testing purposes)
% - Run P = W.currentPosition to see the current wheel position (for testing purposes).
% - Run W.runTrial to start an experimental trial.
% - Run data = W.getLastTrialData once the trial is over, to return the trial outcome and wheel position record
% - To change many parameters with a single serial write, disable auto-sync and use the syncParams function:
%   W.autoSync = 0; W.leftThreshold = 170; W.rightThreshold = 190; W.syncParams; W.autoSync = 1;

classdef TeensySynchronizer < handle
    properties
        Port % ArCOM Serial port
        autoSync = 1; % If 1, update params on device when parameter fields change. If 0, don't.
    end
    properties (Access = private)
        acquiring = 0; % 0 if idle, 1 if acquiring data
        gui = struct; % Handles for GUI elements
    end
    methods
        function obj = TeensySynchronizer(portString)
            obj.Port = ArCOMObject(portString, 115200);
            
            obj.Port.write('C', 'uint8');
            
            response = obj.Port.read(1, 'uint8');
            if response ~= 217
                error('Could not connect =( ')
            end
        end
%         function [] = setLengthTtl(obj, ttl_length)
%             % ttl_length is in milliseconds
%             obj.Port.write('T', 'uint8');
%             ttl_ms = uint32(ttl_length);
%             obj.Port.write(ttl_ms, 'uint32');
%         end
%         function [] = setLengthLed(obj, led_length)
%             % led_length is in milliseconds
%             % note that led on time will include additional time for ttl
%             obj.Port.write('L', 'uint8');
%             led_ms = uint32(led_length);
%             obj.Port.write(led_ms, 'uint32');
%         end
        function roundTripTime = sync(obj)
            tic;
            obj.Port.write('S', 'uint8');
            response = obj.Port.read(1, 'uint8');
            if response ~= 216
                error('Could not synchronize')
            end
            roundTripTime = toc;
            disp(['Synchonized within ', num2str(roundTripTime), ' seconds']);
        end
%         function[] = resetDefaults(obj)
%            %tells teensy to switch to default settings
%            obj.Port.write('R', 'uint8');
%         end       
        function delete(obj)
            obj.Port = []; % Trigger the ArCOM port's destructor function (closes and releases port)
        end
    end
end