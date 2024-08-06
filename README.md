---
title: ambhtmx.tonejs
emoji: 🏃
colorFrom: pink
colorTo: pink
sdk: docker
pinned: false
---

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

<!-- badges: end -->

**THIS IS A WORK IN PROGRESS, DO NOT USE**

See the demo here: 

* Direct URL to the deployed app: https://jrosell-ambhtmx-tonejs.hf.space/
* Space URL: https://huggingface.co/spaces/jrosell/ambhtmx.tonejs

Or test it locally:

```
git clone git@github.com:jrosell/ambhtmx.tonejs.git
cd ambhtmx.tonejs
echo GITHUB_PAT="Your token from github" >> .Renviron
bash docker_run.sh
```

If you want, you can remove docker containers and images:
```
bash docker_rm.sh
```

## How to use Github and Hugging Face Spaces for my project

When you pushing a repository to a Hugging Face Spaces with the option to deploy Dockerfile and include a Dockerfile, Hugging Face will start building and running your app in the Space.

Customize this example, to enable Hugging Face Spaces as additional remote:

```
git init
git add -A
git status
git commit -m "My changes"
git remote add origin git@github.com:jrosell/ambhtmx.tonejs.git
git remote add gh git@github.com:jrosell/ambhtmx.tonejs.git
git remote add hf git@hf.co:spaces/jrosell/ambhtmx.tonejs
git remote -v
```

Then, to depoly to Hugging Face Spaces run:

```
bash deploy_hf.sh
```

## Troubleshooting

Kown issues:

* Only updates when refreshing the whole page. WIP should rerender on innerHTML replace.

Check the [known issues](https://github.com/jrosell/ambhtmx/issues), and if you have another issue? Please, [let me know](https://github.com/jrosell/ambhtmx/issues).

