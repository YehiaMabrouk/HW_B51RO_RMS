% gimbal_model.m

% System Parameters
syms theta1 theta2 theta3
syms alpha1 alpha2 alpha3
syms theta1_dot theta2_dot theta3_dot
syms I1 I2 I3 m1 m2 m3
syms l1 l2 l3

% Desired Angles
desired_roll = 0;
desired_pitch = 0;
desired_yaw = 0;

% Kinematic Model
% Euler Angle Rates to Angular Velocity Conversion Matrix
R = [1, sin(theta1) * tan(theta2), cos(theta1) * tan(theta2);
     0, cos(theta1), -sin(theta1);
     0, sin(theta1) / cos(theta2), cos(theta1) / cos(theta2)];

% Euler Angle Rates
theta_dot = R * [theta1_dot; theta2_dot; theta3_dot];

% Dynamic Model
% Moment of Inertia Tensors
I1_tensor = diag([I1, I1, I2]);
I2_tensor = diag([I3, I3, I2]);
I3_tensor = diag([I1, I1, I2]);

% Angular Velocities
omega1 = [theta1_dot; 0; 0];
omega2 = [theta1_dot; theta2_dot; 0];
omega3 = [theta1_dot; theta2_dot; theta3_dot];

% Torques
tau1 = I1_tensor * omega1 + cross(omega1, I1_tensor * omega1);
tau2 = I2_tensor * omega2 + cross(omega2, I2_tensor * omega2);
tau3 = I3_tensor * omega3 + cross(omega3, I3_tensor * omega3);

% Inverse Kinematic Model
% Assuming the desired angles are Roll-Pitch-Yaw (RPY) Euler angles
roll = desired_roll;
pitch = desired_pitch;
yaw = desired_yaw;

% Compute the desired servo angles (alpha1, alpha2, alpha3)
% Based on the gimbal system's structure and desired orientation
alpha1 = roll;
alpha2 = pitch;
alpha3 = yaw;

% Substitute desired servo angles and numerical values for system parameters
% (e.g., lengths, masses, and moments of inertia) before computing the angles

% alpha1 = subs(alpha1, {theta1, theta2, theta3}, {desired_roll, desired_pitch, desired_yaw});
% alpha2 = subs(alpha2, {theta1, theta2, theta3}, {desired_roll, desired_pitch, desired_yaw});
% alpha3 = subs(alpha3, {theta1, theta2, theta3}, {desired_roll, desired_pitch, desired_yaw});

save('desired_angles.mat', 'alpha1', 'alpha2', 'alpha3');


