/* Last updated Tuesday, Aug. 25 */

/************************************************************/
*Calculating p-values using effects coding;
/************************************************************/

/* Maybe show extended p-value in appendix? */

/* ************************** */
/* Logistic Regressions */
/* ************************** */

/* Ins vs. Acctage (logistic regression) */
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=acctage/clodds=pl;
	title 'Logistic Model (Effects Coding) with Age of Oldest Account';
run;
*p-value for Analysis of Max Likelihood Estimates coefficient is 0.0079;


proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=age/clodds=pl;
	title 'Logistic Model (Effects Coding) with age';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=atmamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Atmamt';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=ccbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with ccbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=cdbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with cdbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=checks/clodds=pl;
	title 'Logistic Model (Effects Coding) with Number of Checks WRITTEN';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=crscore/clodds=pl;
	title 'Logistic Model (Effects Coding) with crscore';
run;

ods output parameterestimates=ddabal;
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=ddabal/clodds=pl;
	title 'Logistic Model (Effects Coding) with Checking Account Balance';
run;

ods output parameterestimates=dep;
proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=dep/clodds=pl;
	title 'Logistic Model (Effects Coding) with Checking Deposits';
run;

data dep1;
	set dep;
	format probchisq dollar30.29;
run;

proc logistic data=hw_data.insurance_t alpha=0.002 outest=ins_depamt_reg;
	model ins(event='1')=depamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Total Amount Deposited';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=hmval/clodds=pl;
	title 'Logistic Model (Effects Coding) with hmval';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=ilsbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with ilsbal';
run;


proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=income/clodds=pl;
	title 'Logistic Model (Effects Coding) with income';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=invbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with invbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=irabal/clodds=pl;
	title 'Logistic Model (Effects Coding) with irabal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=locbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with locbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=lores/clodds=pl;
	title 'Logistic Model (Effects Coding) with lores';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=mmbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with mmbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=mtgbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with mtgbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=nsfamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with Nsfamt';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=phone/clodds=pl;
	title 'Logistic Model (Effects Coding) with Phone';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=pos/clodds=pl;
	title 'Logistic Model (Effects Coding) with pos';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=posamt/clodds=pl;
	title 'Logistic Model (Effects Coding) with posamt';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=savbal/clodds=pl;
	title 'Logistic Model (Effects Coding) with Savbal';
run;

proc logistic data=hw_data.insurance_t alpha=0.002;
	model ins(event='1')=teller/clodds=pl;
	title 'Logistic Model (Effects Coding) with Teller Visits';
run;

/* ************************** */
/* Chi Square Tests */
/* ************************** */

proc freq data=hw_data.insurance_t;
	tables atm*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. ATM";
run;

/* *Need full p-value for this one */
proc freq data=hw_data.insurance_t;
	tables branch*ins/chisq expected cellchi2 nocol nopercent relrisk;
	output out=branch chisq;
	title "Test of Assoc., Ins. vs. branch";
run;

data branch1;
	set branch;
	format p_lrchi dollar30.29;
run;

proc freq data=hw_data.insurance_t;
	tables cashbk*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. Cashbk";
run;

proc freq data=hw_data.insurance_t;
	tables cc*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. cc";
run;

/* need full p-value */
proc freq data=hw_data.insurance_t;
	tables ccpurc*ins/chisq expected cellchi2 nocol nopercent relrisk;
	output out=ccpurc chisq;
	title "Test of Assoc., Ins. vs. ccpurc";
run;

data ccpurc1;
	set ccpurc;
	format p_lrchi dollar30.29;
run;

proc freq data=hw_data.insurance_t;
	tables cd*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. cd";
run;

proc freq data=hw_data.insurance_t;
	tables dda*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. DDA";
run;

proc freq data=hw_data.insurance_t;
	tables dirdep*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. Dirdep";
run;

proc freq data=hw_data.insurance_t;
	tables hmown*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. hmown";
run;

proc freq data=hw_data.insurance_t;
	tables ils*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. ils";
run;

proc freq data=hw_data.insurance_t;
	tables inarea*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. inarea";
run;

proc freq data=hw_data.insurance_t;
	tables inv*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. inv";
run;

proc freq data=hw_data.insurance_t;
	tables ira*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. ira";
run;

proc freq data=hw_data.insurance_t;
	tables loc*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. loc";
run;

proc freq data=hw_data.insurance_t;
	tables mm*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. mm";
run;

/* *Need full p-value for this one */
proc freq data=hw_data.insurance_t;
	tables mmcred*ins/chisq expected cellchi2 nocol nopercent relrisk;
	output out=mmcred chisq;
	title "Test of Assoc., Ins. vs. mmcred";
run;

data mmcred1;
	set mmcred;
	format p_mhchi dollar30.29;
run;

proc freq data=hw_data.insurance_t;
	tables moved*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. moved";
run;

proc freq data=hw_data.insurance_t;
	tables mtg*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. mtg";
run;


proc freq data=hw_data.insurance_t;
	tables nsf* ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. Nsf.";
run;

proc freq data=hw_data.insurance_t;
	tables res*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. branch";
run;

proc freq data=hw_data.insurance_t;
	tables sav*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. sav";
run;

proc freq data=hw_data.insurance_t;
	tables sdb*ins/chisq expected cellchi2 nocol nopercent relrisk;
	title "Test of Assoc., Ins. vs. sdb";
run;
