# PID of current job: 1019123
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("1,5-anhydroglucitol","1-monopalmitin","1-monostearin","2-hydroxyglutaric acid","2-picolinic acid","aminomalonic acid","cadaverine","campesterol","citric acid","conduritol-beta-epoxide","gluconic acid lactone","glucose","glutathione","glycerol-3-galactoside","glycine","hexadecylglycerol","inosine","inositol-4-monophosphate","lactose","levoglucosan","ononitol","phenol","phosphogluconic acid","pinitol","sarcosine","sorbitol","trans-4-hydroxyproline","trehalose-6-phosphate","uridine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "conduritol-beta-epoxide");
mSet<-GetCandidateList(mSet);
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
