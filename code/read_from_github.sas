options dlcreatedir;
%let repopath=%sysfunc(getoption(WORK))/sas-netflix-git;
libname repo "&repopath.";
data _null_;
 rc = gitfn_clone("https://github.com/cjdinger/sas-netflix-git","&repopath.",,);
run;

data viewing;
 length title $ 300 date 8 
        profile $ 40 in $ 250;
 informat date mmddyy.;
 format date date9.;
 infile viewing dlm=',' dsd filename=in firstobs=2;
 profile=scan(in,-1,'\/');
 input title date;
run;