/* Uncomment for custom output */
/*%let dest = %sysfunc(getoption(WORK))/report.xlsx;*/
/*ods excel(id=custom) file="&dest." options */
/*  ( sheet_interval='none' sheet_name='Shows');*/

/* Uncomment to modify the EG Excel output */
/*ods excel(id=egxlssx) options */
/* ( sheet_interval='none' sheet_name='Shows');*/

ods graphics / width=768 height=600;
proc sgplot data=viewing;
 where year(date) in (2019,2020);
 format date monyy.;
 vbar date / stat=freq group=profile groupdisplay=stack;
 yaxis grid label="Shows";
run;

/* Added Top 10 titles */
ods graphics / width=768 height=800;
title "Top 10 Titles streamed in our house";
%let TopN = 10;
proc freq data=viewing ORDER=freq;
  where year(date) in (2019,2020);
  Label maintitle="Program Title";
  tables maintitle / maxlevels=&TopN Plots=FreqPlot (orient=horizontal scale=percent);
run;

/* uncomment for custom output */
/* Note that PROC EXPORT does use SAS/ACCESS to PC Files */
/*ods excel(id=custom) close;*/
/**/
/*proc export data=viewing*/
/* outfile="&dest."*/
/* dbms=xlsx*/
/* replace;*/
/*sheet="ALL VIEWING";*/
/*run;*/
