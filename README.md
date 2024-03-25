<br />
<!-- PROJECT LOGO -->
<br />

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
  <li><a href="#description">Description</a></li>
    <li>
      <a href="#built-with">Built With</a></li>
    </li>
    <li>
      <a href="#contact">Contact</a></li>
    </li>
  </ol>
</details>

## Description

This project is my static web resume. I built it by heavily customized template using css, jQuery, Bootstrap. It is a paralax website using a collapsable menu and anchor resume sections.

## How it works

It is hosted on AWS Cloudfront and an S3 bucket in a private ACL to prevent public access. The view counter is a Lambda function that retrieves value from AWS DynamoDB table

Provising the above resources is done using Terraform and secrets are stored in Github to prevent exposing sensitive information. Ive also added CI/CD github actions to automatically update S3 content on github project push and reflect the change.

### Built With

![Terraform][terraform-shield]

![AWS][aws-shield]

![Github Actions][github-shield]

![Bootstrap][bootstrap-shield]

![JQuery][JQuery-shield]

<!-- CONTACT -->

## Contact

[![LinkedIn][linkedin-shield]][linkedin-url]

[![Email][email-shield]][email-address]

[![Resume][web-shield]](https://d38sqjbcrjmc70.cloudfront.net/)

<!-- MARKDOWN SHIELDS -->

[web-shield]: https://img.shields.io/badge/Resume-darkred?style=for-the-badge&logo=read.cv&logoColor=white
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=blue
[outlook-shield]: https://img.shields.io/badge/Microsoft_Outlook-0078D4?style=for-the-badge&logo=microsoft-outlook&logoColor=white
[terraform-shield]: https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white
[Bootstrap-shield]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[JQuery-shield]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[email-shield]: https://img.shields.io/badge/Email-white?style=for-the-badge&logo=maildotru&logoColor=blue
[aws-shield]: https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white
[github-shield]: https://img.shields.io/badge/Github_Actions-lightblue?style=for-the-badge&logo=githubactions&logoColor=grey

<!-- SHIELD URLS -->

[linkedin-url]: https://linkedin.com/in/ragyriad
[email-address]: mailto:ragyyriad@hotmail.com
[resume-link]: https://d38sqjbcrjmc70.cloudfront.net
