## Trabalho da diciplina MAC0210 - Laboratório de Métodos Numéricos

### Teste:

S1 = imread("bilinear.png");  
S2 = imread("bicubica.png");  
J = imread("original.png");  
imwrite(uint8(abs(double(J) - double(S1))) * 10, "erro_linear.png");  
imwrite(uint8(abs(double(J) - double(S2))) * 10, "erro_cubico.png");  
imwrite(uint8(abs(double(S1) - double(S2))) * 10, "dif_err.png");  
