function [Ipcrop, Ipchar] = cropplate(Iplate)
% �����ַ��ü�������ֵ����ͼ���������ַ�
% �ü��ɵ����ַ�ͼ��
% -----------------------------------
% ����   
% [Ipcrop, Ipchar] = cropplate(Iplate)
% @���� Iplate ����ĳ���ͼ��
% @��� Icrop  ����ü����ͼ������
% @��� Ipchar �ü����һ��ͼ�񣬺���
% -----------------------------------
%                  ���ߣ�� @2017
% clear
% clc
% load test
%%
% Ԥ����
% subplot(1,2,1),plot(Iplate),title('����ͼ��');
Ipf=bwareaopen(Iplate,20);% ��̬ѧ�˲�������ͼ���Ƕ�ֵͼ��%��
Ippcrop=double(Ipf);

[h,w]=size(Ippcrop); 
X3=zeros(1,w);%����1��q��ȫ������
for j=1:w
    for i=1:h
       if(Ippcrop(i,j)==1) 
           X3(1,j)=X3(1,j)+1;
       end
    end
end
% subplot(1,2,2),plot(0:w-1,X3),title('�з������ص�Ҷ�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('�ۼ�������');

% �ַ��ָ� h��w������ָ�
Px0=w;%�ַ��Ҳ���
Px1=w;%�ַ������
for i=1:6
    while((X3(1,Px0)<3)&&(Px0>0))
       Px0=Px0-1;
    end
    Px1=Px0;
    while(((X3(1,Px1)>=3))&&(Px1>0)||((Px0-Px1)<15))
        Px1=Px1-1;
    end
    Ipcrop{i}=Ipf(:,Px1:Px0,:);
    Px0=Px1;
end
% �Ե�һ�����д���
img=Ipcrop{1};%�ַ�1�Ҳ���
PX3=round(size(img,2)/2);
sum1=sum(img);
while((sum1(1,PX3-2)+sum1(1,PX3-1)+sum1(1,PX3)~=0) && ( PX3<length(sum1)-2) )
       PX3=PX3+1;
end
Ipcrop{1}=img(:,1:PX3);
% imshow(Ipcrop{end})
% �����һ�����д���
img=Ipcrop{end};%�ַ�1�Ҳ���
PX3=round(size(img,2)/2);
sum1=sum(img);
while((sum1(1,PX3-2)+sum1(1,PX3-1)+sum1(1,PX3)~=0) && ( PX3<length(sum1)-2) )
       PX3=PX3+1;
end
Ipcrop{end}=img(:,1:PX3);
% imshow(Ipcrop{end})


% �Ե�һ���ַ������ر���
PX3=Px1;%�ַ�1�Ҳ���
while((X3(1,PX3)<3)&&(PX3>0))
       PX3=PX3-1;
end
PX2=PX3; % �ַ�1�������
while( X3(1, PX2+1)+ X3(1,PX2-1)+ X3(1,PX2) > 1 && PX2 > 2)
       PX2=PX2-1;       
end
Ipchar=Ippcrop(:,PX2:PX3,:);

end
% 
