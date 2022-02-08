clear;
close all
clc;

load('lab4_11.mat');
xid=id.X;
xval=val.X;
yid=id.Y;
yval=val.Y;

subplot(211),plot(xid,yid);grid on;title('Date de identificare');xlabel('x');ylabel('y');
subplot(212),plot(xval,yval);grid on;title('Date de validare');xlabel('x');ylabel('y');

Nid=length(yid);
Yid=zeros(Nid,1);
Nval=length(yval);
Yval=zeros(Nval,1);
mse_id_v=zeros(20,1);
mse_val_v=zeros(20,1);
n_v=zeros(20,1);
grad_ales=19;

for i=1:Nid
    Yid(i,1)=yid(i);
end

for i=1:Nval
    Yval(i,1)=yval(i);
end

for i=1:length(xid)
    for j=1:grad_ales
        phi_id_ales(i,j)=xid(i)^(j-1);
    end
end

theta_id_ales=phi_id_ales\Yid;
Yid_hat_ales=phi_id_ales*theta_id_ales;
MSE_Yid_ales=0;
for i=1:length(Yid)
    MSE_Yid_ales=MSE_Yid_ales+(Yid_hat_ales(i)-Yid(i))^2;
end
MSE_Yid_ales=MSE_Yid_ales/length(Yid);

for i=1:length(xval)
    for j=1:grad_ales
        phi_val_ales(i,j)=xval(i)^(j-1);
    end
end

Yval_hat_ales=phi_val_ales*theta_id_ales;
MSE_Yval_ales=0;
for i=1:length(Yval)
    MSE_Yval_ales=MSE_Yval_ales+(Yval_hat_ales(i)-Yval(i))^2;
end
MSE_Yval_ales=MSE_Yval_ales/length(Yval);

figure
plot(Yval);
grid on;
hold on
plot(Yval_hat_ales);
legend('date validare','aproximare');
title('mse_{val}=',num2str(MSE_Yval_ales));

figure
plot(Yid);
grid on;
hold on
plot(Yid_hat_ales);
legend('date identificare','aproximare');
title('mse_{id}=',num2str(MSE_Yid_ales));

for n=1:20
    n_v(n)=n;
    for i=1:length(xid)
        for j=1:n
            phi_id(i,j)=xid(i)^(j-1);
        end
    end
    theta_id=phi_id\Yid;
    Yid_hat=phi_id*theta_id;
    
    MSE_Yid=0;
    for i=1:length(Yid)
        MSE_Yid=MSE_Yid+(Yid_hat(i)-Yid(i))^2;
    end
    MSE_Yid=MSE_Yid/length(Yid);
    mse_id_v(n)=MSE_Yid;
    
    for i=1:length(xval)
        for j=1:n
            phi_val(i,j)=xval(i)^(j-1);
        end
    end
    
    Yval_hat=phi_val*theta_id;
    
    MSE_Yval=0;
    for i=1:length(Yval)
        MSE_Yval=MSE_Yval+(Yval_hat(i)-Yval(i))^2;
    end
    MSE_Yval=MSE_Yval/length(Yval);
    mse_val_v(n)=MSE_Yval;
    
end

figure
subplot(211),plot(n_v,mse_id_v);xlabel('n'),ylabel('mse_{id}');grid on
subplot(212),plot(n_v,mse_val_v);xlabel('n'),ylabel('mse_{val}');grid on

for i=1:20
    if(mse_val_v(i)==min(mse_val_v))
        grad_optim=i;
    end
end

for i=1:length(xval)
    for j=1:grad_optim
        phi_val_optim(i,j)=xval(i)^(j-1);
    end
end
theta_optim=phi_val_optim\Yval;

disp(strcat({'Grad ales= '},num2str(grad_ales)));
disp(strcat({'Grad optim= '},num2str(grad_optim)));
disp('Theta optim= ');
disp(theta_optim);