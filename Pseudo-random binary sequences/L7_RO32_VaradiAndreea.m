clear all;
clc;
load('uval.mat');
val=system_simulator(2,u);
uval=val.InputData;
yval=val.OutputData;
ts=val.Ts;

N=300;
a=0.5;
b=1.7;
m=3;
na=15;nb=15;
pe_3=2^m-1;

u_3=spab(N,m,a,b);
iddata=system_simulator(2,u_3);
arx_3=arx(iddata,[na nb 0]);
compare(arx_3,val);

m=10;
pe_10=2^m-1;
u_10=spab(N,m,a,b);
iddata2=system_simulator(2,u_10);
arx_10=arx(iddata2,[na nb 0]);
figure
compare(arx_10,val);
yval_hat=sim(arx_10,u);

MSE=0;
for i=1:length(yval)
    MSE=MSE+(yval_hat(i)-yval(i))^2;
end
MSE=MSE/length(yval);

figure
plot(yval), hold on
plot(yval_hat)
title('MSE=',num2str(MSE));
legend('yval','yval_{hat}');

function u=spab(N,m,a,b)
la=[];
if(m==3)
    la=[1 0 1];
else if(m==4)
        la=[1 0 0 1];
    else if (m==5)
            la=[0 1 0 0 1];
        else if (m==6)
                la=[1 0 0 0 0 1];
            else if(m==7)
                    la=[1 0 0 0 0 0 1];
                else if (m==8)
                        la=[1 1 0 0 0 0 1 1];
                    else if (m==9)
                            la=[0 0 0 1 0 0 0 0 1];
                        else if (m==10)
                                la=[0 0 1 0 0 0 0 0 0 1];
                            end
                        end
                    end
                end
            end
        end
    end
end

A=eye(m);
A=[la;A];
A(m+1,:)=[];

C=zeros(1,m-1);
C=[C 1];

x=zeros(m,2^m);
x(:,1)=ones(m,1);

for k=2:N
    x(:,k-1)=x(:,k-1)';
    x(:,k)=mod(A*((x(:,k-1))),2);
    x(:,k)=x(:,k)';
    u(k)=C*((x(:,k)));
end

u=u';
u=a+(b-a)*u;

end