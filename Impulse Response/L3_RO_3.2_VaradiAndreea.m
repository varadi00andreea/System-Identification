%Sistem de ordin 1
load('lab3_order1_7.mat');
u=data.InputData{1};
y=data.OutputData{1};
ts=data.Ts{1};

subplot(211);plot(u);title('Intrarea');xlabel('t');ylabel('u');grid on;
subplot(212);plot(y);title('Iesirea');xlabel('t');ylabel('y');grid on;

yid=y(1:110);yval=y(111:330);
uid=u(1:110);uval=u(111:330);

figure
plot(yid);title('y_i_d_e_n_t_i_f_i_c_a_r_e');
grid on;

yss=sum(yid(101:110))/10;
uss=sum(uid(101:110))/10;

K=yss/uss;
ymax=1.73;
kt=46-33;
T=kt*ts;

disp(strcat({'Factorul de proportionalitate K='},num2str(K)));
disp(strcat({'Constanta de timp T='},num2str(T)));

A=-1/T;
B=K/T;
C=1;
D=0;

x0=yss;
Hss=ss(A,B,C,D);
y_hat_id=lsim(Hss,uid,t(1:110),x0);
y_hat_val=lsim(Hss,uval,t(111:330),x0);

MSE_id=0;
for i=1:length(yid)
    MSE_id=MSE_id+(y_hat_id(i)-yid(i))^2;
end
MSE_id=MSE_id/length(yid);

MSE_val=0;
for i=1:length(yval)
    MSE_val=MSE_val+(y_hat_val(i)-yval(i))^2;
end
MSE_val=MSE_val/length(yval);

figure
plot(y_hat_id,'r');
hold on
plot(yid,'b');
grid on
title('MSE_i_d=',num2str(MSE_id));

figure
plot(y_hat_val,'r');
hold on
plot(yval,'b');
grid on
title('MSE_v_a_l=',num2str(MSE_val));

%%
%Sistem de ordin 2

load('lab3_order2_7.mat');
u=data.InputData{1};
y=data.OutputData{1};
ts=data.Ts{1};

subplot(211);plot(u);title('Intrarea');xlabel('t');ylabel('u');grid on;
subplot(212);plot(y);title('Iesirea');xlabel('t');ylabel('y');grid on;

yid=y(1:110);yval=y(111:330);
uid=u(1:110);uval=u(111:330);

figure
plot(yid);grid on;title('y_i_d_e_n_t_i_f_i_c_a_r_e');xlabel('t');ylabel('y_i_d');

yss=sum(yid(91:100))/10;
uss=sum(uid(91:100))/10;

K=yss/uss;
kt00=30;    kt01=50;    kt02=80;
t00=kt00*ts;
t01=kt01*ts;
t02=kt02*ts;

A_plus=0;
for i=kt00:kt01
    A_plus=A_plus+y(i)-yss;
end
A_plus=A_plus*ts;

A_minus=0;
for i=kt01:kt02
    A_minus=A_minus+yss-y(i);
end
A_minus=A_minus*ts;

M=A_minus/A_plus;

zeta=log(1/M)/sqrt(pi^2+(log(M))^2);

tmax1=39; tmax2=86;
T0=(tmax2-tmax1)*ts;

wn=2*pi/(T0*sqrt(1-zeta^2));

A=[0 1;
    -wn^2 -2*zeta];
B=[0; K*wn^2];
C=[1 0];
D=0;

Hss=ss(A,B,C,D);
y_hat_id=lsim(Hss,uid,t(1:110),[yss 0]);

MSE_id=0;
for i=1:length(yid)
    MSE_id=MSE_id+(y_hat_id(i)-yid(i))^2;
end
MSE_id=MSE_id/length(yid);

figure
plot(y_hat_id,'r');
hold on
plot(yid,'b');
grid on
title('MSE_i_d=',num2str(MSE_id));

y_hat_val=lsim(Hss,uval,t(111:330),[yss 0]);

MSE_val=0;
for i=1:length(yval)
    MSE_val=MSE_val+(y_hat_val(i)-yval(i))^2;
end
MSE_val=MSE_val/length(yval);

disp(strcat({'Suprareglajul M='},num2str(M)));
disp(strcat({'Perioada de oscilatie T='},num2str(T)));
disp(strcat({'Pulsatia naturala='},num2str(wn))); 

figure
plot(y_hat_val,'r');
hold on
plot(yval,'b');
grid on
title('MSE_v_a_l=',num2str(MSE_val));