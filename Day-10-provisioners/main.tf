provider "aws" {
  
}
resource "aws_key_pair" "nam" {
    key_name = "task"
    public_key = file("~/.ssh/id_rsa.pub")
  
}
resource "aws_instance" "nae" {
    ami = "nsnnsad"
   instance_type = "t2.mirco"
   key_name = aws_key_pair.nam.id

      connection {
    type        = "ssh"
    user        = "ubuntu"                          # ✅ Correct for Ubuntu AMIs
    private_key = file("~/.ssh/id_ed25519")             # Path to private key
    host        = self.public_ip
      }

    # local execute process
    provisioner "local-exec" {
        command = "touch file200"
      
    }

    # file provisioner to copy a file from local to the remote Ec2 instance
    provisioner "file" {
        source = "file200"      # Replace with the path to your local file
        destination = "/home/ubuntu/file200"  # Replace with the path on the remote instace
      
    }

    # Remote execute process
    provisioner "remote-exec" {
        inline = [ 
            "touch file200",
            "echo hello from aws >> file200",
         ]
      
    }


   

  
}