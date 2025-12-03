# PID of current job: 783586
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("pyrophosphate","adenine","glucose-1-phosphate","UDP-N-acetylglucosamine","cytidine-5-monophosphate","fructose-6-phosphate","glucose-6-phosphate","2,5-dihydroxypyrazine","adenosine","levoglucosan","glycerol","cytosine","fructose","2-hydroxyglutaric acid","alpha-ketoglutarate","saccharic acid","citric acid","fructose-1-phosphate","galactose-6-phosphate","ethanolamine","phenylalanine","2,4-diaminobutyric acid","glutathione","nicotinamide","isomaltose","butyrolactam")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "cytidine-5-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "cytidine-5-monophosphate", "Cytidine monophosphate");
mSet<-PerformDetailMatch(mSet, "2,5-dihydroxypyrazine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "galactose-6-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "galactose-6-phosphate", "D-Galactose 6-phosphate");
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Starch and sucrose metabolism",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1764800823024.png",576.0, 480.0, 100.0)
mSet<-SaveTransformedData(mSet)
