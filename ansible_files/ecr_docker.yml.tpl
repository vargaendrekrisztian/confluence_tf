---
- name: Install, enable and start Docker
  hosts: provisioner_instance
  become: yes
  remote_user: ec2-user
  tasks:
  - name: Pull Confluence Docker image
    shell:
      cmd: sudo docker pull ${original_image}
  - name: Tag Confluence Docker image
    shell:
      cmd: sudo docker tag ${original_image} ${ecr_image_name}
  - name: Login to ECR via Docker and AWS CLI, upload image
    environment:
      AWS_ACCESS_KEY_ID: ${access_key_id}
      AWS_SECRET_ACCESS_KEY: ${secret_access_key}
      AWS_DEFAULT_REGION: ${region}
    shell:
      cmd: aws ecr get-login-password | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${region}.amazonaws.com; sudo docker push ${ecr_image_name}
