# PID of current job: 834071
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("glycerol-alpha-phosphate","urea","ethanolamine","proline","5-hydroxynorvaline","phosphoglycolic acid","aminomalonic acid","methanolphosphate","6-Oxopiperidine-2-carboxylic acid","glycine","maleimide","succinic acid","3-phosphoglycerate","methionine sulfoxide","tocopherol alpha","trehalose-6-phosphate","raffinose","oxamic acid","arachidonic acid","lactose","capric acid","phenol","dehydroascorbic acid","1,5-anhydroglucitol","glycolic acid","glucose","terephthalic acid","galactinol","phenylethylamine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "glycerol-alpha-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "glycerol-alpha-phosphate", "Glycerophosphoric acid");
mSet<-PerformDetailMatch(mSet, "methanolphosphate");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "tocopherol alpha");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "oxamic acid");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-SaveTransformedData(mSet)
