% Main script to implement the gimbal control system
load('desired_angles.mat');


% Load Arduino IO package 
load_system('ArduinoIO');

% Initialize Arduino board
board = arduino('COM4', 'Uno'); 

% Initialize servo motors and potentiometers
servo_roll = servo(board, 'D3');
servo_pitch = servo(board, 'D5');
servo_yaw = servo(board, 'D6');
pot_roll = 'A0';
pot_pitch = 'A1';
pot_yaw = 'A2';

% Initialize IMU
imu = mpu6050(board, '0x68');

% Create PID controllers for each axis
roll_pid = pidController(1, 0, 0); % Replace with appropriate PID gains
pitch_pid = pidController(1, 0, 0); % Replace with appropriate PID gains
yaw_pid = pidController(1, 0, 0); % Replace with appropriate PID gains

while true
    % Read IMU data
    imu_data = readAcceleration(imu);
    imu_data = [imu_data, readAngularVelocity(imu)];
    
    % Process IMU data to obtain the current orientation
    [roll, pitch, yaw] = imu_data_processing(imu_data);
    
    % Read potentiometer data
    pot_data = [readVoltage(board, pot_roll), readVoltage(board, pot_pitch), readVoltage(board, pot_yaw)];
    
    % Process potentiometer data to obtain the desired orientation
    [roll_d, pitch_d, yaw_d] = potentiometer_data_processing(pot_data);
    
    % Calculate control signals using PID controllers
    roll_pwm = roll_pid.compute(roll_d, roll);
    pitch_pwm = pitch_pid.compute(pitch_d, pitch);
    yaw_pwm = yaw_pid.compute(yaw_d, yaw);
    
    % Control servo motors using PWM signals
    writePosition(servo_roll, pulseWidthToPosition(roll_pwm));
    writePosition(servo_pitch, pulseWidthToPosition(pitch_pwm));
    writePosition(servo_yaw, pulseWidthToPosition(yaw_pwm));
    
    % Add a delay to control the loop execution rate
    pause(0.01);
end

function pos = pulseWidthToPosition(pwm)
    % Convert pulse width (in microseconds) to servo position (0 to 1)
    pos = (pwm - 1000) / 1000;
end

