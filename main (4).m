Q = [254 228 197 163 177 155 127 129 99 75 50 27 2];
T = [2.1 2.0 1.9 1.7 1.8 1.7 1.5 1.5 1.4 1.2 1.1 1.0 0.9];
Ps = [-0.08 -0.07 -0.05 -0.04 -0.05 -0.04 -0.03 -0.03 -0.02 -0.02 -0.02 -0.01 -0.01];
Pd = [0.06 0.11 0.18 0.25 0.21 0.25 0.29 0.29 0.32 0.34 0.35 0.36 0.36];
Pm = [0.52 0.50 0.48 0.46 0.47 0.45 0.42 0.42 0.40 0.38 0.36 0.33 0.31];

rho = 1000;
g = 9.81;
n = 1100;

Qm3s = Q / 1000 / 60;
dP = (Pd - Ps) * 1e5;
H = dP ./ (rho * g);
Ph = (rho * g .* Qm3s .* H) / 1000;
eta = Ph ./ Pm;
Ns = (n .* sqrt(Qm3s)) ./ ((g .* H).^(3/4));

titles = {'Head vs Flow Rate','Hydraulic Power','Specific Speed','Overall Efficiency'};
ylabs  = {'H (m)', 'Ph (kW)', 'Ns', '\eta'};
vars = {H, Ph, Ns, eta};

figure('Name','Pump Performance Analysis','NumberTitle','off');
for i = 1:4
    subplot(2,2,i)
    y = vars{i};
    plot(Q, y, 'o', 'MarkerFaceColor', 'b'), hold on
    p = polyfit(Q, y, 2);
    y_fit = polyval(p, Q);
    plot(Q, y_fit, '--r', 'LineWidth', 1.5)
    xlabel('Flow Rate Q (L/min)'), ylabel(ylabs{i}), title(titles{i})
    legend('Data','Poly Fit')
    grid on
end

