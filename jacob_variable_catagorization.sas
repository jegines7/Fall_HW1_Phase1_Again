/*
Name: Jacob Hyman 
Date: 08/26/2020
Objective: determine which variables 
	are continuous (defined as having > 10 catagories, nominal, binary, or ordinal)
Method: proc freq for each variable

/*We are trying to predict 
INS which takes a value of 1 if they bought and 0 if they did not buy.
the other variables represent data before they were offered the variable annuity*/

%let all_var = ACCTAGE DDA DDABAL DEP DEPAMT CASHBK CHECKS DIRDEP NSF NSFAMT PHONE TELLER
 SAV SAVBAL ATM ATMAMT POS POSAMT CD CDBAL IRA IRABAL LOC LOCBAL INV INVBAL ILS ILSBAL
 MM MMBAL MMCRED MTG MTGBAL CC CCBAL CCPURC SDB INCOME HMOWN LORES HMVAL;

/* exploring the data and available variables, as well as the number of missing variables*/
proc contents data=dt.insurance_t;
run;

proc means data=dt.insurance_t n nmiss mean stddev skew;
	var &all_var;
run;

/*__________________________________________________________________*/
/*plots a subset of variables*/
proc freq data=dt.insurance_t;
	table CC MTG MMCRED MTGBAL CCBAL CCPURC SDB INCOME HMOWN LORES/ plots=freqplot missing nocol nocum nofreq;
run;


proc freq data=dt.insurance_t;
	where MMCRED not = 0;
	table MMCRED*INS / plots=freqplot (twoway=stacked scale=grouppct) missing;
run;
