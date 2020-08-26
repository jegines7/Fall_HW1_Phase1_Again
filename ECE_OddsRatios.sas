/**************************************************************************/
/* ODDS RATIOS FOR DDA */

proc freq data=LRHW1.insurance_t;
	tables ins*dda/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR MOVED */
proc freq data=LRHW1.insurance_t;
	tables ins*MOVED/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR INV */
proc freq data=LRHW1.insurance_t;
	tables ins*INV/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR MTG */
proc freq data=LRHW1.insurance_t;
	tables ins*MTG/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR ILS */
proc freq data=LRHW1.insurance_t;
	tables ins*ILS/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR IRA */
proc freq data=LRHW1.insurance_t;
	tables ins*IRA/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR LOC */
proc freq data=LRHW1.insurance_t;
	tables ins*LOC/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR NSF */
proc freq data=LRHW1.insurance_t;
	tables ins*NSF/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR SDB */
proc freq data=LRHW1.insurance_t;
	tables ins*SDB/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR MM */
proc freq data=LRHW1.insurance_t;
	tables MM*INS/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR CD */
proc freq data=LRHW1.insurance_t;
	tables ins*CD/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR DIRDEP */
proc freq data=LRHW1.insurance_t;
	tables ins*DIRDEP/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR SAV */
proc freq data=LRHW1.insurance_t;
	tables ins*SAV/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR CC */
proc freq data=LRHW1.insurance_t;
	tables ins*CC/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR HMOWN */
proc freq data=LRHW1.insurance_t;
	tables ins*HMOWN/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR ATM */
proc freq data=LRHW1.insurance_t;
	tables ins*ATM/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;

/**************************************************************************/
/* ODDS RATIOS FOR INAREA */
proc freq data=LRHW1.insurance_t;
	tables ins*INAREA/chisq expected cellchi2 nocol nopercent relrisk;
	title "MH Chi Square Test, Ins. vs. DDA";
run;