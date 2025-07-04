Q_gpm = [0 500 800 1000 1100 1200 1400 1500];
Ps_psi = [0.65 0.25 -0.35 -0.92 -1.24 -1.63 -2.4 -2.89];
Pd_psi = [53.3 48.3 42.3 36.9 33.6 27.8 26.3 23.0];
I_motor = [18.0 26.2 31.0 33.9 35.2 36.3 38.0 39.0];

g = 9.81;
rho = 1000;
n = 1100;
V_line = 380;
pf = 0.85;
eta_motor = 0.9;

Q_m3s = Q_gpm * 0.06309 / 1000;
dP_Pa = (Pd_psi - Ps_psi) * 6894.76;

H = dP_Pa ./ (rho * g);
Ph = (rho * g .* Q_m3s .* H) / 1000;
Pin = sqrt(3) * V_line * I_motor * pf * eta_motor / 1000;
eta = Ph ./ Pin;
Ns = (n .* sqrt(Q_m3s)) ./ ((g * H).^(3/4));

vars = {H, Ph, eta, Ns};
titles = {'Head vs Flow Rate','Hydraulic Power','Overall Efficiency','Specific Speed'};
ylabs = {'H (m)','P_h (kW)','\eta','N_s'};
figure('Name','Pump Curves','NumberTitle','off')

for i = 1:4
    subplot(2,2,i)
    y = vars{i};
    plot(Q_gpm, y, 'o', 'MarkerFaceColor','b'), hold on
    p = polyfit(Q_gpm, y, 2);
    yfit = polyval(p, Q_gpm);
    plot(Q_gpm, yfit, '--r', 'LineWidth',1.5)
    title(titles{i})
    xlabel('Q (gpm)'), ylabel(ylabs{i})
    legend('Data','Poly Fit')
    grid on
end
