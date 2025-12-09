# PID of current job: 2121611
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("glycerol-alpha-phosphate","urea","proline","ethanolamine","aminomalonic acid","5-hydroxynorvaline","6-Oxopiperidine-2-carboxylic acid","tocopherol alpha","succinic acid","methanolphosphate","3-phosphoglycerate","phosphoglycolic acid","glycine","trehalose-6-phosphate","capric acid","maleimide","methylmaleic acid","oxamic acid","methionine sulfoxide","raffinose","terephthalic acid","arachidonic acid","ethanol phosphate","1,5-anhydroglucitol","dehydroascorbic acid","lactose","glycolic acid","citric acid","phenol")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "glycerol-alpha-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "glycerol-alpha-phosphate", "Glycerophosphoric acid");
mSet<-PerformDetailMatch(mSet, "tocopherol alpha");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "methanolphosphate");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "oxamic acid");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "ethanol phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-SaveTransformedData(mSet)
