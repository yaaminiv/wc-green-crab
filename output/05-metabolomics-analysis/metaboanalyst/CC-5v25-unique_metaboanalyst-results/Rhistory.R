# PID of current job: 986867
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("4-hydroxymandelic acid","cysteine","ketoisoleucine","maltose","maltotriose","melezitose","oxoproline","panose","sucrose")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "4-hydroxymandelic acid");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "4-hydroxymandelic acid", "p-Hydroxymandelic acid");
mSet<-PerformDetailMatch(mSet, "ketoisoleucine");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
