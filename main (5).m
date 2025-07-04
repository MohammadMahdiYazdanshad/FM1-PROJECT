img = imread('pump_curves.jpeg');
imshow(img);
;('Enter نمودار باال - نقطهها رو انتخاب کن بعد')title
;('بزن Enter اول نقاط نمودار باال رو انتخاب کن، بعدش')disp
[x_top, y_top] = ginput;
top_data = [x_top, y_top];
imshow(img);
;('Enter نمودار پایین - نقطهها رو انتخاب کن بعد')title
;('بزن Enter حاال نوبت نمودار پایینه، نقطهها رو انتخاب کن و')disp
[x_bottom, y_bottom] = ginput;
bottom_data = [x_bottom, y_bottom];
save('digitized_data.mat', 'top_data', 'bottom_data');
figure;
subplot(2,1,1);
plot(top_data(:,1), top_data(:,2), 'ro-', 'LineWidth', 1.5);
;('نقاط انتخابشده از نمودار باال')
xlabel('X');
ylabel('Y');
subplot(2,1,2);
plot(bottom_data(:,1), bottom_data(:,2), 'bo-', 'LineWidth', 1.5);
;('نقاط انتخابشده از نمودار پایین')title
xlabel('X');
ylabel('Y');
;(' :(L/s) لطفاا مقدار دبی مورد نظر را وارد کنید')Q_user = input
;(' :(m) لطفاا مقدار هد مورد نظر را وارد کنید')H_user = input
if Q_user > 40 || H_user > 40
;('.مقدار دبی یا هد خارج از محدوده مجاز است')warning 
end
best_match = [];
min_error = inf;
for i = 1:length(pump_data)
 Q_vals = pump_data(i).Q;
 
 if Q_user < min(Q_vals) || Q_user > max(Q_vals)
 continue
 end
 
 H_interp = interp1(Q_vals, pump_data(i).H, Q_user);
 eta_interp = interp1(Q_vals, pump_data(i).eta, Q_user);
 P_interp = interp1(Q_vals, pump_data(i).P, Q_user);
 
 if isnan(H_interp)
 continue
 end
 error = abs(H_interp - H_user);
 if error < min_error
 min_error = error;
 best_match.model = pump_data(i).model;
 best_match.D = pump_data(i).D;
 best_match.eta = eta_interp;
 best_match.P = P_interp;
 best_match.H = H_interp;
 end
end
if isempty(best_match)
;('.هیچ پمپی با شرایط مورد نظر یافت نشد')disp 
else
 fprintf('پیشنهادی پمپ: %s\n', best_match.model);
 fprintf('1.% :پروانه قطرf mm\n', best_match.D);
 fprintf('1.% :واقعی هدf m\n', best_match.H);
 fprintf('1.% :بازدهیf %%\n', best_match.eta * 100);
 fprintf('2.% :نیاز مورد توانf kW\n', best_match.P);
end
