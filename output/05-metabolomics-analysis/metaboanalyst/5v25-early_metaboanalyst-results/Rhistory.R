# PID of current job: 4003658
mSet<-InitDataObjects("conc", "pathora", FALSE, 150)
cmpd.vec<-c("(5E)-isovitamin D3","1-monopalmitin","1-monostearin","2,3-dihydroxypyridine","2,4-diaminobutyric acid","2,5-dihydroxypyrazine","2-hydroxyglutaric acid","N-acetylmannosamine","UDP-N-acetylglucosamine","adenine","agmatine","alanine","arachidonic acid","behenic acid","beta-alanine","butyrolactam","capric acid","cholesterol","citrulline","cytidine-5-monophosphate","cytosine","diphenoxyethane","erythritol","fumaric acid","galactinol","gluconic acid lactone","glutathione","glycerol","glycerol-3-galactoside","glycerol-alpha-phosphate","glycolic acid","heptadecanoic acid","hexadecylglycerol","homoserine","hypoxanthine","inosine","lactic acid","lactose","lauric acid","maleimide","maltose","maltotriose","melezitose","methanolphosphate","methylmaleic acid","n-epsilon-trimethyllysine","nicotinamide","octadecanol","oleic acid","ononitol","ornithine","oxoproline","panose","parabanic acid","phenol","phenylethylamine","phosphate","phosphogluconic acid","phosphoglycolic acid","propylamine","raffinose","ribitol","sorbitol","succinic acid","taurine","tocopherol alpha","tocopherol gamma","urea","uridine")
mSet<-Setup.MapData(mSet, cmpd.vec);
mSet<-CrossReferencing(mSet, "name");
mSet<-CreateMappingResultTable(mSet)
mSet<-PerformDetailMatch(mSet, "(5E)-isovitamin D3");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "2,3-dihydroxypyridine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "2,5-dihydroxypyrazine");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "2,5-dihydroxypyrazine", "2,5-Dihydroxypyridine");
mSet<-PerformDetailMatch(mSet, "cytidine-5-monophosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "cytidine-5-monophosphate", "Cytidine monophosphate");
mSet<-PerformDetailMatch(mSet, "diphenoxyethane");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "glycerol-3-galactoside");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "glycerol-alpha-phosphate");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "glycerol-alpha-phosphate", "Glycerophosphoric acid");
mSet<-PerformDetailMatch(mSet, "hexadecylglycerol");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "methanolphosphate");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "n-epsilon-trimethyllysine");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "parabanic acid");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "phosphogluconic acid");
mSet<-GetCandidateList(mSet);
mSet<-SetCandidate(mSet, "phosphogluconic acid", "6-Phosphogluconic acid");
mSet<-PerformDetailMatch(mSet, "tocopherol alpha");
mSet<-GetCandidateList(mSet);
mSet<-PerformDetailMatch(mSet, "tocopherol gamma");
mSet<-GetCandidateList(mSet);
mSet<-SetKEGG.PathLib(mSet, "dme", "current")
mSet<-SetMetabolomeFilter(mSet, F);
mSet<-CalculateOraScore(mSet, "rbc", "hyperg")
mSet<-PlotPathSummary(mSet, F, "path_view_0_", "png", 150, width=NA, NA, NA )
mSet<-PlotKEGGPath(mSet, "Arginine biosynthesis",576, 480, "png", NULL)
mSet<-RerenderMetPAGraph(mSet, "zoom1764793881717.png",576.0, 480.0, 100.0)
mSet<-PlotKEGGPath(mSet, "Glutathione metabolism",576, 480, "png", NULL)
mSet<-PlotKEGGPath(mSet, "Arginine biosynthesis",576, 480, "png", NULL)
mSet<-SaveTransformedData(mSet)
