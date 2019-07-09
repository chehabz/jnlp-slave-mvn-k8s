# slave-mvn-k8s

A Docker slave which comes pre-shipped with Maven, Docker, Helm, and Kubectl

## Usage

Build the image

```bash
docker build --rm -f "dockerfile" slave-mvn-k8s .
```

Run the image

```bash
docker run -it slave-mvn-k8s <<jenkins vars>> <<command>>
```

if you want to use the image in a pipeline in Kubernetes with Jenkins open the 
Jenkinsfile for an example

## License
[MIT](https://choosealicense.com/licenses/mit/)
