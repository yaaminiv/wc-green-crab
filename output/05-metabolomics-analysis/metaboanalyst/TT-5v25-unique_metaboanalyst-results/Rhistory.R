# PID of current job: 1003242
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("1-monopalmitin","1-monostearin","2-picolinic acid","citric acid","glycerol-3-galactoside","hexadecylglycerol","inositol-4-monophosphate","phosphogluconic acid","sarcosine","trans-4-hydroxyproline","trehalose-6-phosphate")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "glycerol-3-galactoside");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "hexadecylglycerol");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "inositol-4-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "inositol-4-monophosphate", "D-myo-Inositol 4-phosphate");
mSet<-PerformDetailMatch(mSet, "phosphogluconic acid");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "phosphogluconic acid", "6-Phosphogluconic acid");
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
