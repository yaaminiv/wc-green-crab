# PID of current job: 1005740
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("1,5-anhydroglucitol","2,3-dihydroxypyridine","2,5-dihydroxypyrazine","2-hydroxyglutaric acid","4-hydroxymandelic acid","alanine","campesterol","conduritol-beta-epoxide","cysteine","gluconic acid lactone","glutathione","glycine","homoserine","ketoisoleucine","lactic acid","lactose","maltose","maltotriose","melezitose","n-epsilon-trimethyllysine","ononitol","oxoproline","panose","phenol","pinitol","sucrose")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "2,3-dihydroxypyridine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "2,5-dihydroxypyrazine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "4-hydroxymandelic acid");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "4-hydroxymandelic acid", "p-Hydroxymandelic acid");
mSet<-PerformDetailMatch(mSet, "conduritol-beta-epoxide");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "ketoisoleucine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "n-epsilon-trimethyllysine");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
