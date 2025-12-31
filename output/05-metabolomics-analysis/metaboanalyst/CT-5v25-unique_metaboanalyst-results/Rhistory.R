# PID of current job: 994382
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("2,4-diaminobutyric acid","behenic acid","beta-sitosterol","butyrolactam","cholesterol","ciliatine","dehydroascorbic acid","diphenoxyethane","glycerol-alpha-phosphate","heptadecanoic acid","nicotinamide","nonadecanoic acid","octadecanol","xanthine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "diphenoxyethane");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "glycerol-alpha-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "glycerol-alpha-phosphate", "Glycerophosphoric acid");
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
