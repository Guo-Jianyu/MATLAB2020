function  [img_train, label_train, img_test, label_test, param_char]=process(train, test, flag, param_char)
% Ԥ����ѵ���������ݼ�, ������������ѵ�����ݺͲ������� char
% --------------------------------------------------
% ������[img_train, label_train, img_test, label_test, param_char]=process(train, test, flag, param_char)
% @���� train    ѵ��ͼ��Ԫ��������ѵ��ͼ��ͱ�ǩ
%       test     ����ͼ��Ԫ������������ͼ��ͱ�ǩ
% @��� img_train     ����������ѵ��ͼ��
%       img_test      ���������Ĳ���ͼ��
%       label_train   ����������ѵ����ǩ
%       label_test    ����������ѵ����ǩ
% ---------------------------------------------------
%                               ���� ��� @2017 05

%% �������
if nargin < 4
    dim = 50;
    if nargin < 3        
        warning('MATLAB:ParamAmbiguous','not enough parameters given')
    end
end

%% ��ȡ����
train_images=train{1};
train_labels=train{2};
test_images=test{1};
test_labels=test{2};

train_num=size(train_images,3);
test_num=size(test_images,3);

%% ��ǩ������
one_hot=param_char.one_hot;
label_train=zeros(one_hot,train_num); % ѵ����ǩ
for i=1:train_num
    for j=1:one_hot
        if(strcmp(flag(j), train_labels(i)))      
            label_train(j,i)=1;
            break;
        end
    end
end

label_test=zeros(one_hot,test_num); % ���Ա�ǩ
for i=1:test_num
    for j=1:one_hot
        if(strcmp(flag(j), test_labels(i)))      
            label_test(j,i)=1;
            break;
        end
    end
end

%% ͼ��Ԥ����1
% ��ֵ��
train_images2=double(train_images)/256;
for i=1:train_num
    c_max=double(max(max(train_images(:,:,i))));
    c_min=double(min(min(train_images(:,:,i))));
    T=round(c_max-(c_max-c_min)/3); %TΪ��ֵ������ֵ
    train_images(:,:,i)=im2bw(train_images2(:,:,i),T/256);
end
test_images2=double(test_images)/256;
for i=1:test_num
    c_max=double(max(max(test_images(:,:,i))));
    c_min=double(min(min(test_images(:,:,i))));
    T=round(c_max-(c_max-c_min)/3); %TΪ��ֵ������ֵ
    test_images(:,:,i)=im2bw(test_images2(:,:,i),T/256);
end
% ��ȡѵ��������������
train_row=size(train_images,1);
train_col=size(train_images,2);
train_page=size(train_images,3);

test_row=size(test_images,1);
test_col=size(test_images,2);
test_page=size(test_images,3);

% ����ֱ��Ϊ��һ��PCA�����ɷַ�������׼��
train_images=double(reshape( train_images, train_row*train_col, train_page)');
test_images=double(reshape( test_images, test_row*test_col, test_page)');

% ��һ����ȫ��ֵӳ�䵽0-1
train_images=bsxfun(@times,train_images,1./sum(train_images,2));
test_images=bsxfun(@times,test_images,1./sum(test_images,2));

% PCA�����ɷַ�������
[coef,~,latent]=pca(train_images);
% lat=cumsum(latent)./sum(latent); % Ϊ�ٷֱ�����ʹ��

%% ͼ��Ԥ����2����ά
dim=param_char.dim;
if(dim==0)
   dim= size(coef,2);
end;
img_train = train_images*coef(:,1:dim);
img_test = test_images*coef(:,1:dim);
latent=latent';

img_train=bsxfun(@rdivide,img_train, sqrt(latent(1:dim)+1e-6));
img_test=bsxfun(@rdivide,img_test, sqrt(latent(1:dim)+1e-6));

img_train = img_train'; 
img_test = img_test';

param_char.cate=flag;
param_char.latent=latent;
param_char.img_size=size(train_images(:,:,1));
param_char.coef=coef;
end

