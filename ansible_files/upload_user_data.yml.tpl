---
- name: Install, enable and start Docker
  hosts: provisioner_instance
  become: yes
  remote_user: ec2-user
  tasks:
  - name: Copy SQL provisioner file to provisioner instance.
    copy:
      src: ${source}
      dest: /home/ec2-user/user-data.sql
      owner: ec2-user
      group: ec2-user
      mode: '0644'
  - name: Run SQL provisioner on RDS database.
    shell:
      cmd: PGPASSWORD=${password} psql --host=${host} --port=${port} --username=${username} --dbname=${dbname} -f /home/ec2-user/user-data.sql
