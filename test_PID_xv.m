function test_PID_xv
%��λ�� �ٶȱ仯ͼ
close all
global Kp Ki Kd dt lim_v
Kp=0.5;
Ki=0.02;
Kd=0;
D=0;
lim_v=1;%�Ƿ����ٶ�����
dt=0.1;
t=40;
N=t/dt;
x=zeros(1,N);%��ʼ��λ������
v=zeros(1,N);%�ٶ�
e=zeros(1,N);%λ����� ������Ϊλ��
tlist=1:N;
x(1)=-100;
v(1)=10;
e(1)=D-x(1);
x(2)=x(1)+v(1)*dt;
e(2)=D-x(2);
v(2)=Kp*e(2)+Ki*(e(1)+e(2))+Kd*(e(2)-e(1))/dt;
if lim_v==1
    if v(2)>100
        v(2)=100;
    end
    if v(2)<-100
        v(2)=-100;
    end
end
for k=3:N
    x(k)=x(k-1)+v(k-1)*dt;
    e(k)=D-x(k);
    v(k)=cal_v(v(k-1),e(k),e(k-1),e(k-2));
end
figure(1)
hold on
plot(tlist,x,'b')
plot(tlist,v,'r')
legend('x','v')
xlabel('t')
set(gca, 'XTick',0:N/10:N,'XTicklabel',dt*[0:N/10:N]); 
title('λ�� �ٶȱ仯ͼ')
grid on

function vn=cal_v(v,e,el,ell)
%����ʽPID
%if dis>=115 && dis<=135
global Kp Ki Kd dt lim_v
vn=v+Kp*(e-el)+Ki*e+Kd*(e-2*el+ell)/dt;
if lim_v==1
    if vn>100
        vn=100;
    end
    if vn<-100
        vn=-100;
    end
end