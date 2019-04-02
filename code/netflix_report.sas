ods graphics / width=1200 height=600;
proc sgplot data=viewing;
 where year(date) in (2018, 2019);
 format date monyy.;
 vbar date / stat=freq group=profile groupdisplay=stack;
 yaxis grid label="Shows";
run;
