ARG GITHUB_PAT

FROM rocker/r2u:22.04

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

# Install system packages
RUN set -eux; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                git \
                sudo \
                sqlite3 \
                make \
                libcurl4-openssl-dev \
                libssl-dev \
                libxml2-dev \
                zlib1g-dev \
                libfontconfig1-dev \
                libfreetype6-dev \
                libpng-dev \
                libtiff5-dev \
                libjpeg-dev \
                libharfbuzz-dev \
                libfribidi-dev \
                libpq-dev \
                libgit2-dev \
                gdal-bin libgdal-dev \
                libudunits2-dev \
                pandoc \
                ca-certificates \
                gcc \
                libc6-dev \
                wget \
                && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers \
                && sed -i -e '/^suppressMessages(bspm::enable())$/i options(bspm.sudo=TRUE)' /etc/R/Rprofile.site \
                ; \
        \
        url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"; \
        wget "$url"; \
        chmod +x rustup-init; \
        ./rustup-init -y --no-modify-path --default-toolchain beta --default-host x86_64-unknown-linux-gnu; \
        rm rustup-init; \
        chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
        rustup --version; \
        cargo --version; \
        rustc --version; \
        \
        apt-get remove -y --auto-remove \
            wget \
            ; \
        rm -rf /var/lib/apt/lists/*;
        
# Install R packages
RUN install2.r --error -s --deps TRUE htmltools tibble dplyr purrr rlang glue this.path DBI pool RSQLite remotes promises assertthat log here zeallot dbplyr stringr tidyverse rmarkdown plotly
RUN Rscript -e "install.packages('b64', repos = c('https://extendr.r-universe.dev', getOption('repos')))" 
RUN Rscript -e "install.packages('uwu', repos = c('https://josiahparry.r-universe.dev', getOption('repos')))" 
RUN --mount=type=secret,id=GITHUB_PAT GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT) \
    installGithub.r devOpifex/ambiorix devOpifex/scilis devOpifex/signaculum
RUN --mount=type=secret,id=GITHUB_PAT GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT) \
    installGithub.r jrosell/ambhtmx

# Prepare the user
ENV HOME=/workspace \
	PATH=/workspace/.local/bin:$PATH
WORKDIR /workspace
COPY . .

# Entry
EXPOSE 7860
CMD R -e "print(nchar(Sys.getenv('GITHUB_PAT'))); source('app.R'); "
