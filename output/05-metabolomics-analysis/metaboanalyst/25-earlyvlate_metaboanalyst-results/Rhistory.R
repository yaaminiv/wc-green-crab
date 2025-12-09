# PID of current job: 2559015
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("1,5-anhydroglucitol","2,3-dihydroxypyridine","2,5-dihydroxypyrazine","2-hydroxyglutaric acid","2-ketoisocaproic acid","3-Amino-2-piperidone","5-hydroxynorvaline","6-Oxopiperidine-2-carboxylic acid","6-deoxygalactofuranose","UDP-N-acetylglucosamine","adenine","adenosine","alpha-ketoglutarate","arachidonic acid","asparagine","aspartic acid","beta-glycerolphosphate","butyrolactam","capric acid","ciliatine","citrulline","conduritol-beta-epoxide","cyanoalanine","cytidine-5-monophosphate","cytosine","erythronic acid lactone","ethanol phosphate","fructose","fructose-1-phosphate","fructose-6-phosphate","fumaric acid","galactose-6-phosphate","gluconic acid","glucose-1-phosphate","glucose-6-phosphate","glutamic acid","glycerol","glycerol-alpha-phosphate","histidine","hypotaurine","hypoxanthine","inosine","isomaltose","lactose","levoglucosan","lysine","maleimide","maltose","melezitose","methylmaleic acid","ononitol","ornithine","palmitoleic acid","parabanic acid","phenol","phenylalanine","phenylethylamine","phosphate","pinitol","propylamine","pyrophosphate","raffinose","ribitol","saccharic acid","taurine","threonic acid","tocopherol gamma","uric acid","xanthine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "6-deoxygalactofuranose");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "beta-glycerolphosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "beta-glycerolphosphate", "beta-Glycerophosphoric acid");
mSet<-PerformDetailMatch(mSet, "conduritol-beta-epoxide");
mSet<-GetCandidateList(mSet);
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
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Arginine biosynthesis",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1765307335303.png",576.0, 480.0, 100.0)
mSet<-PlotKEGGPath(mSet, "Starch and sucrose metabolism",576, 480, "png", NULL)
mSet<-PlotKEGGPath(mSet, "Alanine, aspartate and glutamate metabolism",576, 480, "png", NULL)
mSet<-SaveTransformedData(mSet)
