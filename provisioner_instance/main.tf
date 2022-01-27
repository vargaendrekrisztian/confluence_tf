resource "aws_instance" "provisioner_instance" {
  ami                         = var.provisioner_ami
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  iam_instance_profile        = var.provisioner_instance_profile_name
  instance_type               = "t2.micro"
  subnet_id                   = var.provisioner_subnet_id
  vpc_security_group_ids      = [var.provisioner_security_group_id]

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "provisioner"
    ])
  }
}

resource "time_sleep" "wait_15s_after_instance_creation" {
  depends_on      = [aws_instance.provisioner_instance]
  create_duration = "15s"
}

resource "null_resource" "ssh_config" {
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_rsa.pub | ssh -oStrictHostKeyChecking=accept-new -i ${var.key_pair_name} ec2-user@${aws_instance.provisioner_instance.public_ip} \"cat - >> ~/.ssh/authorized_keys\""
  }

  depends_on = [time_sleep.wait_15s_after_instance_creation]
}

resource "local_file" "inventory" {
  content = templatefile(
    "${path.root}/ansible_files/inventory.tpl",
    {
      instance_public_ip = aws_instance.provisioner_instance.public_ip
    }
  )
  filename = "${path.root}/ansible_files/inventory"
}

resource "null_resource" "run_playbook" {
  provisioner "local-exec" {
    working_dir = "./ansible_files"
    command     = "ansible-playbook -i inventory provision.yml"
  }

  depends_on = [
    aws_instance.provisioner_instance,
    local_file.inventory,
    null_resource.ssh_config
  ]
}
