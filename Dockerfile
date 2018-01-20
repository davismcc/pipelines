FROM openjdk:8

LABEL authors="davis@ebi.ac.uk" \
    description="Docker image containing all requirements for HipSci fibro pipeline except for R and packages (originally developed at SciLifeLabs and adapted by Vlad Kiselev)"

# Install container-wide requrements gcc, pip, zlib, libssl, make, libncurses, fortran77, g++, R
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        bedtools \
        curl \
        emacs \
        g++ \
        gcc \
        gfortran \
        git \
        libbz2-dev \
        libcurl4-openssl-dev \
        libgsl-dev \
        libgsl2 \
        liblzma-dev \
        libncurses5-dev \
        libpcre3-dev \
        libreadline-dev \
        libssh2-1-dev \
        libssl-dev \
        libxml2-dev \
        libzmq3-dev \
        make \
        pandoc \
        python-dev \
        python3-pip \
        python3-tk \
        software-properties-common \
        wget \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip
RUN curl -fsSL https://bootstrap.pypa.io/get-pip.py -o /opt/get-pip.py && \
    python /opt/get-pip.py && \
    rm /opt/get-pip.py

# Install FastQC
RUN curl -fsSL http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip -o /opt/fastqc_v0.11.5.zip && \
    unzip /opt/fastqc_v0.11.5.zip -d /opt/ && \
    chmod 755 /opt/FastQC/fastqc && \
    ln -s /opt/FastQC/fastqc /usr/local/bin/fastqc && \
    rm /opt/fastqc_v0.11.5.zip

# Install bedops
RUN mkdir /opt/bedops && \
    curl -fsSL https://github.com/bedops/bedops/releases/download/v2.4.20/bedops_linux_x86_64-v2.4.20.v2.tar.bz2 -o /opt/bedops_linux_x86_64-v2.4.20.v2.tar.bz2 && \
    tar xvjf /opt/bedops_linux_x86_64-v2.4.20.v2.tar.bz2 -C /opt/bedops && \
    ln -s /opt/bedops/bin/* /usr/local/bin/ && \
    rm /opt/bedops_linux_x86_64-v2.4.20.v2.tar.bz2

# Install cutadapt
RUN pip install cutadapt

# # Install snakemake
# RUN pip3 install snakemake

# Install TrimGalore
RUN mkdir /opt/TrimGalore && \
    curl -fsSL http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/trim_galore_v0.4.2.zip -o /opt/TrimGalore/trim_galore_v0.4.2.zip && \
    unzip /opt/TrimGalore/trim_galore_v0.4.2.zip -d /opt/TrimGalore && \
    ln -s /opt/TrimGalore/trim_galore /usr/local/bin/trim_galore && \
    rm /opt/TrimGalore/trim_galore_v0.4.2.zip

# Install STAR
RUN git clone https://github.com/alexdobin/STAR.git /opt/STAR && \
    ln -s /opt/STAR/bin/Linux_x86_64/STAR /usr/local/bin/STAR && \
    ln -s /opt/STAR/bin/Linux_x86_64/STARlong /usr/local/bin/STARlong

# Install kallisto
RUN curl -fsSL https://github.com/pachterlab/kallisto/releases/download/v0.43.1/kallisto_linux-v0.43.1.tar.gz -o /opt/kallisto_linux-v0.43.1.tar.gz && \
    tar xvzf /opt/kallisto_linux-v0.43.1.tar.gz -C /opt/ && \
    ln -s /opt/kallisto_linux-v0.43.1/bin/kallisto /usr/local/bin/kallisto && \
    rm /opt/kallisto_linux-v0.43.1.tar.gz

# Install salmon
RUN curl -fsSL https://github.com/COMBINE-lab/salmon/releases/download/v0.8.2/Salmon-0.8.2_linux_x86_64.tar.gz -o /opt/Salmon-0.8.2_linux_x86_64.tar.gz && \
    tar xvzf /opt/Salmon-0.8.2_linux_x86_64.tar.gz -C /opt/ && \
    ln -s /opt/Salmon-0.8.2_linux_x86_64/bin/salmon /usr/local/bin/salmon && \
    rm /opt/Salmon-0.8.2_linux_x86_64.tar.gz

# Install RSeQC
RUN pip install RSeQC

# Install SAMTools - INSTALLED FROM BROAD IMAGE
RUN curl -fsSL https://github.com/samtools/samtools/releases/download/1.6/samtools-1.6.tar.bz2 -o /opt/samtools-1.6.tar.bz2 && \
    tar xvjf /opt/samtools-1.6.tar.bz2 -C /opt/ && \
    cd /opt/samtools-1.6 && \
    make && \
    make install && \
    rm /opt/samtools-1.6.tar.bz2

# Install BCFTools
RUN curl -fsSL https://github.com/samtools/bcftools/releases/download/1.6/bcftools-1.6.tar.bz2 -o /opt/bcftools-1.6.tar.bz2 && \
    tar xvjf /opt/bcftools-1.6.tar.bz2 -C /opt/ && \
    cd /opt/bcftools-1.6 && \
    make && \
    make install && \
    rm /opt/bcftools-1.6.tar.bz2

# Install PreSeq
RUN curl -fsSL http://smithlabresearch.org/downloads/preseq_linux_v2.0.tar.bz2 -o /opt/preseq_linux_v2.0.tar.bz2 && \
    tar xvjf /opt/preseq_linux_v2.0.tar.bz2 -C /opt/ && \
    ln -s /opt/preseq_v2.0/preseq /usr/local/bin/preseq && \
    ln -s /opt/preseq_v2.0/bam2mr /usr/local/bin/bam2mr && \
    rm /opt/preseq_linux_v2.0.tar.bz2 && \
    # Make sure that libgsl.so.0 exists beause PreSeq links to that
    ln -s /usr/lib/x86_64-linux-gnu/libgsl.so /lib/x86_64-linux-gnu/libgsl.so.0

# Install GATK 4 with PicardTools
RUN mkdir /opt/GATK && \
    curl -fsSL https://github.com/broadinstitute/gatk/releases/download/4.0.0.0/gatk-4.0.0.0.zip -o /opt/GATK/gatk-4.0.0.0.zip && \
    unzip /opt/GATK/gatk-4.0.0.0.zip -d /opt/GATK && \
    ln -s /opt/GATK/gatk /usr/local/bin/gatk && \
    ln -s /opt/GATK/gatk-package-4.0.0.0-local.jar /usr/local/bin/gatk-package-4.0.0.0-local.jar && \
    ln -s /opt/GATK/gatk-package-4.0.0.0-spark.jar /usr/local/bin/gatk-package-4.0.0.0-spark.jar && \
    rm /opt/GATK/gatk-4.0.0.0.zip

# Install featureCounts
RUN curl -fsSL http://downloads.sourceforge.net/project/subread/subread-1.6.0/subread-1.6.0-Linux-x86_64.tar.gz -o /opt/subread-1.6.0-Linux-x86_64.tar.gz && \
    tar xvzf /opt/subread-1.6.0-Linux-x86_64.tar.gz -C /opt/ && \
    ln -s /opt/subread-1.6.0-Linux-x86_64/bin/featureCounts /usr/local/bin/featureCounts && \
    rm /opt/subread-1.6.0-Linux-x86_64.tar.gz

# Install StringTie
RUN curl -fsSL http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.3.3.Linux_x86_64.tar.gz -o /opt/stringtie-1.3.3.Linux_x86_64.tar.gz && \
    tar xvzf /opt/stringtie-1.3.3.Linux_x86_64.tar.gz -C /opt/ && \
    ln -s /opt/stringtie-1.3.3.Linux_x86_64/stringtie /usr/local/bin/stringtie && \
    rm /opt/stringtie-1.3.3.Linux_x86_64.tar.gz

# Install MultiQC
RUN pip install git+git://github.com/ewels/MultiQC.git

# Install Hisat2
RUN git clone https://github.com/infphilo/hisat2.git /opt/hisat2 && \
    cd /opt/hisat2/ && \
    make && \
    cp /opt/hisat2/hisat2 /opt/hisat2/hisat2-align-s /opt/hisat2/hisat2-align-l /opt/hisat2/hisat2-build /opt/hisat2/hisat2-build-s /opt/hisat2/hisat2-build-l /opt/hisat2/hisat2-inspect /opt/hisat2/hisat2-inspect-s /opt/hisat2/hisat2-inspect-l /usr/local/bin/ && \
    cp /opt/hisat2/*.py /usr/local/bin

# Create root directories for UPPMAX and c3se hebbe
RUN mkdir /pica /lupus /crex1 /crex2 /proj /scratch /sw /c3se /local /apps

