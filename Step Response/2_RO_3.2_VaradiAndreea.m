%%sistemul de ordin 1
load('lab2_order1_2.mat');
u=data.InputData{1};
y=data.OutputData{1};
ts=data.Ts{1};

subplot(2,1,1);plot(u);xlabel('t'),ylabel('u');grid on;
subplot(2,1,2);plot(y);xlabel('t');ylabel('y');grid on;

uid=u(1:100);
yid=y(1:100);
uval=u(201:500);
yval=y(201:500);

figure
plot(yid);title('y_i_d');xlabel('k');ylabel('y');grid on;

yss=sum(yid(91:100))/10;
uss=sum(uid(91:100))/10;
K=yss/uss;
kt=17;
T=kt*ts;
num=[K];
den=[T 1];
H=tf(num,den);

disp(strcat({'Factorul de proportionalitate K='},num2str(K)));
disp(strcat({'Constanta de timp T='},num2str(T)));

yid_ap=lsim(H,uid,t(1:100));
yval_ap=lsim(H,uval,t(201:500));

figure
plot(yid_ap,'r');
hold on
plot(yid,'b');
legend('yid_a_p','yid');
xlabel('t');ylabel('y');grid on;

figure
plot(yval_ap,'r');
hold on
plot(yval,'b');
legend('yval_a_p','yval');
xlabel('t');ylabel('y');grid on;

MSEid=0;
for i=1:length(yid)
    MSEid=MSEid+(yid_ap(i)-yid(i))^2;
end
MSEid=MSEid/length(yid);

MSEval=0;
for i=1:length(yval)
    MSEval=MSEval+(yval_ap(i)-yval(i))^2;
end
MSEval=MSEval/length(yval);

disp(strcat({'MSE_identificare='},num2str(MSEid)));
disp(strcat({'MSE_validare='},num2str(MSEval)));

%%sistemul de ordin 2
%%
load('lab2_order2_2.mat');
u=data.InputData{1};
y=data.OutputData{1};
ts=data.Ts{1};

subplot(211);plot(u);xlabel('t');ylabel('u');grid on;
subplot(212);plot(y);xlabel('t');ylabel('y');grid on;

uid=u(1:100);
uval=u(201:500);
yid=y(1:100);
yval=y(201:500);

figure
plot(yid);xlabel('k_t'),ylabel('y');title('y_i_d');grid on

yss=sum(yid(90:100))/11;
uss=sum(uid(90:100))/11;

K=yss/uss;
y_t1=8.3;
M=(y_t1-yss)/yss;
zeta=log(1/M)/sqrt(pi^2+(log(M))^2);
y1max=8.3;y2max=6.3;
t1max=15;t2max=43;
T=(t2max-t1max)*ts;
omega_n=2*pi/(T*sqrt(1-zeta^2));
H=tf([K*omega_n^2],[1 2*zeta*omega_n omega_n^2]);

disp(strcat({'Suprareglajul M='},num2str(M)));
disp(strcat({'Perioada de oscilatie T='},num2str(T)));
disp(strcat({'Pulsatia naturala='},num2str(omega_n)));

yid_ap=lsim(H,uid,t(1:100));
yval_ap=lsim(H,uval,t(201:500));

figure
plot(yid,'b');hold on
plot(yid_ap,'r');
legend('yid','yid_a_p');
xlabel('t');ylabel('y');grid on

figure
plot(yval,'b');hold on
plot(yval_ap,'r');
legend('yval','yval_a_p');
xlabel('t');ylabel('y');grid on

MSEid=0;
for i=1:length(yid)
    MSEid=MSEid+(yid_ap(i)-yid(i))^2;
end
MSEid=MSEid/length(yid);

MSEval=0;
for i=1:length(yval)
    MSEval=MSEval+(yval_ap(i)-yval(i))^2;
end
MSEval=MSEval/length(yval);

disp(strcat({'MSE_identificare='},num2str(MSEid)));
disp(strcat({'MSE_validare='},num2str(MSEval)));
