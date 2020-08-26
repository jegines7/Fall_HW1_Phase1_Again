*Logistic regression HW1;
libname logreg "/opt/sas/home/jegines/sasuser.viya/Logisitic Regression";

proc freq data=logreg.insurance_t;
run;
*This step done for all continuous variables to assess their relationship with the insurance product purchase target vairable;

proc logistic data=logreg.insurance_t alpha=.002;
model ins(event='1')=hmval /clodds=pl;
title 'Logistic Model ';
run;
proc logistic data=logreg.insurance_t alpha=.002;
model ins(event='1')=age /clodds=pl;
title 'Logistic Model ';
run;

proc logistic data=logreg.insurance_t alpha=.002;
model ins(event='1')=crscore /clodds=pl;
title 'Logistic Model ';
run;

/* Chi-Square Test */
proc freq data=logreg.insurance_t;
    tables (moved)*ins
          / chisq expected cellchi2 nocol nopercent
            relrisk;
run;
/* Detecting Ordinal Associations for small samples */
proc freq data=logreg.insurance_t;
    tables (cashbk mmcred)*ins / fisher;
    title 'Ordinal Association?';
run;
proc freq data=logreg.insurance_t;
	tables ins*(moved inarea branch res)/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test";
run;




proc freq data=logreg.insurance_t;
	tables ins*ILS/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*IRA/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*dda/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*LOC/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*NSF/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*SDB/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables MM*INS/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*CD/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*DIRDEP/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*SAV/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*CC/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*HMOWN/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*ATM/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*DDA/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

proc freq data=logreg.insurance_t;
	tables ins*INAREA/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;
