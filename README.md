<p align="center" margin="20 0"><a href="https://github.com/convisolabs/electrosphere">
    <img src="https://user-images.githubusercontent.com/66391286/186287468-4ed60c6a-e079-42fb-b683-85928fb0d2f8.png" alt="logo_header" width="65%" style="max-width:100%;"/></a></p>
    
    
<p align="center">
    <a href="/RELEASES" alt="version">
        <img src="https://img.shields.io/badge/version-0.0.1-blue.svg"/></a>
    <a href="/LICENSE" alt="license">
        <img src="https://img.shields.io/badge/license-MIT-blue.svg"/></a>
     </a>
</p>


</p>

## **Table of contents**
### 1. [**About**](#about)
### 2. [**Getting started**](#getting-started)
>#### 2.1.   [**Requirements**](#requirements)
>#### 2.2.  [**Installation**](#installing-electrosphere)
### 3. [**Usage**](#usage)
>#### 3.1. [**CLI Usage**](#cli-usage)
>#### 3.2. [**Options**](#options)
>#### 3.3. [**Demos**](#demos)
### 4. [**Documentation**](#documentation)
### 5. [**Contributing**](#contributing)
### 6. [**License**](#license)
### 7. [**Community**](#community)

<br>
<br>
<br>

# **About**
Electrosphere was built to help developers and security analysts who use the Conviso Platform to manage their vulnerabilities.

The purpose of this microservice is to register, in a simple and easy way, vulnerabilities found by nuclei on Conviso Platform. This application was Developed by rd-team.

### **Conviso Platform**
[Conviso Platform](https://blog.convisoappsec.com/en/appsec-flow-a-complete-devsecops-platform/) is a Software as a Service (SaaS) platform created by [Conviso](https://www.convisoappsec.com/) that supports the entire security cycle in the software development life cycle. It was created based on the Software Assurance Maturity Model (SAMM) - a project in the portfolio of the Open Web Application Security Project (OWASP) that defines a series of practices with the objective of improving software security. 


# **Getting started**

## **Requirements**

- Docker
You need Docker installed in your machine in order to run Electrosphere.

## **Installing Electrosphere**

### Clone repository
	
```bash
  git clone https://github.com/convisolabs/electrosphere.git 
  cd electrosphere
```

### Build docker image
	
```bash
  docker build -t electrosphere .
```

## **Usage**

### **CLI Usage**
Electrosphere uses the nuclei output in JSONL(ines) format to register vulnerabilities in the Conviso Platform.

To generate the output correctly use the following command:

```bash
  nuclei -u $HOST -t $TEMPLATE -json -irr -o nuclei_output.json
```

Important: `Do not change or format the nuclei output`

### **Options**

```bash
  docker run --rm -v $(pwd):/workspace -v /tmp:/tmp electrosphere  -h
```
![Alt text](assets/readme/options.png "Options")

### **Demos**

Demo running in homologation environment
	
```bash
  docker run --rm -v $(pwd):/workspace -v /tmp:/tmp electrosphere  -k $X_API_KEY -p $PROJECT_ID -i nuclei_output.json -e hml
```
![Alt text](assets/readme/output.png "Options")

---

## **Documentation**

You can find Conviso Platform's documentation on our [**website**](https://docs.convisoappsec.com/).


## **Contributing**

Your contributions and suggestions are welcome!

See here the [contribution guidelines](/.github/CONTRIBUTING.md) to learn about our development process, how to suggest bugfixes and improvements. For security issues, see here the [security policy](/SECURITY.md).

## **License**

This work is licensed under [MIT License.](/LICENSE)

## **Community**

You can connect with us and other contributors through the [DevSecOps Community on Slack](https://join.slack.com/t/devsecopsglobal/shared_invite/zt-18pirxrbb-0JBmsu5tiFTqg96IJ8Lf5Q).

Thanks everyone! 🚀