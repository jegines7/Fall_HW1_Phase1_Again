/*********************************************************/ 
/* Testing Continuous Variables for Linearity Assumption */
/*                       Ike Ingle                       */
/*********************************************************/ 

/*****************************/ 
/* Exploratory Data Analysis */
/*****************************/ 


/* check for 0's and negative numbers in continuous vars to account for any potential issues */
/* within a Box-Tidwell Transformation and found that all have this issue except for ACCTAGE */
/* but it does have 546 missing vals that could potentially be new ones? */
proc univariate data=lrhw1.insurance_t;
	var acctage;
	hist;
run;

*explore acctage further where acctage is missing so that I can see if 
new accounts represent missing data so a value of 0 would make sense;
data age_check;
	set lrhw1.insurance_t;
	if acctage = '.';
run;

*check further for frequencies of these operations compared to normal data;
proc means data=age_check;
	var age crscore dep dda ddabal;
run;

*normal data check reveals that these values all seem about the same so no trend could really be 
established that would make assuming missingness is a new account;
proc means data=lrhw1.insurance_t;
	var age crscore dep dda ddabal;
	title "Normal Data's Means Across Several Variables"; 
run;

*All seems normal so finally going to use indicator variable to test if significant inside of 
proc logistic model and if it's giving any value anywhere else before just imputing with median perhaps;
data age_check_log;
	set lrhw1.insurance_t;
	if acctage = '.' then missing_acct_age = 1;
	else missing_acct_age = 0;
run;

*verify it did it correctly still;
proc freq data = age_check_log;
	tables missing_acct_age;
run;

*check if this missing data contains any dependence on target var;
proc logistic data = age_check_log;
	class missing_acct_age(ref = '0') / param=ref;
	model ins(event='1') = missing_acct_age;
	title 'Testing for Missingness being a significant indicator on Predictor Var'; 
run;

/* doesn't return it as a significant variable to the target so check for dependence with other predictors */

*check for dependence on a few random predictor variables;
proc logistic data=age_check_log;
	 class ira sav ils;
	model missing_acct_age(event='1') = crscore age ddabal ira sav ils;
run;

*doesn't show significant p vals for any of these randomly chosen variables except ira curiously so going to explore that;
proc means data = age_check_log;
	class missing_acct_age;
	var ira;
run;
*mean of .05~ for nonmissing and .08 for missing shows potential for relationship here but not super sure then
might need to run another test to see if that is significant or not;
proc logistic data=age_check_log;
	 class ira;
	model missing_acct_age(event='1') = ira;
run;

*by itself it's right on the line for significant at =.0021 so giong to reject dependence on 
other predictor variables for now too and assume rare event aspect of IRA was part of issue

*for now consider imputing with median in the future to deal with missing values and do it now to make BT work; 
proc means data=lrhw1.insurance_t median mean;
	var acctage;
run;
*median is 4 and mean is 6.03;

*impute acctage missing values with median val for acctage;
data med_imp_acctage;
	set lrhw1.insurance_t;
	if acctage  = '.' then acctage = 4;
run;

*check that it worked;
proc freq data= med_imp_acctage;
	tables acctage;
run;

/*****************/ 
/* ACCTAGE Tests */
/*****************/ 

*create acctage_log of the Box Tidwell Transformation now to check for linearity in acctage;
data med_imp_acctage;
	set med_imp_acctage;
	acctage_log = acctage*log(acctage);
run;

*run BT Transformation now for acctage and acctage_log;
proc logistic data=med_imp_acctage plots(only)=(oddsratio);
	model ins(event='1') = acctage acctage_log/ clodds=pl clparm=pl;
run;
quit;

*run BT Transformation now for acctage and find that y hat ~= 3;
proc logistic data=med_imp_acctage plots(only)=(oddsratio);
	model ins(event='1') = acctage/ clodds=pl clparm=pl;
run;
quit;

*run proc gam to check for agreement on acctage;
proc gam data=med_imp_acctage plots = components(clm commonaxes);
	model ins(event = '1') = spline(acctage, df=4) / dist=binomial link = logit;
run;
quit;

/****************/ 
/* DDABAL Tests */
/****************/ 

*run proc gam bc of zeros in ddabal so I need to test in GAM preferably but it doesnt accurately converge;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(ddabal, df=4) / dist = binomial link = logit;
run;
quit;

*Transformation on ddabal variable to account for nonconvergence in GAM model
 and create neg_dda indicator variable that the data was negative before being
 transformed to equal 1 to make BT work;
data insurance_t;
	set lrhw1.insurance_t;
	if ddabal < 0 then neg_dda = 1;
	else neg_dda = 0;
	ddabal1 = (1 + (ddabal));
	if ddabal1 < 1 then ddabal1 =1;
	ddalogdda = ddabal1*log(ddabal1);
run;

*box tidwell transformation for ddabal;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = ddabal ddalogdda/ clodds=pl clparm=pl;
	title "Modeling DDABal BT Transformation";
run;
quit;

*check original param estimates to find that y hat = 0.62 ;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = ddabal / clodds=pl clparm=pl;
	title 'Modeling DDABal by Itself';
run;
quit;


/****************/ 
/*   DEP Tests  */
/****************/ 
*run proc gam bc of zero's in dep that I need to test but does converge and say that it is not correct currently
 looks to me like it should be a square according to this plot, but I'm more thinking that this variable might need
to be binned so that it can become categorical instead of continuous;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(dep, df=4) / dist = binomial link = logit;
run;
quit;

*check dep with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	dep1 = (1 + (dep));
	deplog = dep1*log(dep1);
run;

*box tidwell transformation for dep;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = dep deplog/ clodds=pl clparm=pl;
	title 'Modeling Dep BT Transformation';
run;
quit;

*check original param estimates to find that y hat = -.24;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = dep / clodds=pl clparm=pl;
	title 'Modeling Dep by Itself';
run;
quit;

/****************/ 
/* DEPAMT Tests */
/****************/ 
*run proc gam bc of zero's in depamt that I need to test but doesn't accurately converge;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(depamt, df=4) / dist = binomial link = logit;
run;
quit;


*Transformation on depamt variable to account for nonconvergence in GAM model;
data insurance_t;
	set lrhw1.insurance_t;
	depamt1 = (1 + (depamt));
	depamtlog = depamt1*log(depamt1);
run;

*box tidwell transformation for depamt, found to be insignificant;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = depamt depamtlog/ clodds=pl clparm=pl;
	title 'Modeling depamt BT Transformation';
run;
quit;

/****************/ 
/* CHECKS Tests */
/****************/ 
*run proc gam bc of zero's in checks and find that is significant;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(checks, df=4) / dist = binomial link = logit;
run;
quit;

*check checks with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	checks1 = (1 + (checks));
	checkslog = checks1*log(checks1);
run;

*box tidwell transformation for checks;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = checks checkslog/ clodds=pl clparm=pl;
	title 'Modeling checks BT Transformation';
run;
quit;

*check original param estimates to find that y hat = -.34;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = checks / clodds=pl clparm=pl;
	title 'Modeling checks by Itself';
run;
quit;

/****************/ 
/* NSFAMT Tests */
/****************/ 
*run proc gam bc of zero's in nsfamt and find that is significant;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(nsfamt, df=4) / dist = binomial link = logit;
run;
quit;

*check nsfamt with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	nsfamt1 = (1 + (nsfamt));
	nsfamtlog = nsfamt1*log(nsfamt1);
run;

*box tidwell transformation for nsfamt;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = nsfamt nsfamtlog/ clodds=pl clparm=pl;
	title 'Modeling nsfamt BT Transformation';
run;
quit;

*check original param estimates to find that y hat = .86;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = nsfamt / clodds=pl clparm=pl;
	title 'Modeling nsfamt by Itself';
run;
quit;

/****************/ 
/* PHONE Tests */
/****************/ 
*run proc gam bc of zero's in phone and find that is significant & looks like square transformation maybe;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(phone, df=4) / dist = binomial link = logit;
run;
quit;

*check phone with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	phone1 = (1 + (phone));
	phonelog = phone1*log(phone1);
run;

*box tidwell transformation for phone;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = phone phonelog/ clodds=pl clparm=pl;
	title 'Modeling phone BT Transformation';
run;
quit;

*check original param estimates to find that y hat = -.028;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = phone / clodds=pl clparm=pl;
	title 'Modeling phone by Itself';
run;
quit;

/****************/ 
/* TELLER Tests */
/****************/ 
*run proc gam bc of zero's in teller and find that is significant barely and looks like cubed;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(teller, df=4) / dist = binomial link = logit;
run;
quit;

*check teller with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	teller1 = (1 + (teller));
	tellerlog = teller1*log(teller1);
run;

*box tidwell transformation for teller;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = teller tellerlog/ clodds=pl clparm=pl;
	title 'Modeling teller BT Transformation';
run;
quit;

*check original param estimates to find that y hat = 3.47 but not sig w a p val = .10
 most likely here we will still reject the linearity here and at least explore raising 
 teller to the cubic or squared power since GAM is using untransformed data;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = teller / clodds=pl clparm=pl;
	title 'Modeling teller by Itself';
run;
quit;

/****************/ 
/* SAVBAL Tests */
/****************/ 
*run proc gam bc of zero's in savbal and find that is not able to converge;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(savbal, df=4) / dist = binomial link = logit;
run;
quit;

*check savbal with BT after data transformation after no convergence;
data insurance_t;
	set lrhw1.insurance_t;
	savbal1 = (1 + (savbal));
	savballog = savbal1*log(savbal1);
run;

*box tidwell transformation for savbal;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = savbal savballog/ clodds=pl clparm=pl;
	title 'Modeling savbal BT Transformation';
run;
quit;

*check original param estimates to find that y hat = .123 and sig w a p val <.0001;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = savbal / clodds=pl clparm=pl;
	title 'Modeling savbal by Itself';
run;
quit;

/****************/ 
/* ATMAMT Tests */
/****************/ 
*run proc gam bc of zero's in atmamt and find that there is no convergence;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(atmamt, df=4) / dist = binomial link = logit;
run;
quit;

*check atmamt with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	atmamt1 = (1 + (atmamt));
	atmamtlog = atmamt1*log(atmamt1);
run;

*box tidwell transformation for atmamt shows that it is not signficant;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = atmamt atmamtlog/ clodds=pl clparm=pl;
	title 'Modeling atmamt BT Transformation';
run;
quit;

/*************/ 
/* POS Tests */
/*************/ 
*run proc gam bc of zero's in pos and find that is significant and looks like squared w one inflection point;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(pos, df=4) / dist = binomial link = logit;
run;
quit;

*check pos with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	pos1 = (1 + (pos));
	poslog = pos1*log(pos1);
run;

*box tidwell transformation for pos;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = pos poslog/ clodds=pl clparm=pl;
	title 'Modeling pos BT Transformation';
run;
quit;

*check original param estimates to find that y hat = -1.3 and sig w a p val <.0001;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = pos / clodds=pl clparm=pl;
	title 'Modeling pos by Itself';
run;
quit;

/****************/ 
/* POSAMT Tests */
/****************/ 
*run proc gam bc of zero's in posamt and find that is significant and looks like squared w one inflection point;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(posamt, df=4) / dist = binomial link = logit;
run;
quit;

*check posamt with BT after data transformation to see if proc eyball was right on squaring it technically;
data insurance_t;
	set lrhw1.insurance_t;
	posamt1 = (1 + (posamt));
	posamtlog = posamt1*log(posamt1);
run;

*box tidwell transformation for posamt;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = posamt posamtlog/ clodds=pl clparm=pl;
	title 'Modeling posamt BT Transformation';
run;
quit;

*check original param estimates to find that y hat = -6.75 and sig w a p val <.0001;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = posamt / clodds=pl clparm=pl;
	title 'Modeling posamt by Itself';
run;
quit;

/****************/ 
/* CDBAL Tests */
/****************/ 
*run proc gam bc of zero's in cdbal and find no convergence;
proc gam data=lrhw1.insurance_t plots = components(clm commonaxes);
	model ins(event='1') = spline(cdbal, df=4) / dist = binomial link = logit;
run;
quit;

*check cdbal with BT after data transformation since no convergence;
data insurance_t;
	set lrhw1.insurance_t;
	cdbal1 = (1 + (cdbal));
	cdballog = cdbal1*log(cdbal1);
run;

*box tidwell transformation for cdbal;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = cdbal cdballog/ clodds=pl clparm=pl;
	title 'Modeling cdbal BT Transformation';
run;
quit;

*check original param estimates to find that y hat = .58 and sig w a p val <.0001;
proc logistic data=insurance_t plots(only)=(oddsratio);
	model ins(event='1') = cdbal / clodds=pl clparm=pl;
	title 'Modeling cdbal by Itself';
run;
quit;