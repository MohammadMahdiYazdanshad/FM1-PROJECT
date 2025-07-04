Q_Lmin = 197;
Q_m3s = Q_Lmin / 1000 / 60;
rho = 1000;
g = 9.81;

P_discharge = 0.18;
P_suction = -0.05;
motor_power = 0.48;
torque = 1.9;
N_rpm = 1100;

delta_P = (P_discharge - P_suction) * 1e5;
H = delta_P / (rho * g);

Ph = (rho * g * Q_m3s * H) / 1000;
Pmech = (2 * pi * N_rpm * torque) / 60 / 1000;

eta_hydraulic = Ph / Pmech;
eta_overall = Ph / motor_power;

fprintf('هد پمپ: %.2f متر\n', H);
fprintf('توان هیدرولیکی: %.2f کیلووات\n', Ph);
fprintf('توان مکانیکی: %.2f کیلووات\n', Pmech);
fprintf('بازده هیدرولیکی: %.2f\n', eta_hydraulic);
fprintf('بازده کلی: %.2f\n', eta_overall);
