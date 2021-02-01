f = figure;
t = uitable(f,'Data',randi(100,10,3),'Position',[20 20 262 204]);
%% Trying
Vmean=(v_new+v)/2;
T= readtable("C:\Users\evely\OneDrive\Documents\GitHub\EmBehav");

%% Successful?
table1 = array2table(pos_new);
table2 = array2table(v_new);%wrong values??
Vmean_table = array2table(v_m);
const_table = table(K, sig, beta, dim);