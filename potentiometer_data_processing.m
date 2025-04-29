function [roll_d, pitch_d, yaw_d] = potentiometer_data_processing(pot_data)
    % Process potentiometer data and convert to desired Euler angles (in degrees)
    
    % Unpack raw data from potentiometers
    roll_pot = pot_data(1);
    pitch_pot = pot_data(2);
    yaw_pot = pot_data(3);
    
    % Scale raw potentiometer values to the desired range for each axis
    roll_d = map_value(roll_pot, 0, 1023, -30, 30);
    pitch_d = map_value(pitch_pot, 0, 1023, -30, 30);
    yaw_d = map_value(yaw_pot, 0, 1023, -30, 30);
end

function value_mapped = map_value(value, in_min, in_max, out_min, out_max)
    % Map value from one range to another
    value_mapped = (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
end
