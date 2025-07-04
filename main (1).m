rho = 998; 
g = 9.81; 
V = 460; 
pf = 0.875; 
eta_motor = 0.9;
I = 31; 
Q_gpm = 800;
Q_m3s = Q_gpm 
P_out = 33 * 6894.76; 
P_in = -1.24 * 6894.76; 
deltaP = P_out - P_in;
z = 3; 
Head = (deltaP/(rho * g)) + z;
P_hyd = rho * g * Q_m3s * Head;
P_input = eta_motor * sqrt(3) * V * I * pf;
eff_total = P_hyd / P_input;
fprintf('Head: %.2f m\n', Head);
fprintf('Hydraulic Power: %.2f W\n', P_hyd);
100f %%\n', eff_total * 2fprintf('Overall Efficiency: %.
