# PID of current job: 1023562
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("1-monostearin","glutamine","3-phosphoglycerate","bisphosphoglycerol","ornithine","3-aminoisobutyric acid","lactose","methionine sulfone","N-acetylmannosamine","3-Amino-2-piperidone","alpha-ketoglutarate","cysteine","cystine","nicotinic acid","glycerol","tocopherol gamma","threonine","putrescine","methionine","galactinol","agmatine","citrulline","cyanoalanine","UDP-N-acetylglucosamine","octadecanol","lactic acid","methionine sulfoxide")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "bisphosphoglycerol");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "tocopherol gamma");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Arginine biosynthesis",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1764803759432.png",576.0, 480.0, 100.0)
mSet<-SaveTransformedData(mSet)
