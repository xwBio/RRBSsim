RRBSsim
RRBSsim: reduced representation bisulfite sequencing simulator for next-generation sequencing

1 Introduction
==============
RRBSsim can produce paired-end RRBS reads, with significant attributes of real data, such as 
RRBS library construction, distribution of CpGs methylation level, sequencing error(substitution,
insertion, deletion), quality score. Including four steps below:

(i) Simulation of reference genome with sequencing variation: it can be achived by software, 
pIRS(ftp://ftp.genomics.org.cn/pub/pIRS/.).

(ii) Simulation of reference genome with methylated CpGs:we generate methylation values of CpG 
in the genome using a Beta model. Methylation levels of CpGs within a read are generated to 
account for the strong dependence of methylation among CpG sites within a genomic region in real data.

(iii) Generate simulated RRBS reads: the above modified reference genome is digested by a restriction 
enzyme (e.g., MspI) in silico and the position of generated fragments is marked.

(iiii) Sequencing error profile: we produce an empirical error profile from enough large training datasets
that it can be used to generate simulated Illumina reads.

