function [labels, images ,flag] = readimg(rootpath)
%  ��ʽ��ͼ��
%  �����С��һ����ĳ��Ƶ��ַ�ͼ��
%   
% clear
% clc
% rootpath='samples/*';
%%

dirs = dir(rootpath); % �趨��Ŀ¼������ȡ��Ŀ¼�µ��ļ���
l = length(dirs)  % �ļ��и���
labels=[]; % ��ʼ��
images(16,32,1)=0; % ��ʼ��
num=1;
flag=[];

%% ѭ����ȡÿһ��Ŀ¼�µ�bmpͼ��
for i=1:l    
    fprintf('.');
    % ���ɵ�ǰĿ¼�µ�·��
    path=strcat('samples/ ',dirs(i).name, '/');
    files = dir(strcat(path,'*.bmp')); % ��ȡ��i��·���������ļ����� 
    n=length(files); % �õ����ļ�����
    % �ܽ���ѭ��˵����ǰ·����png�ļ�
    if n~=0 % ��ǰĿ¼�´���png�ļ�����������0��
    %��ȡͼ�񲢷�����25*15
    label=[];
    flag=[flag dirs(i).name ];
    for j=1:200
        img=imresize(imread(strcat(path, files(j).name)),[16,32]); %����ͼ��
        images(:,:,num)=img(:,:);
        label=[label dirs(i).name];
        num=num+1;
    end
    % �洢��ǰ��ǩ
    labels=[labels label];
    end
end

% չʾBÿ��Ԫ�صĵ����ͼ��
figure(1)
j=0;
for i=1:200:6800
    j=j+1
    subplot(6,6,j)
    imshow(uint8(images(:,:,i)));
end
save variables flag images labels
end



