function [roll, pitch, yaw] = imu_data_processing(imu_data)
    % Process IMU data and convert to Euler angles (in degrees)
    
    % Unpack raw data from IMU
    ax = imu_data(1);
    ay = imu_data(2);
    az = imu_data(3);
    gx = imu_data(4);
    gy = imu_data(5);
    gz = imu_data(6);
    
    % Compute roll, pitch, and yaw using IMU data
    roll = atan2(ay, az) * 180 / pi;
    pitch = atan2(-ax, sqrt(ay^2 + az^2)) * 180 / pi;
    yaw = atan2(gy, sqrt(gx^2 + gz^2)) * 180 / pi;
end

