RRBSsim
===
RRBSsim: reduced representation bisulfite sequencing simulator for next-generation sequencing
====

1.Introduction
==============

RRBSsim can produce paired-end RRBS reads, with significant attributes of real data, such as<br> 
RRBS library construction, distribution of CpGs methylation level, sequencing error(substitution,<br>
insertion, deletion), quality score. Including four steps below:<br>
(i) Simulation of reference genome with sequencing variation: it can be achived by software,<br> 
pIRS(ftp://ftp.genomics.org.cn/pub/pIRS/.).<br>
(ii) Simulation of reference genome with methylated CpGs:we generate methylation values of CpG<br> 
in the genome using a Beta model. Methylation levels of CpGs within a read are generated to account<br>
for the strong dependence of methylation among CpG sites within a genomic region in real data.<br>
(iii) Generate simulated RRBS reads: the above modified reference genome is digested by a restriction<br> 
enzyme (e.g., MspI) in silico and the position of generated fragments is marked.<br>
(iiii) Sequencing error profile: we produce an empirical error profile from enough large training datasets<br>
that it can be used to generate simulated Illumina reads.<br>

2.System requirements
============

* Linux/Unix or Mac OS platform

* pIRS from: ftp://ftp.genomics.org.cn/pub/pIRS/<br>
   	1. Dependencies<br>
   	===========<br>
   	  pIRS requires the following libraries(with *-devel packages) to compile:<br>
            zlib (http://www.zlib.net/)<br>
            Boost Libraries (http://www.boost.org/)<br>
   
          pIRS requires the following tools to generate and analyse profiles:<br>
     	    Perl 5 (http://www.perl.org/)<br>
            Gzip (http://www.gnu.org/software/gzip/)<br>
            Gnuplot 4.4 (http://www.gnuplot.info/)<br>
            GNU Core Utilities (http://www.gnu.org/software/coreutils/)<br>
            SAM Tools (http://samtools.sourceforge.net/)<br>
 	 2. Building<br>
         ===========<br>
           The GNU Compiler Collection version 4.1 and above are needed. (http://gcc.gnu.org/)<br>
   	
              make<br>
           All tools will be linked to top path after make.<br>
           You are free to use the following command to install them to /TARGET/PATH/ :<br>
   
              PREFIX=/TARGET/PATH/ make instal<br>

* [Python](http://www.python.org/download/) (Version 2.7 +)<br>

  Type " python -V" to see the installed version.<br>
  
* [pyfasta](http://pypi.python.org/pypi/pyfasta/) package (Version 0.5.2)<br>
                                                                   
        tar -zxvf pyfasta-0.5.2.tar.gz
        cd pyfasta-0.5.2
        python setup.py install
  
     To test pyfasta, type below commond in the console :<br>
        
	 	$python
          	>>>import pyfasta
        	>>>quit()

3.Usage :
=======

		$python RRBSsim.py -h
		Usage: RRBSsim.py [options]
	
		General:			
		-h/--help		Output help information.
		-v/--version		Output version information.
		--seed <int>        	Simulated seed. Default is function of system time and varing among different simulations.
		-f/--fasta	        Input single reference sequence in the fasta format(usually having extension .fa).
					Specifying either -f or --genome_folder is mandatory.
		--genome_folder </../../> Input the path to the genome folder including multiple reference sequences
					in the fasta format (usually having extension .fa). It may be an absolute or relative
					path. Specifying either -f or --genome_folder is mandatory.
		-d <int>	        Expectation of sequencing depth (>0),exponential distribution are supposed here. Default: 30.
		-l/--length <int>   	Read length (>0), read1 and read2 are the same length. Default: 100 bp.                         
		-s/--single_end	Simulated single-end read pattern.
		-p/--paired_end	Simulated paired-end read pattern (default).
		--non_directional   	Directional: reads1 is the same direction with reference sequencing (Watson strand) and read
					is from Crick strand.
					Non-directional: reads1 and reads2 can be of all four bisulfite strands.
					Default: directional.
		--adapter1          	The ligated adapter sequence of the  first end of RRBS fragments. Default: Illumina universal
                        		adapter 'ACACTCTTTCCCTACACGACGCTCTTCCGATCT'.
		--adapter2          	The ligated adapter sequence of the  second end of RRBS fragments. Default: Illumina universal
                        	a	dapter 'GATCGGAAGAGCACACGTCTGAACTCCAGTCAC'.
		--non_meth_adapter  	The cytosines of adapters is unmethylated. Default is methylated.
		--non_meth_end_repair_bases The cytosines of end-repair bases is unmethylated. Default is methylated.
		--min <int>	        The minimum size-selected fragment length of RRBS library (library size) (>0). Default: 40 bp.
		--max <int>         	The maximum size-selected fragment length of RRBS library (library size) (>0). Default: 220 bp.
		--cut_site          	The cutting site of restricted enzyme is separated by '-'. For example, cutting site of MspI
					'C-CGG';here,at most two cutting sites are supported and they must separated by comma (,);
					Default is 'C-CGG'.
		-o/--output	        Prefix of output file. Default is set by name of input file.
		--nPosInfo	    	Output position information into the output file. Default is True.
		--SAM	            	Output alignment results in SAM format. Default is not.
		-R/--ref_methInfo	Output the reference methylation information. Default is not.
		
		
		DNA methylation:
		note: All the default values below are estimated from real RRBS data of lung cancer.
		--CG_level  <float>	CG methylation level (0~1). Default: 0.44.
		--CHG_level <float>	CHG methylation level (0~1). Default: 0.03.
		--CHH_level <float>	CHH methylation level (0~1). Default: 0.03.
		
		--CG_rate  <float>	mCG/CG rate (0~1). Default: 0.67.
		--CHG_rate <float>	mCHG/CHG rate (0~1). Default: 0.375.
		--CHH_rate <float>	mCHH/CHH rate (0~1). Default: 0.375.
		
		--mCG_level <float>	mCG methylation level (0~1). Default: 0.65.
		--mCHG_level <float>	mCHG methylation level (0~1). Default: 0.08.
		--mCHH_level <float>	mCHH methylation level (0~1). Default: 0.08.
		--mCGS  <float>		Standard deviation of mCG_level (0~(1-mCG_level)*mCG_level).
					Default: (1-mCG_level)*mCG_level/2.0.
		--mCHGS <float>		Standard deviation of mCHG_level (0~(1-mCHG_level)*mCHG_level).
					Default: (1-mCHG_level)*mCHG_level/2.0.
		--mCHHS <float>		Standard deviation of mCHH_level(0~(1-mCHH_level)*mCHH_level).
					Default: (1-mCHH_level)*mCHH_level/2.0.
		--cr  <float>	    	Cytosines conversion rate [0~1]. Default: 0.998.
		
		
		SNP:
		-S	                File with SNP information, specifying location and frequency of SNPs.format is:
                        		Chromosome position	strand	frequency_of_A frequency_of_T frequency_of_C frequency_of_G
                        		chr10	1	+	0	0.4	0	0.6
                        		chr10	2	+	0.3	0.2	0.1	0.4
		--non_SNP	        Do not add SNP. Default is add (based on prior probability).
		--homo_freq <float>	The frequency of homozygous SNPs [0~(1-Z)]. Default: 0.0005.
		--heter_freq <float>	The frequency of heterozygous SNPs [0~(1-Y)]. Default: 0.001.
		
		
		Reads quality profiles:
		-q/--quality <float>	Quality score (mean value of quality score). Default: 0.95 (95% of highest score).
		--qs <float>	    	Standard deviation of -q (0~(1-q)*q). Default: (1-q)*q/2.
		--rand_quals	    	Randomly introduce quality value. Default: uniform quality score.
		--rand_error	    	Randomly introduce sequencing errors by sequencing quality value(Q =-10*log10(e), Q is the 
					sequencing quality value (Phred score),e is the error rate ). Default is not.
		
		--input_quals       	Introduce quality value empirically obtained from real data. Default: on.
		--matrix_qual_R1    	Input the file including the probability matrix of  quality value counts at each position for reads1.
		--matrix_qual_R2    	Input the file including the probability matrix of  quality value counts at each position for reads2.
		--phred33_quals     	FastQ qualities are ASCII transformation of that Phred quality plus 33. Default: on.
		--phred64_quals     	FastQ qualities are ASCII transformation of that Phred quality plus 64. Default: off.
                        		

4.Example :
=======

 (1) Base quality profiles Generator
						
		python base_quality_profile_R1.py -i rrbs.R1.fastq
		python base_quality_profile_R2.py -i rrbs.R2.fastq

	Output file:

		base_quality_profile.R1 , base_quality_profile.R2
	file format:

		position        !       "       #       $       %       &       '       (       )
		0       0       0       34344   0       0       0       0       0       0
		1       0       0       819     0       0       0       0       0       0
		2       0       0       1148    0       0       0       4       0       47060
		3       0       0       1407    0       0       416     889     0       29268
	
	Format descriptions:
	
		(1) position of base
		(2)- number of base related to each ASCII shift of quality value 
	
(2) Generate the diploid genome sequence with variation

		pirs diploid -i hg19.fa -c 0
	Output file:
		
		hg19.snp.indel.invertion.fa
		
(3) Generate simulated RRBS with reads

		python RRBSsim.py -f hg19.snp.indel.invertion.fa --CG_level 0.6 -R --cut_site C-CGG
		
	Output file (1):
	
		rrbssim.1.fq, rrbssim.2.fq 
	file format (1):
		
		@HWUSI-EAS100R:6:73:3307:22982#0/1
		CGGGAGTTCGTAGAGGCGGCGGTTCGGGGAGAAATTTTAGGTACGGTTGAAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCC
		+
		B?@DA8DFHDCGDHGEIIBGDH?HH1FEFIIIB?FDICJJHGI;GJJH@GHFAGIJGFHBD>I>:D>A7ADA#7@EDCBD29D#D=DDDC4C;CC>#A:#
		@HWUSI-EAS100R:6:73:47639:49782#0/1
		CGGGAGTTCGTAGAGGCGGCGGTTCGGGGAGAAATTTTAGGTACGGTTGAAGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCC
		+
		@B@FFADFFHFH@HCFH)H)JBGJCDJJJIJIEDBD#HIFHBJFIHIJJHFDH>JBIAIHIDH?##CD3BF=DC#:>?ACD##<>C@D#BD4<C9##?D:


	Output file (2):
	
		rrbssim.Crick.sam, rrbssim.Crick.sam
		
	Output file (3):

		rrbssim.ref
		
	File format (3):
	
		chr1      1       G       G               0.002   0
		chr1      2       A       A               1       0
		chr1      3       T       T               1       0
		chr1      4       C       C       CHH     0.002   0
		chr1      5       C       C       CHG     0.002   0
		chr1      6       C       C       CG      0.002   0
		chr1      7       G       G       CG      0.805144911452  0
		chr1      8       C       C       CG      0.953731797262  0
		

	Format descriptions(3):
	
		(1) chromosome 
		(2) position 
		(3) base of origin reference genome
		(4) base of reference genome with variation
		(5) context (CG/CHG/CHH)
		(6) methylation level
		(7) mutation rate
			
5.update & support
======

please refer to https://github.com/xwBio/RRBSsim or email to xwsun@zju.edu.cn







