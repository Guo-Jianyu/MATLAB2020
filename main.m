clear all;
close all;
% ==============�ⶨ�㷨ִ�е�ʱ�䣬��ʼ��ʱ=================
tic
%=====================����ͼƬ================================
[fn,pn,fi]=uigetfile('*.jpg','ѡ��ͼƬ');
I=imread([pn fn]);figure,imshow(I);title('ԭʼͼ��');%��ʾԭʼͼ��
%I = imresize(I, [2048 1536]);
I_bai=I;
load param_char
load param_num
[PY2,PY1,PX2,PX1]=chepai_dingwei(I);


%===============������������������У��======================
[PY2,PY1,PX2,PX1,threshold]=jiaozheng(PY2,PY1,PX2,PX1);
%==============����ͼƬ=============================
I_new=I_bai(PY1:PY2,PX1:PX2,:);
%==============�����ø�ʴ�����ɫ������=============
bw=I_new;figure,imshow(bw);title('����ͼ��');
bw=rgb2gray(bw);figure,imshow(bw);title('�Ҷ�ͼ��');
%================��бУ��======================

qingxiejiao=rando_bianhuan(bw)%��ȡ��б�Ƕ�
bw=imrotate(bw,qingxiejiao,'bilinear','crop');figure,imshow(bw);title('��бУ��');%ȡֵΪ��ֵ������ת
%==============================================
bw=im2bw(bw,graythresh(bw));figure,imshow(bw);
bw=bwmorph(bw,'hbreak',inf);figure,imshow(bw);
bw=bwmorph(bw,'spur',inf);figure,imshow(bw);title('����֮ǰ');
bw=bwmorph(bw,'open',5);figure,imshow(bw);title('�պ�����');
bw = bwareaopen(bw, threshold);figure,imshow(bw);title('����');
%==========================================================
bw=~bw;figure,imshow(bw);title('������ɫ'); 
%=============��ͼ���һ���ü�����֤�߿���������===========
bw=touying(bw);figure;imshow(bw);title('Y������');
bw=~bw;
bw = bwareaopen(bw, threshold);
bw=~bw;%figure,imshow(bw);title('���β���');

 [y,x]=size(bw);%�Գ������¸�ֵ
% %=================���ַָ�=================================
 fenge=shuzifenge(bw,qingxiejiao)
 [m,k]=size(fenge);
% %=================��ʾ�ָ�ͼ����========================= 
figure;
for s=1:2:k-1
    subplot(1,k/2,(s+1)/2);imshow(~bw( 1:y,fenge(s):fenge(s+1)));
end
%================ ������ͼƬ��λ===============
han_zi  =~bw( 1:y,fenge(1):fenge(2));
zi_mu   =~bw( 1:y,fenge(3):fenge(4));
zm_sz_1 =~bw( 1:y,fenge(5):fenge(6));
zm_sz_2 =~bw( 1:y,fenge(7):fenge(8));  
shuzi_1 =~bw( 1:y,fenge(9):fenge(10)); 
shuzi_2 =~bw( 1:y,fenge(11):fenge(12)); 
shuzi_3 =~bw( 1:y,fenge(13):fenge(14)); 
%==========================ʶ��====================================
%======================���������ݶ���==============================
xiuzhenghanzi =   imresize(han_zi, [110 55],'bilinear');
xiuzhengzimu  =   imresize(zi_mu,  [110 55],'bilinear');
xiuzhengzm_sz_1=  imresize(zm_sz_1,[110 55],'bilinear');
xiuzhengzm_sz_2 = imresize(zm_sz_2,[110 55],'bilinear');
xiuzhengshuzi_1 = imresize(shuzi_1,[110 55],'bilinear');
xiuzhengshuzi_2 = imresize(shuzi_2,[110 55],'bilinear');
xiuzhengshuzi_3 = imresize(shuzi_3,[110 55],'bilinear');
%==========================ʶ��====================================
% figure();
% imshow(xiuzhenghanzi);
resultc = recchar(xiuzhenghanzi, param_char);
chepai2= recplate(xiuzhengzimu, param_num)
chepai3= recplate(xiuzhengzm_sz_1, param_num)
chepai4= recplate(xiuzhengzm_sz_2, param_num)
chepai5= recplate(xiuzhengshuzi_1, param_num)
chepai6= recplate(xiuzhengshuzi_2, param_num)
chepai7= recplate(xiuzhengshuzi_3, param_num)
fprintf('resultc = %s,chepai2 = %s,chepai3 = %s,chepai4 = %s,chepai5 = %s,chepai6 = %s,chepai7 = %s ',resultc, chepai2,chepai3, chepai4,chepai5, chepai6,chepai7);
%=====================�����ı�==================
shibiejieguo = strcat(resultc,chepai2,chepai3, chepai4,chepai5, chepai6,chepai7);
uiwait(msgbox(shibiejieguo,'���ƺ�','modal'));
fid=fopen('Data.xls','a+');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);
