clear all;
close all;
% ==============测定算法执行的时间，开始计时=================
tic
%=====================读入图片================================
[fn,pn,fi]=uigetfile('*.jpg','选择图片');
I=imread([pn fn]);figure,imshow(I);title('原始图像');%显示原始图像
%I = imresize(I, [2048 1536]);
I_bai=I;
load param_char
load param_num
[PY2,PY1,PX2,PX1]=chepai_dingwei(I);


%===============车牌区域根据面积二次校正======================
[PY2,PY1,PX2,PX1,threshold]=jiaozheng(PY2,PY1,PX2,PX1);
%==============更新图片=============================
I_new=I_bai(PY1:PY2,PX1:PX2,:);
%==============考虑用腐蚀解决蓝色车问题=============
bw=I_new;figure,imshow(bw);title('车牌图像');
bw=rgb2gray(bw);figure,imshow(bw);title('灰度图像');
%================倾斜校正======================

qingxiejiao=rando_bianhuan(bw)%获取倾斜角度
bw=imrotate(bw,qingxiejiao,'bilinear','crop');figure,imshow(bw);title('倾斜校正');%取值为负值向右旋转
%==============================================
bw=im2bw(bw,graythresh(bw));figure,imshow(bw);
bw=bwmorph(bw,'hbreak',inf);figure,imshow(bw);
bw=bwmorph(bw,'spur',inf);figure,imshow(bw);title('擦除之前');
bw=bwmorph(bw,'open',5);figure,imshow(bw);title('闭合运算');
bw = bwareaopen(bw, threshold);figure,imshow(bw);title('擦除');
%==========================================================
bw=~bw;figure,imshow(bw);title('擦除反色'); 
%=============对图像进一步裁剪，保证边框贴近字体===========
bw=touying(bw);figure;imshow(bw);title('Y方向处理');
bw=~bw;
bw = bwareaopen(bw, threshold);
bw=~bw;%figure,imshow(bw);title('二次擦除');

 [y,x]=size(bw);%对长宽重新赋值
% %=================文字分割=================================
 fenge=shuzifenge(bw,qingxiejiao)
 [m,k]=size(fenge);
% %=================显示分割图像结果========================= 
figure;
for s=1:2:k-1
    subplot(1,k/2,(s+1)/2);imshow(~bw( 1:y,fenge(s):fenge(s+1)));
end
%================ 给七张图片定位===============
han_zi  =~bw( 1:y,fenge(1):fenge(2));
zi_mu   =~bw( 1:y,fenge(3):fenge(4));
zm_sz_1 =~bw( 1:y,fenge(5):fenge(6));
zm_sz_2 =~bw( 1:y,fenge(7):fenge(8));  
shuzi_1 =~bw( 1:y,fenge(9):fenge(10)); 
shuzi_2 =~bw( 1:y,fenge(11):fenge(12)); 
shuzi_3 =~bw( 1:y,fenge(13):fenge(14)); 
%==========================识别====================================
%======================把修正数据读入==============================
xiuzhenghanzi =   imresize(han_zi, [110 55],'bilinear');
xiuzhengzimu  =   imresize(zi_mu,  [110 55],'bilinear');
xiuzhengzm_sz_1=  imresize(zm_sz_1,[110 55],'bilinear');
xiuzhengzm_sz_2 = imresize(zm_sz_2,[110 55],'bilinear');
xiuzhengshuzi_1 = imresize(shuzi_1,[110 55],'bilinear');
xiuzhengshuzi_2 = imresize(shuzi_2,[110 55],'bilinear');
xiuzhengshuzi_3 = imresize(shuzi_3,[110 55],'bilinear');
%==========================识别====================================
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
%=====================导出文本==================
shibiejieguo = strcat(resultc,chepai2,chepai3, chepai4,chepai5, chepai6,chepai7);
uiwait(msgbox(shibiejieguo,'车牌号','modal'));
fid=fopen('Data.xls','a+');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);
