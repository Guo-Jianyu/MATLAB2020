% ѵ��matlab�������� char
% ͼƬ��С�ǹ�һ��Ϊ 16 * 32
clear all
close all
clc

rootpath='samples/*';
[labels, images ,flag] = readimg(rootpath);
% load variables
param_char.dim=10;
param_char.one_hot=length(flag);

%% ���ɱ�׼���ݸ�ʽ��������mnist��
[train , test] = cdata(labels, images);
clear images labels

%% Ԥ����
[img_train, label_train, img_test, label_test, param_char]=...
    process(train, test, flag, param_char);
% clear test train dim flag
 savevari('D:', img_train, label_train, img_test, label_test) % �洢���ݼ���txt

%% ������
param_char = ANN(img_train, label_train, img_test, label_test, param_char); % ѵ�������粢�õ�ʶ����
save param_char