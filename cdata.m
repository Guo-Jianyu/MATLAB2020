function [train , test] = cdata(  labels, images)
% ����ѵ���������ݼ�
% --------------------------------------------------
% ������[train , test] = cdata( images, labels )
% @���� images    ����ͼ��
%       labels    �����ͼ���ǩ
% @��� train     �����ѵ��ͼ��ͱ�ǩ
%       test      ����Ĳ���ͼ��ͱ�ǩ
% ---------------------------------------------------

image_num=size(images, 3);
train_num= round(image_num*0.85);
test_num= image_num-train_num;

%% ��������
randIdx=randperm(size(images,3));
for i=1:size(images,3)
    newimages(:,:,i)=images(:,:,randIdx(i));
    newlabels(i)=labels(randIdx(i));
end;

%% �ּ����� 
% �ּ�ѵ������
train_images=newimages(:,:,1:train_num);
train_labels=newlabels(1:train_num);
train={train_images train_labels};

% �ּ��������
test_images=newimages(:,:,train_num+1:image_num);
test_labels=newlabels(train_num+1:image_num);
test={test_images test_labels};

end

