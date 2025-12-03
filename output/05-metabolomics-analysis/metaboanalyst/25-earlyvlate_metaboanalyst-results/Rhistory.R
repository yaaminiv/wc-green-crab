# PID of current job: 674759
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("UDP-N-acetylglucosamine","cyanoalanine","cytidine-5-monophosphate","cytosine","erythronic acid lactone","ethanol phosphate","fructose","fructose-1-phosphate","fructose-6-phosphate","fumaric acid","galactose-6-phosphate","gluconic acid","glucose-1-phosphate","glucose-6-phosphate","glutamic acid","glycerol","glycerol-alpha-phosphate","histidine","hypotaurine","hypoxanthine","inosine","isomaltose","lactose","levoglucosan","lysine","maleimide","maltose","melezitose","ononitol","ornithine","palmitoleic acid","parabanic acid","phenol","phenylalanine","phenylethylamine","phosphate","pinitol","propylamine","pyrophosphate","raffinose","ribitol","saccharic acid","taurine","threonic acid","tocopherol gamma","uric acid","xanthine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "cytidine-5-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "cytidine-5-monophosphate", "Cytidine monophosphate");
mSet<-PerformDetailMatch(mSet, "erythronic acid lactone");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "erythronic acid lactone", "Erythrono-1,4-lactone");
mSet<-PerformDetailMatch(mSet, "ethanol phosphate");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "galactose-6-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "galactose-6-phosphate", "D-Galactose 6-phosphate");
mSet<-PerformDetailMatch(mSet, "glycerol-alpha-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "glycerol-alpha-phosphate", "Glycerophosphoric acid");
mSet<-PerformDetailMatch(mSet, "parabanic acid");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "tocopherol gamma");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Starch and sucrose metabolism",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1764800071349.png",576.0, 480.0, 100.0)
mSet<-SaveTransformedData(mSet)
