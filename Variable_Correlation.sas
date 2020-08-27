/*
Name: Jacob Hyman
Date: 08/26/2020
Objective: investigation of redundancy in catagorical vs catatgorical
and catagorical vs continuous variables that registered high VIF's*/

/*****************/
/*MM (binary) and MMCRED (ordinal)*/ 

proc freq data=dt.insurance_t;
	tables MM MMCRED / plots=freqplot;
run;

/*basically shows what we are trying to explain: that MM and MMCRED are almost interchangable*/
proc freq data=dt.insurance_t;
	table MM*MMCRED / plots=freqplot (twoway=stacked scale=percent);
run;

/*residuals show why VIF is maybe not the best to use*/
proc reg data=dt.insurance_t;
	model MM = MMCRED;
	output out=check residual=r predicted=p;
run;

/*spearmans correlation coefficient shows that MM and MMCRED are highly correlated (likley to have linear relationship)*/
proc corr data=dt.insurance_t spearman nosimple;
	var MM MMCRED;
run;


/*provides Caramers V*/
proc freq data = dt.insurance_t;
  tables MM*MMCRED / chisq;
run;

/*****************/
/*MM and MMBAL*/ 

proc glm data=dt.insurance_t
plots(only) = (diffplot(center)controlplot);
	class MM;
	model MMCRED = MM;
	lsmeans MM / pdiff=all adjust=tukey;
	lsmeans MM / pdiff=Control('Average/Typical') adjust=dunnett;
run;

