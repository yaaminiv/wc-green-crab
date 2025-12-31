# PID of current job: 1013141
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("1,5-anhydroglucitol","2,3-dihydroxypyridine","2,4-diaminobutyric acid","2,5-dihydroxypyrazine","2-hydroxyglutaric acid","alanine","aminomalonic acid","behenic acid","beta-sitosterol","butyrolactam","cadaverine","cholesterol","ciliatine","conduritol-beta-epoxide","dehydroascorbic acid","diphenoxyethane","glucose","glutathione","glycerol-alpha-phosphate","glycine","heptadecanoic acid","homoserine","inosine","lactic acid","levoglucosan","n-epsilon-trimethyllysine","nicotinamide","nonadecanoic acid","octadecanol","ononitol","phenol","pinitol","sorbitol","uridine","xanthine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
