data _null_;
  set viewing end=eod;
  if _n_=1 then do;
    declare hash v ();
      v.definekey('maintitle');
      v.definedata('maintitle','_point');
      v.definedone();
    declare hash duplicates (dataset:'viewing (obs=0)',ordered:'a',multidata:'y');
      duplicates.definekey('maintitle');
      duplicates.definedata(all:'y');
      duplicates.definedone();
  end;

  if v.find()^=0 then v.add(key:maintitle,data:maintitle,data:_n_);  /*If new VAR add it to hash*/
  else do;                 /* Not new maintitle? Then we are processing a duplicate       */
    duplicates.add();      /* First add incoming duplicate                          */
    if _point^=. then do;  /* Then go back to add the first dupe if not already done*/
      set viewing point=_point;
      duplicates.add();
      v.replace(key:maintitle,data:maintitle,data:.);
    end;
  end;
  if eod then rc=duplicates.output(dataset:'duptitles');
run;