function err = calculateError (originalImg, decompressedImg)
  orig = double(imread (originalImg));
  decomp = double(imread (decompressedImg));
  dif = orig - decomp;
  err = (norm (dif (:,:,1)) + norm (dif (:,:,2)) + norm (dif (:,:,3)))/3;
  return
endfunction