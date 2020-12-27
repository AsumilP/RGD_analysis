function skip_frames(fid,skip_frame,framesize,typesize,skipmode)
  if skipmode == 1 %%For first_frame
    fseek(fid,(skip_frame-1)*framesize*typesize,'bof');
  end
  if skipmode == 2 %%Others
    fseek(fid,skip_frame*framesize*typesize,'cof');
  end
end
