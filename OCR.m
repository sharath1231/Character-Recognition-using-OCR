% OCR (Optical Character Recognition).
% Author: Ing. Diego Barragán Guerrero 
% e-mail: diego@matpic.com
% For more information, visit: www.matpic.com
%________________________________________
% PRINCIPAL PROGRAM
warning off %#ok<WNOFF>
% Clear all
clc, close all, clear all
% Read image
imagen=imread('test cases\t15.jpg');
% Show image
figure(10);
       imshow(imagen);
%%%%  add noise to the image
%imagen = imnoise(imagen,'gaussian',0,0.05);
% 
%         
% figure(1);        
% imshow(imagen);
% title('INPUT IMAGE WITH NOISE')
% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
figure(2);
imshow(imagen);
% use median filter
imagen = medfilt2(imagen,[10 10]);
figure(3);
imshow(imagen);
% use adaptive histogram equalisation
imagen = adapthisteq(imagen);
figure(4);
imshow(imagen);
% contrast stretching
imagen = imadjust(imagen);
figure(5);
imshow(imagen);
                     
% Convert to BW
                      
threshold = graythresh(imagen);
figure(6);
imshow(imagen);

imagen = imcrop(imagen,[20, 12, 725, 128]);

imagen =~im2bw(imagen,threshold);
figure(7);
imshow(imagen);

% se = strel('square',4);
% imagen = imopen(imagen,se);
% figure(8);
% imshow(imagen);
                                         
                     
% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
%Storage matrix word from image
word=[ ];
re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'a');
% Load templates
load templates
global templates
% Compute the number of letters in template file
num_letras=size(templates,2);
while 1
    %Fcn 'lines' separate lines in text
    [fl re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
         %imshow(img_r);pause(0.5)
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        letter=read_letter(img_r,num_letras);
        % Letter concatenation
        word=[word letter];
    end
    %fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
                %fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
                word
               % word1 = 'SHARATH'
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end
%%%%%%% to print in a text file 'text.txt'
%fclose(fid);
%Open 'text.txt' file
%winopen('text.txt')



clear all