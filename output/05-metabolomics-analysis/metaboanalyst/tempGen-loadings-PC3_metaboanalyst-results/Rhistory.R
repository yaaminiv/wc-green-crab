# PID of current job: 1062409
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("2,3-dihydroxypyridine","malic acid","phenol","propylamine","methionine sulfoxide","parabanic acid","lactic acid","homocysteine","hypotaurine","beta-gentiobiose","uric acid","nicotinic acid","diphenoxyethane","2,4-diaminobutyric acid","gluconic acid lactone","panose","maltotriose","uracil","1-monopalmitin","ethanol phosphate","trehalose-6-phosphate","homoserine","hexadecylglycerol","cyanoalanine","nicotinamide","indole-3-butyric acid","pipecolinic acid","terephthalic acid","aminomalonic acid","sarcosine","dopamine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "2,3-dihydroxypyridine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "parabanic acid");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "beta-gentiobiose");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "diphenoxyethane");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "ethanol phosphate");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "hexadecylglycerol");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-SaveTransformedData(mSet)
