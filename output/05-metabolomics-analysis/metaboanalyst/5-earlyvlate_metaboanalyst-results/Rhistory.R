# PID of current job: 2402160
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("2,5-dihydroxypyrazine","2-hydroxyglutaric acid","3-phosphoglycerate","6-deoxygalactofuranose","UDP-N-acetylglucosamine","adenine","adenosine","adenosine-5-monophosphate","alpha-ketoglutarate","aminomalonic acid","ciliatine","citrulline","cysteine","cytidine-5-monophosphate","cytosine","dehydroascorbic acid","ethanolamine","fructose","fructose-1-phosphate","fructose-6-phosphate","galactose-6-phosphate","glucose-1-phosphate","glucose-6-phosphate","glutathione","glycerol","glycine","histidine","hypotaurine","ketoisoleucine","lactose","levoglucosan","lysine","methanolphosphate","nicotinamide","ornithine","phosphate","pyrophosphate","saccharic acid","taurine","terephthalic acid","trehalose-6-phosphate","uric acid")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "2,5-dihydroxypyrazine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "6-deoxygalactofuranose");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "adenosine-5-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "adenosine-5-monophosphate", "Adenosine monophosphate");
mSet<-PerformDetailMatch(mSet, "cytidine-5-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "cytidine-5-monophosphate", "Cytidine monophosphate");
mSet<-PerformDetailMatch(mSet, "galactose-6-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "galactose-6-phosphate", "D-Galactose 6-phosphate");
mSet<-PerformDetailMatch(mSet, "ketoisoleucine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "methanolphosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Starch and sucrose metabolism",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1765306386132.png",576.0, 480.0, 100.0)
mSet<-PlotKEGGPath(mSet, "Taurine and hypotaurine metabolism",576, 480, "png", NULL)
mSet<-SaveTransformedData(mSet)
