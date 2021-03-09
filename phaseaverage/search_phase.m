function [p_fil,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup] = serach_phase(dir_p,fn_p,pres_datasize)

  fid=fopen(strcat(dir_p,fn_p),'r');
  p_fil=fread(fid,pres_datasize,'double');
  fclose(fid);

  [pks_pres,locs_presmax] = findpeaks(p_fil);
  TF_pres = islocalmin(p_fil);

  nn=0;

  for t=1:pres_datasize
      if TF_pres(t)==1
          nn=nn+1;
          locs_prestemp(nn)=t;
      end
  end

  locs_presmin=reshape(locs_prestemp,[nn,1]);

  if length(locs_presmin) <= length(locs_presmax)
    if (locs_presmax(1) < locs_presmin(1))
        for t=1:length(locs_presmin)-1
          inflect1(t)=ceil((locs_presmin(t)+locs_presmax(t))/2);
        end
        for t=1:length(locs_presmin)-1
          inflect2(t)=ceil((locs_presmax(t+1)+locs_presmin(t))/2);
        end
    else
        for t=1:length(locs_presmin)-1
          inflect2(t)=ceil((locs_presmax(t)+locs_presmin(t))/2);
        end
        for t=1:length(locs_presmin)-1
          inflect1(t)=ceil((locs_presmin(t+1)+locs_presmax(t))/2);
        end
    end
    locs_inflectdown=reshape(inflect1,[length(locs_presmin)-1,1]);
    locs_inflectup=reshape(inflect2,[length(locs_presmin)-1,1]);

  else
    if (locs_presmax(1) < locs_presmin(1))
        for t=1:length(locs_presmax)-1
          inflect1(t)=ceil((locs_presmin(t)+locs_presmax(t))/2);
        end
        for t=1:length(locs_presmax)-1
          inflect2(t)=ceil((locs_presmax(t+1)+locs_presmin(t))/2);
        end
    else
        for t=1:length(locs_presmax)-1
          inflect2(t)=ceil((locs_presmax(t)+locs_presmin(t))/2);
        end
        for t=1:length(locs_presmax)-1
          inflect1(t)=ceil((locs_presmin(t+1)+locs_presmax(t))/2);
        end
    end
    locs_inflectdown=reshape(inflect1,[length(locs_presmax)-1,1]);
    locs_inflectup=reshape(inflect2,[length(locs_presmax)-1,1]);
  end

end
