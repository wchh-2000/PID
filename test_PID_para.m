function test_PID_para
%����ͬ������λ�ñ仯ͼ
close all
global dt lim_v
% PID=[0.3 0.5 0.3;%Kp Ki Kd
%     0.9 0.5 0.3;%�ڶ������
%     1.5 0.5 0.3];
PID=[1.5 0.1 0.3;%Kp Ki Kd
    1.5 0.2 0.3;%�ڶ������
    1.5 0.5 0.3];
% PID=[0.9 0.9 0;%Kp Ki Kd
%     0.9 0.9 0.5;%�ڶ������
%     0.9 0.9 0.9];
D=0;%Ŀ��λ��
lim_v=1;%�Ƿ����ٶ�����
dt=0.1;%���沽��
t=10; %����ʱ��
N=t/dt;
x=zeros(1,N);%��ʼ��λ������
v=zeros(1,N);%�ٶ�
e=zeros(1,N);%λ����� ������Ϊλ��
tlist=1:N;
text=cell(1,size(PID,1));%���ڻ�ͼ��ʾ����
line=cell(1,size(PID,1));%���ڻ�ͼ��ʾ����
line{1}='k:';
line{2}='k-.';
line{3}='k-';
x(1)=-100;%��ʼλ��
v(1)=10;%��ʼ�ٶ�
e(1)=D-x(1);
hold on
for i=1:size(PID,1)%����ÿ�����
    Kp=PID(i,1);
    Ki=PID(i,2);
    Kd=PID(i,3);    
    x(2)=x(1)+v(1)*dt;
    e(2)=D-x(2);
    v(2)=Kp*e(2)+Ki*(e(1)+e(2))+Kd*(e(2)-e(1))/dt;
    if lim_v==1 %�ٶ�����
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
        v(k)=cal_v(Kp,Ki,Kd,v(k-1),e(k),e(k-1),e(k-2));
    end
    plot(tlist,x,line{i})
    text{i}=['Kp=',num2str(Kp),' Ki=',num2str(Ki),' Kd=',num2str(Kd)];
end
legend(text{1},text{2},text{3})
xlabel('t')
ylabel('λ������')
set(gca, 'XTick',0:N/10:N,'XTicklabel',dt*[0:N/10:N]); 
grid on

function vn=cal_v(Kp,Ki,Kd,v,e,el,ell)
%����ʽPID
%eΪƫ�� elΪǰһʱ��ƫ� ellΪ��ǰһʱ��
%if dis>=115 && dis<=135
global dt lim_v
vn=v+Kp*(e-el)+Ki*e+Kd*(e-2*el+ell)/dt;
if lim_v==1 %�ٶ�����
    if vn>100
        vn=100;
    end
    if vn<-100
        vn=-100;
    end
end