# SkateSpot Recommender  
### When AI decides where you should skate for the best session   (MLOps & AWS Cloud like) 
---

## Overview  
This project is a **machine learning pipeline** and **mobile app** that helps skateboarders in Montréal find the best skatepark based on:  
- Ratings and reviews of skateparks  
- Distance and travel time  
- Weekday trends  
- Estimated crowd level  

It reproduces a **mini MLOps workflow**, similar to **AWS SageMaker + S3**, but fully local using **Docker containers**.



---

## Tech Stack  

| Layer | Technology | Description |
|:------|:------------|:------------|
| Cloud Simulation | Docker Compose | Orchestrates multiple containers |
| Storage | MinIO | S3-compatible object storage for datasets |
| Computation | Jupyter Notebook | Local equivalent to AWS SageMaker |
| Frontend | Qt C++ | Mobile app displaying skateparks, distances, and recommendations |


## Docker Configuration:

Docker Host
Jupyter Notebook (8888) <--> MinIO Server (9000/9001)
- Data analysis & ML - S3 storage for datasets
- SageMaker equivalent - Accessible via GUI


## Instructions


- **Jupyter Notebook** simulates an AWS SageMaker instance for data exploration and model training.  
- **MinIO** acts as an S3 bucket to store your datasets and models.  
- Both are connected through Docker Compose for easy setup.

---

## Setup Instructions  

### Requirements
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) must be installed and running.

### Start the containers: 
`docker-compose up --build`


### Once everything is running:

Jupyter Notebook: http://127.0.0.1:8888

MinIO Console: http://127.0.0.1:9001

Login: admin

Password: admin123

### Stop the containers
`docker-compose down`



## Architecture


## Feedback

If you have any feedback, please reach out to us on Linkedin: 
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](
https://www.linkedin.com/in/s%C3%A9bastien-doyez-042604252/)

