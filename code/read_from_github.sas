/* Utility macro to check if folder is empty before Git clone */ 
%macro FolderIsEmpty(folder);
  %local memcount;
  %let memcount = 0;
	%let filrf=mydir;
	%let rc=%sysfunc(filename(filrf, "&folder."));
  %if &rc. = 0 %then %do;
  	%let did=%sysfunc(dopen(&filrf));
  	%let memcount=%sysfunc(dnum(&did));
  	%let rc=%sysfunc(dclose(&did));
    %let rc=%sysfunc(filename(filrf));
  %end;
  /* Value to return: 1 if empty, else 0 */
  %sysevalf(&memcount. eq 0)
%mend;

options dlcreatedir;
%let repopath=%sysfunc(getoption(WORK))/sas-netflix-git;
libname repo "&repopath.";
data _null_;
 if (%FolderIsEmpty(&repoPath.)) then do;
    	rc = gitfn_clone( 
      	"https://github.com/cjdinger/sas-netflix-git", 
      	"&repoPath." 
    				); 
    	put 'Git repo cloned ' rc=; 
    end;
    else put "Skipped Git clone, folder not empty";
run;

filename viewing "&repopath./NetflixData/*.csv";
data viewing (keep=title date profile);
 length title $ 300 date 8 
        profile $ 40 in $ 250;
 format date date9.;
 infile viewing dlm=',' dsd filename=in firstobs=2;
 profile=scan(in,-1,'\/');
 input title date:??mmddyy.;
 if date^=. and title ^="";
run;