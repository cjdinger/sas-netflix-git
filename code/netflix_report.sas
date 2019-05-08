ods graphics / width=1200 height=600;
proc sgplot data=viewing;
 where year(date) in (2018, 2019);
 format date monyy.;
 vbar date / stat=freq group=profile groupdisplay=stack;
 yaxis grid label="Shows";
run;

/* Added Top 10 titles */
ods graphics / width=800 height=800;
title "Top 10 Titles streamed in our house";
%let TopN = 10;
proc freq data=viewing ORDER=freq;
  where year(date) in (2018, 2019);
  Label maintitle="Program Title";
  tables maintitle / maxlevels=&TopN Plots=FreqPlot (orient=horizontal scale=percent);
run;