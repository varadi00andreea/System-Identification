clear all
clc;
load('lab5_5.mat');
stem(imp);
uid=id.InputData{1};
yid=id.OutputData{1};
uval=val.InputData{1};
yval=val.OutputData{1};

figure
subplot(211),plot(uid);title('u_{id}');
subplot(212),plot(yid);title('y_{id}');
figure
subplot(211),plot(uval);title('u_{val}');
subplot(212),plot(yval);title('y_{val}');

M=[50,59,72,80,100];

N=length(uid);
T=N;
ru=zeros(T,1);
uid=detrend(uid);
yid=detrend(yid);

for i=1:T
    for k=1:N-i
        ru(i)=ru(i)+uid(k+i-1)*uid(k);
    end
    ru(i)=(1/N)*ru(i);
end

ryu=zeros(T,1);
for i=1:T
    for k=1:N-i
        ryu(i)=ryu(i)+yid(k+i-1)*uid(k);
    end
    ryu(i)=(1/N)*ryu(i);
end

for l=1:length(M)
Ru=zeros(T,M(l));
for i=1:T
    for j=1:M(l)
        if(i==j)
            Ru(i,j)=ru(1);
        else if(i>j)
                Ru(i,j)=ru(i-j+1);
            else
                Ru(i,j)=ru(j);
            end
        end
    end
end

Ryu=ryu(:);
H=Ru\Ryu;
h=H';
yid_hat=conv(h,uid);
yid_hat=yid_hat(1:length(uid));

MSE_id=0;
for i=1:length(yid)
    MSE_id=MSE_id+(yid_hat(i)-yid(i))^2;
end
MSE_id=MSE_id/length(yid);

figure(M(l))
subplot(211)
plot(yid);
hold on
plot(yid_hat);
title('MSE_{id}=',num2str(MSE_id));
legend('System','FIR Model');

yval_hat=conv(h,uval);
yval_hat=yval_hat(1:length(uval));

MSE_val=0;
for i=1:length(yval)
    MSE_val=MSE_val+(yval_hat(i)-yval(i))^2;
end
MSE_val=MSE_val/length(yval);

subplot(212);
plot(yval);
hold on
plot(yval_hat);
title('MSE_{val}=',num2str(MSE_val));
legend('System','FIR Model');
end