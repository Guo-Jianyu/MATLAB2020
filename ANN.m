function param_char=ANN(img_train, label_train, img_test,label_test, param_char)
% ����ѵ���������ݼ�   char
% --------------------------------------------------
% ������ANN(img_train, label_train, img_test, label_test)
% @���� img_train      �����ѵ��ͼ��
%       label_train    �����ѵ��ͼ���ǩ
%       img_test       ����Ĳ���ͼ��
%       label_test     ����Ĳ���ͼ���ǩ
% ---------------------------------------------------

one_hot = param_char.one_hot;

%% ������ѵ��������
% goal ѵ��Ŀ����С����������Ϊ0.1
% epochs ѵ������
% Ir ѧϰ����
% mc ��������
% ����������
net=newff(minmax(img_train),[1000,one_hot],{'logsig','purelin'},'trainscg');
net.trainParam.epochs=8000;
net.trainParam.goal=1e-4;  
net.trainParam.lr=0.01;
net.trainParam.mc=0.2;
% ѵ��������
tic;
net=train(net,img_train,label_train);
toc
param_char.net=net;

%% ���������磨���棩
sim1=sim(net,img_train);[~ ,Y1] = max(sim1);
[~ ,trainl] = max(label_train);
ratio1 = mean(Y1==double(trainl));
fprintf('Train ratio�� %0.4g \n',ratio1);

sim2=sim(net,img_test);[~ , Y2] = max(sim2);
[~ ,testl] = max(label_test);
ratio2 = mean(Y2==double(testl));
fprintf('Test ratio�� %0.4g \n',ratio2);

end

