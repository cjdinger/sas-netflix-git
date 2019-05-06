%if %symexist(_SASPROGRAMFILE) %then %do;
  %let codepath =
    %sysfunc(substr(%sysfunc(dequote(&_SASPROGRAMFILE)), 1,
    %sysfunc(findc(%sysfunc(dequote(&_SASPROGRAMFILE)), %str(/\), -255 )))); 
    %put Base code path is &codepath.;
%end;

filename viewing "&codepath.../NetflixData/*.csv";

data viewing;
 length title $ 300 date 8 
        maintitle $ 60 episode $ 40 season $ 12 
        profile $ 40 in $ 250;
 informat date mmddyy.;
 format date date9.;
 infile viewing dlm=',' dsd filename=in firstobs=2;
 profile=scan(in,-1,'\');
 input title date;
 array part $ 60 part1-part4;
 do i = 1 to 4;
	part{i} = scan(title, i, ':',);
  if (find(part{i},"Season")>0)
   then do;
     season=part{i};
   end;
	end;
 drop i;
 maintitle = part{1};
 episode = part{3};
run;
