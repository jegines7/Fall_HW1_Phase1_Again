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

/* Detecting Ordinal Associations for small samples, using exact fisher test */
proc freq data=logreg.insurance_t;
    tables (cashbk mmcred)*ins / fisher;
    title 'Ordinal Association?';
run;
/* Chi-Square Test used for all non continuous variables */
proc freq data=logreg.insurance_t;
	tables ins*(moved inarea branch res)/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test";
run;

