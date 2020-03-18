
cd "D:\Amanda's Files\UC Merced\Spring 2020\Soc211\week8"
use "gss93dd.dta"


tab wrkslf, nol
drop if wrkslf==9
*Method number 1 
gen selfemploy = wrkslf==1
gen selfemployno = wrkslf==2

gen female = sex==2
gen selfemployxfemale = selfemploy * female
gen selfemploynoxfemale = selfemployno * female
gen age2=age^2

*Method number 2
xi i.wrkslf*i.sex, noomit

list wrkslf sex selfemploy _Isex_1 selfemployno _Isex_2 selfemployxfemale _IworXsex_1_2 
selfemploynoxfemale _IworXsex_2_2 if _n<13

est clear
eststo: reg rincom91 i.wrkslf i.sex age age2
eststo: reg rincom91 i.wrkslf##i.sex  age age2

esttab, stats(r2 N, labels("R2" "N") fmt(%10.2fc %10.0fc)) cells(b(star fmt(%10.0fc)) se(fmt(%6.0fc) par) N (fmt(%10.0fc)) r2 (fmt(%10.2f))) ///
  nobase noconstant starlevels(* .1 ** .05 *** .01) mlabels("Model 1" "Model 2")  
  

quietly eststo: reg rincome i.wrkslf##i.sex  age age2
quietly margins i.wrkslf, over(sex) atmeans
marginsplot

quietly eststo: reg rincome i.wrkslf##i.sex  age age2
quietly margins i.sex, over(wrkslf) atmeans
marginsplot