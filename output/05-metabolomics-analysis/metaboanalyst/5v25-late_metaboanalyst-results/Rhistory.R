# PID of current job: 2507351
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("1,5-anhydroglucitol","1-monopalmitin","2,3-dihydroxypyridine","2,5-dihydroxypyrazine","2-hydroxyglutaric acid","2-ketoisocaproic acid","2-picolinic acid","3-Amino-2-piperidone","4-hydroxymandelic acid","5-hydroxynorvaline","6-deoxygalactofuranose","N-methyl-UMP","UDP-N-acetylglucosamine","alanine","aminomalonic acid","butyrolactam","cadaverine","ciliatine","citrulline","conduritol-beta-epoxide","creatinine","cytidine-5-monophosphate","dehydroascorbic acid","diphenoxyethane","erythronic acid lactone","ethanolamine","gluconic acid lactone","glucose","glucose-1-phosphate","glutathione","glycerol-alpha-phosphate","glycine","homoserine","inosine","inositol-4-monophosphate","ketoisoleucine","lactic acid","lactose","levoglucosan","maltose","maltotriose","melezitose","methionine","methionine sulfone","methionine sulfoxide","n-epsilon-trimethyllysine","ononitol","ornithine","oxoproline","panose","pentitol","phenol","phosphogluconic acid","pinitol","proline","pyrophosphate","sorbitol","trehalose-6-phosphate","uridine","xanthine")
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
mSet<-PerformDetailMatch(mSet, "6-deoxygalactofuranose");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "N-methyl-UMP");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "conduritol-beta-epoxide");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "cytidine-5-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "cytidine-5-monophosphate", "Cytidine monophosphate");
mSet<-PerformDetailMatch(mSet, "diphenoxyethane");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "erythronic acid lactone");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "glycerol-alpha-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "glycerol-alpha-phosphate", "Glycerophosphoric acid");
mSet<-PerformDetailMatch(mSet, "inositol-4-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "inositol-4-monophosphate", "D-myo-Inositol 4-phosphate");
mSet<-PerformDetailMatch(mSet, "ketoisoleucine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "n-epsilon-trimethyllysine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "phosphogluconic acid");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "phosphogluconic acid", "6-Phosphogluconic acid");
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Starch and sucrose metabolism",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1765307121050.png",576.0, 480.0, 100.0)
mSet<-PlotKEGGPath(mSet, "Glutathione metabolism",576, 480, "png", NULL)
mSet<-SaveTransformedData(mSet)
