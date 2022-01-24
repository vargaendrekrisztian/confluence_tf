resource "null_resource" "keygen" {
  provisioner "local-exec" {
    command = "ssh-keygen -b 2048 -f ${var.key_name} -m PEM -N '' -P '' -t rsa"
  }
}

data "local_file" "keyfile" {
  filename   = join("", [var.key_name, ".pub"])
  depends_on = [null_resource.keygen]
}

resource "aws_key_pair" "provisioner_instance_key_pair" {
  key_name   = var.key_name
  public_key = data.local_file.keyfile.content

  tags = {
    Name = join("-", [
      var.tag_prefix,
      var.key_name
    ])
  }

  depends_on = [null_resource.keygen]
}
