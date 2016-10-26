S1 = imread ("bilinear.png");
S2 = imread("bicubica.png");
J = imread ("seno.png");
imwrite(uint8(abs(double(J)-double(S1)))*10, "erro_linear.png")
imwrite(uint8(abs(double(J)-double(S2)))*10, "erro_cubico.png")
imwrite(uint8(abs(double(S1)-double(S2)))*10, "dif_err.png")
