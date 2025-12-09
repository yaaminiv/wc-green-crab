# PID of current job: 2100264
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("ononitol","conduritol-beta-epoxide","pinitol","ciliatine","6-deoxygalactofuranose","lactose","2-hydroxyglutaric acid","cadaverine","1,5-anhydroglucitol","sorbitol","homoserine","alanine","glycine","glucose-6-phosphate","fructose-6-phosphate","campesterol","n-epsilon-trimethyllysine","uridine","gluconic acid lactone","glucosamine","N-acetylmannosamine","citrulline","creatinine","behenic acid")
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
