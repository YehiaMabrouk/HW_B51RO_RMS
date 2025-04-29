function [yaw, pitch, roll] = calculatePitchRoll()
% CALCULATEPITCHROLL - This function reads acceleration and angular velocity from an IMU sensor
% and calculates its orientation by finding out pitch and roll. In this
% application MPU9250 sensor is used. However, it could be replaced with
% any other IMU sensor as well.

% Copyrights 2020-2022 The MathWorks.Inc
persistent arduinoObj imuObj fuseObj


if isempty(arduinoObj)
    arduinoObj = arduino();
end
if isempty(imuObj)
    imuObj = lsm6ds3(arduinoObj);
end

if isempty(fuseObj)
    fuseObj = complementaryFilter('HasMagnetometer', false);
end

% Using complementary filter to fuse accelerometer and gyroscope data.
% Filter coefficient should be tuned to improve result
[accel, gyro, ~, ~] = read(imuObj);
q = fuseObj(accel, gyro);
eulerAngles = eulerd( q, 'ZYX', 'frame');
yaw = eulerAngles(1)*180/pi;
pitch = eulerAngles(2)*180/pi;
roll = eulerAngles(3)*180/pi;
end
