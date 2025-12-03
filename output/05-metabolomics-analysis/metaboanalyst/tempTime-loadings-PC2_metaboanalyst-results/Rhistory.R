# PID of current job: 811503
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("ononitol","conduritol-beta-epoxide","ciliatine","pinitol","6-deoxygalactofuranose","lactose","2-hydroxyglutaric acid","1,5-anhydroglucitol","sorbitol","cadaverine","homoserine","alanine","glycine","glucose-6-phosphate","fructose-6-phosphate","n-epsilon-trimethyllysine","campesterol","uridine","glucosamine","gluconic acid lactone","citrulline","N-acetylmannosamine","creatinine","ornithine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "conduritol-beta-epoxide");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "6-deoxygalactofuranose");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "n-epsilon-trimethyllysine");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-SaveTransformedData(mSet)
