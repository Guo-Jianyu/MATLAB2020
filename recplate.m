function result=recplate(num_char, param_num)
% �˺����Ƕ�������ĸ�Ķ�ֵͼ�����ʶ��
% --------------------------------------------------------
% ����  [result, Ipcrop]=recplate(Ipcrop, param_num)
% @���� Ipcrop     ��ֵ�������ֻ�����ĸͼ��
%       Ipchar     ��ֵ���ĺ���
% %       param      �ṹ�壬�����������ݣ�
%                  [    param.net       ѵ���õ�BP������]
%                  [    param.coef      PCA����          ]
%                  [    param.latent    PCA����          ]
%                  [    param.dim       ��άά��         ]
% @��� result     ʶ����
%       Icrop      ʶ���ԭͼ
% --------------------------------------------------------
%                                    ���ߣ� � @2017 ,04
% clear
% clc
% load test

%% ��ȡԤѵ������
% coef=param.coef;
% dim=param.dim;
% latent=param.latent;
% net=param.net;
% cate=param.cate;
% img_size=param.img_size;

%% ʶ����ĸ 
    image=num_char; % ʶ���i��ͼƬ
    
    % Ԥ����
    image=imresize(image, param_num.img_size);
    image2=double(reshape(image, param_num.img_size(1)*param_num.img_size(2), 1)'); % ����ֱ����һ��PCA�����ɷַ�����
    image2=bsxfun(@times,image2,1./sum(image2,2));% ��һ����ȫ��ֵӳ�䵽0-1
    image2 = image2*param_num.coef(:,1:param_num.dim);% ��ά
    image2=bsxfun(@rdivide, image2, sqrt(param_num.latent(1:param_num.dim)+1e-6));% �׻�
    image2 = image2'; % ����Ҫʹ��������
    
    % ����
    val=sim(param_num.net,image2);
    [~ , temp] = max(val);    
      ch=param_num.cate(temp);

    % �����ʾ
    result=ch;
end