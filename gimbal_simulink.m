% Gimbal system parameters
Kp_roll = 0.5;
Ki_roll = 0.1;
Kd_roll = 0.05;
Kp_pitch = 0.5;
Ki_pitch = 0.1;
Kd_pitch = 0.05;
Kp_yaw = 0.5;
Ki_yaw = 0.1;
Kd_yaw = 0.05;

% Desired orientation
desired_roll = 0;
desired_pitch = 0;
desired_yaw = 0;

% Save parameters for use in Simulink
save('gimbal_simulink_params.mat', 'Kp_roll', 'Ki_roll', 'Kd_roll', ...
    'Kp_pitch', 'Ki_pitch', 'Kd_pitch', ...
    'Kp_yaw', 'Ki_yaw', 'Kd_yaw', ...
    'desired_roll', 'desired_pitch', 'desired_yaw');

% Open the Simulink model
open_system('gimbal_simulink_model.slx');
