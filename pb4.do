
cd "D:\Amanda's Files\UC Merced\Spring 2020\Soc211\week9"
use "gss93dd.dta"


**1


tw(scatter prestg80 age)(lfitci prestg80 age),
ytitle(Occupational Prestige Score) 
title("How does variance in Occupational Prestige increase with Age?")

graph twoway (scatter incwelfr `x') (lfit incwelfr `x', color(red)), name(`x', replace) legend(off) ytitle(income) scheme(plotplainblind)

**2

regress prestg80 age
estat hettest

gen prestg80_log=log(prestg80)
regress prestg80_log age
estat hettest

**3-- I installed stripplot but am still not able to get this to work in Stata--I've played with the code but it returns variable random already defined. I'll follow up and see what I need to do to fix this in Stata and then come back to it.

ssc install stripplot

clear

cd "D:\Amanda's Files\UC Merced\Spring 2020\Soc211\week9"
use "gss93dd.dta"


quietly keep if prestg80!=.
quietly gen prestmeans=.
quietly gen n=_n
forvalues i=1/10 {
quietly gen random=runiform()
quietly sort random
quietly stripplot prestg80 _n<=50, scheme(538w) refline ///
ysize(1) xsize(10) scale(5) xtitle("") xlabel(0(5000)17000, labsize(vlarge))
graph display, margins(zero)
quietly sum prestg80 if _n<=50
quietly replace prestmeans=r(mean) if n==`i'
drop random
}

quietly {
forvalues i=11/200 {
quietly gen random=runiform()
quietly sort random
quietly sum prestg80 if _n<=50
quietly replace prestmeans=r(mean) if n==`i'
quietly drop random
}
quietly histogram prestmeans
}
graph display

**4

quietly reg prestg80 age
quietly eststo

quietly 
reg prestg80 age, robust
quietly eststo

*clearing old estimates*
eststo clear

*Base model
eststo m1: reg prestg80 age

**>Estimating model 2<**
eststo m2: reg prestg80 age, robust

esttab using "D:\Amanda's Files\UC Merced\Spring 2020\Soc211\Week9\pb4.6.rtf", replace label b(%8.3f) se(%8.3f) ///
    nogap nodepvars compress nonumbers r2 ar2 obslast bic ///
	mtitles("Base Model" "Model 2") /// 
    title ("Table 1: Multiple Regression Model")


putdocx clear
putdocx begin
estimates clear
putdocx paragraph, font("Times New Roman",12, black) halign(left)
putdocx text ("Table 1: Example tables")

estimates table M1 M2, b(%9.3f) star stats(N r2_a bic) vsquish varlabel ///
nolstretch style(noline) 
putdocx table tbl1 = etable

putdocx table tbl1(.,1), halign(left) font("Times New Roman")
putdocx table tbl1(.,2 3 4), halign(center) font("Times New Roman")

putdocx pagebreak



**5

qui reg prestg80 age, cluster()
quietly eststo

*clearing old estimates*
eststo clear

*Base model
eststo m1: reg prestg80 age

**>Estimating model 2<**
eststo m2: reg prestg80 age, robust

**>Estimating model 3<**
eststo m3: reg prestg80 age, cluster(educ)


esttab using "D:\Amanda's Files\UC Merced\Spring 2020\Soc211\Week9\pb4.5.2.rtf", replace label b(%8.3f) se(%8.3f) ///
    nogap nodepvars compress nonumbers r2 ar2 obslast bic ///
	mtitles("Base Model" "Model 2" "Model3") /// 
    title ("Table 1: Multiple Regression Model")


putdocx clear
putdocx begin
estimates clear
putdocx paragraph, font("Times New Roman",12, black) halign(left)
putdocx text ("Table 1: Example tables")

estimates table M1 M2 M3, b(%9.3f) star stats(N r2_a bic) vsquish varlabel ///
nolstretch style(noline) 
putdocx table tbl1 = etable

putdocx table tbl1(.,1), halign(left) font("Times New Roman")
putdocx table tbl1(.,2 3 4), halign(center) font("Times New Roman")

putdocx pagebreak




