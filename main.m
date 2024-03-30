% 02/2022
% NOTE
% codice per paper MED22 - controllo ESS e controllo aggregato potenza
% ricarica con expectation su numero veicoli e potenza PV
syms tau t
syms x_t_f
syms lambda_t_i lambda_t_f
rng('shuffle')      % updates rnd seed (needed for m file in simulink)
t_i = 0; 
t_f = 12;           % [hours] 
hours_divisions = 12; %[5 minut]

x_t_i = 0;
b = 1;
B = [-b ; 0];

q = 1;              % peso x
r = 2;              % peso u
s = 10;             % peso x_f

w_r_base = 50; %[kW]
max_auto = 10;
w_max = w_r_base*max_auto;        % [kW]

demand_base = 50;

u_nom = (11*demand_base) - 1; % to be checked
c_nom = 1; %to be checked/

t_indices =     (1:t_f * hours_divisions+1);

%sessions = [1 2 3 4 5 4 3 2 1];
%t_instants =    [0   2.5  5   7    9    12  15  18 22 25];
%sessions = randi(max_auto-3,1,t_f*hours_divisions)-1;
t_instants = linspace(0, t_f+1, t_f * hours_divisions); 

%peak_1 = 200;
%peak_2 = 350;
%peak_1_time = 2;
%peak_2_time = 8;
%power_demand_variance = 50; % +-1 veicolo come varianza
%power_demand_mean = demand_base + peak_1*exp(-4*(tau-peak_1_time)^2) + peak_2*exp(-5*(tau-peak_2_time)^2);
%power_demand_mean = subs(power_demand_mean, tau, t_instants);
%power_demand = zeros(length(power_demand_mean));
%for i=1:length(power_demand_mean)
%    power_demand(i) = power_demand_mean(i) + randn()*power_demand_variance;
%end
%sessions = round(power_demand./w_r_base);

%sessions = [ 0, 1, 2, 3, 4, 4, 5, 5, 4, 3, 3, 2, 2, 1, 1, 1, 0, 0, 0, 0, 1, 2, 2, 4, 4, 4, 5, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%sessions = [ 0     1     2     3     4     4     5     5     4     3     3     2     2     1     0     0     0     0     0     0     1     2     3     4  4     3     4     5     6     7     8     7     6     5     4     3     2     2     1     0     0     0     0     0     0     0     0     0 ];
sessions_mean = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5, 5, 5, 5, 4, 3, 3, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 7, 6, 5, 4, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%sessions_mean = sessions_mean(1:length(sessions_mean)/2);
%sessions_variance = 1;
%sessions = sessions_mean + round(randn(1,length(sessions)).*(sessions_mean/3));
%for i=1:length(sessions)
%    if sessions(i)<0
%        sessions(i) = 0;
%    end
%end
w_r_mean = sessions_mean * w_r_base;
%w_r = sessions_real * w_r_base;
quota = 0.7;
sessions_stochastic = round(sessions_mean * (1-quota));
sessions_deterministic = sessions_mean - sessions_stochastic;
w_r_deterministic = sessions_deterministic * w_r_base;
w_r_stochastic = sessions_stochastic * w_r_base;
w_r_variance = w_r_stochastic*w_r_base;
w_r = w_r_deterministic + (poissrnd(sessions_stochastic, 1, length(w_r_mean)).*w_r_base);
% Perform the symbolic computation of the optimal solutions
%syms c(w_max,w_r)

%% w_pv, w
w_pv  = zeros(1,length(w_r));    % no PV per semplicità. 20 + 150*exp(-1*(tau-4)^2) + 200*exp(-5*(tau-8)^2);
demand_base = 0;
 peak_1 = 50;
 peak_2 = -20;
% peak_1 = 0;
% peak_2 = 0;
peak_1_time = 7;
peak_2_time = 7.3;
%power_demand_variance = 5;
power_demand_mean = demand_base + peak_1*exp(-0.3*(tau-peak_1_time)^2) + peak_2*exp(-4*(tau-peak_2_time)^2)+peak_2/2*exp(-8*(tau-peak_2_time+2)^2);
power_demand_mean = subs(power_demand_mean, tau, t_instants);
%power_demand = zeros(length(power_demand_mean), 1);
% for i=1:length(power_demand_mean)
%     if power_demand_mean(i) > 5
%         power_demand(i) = power_demand_mean(i) + randn()*power_demand_variance;
%         if power_demand(i) < 0
%             power_demand(i) = 0;
%         end
%     else
%         power_demand(i) = power_demand_mean(i);
%     end
% end
power_demand_variance = power_demand_mean./3;
power_demand = power_demand_mean + randn(1, length(power_demand_mean)).*power_demand_variance;
%power_demand = power_demand';
w_pv = power_demand;
% plot(w_pv)
% pause
% w_pv_table = readtable('pv_data_simulation.csv');
% w_pv = table2array(w_pv_table(:, 1));
% w_pv = w_pv*4; %ho preso il profilo di una giornata, lo uso come shape
%w = w_r - w_pv;
%% computation of the weigth of 
%c(w_ev) = coeff_1/(w_r + coeff_2);
%peso_max = 100;                                 % c(w_r) when w_r = 0
%peso_min = 1;                                  % c(w_r) when w_r = w_max
%divisions = 100;
%treshold = divisions/2.5;
%scale = 8;
%[p_cw_base, cw_base] = create_cw(divisions,treshold, peso_max, peso_min, 450, scale);

%now the weigth is linear with \hat{u}^{ev} = w_ev (using the notation of
%this code
% 
% cw = zeros(length(w_r_mean), 1);
% for i=1:length(w_r_mean)
%     cw(i) = c_nom*(1 + u_nom - w_r_mean(i));
% end
% cw = cw';
% 
% E_u_ev_square = (w_r_variance) + (w_r_mean.^2);
% w = zeros(length(E_u_ev_square), 1);
% for i=1:length(E_u_ev_square)
%     w(i) = -(c_nom/cw(i))*(E_u_ev_square(i) - ((1+u_nom)*w_r_mean(i))) - power_demand_mean(i);
% end
% w = w';
%% MPC Cycle
window = 4 * hours_divisions;
x_t_i_window = x_t_i;
t_f_window = t_instants(2);
x_plot = zeros(1);
u_plot = zeros(1);
w_r_plot = zeros(1);
w_pv_plot = zeros(1);
w_ev_plot = zeros(1);
p_plot = zeros(1);
lambda_plot = zeros(1);
w_r_mean_plot = zeros(1);
w_pv_mean_plot = zeros(1);
for i=1:length(t_instants)-1
    disp(i)
    syms x_t_f_window
    syms lambda_t_i_window lambda_t_f_window
    if i + window > length(t_instants)
        window = length(t_instants) - i;
    end
    t_window = t_instants(i:i+window);
    t_indices_window = (1:window);
    w_r_mean_window = cat(2, w_r(i), w_r_mean(i+1:window+i));
    w_r_mean_window2 = w_r_mean(i:window+i); % for plotting purposes only
    w_r_variance_window = cat(2, 0, w_r_variance(i+1:window+i));
    w_pv_mean_window = cat(2, w_pv(i), power_demand_mean(i+1:window+i));
    w_pv_mean_window2 = power_demand_mean(i:window+i); % for plotting puroposes only
    
    cw_window = zeros(length(w_r_mean_window), 1);
    for j=1:length(w_r_mean_window)
        cw_window(j) = c_nom*(1 + u_nom - w_r_mean_window(j));
    end
    cw_window = cw_window';

    E_u_ev_square = (w_r_variance_window) + (w_r_mean_window.^2);
    w = zeros(length(E_u_ev_square), 1);
    for j=1:length(E_u_ev_square)
        w(j) = -(c_nom/cw_window(j))*(E_u_ev_square(j) - ((1+u_nom)*w_r_mean_window(j))) - w_pv_mean_window(j);
    end
    w = w';
    

    %% compute first product in (16)
    prod_1 = 1;
    n = length(t_window);   %%%% controllare
    for k=1:n-1
        %c_w_nmk = assign_cw(w_r(n-k), p_cw_base, cw_base);
        A_nmk = [0 -(1/r + 1/cw_window(n-k)); -q 0];
        Dt_nmk = t_window(n-k+1)  - t_window(n-k);   %%%% controllare
        prod_1 = prod_1*expm(A_nmk*Dt_nmk);
    end

    %% compute second term in (16)
    term_2 = 0;
    n = length(t_window);     %%%% controllare
    prod_2 = 1;
    for h=1:n-1
        prod_2 = 1;
        % compute the internal product
        for j=1:n-1-h
            if h~=n-1                                   % otherwise empty product-->1
                %c_w_nmj = assign_cw(w_r(n-j), p_cw_base, cw_base);
                A_nmj = [0 -(1/r + 1/cw_window(n-j)); -q 0];
                Dt_nmj = t_window(n-j+1)  - t_window(n-j);
                prod_2 = prod_2*expm(A_nmj*Dt_nmj);
            end
        end
        %c_w_h = assign_cw(w_r(h), p_cw_base, cw_base);   
        A_h = [0 -(1/r + 1/cw_window(h)); -q 0];
        integral_2 = int( expm(A_h*(t_window(h+1)-tau)), tau, t_window(h) , t_window(h+1) );
        % sum the terms
        term_2 = term_2 + prod_2*integral_2*B*w(t_indices_window(h));      %% w is to be put in the integral above if w_pv is different from 0
    end

    %% solve (15) to find the initial costate
    eqns = [lambda_t_f_window == s*x_t_f_window  ,  x_t_f_window == prod_1(1,:)*[x_t_i_window; lambda_t_i_window] + term_2(1, :)  ,  lambda_t_f_window == prod_1(2,:)*[x_t_i_window; lambda_t_i_window] + term_2(2, :)];
    S = solve(eqns);

    %% Substitute the numeric initial conditions
    lambda_t_i_window = eval(S.lambda_t_i_window);

    x_t_i_simulink = double(x_t_i_window);
    b_simulink = double(b);
    r_simulink = double(r);
    q_simulink = double(q);
    c_nom = double(c_nom);
    u_nom = double(u_nom);
    %w_r_simulink = double(w_r);
    w_r_real_simulink = double(w_r(i:window+i));
    w_r_simulink = double(w_r_mean_window);
    w_r_mean_simulink = double(w_r_mean_window2);
    w_r_variance_simulink = double(w_r_variance_window);
    %w_pv_simulink = double(w_pv);
    w_pv_real_simulink = double(w_pv(i:window+i));
    w_pv_simulink = double(w_pv_mean_window);
    w_pv_mean_simulink = double(w_pv_mean_window2);
    t_instants_simulink =double(t_window);
    t_indices_simulink = double(t_indices_window);
    %p_cw_base_simulink = double(p_cw_base);
    %cw_base_simulink = double(cw_base);
    w_max_simulink = double(w_max);
    lambda_0_simulink = double(lambda_t_i_window);
    %peso_min_simulink = double(peso_min);
    sim('simulink_2018b');
%     index = 0;
%     for j=1:length(x_out.time(:))
%         if x_out.time(j) >= t_instants(2)
%             index = j;
%             break;
%         end
%     end
    x_t_i_window = getsamples(x_out, length(x_out.time)).Data;
    x_plot = cat(1, x_plot, getsamples(x_out, [1:length(x_out.time)]).Data);
    u_plot = cat(1, u_plot, getsamples(u_out, [1:length(u_out.time)]).Data);
    w_r_plot = cat(1, w_r_plot, getsamples(w_r_out, [1:length(w_r_out.time)]).Data);
    w_pv_plot = cat(1, w_pv_plot, getsamples(w_pv_out, [1:length(w_pv_out.time)]).Data);
    w_ev_plot = cat(1, w_ev_plot, getsamples(w_ev_out, [1:length(w_ev_out.time)]).Data);
    p_plot = cat(1, p_plot, getsamples(p_out, [1:length(p_out.time)]).Data);
    lambda_plot = cat(1, lambda_plot, getsamples(lambda, [1:length(lambda.time)]).Data);
    w_r_mean_plot = cat(1, w_r_mean_plot, getsamples(w_r_mean_out, [1:length(w_r_mean_out.time)]).Data);
    w_pv_mean_plot = cat(1, w_pv_mean_plot, getsamples(w_pv_mean_out, [1:length(w_pv_mean_out.time)]).Data);
    plot(p_plot)
end
%% Plotting the timeseries
timespan = linspace(duration(6,0,0), duration(18,0,0), length(x_plot)-1);


x_out = timeseries(x_plot(2:end), linspace(0, t_f, length(x_plot)-1));
u_out = timeseries(u_plot(2:end), linspace(0, t_f, length(u_plot)-1));
w_r_out = timeseries(w_r_plot(2:end), linspace(0, t_f, length(w_r_plot)-1));
w_pv_out = timeseries(w_pv_plot(2:end), linspace(0, t_f, length(w_pv_plot)-1));
w_ev_out = timeseries(w_ev_plot(2:end), linspace(0, t_f, length(w_ev_plot)-1));
p_out = timeseries(p_plot(2:end), linspace(0, t_f, length(p_plot)-1));
lambda = timeseries(lambda_plot(2:end), linspace(0, t_f, length(lambda_plot)-1));
w_r_mean_out = timeseries(w_r_mean_plot(2:end), linspace(0, t_f, length(w_r_mean_plot)-1));
w_pv_mean_out = timeseries(w_pv_mean_plot(2:end), linspace(0, t_f, length(w_pv_mean_plot)-1));

