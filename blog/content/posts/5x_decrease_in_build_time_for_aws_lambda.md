---
title: "5x Decrease In Build Time For AWS Lambda"
description: "Trick in increasing build speeds for container based AWS lambdas."
draft: false
date: 2024-03-30T13:49:14-04:00
tags: ["software engineering", "python", "AWS", "containers"]
---

## Background:
At my work we have an API that is setup as an AWS API gateway with Lambda functions attached to the API gateway routes. We package the Lambda functions in containers. This [blog post](https://aaronstuyvenberg.com/posts/containers-on-lambda) goes over the benefits of packaging your Lambdas in containers. Pretty standard setup. Each Lambda function had its own Python file and Dockerfile. At the time of writing there are around ~15 unique Lambda functions. The project file structure was as follows.
```bash
.
├── dockerfiles
│   ├── func1.dockerfile
│   ├── func2.dockerfile
│   └      …
├── src
│   ├── func1.py
│   ├── func2.py
│   └      …
├── samconfig.toml
├── setupfiles.example
└── template.yaml
```

## Problem:
The build and deployment times were getting ridiculous. On our CI/CD the time to build and deploy was getting to over 15 minutes. 15 minutes to deploy is not great especially if you are trying to push a fix fast.

## Solution:
The solution is to build one container with all the required files and override the command in the sam template. I got this idea of packaging and overriding the the command from [fly.io](https://fly.io/) [docs](https://fly.io/docs/) on [Run Multiple Process Groups in an App](https://fly.io/docs/apps/processes/). You can override the command by adding [ImageConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-Lambda-function-imageconfig.html) to your function:
```yaml
ImageConfig:
  Command:
    - “folder/file.lamdba_handler”
```
Although there is a small startup that costs around ~100ms for running the larger container. I think that the small cost in startup is worth the speed in deployment and the cost of maintaining more and more Docker files as the project grows. After making this change the time to deploy on the CI/CD has gone down to 3 mins.
