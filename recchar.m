function resultc=recchar(Ipchar, param_char)
% �˺����Ƕ��ַ��Ķ�ֵͼ�����ʶ��
% --------------------------------------------------------
% ����  [resultc, Ic]=recchar(Ichar);
% @���� Ichar     ��ֵ�������ֻ�����ĸͼ��
% @��� resultc   ʶ����
%       Ic        ʶ���ԭͼ
% --------------------------------------------------------
%                          
% /////////////////////////////////////////////////////
image=Ipchar; % ʶ��ͼƬ
% Ԥ����
image=imresize(image,param_char.img_size);
image=double(reshape(image, param_char.img_size(1)*param_char.img_size(2), 1)'); % ����ֱ����һ��PCA�����ɷַ�����
image=bsxfun(@times,image,1./sum(image,2));% ��һ����ȫ��ֵӳ�䵽0-1
image = image*param_char.coef(:,1:param_char.dim);% ��ά

image=bsxfun(@rdivide, image, sqrt(param_char.latent(1:param_char.dim)+1e-6));% �׻�
imgage = image'; % ����Ҫʹ��������

% ����
val=sim(param_char.net, imgage);
[~,temp] = max(val);
resultc=param_char.cate(temp);
end

