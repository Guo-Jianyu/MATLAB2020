function savevari(rootp, img_train, label_train, img_test, label_test)
% ���������txt

%% ����ѵ���ļ�
fid=fopen(strcat(rootp, '\img_train.txt'),'wt'); %д����ļ���������������˵��
[m,n]=size(img_train);
 for i=1:m
	for j=1:n
        fprintf(fid,'%g ',img_train(i,j));
	end
 	fprintf(fid,'\n');
end
fclose(fid);

fid=fopen(strcat(rootp, '\label_train.txt'),'wt'); %д����ļ���������������˵��
[m,n]=size(label_train);
 for i=1:m
	for j=1:n
        fprintf(fid,'%g ',label_train(i,j));
	end
 	fprintf(fid,'\n');
end
fclose(fid);

%% ��������ļ�
fid=fopen(strcat(rootp, '\img_test.txt'),'wt'); %д����ļ���������������˵��
[m,n]=size(img_test);
 for i=1:m
	for j=1:n
        fprintf(fid,'%g ',img_test(i,j));
	end
 	fprintf(fid,'\n');
end
fclose(fid);

fid=fopen(strcat(rootp, '\label_test.txt'),'wt'); %д����ļ���������������˵��
[m,n]=size(label_test);
 for i=1:m
	for j=1:n
        fprintf(fid,'%g ',label_test(i,j));
	end
 	fprintf(fid,'\n');
end
fclose(fid);

end