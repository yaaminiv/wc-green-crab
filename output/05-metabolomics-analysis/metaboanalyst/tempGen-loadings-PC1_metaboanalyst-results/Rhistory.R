# PID of current job: 896722
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("2-hydroxyglutaric acid","conduritol-beta-epoxide","ononitol","ciliatine","glycine","levoglucosan","pinitol","6-deoxygalactofuranose","1,5-anhydroglucitol","aminomalonic acid","alanine","glycerol-alpha-phosphate","cadaverine","dehydroascorbic acid","glutathione","homoserine","glucose","oxoproline","2,5-dihydroxypyrazine","sorbitol","N-acetylmannosamine","6-Oxopiperidine-2-carboxylic acid","phosphogluconic acid","proline")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "conduritol-beta-epoxide");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "6-deoxygalactofuranose");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "glycerol-alpha-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "glycerol-alpha-phosphate", "Glycerophosphoric acid");
mSet<-PerformDetailMatch(mSet, "2,5-dihydroxypyrazine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "phosphogluconic acid");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "phosphogluconic acid", "6-Phosphogluconic acid");
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Glutathione metabolism",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1764801658708.png",576.0, 480.0, 100.0)
mSet<-SaveTransformedData(mSet)
